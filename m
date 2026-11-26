Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489C606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k8DqjwnF;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=o2dVEJyN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB3C260A66;
	Thu, 26 Nov 2026 12:24:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kbH1gBSKZtow; Thu, 26 Nov 2026 12:24:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7A79A60A57
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795695893;
	b=CPGUhowILwYHQ+19xGCWUapUOKgr9iRb3gUEl/sV5x69avOyr+p7APBRY5QxpMH4xTDQ
	 ZzlRomy/Pqpcq1/UCL7ME6TWjdiJWtNbmrrnQkH5HAkg6zX21vJau2AapCXS42rmJ5HSO
	 QRHXjNXh9wt5IXpNdlocX3amrAR+nL0njLaeFiDWgD284lsuma00ig7artzX0A3HI7+fF
	 PxTSpeqtkukZLK+9HN96QUDYmTXypjp4HKYblJVmpuIhtjSZHIXKrEkZWetlEwa54zCPi
	 26SeJEI+MdOqapaiWs1ZYD2I2GGDaZkmwaQn+eR9QmMEkyi3k+REhhqzhBWLao9u2yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795695893;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dG9e+q99oUpu7eRRDEi5vZR3LCYs/EXYQ//8JDjSR14=;
	b=TNq14av0Po8BbJrPzc4Ng9+++G9Wl8htW1h4ERzzUDKz5Ep9xsk9GJdCikIXkIt+uBOk
	 wxfMFZoTpXtR+GHxZDNJs7KvFzPRBFiplWGoyseGGe0+jwFFl9Y4S3729fgUcWvCpHIX7
	 bqF64ONGvomFeWdda1iz+JStYMItDolUahuuPP0gILLIQw6j42+RJX9Gy8R1uJs5lkk7O
	 oqiyNOotGtxScarc+OXg0755xLNJ0pjg9NbpQOoJaiZ3AS0oG6VECww8Osz6D2Atcg18f
	 X0EUjwZtjEvd13vTx4Og69wSlAKxDJLoXIJ5jy+fjQNjA4XA493h84Eob0CJeluggtw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795695893;
	bh=dG9e+q99oUpu7eRRDEi5vZR3LCYs/EXYQ//8JDjSR14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k8DqjwnFwanIL3M748K8ogmJK7/stne1HKJUN9yiWP4FaLKkH39erLvDzbRatcqjw
	 LPN9DteZNGHXTseRh7duFZ/iFUjPK7uubAhhdPHjQ2bRfzfe8V9FITwW1nbL8zKBcV
	 ZUZRXIKBf+rMxZmlnH5sSkcmAcdPBOaxK9+lt0qLCc5DM0jdQaIvY+RV7b2/Ac8VJh
	 xFhIT65JFxVNE0vqmegxSmnAWL2WTQ6/enEvH4tRNKdennEpJuiwrauqICwDRBdzCf
	 2exihqu169YADvfdq6/MHtvijyZ7ejq6FU2STyup29aesj604t3ao4rtIqYNyH9tfh
	 a0taepZ55SdjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A79A60A57;
	Thu, 26 Nov 2026 12:24:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E45331AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5F054087D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0gqoYX6Tds21 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9160040547
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=o2dVEJyN
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9160040547
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=dG9e+q99oUpu7eRRDEi5vZR3LCYs/EXYQ//8JDjSR14=; b=o2dVEJyNptJQoxwKsKPOI/YHzL
 wzvCbgA4/VV5qkitqh+U3Vo4/4HMfRzxern/nnj/Q4cRcs4QocTtScGd7iR86ozdZfV/0lA7TSURc
 VvrlGwAXXFQXA5LM/4LrMiSsk/vUqNqvagguRj7bM7cryM9BtJKLYNgP1u7csnKgGCIDdjmP5nx6Q
 5lOyyAapoGPCzvfHx8tfaJkHs0eMOw9bRTbdUXw5p5uEeiT/zmuTgWW7Mizkl5gUwFKLNtZjfXj6T
 ZIMgliwlMdjUJjdYxDAx1f/xfk9Htd1c2RI/BXOYECneR038l3lwnY8lt+9h/SmXMlQcvYNYC4j65
 f/PciF0g==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWg-000ICw-1y; Thu, 26 Nov 2026 13:24:34 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xWYWf-0003gJ-1c; Thu, 26 Nov 2026 13:24:34 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v3 7/7] power: domain: imx8m: add support for i.MX7D
Date: Thu, 26 Nov 2026 13:23:59 +0100
Message-ID: <3415df204f287b0ad440d5becab9f4345a4a79e7.1795694935.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795694935.git.nora.schiffer@ew.tq-group.com>
References: <cover.1795694935.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Import the power domain definitions for the i.MX7D from the Linux kernel.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/power/domain/Kconfig              |  6 +--
 drivers/power/domain/imx8m-power-domain.c | 60 ++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 8809887b1c4..2ca2bb07dfa 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -41,10 +41,10 @@ config IMX8_POWER_DOMAIN
 	  requests to the SCU.
 
 config IMX8M_POWER_DOMAIN
-	bool "Enable i.MX8M power domain driver"
-	depends on POWER_DOMAIN && ARCH_IMX8M
+	bool "Enable i.MX7D/i.MX8M power domain driver"
+	depends on POWER_DOMAIN && (MX7D || ARCH_IMX8M)
 	help
-	  Enable support for manipulating NXP i.MX8M on-SoC power domains.
+	  Enable support for manipulating NXP i.MX7D/i.MX8M on-SoC power domains.
 
 config IMX8MP_HSIOMIX_BLKCTRL
 	bool "Enable i.MX8MP HSIOMIX domain driver"
diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index aef7f4cbb35..df70621c50f 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
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
@@ -150,7 +167,8 @@ struct imx8m_power_domain_plat {
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
@@ -580,6 +635,9 @@ static int imx8m_power_domain_of_to_plat(struct udevice *dev)
 }
 
 static const struct udevice_id imx8m_power_domain_ids[] = {
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

