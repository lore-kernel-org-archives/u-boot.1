Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0664ACAC587
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 14:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B4C383071;
	Sun, 14 Sep 2025 16:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="qmf7WNM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0534B83211; Sun, 14 Sep 2025 16:44:56 +0200 (CEST)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0107082AE1
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 16:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding; 
 bh=iBA+IbG/V20LMDO57PhRWTNs+si/3jCv8vzS9k7alOs=;
 b=qmf7WNM9XnzfXKxGncr5+WllrRh07DZhuGb4QCWzKrnnfsOyCFVrKim2wWKtDZnCfe2moubyG5pT1CSFUrPLi4Lgsewoa4FgriFZNN4CHjmvvfnKOQl518T5EKVPU450kklGE8knHQ83aJpZboEFetLE082LMZFjYNoa/3M9XMM=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at
 [212.241.70.231]) by mail.netcube.li with ESMTPA
 ; Sun, 14 Sep 2025 16:44:53 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Tom Rini <trini@konsulko.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/1] sunxi: extend R528/T113-s3/D1(s) DRAM initialisation
Date: Sun, 14 Sep 2025 16:44:11 +0200
Message-Id: <20250914144411.157826-1-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Extend the DRAM initialisation code to add support for the T113-S4 aka
T113M4020DC0 by checking the SoC's CHIPID.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 drivers/ram/sunxi/dram_sun20i_d1.c | 13 ++++++++++++-
 drivers/ram/sunxi/dram_sun20i_d1.h |  7 +++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dram_sun20i_d1.c
index a1794032f3b..01d19d5feaa 100644
--- a/drivers/ram/sunxi/dram_sun20i_d1.c
+++ b/drivers/ram/sunxi/dram_sun20i_d1.c
@@ -54,6 +54,11 @@ static void sid_read_ldoB_cal(const dram_para_t *para)
 	clrsetbits_le32(0x3000150, 0xff00, reg << 8);
 }
 
+static u32 sid_read_soc_chipid(void)
+{
+	return readl(SUNXI_SID_BASE + 0x00) & 0xffff;
+}
+
 static void dram_voltage_set(const dram_para_t *para)
 {
 	int vol;
@@ -663,6 +668,7 @@ static void mctl_phy_ac_remapping(const dram_para_t *para,
 
 	fuse = (readl(SUNXI_SID_BASE + 0x28) & 0xf00) >> 8;
 	debug("DDR efuse: 0x%x\n", fuse);
+	debug("SoC Chip ID: 0x%08x\n", sid_read_soc_chipid());
 
 	if (para->dram_type == SUNXI_DRAM_TYPE_DDR2) {
 		if (fuse == 15)
@@ -675,7 +681,12 @@ static void mctl_phy_ac_remapping(const dram_para_t *para,
 			switch (fuse) {
 			case 8: cfg = ac_remapping_tables[2]; break;
 			case 9: cfg = ac_remapping_tables[3]; break;
-			case 10: cfg = ac_remapping_tables[5]; break;
+			case 10:
+				if (sid_read_soc_chipid() == SUNXI_CHIPID_T113M4020DC0)
+					cfg = ac_remapping_tables[0];
+				else
+					cfg = ac_remapping_tables[5];
+				break;
 			case 11: cfg = ac_remapping_tables[4]; break;
 			default:
 			case 12: cfg = ac_remapping_tables[1]; break;
diff --git a/drivers/ram/sunxi/dram_sun20i_d1.h b/drivers/ram/sunxi/dram_sun20i_d1.h
index 91383f6cf10..7bd8f67a77a 100644
--- a/drivers/ram/sunxi/dram_sun20i_d1.h
+++ b/drivers/ram/sunxi/dram_sun20i_d1.h
@@ -19,6 +19,13 @@ enum sunxi_dram_type {
 	SUNXI_DRAM_TYPE_LPDDR3 = 7,
 };
 
+enum sunxi_soc_chipid {
+	SUNXI_CHIPID_F133A = 0x5C00,
+	SUNXI_CHIPID_D1S = 0x5E00,
+	SUNXI_CHIPID_T113S3 = 0x6000,
+	SUNXI_CHIPID_T113M4020DC0 = 0x7200,
+};
+
 /*
  * This structure contains a mixture of fixed configuration settings,
  * variables that are used at runtime to communicate settings between
-- 
2.39.5


