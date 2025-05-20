Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0605CC3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 12:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FA5382CA2;
	Tue, 20 May 2025 14:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ekai6ORd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 193C582AA7; Tue, 20 May 2025 09:58:36 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB08D82A4B
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 09:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22fcf9cf3c2so43458025ad.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 00:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747727912; x=1748332712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UzqhTbGo9uV252TD9Sf80J8NArSZZUjFqxUvP48IFt0=;
 b=ekai6ORdMadyU9Wuw43a/ChWb8jBkDb85DUuUYo318DrPkOGbC+l2ScAF4NB6siygS
 Lb0W2LvF+lg4I8jyeIh5fcsz/A2o3xFMpoagyo1I/sZ6TordJerlSkk4CYiTfZouzXJk
 Tv2VlVtAMB9JIR7UkWPY1WATeDlt8ak7vLYM6VrYEEAiq7ct20M4+Rr7t9a4D2P6s9Zi
 UF96TS77vPV9kl0kT1c8N47790AxPysklexWUpxGVbEsldyomZyez4gZhGtXlm9aZYMM
 d3DAA9wcMbW6P8A01J+MopcH3PJwVBJzpQct7rbwEvHpqdstZgb1SeVnoGdGvF4Ew8rr
 WFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747727912; x=1748332712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UzqhTbGo9uV252TD9Sf80J8NArSZZUjFqxUvP48IFt0=;
 b=WzYPPI6jkkNn+PC9umlMtns0yOBZ7zIele84dKS5cAXYR8/0Lj1bpvRXLNMyYQy88b
 XXCggENXZo8enuKgvVYlPxOPGTaXUcLPnv2MUaiI60OrkrKoasFzATGc5Z7FI+RY0TqA
 pHVjHS16NDLd89XpCZALHFuqUaeAWhpzeadNTaVQeZ9AmpJNVIZQ/A+5gljMY6a3C7/M
 oK1zrnHY6BoFHAfAI0CjJMYyzrQ4PCoB5N7Rd1iX9gjAAqf2RZc3fmRZv4vdWkIxpOrQ
 nmBIEM/32M2ewmPbjG7Ms/9A0EbSj3h2wKBWihkAP5taRhkataX49PWBevFIo4kJU9Ep
 luWg==
X-Gm-Message-State: AOJu0YzhThH4og6KEcAuYyYhMlOFIhND0p1vqq/2wrb8IYZgemtPGM3B
 GmsHekbPQsppwRhfzVPdQCD70XZC6cz+TkLD5IRrHSko0/yd32I+aJ2GfI5agCR/
X-Gm-Gg: ASbGncu/p0sGHWmO/hMjSznU439Ade/jjh63oIVahM/VbmIttCEmlhlF3XCGeFB8AYv
 g/oWQ3l0G91W2u1xawBxpnmIU+mldH/CiDKWU2X4NJKSe0qYIcF3UXP3nOkjkXLsMvirXKyFrhE
 zlAPIDyT/LmiEUa3VFfgoLbezrYKqFP779nIkBIVsmc1FIjDNow7Fo/KrhvShFm+NIt1IfYNY5W
 MlCWdO4lNiBuvuZwRIHhqvH7FcoEPXKt1TKP1BJI7aM5U+LifjV2Y5W9bpQU95pMdUeIphMAZBZ
 ITtazvh69MhdFC4oh4isD/GRbY0zSznXcWIgFpz1WuNstsO2j9GhOsfR2CFNd5UaUbB6NvZszpF
 tvsdbzjWMBqOol3Y4oRX6hPtBS4ltLTV0TTQ0b3Mt8HlHeuw=
X-Google-Smtp-Source: AGHT+IEj0y2++/gdXOHHEMY7UYojWM1OO6MHTTdQAF3R549BgMLJOjln+hyStnxyiS4tzVyDJeYVOg==
X-Received: by 2002:a17:903:2303:b0:223:52fc:a15a with SMTP id
 d9443c01a7336-231d452d4ddmr221878915ad.33.1747727912061; 
 Tue, 20 May 2025 00:58:32 -0700 (PDT)
Received: from noble-leuven.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4eba49esm71544795ad.163.2025.05.20.00.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 00:58:31 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com
Subject: [PATCH v2 3/4] binman: test: Ensure all config references exist in
 /images node
Date: Tue, 20 May 2025 07:50:05 +0000
Message-ID: <20250520075735.132308-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505100852.9364-1-aristo.chen@canonical.com>
References: <20250505100852.9364-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 May 2025 14:28:13 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Several binman FIT test device trees reference image nodes such as atf
and uboot in their /configurations sections, but those image nodes
were not actually defined in the /images node. This mismatch can lead
to validation errors when stricter consistency checks are introduced.

This patch adds minimal definitions for atf and uboot under the
/images node in all relevant test DTS files.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/binman/test/170_fit_fdt.dts              | 14 ++++++++++++++
 tools/binman/test/220_fit_subentry_bintool.dts |  2 +-
 tools/binman/test/223_fit_fdt_oper.dts         | 14 ++++++++++++++
 tools/binman/test/284_fit_fdt_list.dts         | 14 ++++++++++++++
 tools/binman/test/333_fit_fdt_dir.dts          | 14 ++++++++++++++
 tools/binman/test/334_fit_fdt_compat.dts       | 14 ++++++++++++++
 tools/binman/test/335_fit_fdt_phase.dts        | 14 ++++++++++++++
 tools/binman/test/345_fit_fdt_name.dts         | 14 ++++++++++++++
 8 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/tools/binman/test/170_fit_fdt.dts b/tools/binman/test/170_fit_fdt.dts
index 0197ffd1597..4b1e9b41ec0 100644
--- a/tools/binman/test/170_fit_fdt.dts
+++ b/tools/binman/test/170_fit_fdt.dts
@@ -15,6 +15,20 @@
 			fit,fdt-list = "of-list";
 
 			images {
+				atf {
+					description = "atf firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
+				uboot {
+					description = "U-Boot firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
 				kernel {
 					description = "Vanilla Linux kernel";
 					type = "kernel";
diff --git a/tools/binman/test/220_fit_subentry_bintool.dts b/tools/binman/test/220_fit_subentry_bintool.dts
index 6e29d41eeb3..b1d8fb0feae 100644
--- a/tools/binman/test/220_fit_subentry_bintool.dts
+++ b/tools/binman/test/220_fit_subentry_bintool.dts
@@ -12,7 +12,7 @@
 			#address-cells = <1>;
 
 			images {
-				test {
+				kernel {
 					description = "Something using a bintool";
 					type = "kernel";
 					arch = "arm";
diff --git a/tools/binman/test/223_fit_fdt_oper.dts b/tools/binman/test/223_fit_fdt_oper.dts
index e630165acf4..cb3b31e36f6 100644
--- a/tools/binman/test/223_fit_fdt_oper.dts
+++ b/tools/binman/test/223_fit_fdt_oper.dts
@@ -15,6 +15,20 @@
 			fit,fdt-list = "of-list";
 
 			images {
+				atf {
+					description = "atf firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
+				uboot {
+					description = "U-Boot firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
 				kernel {
 					description = "Vanilla Linux kernel";
 					type = "kernel";
diff --git a/tools/binman/test/284_fit_fdt_list.dts b/tools/binman/test/284_fit_fdt_list.dts
index 8885313f5b8..70cdb326708 100644
--- a/tools/binman/test/284_fit_fdt_list.dts
+++ b/tools/binman/test/284_fit_fdt_list.dts
@@ -15,6 +15,20 @@
 			fit,fdt-list-val = "test-fdt1", "test-fdt2";
 
 			images {
+				atf {
+					description = "atf firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
+				uboot {
+					description = "U-Boot firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
 				kernel {
 					description = "Vanilla Linux kernel";
 					type = "kernel";
diff --git a/tools/binman/test/333_fit_fdt_dir.dts b/tools/binman/test/333_fit_fdt_dir.dts
index aa778451a4b..71971de4232 100644
--- a/tools/binman/test/333_fit_fdt_dir.dts
+++ b/tools/binman/test/333_fit_fdt_dir.dts
@@ -15,6 +15,20 @@
 			fit,fdt-list-dir = "fdts";
 
 			images {
+				atf {
+					description = "atf firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
+				uboot {
+					description = "U-Boot firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
 				kernel {
 					description = "Vanilla Linux kernel";
 					type = "kernel";
diff --git a/tools/binman/test/334_fit_fdt_compat.dts b/tools/binman/test/334_fit_fdt_compat.dts
index 3bf45c710db..bf1b5a4a94a 100644
--- a/tools/binman/test/334_fit_fdt_compat.dts
+++ b/tools/binman/test/334_fit_fdt_compat.dts
@@ -15,6 +15,20 @@
 			fit,fdt-list = "of-list";
 
 			images {
+				atf {
+					description = "atf firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
+				uboot {
+					description = "U-Boot firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
 				kernel {
 					description = "Vanilla Linux kernel";
 					type = "kernel";
diff --git a/tools/binman/test/335_fit_fdt_phase.dts b/tools/binman/test/335_fit_fdt_phase.dts
index f8d0740a394..c20bcad651a 100644
--- a/tools/binman/test/335_fit_fdt_phase.dts
+++ b/tools/binman/test/335_fit_fdt_phase.dts
@@ -15,6 +15,20 @@
 			fit,fdt-list = "of-list";
 
 			images {
+				atf {
+					description = "atf firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
+				uboot {
+					description = "U-Boot firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
 				kernel {
 					description = "Vanilla Linux kernel";
 					type = "kernel";
diff --git a/tools/binman/test/345_fit_fdt_name.dts b/tools/binman/test/345_fit_fdt_name.dts
index 631a8e5f59b..0ef2e1934a0 100644
--- a/tools/binman/test/345_fit_fdt_name.dts
+++ b/tools/binman/test/345_fit_fdt_name.dts
@@ -15,6 +15,20 @@
 			fit,fdt-list = "of-list";
 
 			images {
+				atf {
+					description = "atf firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
+				uboot {
+					description = "U-Boot firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
 				kernel {
 					description = "Vanilla Linux kernel";
 					type = "kernel";
-- 
2.43.0

