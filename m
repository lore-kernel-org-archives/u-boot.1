Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D130C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 08:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD70C87FA9;
	Tue, 20 Feb 2024 09:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QCrRPTFV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XalQm/C1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97D0887FA0; Tue, 20 Feb 2024 09:38:23 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 636AF87F6F
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 09:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TfCTw015Lz9spD;
 Tue, 20 Feb 2024 09:38:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708418292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMFzdcHoD125OfUztIsIjcBCnI4nNgaDS7bROynU+i8=;
 b=QCrRPTFVAm7uD71mrjGtqgaYSZ/Trx0XLDnYj7Frvm5j3WcdiR6zs92fLHlFBxpPCBHqJp
 ScYW6K+6tWFkpf8oYxoUQbSvrirIbl3RRDBfx2FQbhNlYL9jHxcrsyKtbyHG5edU1O2k/5
 EH6opRBStaIwx0XTzkEQbbz3YflG3wFi50MdgoFRbj34CVhUym2EXYY0j5q2/foaEo7bud
 4wLbeJa4nMuZqDihwnwcxI6gX0myoULSEAGDeF5XfKjkosta951cbZc0sF3pJSWsz0LlJ2
 +HxctJeqyoKyhs2W0riilaO9AMdaHt8NBi/Cq/nK/zcJjKG1PZJag4k8BeB30A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708418289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMFzdcHoD125OfUztIsIjcBCnI4nNgaDS7bROynU+i8=;
 b=XalQm/C1Wa/Dvfz4t3xAOb98C9v42GlvVxGG6w2tlPlmd6m5cTtRT5e+0wrBgz8V+BAlNv
 VG1nNxugk94hx/2Eo9g00agTxrpS80TCvHniY5HcXkrLbUygHzRz2ATJfMWA/trdx1On9i
 FSof0ltJwytDwh5p0vzgcKQRDy4xljLNg6F0i+3XOlb3xuQvHSMq/BpVMaumGpgpaKKTVi
 bggP2bOZJqVVtBB98yYsUqSbgsj8fka77aqw4Ky3UPMiCDRabqDRQWJcrDthUIJEq030ky
 GyRzw4FmgWuIHyreidNR+F1dnsoY8E1SWzTp0Q0QkZHU0lqEGoO7mvA+Qu9Y8A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 3/3] mmc: renesas-sdhi: Do not access SCC during tuning in
 send_cmd callback
Date: Tue, 20 Feb 2024 09:37:49 +0100
Message-ID: <20240220083755.34449-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240220083755.34449-1-marek.vasut+renesas@mailbox.org>
References: <20240220083755.34449-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 82aeebd71f1cebb53a2
X-MBO-RS-META: kiyyzjye3g7fie8caozuuqm6u8c74jd3
X-Rspamd-Queue-Id: 4TfCTw015Lz9spD
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
 drivers/mmc/renesas-sdhi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index 9770b6bb5e1..316b75b35fe 100644
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

