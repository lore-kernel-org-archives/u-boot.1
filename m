Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C28DC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 12:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE81A82BD6;
	Tue, 10 Jun 2025 14:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I8LTiR5V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1411E80E9A; Tue, 10 Jun 2025 09:41:45 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7756805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-234f17910d8so49738715ad.3
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 00:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749541301; x=1750146101; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UzqhTbGo9uV252TD9Sf80J8NArSZZUjFqxUvP48IFt0=;
 b=I8LTiR5VjKCAdhDrntjrkg570r4p2Dq76PV304oSZzWSNL55VO6NyjRyocjdzg7laq
 GapUUH9rQkTXzAGWJwzTy+qJu2Ltf9FvKaXMW9E8DDqw5xs1+19Omc7MeGqSy3ZXcmbT
 9XQt8iXMaK8m27R+8CUv+9iUO3ub4764FLlJTxrl+luW7ODpOykg5tZXAYxDbexL7JPM
 i97VKJNOmusR6i7VLL3y8DvT7GnR00iCYzUHQCrPr07M7XwMAKFWXOyIkEDvfkUzYQ0d
 3bC6QrR6rEg1RY7KdZCL55JCGMXIG46iUgyhgELNIceSJyaiRDDSp7VmYLjTfydC0Sif
 oyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749541301; x=1750146101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UzqhTbGo9uV252TD9Sf80J8NArSZZUjFqxUvP48IFt0=;
 b=gRQinnHgYNCZJr5wwaE6GaPGQPJxHENZpk9Tez2kR5dtMji+csom+GfiFHNjJczpet
 /Jtesme8ANKRBIRdPXCCXdmcvZlgoFP0XZDdp/PbNfVkdzWGD/ggvYGAkuZS9FIsbnDZ
 my8h0SNo//FUg2OYUVZ+8sm9/cDDlfMjo6ccT+4a9YEVCzkWZYX6VloK385BM6m1Xt+I
 FOZT9UZtsqi0CKWyz01I//Of/wFhsj0oo4C+4moj2v9Btqg7R5KNfBZPhI2kWcjJ09Ro
 UpxWvfyhqPd9/EdBro4OCaHTShrnHFCv1qizHObsZI+H6BVa3qLCDetVYFO3kIEQx/RA
 xTaA==
X-Gm-Message-State: AOJu0Yxy64B2DaZl2g78u4qdNXYE2A7gSiRy1PRgmVUSr0Fei54742mi
 QZETW2khB7S09NUoIpEF28w9O1RgkJKTrmXy1P1xbikmDI8opXvY8My2OSKlqxqL
X-Gm-Gg: ASbGncvReEG/o4uMw8Z5wFl9i7OROtBWP+PqDEdU8efMpYU51llneZL0Z0pFcUx+IM0
 WSnlh0QwFE2lotrEn1mGBIBn1IhhvdwfZAtcXoDxdDDfS0woz1Vq3dxdElPnNMtxqQ+VdnoGjP7
 v4I/Oxr8Atel3eL8VUIy0uNZVuhD2vQWWllWU3bPG1i1PA1XomM65vD9JgP5ZVdcC5AnptFAcFz
 bibYcqOORq46Jw8AHnUchm6Ifdshs7SKGCuD/dP21QJkkr11gCkNKhIwgfV3fU49nfWX1/VmIFK
 XC73IM06mKEMceEb0ljYxvBEoGGp4nJ3ziHh24xC3PqMc2e8kLyy6AeEKPLfd8GTxSAN+bFnntp
 4xWMmBGhqGequkZF3h2lbxLNLb8+zuMW+Y6I=
X-Google-Smtp-Source: AGHT+IGO5WD7Yi5llno96Uq9X69zPXQexr4B3tcvMRUzC+3tgaq/MqPGm1fb1Zg8AURw2d7TB6iXZw==
X-Received: by 2002:a17:902:e890:b0:234:d1f2:da31 with SMTP id
 d9443c01a7336-23601d04105mr238353995ad.2.1749541300952; 
 Tue, 10 Jun 2025 00:41:40 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603092640sm65201945ad.54.2025.06.10.00.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 00:41:40 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com,
 paul.henrys_ext@softathome.com, d-gole@ti.com, afd@ti.com,
 d.schultz@phytec.de, nm@ti.com, n-francis@ti.com, alpernebiyasak@gmail.com
Subject: [PATCH v4 3/5] binman: test: Ensure all config references exist in
 /images node
Date: Tue, 10 Jun 2025 07:41:19 +0000
Message-ID: <20250610074121.8308-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610074121.8308-1-aristo.chen@canonical.com>
References: <20250610074121.8308-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Jun 2025 14:57:04 +0200
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

