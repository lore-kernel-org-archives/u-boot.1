Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBEBCD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 10:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB86184AD3;
	Thu,  7 May 2026 12:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="Y0hQ0gkN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 558A084A93; Thu,  7 May 2026 12:37:23 +0200 (CEST)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::190d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7339D84A72
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 12:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gB7wx1QYvzsst;
 Thu,  7 May 2026 12:37:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1778150240;
 bh=DpUi2lS/fgkStAAqT7Vmz3WkKUibYS6vFHfGGkBOPeE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Y0hQ0gkNFlvvMs9i64p4emKrrn/Psow82tsMcfq2dH0h52gn1w5zT35wKX54NfwU+
 P3sPBoFsvg2tV4MOHPzRtiORmCW/llFUstZ0oD2duPxGhNWGiVt40HUwaY1jjI+Hu7
 yG9gz3EAEu/rYCxJtf2S2q6zGpIYRoTEl7nszwrDU9D1r0KEba9EjIQuWXvp+28aQc
 F8+vyN4vatHOtjHm7SPI5XpEnptNkLvVxtjlAVvNui9pkY70yXxc8586kN6JvTH5RL
 LuoRcHIiXhYFIkBucsFNOEtP5kfuF748WAtIW3hOG48bJot/3bcSaeIwNQaL8sDLq2
 /naGa/VacTINA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gB7ww2QMXzVTN; Thu,  7 May 2026 12:37:20 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 07 May 2026 12:37:12 +0200
Subject: [PATCH RFC next v2 5/5] net: SYS_RX_ETH_BUFFER defaults to 8 when
 CONFIG_FSL_ENETC=y
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-sys_rx_eth_buffer-no-net-v2-5-cd7ef934bf42@cherry.de>
References: <20260507-sys_rx_eth_buffer-no-net-v2-0-cd7ef934bf42@cherry.de>
In-Reply-To: <20260507-sys_rx_eth_buffer-no-net-v2-0-cd7ef934bf42@cherry.de>
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

Start all lines with a tab instead of spaces.

Specify limitation for FSL_ENETC in the help text.

[1] commit 53cf9435ccf9 ("- CFG_RX_ETH_BUFFER added.")
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 net/Kconfig | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/Kconfig b/net/Kconfig
index 171a88f8ed2..6be392c1564 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -280,12 +280,15 @@ config TFTP_BLOCKSIZE
 	  You can also activate CONFIG_IP_DEFRAG to set a larger block.
 
 config SYS_RX_ETH_BUFFER
-        int "Number of receive packet buffers"
-        default 4
-        help
-          Defines the number of Ethernet receive buffers. On some Ethernet
-          controllers it is recommended to set this value to 8 or even higher,
-          since all buffers can be full shortly after enabling the interface on
-          high Ethernet traffic.
+	int "Number of receive packet buffers"
+	default 8 if FSL_ENETC
+	default 4
+	help
+	  Defines the number of Ethernet receive buffers. On some Ethernet
+	  controllers (e.g. FSL_ENETC) it is recommended to set this value to 8
+	  or even higher, since all buffers can be full shortly after enabling
+	  the interface on high Ethernet traffic.
+
+	  FSL_ENETC requires this value to be a multiple of 8.
 
 endif   # if NET

-- 
2.54.0

