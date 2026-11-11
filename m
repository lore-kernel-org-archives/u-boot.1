Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC69606A33D
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SPd9qk5j;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=GkgkK0Uc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14AF140A6A;
	Wed, 11 Nov 2026 10:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yksVju4z1Dq4; Wed, 11 Nov 2026 10:13:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 783F040967
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392024;
	b=iutxdqXMMyiQheI9811XL3aQy/1kndY30fc5ljO/hOCkWpkvdqcw522PEtFjZ/dXAvRa
	 8i2hccxWdRAM6/qhZAMT4z2mrNcOrRQYDgEuL7V6Xl59ZxiFppk+1McfrFNZOsO3hVFD2
	 9HYfXukju6b3I3Pv3TvnCd9c0Ha7IWAKWKlbOYnRQL3hVxjdRDKbYz20fG/Ct4o0+AquG
	 qsPYHCi+yKSIZpIfyoV44NmTP5wMzii0gaq8bISYyLZNpur83iR4Sheyw+jKGZ0DOso+P
	 MXWFTjvh83/sMGnIU4xO2pI3nIkAYE+9Qm7c687WvnvNfae1kBZekjRR3v4V4oncGIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392024;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L71ar9P737U06KBxyPshsvSAeZwpfSO4z7TrRFUs5jo=;
	b=h+WHV/egHOHry+nmiddK0pREmSPNvujX0y/Eov6YUarPnfiFkbwwB2Ei1VrH57j4iNEV
	 VGmK4EYqXVu0eLqZMlSoFDQbsQNVhUj7dgx/i0zU5LxCe9asCQqwyGA0JaqfAGmWceJNP
	 sNul4nEwIWz2TTMkNtSOsS7N3c5wa/tC3a5KRpIEHXXKx8L1yu61gf1usSagW1K3CCOkF
	 Js/Mbawj3NGeCpWdhWdBec5q0lgreigOql/RKgAZTII7CGDlG12oML44d2yIBw8vbZ9gc
	 PbDmfU7OHVsHVmoqCA6DUaojBB2e9QnwWc1ZBat4ZnnulH7jwg9HXCaeF5vmapPg7zQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392024;
	bh=L71ar9P737U06KBxyPshsvSAeZwpfSO4z7TrRFUs5jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SPd9qk5jZcP/11GafEaiSbwPvMur1P4d9RXj2a9KZLKBmgIi4spTAEaeq3V5U7hiE
	 lz/VJAcRtz/TmAzPC9LJY8gEedDTmHCV6RMdHJhFcv3Sjm5donZa4g6p8fnXC6K89H
	 2Sp2dzYOjaCrbuIZVAiJtINye9JCcRiR0Ci0iDFrvyNixH8K7cSOSXsyNWJSvysU92
	 iCL+zZUwqdoGaTbMfbYhzyp++wE2MY6GVREo/B9p6aRq/0ekcuL5+1JPcWju9IXtXn
	 DRyVdJZS4iDHWUR///V4NdTGVzj5A+4ZrpgvJgeg2uZf2wKMUpDfd2yfb3jYqQjP0C
	 fmsW/jqLBXinw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 783F040967;
	Wed, 11 Nov 2026 10:13:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 505CF17CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D511403B5
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kRT9025a5gX5 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:13:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4AAF840070
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=GkgkK0Uc
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4AAF840070
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=L71ar9P737U06KBxyPshsvSAeZwpfSO4z7TrRFUs5jo=; b=GkgkK0UckmNKHJ3N35K1JoqE/w
 yVc5l6FUtkbRKJVmy9cKryMPUn5WlknU/MxD9lPj8Jfn3X4eUMH/XAam+z3GkVwmhJk3KmBc5MFFf
 Qnv6Ja/A6AR77NkU+BwzhE4RHn/Ask4mevloUNNdRLDsNz+Kbm+HmttwUGBPsC2ARM4V5Ksf92TJl
 8DcOT9sR5T7YtZJJ8cmDTEAXU7LoL+UA4+YU+TMRymzzuckdJmYbtePlyMkcOm9rVua28VltyWOB1
 1v+n/XzEMkGiuBtnKFvD0VCThJ/bKJN2In8pCaOvzr5BjRFUSDcaVU+qsO4LXOVtjXZtL+CRBK161
 HkjhyWMg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KY-0004yz-2w; Wed, 11 Nov 2026 11:13:26 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KZ-000Lq2-0U; Wed, 11 Nov 2026 11:13:26 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v2 7/7] power: domain: imx-gpcv2: add support for i.MX7D
Date: Wed, 11 Nov 2026 11:12:58 +0100
Message-ID: <e5f5cc4284683f5f087a908473736f21d0b8ad58.1794391398.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
References: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28180/Wed Nov 11 07:24:27 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Import the power domain definitions for the i.MX7D from the Linux kernel.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/power/domain/Kconfig                  |  6 +-
 drivers/power/domain/imx-gpcv2-power-domain.c | 60 ++++++++++++++++++-
 2 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 2915be0fc76..4c903440c1b 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -34,10 +34,10 @@ config BCM6328_POWER_DOMAIN
 	  mapped registers.
 
 config IMX_GPCV2_POWER_DOMAIN
-	bool "Enable i.MX8M power domain driver"
-	depends on POWER_DOMAIN && ARCH_IMX8M
+	bool "Enable i.MX7D/i.MX8M power domain driver"
+	depends on POWER_DOMAIN && (ARCH_IMX8M || MX7D)
 	help
-	  Enable support for manipulating NXP i.MX8M on-SoC power domains.
+	  Enable support for manipulating NXP i.MX7D/i.MX8M on-SoC power domains.
 
 config IMX8_POWER_DOMAIN
 	bool "Enable i.MX8 power domain driver"
diff --git a/drivers/power/domain/imx-gpcv2-power-domain.c b/drivers/power/domain/imx-gpcv2-power-domain.c
index d6334d1b8c3..542edb24696 100644
--- a/drivers/power/domain/imx-gpcv2-power-domain.c
+++ b/drivers/power/domain/imx-gpcv2-power-domain.c
@@ -17,6 +17,7 @@
 #include <power/regulator.h>
 #include <wait_bit.h>
 
+#include <dt-bindings/power/imx7-power.h>
 #include <dt-bindings/power/imx8mm-power.h>
 #include <dt-bindings/power/imx8mn-power.h>
 #include <dt-bindings/power/imx8mp-power.h>
@@ -25,6 +26,12 @@
 #define GPC_PGC_CPU_MAPPING			0x0ec
 #define IMX8MP_GPC_PGC_CPU_MAPPING		0x1cc
 
+#define IMX7_USB_HSIC_PHY_A_CORE_DOMAIN		BIT(6)
+#define IMX7_USB_OTG2_PHY_A_CORE_DOMAIN		BIT(5)
+#define IMX7_USB_OTG1_PHY_A_CORE_DOMAIN		BIT(4)
+#define IMX7_PCIE_PHY_A_CORE_DOMAIN		BIT(3)
+#define IMX7_MIPI_PHY_A_CORE_DOMAIN		BIT(2)
+
 #define IMX8M_PCIE2_A53_DOMAIN			BIT(15)
 #define IMX8M_OTG2_A53_DOMAIN			BIT(5)
 #define IMX8M_OTG1_A53_DOMAIN			BIT(4)
@@ -49,6 +56,12 @@
 #define GPC_PU_PGC_SW_PUP_REQ			0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ			0x104
 
+#define IMX7_USB_HSIC_PHY_SW_Pxx_REQ		BIT(4)
+#define IMX7_USB_OTG2_PHY_SW_Pxx_REQ		BIT(3)
+#define IMX7_USB_OTG1_PHY_SW_Pxx_REQ		BIT(2)
+#define IMX7_PCIE_PHY_SW_Pxx_REQ		BIT(1)
+#define IMX7_MIPI_PHY_SW_Pxx_REQ		BIT(0)
+
 #define IMX8M_PCIE2_SW_Pxx_REQ			BIT(13)
 #define IMX8M_OTG2_SW_Pxx_REQ			BIT(3)
 #define IMX8M_OTG1_SW_Pxx_REQ			BIT(2)
@@ -90,6 +103,10 @@
  * GPC_PGC memory map are incorrect, below offset
  * values are from design RTL.
  */
+#define IMX7_PGC_MIPI			16
+#define IMX7_PGC_PCIE			17
+#define IMX7_PGC_USB_HSIC		20
+
 #define IMX8M_PGC_PCIE1			17
 #define IMX8M_PGC_OTG1			18
 #define IMX8M_PGC_OTG2			19
@@ -150,7 +167,8 @@ struct imx_gpcv2_power_domain_plat {
 	int has_pd;
 };
 
-#if defined(CONFIG_IMX8MM) || defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MQ)
+#if defined(CONFIG_MX7D) || defined(CONFIG_IMX8MM) || \
+	defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MQ)
 static const struct imx_pgc_regs imx7_pgc_regs = {
 	.map = GPC_PGC_CPU_MAPPING,
 	.pup = GPC_PU_PGC_SW_PUP_REQ,
@@ -159,6 +177,43 @@ static const struct imx_pgc_regs imx7_pgc_regs = {
 };
 #endif
 
+#ifdef CONFIG_MX7D
+static const struct imx_pgc_domain imx7_pgc_domains[] = {
+	[IMX7_POWER_DOMAIN_MIPI_PHY] = {
+		.bits  = {
+			.pxx = IMX7_MIPI_PHY_SW_Pxx_REQ,
+			.map = IMX7_MIPI_PHY_A_CORE_DOMAIN,
+		},
+		.voltage   = 1000000,
+		.pgc	   = BIT(IMX7_PGC_MIPI),
+	},
+
+	[IMX7_POWER_DOMAIN_PCIE_PHY] = {
+		.bits  = {
+			.pxx = IMX7_PCIE_PHY_SW_Pxx_REQ,
+			.map = IMX7_PCIE_PHY_A_CORE_DOMAIN,
+		},
+		.voltage   = 1000000,
+		.pgc	   = BIT(IMX7_PGC_PCIE),
+	},
+
+	[IMX7_POWER_DOMAIN_USB_HSIC_PHY] = {
+		.bits  = {
+			.pxx = IMX7_USB_HSIC_PHY_SW_Pxx_REQ,
+			.map = IMX7_USB_HSIC_PHY_A_CORE_DOMAIN,
+		},
+		.voltage   = 1200000,
+		.pgc	   = BIT(IMX7_PGC_USB_HSIC),
+	},
+};
+
+static const struct imx_pgc_domain_data imx7_pgc_domain_data = {
+	.domains = imx7_pgc_domains,
+	.domains_num = ARRAY_SIZE(imx7_pgc_domains),
+	.pgc_regs = &imx7_pgc_regs,
+};
+#endif
+
 #ifdef CONFIG_IMX8MQ
 static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 	[IMX8M_POWER_DOMAIN_PCIE1] = {
@@ -580,6 +635,9 @@ static int imx_gpcv2_power_domain_of_to_plat(struct udevice *dev)
 }
 
 static const struct udevice_id imx_gpcv2_power_domain_ids[] = {
+#ifdef CONFIG_MX7D
+	{ .compatible = "fsl,imx7d-gpc", .data = (long)&imx7_pgc_domain_data },
+#endif
 #ifdef CONFIG_IMX8MQ
 	{ .compatible = "fsl,imx8mq-gpc", .data = (long)&imx8m_pgc_domain_data },
 #endif
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

