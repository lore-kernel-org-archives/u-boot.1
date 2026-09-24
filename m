Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34920C9831A
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D812381E00;
	Thu, 24 Sep 2026 12:37:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ozxQMuHacRta; Thu, 24 Sep 2026 12:37:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 17E3D81315
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253424;
	b=bI986pVGo7Z5wlauUtVM7vca6cNfRWDEwl0nEzyLRGgZ0XAG7kprR0IUi/1H6OCbFBh6
	 ML/jClJcflF7Qin0y+l7avpVvYIEArb4p7Mk04IIQs8vvSAEtYdnA77bpakCFnoEEJDrr
	 +Gxo+qezR9+dsHsU1pjkoGaMDAq0t6PcJO8mgHDTB/6478mVkRJC5W2H+1sgB4+9V/XP7
	 rQUjcno1ajy1OWXwKasKO2l1+Dx9+wNqqcYOfyyhaVRyTCitjNZOIV+VJM9Jopjlk9e37
	 PvWLK5tsGjbYpJKIeOZIqQkRMzb08wrJjaVBfw5KAztDc8ZKKDN6vDwSBUJh1505j4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WW/j6m31Uq12h+kfPAlWWNwZXUM2rWtg26kJDaIrfzw=;
	b=ZWreVVNixQJAu+ydYnU2BkwWqhbc9qwbyOfxZDtk6O3jg4J7WCJEC9bhbSqAo4PVmlxS
	 AxLwhQSNc7DBQws1wKX5cZK++fc837/bp9eUL6DG+HP190UeRfEssz6uQE0R/LdcezRR1
	 9k50AY6alG+ulpEVSM9h4QcvDi9xnaPWG0yZSZpkVYkyf0o9QYAiZnKwmSyjP1aLD3JUN
	 dvsuJ1BkTZXSIp8Vmk1DpNINOGKR8Zt86rteeFtg0viFdpmFN6kTfwEDhFcZ/cXEWGZ8e
	 ApHjBNR/4J+jR+LMZeiWhcLdYWPnBBCjFxmDX/NLmIW33RBwGafMUYSAwP7FIaLgobQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253424;
	bh=WW/j6m31Uq12h+kfPAlWWNwZXUM2rWtg26kJDaIrfzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tk/CCu9XhAMZAr4VVNqknffbNcAnK5WIY9IA2MCK+ZXK3t1wZ1R/lh38H3QGOT3V9
	 cmOkF8aXrmufWYWmEyRg7V5OXR5Ppe+glO0DJJVR9zpOF+JlIOIoF2pC0eltYnXdkc
	 KKgeO4/M0dXeq7Az2UGZO1aQQ84pTjjHPIRtIF5ci/Eh3qYNLfKqP6knPoREeMs+nb
	 kaIhPBiyqwmWyhMnfr3VNnlyLv0z/SGAGqqR3Q4WnHhzmjzFg2MLD7QMq+QWrGccSu
	 X4YFgw6nMV1t2yZIMZeUJ3/iwj5AbOLbrVN7lbH6KFfxcLNUiQtyGxiALpCi9KJvl7
	 LOzJDrORz8VOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17E3D81315;
	Thu, 24 Sep 2026 12:37:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C35E4392
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A95F26081B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YyPlVKWYpLil for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:37:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CED74607E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253421;
 b=VFRj4KUIe1Zz/yL+GZmJ45M9X4vyh0lxIph5+K7nMU015x08N0H6AWjHfkrak39CD2Hc
 Lj6j9tKdd5d9rgS6lVIGma+Y8NwM/HMh2LUX0uZ/cFPtsvTs12HR9k/8Xuc0N082HnCY8
 /m+LmkphwioEd/jk4vI7Ea0dRPFmwXnLy/jspJERbtgyWN6ZY2OULoQooY5+ytg4zXvVI
 9sQrpMbX4e1NLAdR5uPoU+VB8sdfhYE8sbUkG0phqit8H/yBXuqG1g761kXu0zwvNVXCP
 +TaA92+J39rPDPrqGVufbbnxHbpAdYRcLjdtEIVjSdJg9ZDoyipaDjOqkhfTF31YkqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253421;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=WW/j6m31Uq12h+kfPAlWWNwZXUM2rWtg26kJDaIrfzw=;
 b=q7Sc4UpJ6oLGDGNIO9UbLYHdEFPxl/xlljTeIw1SDXvSCpEBICYMDgFwh2M9t8PhSI3f
 UjnrvIv2fJS3z7aJXI+dnsWwzm/3HmyOBZeMSCo6xxieo6ESeWeHEoWNQ5CD6ln/A7YZN
 AGrv9jnoOZt8dQ9EpCF55S4krKDacZGMr0pT0g9cox4ZvCrxG/BGYKLRf1JEEOwOZ10vF
 xJa+ZJUXkueas0TwLv2IB+XkTG8dx089EuT4uGg7VpIsaa3arn2wuzAZqcy+I2/6jI+Rs
 WRvvXhNRs6L2OtH1Dg1k7DPEF4hfxV3mUDfJb/PsDg74dJPW8rLW1s4RO9x8TceywmQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=v0eKipJa; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=v0eKipJa
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CED74607E4
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 4A96EC211C1;
 Thu, 24 Sep 2026 12:37:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CF65260341;
 Thu, 24 Sep 2026 12:36:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B6DA010329407; 
 Thu, 24 Sep 2026 14:36:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253417; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=WW/j6m31Uq12h+kfPAlWWNwZXUM2rWtg26kJDaIrfzw=;
 b=v0eKipJad++L/WshEAlERDjwU/5JSV9ll5PUjzwJUW0FIMbREHkoOAEkAn21/ZMzBOmEl7
 kVPDQzJ7U+6LTFYsFrsXWUXxewo1ZkBaISuY8P5wManx4sBdauAc5XRKTbafgqqKSBMwbk
 g2i8LsgU8uyGf+I1sO3NcYzwj9tqpBIG49GtwFP1eDq1/bEOeiynkb5tdF2S9F473h1Cqc
 t5EP813YjT04iG/XU/9+yhR/rY2td7ib5NCq+c/wTUf64lLgt7oOYgFe33ft5fL1kpC78x
 dewDk5zszRJRfFMHINhC9NpaMPn0EGt3FESO4+7jHuBpF+ausua4gpr4mQHWtA==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 13/22] ram: k3-ddrss: Add j722s DDR resume sequence
Date: Thu, 24 Sep 2026 14:35:24 +0200
Message-ID: <20260924123533.2599438-14-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

As the j722s and am62p resume sequence differs on the way they are
detecting that the board is resuming, we should have a specific
compatible for each one of them.

For that purpose, introduce ti,j722s-ddrss compatible.

Acked-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/dts/k3-j722s-r5-evm.dts | 4 ++++
 drivers/ram/k3-ddrss/k3-ddrss.c  | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
index e1ef5d181ed7..cc4a5910673b 100644
--- a/arch/arm/dts/k3-j722s-r5-evm.dts
+++ b/arch/arm/dts/k3-j722s-r5-evm.dts
@@ -11,6 +11,10 @@
 #include "k3-am62a-ddr.dtsi"
 #include "k3-j722s-r5.dtsi"
 
+&memorycontroller {
+	compatible = "ti,j722s-ddrss", "ti,am62a-ddrss";
+};
+
 /* WKUP UART0 is used for DM firmware logs */
 &wkup_uart0 {
 	status = "okay";
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index d8ec8356b286..3af360f191df 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -19,6 +19,7 @@
 #include <power-domain.h>
 #include <wait_bit.h>
 #include <power/regulator.h>
+#include <mach/hardware.h>
 #include <mach/k3-ddr.h>
 
 #include "k3-ddrss-lpm.h"
@@ -1300,11 +1301,18 @@ static const struct k3_ddrss_data j721s2_data = {
 	.flags = MULTI_DDR_SUBSYSTEM,
 };
 
+static const struct k3_ddrss_data j722s_data = {
+	.flags = SINGLE_DDR_SUBSYSTEM,
+	.is_lpm_resume = j7xx_board_is_resuming,
+	.ddrss_deassert_retention = am62xx_ddrss_deassert_retention,
+};
+
 static const struct udevice_id k3_ddrss_ids[] = {
 	{.compatible = "ti,am62a-ddrss", .data = (ulong)&am62xx_data, },
 	{.compatible = "ti,am64-ddrss", .data = (ulong)&k3_data, },
 	{.compatible = "ti,j721e-ddrss", .data = (ulong)&k3_data, },
 	{.compatible = "ti,j721s2-ddrss", .data = (ulong)&j721s2_data, },
+	{.compatible = "ti,j722s-ddrss", .data = (ulong)&j722s_data, },
 	{}
 };
 
-- 
2.55.0

