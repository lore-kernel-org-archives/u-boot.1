Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38DB606A32A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=F5qSXRxD;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=ZNcmg1hx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CC17406FC;
	Tue, 27 Oct 2026 09:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P3fDMF1Lake7; Tue, 27 Oct 2026 09:40:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BDEE0406E7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793094033;
	b=apX+CHrbV2zYFLduHYVEVWn/h938aR26zZo4ayZQIniuDAxUHd09KatR2sdfxI3NTaji
	 JGnbueO4B0yauF74YPRjwIHHeYsYSJ8R21f7YJBHL6EOSEHpR/PFN4NK7M+Q1ybe2ZDqN
	 xnVHaSclKefT++Y0jUb4UNfMuaq8PDnD4eX/tioUD/j0VPP6RGmFLFLMsIfl9DDMJ4X/I
	 hGfubNFP2+QiXRsZU5MVrQocpYNWZhOEmY8xX7C92u5ZWYUpIvr/yuazVpb3iZO/+3Dor
	 km2fHw4AHCucnjfeVJj6QtOkUC7apCE9f2JRsENLSDNxWen9KxNR6zxStLikwMphqmw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793094033;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1GjJQfTRnYY4mkYWvvz3ZVKqJTX1IzsHbwKjp0pdDgw=;
	b=lROOGC9w/hH08HD7Yk7BVTldKps0fxpaDNHA3k5DqY7CtJZ7OIp4OM5i7f7GDIH0Re8S
	 skiVTAHhXHpkIi9rTG6HYFLtIwgqCve9MBFiyrve3jk/47K5QmkqEsaMZSpmHxiF0h7Na
	 4NAKjCF7X9GLcHwGQYGKhJq5X96p9t/xEb0LU5Mw/nQ/OHAyXssGmWv87zOhYDYIGVShn
	 hx70JuUh3y+H9I0pQNVX1SWN9MCAJRM8gNR4dsIybEC7DxS4TTKxpY+w7miNECEeIm7Hb
	 TohIUgiUo516lkPkT/aBgKMh0kfarQmS9QIlNpIddNOdEUrbDprYcCn6obj3ziBBRow==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793094033;
	bh=1GjJQfTRnYY4mkYWvvz3ZVKqJTX1IzsHbwKjp0pdDgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F5qSXRxD6RhlCf7sLlykXYKEWXKjoDdkJq7tGbjmUJx6WaWDNGtxoT9olguYRdOMc
	 5KJeothr/QQKsnUhUT+Z3HZim8KOT0xC1ddEJHYOe6I/tAqnA9GrQk6Yc/gcfO6R42
	 xMZnNLoVl9AEC/vw/gcLrPnWLxvtsfAdZJPKVRWyIL4bczus9Du8bipV33KU/+LIcZ
	 bbqUCOWyc7mkVx08V9NwtHSpAvrpBrMi5Qjq0azR51+ps4Pe5tYTgFUz9HcZQyxp5q
	 cXGK823AOITw3agVCM2ij3srP0W01xC0kABBvN5vI5661BBbntfkkUwECviZvL/z5Q
	 Jm46DGTuHGGuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDEE0406E7;
	Tue, 27 Oct 2026 09:40:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 37AAF1DE
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DA35400C5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id waInJf8fMlgd for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 09:40:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C928440042
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793094020;
 b=R5OPcRFfSXIfZMxtAp6p1BSQ0XgYXPHXHzUKR2mluJVKkbFqEeEqVUKgxZYt2nELTg8J
 zYAX395MfaJDe6lIOeYHnENgf9EXyV1fMUeKvbbyn1vqCMW916rlmycB5BSp1TFNyQ+xq
 yAuumUUC1V60nnaS/BZaSmLTVHewba11yc8qwgrgMfh5Y3b/shDh3DapF3Aq+w/+DyX4G
 4yr7di5dpwhqoDqY+mWEmuN03Oi+HVoDaLwuRG/+qiTiDoOp8ZlLDnpRB4Ftj0/AL7W/+
 ZStYt4n7j1zfqlQN4mZhP8eCSAVYM33uSKQY9eCFHLu6/bQJmA2tKhDBCR5pX4koyuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793094020;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=1GjJQfTRnYY4mkYWvvz3ZVKqJTX1IzsHbwKjp0pdDgw=;
 b=kkswZ6tDkhan9rKDj5WsNDcmtAw6bX4tD2E9440nbkOq/TQm6he2GHCQFwOF8GaC0sbM
 tubKakHhzvrFo3hhLJEZqE6jDYvlVB3IW39f1mXMCj0/OXevExvIJHtxvaDg+4RV9aBn9
 P7HCztt5G5HXAeCt2WzH8hf/U2tlkAEER0MopSbrRSVqALs8EQ591LKi3Xl05s3BcUm+a
 edwFmH+u6oZ8Dd4lRCYqpvBEQDQBBcwTQNUMMMS1rjxcsIvSjBX3/GyLLhoQr6zW4K/6g
 Qk7/oPpVd2EmX9B3TJU2zBq7qt6UnrdW8qhCh8zuzP9dBlm1cUoJzfkDmNH6rfxsoFQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=ZNcmg1hx; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=ZNcmg1hx
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C928440042
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=1GjJQfTRnYY4mkYWvvz3ZVKqJTX1IzsHbwKjp0pdDgw=; b=ZNcmg1hxqqE5qHukJUHHvyeqAs
 cpBEX89bm6aBHIDWwP4f2bunkym8d9YiNdvGq257XoXXgxOR5Z6Lzctwm5//Ma+exCc1Bn11bYkjT
 RwZdEUzA74oTRyCMXnWIzCXUR2VHyh6la961LnC4lMSO0BS98emQbzUMX/qg9sBUyFehj3IoM6FTS
 xR5Q8DuS4CCh1NSJYM2eUJiP112C5K6FwegVeqc68PUqfBpmWVDHGMyku5xpn9emYHJMm65UsSd7W
 wsnQckdJa/fx99rPFo/N3oiTuz7XPMIQmchy1bRKBVGIBwjtJ/Y3SKE91uo7BksVOrbBedSa52g63
 L+Y/jiDw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfF-0007WN-1h; Tue, 27 Oct 2026 10:40:17 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfF-00022y-1x; Tue, 27 Oct 2026 10:40:17 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 08/16] power: domain: imx-gpcv2: add support for i.MX7D
Date: Tue, 27 Oct 2026 10:39:05 +0100
Message-ID: <ed7717aa9b6e85391cef1d406976ee0d81916f7f.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)
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
2.55.0

