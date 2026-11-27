Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88877606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VV6iGysB;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=csQ7927B
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62BAC81184;
	Fri, 27 Nov 2026 10:31:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q7e22CkLLphe; Fri, 27 Nov 2026 10:31:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 943EB81223
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775494;
	b=nHWLzC4RDO4yeL6f0EbZ4PFlVZw9bznM/vOQoIBAzxT8CO/DUi8xrXf9Bh1/HA8reGpk
	 Q0jX6WzCEY/HxlhdxcHzBd5doVLEPrqDtZdxEXC6hNoKxhPRLGYXWHzLF0h4KhnJJmNww
	 G+hsFar9asHGY4ye3w0qrPfnXtWDumsx/heSVeF57voMYg6N69esal7rFkOuLek11tNoq
	 JJzQHvpv2IbtNmkth2LyPYuLKbYEqgakrnFpCZUcwLWSoNsBb/31XeByjkqzkm4wPtkEM
	 9+3Pshfg5h2BqhmDcMO/UYk805Yw6yziRgw48MY5zZ02q+T1fLpk0ElPG4f/U66V3iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775494;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HlK6xZ7AgzYg0QevBQAgrSjuZfMDjrPgUKoyqvPAdFY=;
	b=Mxw2tprzf57rI/v4t3lGZuOaImMvotA3m6O6ybt7DGf4WMv5xSbM9DMGB9EzCNcWtOtt
	 XQTvnk20OMbEtKv2QasAFTGCDHZMFPJQf0N3WPI4dlXzFMjD7HTHvjARALcYbDjdGRj4g
	 zWB/1zcVE5gFKEZ4kRLD8RsY5w6cXl3+cqnrbYv6Bq7fbPeZ3E7CCqtdpm6iG0DQ7qUfL
	 fKhneeCaUH6nuYHuYIDa/2AeC+mltM4kt9wQ9U1gMSmddrW5RHx8JA5pQCfXAzWUfHe6t
	 w1xSLAx8CmzbKt3CVEBg9QAuVJqrT+tWz6LkfT5NM4I0DbPspL2r9ydwIyMlZgCmzJQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775494;
	bh=HlK6xZ7AgzYg0QevBQAgrSjuZfMDjrPgUKoyqvPAdFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VV6iGysBRGifwO6VUx3DZfQ3SGVj0UnzHPk0SRmqPX6MgYTw2sjoNgx7HM62YveUe
	 zd7BaXOvkWC1oYWbkTATNC0W3o4bOgs+5MfrySE8ATJMoMyZdDG4hLGdLHeFUOL9NT
	 eZSkMYgu7VYPTio+ZZjc67BawB6FjpY5MNm7siYAujuCiGGunS687co0VShGTKvcto
	 0Gs8nm+D9LMupLXFAvuN29LZVGfEICdeRm5nF8ABebrevG1fijzO3RHAnbOVH5XmIF
	 BkstR4rEtALzQ9BMqoMvgF7QamdlkEYrtGg7Uztxs8RC5dQhed2ACbxhpIJNq0rij5
	 nvfdTRbx5pKYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 943EB81223;
	Fri, 27 Nov 2026 10:31:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B2A42BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D53C4008B
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oyGKMy01WW5l for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:31:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9D0614004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1232; helo=mail-dl1-x1232.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=csQ7927B
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com
 [IPv6:2607:f8b0:4864:20::1232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D0614004D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:31 +0000 (UTC)
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-1b5786e099cso6760514c88.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 02:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775490; x=1796380290;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HlK6xZ7AgzYg0QevBQAgrSjuZfMDjrPgUKoyqvPAdFY=;
 b=csQ7927B6K/e8p2uy97MAkWJKzULKJKLvCXTEnF7vyUHC5ucMKMup8ZbpAPwpZoBY+
 UHUt7ibxXm6Co7ivJJXnlw9eFQFf8HpM4M1W5y8CmixsS7ktSRdh8sDZBE3Qotq/VOQe
 8FQQ1/pxyFPNQxxkB96sp7O+mJQUS/7643Z8uA24V3OYzVFdjv50GL9hYE9gG+0gDYfv
 DM2bZKXPY4pyIJSmZ56WoQdYVnlTg8azTv+TLS++E4K9nSeZ3jiz3wdLPxohLdWHbLJV
 7b3ZMjORaaVBi5KNcYOc2BGJogyEMmJPD9mME+PZjG1MOBZfSJ/HBbIVyXBkwsKq303w
 wA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775490; x=1796380290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HlK6xZ7AgzYg0QevBQAgrSjuZfMDjrPgUKoyqvPAdFY=;
 b=1Ttk5bgJvxGcUBImkW6RLVoPkoWAWCba1B/72mfdQYuN54Lfj/1kWaNOebHctMpzfD
 7A+auLVLNSQX3rT07fOeP60cf1HFlwwvMd0IhplRvb2heeSyd2xMmFWXutweLEG+IFd5
 Hh9Vd4Wu9jfCkRm60Id07LO5AmvrqYQM1Ry7/GW2Bb2HOkN//+EHCMtuV1wEQ30BEoS8
 DjUTMK7nxpZ4cjYFquxuinCVKxbSRGXlTx+7GqDpDU8HqMsToAR4yuR+sOKU2+kmrWWs
 pna5XqhtduOG97R/bJYqdW5DL6yKbq/M6yqeMAjZkLS5PqP4riMKRbVl7TZ5lmDxnK8V
 h2Kw==
X-Gm-Message-State: APuU4Z8IxuFer+6RM9o9gBPB+WfxwPc1SHqaNAEcCUYW0Wh2WKstWW7E
 b1GVSURO0gfqTUiC6Bd6CyOto449UOm4x79+z2QYVW9+kP051LOFIGa6DSVkBA==
X-Gm-Gg: AZFdTZfguGfF7AbnKU9+VHTTMS5350iyzVg5hM1iVd+gzC0VXB/4tjs0qEDFMoGyU/+
 WUHiEtZREKTaUsalS2n6ZQP70XZjKkc0aeSwEVRM5tbnBz0XrC0E3iiprXK0yheduZXpeA0qyMX
 jRID9L52LHCzoNfNjKnzTndQO7NXvKyTtJD7iTYZUacpXMmcBWB998s02NeRzAPyIbG4Waiu0HO
 tyeeRUmEfrejqtM2d1EDsQGWNwxYhVLAleToPkePZMB610qqqLV7s4ppBPHgHkGbrFEV9A1aDcS
 HMmAqCscvzBSxA6QXtJvgZ+u82S/gCoKgNC2TrvhFjszabZyx/5cLxTRHUXc7aOYHuy/moCRmFR
 0IBb5/BDAACQAk1IWyCG6qSJzyC559wSx4kSyrKs0gBG7QMb/UEkc9Fs63vbL0OFAeDvaQD6aNs
 2KJYxfhG6uLyNzsiqy5n5Vv66v5DjZxcKnp1wINiyP13DlhZgFIjKeEn1+QZX306Vs5a9jVgxAO
 Oultp9qnbI9vM8esaQakbLBwNVwukMxL7kfTgx5Ua/PVyII0BhI+X/0zcO/b4BnnX8UXh/an5g1
 fE1jumDR34WNzeJt+npkHk+yHWqt
X-Received: by 2002:a05:7301:6192:10b0:386:a7f2:88e2 with SMTP id
 5a478bee46e88-386a7f28967mr16942613eec.23.1795775490446; 
 Fri, 27 Nov 2026 02:31:30 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm63369991eec.8.2026.11.27.02.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:31:29 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io
Subject: [PATCH v3 03/13] riscv: dts: spacemit: k1: Move common U-Boot
 properties to shared DTSI
Date: Fri, 27 Nov 2026 10:30:02 +0000
Message-ID: <20261127103030.4647-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127103030.4647-1-linux.amoon@gmail.com>
References: <20261127103030.4647-1-linux.amoon@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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

