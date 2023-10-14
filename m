Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F081CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 06:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA85686DF5;
	Sun, 15 Oct 2023 08:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MNv4jSf1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tBRuk73B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 872258657B; Sun, 15 Oct 2023 08:17:23 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73AF08692B
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S7HJH6SjLz9sXg;
 Sat, 14 Oct 2023 23:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697320575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YIRkM/s/qryOqVJQh3lQa7P6aQ3Wfrv34fLt4etORFE=;
 b=MNv4jSf1zu8tD8ptoNsxM6b/26QgxvSd0Msqwkhz7wFmvd+CEOPZ8HVcL0Yc3X3Z/IkzX4
 KITeYg0pEmna5KCgMQG0MuivrYzOxNN+XdrvTyd4XbDtcOZclL4gBT+U4vBZJwuVBrvkbj
 sn8Aicn7tl2tjTVb84519iI8pUVOCgBC6YCJpcxQPQCSTQHiprhf5FptUNaKER0TNh/86F
 kL70mJVG2Ri7AAxVx/2IanACIHUBelTA6q/m4LADlNjPJwhpgiBiz6UcQrh1sSZQJUnCqk
 UGFbo+ikBSDhca7Hh3RW8P0z/WqOaQBywH3auCAIGCD3JbxHr57Chq428Ed2uw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697320574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YIRkM/s/qryOqVJQh3lQa7P6aQ3Wfrv34fLt4etORFE=;
 b=tBRuk73Bg89uYd/1jJD702iyVHxked5Xte/6jAzpBvP2jMhSVVrpwp+bvDwDoBzTrB+TNE
 h4Eb40VtXZbO3s1BuE5h68SyfOm0y8boWGU8agOriZdauTFRX5rRp6z4WYS3tyXhHueszG
 AvqRqnTGUDxDJ3glXT/88yGHjyDY/MDUzLsZEhhTcr4/WSy0kB7yVQPdW0ebP3JaurHkRD
 zrxjUsz3xNakIfNz96quW0xH6asZSmCneCCVaBShNO/lf2rez6/J3L/4AnX6gEhvy5CyJD
 mNrRU09Psyax3EivAel+YsUJLbsxh/VbpghWtdmkKmpCOsrDbJx4PO6vWs3yFQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mmc: tmio: Always check for errors after receiving an IRQ
Date: Sat, 14 Oct 2023 23:56:03 +0200
Message-ID: <20231014215606.130343-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 22bd902b0cf4a0238d0
X-MBO-RS-META: zd49nuwepwpmgzbm1edm9ypcpyfihhpj
X-Rspamd-Queue-Id: 4S7HJH6SjLz9sXg
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

Unconditionally check for errors even after successful reception
of IRQ flag, since the hardware may set both an IRQ completion
flag and an error flag at the same time.

This mode of failure happens in case of an error during transfer,
in which case the hardware may set the expected IRQ completion
flag as well as error flags. The later is currently not checked
by the driver and such an error is not detected. Improve the
error detection.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/tmio-common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/tmio-common.c b/drivers/mmc/tmio-common.c
index d1e26815996..83eaf361f0c 100644
--- a/drivers/mmc/tmio-common.c
+++ b/drivers/mmc/tmio-common.c
@@ -122,7 +122,10 @@ static int tmio_sd_wait_for_irq(struct udevice *dev, struct mmc_cmd *cmd,
 	long wait = 1000000;
 	int ret;
 
-	while (!(tmio_sd_readl(priv, reg) & flag)) {
+	while (true) {
+		if (tmio_sd_readl(priv, reg) & flag)
+			return tmio_sd_check_error(dev, cmd);
+
 		if (wait-- < 0) {
 			dev_err(dev, "timeout\n");
 			return -ETIMEDOUT;
-- 
2.42.0

