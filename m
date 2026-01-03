Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B45CFC6165
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 00:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3579842F2;
	Sat,  3 Jan 2026 01:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DG60NWPF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BKyn1+sJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 939C6842D2; Sat,  3 Jan 2026 01:23:31 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DC1383CF2
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 01:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4djh9s15xqz9t9B;
 Sat,  3 Jan 2026 01:23:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uE8zdbMp/PXbj3ZwCt+uTgjLJu3Hh5x4sl38aqVgMp4=;
 b=DG60NWPFKc5PjGHaYXOnQavXX16XSI3C9jRIraK5OG6f6dOXASMiZBgUHnL1exeNeR6Zbh
 ZW1Btey6/svDUmLwngrKZXjgTwZIoX/xZjJQwnL9IDdzhfEEFnQetuBP4NW6BDhQwPdd+k
 HI1FvpmfHepvVpRM3TEAUHsO3jCyKrWMC+Z4kwjKBk3qjgXoWsoxf+ZqZ1Ft76jxVtj61D
 jlMzlQkQ/bjdENK3ouJUY3z9dWPIuwqPfzhM8fF01tu5AKcgvtt3ytsWNGL6LKWNpMAHsK
 erLA7+iDs91+nGTFQ+9FDrttenUP3RHlpFHMWOw6WupmHoq5kMZvGP2jiSjmtw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=BKyn1+sJ;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uE8zdbMp/PXbj3ZwCt+uTgjLJu3Hh5x4sl38aqVgMp4=;
 b=BKyn1+sJNHJAuwUwWjAhRKpIgP6AU27Qg+KdF1iOs4aBR9ZEaCua8PaPzlB/SsQzZO3/vk
 qEITHanVfQhuzqdi6roP38DiPnkHM/llYu0cR3OULO6dhFjFkPfmenz++N2sHuCQ2liNoI
 gdLDREtU9ftEZCt/rWjoG2cv+vfk85P+DiA2ooobtItBnD9wx7Pgs9SG/l40zuCE/2BuSd
 4CKDMMZJ2xe/Ptp/TYY8tQFaV7SPk75W7UvajEpvgc/ZhE78XajlBl9fDw9CH8OOvFoLD2
 Me18+rGgZoiwUnpMC67T9IaMA0LkmaL5MzBUulU7/prf3isJSbHM85h5yookPQ==
To: u-boot@lists.denx.de
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] scsi: ufs: renesas: Refactor 0x10ad/0x10af PHY settings
Date: Sat,  3 Jan 2026 01:22:30 +0100
Message-ID: <20260103002254.183357-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
References: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 498fd077be4edbc8518
X-MBO-RS-META: cht5ouwb6wiomu7k3mjata637hiaptpm
X-Rspamd-Queue-Id: 4djh9s15xqz9t9B
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

Extract specific PHY setting of the 0x10a[df] registers into a new
function.

Ported from Linux kernel commit
cca2b807c227 ("scsi: ufs: renesas: Refactor 0x10ad/0x10af PHY settings")

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/110eafd1ee24f9db0285a5e2bca224e35962268a.1741179611.git.geert+renesas@glider.be
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
 drivers/ufs/ufs-renesas.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
index c8fbe61901b..b2edc3b5497 100644
--- a/drivers/ufs/ufs-renesas.c
+++ b/drivers/ufs/ufs-renesas.c
@@ -130,6 +130,16 @@ static void ufs_renesas_indirect_poll(struct ufs_hba *hba, u32 gpio, u32 addr,
 	ufs_renesas_write(hba, 0xf0, 0);
 }
 
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
 static void ufs_renesas_pre_init(struct ufs_hba *hba)
 {
 	u32 timer_val;
@@ -204,29 +214,10 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
 	ufs_renesas_write_phy(hba, 0x4000, 0x0000);
 	ufs_renesas_write_phy(hba, 0x4001, 0x0000);
 
-	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
-	ufs_renesas_write_phy(hba, 0x10ad, 0x0000);
-	ufs_renesas_write_phy(hba, 0x10af, 0x0001);
-	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
-	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
-
-	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
-	ufs_renesas_write_phy(hba, 0x10ad, 0x0000);
-	ufs_renesas_write_phy(hba, 0x10af, 0x0002);
-	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
-	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
-
-	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
-	ufs_renesas_write_phy(hba, 0x10ad, 0x0080);
-	ufs_renesas_write_phy(hba, 0x10af, 0x0000);
-	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
-	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
-
-	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
-	ufs_renesas_write_phy(hba, 0x10ad, 0x0080);
-	ufs_renesas_write_phy(hba, 0x10af, 0x001a);
-	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
-	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
+	ufs_renesas_write_phy_10ad_10af(hba, 0x0000, 0x0001);
+	ufs_renesas_write_phy_10ad_10af(hba, 0x0000, 0x0002);
+	ufs_renesas_write_phy_10ad_10af(hba, 0x0080, 0x0000);
+	ufs_renesas_write_phy_10ad_10af(hba, 0x0080, 0x001a);
 
 	ufs_renesas_indirect_write(hba, 7, 0x70, 0x0016);
 	ufs_renesas_indirect_write(hba, 7, 0x71, 0x0016);
-- 
2.51.0

