Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E927EC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 12:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D3EB87CFF;
	Tue, 30 Jan 2024 13:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="NTkX5rg+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3165787CFF; Tue, 30 Jan 2024 13:43:42 +0100 (CET)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAD1687CC0
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 13:43:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zpK1768T2KCW81if3epyoouSZCUXHFE4GBEq18NKCHM=; b=NTkX5rg+F+78QmvYRiY/AGDXTH
 ZhlwExLKi3JFIVrgmVjGP5gwXsjL+HtYiHnRB/oKCyhSD87/pXGQUtQGgB07j1YR4r5FTHVHJCCTR
 +RYb/lYU4eJMPG0Q6i26Hnti8DbrwE0+xx3Pfmd1KQYDeYQv+3/VgZjtCDj8iBqrS5W20TbhyqrYo
 QmD5rrGXaqec+HkfOk56MboNCf+tEWCooJTA2GSLvNmaMbKaj1+LosFwy4PHwBYl0SaEoSOAdKdhA
 UQS6hz1DTEh2/xPZBjKqDK+btwB5azTy5TkDYcvQzOvkCIHsdbIlsOh4eWGSD//iJtv9iPGL2b7YN
 AEHJ5pIg==;
Received: from [89.212.21.243] (port=40348 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1rUnSk-00A5HC-1g;
 Tue, 30 Jan 2024 13:43:38 +0100
From: Primoz Fiser <primoz.fiser@norik.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 u-boot@lists.denx.de
Cc: upstream@lists.phytec.de
Subject: [PATCH] imx9: clock: Fix board_interface_eth_init for FEC
Date: Tue, 30 Jan 2024 13:43:37 +0100
Message-Id: <20240130124337.497748-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Commit d5eae216d833 ("net: dwc_eth_qos: Add board_interface_eth_init()
for i.MX93") implemented board_interface_eth_init for i.MX9 platforms.
However it only accounted for the EQOS interface while any board using
FEC as primary Ethernet interface was left out as return value -EINVAL
is always returned from the function in such case.

Fix this by returning 0 (success) when FEC interface is primarily used
instead of EQOS interface on i.MX93.

Fixes: d5eae216d833 ("net: dwc_eth_qos: Add board_interface_eth_init() for i.MX93")
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 arch/arm/mach-imx/imx9/clock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 92c41e9a67bf..75d92af036a1 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -882,6 +882,11 @@ int board_interface_eth_init(struct udevice *dev, phy_interface_t interface_type
 	    device_is_compatible(dev, "nxp,imx93-dwmac-eqos"))
 		return imx93_eqos_interface_init(dev, interface_type);
 
+	if (IS_ENABLED(CONFIG_IMX93) &&
+	    IS_ENABLED(CONFIG_FEC_MXC) &&
+	    device_is_compatible(dev, "fsl,imx93-fec"))
+		return 0;
+
 	return -EINVAL;
 }
 
-- 
2.25.1

