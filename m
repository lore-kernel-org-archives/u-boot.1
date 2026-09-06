Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5FAC79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 09:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B094A4060F;
	Sun,  6 Sep 2026 09:11:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BebrxdWfe8cP; Sun,  6 Sep 2026 09:11:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BBE7540600
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788685899;
	b=oD0ao2SYvG7EXblC6ERKm+1uPxykuK4LRjrhq7igHuinC6RVmwhfE/DlZ4rMXqsa59uQ
	 EaJBIeJaxeyBEP8xzvt+ZBKwCOyVqt3rPlJPyOs5dyXyuwNCf1GC8krZhWySbcbwWxX1q
	 FLCA+9RcWy7DwNNxKacpoYJNC6oFjjGDZm9mecZd34TFUHWiq4DhaM5NmlObE9tAieBTa
	 bhhBs0oGGLE7aujPwJNJHVekyAWdWdPipB+as4eIqLxuAsixy6wf4Ja5METyKM3UX8/Hi
	 dHGfR+9tIrSR03gHwOTPTg/e0LIp07DHFyJui0kyAt+4i+3ngVAxrQDqpZteOTNl0/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788685899;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
	b=Ud3Xoe5boiggvxhc+bcMDUSW7bj2IQqwB8r0xRj794zufObVD78lsLRBVmcRB5znBvYF
	 JIkLX35fis7oiNPS9gpJxCgpcLHND9memm9jU0I+SqNv1QZLXimwDJL02BpVVO2PyL7Fq
	 xmhaRTrkBQr5sBz/RjZl1/ksLRjeLmL/jDfE2AWtinszAIAPszp3j9KBoI1rdXqmnIJkx
	 LC5tLuroz1F1XIh+lUUqmeocPhULVHUtLuVVFjfzGa4kvRf+uIZ3mkXju8H61YcvPvjGw
	 6FlNUR/NxrC85sWBjNw0GzTBgrmKFA/Qn31Nvyhr83Q1aVvyevLxSjLvysNOEOL/gcA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=f8FNmM9e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788685899;
	bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EZ3dLBTyhQ6u+cnnt4Qdt1Bbk+/nVZXACq/234qKBhEaAeJ8DgqnHLHCA/8FA5rv6
	 JwO1sSmnlMmuHHF3OpNpCopQa1wz0SuMyKBhNfD2y7dx7J0Tn+xwyPF5aSVNW0OfUl
	 N4ltzFKPmg3XkcorSW5MsZe2NPU8iNTd1ZlehbOgEtQSri4KkT2Fac6CRQn/UMqnoy
	 nOlfN8qCxvEVLJkmZrIVK0t54sN7tl24hXIyNBEkmxHA7EdoFKrG6+rVm8gIU7nOXw
	 ijv37NnFBVFzujRs3MnNwEwB6DEqMRL/XHq7zLygvboTwNzOBkh/gxQBg4JNzYVa3T
	 GEtbFW7VRUTrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBE7540600;
	Sun,  6 Sep 2026 09:11:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E53EA58
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0E9940609
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ea3emaohQ51D for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 09:11:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 94B1440602
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788685896;
 b=D5lZBgIAd0q7JVf9poHwvk9uieBDdeTUdD+ma6P104Ql9XcCSwOqO9IdSn9sak3hXly4
 52IMJr4g4END0CfJcFcSvt8Y6zGyfk7eghH1GHJeOdKwZGCJBUdLB78A5MJ7Eat5sgxA4
 nOg9yHdVvtqGzMn95pHlvypcwNeTYx71IhrIawPcjiE3uGLnW4uHgzlmaSp5eVFv0He3i
 +qRTdZRr1DpN3gSYaCgFoDWH7eUM8OD83wps1FSYq4kSuIFikdSlytjj22WYXexvSRAV/
 yuidCJsCSw65ucuQ3GLtkFc3n0MZGX0/ztEUEtHBv5xN6/udkQSjpWiTHuvap4KW9eQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788685896;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
 b=Uu8CiAaAhdqFmcxkF3Irvw9pAkAXwbJzY07adf5gjk4lplqQ1NT2ZEErMm/CNJfxfyvo
 EaZTbKvLE8anwkUIUT6LVKb/cz77aOIZfqDEbC1tMNxDeAfZWtHZ0kvNs/0tj/DSjxBbw
 NJBM4ZcTPzRVliTKyGD5NJDt7jFqTwxBpPVwEfxTetAfGoMGl/texVV0KhRjiGI7iVGnW
 wy0H509RjxLbWbzhhZYd9T+Y2e5ZSQoG2MIZ177Ua3843eTgf00UyqsM87XpHLU5oBYNp
 vPoY5btLDS3nVCbpFgzxPZYkJDFcI7uepKJEuS2ExNGYW+CzExlcTUA5q819clwyc2g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=f8FNmM9e; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=f8FNmM9e
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94B1440602
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:36 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2d72ae08fa1so21954545ad.2
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788685895; x=1789290695;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
 b=f8FNmM9e71Nu8dFNalMK0+mEyN2zTcQ5Hh0MJmjDDUlG7ejp0uJIwZ8G9O6//4OLa1
 WMMS9wy3B2kMVFPsRlSmA1nW5datRq3GFTZMuB2G5GRC7FoePlnr8GCNb6yUimt4Hdlz
 0UBHZSKKRHJ06jsGiT+FyXYmYbjRR8FX+z8qi85VxlYw3NFUnFSD+8qR0655Juz8KxPC
 UDJbspO5YV1qi5Xsl3A6JlQugL8CzuYLgFAvgNQksozgB+suzYcizGgVfgRqCrp6RWdE
 95ngEdbf6MseJ71lfX+knV4+q03DF/d+mSgnqKtBa/Zarzd5H6h1+5n4mjadAR9GVOEu
 EhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788685895; x=1789290695;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
 b=MwZqjbehHDoR2SG2DQCPAjwdEHesozFPiSG0GCh02f5GwoJXeirgV5qRSsCOonGydQ
 BDzjBDPv+XvQ7fVtb9xn+V5z6UYwO4FG8SI5qQHDlgUjOMZIaqCBok/eOC3k7ZC5crbX
 eBmQKuQh2TA81fie601fBFQprMFIBMyum9BW/fEFhJXDDgHRJf6C7bc9oiyp8aqtPmSI
 aZjeT194/Pbe1q/FlMJ59Mc7Sz1XPd7yMCSksLPQ0RtMlgWsz+1jGS3HM2n1yF7fBhGS
 op95FwArW1eDSqSueKow7jI51vWWCsHoQeMy3yMX0WB4Es/vdYwjKxqfTH8xp9Gq/GVp
 PTQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBynglSWul3G+yNc7tBFVY7/xPCgA2nKzu3qE4+hmrp7dZKin6q+VZZSLfOqKGAhp+HnDAA603c=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mlt7CHuB94dY4eXPmVF0G1ZWzo5xJz+JiYTZKxxuqBZFTR1zdK
 i4l5DPdkGp0YtB1lcBCDTTDfUZ0lWpqkkSJonplZ37Xoz5jzlaPOaFB39Ro5EBhxUzg=
X-Gm-Gg: AYBFou1WVONaK1l9BIdBeHNc5lBT7RARHhJuFE7DwZkZFAXATpTzyoIegZAw9dWxXyT
 hghdj3Spcd/TGkTavzLJMkoKaWm1rE2ByDWoW1Wr5dhpS5OLwOwU2kDh6wLobMT5PJ9VlUG3aXL
 bf9lK31DLhkxAxghZZEQ1X7OPMws5+h96L1Ca7CHYDNzW2oBapBhwXIyGcSeM3/eFSvkA+e9vGD
 uE+jmlAwU3qWqE9ipoFWlyYK3YCLeT0NazI/BRHq7Htdcx3bux6rH2T41+2g+4F7y8yeHj4XiSi
 YQ0YfPwkk2S9UClgVUp+9llJGNPIwPXTI3+YD8zQCqCZx24WtWSat95t7N3SNrE7MD2HZ+bQ/on
 PASR7F8nfeD4AfpXL6qdyAxUm26vSajxdPbbBeGs9cQkzMWV80OT3r3ZOUcyVWcdLLcn1kkofJP
 l4JNaAkU/rWxocBNuBcAcVG0Jj/UQmXIqtpgplsnyycTGuS39V7nr99iE/fbJSO3Dy3Y0znb2Zc
 E7u+HzlJ33RPKuNVHKvw2hskVh2D/XjByBw2400BoAegfp1Yg6yXhzeKPfA7oqIFb42SFP7mXq1
 Wz6/8Bj8IVIfyw1BFy00NcohNPcpHOnEAMIJ
X-Received: by 2002:a17:903:234d:b0:2da:c09d:b5d2 with SMTP id
 d9443c01a7336-2db1231eb81mr224199975ad.3.1788685895540; 
 Sun, 06 Sep 2026 02:11:35 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b8f44d7sm18845384eec.22.2026.09.06.02.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 02:11:34 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 06 Sep 2026 17:11:05 +0800
Subject: [PATCH v12 3/7] dts: k1: enable mmc devices in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-m4-v12-3-89eb5a8f879d@riscstar.com>
References: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
In-Reply-To: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Enable eMMC and SD device nodes in SPL stage. And set the
bus frequency for mmc device nodes.

Remove the redundant device nodes that are delcared in upstream
DTS files.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  12 ++-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 136 +++---------------------------
 2 files changed, 21 insertions(+), 127 deletions(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 7f9443d69510..3077cdee55d7 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -50,7 +50,6 @@
 
 &i2c2 {
 	bootph-pre-ram;
-	resets = <&syscon_apbc RESET_TWSI2>;
 
 	eeprom@50 {
 		bootph-pre-ram;
@@ -65,7 +64,6 @@
  */
 &i2c8 {
 	bootph-pre-ram;
-	resets = <&syscon_apbc RESET_TWSI8>;
 
 	pmic@41 {
 		bootph-pre-ram;
@@ -89,6 +87,16 @@
 	};
 };
 
+&emmc {
+	bootph-pre-ram;
+	max-frequency = <204800000>;
+};
+
+&sdhci0 {
+	bootph-pre-ram;
+	max-frequency = <204800000>;
+};
+
 &binman {
 	u-boot-spl-ddr {
 		type = "section";
diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
index 8a9a2a09de99..d6299c96949d 100644
--- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
+++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
@@ -76,42 +76,15 @@
 
 &i2c2 {
 	bootph-pre-ram;
-	status = "okay";
-	pinctrl-0 = <&i2c2_0_cfg>;
-	pinctrl-names = "default";
-	resets = <&syscon_apbc RESET_TWSI2>;
 
 	eeprom@50 {
 		bootph-pre-ram;
 		status = "okay";
-		compatible = "atmel,24c02";
-		reg = <0x50>;
-		vcc-supply = <&buck3_1v8>; /* EEPROM_VCC1V8 */
-		pagesize = <16>;
-		read-only;
-		size = <256>;
-
-		nvmem-layout {
-			compatible = "onie,tlv-layout";
-
-			mac-address {
-				#nvmem-cell-cells = <1>;
-			};
-
-			num-macs {
-			};
-
-			serial-number {
-			};
-		};
 	};
 };
 
 &i2c8 {
 	bootph-pre-ram;
-	pinctrl-0 = <&i2c8_cfg>;
-	pinctrl-names = "default";
-	resets = <&syscon_apbc RESET_TWSI8>;
 	status = "okay";
 
 	pmic@41 {
@@ -125,130 +98,43 @@
 			buck1 {
 				bootph-pre-ram;
 				regulator-name = "vdd_core";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3450000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
-			};
-
-			buck2 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3450000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
 			};
 
 			buck3_1v8: buck3 {
 				bootph-pre-ram;
 				regulator-name = "vdd_1v8";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
-			};
-
-			buck4 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
-			};
-
-			buck5 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3450000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
-			};
-
-			buck6 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3450000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
 			};
 
 			aldo1 {
 				bootph-pre-ram;
 				regulator-name = "vdd_1v8_mmc";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-			};
-
-			aldo2 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			aldo3 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
 			};
 
-			aldo4 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			dldo1 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-			};
-
-			dldo2 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			dldo3 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			dldo4 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-always-on;
-			};
-
-			dldo5 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			dldo6 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-always-on;
-			};
-
-			dldo7 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
 		};
 	};
 };
 
 &qspi {
 	bootph-pre-ram;
-	pinctrl-names = "default";
-	pinctrl-0 = <&qspi_cfg>;
 	status = "okay";
 
 	flash@0 {
 		bootph-pre-ram;
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <26500000>;
-		m25p,fast-read;
-		broken-flash-reset;
 		status = "okay";
 	};
 };
 
+&emmc {
+	bootph-pre-ram;
+	max-frequency = <204800000>;
+};
+
+&sdhci0 {
+	bootph-pre-ram;
+	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+	max-frequency = <204800000>;
+};
+
 &binman {
 	u-boot-spl-ddr {
 		type = "section";

-- 
2.51.0

