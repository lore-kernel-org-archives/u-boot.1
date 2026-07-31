Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60D7C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 00:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FBEF607AF;
	Fri, 31 Jul 2026 00:15:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbItboWCI-tf; Fri, 31 Jul 2026 00:15:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1449606C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785456942;
	bh=5Uhwz4xurQbVorssRQqOhWhN5n0Hdkkv0q/MTks7zuM=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=nMbGU/WBZQxvTGL7gIwXdlYBisMjEOn24QTg2NKZPP+qmY8kysJqlEe7RMvUDv0Nh
	 1nKQubjw+ZTzpgBayTN4bJY4IvBS342Egj7LpfnJdSFz83GhViXqU7dlPzlf2H3tcd
	 eMUbE9y/UtQ7aAFxzxw0RinNWIWhV0gPbfV9MbrGQpt9ShkRNEpf0RCjJMoXAghEa8
	 JmQjBMhobdlp59T5tLw6tQEc5p503g7TE04DEurZ8sz3AtWSaDbOt6KqrfmYl6dv2L
	 xTuW50UMkZn/t8BHF7vBTGrKQiQ+U0en5R7PTLe2axO+VJpVXh67InMoeIicicTbN6
	 n3hVag58aFnVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1449606C2;
	Fri, 31 Jul 2026 00:15:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BC12C218
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A21AA40CCA
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u-I5mVbEwmQT for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 00:14:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9637540D82
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9637540D82
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9637540D82
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:44 +0000 (UTC)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A00923F9AB
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:42 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8484f26852dso454717b3a.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456881; x=1786061681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Uhwz4xurQbVorssRQqOhWhN5n0Hdkkv0q/MTks7zuM=;
 b=bldP7ooX1m+C5vd9uEMHpMZ90lQkNU7V57FgvlRaHbPFgfmtB5IvStq13AtMEy2BJd
 euEwHvs1Hzeh2huCY61J6fMsZ0DrL0a0Ra8hDxxgqYYyprKRgvyBtcZmrfg9w1Z3JUt5
 1mulog6Sq4TZ+v9kSJtVLERoAwUPC05f8KO+y88tM+MZ7lOA5F/FGqAm63uBovkj72d2
 h6UDbIhAaXjVofVyPIeEknMTD634AeKiR7wfhoD4L7bwuBNsbJ/HOyZeoSsZJhuBo8UN
 IAuEsKjHoZYc/g1ihgpE2RhArY2xD0kKfHTbZUHaVqjSpHVBiSUJXtvTxBRxGLX/sSSD
 cGkA==
X-Gm-Message-State: AOJu0YxAbH6nZeIQWW/xiMbd3sKl+yziQC/L9SCSso2/mfyqIOevXw58
 RUJtZSEgaQP2hFF9tlLcO+Mmr/4Yz1UWIB2sTGdxXJSE9iU10Av/0/kTSBM459bl5cq4NKfGn3O
 XcEl92pDA/y1/P91kVi27oabit3sA755DKzgbKbIw4YXYfpO2yaT+7iI9enSlr7Gavcsy/UOI6G
 RJvw7NffU8SA==
X-Gm-Gg: AR+sD12Yi3jU6dk1iCZP4X1qAP+qHgN3FnhGPbVABTdCHaki0bwRQnKgpyC0mJRTxX6
 k0tnpb+OP4D/7aInqSHGEUJEFOg26KtRX4fAVB2cH+cvrHMnBHEfXsb72plfz4tl+WL/Q7i/hAZ
 nOHLMl5H1XWPC5zOJTipa5f8ZTbNtGM8HOiUL3BUT1g8rceknRuwE5uMqEhXBz8MzRUVTkwdO12
 +gkbAU2Rp9XjxjLMH+JT+KCoRkYxAbmKIp89GrnwF9vVQ/Z5ZTJ3H1DCmW10da2ruGKKhDIqyZL
 eaU5fgfXgUbAhhH4bLDRWozF+AJIh+WaKhlFEkFplt0bBucfGMMruFmf4Gx2MdSi7w9wKEXbGbM
 6WparOJC00ExoxFNNaab7R9ML1i1TsH3IKqIIQMzhfzZMy2C7q0YQk71FZKp5oMyilkobSw==
X-Received: by 2002:a05:6a00:1256:b0:82d:62ed:b01d with SMTP id
 d2e1a72fcca58-84ebc3eb31amr4249013b3a.45.1785456881121; 
 Thu, 30 Jul 2026 17:14:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:1256:b0:82d:62ed:b01d with SMTP id
 d2e1a72fcca58-84ebc3eb31amr4248993b3a.45.1785456880763; 
 Thu, 30 Jul 2026 17:14:40 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea02f8461sm3695718b3a.28.2026.07.30.17.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:14:40 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org,
 nm@ti.com, bb@ti.com, n-francis@ti.com, d-gole@ti.com, e@freeshell.de,
 jonas@kwiboo.se, Aristo Chen <aristo.chen@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v4 2/7] binman: Fix FIT image overlap issues
Date: Fri, 31 Jul 2026 00:13:36 +0000
Message-ID: <20260731001347.35624-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731001347.35624-1-aristo.chen@canonical.com>
References: <20260731001347.35624-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 00:15:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785456882;
 bh=5Uhwz4xurQbVorssRQqOhWhN5n0Hdkkv0q/MTks7zuM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=gNgxwTVrDgwa1KyreAU5wre0CU5s/+UQ8iadCaYb4YBoyTz9mvQ3LavunufZZLa9I
 zuKqMmyXNKlmYUcyBQEyrjv+7elSLC1JOyab569Oy0e8sbBzO+mwd6xAz/nx4QJQhO
 zQO7rTYzRO6cjTRlvxZjQvlHdXvckV2YJiUOOKwxnRY8tUjPCyO3vgcQcSRBxA5H60
 OI00UHsLcyIVXeTlyvQo8f4IrKu9131avAZ1Ft2SXxGDIwZ1JQkG/xvP2jFyCRNfDB
 Pn55l8YHsePwDo5aTPSLRqefRO1TZI7h16VQyVWkIdGMaUb2LG0Yz5BwFGlxSubU+m
 eOvaMQL8yHTKV/ej64BHOh4RO0WZzGlsivH5lP1uOHhWJJtopettevhc9v4i0EnEud
 ag+c9ptza27JmCUEpUB/Img86Lb4wCTY07DGvawvwyoWXndGTHefWIUc4Ri/8QcYFB
 2BJCb6EP6CeJtvouqjV1h1i4MtYnRWsjUyDkUgZZmphrKSuhKY6JK7slhBoCfxP/77
 CkhFukmEC/eEDS8Rwlj17viFtBZv236DmxO3pqEufHuSW+HmD18iqYhL7BPWBFsOG4
 Il6kaMKItmSIKCFBKKmOC7Vj3YlD51ejji7MyQpkTu/jESSZYmWh/jgw2HnN5J3NQA
 oXPcP7cBdGp2rNBt06xgAGkg=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=gNgxwTVr
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Several binman test fixtures describe FIT images whose configuration
references both a u-boot firmware image loaded at address 0x0 with a
size of 0x2e bytes and a split-elf atf image whose first segment is
loaded at 0x10, so the two images overlap in memory. The upcoming
mkimage load address overlap check refuses to build such images,
which makes the tests that run these fixtures through mkimage fail.

Move the u-boot load and entry addresses to 0x2000, clear of the atf
segments taken from elf_sections.lds, in the fixtures used by
testFitFirmwareLoadables, testFitSignSimple,
testFitSignNoSignatureNodes, testFitSignEngineSimple,
testFitSignEncryptEngine, testFitSignPKCS11Simple,
testFitSignPKCS11Object, testFitSignMultipleKeyPaths and
testKeyNameHintIsPathSimpleFit.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 tools/binman/test/fit/firmware_loadables.dts             | 4 ++--
 tools/binman/test/fit/key_name_hint_dir_signature.dts    | 4 ++--
 tools/binman/test/fit/signature.dts                      | 4 ++--
 tools/binman/test/fit/signature_engine.dts               | 4 ++--
 tools/binman/test/fit/signature_engine_encrypt.dts       | 4 ++--
 tools/binman/test/fit/signature_engine_pkcs11.dts        | 4 ++--
 tools/binman/test/fit/signature_engine_pkcs11_object.dts | 4 ++--
 tools/binman/test/fit/signature_multi_key.dts            | 4 ++--
 tools/binman/test/fit/signature_no_nodes.dts             | 4 ++--
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/binman/test/fit/firmware_loadables.dts b/tools/binman/test/fit/firmware_loadables.dts
index 2f79cdc9bb8..d344036a11a 100644
--- a/tools/binman/test/fit/firmware_loadables.dts
+++ b/tools/binman/test/fit/firmware_loadables.dts
@@ -19,8 +19,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/key_name_hint_dir_signature.dts b/tools/binman/test/fit/key_name_hint_dir_signature.dts
index 96e2126dadb..33b4ff8ea02 100644
--- a/tools/binman/test/fit/key_name_hint_dir_signature.dts
+++ b/tools/binman/test/fit/key_name_hint_dir_signature.dts
@@ -20,8 +20,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/signature.dts b/tools/binman/test/fit/signature.dts
index 9dce62e52de..1c25d52cba4 100644
--- a/tools/binman/test/fit/signature.dts
+++ b/tools/binman/test/fit/signature.dts
@@ -20,8 +20,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/signature_engine.dts b/tools/binman/test/fit/signature_engine.dts
index fd374e0edd2..ba4df53a0c0 100644
--- a/tools/binman/test/fit/signature_engine.dts
+++ b/tools/binman/test/fit/signature_engine.dts
@@ -21,8 +21,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/signature_engine_encrypt.dts b/tools/binman/test/fit/signature_engine_encrypt.dts
index fbcde342c65..40090431459 100644
--- a/tools/binman/test/fit/signature_engine_encrypt.dts
+++ b/tools/binman/test/fit/signature_engine_encrypt.dts
@@ -22,8 +22,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/signature_engine_pkcs11.dts b/tools/binman/test/fit/signature_engine_pkcs11.dts
index 60ba04c13d4..8d86c994afe 100644
--- a/tools/binman/test/fit/signature_engine_pkcs11.dts
+++ b/tools/binman/test/fit/signature_engine_pkcs11.dts
@@ -21,8 +21,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/signature_engine_pkcs11_object.dts b/tools/binman/test/fit/signature_engine_pkcs11_object.dts
index 5226ab4c6cf..48cd963476d 100644
--- a/tools/binman/test/fit/signature_engine_pkcs11_object.dts
+++ b/tools/binman/test/fit/signature_engine_pkcs11_object.dts
@@ -22,8 +22,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/signature_multi_key.dts b/tools/binman/test/fit/signature_multi_key.dts
index 77bec8df1e5..3b8da190b42 100644
--- a/tools/binman/test/fit/signature_multi_key.dts
+++ b/tools/binman/test/fit/signature_multi_key.dts
@@ -20,8 +20,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/fit/signature_no_nodes.dts b/tools/binman/test/fit/signature_no_nodes.dts
index 267105d0f68..2ac600b1c70 100644
--- a/tools/binman/test/fit/signature_no_nodes.dts
+++ b/tools/binman/test/fit/signature_no_nodes.dts
@@ -20,8 +20,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
-- 
2.43.0

