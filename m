Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A30606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZQw7tqSB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=IeU/faPz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=pFMS4BTf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8837940765;
	Mon, 23 Nov 2026 23:45:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YRjntj4-ErL2; Mon, 23 Nov 2026 23:45:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4AFBE40732
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795477530;
	b=kkGIGqYxc5PKtjDsbrQpe29CII2XY6RitkvQZ6DKUGnVpKka5kgyN2FfiyorO47AB6X6
	 IgNwWQ7mwxtMcTJgccuZ/Z+iQcyx6RYhqvWPwHBYyEoOitJmoDzsxFGFJcduzP+wwmv+z
	 g1+SOqEiBKjkhd6+WCKTMybjPgQ7kclW5UWi39L0jF80crrNMo4BcDnwsBzOod8VMxbMq
	 H0Fl38KT/3FeaA/Iyt/ck/RN4kX//ZigaoPNOUobzXFmlfhThP2irLV7Rl3e46rMyaznY
	 RiyOm4+3fg0F0/deGW93LeU8pAp5EKbs7OumDRylVwmg0WMF5kZq5Qu/7ycdVJOSodQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795477530;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:X-SGantispam-id:
	 X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:AntiSpam-TS:
	 CFBL-Address:CFBL-Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wURfdRZzcyn5WYLyHAodEJzoEvugevAaMSGNGnUKJOE=;
	b=KtG67p0gCHrLURXJNxYoSFxopcKw2C+mGE/53Z2YXrfjWJ1zK4eXCBYilgV3F2sDWyg8
	 5Yoel3FLcYCqVnJikiBQYg990TBCqO3qd5BaFBrZgrIeomwYfcS61YGdv6jsPtkBK3Hin
	 tU0+WJYwyypgySRtQHR8zdOim0tF1k7TavlkncPeR1m6Ld/avt/al26OYgcBWIQ2S6PSQ
	 tZlvDQVAYsUmSfE7wiS0A+EdTHJ52KPe0wSmAoG05df7MnjaTbahhWNZvh0Z0euU1emGF
	 vaCu7I5/UdXPPPE3jQvR0TE0O5OO6Hy845Pb/Gwnn5SwEx3G+sM4Ay7wYIIk1F/UC9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b="IeU/faPz";
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=pFMS4BTf;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795477530;
	bh=wURfdRZzcyn5WYLyHAodEJzoEvugevAaMSGNGnUKJOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZQw7tqSB4C52tWS4sVccCwaYCcAAedc/XYLssZoNeEZWa9hkTPO3zVsOWybTNqdGe
	 ZBLarP1qCbV0FIjU1CuH/x2zJOo9Kc6h6453GCb9ZWESrasN1O+odjTppi3pl6QAub
	 84jYKBUti9RKi4VM5OD28XZjyawkaRnH/5+Xzcu07C/IW1sdEXkiNNQF62481aTxhp
	 rW+Zp2NmWIQmpnWZRs7tgdvWT4MfFAzjwDZ7KSOaebBqVhQaAj7RUZ68ExfIRD7XXM
	 CmZd7jLyU21v+qHSMYbtI2DdDNYI8O+qn4FUeUwO1plplmdVBsEZSSjXq/CYt1vdNI
	 9XWjn+CgXWhtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AFBE40732;
	Mon, 23 Nov 2026 23:45:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AC820260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 92D4F406D8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:45:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tNmsZeGB7YKz for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 23:45:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DB48D405C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.5;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=IeU/faPz; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=pFMS4BTf
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB48D405C4
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=wURfdRZzcyn5WYLyHAodEJzoEvugevAaMSGNGnUKJOE=; b=IeU/faPzregJhaV7MMT63/lDzr
 XDIsIKbkN2DN7tYVG/AwcIfJhY5h6BAEwTYe4q0+EYj3R/kUqkfFCUimgaaAdbcNifFY/bUmIRP6i
 UVJUnrNZZsQAzuT1kpWkqJ8rTv6zLXkVPuPYh9ihv3kPfp1UxxZa4Nc0+2JL8rPKOAhI=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVdip-0000000DCwk-36aa
 for u-boot@lists.u-boot-project.org; Mon, 23 Nov 2026 23:45:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=wURfdRZzcyn5WYLyHAodEJzoEvugevAaMSGNGnUKJOE=; b=pFMS4BTfvkqBP9CIyoWVCm/3Ld
 6Y7yuyAMs3ZaHFYsd/0b4+ne3eEdqMVSSqhQYvKcU0KIRQD+cDyW7Ub1l9hS3r/7Tur4H5bp4fXPS
 D199s0nl8hPS8Z77zyrGrCrJL6Fy4PODGOJPOdC/ZOrO1UV9d0lO8cbD4Xi4eG/TJZG4=;
Received: from [79.28.115.6] (port=61909 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVdig-00000000MHw-1NpA; Mon, 23 Nov 2026 23:45:10 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 24 Nov 2026 00:44:31 +0100
Subject: [PATCH 1/2] arm: dts: k3-am67a-r5-beagley-ai: Switch to
 k3-j722s-r5.dtsi
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-am67a-j722s-unify-v1-1-19a83f16d38a@valla.it>
References: <20261124-am67a-j722s-unify-v1-0-19a83f16d38a@valla.it>
In-Reply-To: <20261124-am67a-j722s-unify-v1-0-19a83f16d38a@valla.it>
To: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Andrew Davis <afd@ti.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Anshul Dalal <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3245; i=francesco@valla.it;
 h=from:subject:message-id; bh=69uh9aehbalF6Sk0R2SBK6B4ggWLqBoeaLTkwQmOwR0=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDNksF1hSltlzvnox8efCDzpOxXP0onQNWmQ5bI5ev8mff
 DO9O/p6RykLgxgXg6yYIkvIuhv39sw1/5a2gfERzBxWJpAhDFycAjCRegdGhuenazmPCaY8740J
 ufJX+e495sRj59NUJ68yVzOd7P/0xheG/65f4kN94u4s2VDY+SJ/30rfY7Mmn5OfZ1/4ci374S1
 FHAwA
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: f966b38116a512f1206262592d8932bf
X-AntiAbuse: ID - f966b38116a512f1206262592d8932bf
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVdip-0000000DCwk-36aa-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AM67A and the J722S are the same processor; their name differs only
for commercial / market segment reasons. Drop the AM67A dtsi file for
the R5 and use the one for the J722S instead; all the differences (MPU
clock rate, main timer clock, OSPI and HSM) were part of previous fixes
done on the J722S and therefore also apply to the AM67A.

This fixes also the DM2TIFS secure proxy threads, which were incorrectly
declared as 22/23 instead of 28/29 in the AM67A specific dtsi.

Fixes: b27c94958b97 ("board: beagle: Add support for BeagleY-AI")
Signed-off-by: Francesco Valla <francesco@valla.it>
---
 arch/arm/dts/k3-am67a-r5-beagley-ai.dts |  2 +-
 arch/arm/dts/k3-am67a-r5.dtsi           | 70 ---------------------------------
 2 files changed, 1 insertion(+), 71 deletions(-)

diff --git a/arch/arm/dts/k3-am67a-r5-beagley-ai.dts b/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
index 61ee75b74323..d3da07e470d3 100644
--- a/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
+++ b/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
@@ -11,7 +11,7 @@
 
 #include "k3-am67a-beagley-ddr-lp4.dtsi"
 #include "k3-am62a-ddr.dtsi"
-#include "k3-am67a-r5.dtsi"
+#include "k3-j722s-r5.dtsi"
 
 /* WKUP UART0 is used for DM firmware logs */
 &wkup_uart0 {
diff --git a/arch/arm/dts/k3-am67a-r5.dtsi b/arch/arm/dts/k3-am67a-r5.dtsi
deleted file mode 100644
index 48bd15f480fc..000000000000
--- a/arch/arm/dts/k3-am67a-r5.dtsi
+++ /dev/null
@@ -1,70 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-/ {
-	aliases {
-		remoteproc0 = &sysctrler;
-		remoteproc1 = &a53_0;
-		serial0 = &wkup_uart0;
-		serial2 = &main_uart0;
-	};
-
-	a53_0: a53@0 {
-		compatible = "ti,am654-rproc";
-		reg = <0x00 0x00a90000 0x00 0x10>;
-		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
-			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
-		resets = <&k3_reset 135 0>;
-		clocks = <&k3_clks 61 0>;
-		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
-		assigned-clock-parents = <&k3_clks 61 2>;
-		assigned-clock-rates = <200000000>, <1200000000>;
-		ti,sci = <&dmsc>;
-		ti,sci-proc-id = <32>;
-		ti,sci-host-id = <10>;
-		bootph-all;
-	};
-
-	dm_tifs: dm-tifs {
-		compatible = "ti,j721e-dm-sci";
-		ti,host-id = <36>;
-		ti,secure-host;
-		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 22>,
-			<&secure_proxy_main 23>;
-		bootph-all;
-	};
-};
-
-&dmsc {
-	mboxes= <&secure_proxy_main 0>,
-		<&secure_proxy_main 1>,
-		<&secure_proxy_main 0>;
-	mbox-names = "rx", "tx", "notify";
-	ti,host-id = <35>;
-	ti,secure-host;
-};
-
-&cbass_main {
-	sa3_secproxy: secproxy@44880000 {
-		compatible = "ti,am654-secure-proxy";
-		#mbox-cells = <1>;
-		reg = <0x00 0x44880000 0x00 0x20000>,
-		      <0x00 0x44860000 0x00 0x20000>,
-		      <0x00 0x43600000 0x00 0x10000>;
-		reg-names = "rt", "scfg", "target_data";
-		bootph-all;
-	};
-
-	sysctrler: sysctrler {
-		compatible = "ti,am654-tisci-rproc-r5";
-		mboxes= <&secure_proxy_main 1>,
-			<&secure_proxy_main 0>,
-			<&sa3_secproxy 0>;
-		mbox-names = "tx", "rx", "boot_notify";
-		bootph-all;
-	};
-};

-- 
2.56.1

