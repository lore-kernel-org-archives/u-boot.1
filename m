Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A690FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 10:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DD928485A;
	Wed, 29 Apr 2026 12:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="QPdxGS19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 230DB8483E; Wed, 29 Apr 2026 12:35:21 +0200 (CEST)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [83.166.143.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0799384848
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 12:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g5DGF5FzKzCrF;
 Wed, 29 Apr 2026 12:35:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777458917;
 bh=B15bT149NZ1gEGqcciEaPwYruyNJAqGD3R4MtlYDjsU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QPdxGS19bRZxoQY/b+IU3S4DGMUjw9yoN7PykSjvWjimT74t8GCeIT9dWTWmvIn30
 RkTUEemtRmO6fKclHc6hlDkop91B5MBEyFbbjByJ73JWSliMSSnoiehRA/Cb3ck1kY
 3KsOtRaNiGfxlnezN5CAW47yY36uuBdJP9hp4wBfN1POG2zefS6ovCO2XegSsyufLK
 1wXq/TviqG0CYRfSdUlx+/DL9n3wpDbFXE7zlb9LnjB3scVcTGGqO34IDE93pYlGtf
 qQyDh/plZuRnQ9SZm3gmGg3l92iPwOVz0frQ0qHeZ1OfZ53d8CuCuGqVrjbEcwyyim
 HXJ3uyUStCaKA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g5DGD4tSkzYX6; Wed, 29 Apr 2026 12:35:16 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Apr 2026 12:35:05 +0200
Subject: [PATCH RFC next 5/5] net: SYS_RX_ETH_BUFFER defaults to 8 when
 CONFIG_FSL_ENETC=y
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-sys_rx_eth_buffer-no-net-v1-5-396ef37ae93c@cherry.de>
References: <20260429-sys_rx_eth_buffer-no-net-v1-0-396ef37ae93c@cherry.de>
In-Reply-To: <20260429-sys_rx_eth_buffer-no-net-v1-0-396ef37ae93c@cherry.de>
To: u-boot@lists.denx.de
Cc: Tang Yuantian <andy.tang@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Benjamin Hahn <B.Hahn@phytec.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

drivers/net/fsl_enetc.h specifies ENETC_BD_CNT "buffer descriptors count
must be a multiple of 8". This constant is set to
CONFIG_SYS_RX_ETH_BUFFER which defaults to 4.

All defconfigs enabling CONFIG_FSL_ENETC fortunately have it set to 8,
according to
./tools/qconfig.py -l -f CONFIG_FSL_ENETC '~CONFIG_SYS_RX_ETH_BUFFER=8'.

Let's make sure the default is sane by having it set to 8 when this
driver is enabled. Note that originally[1] it was said EEPRO100 and 405
EMAC should be 8 or higher. 405 (PPC405?) support seems to have been
dropped in commit b5e7c84f72ee ("ppc4xx: remove ASH405 board"), 11 years
ago. Maybe there's something we can do for EEPRO100 though?

[1] commit 53cf9435ccf9 ("- CFG_RX_ETH_BUFFER added.")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 net/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/Kconfig b/net/Kconfig
index 171a88f8ed2..80f0872e0f5 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -281,6 +281,7 @@ config TFTP_BLOCKSIZE
 
 config SYS_RX_ETH_BUFFER
         int "Number of receive packet buffers"
+	default 8 if FSL_ENETC
         default 4
         help
           Defines the number of Ethernet receive buffers. On some Ethernet

-- 
2.54.0

