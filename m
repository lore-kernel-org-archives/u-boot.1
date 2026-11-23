Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13090606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tFL53tjW;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wvTwsujp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5BD44071D;
	Mon, 23 Nov 2026 19:37:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OkH_9ChwPwIf; Mon, 23 Nov 2026 19:37:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B4E840704
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795462675;
	b=gtF9//tTzb3vTgBdHrgw9kj3+DzZgYu5HZuTeRKw0B0BZ9mgBWk8463+MTwuvrAZOXf1
	 0jLn0/TIAmLFGyltEH8HGK5B2ykog4xOJFufjWIz3oZWleCXMnBRfp6jxQ+mp0H+6lQX6
	 zRLmwzvNj5prUT0UH7nvw7RFBwhfCaGe73on5pIPAHXsRweQpv7OIsBi3ZQOZpAC7quXY
	 wPx3th2owBHC+ZVsMUMcMeInul8L42uGI1HyxP2HsZtmM5tEtXDJDoTAa+hvhIarXp//g
	 VWACTe3HLS3t055ajYAXDbZvldQSojtIP0FCvNSkReXvu+uVWXN4+JDz3wPA5BCfBGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HlK6xZ7AgzYg0QevBQAgrSjuZfMDjrPgUKoyqvPAdFY=;
	b=kfiXFRmBvVY6WH5xCroiJYTR5lOXZc6FT143HTjE6t+ihCzA6+VSCxRjLbOoUP5A8fXq
	 O4ebsaD9vZr3QrjoUfzGVsF/e83OXz8xCIAvbU7SyluPh0WyjYVga9/+vHhPy94ksSR8/
	 1ZinHISUEAlxZwBgseEgdnpH2qP1iwLbVoj/aXRQHD3Shr6YWIGyp3JE2wREdXYmf7nhX
	 jEyX8XmJ0QoQJ1yO2XajZ0ORF2HLEkRNftfLVbtmlJ3WvN3qqj8sEdxIabZORvL5SE70e
	 /GFqysDhm5sanKnmo574fniIOBKyDOvUgJ7o1Y2UOG5az4W/A1YaPCZk1jBWqsfpJ3A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795462675;
	bh=HlK6xZ7AgzYg0QevBQAgrSjuZfMDjrPgUKoyqvPAdFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tFL53tjWIb1gI5qkQ6jMD8FvRhypX+jyYxjtWIUm0NPt+BEWh6sjXWWjZUcf2BnC1
	 /SEam9UvL8+dN6YfR5gF21fZRC7C/V2dY3Y5/tqKCKhPfA51UY8XWv7nhfjSNRWa6Q
	 jojxOlt68RDEkKzeICZ+IggTosV7f0Laaf+NS2/Xdr/WVc4Jkeg5cbsUDRAl9LCnCM
	 soBRctfm4OahRuOJg+C+lGmnJ7kstybZqRMNp/nwdKIFcZkL+/E0ZFpdXOWwrbApji
	 uFm6OapvvnW6zzHk9QztReHtICYWoLW1IqrI1hFjfRttA/mie7y8ZA1PhSoEEGJZf5
	 MOBe6vxBHHAzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B4E840704;
	Mon, 23 Nov 2026 19:37:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D4A53A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 02DD36067B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:37:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZR6Kplg_PmX7 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 19:37:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2D40B60663
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=wvTwsujp
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com
 [IPv6:2607:f8b0:4864:20::132f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D40B60663
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:37:52 +0000 (UTC)
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-3282db206d3so351179eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795462672; x=1796067472;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HlK6xZ7AgzYg0QevBQAgrSjuZfMDjrPgUKoyqvPAdFY=;
 b=wvTwsujpa19+M2Qc/935C9uuf9OyYdUB/Q8D3rCK/STSKQgdoMsz6j6Jlf5rjYm3SD
 7hsdZDw2cV7C2+dDDOmmo7Eb5u9tqHw/DAx2WmPTGD3qd4bnM+HdNjJRM0AUOusVFzRz
 r/5xF8p4LY3HfskFBu3+up2kSfGpMyAGCAECmgoZ4MuOryj9iXfMzdaGkcYbn5JiocWn
 aRbaX0I9e5WQJZ6XXucRNUWiszI7aXUe+W6DbNg+xlR89QNw+UqpD3ZhtPBBvVX/IQAx
 xMuM7hYRSpGMZPVVrYzBRbTWKrJWrSGSwf7LoYzZ4m7uQOZX8yU5IFNlnUwiQY/Zfani
 LP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795462672; x=1796067472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HlK6xZ7AgzYg0QevBQAgrSjuZfMDjrPgUKoyqvPAdFY=;
 b=wS5iOY7XhlM+MQhfCrXvOPnYI76MRMAjApNcPvq9NOC1RJjhazhHlvYhrSUUFMMTNn
 wrMAcKFx9QXUZh8Leu3XrTaezYIJORqIU84pF1EVTW504LOkL8EURVzBFFmUDwioswW9
 rBEC3IRYvU0LyiJYooCT1J2pa/iY6JZ4YrSrKy+jUKwagyFne86Pkb2ZZ3kQKMUyx8VR
 J6402Ma1lpczvloHg7jo13uaGiYJ5J7uYw7/g21gW/RIKA/yjjwOxUsjfEy6sn6tXjIN
 GsbISGHUJ1lXbbZ5mSY9bARZxfF9a2aEkjbBZcs8++Q+pXiEfHiQBF0VBeM4Dn3Xy4Ta
 rKTQ==
X-Gm-Message-State: APuU4Z+riB1zntMufWeOTqA9U9CnPtL7Q8+lKUgoNJEUXrGJhEltfm89
 tA9pFeKi7q92tVCj5UwtSIQtSp29yYxIdMftHnzd99dnBgr3YLDnUuFU1c7sUg==
X-Gm-Gg: AZFdTZessMXrjj29KAC7Q9C7Lz4qs0+zR2C8LNc4MkSQm5ijfFS4QSX85UaZ2iCswDv
 +fzKTALqcyHpBE1yII9XS7PT/GtS2aIVQjUE6WzDRBPSmROsIY4lOxSINAr88M4zg0gpsUnxjYj
 zHGy26DsfrUsuIPxjcXD25W86+sHaU4wR5Y25sTOshkfwZ4JkY93ioKggTGzm+KtVAUeIPSDC4h
 PubF+H7Mmrtz4/PttHzwjvtl7lnoYdalNf42kkyD+1NhtBGSEEFjVHfh6/ABXcmaabn5MZtmj0y
 3J6oxtmo2/p4vi7djs3YMnBxCrd5WxpZSIUkhStII9Nx7s1BbHRV/cXw1W/bZk31+E5AzIYS7Zj
 D3nucSTofe5x/5x4290P6835NROCYinxdaPUfBkBXgb/q+Jrglhceb9RUUohALFbLPvTBzHDVi9
 AOTRgJGIvPJsI3FB3lqB4uF8n10P9ha8xxuyloGXO6+CDmVBupcfTw7YBp/o4v5aXpZL/9GCJQh
 lvQrm9t6mSHE2rRugAPM19FpTtw41l4hW21KpR6RbgDK+vKAyNjDkMllubiEXcW9nNMaloCzXie
 T/tkQw7MVC57WEeCiMPqWdDrhjff
X-Received: by 2002:a05:7300:d788:b0:386:83e2:a8 with SMTP id
 5a478bee46e88-38683e2019bmr11216899eec.40.1795462671509; 
 Mon, 23 Nov 2026 11:37:51 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c0c1dsm41796268eec.21.2026.11.23.11.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 11:37:50 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io
Subject: [PATCH v2 3/6] riscv: dts: spacemit: k1: Move common U-Boot
 properties to shared DTSI
Date: Mon, 23 Nov 2026 19:37:01 +0000
Message-ID: <20261123193714.5096-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123193714.5096-1-linux.amoon@gmail.com>
References: <20261123193714.5096-1-linux.amoon@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move common U-Boot device tree properties from the Banana Pi F3
and MusePi Pro board-specific DTSI files into spacemit-k1-u-boot.dtsi.

Consolidate early boot properties for UART, clocks, I2C, eMMC and
SDHCI controllers to reduce duplication between the boards.

Also move the clock configuration for the MPMU and APBC system
controllers into the shared DTSI.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 54 ----------------
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 79 -----------------------
 arch/riscv/dts/spacemit-k1-u-boot.dtsi    | 76 ++++++++++++++++++++++
 3 files changed, 76 insertions(+), 133 deletions(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index bc117f5987a..4e9f2c13203 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -3,50 +3,6 @@
  * Copyright (C) 2026 RISCstar Ltd.
  */
 
-&uart0 {
-	bootph-pre-ram;
-};
-
-&osc_32k {
-	bootph-pre-ram;
-};
-
-&vctcxo_1m {
-	bootph-pre-ram;
-};
-
-&vctcxo_3m {
-	bootph-pre-ram;
-};
-
-&vctcxo_24m {
-	bootph-pre-ram;
-};
-
-&syscon_mpmu {
-	bootph-pre-ram;
-};
-
-&pll {
-	bootph-pre-ram;
-};
-
-&syscon_apmu {
-	bootph-pre-ram;
-};
-
-&syscon_apbc {
-	bootph-pre-ram;
-};
-
-&i2c2 {
-	bootph-pre-ram;
-
-	eeprom@50 {
-		bootph-pre-ram;
-	};
-};
-
 /*
  * The kernel pmic@41 nodes use the standard regulator-* properties only.
  * The SPL board code looks up the bucks that DDR training depends on by
@@ -77,13 +33,3 @@
 		};
 	};
 };
-
-&emmc {
-	bootph-pre-ram;
-	max-frequency = <204800000>;
-};
-
-&sdhci0 {
-	bootph-pre-ram;
-	max-frequency = <204800000>;
-};
diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
index ddea04a8e3e..834d9f46b48 100644
--- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
+++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
@@ -3,75 +3,6 @@
  * Copyright (C) 2026 RISCstar Ltd.
  */
 
-#include <dt-bindings/clock/spacemit,k1-syscon.h>
-
-/ {
-	aliases {
-		console = &uart0;
-	};
-};
-
-&syscon_mpmu {
-	clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>, <&vctcxo_24m>,
-		 <&pll CLK_PLL1_D4>;
-	clock-names = "osc", "vctcxo_1m", "vctcxo_3m", "vctcxo_24m",
-		      "pll1_d4";
-};
-
-&syscon_apbc {
-	clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>, <&vctcxo_24m>,
-		 <&pll CLK_PLL1_D4>,
-		 <&syscon_mpmu CLK_PLL1_31P5>,
-		 <&syscon_apmu CLK_PMUA_ACLK>;
-	clock-names = "osc", "vctcxo_1m", "vctcxo_3m", "vctcxo_24m",
-		      "pll1_d4", "pll1_d78_31p5", "pmua_aclk";
-};
-
-&uart0 {
-	bootph-pre-ram;
-};
-
-&osc_32k {
-	bootph-pre-ram;
-};
-
-&vctcxo_1m {
-	bootph-pre-ram;
-};
-
-&vctcxo_3m {
-	bootph-pre-ram;
-};
-
-&vctcxo_24m {
-	bootph-pre-ram;
-};
-
-&syscon_mpmu {
-	bootph-pre-ram;
-};
-
-&pll {
-	bootph-pre-ram;
-};
-
-&syscon_apmu {
-	bootph-pre-ram;
-};
-
-&syscon_apbc {
-	bootph-pre-ram;
-};
-
-&i2c2 {
-	bootph-pre-ram;
-
-	eeprom@50 {
-		bootph-pre-ram;
-		status = "okay";
-	};
-};
-
 &i2c8 {
 	bootph-pre-ram;
 	status = "okay";
@@ -112,13 +43,3 @@
 		status = "okay";
 	};
 };
-
-&emmc {
-	bootph-pre-ram;
-	max-frequency = <204800000>;
-};
-
-&sdhci0 {
-	bootph-pre-ram;
-	max-frequency = <204800000>;
-};
diff --git a/arch/riscv/dts/spacemit-k1-u-boot.dtsi b/arch/riscv/dts/spacemit-k1-u-boot.dtsi
index 0d92edf9fc1..c084e15cb94 100644
--- a/arch/riscv/dts/spacemit-k1-u-boot.dtsi
+++ b/arch/riscv/dts/spacemit-k1-u-boot.dtsi
@@ -3,11 +3,87 @@
  * Copyright (C) 2026 RISCstar Ltd.
  */
 
+#include <dt-bindings/clock/spacemit,k1-syscon.h>
+
 / {
 	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
 	};
+
+	aliases {
+		console = &uart0;
+	};
+};
+
+&syscon_mpmu {
+	clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>, <&vctcxo_24m>,
+		 <&pll CLK_PLL1_D4>;
+	clock-names = "osc", "vctcxo_1m", "vctcxo_3m", "vctcxo_24m",
+		      "pll1_d4";
+};
+
+&syscon_apbc {
+	clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>, <&vctcxo_24m>,
+		 <&pll CLK_PLL1_D4>,
+		 <&syscon_mpmu CLK_PLL1_31P5>,
+		 <&syscon_apmu CLK_PMUA_ACLK>;
+	clock-names = "osc", "vctcxo_1m", "vctcxo_3m", "vctcxo_24m",
+		      "pll1_d4", "pll1_d78_31p5", "pmua_aclk";
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&osc_32k {
+	bootph-pre-ram;
+};
+
+&vctcxo_1m {
+	bootph-pre-ram;
+};
+
+&vctcxo_3m {
+	bootph-pre-ram;
+};
+
+&vctcxo_24m {
+	bootph-pre-ram;
+};
+
+&syscon_mpmu {
+	bootph-pre-ram;
+};
+
+&pll {
+	bootph-pre-ram;
+};
+
+&syscon_apmu {
+	bootph-pre-ram;
+};
+
+&syscon_apbc {
+	bootph-pre-ram;
+};
+
+&i2c2 {
+	bootph-pre-ram;
+
+	eeprom@50 {
+		bootph-pre-ram;
+	};
+};
+
+&emmc {
+	bootph-pre-ram;
+	max-frequency = <204800000>;
+};
+
+&sdhci0 {
+	bootph-pre-ram;
+	max-frequency = <204800000>;
 };
 
 #include "spacemit-k1-binman.dtsi"
-- 
2.56.1

