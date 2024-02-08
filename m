Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8FBC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 12:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B513787E38;
	Thu,  8 Feb 2024 13:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="owtP1usV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D63787E46; Thu,  8 Feb 2024 13:03:24 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB5D87E47
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 13:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1707393800; x=1709985800;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pW507IJpdbfOaKxIs7bremqN9uX+tsRoDqdsVMZpV80=;
 b=owtP1usVdEYKv72XdIICYVlpl/tkxHm9v7162CPkBsx4ockXtaeMaLFzupQpWPWy
 k25tRgd8pTsDc+0hKXWPFn4Yn2IiBK0z2vZbqP3lr94FqDXWg8pNUeHXsMIrbgsx
 LHUn1EWXWZpBH1dT/QYH2po4968jdea29pO+D1+7/Ac=;
X-AuditID: ac14000a-fbefe7000000290d-7c-65c4c3086f6d
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id AE.80.10509.803C4C56;
 Thu,  8 Feb 2024 13:03:20 +0100 (CET)
Received: from llp-hahn.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 8 Feb 2024
 13:03:20 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Thu, 8 Feb 2024 13:03:09 +0100
Subject: [PATCH v3 2/4] phycore-imx8mp: add USB host support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240208-usb_support-v3-2-e605efd50512@phytec.de>
References: <20240208-usb_support-v3-0-e605efd50512@phytec.de>
In-Reply-To: <20240208-usb_support-v3-0-e605efd50512@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, NXP
 i.MX U-Boot Team <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707393799; l=1155;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=pW507IJpdbfOaKxIs7bremqN9uX+tsRoDqdsVMZpV80=;
 b=jIGXOWcBz9w8hRNAaR8RFY/oGUZbAANljRmXxYneYXbetDBakpJcYDV7w01FzDHjNpLnRbNjQ
 zzvBHf19wy+CBbFYxHdPvKcms9kqkelNOkPK43kA75Fd/nSyc8Tyc4C
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42JZI8nAo8tx+EiqQd9BEYsP81rZLR5e9bdo
 P+VjMXXSZnaLt3s72S2mPF7PbtH9Tt2B3WPerBMsHjtn3WX3eHVgFbvHnWt72DzO3tnB6NHf
 3cLqsfHdDqYA9igum5TUnMyy1CJ9uwSujKk/zrAWtHJWnJ94mK2B8RV7FyMnh4SAicSGtc1M
 XYxcHEICi5kkLvffYYZwHjBKTHlwiwWkik1ATWLXm9esIDaLgIrEk+trmEFsYQEbibMtLYwg
 Nq+AoMTJmU+A6jk4mAU0Jdbv0gcJMwvIS2x/O4cZosRO4ufhi2BjhIDsZQ07wcZzCthL7Dny
 kg1kr4jAdkaJa4t/MYI4zAItjBKT/ncxggyVEBCW2LRTCyQuIbCbSaKpeT0bRDxRYudrOYih
 shI3z29hg/hMXmLaudfMEHaoxNYv25kmMIrMQnLqLIRTZyE5dQEj8ypGodzM5OzUosxsvYKM
 ypLUZL2U1E2MoHgSYeDawdg3x+MQIxMH4yFGCQ5mJRHekCVHUoV4UxIrq1KL8uOLSnNSiw8x
 SnOwKInzru4IThUSSE8sSc1OTS1ILYLJMnFwSjUwRmr//vr9hvDnAAnPp51Xe88lPCnQXrGu
 44/8jx2ON3Z2+y8qF841LDu3eA/jOmO5ygj/+frhzwL/CF01v/6wk3fK01snlnwv7FzZH1l8
 0va7T67eo2u+NYJbD6/Y9jLOObAi6nhpp51V6C4eDe2TbMKPvLn/9C+Ws33XsGELz/O0ey89
 vldFKbEUZyQaajEXFScCAPPpYJiVAgAA
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

The phyBOARD Pollux has two USB ports. Add support for USB host and USB
storage for the USB1 port.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 configs/phycore-imx8mp_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 519e0cfb3d..74450b957b 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -65,6 +65,7 @@ CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
@@ -104,6 +105,7 @@ CONFIG_DM_ETH_PHY=y
 CONFIG_FEC_MXC=y
 CONFIG_RGMII=y
 CONFIG_MII=y
+CONFIG_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
@@ -120,4 +122,12 @@ CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_STORAGE=y
 CONFIG_IMX_WATCHDOG=y

-- 
2.34.1

