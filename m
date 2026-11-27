Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FEF606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X/XpbL/M;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UAYYnjDG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D8BF409C1;
	Fri, 27 Nov 2026 10:31:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zKMooUy5AUtW; Fri, 27 Nov 2026 10:31:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 654ED40A3C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775480;
	b=Q5j+r4k/ER+7gSEoPt3xWh3meI+SBFf0vyxTMWTRqqG/3c5hMova+SWjbtnDaRkmwfjd
	 OPSS/uXjvy+XAPc78HLdZhd3G3Vm7w+VAB/EKwDnSS+AUoVPOjRLb3c/aJG3soXvZMJoA
	 qKlxu2UM0FzlpPixtRNbvod0Mu/uAcapetdOEQUiRxKuoMqycGjKfN84kVt+9uMEir9mD
	 y59DX8+IU9vAdZAHDRISEHVIo92GT8QxmH9whjj+iciKA5+GcZiref5djczzzCN3XVdxg
	 /4S6787Nl2PlhCTcm5R3jTmlQl+LU+CeDZejA5CmS8pg0uRVaBKcnr1qt7OMSAR/U/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775480;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4FVINPkoeDOvqeX0WNeCjCssu3PBPagsQXD5swOREbE=;
	b=kQHN2mXA7P8dZpJLFnJfg24hU0YX3/75JvH+DIaVwPcOFb9/AmSFt4YXtLX2FT9W/Fgf
	 7eM5G/rFi5u+AaB9Tg/9olwxm2cZHPrxGh0FrrMC7oBpi6aL6vn6fqhYvwpTKRILOSZ1H
	 lS/B9r7323ZT9P9ruKTgPAgjm0TfFcGw53c6xh0WvIBa0SWcASRo8Z7PWu0KDLe0n59XT
	 EYZ34RCCY62xXZaE15olutamLo8n7hHV0BuC4Cxr7kUVhfC3iiAz1OAlv0aFjua8QGcNW
	 6kwaZ5dFpn9/nIuo4ngsH/jS4kBc4mrY0FdIOqGgmXkQ57qkYhwBfVNwKrZ4oD5Wvtg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UAYYnjDG;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775480;
	bh=4FVINPkoeDOvqeX0WNeCjCssu3PBPagsQXD5swOREbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X/XpbL/MM7G7hoJdD+gyLBSfA0kAAa0tM7BuObOjtWwlIh2/P4+Kt9ZaMB3AyQ/gE
	 0ccayoN96eehFgvS0Gn4l8+Fcvj9HHw5fpfBBfiChpKK+7w+eDaky4J8NnYYcbD5N5
	 PnS3kjeI0KUEo1pzNifDuDCZVIGczY2LzXuFLlzhSxDwsfv8quy2yqt1wRc2TX5bNa
	 5vxv07avWQwjO7txsopP7JKzhuvU3SarPCUXIWfp6VuE757fUMI7Wh1YoqqPyGDjZC
	 HtN12YwAD18Z+BnJFwoFRCMtys+F28DhRQ/NjXViIBqEvVOgOWK5BLb8Lc108zOwyB
	 0aRLiTSqJs5kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 654ED40A3C;
	Fri, 27 Nov 2026 10:31:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D7C892BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D554140963
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bMRl72hXny-A for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:31:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1255540934
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=UAYYnjDG
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com
 [IPv6:2607:f8b0:4864:20::122f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1255540934
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:17 +0000 (UTC)
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-1b3a05f8b5bso10829754c88.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 02:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775477; x=1796380277;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4FVINPkoeDOvqeX0WNeCjCssu3PBPagsQXD5swOREbE=;
 b=UAYYnjDGPVqETkLomEiDgVWnLZcpP8HMOs3MabNf2TIDt8Dm04651LR7rvVRh7aw1r
 JMkQdbge0FCY6hwdksk3mMt7M3bkqdFTsiYg397xUqNS/PfFTXm4ZIf6rseoJKj10AL9
 MIg2QSDBD3bkJJk+jlGjILOxrRIekCAiDVUKq+v8zuUZBrzNrLnJdv8vMsAOZoWTu6zw
 c9S3InwTh/RAoIaE2yLhcyqPgZXWct/Uyu/LMs7YO5a8qdMCp26bE0rFUV1HM+wQXvFY
 Qtmju88O/L4K7mVs+GXtcP5Smzz8QkrAIl+vZPOYLd261h/16ZEuK01s88F6UXA7aEsj
 NUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775477; x=1796380277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4FVINPkoeDOvqeX0WNeCjCssu3PBPagsQXD5swOREbE=;
 b=PEvKfVxV5oZvNrPma/TuUkuaQ42XLD+tY5zpcJpp1Mepx2ONUR6Hzg1ZoB+LnnGqHL
 JYXCSa5qUQvIs+t0xLGjs1saay8ZHSFTh5bSna/msOUJVB27eSX4kjzhuknU2Alh6qKC
 1FaEaXu2i5Qqi9ki4kCWVqpfDqu3edLdwVbmTpxg0BlsJel5A0IlJRLBjLktpvPxz67F
 o8m2oy2LdWMhAm5TJdEzh9RlVeTMp0mx61gU7nyPer/tlqC3KEZpSSxhGlXg4tFWMyyw
 BhRyrbmVawahd3xq1WpdZLihsNlpD6wN5FHRFj5otUtmXEvgOUHWeD+Zvi6Asm4P03nM
 +Ncw==
X-Gm-Message-State: APuU4Z+/mJ5DkqfEFoBrqwcFU1qMogDbO9lBkxI6TnHBvm/N3dgT9iut
 WfTUsZjS46jTt/xATF7aiJbSNRdDjKaYDhV0Pa/6Sg+1mi8HwAfzkzVajSd7GQ==
X-Gm-Gg: AZFdTZcCfSaAfKtb/7VRS7QfxW8Hpr3QyEJMFozCZOPcWcjxZyGOta0BmcOQjOr/sAt
 cSpzxe9uAgtklxjFS7KtSvF17ktE8Ld7GmQRnaxVgwCJgB9XesJYnpXkXt9vegtnnmzWwDYOSZs
 XbnakrQ36Jwty9idOJPjOrokWMRzbm8XifH71haPOEjyB2iTRNYgsMZe2Gb7ukzOrtxYnA8vXNm
 4JCFto8Fr8+raxT9qe/bN2UL6zkD5wzxkkM77LBFVeGv5UxrUKcQaxwv2pmQKCxYbPRGLMipjW5
 x9w2XSxXRII+PthHQqNsw0ggQjAIFPuQYko4h29X6AXtxga0YQtlTwt9sza6heRbkZFYWb9zy+y
 JjZ0rvhUK7K3awnnKyUJWeHE0DUHyaJizrnHOeUh60lF5WXeC7gaWMB+K/hUJFogL9JiYN2L0sW
 15vRSnT2mdEmewAEewZXBvomTUtkaSXLUq1WxdYrTg5wd2Arj/nOJqLZ3rZcRiRIzXEJSNSfK04
 xmsMDGBSMwm4blgSFaCPfWVy12OxNwDxoNC4wXMtPSE2AGPeCOpT4CCbNPCiJc6tQj5oB5qt4eY
 mi0XbWq2lzx3UHqIJbXvIb4Hf4M2kg==
X-Received: by 2002:a05:701a:815a:20b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-1b556695bf9mr21949150c88.0.1795775476775; 
 Fri, 27 Nov 2026 02:31:16 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm63369991eec.8.2026.11.27.02.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:31:16 -0800 (PST)
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
Subject: [PATCH v3 01/13] riscv: dts: spacemit: k1: Move common U-Boot nodes
 to shared DTSI
Date: Fri, 27 Nov 2026 10:30:00 +0000
Message-ID: <20261127103030.4647-2-linux.amoon@gmail.com>
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

