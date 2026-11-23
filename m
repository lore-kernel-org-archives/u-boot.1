Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9A606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fToFyfQn;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UyHQpQR1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D22B980E38;
	Mon, 23 Nov 2026 19:37:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aiemTBHjiwrz; Mon, 23 Nov 2026 19:37:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E708A80E3A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795462662;
	b=oFhAbev9MJx3AlcGvju96ksdK7emqKHTBbI3eFCSKSv8ReqYpS86mn6bKq+L4N2Nu29h
	 eq2KfmhAD9heLQjeqJdfnRmJEbMjGDzGTlE/fGKNdtzh1QVoQ9haHCHlTFy3eZdi306f0
	 jZw8VH8E44uX81bGBqW+kMSoCwrVt5LjEKA9kCeGFQ+I6LyNfIUmNheGr3ELhk2MqVsst
	 vvNjPej5bN7PJLlWMh/38QAlXzcN6ipywM1gNX5UpnYEqLLnmaCCwwWJtfdkd9e3TPH3O
	 QnIMHIFzUBmanzOB33kZ8EYszV8p5rcmkYn9VN1zQkcN/2Yuy4vnterFSKktuv2t5FQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462662;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4FVINPkoeDOvqeX0WNeCjCssu3PBPagsQXD5swOREbE=;
	b=rrtIVnh1yH9H7YlXhVAFqoqQLl1lYP2hFV/a5xU8wi8AsorA3HPSf3GCHSGnSag8T17J
	 +Vksb9ApYFRWyAzOOrs8hwF7SCqQ9AXVIKuJQKCTAzoF2DIA3cxGVaQtuk349iLazssQa
	 DwyjJbjTNAl7valGUAV0cHhu/NlV8CwKFJFw42jn59/QTm8c+yAODebhLi8qQgFYowQUd
	 6pMaVN9GnhaNn/48odwmP0iridj62M1q9IIeHDa7EnBtPv8VAbdtNVdug2KpDZ1L1pZjK
	 4NDsmy4dLGZ/xhAFn+CyTmbdvmd1OlN3rxyazKWDlh7PqYpynetq4HkxJrgO46SVVyg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795462662;
	bh=4FVINPkoeDOvqeX0WNeCjCssu3PBPagsQXD5swOREbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fToFyfQn72ZDTydb2VsqiuZxN3BBm31B02g6s7zQ/yhuKRSWcp6MmunHuOmTzjIV8
	 GCbb755/KjaUvgPN9roxnYlESzqltbCKkF+aN3THk3k8Zulxp2oG7qxFyw31mMOh7J
	 2bCpxJ0NQO34BLXkRTc0fialaXePnxfXQRNbUAVxfEpM+JuxZ9Eh7d2nH9L/uiVPFU
	 ywnY/vOqYsl4je+ph6uf7eY92t/+oRmlZ5QAMGzOwxSp1gLzEejS/UzwbgtUUoqHfn
	 kQQRhb9RNgTogS0oJlomkUQH2+QuyN3CWGwDTp6gDkSLGLPComTEWGwnZJ6agpSTr0
	 B4SdgZ6HQPljw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E708A80E3A;
	Mon, 23 Nov 2026 19:37:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EAB063A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC7A360663
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:37:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wFDwJVZhe8Wj for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 19:37:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 18BBA605F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=UyHQpQR1
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18BBA605F7
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:37:39 +0000 (UTC)
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-38587f3de36so4452245eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795462659; x=1796067459;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4FVINPkoeDOvqeX0WNeCjCssu3PBPagsQXD5swOREbE=;
 b=UyHQpQR1LN25gvP0hBPr2XCpPwZYuT3A4AGVIPE0JeKi0NFmbXg2cS/VfEDtCcqaSK
 HzLrYn+UtEEA94oTGH0oKdbvmmGVQLbC7cL9Qn/kMzUYl/8/7U49lxtn1ZKSbuWPADod
 +JDh1mp+7/98OwU0Im+OV+dVupieqDJK4MSPhXQ/BTTzB0Pn5oLqnmoNgjDug0D1Er3x
 lN6MH6d18rmSJkqv9FM6kyr++ZFyLu75coHk20EtDXHu2hfw3oALKMYh4d8VU5KLk7l3
 sQ0ggAzwMIoJKIpn42KIQnY7Ij57dHSjZwAinbNuFpm09Aj5hEpCBpVwjtKtErXOQ1L8
 R0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795462659; x=1796067459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4FVINPkoeDOvqeX0WNeCjCssu3PBPagsQXD5swOREbE=;
 b=DZsxrmcNG3DrBp+1xkIiX2YEPViN8VgUb6lr6Q1NtrmqBVbvNyC7SuItCb+jat6KUG
 ru2ojn5Pem3YIagRMb1je2NhBX+c2MGkHdcLQPrHhiFVrpKUD6NTKRzQwsXu3yQaARuk
 eqoUyE/5Vgv6wRVZYcHRfdSzOCl7sYNm8T0gEXZquZCs89qnwLgytzJMhIf5jP+ESwCo
 oRxTBNyEb64u0FCo3Zc9uAIwadjIPYizWmof1gWfXDfgAMfMxwHmUqGRLM+pUNulgQIt
 qvabt6RDS6a1Yx4HquwN8uk9mv4zsCzc8V2dCbE5/IT4kyJ6BT3lHavpnMh1rsJMq4II
 +w+A==
X-Gm-Message-State: APuU4Z933iZmkcdAAp8FKGFKpfv9JDcij4rsnUvMfVt6msfnnSrW/slW
 VyFJUhJSS3cKjc8onJ6wftXbHQc1hBAxrjN0Y0IKwjFM6jWChBE8iPw0sGvhtw==
X-Gm-Gg: AZFdTZcLBePgjzrrNpxy1WmaJy77GwMck8lNWSDUZ35qp1/SX6VlIS0x3Mj3sYC7ciL
 3sUyuPgFZbyjVQ+Epv53FpgDsjU4J+Lyd4jtf01+BktMSO0K9CwqgxinyuKH6z+6TRA8gQZ7a8W
 UgLXIRJpkPbx+7JP9n+LIdXO9Uhkj4OzTwSMDNXFJ7XqtuJhR7/RCEBTR/OsQ3Wz3DQTwJC4pIF
 /idoXgZ5rEP0+PGPhLhp5yyVlumW43hf8Zotgnx4s5ZE6UjaPpMOGTjG0wURm7aPKjDhrqhAeJj
 n2JNxLTbeurpdY4gqsOKvBRlS7b/J3vvMNI9gtv68wtVv0VnRtAYyR4MW6xAFK1X5+kz8MbyYg2
 dm1OGJMHV/dw06/yqPEeTxMW9InUQnp8GvQ00qFX9LGjsiJXRCaSPpveVZSV/2t6tg3CWYmXU+6
 PXmT1nqUhX1e5v1N3qm1EFYOA5QrwpUF0jphKkn1Pn18j6lRwIN5ANn42V/WwxnRrrPF4XABKK9
 +Oi8vhK7uzwWvok18v0mvtctQYJfcJEaLqXIyUIaJ3GPDi7tIE08EnSAWRHNtYfhJNMsXl2wpQ0
 X7SPDaEd2zPlrG0hTuILgAOG7w076Q==
X-Received: by 2002:a05:693c:37c8:b0:386:a0d1:1b41 with SMTP id
 5a478bee46e88-386a0d136aemr12202740eec.34.1795462658756; 
 Mon, 23 Nov 2026 11:37:38 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c0c1dsm41796268eec.21.2026.11.23.11.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 11:37:36 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io
Subject: [PATCH v2 1/6] riscv: dts: spacemit: k1: Move common U-Boot nodes to
 shared DTSI
Date: Mon, 23 Nov 2026 19:36:59 +0000
Message-ID: <20261123193714.5096-2-linux.amoon@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Banana Pi BPI-F3 and MusePi Pro U-Boot device trees contain
identical Binman descriptions and memory node overrides.

Move the Binman description into spacemit-k1-binman.dtsi and the
memory override into spacemit-k1-u-boot.dtsi.

Include the common U-Boot device tree through DEVICE_TREE_INCLUDES
to avoid duplicating these definitions in the board-specific files.

This is a device tree reorganization with no intended functional
changes.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 32 -----------------------
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 29 --------------------
 arch/riscv/dts/spacemit-k1-binman.dtsi    | 29 ++++++++++++++++++++
 arch/riscv/dts/spacemit-k1-u-boot.dtsi    | 13 +++++++++
 configs/spacemit_k1_defconfig             |  1 +
 5 files changed, 43 insertions(+), 61 deletions(-)
 create mode 100644 arch/riscv/dts/spacemit-k1-binman.dtsi
 create mode 100644 arch/riscv/dts/spacemit-k1-u-boot.dtsi

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 36c1bfc12fb..bc117f5987a 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -3,15 +3,6 @@
  * Copyright (C) 2026 RISCstar Ltd.
  */
 
-#include "binman.dtsi"
-
-/ {
-	memory@0 {
-		device_type = "memory";
-		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
-	};
-};
-
 &uart0 {
 	bootph-pre-ram;
 };
@@ -96,26 +87,3 @@
 	bootph-pre-ram;
 	max-frequency = <204800000>;
 };
-
-&binman {
-	u-boot-spl-ddr {
-		type = "section";
-		filename = "u-boot-spl-ddr.bin";
-		pad-byte = <0xff>;
-
-		u-boot-spl {
-		};
-
-		ddr-fw {
-			type = "blob";
-			filename = "ddr_fw.bin";
-			align = <64>;
-		};
-
-		u-boot-any {
-			type = "section";
-			size = <0>;
-			offset = <0>;
-		};
-	};
-};
diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
index f2688a1868f..03cfed10521 100644
--- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
+++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
@@ -4,7 +4,6 @@
  */
 
 #include <dt-bindings/clock/spacemit,k1-syscon.h>
-#include "binman.dtsi"
 
 / {
 	aliases {
@@ -15,11 +14,6 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
-	};
 };
 
 &syscon_mpmu {
@@ -133,26 +127,3 @@
 	bootph-pre-ram;
 	max-frequency = <204800000>;
 };
-
-&binman {
-	u-boot-spl-ddr {
-		type = "section";
-		filename = "u-boot-spl-ddr.bin";
-		pad-byte = <0xff>;
-
-		u-boot-spl {
-		};
-
-		ddr-fw {
-			type = "blob";
-			filename = "ddr_fw.bin";
-			align = <64>;
-		};
-
-		u-boot-any {
-			type = "section";
-			size = <0>;
-			offset = <0>;
-		};
-	};
-};
diff --git a/arch/riscv/dts/spacemit-k1-binman.dtsi b/arch/riscv/dts/spacemit-k1-binman.dtsi
new file mode 100644
index 00000000000..2ff6bd2cc43
--- /dev/null
+++ b/arch/riscv/dts/spacemit-k1-binman.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2026 RISCstar Ltd.
+ */
+
+#include "binman.dtsi"
+
+&binman {
+	u-boot-spl-ddr {
+		type = "section";
+		filename = "u-boot-spl-ddr.bin";
+		pad-byte = <0xff>;
+
+		u-boot-spl {
+		};
+
+		ddr-fw {
+			type = "blob";
+			filename = "ddr_fw.bin";
+			align = <64>;
+		};
+
+		u-boot-any {
+			type = "section";
+			size = <0>;
+			offset = <0>;
+		};
+	};
+};
diff --git a/arch/riscv/dts/spacemit-k1-u-boot.dtsi b/arch/riscv/dts/spacemit-k1-u-boot.dtsi
new file mode 100644
index 00000000000..0d92edf9fc1
--- /dev/null
+++ b/arch/riscv/dts/spacemit-k1-u-boot.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2026 RISCstar Ltd.
+ */
+
+/ {
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
+	};
+};
+
+#include "spacemit-k1-binman.dtsi"
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index d9cb6c8cebc..0f6e9284259 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -66,6 +66,7 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_UPSTREAM=y
+CONFIG_DEVICE_TREE_INCLUDES="spacemit-k1-u-boot.dtsi"
 CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
-- 
2.56.1

