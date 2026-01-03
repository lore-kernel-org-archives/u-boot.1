Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D4EFC6165
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 00:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09AEA842C4;
	Sat,  3 Jan 2026 01:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KIsXSBhg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bUAz0opF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9950C842F4; Sat,  3 Jan 2026 01:23:37 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C97C9842C3
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 01:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4djh9t4gLTz9v66;
 Sat,  3 Jan 2026 01:23:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ga6WkqKTLO2oUanzMm7Tf49nndW249mAeyX6FN/gn6w=;
 b=KIsXSBhgNsqh3H1IFSDbJ4pHCweVNNA4a+ijMsZyr7+3jU8nTp561rYEKaCXulL11aUg6G
 Vn+t4uzHi0yVPJx5NTfuJ+RrfTMByF9y7tJPlIqQR5h7MATRnI9yxGqYvD4XEznHWYplSk
 Zl2ZzHPu4Dhmgqk08tqAYJpXSnWVKFZEvRrwZvrj4PdmWHqNGz3r/RqRlflS9ywhc94csa
 C3qUXUxhHkvp5xB9Ftt+I9+8FjNgx+lUGDgYJLna6mVVnakjL73/GKM4Ran8j5XUQoT/X2
 ipkPTSiBl20dYPK22yVEhI37mUdz8qWR6UGh+jst3C4mNvzKksVShfBKPwPAeg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=bUAz0opF;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ga6WkqKTLO2oUanzMm7Tf49nndW249mAeyX6FN/gn6w=;
 b=bUAz0opFxc58ErhWfPqMPxt8uLfiG2jw7fH2BlJB0LFxQ0NIcEtogS9+ZDwls/wg+62mUQ
 IqKSrwH6RrbySzlSHYia1bW+2cQoK8vDj3DqRWOh8sAbgp4Aj9VhcCKevJW1TiLwB2Ajec
 oz+6tTlviqtI3d4hdK9U6mrRGhUVts6wYw9wy8NE3gyFKKcrsMgI3EvRZ/N+/L9obdo2+0
 ysayfSC6iXrn3+z9FedLnbHdFoHE2Dsv8TfIWIr9qF5UWfnZItvFRQgj6vq96HFceyHiTp
 Qh+PWMzEifo7STQd7qx22R+V4UnA5oGCTz6J54Q2Rn7IpcdycS7u84AFSvs5GQ==
To: u-boot@lists.denx.de
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/5] scsi: ufs: renesas: Add reusable functions
Date: Sat,  3 Jan 2026 01:22:31 +0100
Message-ID: <20260103002254.183357-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
References: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: woogufbgqd5dypbd3be978sa6hgq1p6a
X-MBO-RS-ID: bc3df684e82d97e338f
X-Rspamd-Queue-Id: 4djh9t4gLTz9v66
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

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since some settings can be reused on other UFS controller (R-Car S4-8
ES1.2), add reusable functions.

Ported from Linux kernel commit
44ca16f4970e ("scsi: ufs: renesas: Add reusable functions")

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/446d67b751a96645799de3aeefec539735aa78c8.1741179611.git.geert+renesas@glider.be
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot@lists.denx.de
---
 drivers/ufs/ufs-renesas.c | 71 +++++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
index b2edc3b5497..5652309911e 100644
--- a/drivers/ufs/ufs-renesas.c
+++ b/drivers/ufs/ufs-renesas.c
@@ -130,21 +130,8 @@ static void ufs_renesas_indirect_poll(struct ufs_hba *hba, u32 gpio, u32 addr,
 	ufs_renesas_write(hba, 0xf0, 0);
 }
 
-static void ufs_renesas_write_phy_10ad_10af(struct ufs_hba *hba,
-					    u32 data_10ad, u32 data_10af)
+static void ufs_renesas_init_step1_to_3(struct ufs_hba *hba)
 {
-	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
-	ufs_renesas_write_phy(hba, 0x10ad, data_10ad);
-	ufs_renesas_write_phy(hba, 0x10af, data_10af);
-	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
-	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
-}
-
-static void ufs_renesas_pre_init(struct ufs_hba *hba)
-{
-	u32 timer_val;
-
-	/* This setting is for SERIES B */
 	ufs_renesas_write(hba, 0xc0, 0x49425308);
 	ufs_renesas_write_d0_d4(hba, 0x00000104, 0x00000002);
 	udelay(1);
@@ -158,7 +145,10 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
 
 	ufs_renesas_write(hba, 0xc0, 0x49425308);
 	ufs_renesas_write(hba, 0xc0, 0x41584901);
+}
 
+static void ufs_renesas_init_step4_to_6(struct ufs_hba *hba)
+{
 	ufs_renesas_write_d0_d4(hba, 0x0000080c, 0x00000100);
 	ufs_renesas_write_d0_d4(hba, 0x00000804, 0x00000000);
 	ufs_renesas_write(hba, 0xd0, 0x0000080c);
@@ -168,6 +158,11 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
 
 	ufs_renesas_write(hba, 0xd0, 0x00000804);
 	ufs_renesas_poll(hba, 0xd4, BIT(8) | BIT(6) | BIT(0), BIT(8) | BIT(6) | BIT(0));
+}
+
+static u32 ufs_renesas_init_disable_timer(struct ufs_hba *hba)
+{
+	u32 timer_val;
 
 	ufs_renesas_write(hba, 0xd0, 0x00000d00);
 	timer_val = ufs_renesas_read(hba, 0xd4) & 0x0000ffff;
@@ -179,6 +174,45 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
 	ufs_renesas_write(hba, 0xd0, 0x00000d2c);
 	ufs_renesas_poll(hba, 0xd4, BIT(0), BIT(0));
 
+	return timer_val;
+}
+
+static void ufs_renesas_init_enable_timer(struct ufs_hba *hba, u32 timer_val)
+{
+	ufs_renesas_write(hba, 0xf0, 0);
+	ufs_renesas_write(hba, 0xd0, 0x00000d00);
+	ufs_renesas_write(hba, 0xd4, timer_val);
+}
+
+static void ufs_renesas_write_phy_10ad_10af(struct ufs_hba *hba,
+					    u32 data_10ad, u32 data_10af)
+{
+	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
+	ufs_renesas_write_phy(hba, 0x10ad, data_10ad);
+	ufs_renesas_write_phy(hba, 0x10af, data_10af);
+	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
+	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
+}
+
+static void ufs_renesas_init_compensation_and_slicers(struct ufs_hba *hba)
+{
+	ufs_renesas_write_phy_10ad_10af(hba, 0x0000, 0x0001);
+	ufs_renesas_write_phy_10ad_10af(hba, 0x0000, 0x0002);
+	ufs_renesas_write_phy_10ad_10af(hba, 0x0080, 0x0000);
+	ufs_renesas_write_phy_10ad_10af(hba, 0x0080, 0x001a);
+}
+
+static void ufs_renesas_pre_init(struct ufs_hba *hba)
+{
+	u32 timer_val;
+
+	/* This setting is for SERIES B */
+	ufs_renesas_init_step1_to_3(hba);
+
+	ufs_renesas_init_step4_to_6(hba);
+
+	timer_val = ufs_renesas_init_disable_timer(hba);
+
 	/* phy setup */
 	ufs_renesas_indirect_write(hba, 1, 0x01, 0x001f);
 	ufs_renesas_indirect_write(hba, 7, 0x5d, 0x0014);
@@ -214,10 +248,7 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
 	ufs_renesas_write_phy(hba, 0x4000, 0x0000);
 	ufs_renesas_write_phy(hba, 0x4001, 0x0000);
 
-	ufs_renesas_write_phy_10ad_10af(hba, 0x0000, 0x0001);
-	ufs_renesas_write_phy_10ad_10af(hba, 0x0000, 0x0002);
-	ufs_renesas_write_phy_10ad_10af(hba, 0x0080, 0x0000);
-	ufs_renesas_write_phy_10ad_10af(hba, 0x0080, 0x001a);
+	ufs_renesas_init_compensation_and_slicers(hba);
 
 	ufs_renesas_indirect_write(hba, 7, 0x70, 0x0016);
 	ufs_renesas_indirect_write(hba, 7, 0x71, 0x0016);
@@ -244,9 +275,7 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
 	ufs_renesas_indirect_poll(hba, 7, 0x41, 0, BIT(7));
 	/* end of phy setup */
 
-	ufs_renesas_write(hba, 0xf0, 0);
-	ufs_renesas_write(hba, 0xd0, 0x00000d00);
-	ufs_renesas_write(hba, 0xd4, timer_val);
+	ufs_renesas_init_enable_timer(hba, timer_val);
 }
 
 static int ufs_renesas_hce_enable_notify(struct ufs_hba *hba,
-- 
2.51.0

