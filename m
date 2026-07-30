Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FFEC55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 16:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBAB440C84;
	Thu, 30 Jul 2026 16:38:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qjAySxDCLc3Z; Thu, 30 Jul 2026 16:38:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9415E40C48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785429528;
	bh=+VPU0t/+DL9Uu/Xkq5a/RWCL8YqAmfexV8nAYBxZvRo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=r0ItC//TEOOvGFiTN6Tvow1tD8jiDfG59EGQRuo3pGKo8cZF6WyABwPySEp7rNfBB
	 VNsQUErUX9qj/zXgLCLTxAYU9zbx47sK263Ospt2uMUAJ/Kk5/CHu1horvLuhdYMtV
	 gHCl9bjQ29x5FNoR/p7QLEGumDuHMtGEZz0MdEiiu7FiGetrOC4XY4lspHFiSzzHfE
	 SekDm4fPDAuMYqGm1pS84tcVcnK8sff8/wovoH6ljsLJSLw5A2ZlciM6bfuFQZOQrI
	 PFHkU6rnC7PeWgFoe63BVfoPGU92YGsoUpTPl+VcCPq0E98NFclj6sMSsvcoebF06H
	 ZFYejSpEiJadA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9415E40C48;
	Thu, 30 Jul 2026 16:38:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E23727C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 16:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 341DE608ED
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 16:38:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fy7hmHzH5KLA for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 16:38:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ozndrgt@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 063B9608D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 063B9608D8
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 063B9608D8
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 16:38:45 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FB56849F3; Thu, 30 Jul 2026 18:38:42 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91E85849BC
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 18:38:40 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f7854678cso1325296f8f.1
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 09:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785429520; x=1786034320;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+VPU0t/+DL9Uu/Xkq5a/RWCL8YqAmfexV8nAYBxZvRo=;
 b=VOnviTm/jaekpvAVqeqK6h9Ainf8RzcQOpEcwGPQarQug+YBE+n+GPnlAaZajmV6t8
 OjQE6BgmBo0E1zQRoZM5wk8NBpFe5xeATBL/7NVvD3+F0iMzg+oWECPWsVINrsQy+qC8
 dVJ3bKXnnT8mUsU8kRyA2Sy6s2zTrPO4JmBdA0U30UclDftQPO/mFh3AWo4upprDBfFG
 Drxpn5+M7p9qLSzbTCFpW6PdJH2ddzooU3vjmZS0AETAI/QtjrtSYrx7NwU7KTT9SSyQ
 SS2QFv3c7HmiUakBs1QEcEA+bp7N9GduSmIf25GMAxTBddQUWdz4oYAmwIYtt1fxxxzq
 /HZg==
X-Gm-Message-State: AOJu0Yw13/aDK0Tt/sd3DHiwwkPYyHY9i9W9Ue3LxnzNKOMqDT7aDhdV
 pF+pwJ49VEBVyczo8Md1msglrulqmsNpx9xJ8tzassswrELiSHDETK92
X-Gm-Gg: AR+sD13Ar31av9tmwsa5VpxiIMLZdn/sT35UdIz/Wt89kQb+oqavAzGbaM5vvFrNLHB
 5CJ++hMZAM9nLi6lgjJwn4+kAIxnSCddFGMe3RCSARh0AjqJxSFECUhCFQ71699i9BQtdTICsvG
 ZJHL8zMpRN+lH2Jch/Wkg9gprYUYRjOn3LqH5i+rEiVrRmrgIV+VXdj3lKeSQPLq700rzbay5vO
 0KxP81cfLXv9qpclXbDwDK+QrMKp9yZVRrRomsF+eXbOGnIN57vUqDFt0wk0hRvolPhZW0hvvUo
 W1p+wiH7R++AhGhxzhjduHo96XXgGyEmb2/CeTrnXsd4pTzOgNzauBuTo/4eXfRX/RXP1GBYQJf
 uPejTbP7K97BlcRyKUUcolRQpnpUcWAbA9Oo17PyHDS7nwZqk3vC9KUJGsu5M7p0q7w7bGIJmT7
 bXan3ahkhVsocBBa5U9bLnKtDdSPOngszlGG/Dfo0OemfMiJr8UOOiKJdTCDbCx2TmQ8qHJz6wQ
 2zCrB1ckKpPkobumJRUIOcQhqYgMEzrFIvNd+KBu9VLTbJ30ttfJIw=
X-Received: by 2002:a05:6000:290a:b0:47f:97e9:fe3b with SMTP id
 ffacd0b85a97d-47fc822d8bcmr4800408f8f.34.1785429519769; 
 Thu, 30 Jul 2026 09:38:39 -0700 (PDT)
Received: from hp-15-dh1xxx.tail71a1d0.ts.net
 (port-92-196-144-227.dynamic.as20676.net. [92.196.144.227])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88e424fsm10927291f8f.14.2026.07.30.09.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 09:38:39 -0700 (PDT)
From: Ozan Durgut <ozndrgt@gmail.com>
To: Stefan Roese <stefan.roese@mailbox.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>
Cc: u-boot@lists.denx.de, linux@analog.com, Tom Rini <trini@konsulko.com>,
 UtsavAgarwalADI <utsav.agarwal@analog.com>,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [PATCH] watchdog: adi_wdt: get SEC fault source ID from DT
Date: Thu, 30 Jul 2026 18:36:21 +0200
Message-ID: <20260730163621.83050-1-ozndrgt@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785429520; x=1786034320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+VPU0t/+DL9Uu/Xkq5a/RWCL8YqAmfexV8nAYBxZvRo=;
 b=q4VWR0YCYx2KXx2K8+6ge2eOGZUexV7el1U5uY51JFo6+BZ3AH7vqQiNObBm51dCyi
 1QJMhRzU4XEH2fQ5jUZlDp3qiEIng4ram1Sitcn1bjvOsaE6XCRxxJvrN5GzXZui11gx
 FfJz5W1PqX4Ylod5mYSP43yGMBD2rduUHJFJc1L+d+90ziA2D84NcRre7EzPFqB+Eaqg
 dDfMVfz4BO70nc+pjs3Y2pg39+fu53xDo6qKJAAkO4uvwUfxFDbGjViwhesd8uFwoRJq
 93ep2HYkHOjeOYUcpmTlNQH9sk+/277dcuG4LS3ZHCC1kj2BbtRMJPbyOa39OMDFur43
 0F0Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=q4VWR0YC
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ozndrgt@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="q4VWR0YC"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: UtsavAgarwalADI <utsav.agarwal@analog.com>

The ADI watchdog drives a reset through a Security (SEC) controller
fault source. The source index was hardcoded to 3 in adi_wdt_start(),
which is only correct for the SC5xx parts that happen to use that
index.

Read the index from a new "secid" device tree property so boards that
route the watchdog fault to a different SEC source can configure it.

Set secid = <3> in the SC57x, SC58x, SC594 and SC598 device trees to
match the value they relied on before.

Co-developed-by: Ozan Durgut <ozan.durgut@analog.com>
Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
Signed-off-by: UtsavAgarwalADI <utsav.agarwal@analog.com>
---
 arch/arm/dts/sc57x.dtsi     | 1 +
 arch/arm/dts/sc58x.dtsi     | 1 +
 arch/arm/dts/sc594-som.dtsi | 1 +
 arch/arm/dts/sc598-som.dtsi | 1 +
 drivers/watchdog/adi_wdt.c  | 9 ++++++++-
 5 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/sc57x.dtsi b/arch/arm/dts/sc57x.dtsi
index e4cc612959f..794e80c3cf1 100644
--- a/arch/arm/dts/sc57x.dtsi
+++ b/arch/arm/dts/sc57x.dtsi
@@ -113,6 +113,7 @@
 
 &wdog {
 	clocks = <&clk ADSP_SC57X_CLK_CGU0_SCLK0>;
+	secid = <3>;
 };
 
 &eth0 {
diff --git a/arch/arm/dts/sc58x.dtsi b/arch/arm/dts/sc58x.dtsi
index 7b07589de47..d4008ba7988 100644
--- a/arch/arm/dts/sc58x.dtsi
+++ b/arch/arm/dts/sc58x.dtsi
@@ -158,6 +158,7 @@
 
 &wdog {
 	clocks = <&clk ADSP_SC58X_CLK_CGU0_SCLK0>;
+	secid = <3>;
 };
 
 &eth0 {
diff --git a/arch/arm/dts/sc594-som.dtsi b/arch/arm/dts/sc594-som.dtsi
index 1c2adc601dd..7a7167fbbba 100644
--- a/arch/arm/dts/sc594-som.dtsi
+++ b/arch/arm/dts/sc594-som.dtsi
@@ -67,6 +67,7 @@
 
 &wdog {
 	clocks = <&clk ADSP_SC594_CLK_CGU0_SCLK0>;
+	secid = <3>;
 };
 
 &i2c0 {
diff --git a/arch/arm/dts/sc598-som.dtsi b/arch/arm/dts/sc598-som.dtsi
index bc212ef25cb..bca3ff765d6 100644
--- a/arch/arm/dts/sc598-som.dtsi
+++ b/arch/arm/dts/sc598-som.dtsi
@@ -124,6 +124,7 @@
 
 &wdog {
 	clocks = <&clk ADSP_SC598_CLK_CGU0_SCLK0>;
+	secid = <3>;
 };
 
 &i2c0 {
diff --git a/drivers/watchdog/adi_wdt.c b/drivers/watchdog/adi_wdt.c
index 7d7cf98b55e..8e7ff958121 100644
--- a/drivers/watchdog/adi_wdt.c
+++ b/drivers/watchdog/adi_wdt.c
@@ -36,6 +36,7 @@ struct adi_wdt_priv {
 	void __iomem *rcu_base;
 	void __iomem *sec_base;
 	void __iomem *wdt_base;
+	u32 secid;
 	struct clk clock;
 };
 
@@ -72,7 +73,7 @@ static int adi_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 	iowrite32(0xc1, priv->sec_base + SEC_FCTL);
 
 	/* enable SEC fault source for watchdog0 */
-	setbits_32(priv->sec_base + SEC_SCTL0 + (3*8), 0x6);
+	setbits_32(priv->sec_base + SEC_SCTL0 + (priv->secid * 8), 0x6);
 
 	/* Enable SYSCD_RESETb input */
 	iowrite32(0x100, priv->rcu_base + RCU_CTL);
@@ -95,6 +96,7 @@ static int adi_wdt_probe(struct udevice *dev)
 	struct adi_wdt_priv *priv = dev_get_priv(dev);
 	int ret;
 	struct resource res;
+	u32 secid;
 
 	ret = dev_read_resource_byname(dev, "rcu", &res);
 	if (ret)
@@ -111,6 +113,11 @@ static int adi_wdt_probe(struct udevice *dev)
 		return ret;
 	priv->wdt_base = devm_ioremap(dev, res.start, resource_size(&res));
 
+	ret = dev_read_u32(dev, "secid", &secid);
+	if (ret)
+		return ret;
+	priv->secid = secid;
+
 	ret = clk_get_by_name(dev, "sclk0", &priv->clock);
 	if (ret < 0) {
 		printf("Can't get WDT clk: %d\n", ret);
-- 
2.43.0

