Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC05FC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF0288172;
	Thu, 28 Mar 2024 16:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711640079;
	bh=eJOr65NrCaA1tj3dKnYB22gVwpRA0ancxXdUR7BpvcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xOFD/CnbGnf2uKIGFkFsyDMXC6gooG5JRJjLgkJei12vJvDAYDtUINbhFFxIPnCxh
	 THnjpqfLH+NHQWjxqYpNYJ4FYtv0ojGg72lNpoLt5PFLrYn3k8JKTIjxUT50y6amgQ
	 AlNVwHe3WhFC4YDFtm4jrUyiXBJYRk4+Wry5rFU+MsVxu0ffS8jRT+SiUS4A0rHJcX
	 G0s53D2hFCvWZfBu+BTBWGsbX7t9fMDS/sCH/B6Hhvw97CmPrHfFWh5j98j8oA1P4o
	 gONDqwrSAwzII+fae6FattR3ICZTnFpynNf4BCorIJX/RLcg6I4OTUVMLGrBK+Sf/I
	 U45A02eZDH51Q==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C540488196;
 Thu, 28 Mar 2024 16:34:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711640078;
 bh=eJOr65NrCaA1tj3dKnYB22gVwpRA0ancxXdUR7BpvcQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y3gFfYxg4s89q0dfrVb1QaHIuiQgUtUcWBumJGjSaJvrLeQ2KGdAzT6Oo65omN8wZ
 vVGGrr6SbnYV+QIgpMVaeHO38JewVuRUqKBXT+rrmtGWN3aVidprSMLe7v5AajJTQ1
 EraQrbn1psuZ9L7BOU6tbBzD5+6DYdr/HPZ3NuP7b7235csjkRdcj4O8EncjE46xro
 /YMh6hcasPd75Erz04cmRf7gCDoEz+zInvmkJ/y2WZ6E1BWpVGnr9FV4UNmFzUDGgv
 ZhnjcpAKi66Rurrd049iMblVFPFvFzG+zBQq8tUSZztG5O9wi8OKG+CjivGF09ywaZ
 WV4Qqq5efUBJA==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/6] arm: spl: Add definition for PHY reset GPIO for XEA HW
 rev. 2
Date: Thu, 28 Mar 2024 16:34:12 +0100
Message-Id: <20240328153415.3706637-4-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328153415.3706637-1-lukma@denx.de>
References: <20240328153415.3706637-1-lukma@denx.de>
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

The imx287 based XEA board's revision 2 uses GPIO_3_21 for PHY reset

It is safe to keep the GPIO_2_13 as well, as in the SPL SPI1 is not
used for transmission. This simplifies the code, as the proper
configuration is performed either in falcon boot's read DTB or in
u-boot proper (with correct FIT configuration chosen).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

 board/liebherr/xea/spl_xea.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/liebherr/xea/spl_xea.c b/board/liebherr/xea/spl_xea.c
index 71194db235..6cf8f8390e 100644
--- a/board/liebherr/xea/spl_xea.c
+++ b/board/liebherr/xea/spl_xea.c
@@ -225,7 +225,8 @@ const iomux_cfg_t iomux_setup[] = {
 	MX28_PAD_ENET0_TXD0__ENET0_TXD0 | MUX_CONFIG_ENET,
 	MX28_PAD_ENET0_TXD1__ENET0_TXD1 | MUX_CONFIG_ENET,
 	MX28_PAD_ENET0_TXD3__ENET1_TXD1 | MUX_CONFIG_ENET,
-	MX28_PAD_SSP1_CMD__GPIO_2_13, /* PHY reset */
+	MX28_PAD_SSP1_CMD__GPIO_2_13, /* PHY reset HW Rev. 1*/
+	MX28_PAD_SAIF0_LRCLK__GPIO_3_21, /* PHY reset HW Rev. 2*/
 
 	/* TIVA boot control */
 	MX28_PAD_GPMI_RDY3__GPIO_0_23 | MUX_CONFIG_BOOT, /* TIVA0 */
-- 
2.39.2

