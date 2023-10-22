Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B57CCDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 21:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E386D874DB;
	Sun, 22 Oct 2023 23:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dQnztGVV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EfJHkY6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 792F9875AF; Sun, 22 Oct 2023 23:41:23 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB8D784003
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 23:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SDBbM3gsjz9sWZ;
 Sun, 22 Oct 2023 23:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1698010879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=w2423DRu6iiYgsAI+vPIR3LUfaBWRNTpD4vjrLIs8rM=;
 b=dQnztGVVVCxd+UAnVm3zyvo8+pxw3SfaS8U9SQfk+S74ahXRlz/RJ2bwL+EDQqbUF5FsON
 XPuecV7ATKMogvGakO2ejF6X3+ZBQTRaFKimvDGTmWs9BKSy84fOAJ15QIqDocP+SxsXpu
 7g7Fg4LszKmD9YyUQRGTX2jvGhzIOo1HQOkmFB8m+HjVcpUdLm9P3ljFKIqS3zF/5DwvMZ
 S+hKXkdkaCYUgplCr1w1RELzMvYbFkt+AlPffgVpZVSf/kQvKfrb4qlYD10k2KZfA3OJZ0
 kXBrrcn0S951Tkg4lRcBbAE9h8cQFwVBmcqA5c70u6kzT6vIyOkKT+GCMfSXIQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1698010877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=w2423DRu6iiYgsAI+vPIR3LUfaBWRNTpD4vjrLIs8rM=;
 b=EfJHkY6Ub+q/sm0P2PcpZLZvZ9A/21LNVt91Mvmz2xbkXWR4diM7LEO+YCukjvW6DUuAOr
 D5SaILuKkGs2gOxxqTUdbiisCWo6uYWBeD4PjfScgH/1UYwBC2xe7dT3wePvGuvf2nj+ZN
 Q7OXEn/FZOsd1YLMivJ27l65sE6y5DJFGJa52Ozc3JwoB8JSSKBZTnW8apPasErA5N2qXz
 swpn7N6KJ9DE+4nOkbPVgycfBMCwz05yAf/b9CkgcB5oIjTYu40ZSHQoGK4VRfxzBWN5uS
 yRogZWKYCPGq8IHuEP6EwsvLLa1e1UrsbyM3+3jkkF5fdaNxXWOWPdLgnr/HVA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mmc: tmio: Disable 1/1024 clock divider on Renesas R-Car
 platforms
Date: Sun, 22 Oct 2023 23:40:43 +0200
Message-ID: <20231022214057.102051-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 569c687624d716c2882
X-MBO-RS-META: oq6wmb4ccon3mse4rf5yoxaphiddnztq
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

The R-Car Gen3 SD_CLK_CTRL register does not use BIT(16) to implement
divider 1/1024, instead BIT(16) is reserved bit and divider 1/1024 is
not supported. The divider 1/1024 is specific to Socionext variant of
the IP, as is indicated by Linux commit:

0196c8db8363 ("mmc: tmio: move tmio_mmc_set_clock() to platform hook")
"
Socionext (and Panasonic) uses bit 10 (CLKSEL) for 1/1.  Also, newer
versions of UniPhier SoC variants use bit 16 for 1/1024.
"

Do not set the TMIO_SD_CAP_DIV1024 on Renesas R-Car platforms even if
the IP VERSION register does exist, and indicates IP version is newer
or equal to version 1.0 . The IP version 1.0 or newer does not imply
presence of the 1/1024 divider.

Since the TMIO driver is used exactly by two supported platforms, that
is Renesas R-Car and Socionext UniPhier, it is OK to check whether the
TMIO_SD_CAP_RCAR capability is not set to identify the UniPhier platform
and add the capability only on that platform.

Fixes: 58c35b17aa8f ("mmc: matsushita-common: Always check controller version")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/tmio-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/tmio-common.c b/drivers/mmc/tmio-common.c
index 83eaf361f0c..890c496b535 100644
--- a/drivers/mmc/tmio-common.c
+++ b/drivers/mmc/tmio-common.c
@@ -759,7 +759,8 @@ int tmio_sd_probe(struct udevice *dev, u32 quirks)
 	dev_dbg(dev, "version %x\n", priv->version);
 	if (priv->version >= 0x10) {
 		priv->caps |= TMIO_SD_CAP_DMA_INTERNAL;
-		priv->caps |= TMIO_SD_CAP_DIV1024;
+		if (!(priv->caps & TMIO_SD_CAP_RCAR))
+			priv->caps |= TMIO_SD_CAP_DIV1024;
 	}
 
 	if (fdt_get_property(gd->fdt_blob, dev_of_offset(dev), "non-removable",
-- 
2.42.0

