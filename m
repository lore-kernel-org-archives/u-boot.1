Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73691CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 10:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB55F84A90;
	Thu,  7 May 2026 12:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="P1FAg03Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0809184AA4; Thu,  7 May 2026 12:37:21 +0200 (CEST)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [83.166.143.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C420584A7B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 12:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gB7wt3M1czwCx;
 Thu,  7 May 2026 12:37:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1778150238;
 bh=vnwvprxFkhTOL7GbCOB3hwM53oNSJ5Tb1CzXZfUUZCs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=P1FAg03QTkUuFOJg7uXKqyrQ0XpvNU6F4Wl4gDRaX0/C3VIOUZTYB5XmCoHMrGJrD
 SSckGj/fQRnXP6eEg6MkNVvIPOsaY8VVZjNG8bT9h8dVSKG1nJWLcctWsZtEw+P1Ml
 xPv9kPCiH62hINaRaWleBeRNxTRaHPxK6qc5ZT55bJzd/5ZjxXxevGWqHMU6Zi/x80
 qf7cdlKTyzEI7i+fJInR4dtNqS//UUPK/IdUvO+PyFTVMvSvwMeli5dAXfXe/t8Dbc
 zu+nfrIJPTSanYfLV2vwn3cbYqBsYxc+pyqkaaDUyspmALAYZKaC/ioIiTDIUDfJZW
 /gJfrmwit6oqw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gB7ws4G7lzWLh; Thu,  7 May 2026 12:37:17 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 07 May 2026 12:37:08 +0200
Subject: [PATCH RFC next v2 1/5] ls1028a: only include
 drivers/net/fsl_enetc.h when driver is compiled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-sys_rx_eth_buffer-no-net-v2-1-cd7ef934bf42@cherry.de>
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

As hinted by its path, it's not really meant to be included outside of
the driver itself. This header uses CONFIG_SYS_RX_ETH_BUFFER which we
are trying to move under CONFIG_NET dependency. This file here can be
compiled without network support so make sure this only gets included
when needed.

The function from that header (fdt_fixup_enetc_mac) is already guarded
by CONFIG_FSL_ENETC so simply guard the inclusion of the header the same
way.

This was tested by building ls1028aqds_tfa_defconfig with
CONFIG_MSCC_FELIX_SWITCH and CONFIG_FSL_ENETC disabled.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 board/nxp/ls1028a/ls1028a.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/nxp/ls1028a/ls1028a.c b/board/nxp/ls1028a/ls1028a.c
index db94d9c1fa8..4725efd1002 100644
--- a/board/nxp/ls1028a/ls1028a.c
+++ b/board/nxp/ls1028a/ls1028a.c
@@ -26,7 +26,9 @@
 #include <fdtdec.h>
 #include <miiphy.h>
 #include "../common/qixis.h"
+#ifdef CONFIG_FSL_ENETC
 #include "../drivers/net/fsl_enetc.h"
+#endif
 
 DECLARE_GLOBAL_DATA_PTR;
 

-- 
2.54.0

