Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F51CCD193
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 11:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 704FC832AD;
	Sun, 26 Oct 2025 12:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="AAl0DVSY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6749A83623; Sun, 26 Oct 2025 12:42:11 +0100 (CET)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27F2582E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 12:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding; 
 bh=KR5sO/y19iwQ/gvT2+P02NvTLW181CjH/ppfZrnUA10=;
 b=AAl0DVSYqY6DSZPyjDG6YKVRzy/O5Gg+an2OQqrbera27iWK8jeEJOJUvZGdzX/HfAZ7g/NDLoUGTYAUiD/cnImhSYGc75jx2pA5ARZhC4k812een8O4gWks2WNHnYZMt2PEYFX3pZFYBUVZ3WQu1dWdRRSUTv4jnep5bwhF2EE=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at
 [212.241.70.231]) by mail.netcube.li with ESMTPA
 ; Sun, 26 Oct 2025 12:41:55 +0100
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Tom Rini <trini@konsulko.com>
Cc: linux-sunxi@lists.linux.dev, Lukas Schmid <lukas.schmid@netcube.li>,
 John Watts <contact@jookia.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v3] sunxi: extend R528/T113-s3/D1(s) DRAM initialisation
Date: Sun, 26 Oct 2025 12:41:17 +0100
Message-ID: <20251026114118.3922714-1-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.47.3
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

The T113-s4 SoC is using the same die as the T113-s3, but comes with
256MiB of co-packaged DRAM. Besides the doubled size, the DRAM chip
seems to be connected slightly differently, which requires to use a
different pin remapping.

Extend the DRAM initialisation code to add support for the T113-S4 aka
T113M4020DC0 by checking the SoC's CHIPID, which is stored in the first
word of the SID efuses.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
Tested-by: John Watts <contact@jookia.org>
Reviewed-by: John Watts <contact@jookia.org>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes in v3:
  - Move the Chip-ID list link to a comment in the header file
  - Use andre's suggested commit message
  - Drop out of remapping early for T113M4020DC0 instead of doing it in the
    switch-case

Changes in v2:
  - Use uint32_t instead of u32 for sid_read_soc_chipid return type
  - Add descriptive comment about source of Chip-ID list and register

 drivers/ram/sunxi/dram_sun20i_d1.c | 10 ++++++++++
 drivers/ram/sunxi/dram_sun20i_d1.h | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dram_sun20i_d1.c
index a1794032f3b..d851deac7a5 100644
--- a/drivers/ram/sunxi/dram_sun20i_d1.c
+++ b/drivers/ram/sunxi/dram_sun20i_d1.c
@@ -54,6 +54,11 @@ static void sid_read_ldoB_cal(const dram_para_t *para)
 	clrsetbits_le32(0x3000150, 0xff00, reg << 8);
 }
 
+static uint32_t sid_read_soc_chipid(void)
+{
+	return readl(SUNXI_SID_BASE + 0x00) & 0xffff;
+}
+
 static void dram_voltage_set(const dram_para_t *para)
 {
 	int vol;
@@ -663,6 +668,11 @@ static void mctl_phy_ac_remapping(const dram_para_t *para,
 
 	fuse = (readl(SUNXI_SID_BASE + 0x28) & 0xf00) >> 8;
 	debug("DDR efuse: 0x%x\n", fuse);
+	debug("SoC Chip ID: 0x%08x\n", sid_read_soc_chipid());
+
+	if (sid_read_soc_chipid() == SUNXI_CHIPID_T113M4020DC0) {
+		return;
+	}
 
 	if (para->dram_type == SUNXI_DRAM_TYPE_DDR2) {
 		if (fuse == 15)
diff --git a/drivers/ram/sunxi/dram_sun20i_d1.h b/drivers/ram/sunxi/dram_sun20i_d1.h
index 91383f6cf10..83ae7eb36cd 100644
--- a/drivers/ram/sunxi/dram_sun20i_d1.h
+++ b/drivers/ram/sunxi/dram_sun20i_d1.h
@@ -19,6 +19,17 @@ enum sunxi_dram_type {
 	SUNXI_DRAM_TYPE_LPDDR3 = 7,
 };
 
+/*
+ * Chip-IDs taken from
+ * https://github.com/ua1arn/hftrx/blob/25d8cb9e4cfe1d7d0e4a2f641025c88a9ec5e758/inc/clocks.h#L250
+ */
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
2.47.3


