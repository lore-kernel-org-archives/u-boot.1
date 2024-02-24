Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89911C48BF6
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 22:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE9A487D64;
	Sat, 24 Feb 2024 23:33:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YgEdi/X3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="n0OPfEQp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D233E87CEC; Sat, 24 Feb 2024 23:33:10 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B8E871C7
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 23:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Tj1qK0wFTz9sRX;
 Sat, 24 Feb 2024 23:33:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708813981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IYHNZ8djdC3qMecMpKbI2wCBrMmbDIXvklNUI74ASxc=;
 b=YgEdi/X3aaqFGlfxo+FcqOUaz67AQG1htM3j0xBv230/gCvlMvxXFmjkHD2ZHrMv51OmB2
 Mkc6aKRwACaEGyjgJzJ7SuAg1brf+hmYfh2qj9lrDn43IxhlZxWe6U26le5deMjfM1X5D5
 +IrQiWWCz/OgGdq/fQkyF1pbn2zgOFbjo/CTr7deaskaxB/F7wO8Kv8L0xb9ql+gcPYx1H
 su58n80IdFcwtw3Lip/Ij9lJWykl4xF+CYTVJeWzfD0R4+AaE1HnlGDRH2dBUUDjaOQXvu
 E/mhEutogjhj9H2eHGZ53OHI3CQuz7mNnB1JN05r4yApilcOljgkcU7c47Sdug==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708813979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IYHNZ8djdC3qMecMpKbI2wCBrMmbDIXvklNUI74ASxc=;
 b=n0OPfEQpfpkqbxJL3ozAb92jAZuONWynrK6foRNBtB2OTJ9EtaXwsWzv0NRDT98JkGUAa/
 aL0nIcz4n/h7FZQItqAoO4SqJ/QbCDO2E+gRkQ7LKOAXMLcoZnIyGoQruzQhs04YNJFEef
 23PPPnU97/BobJUwlTWDbyQ05FPkzD9c1DGcikYrow1jBfVUmp0Hf4EaY8XLHKxTkEAOOV
 cIB08OkCQNzJjUNBTLsKcOXK4XWUKBw7BucJkiq/uuynWGvvyQIdJNBq3PlXMnhMTcHSQF
 XRI58Zj+Aqj6JYEHoUD2S/9QJ+rcjkAv/ZUmAgEjcuKwhHK+RjoQ0uxYjZFW0Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 3/3] mmc: renesas-sdhi: Do not access SCC during tuning in
 send_cmd callback
Date: Sat, 24 Feb 2024 23:32:11 +0100
Message-ID: <20240224223235.287889-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240224223235.287889-1-marek.vasut+renesas@mailbox.org>
References: <20240224223235.287889-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 93s1bjwxh5iumjxzyj6q16u9p3gmpuya
X-MBO-RS-ID: a52c6335d4f54e47895
X-Rspamd-Queue-Id: 4Tj1qK0wFTz9sRX
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

Do not access SCC when sending commands during tuning operation as that
will disrupt the tuning operation. The tuning operation is adjusting the
SCC settings itself in execute_tuning callback.

When renesas_sdhi_execute_tuning() is called by the MMC core code, a loop
which consists of renesas_sdhi_prepare_tuning(), mmc_send_tuning() and
renesas_sdhi_compare_scc_data() iterates over each SCC tuning tap.

The renesas_sdhi_prepare_tuning() configures the SCC tuning tap number into
hardware, mmc_send_tuning() triggers transfer of tuning block which depends
on the bus mode for which the bus is currently being tuned, this information
is supplied by the MMC core code, and finally renesas_sdhi_compare_scc_data()
tests the received tuning block for validity.

Because renesas_sdhi_prepare_tuning() configures the SCC tuning tap into
the hardware to fit the tuning operation, mmc_send_tuning() which triggers
command transfer using renesas_sdhi_send_cmd() must not manipulate with
the SCC in any way. Currently renesas_sdhi_send_cmd() does unconditionally
call renesas_sdhi_check_scc_error(), which may adjust the SCC tuning tap
position by writing RENESAS_SDHI_SCC_TAPSET, which would overwrite the
required tuning configuration set by renesas_sdhi_prepare_tuning() and
disrupt the tuning operation.

Fix this by skipping the renesas_sdhi_check_scc_error() call in case the
MMC subsystem is in tuning state. This way, the SCC settings are left
unmodified by command transfer during tuning operation.

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Tested-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
V2: Add RB/TB from Paul
---
 drivers/mmc/renesas-sdhi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index 29a742f404e..c4d0733b621 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -798,9 +798,12 @@ static int renesas_sdhi_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
 #if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) || \
     CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
     CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
+	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
 	struct tmio_sd_priv *priv = dev_get_priv(dev);
+	struct mmc *mmc = upriv->mmc;
 
-	renesas_sdhi_check_scc_error(dev);
+	if (!mmc->tuning)
+		renesas_sdhi_check_scc_error(dev);
 
 	if (cmd->cmdidx == MMC_CMD_SEND_STATUS)
 		renesas_sdhi_adjust_hs400_mode_enable(priv);
-- 
2.43.0

