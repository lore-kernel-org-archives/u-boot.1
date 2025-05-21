Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19271C3ABC9
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 12:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF4782F5A;
	Wed, 21 May 2025 14:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zlf8HkQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F94482D33; Wed, 21 May 2025 08:28:49 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C1682BD6
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 08:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so5027559b3a.2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 23:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747808925; x=1748413725; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UzqhTbGo9uV252TD9Sf80J8NArSZZUjFqxUvP48IFt0=;
 b=Zlf8HkQ/2vrMVaC46gE/PXL91d9IfDvWvDJBRK3grkTfcXnHwqjtbWamG2GyqEWm2w
 qRmMyHws4UIBasMF8ahUPNEzf1wd0EZI+AZPK16DTiY8Qu5qie4pT1b95OQ8DMvrpHa5
 E2tlRmIG/49RbY1ppoe8uOaX9D0QUDPAAUrDQsCcoxq2cRZON7ocbbPGzrl868Yu52Vo
 mU3CfA0Gs3AvbZ7WDrcr/peb6jh6Yxc3DDwmtWGs+Nhf2JnU7JmEyzjPwPQAZF3APy/X
 KabCjUgqKlqXzKhylWVp/QXbhiHIJ69qy3rSKn/vGSkJV4WndUUQH8eXhjFmS2mW4nFF
 vgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747808925; x=1748413725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UzqhTbGo9uV252TD9Sf80J8NArSZZUjFqxUvP48IFt0=;
 b=f9aKvrWoUI7dicCZNvKc9MonLyG1TnFmFrDottvl5fiFxUMIlWnMl3r+SdcX6KX+E5
 ba+07Nn3vnWA0fYByBA042tBqHBiJEEAwb6CiuLpr7iv/mnWp22OQEGdBH7GXSYa31yr
 4dqMZFNXDs6SLrdlshYCZZP3toCvTwQ6gekEsuhsuXNcQKPN9la6SxLp0FiJxNMPs0NB
 1oR5G7mm3KaONKhndNfo6sxzMfKTabucFcXWwYJNJnavcUj9jG8FulciaSnu9ZFxvHcE
 1+j2L5xRf7as2/ITEeS6OlHyo5XQesfxzdwTd8kOtYTgkWzh4Lr61KudjsamFTpjMR41
 diuQ==
X-Gm-Message-State: AOJu0YwuScwPOYl5zDWbs94Je+0WNIwSQ856vBir7JkpC/wpwekTvHvX
 mX+P/qTaQN4BLk5TCJ+vDjOyPlV24wf1Fwb+TSvE8InOGVfNmJq2E/ZG7LNkj5Xa
X-Gm-Gg: ASbGncuicC74InXZzlxmdjvSiqR/fhXYIn/5F1ChY0GDOO2oq3zmyAHG5W0/u207ZNu
 zl1Xh277bc6KuDa+rlYTctCpTdz4DvL7iNatQ+AEhBsZdakynA1hCaHscIC1VSXQ5ez/6jYCp3B
 2kmS7agPPi7WNvrLAwgnGGz6wU77MQuQjbFUJCRCLTADEyK7ra8CoeDHQpBuR1qRf86g4d6cq+c
 lbRKVmYg20LwYwU2ASEmm9fFVwbn603Tkpbr1cCjUuJUHoyx04HI6yNmRKDpP2zGhwliaM5BV2+
 TyMflH9z6ToU6GPvqpm1Wc4Q74+ZH3dyLWg/F9H8siSM9bcQsZrBuHCdZZuw7WmvRUlGbW7AceC
 YxyuFhzIDEoZViQN5KFKbkJ+vZZD0
X-Google-Smtp-Source: AGHT+IH0KNB4I5iv5QEhAR7vFDKITtuZ2eKw2sCl50xT2L6hNkMqNnJx+ZkY7suL9xzD5GkZjLZhBQ==
X-Received: by 2002:a05:6300:668c:b0:215:dc32:ffac with SMTP id
 adf61e73a8af0-2170cdf19f0mr27707644637.26.1747808925447; 
 Tue, 20 May 2025 23:28:45 -0700 (PDT)
Received: from noble-leuven.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a982b884sm9277911b3a.95.2025.05.20.23.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 23:28:45 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com
Subject: [PATCH v3 3/4] binman: test: Ensure all config references exist in
 /images node
Date: Wed, 21 May 2025 06:27:44 +0000
Message-ID: <20250521062745.3458-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521062745.3458-1-aristo.chen@canonical.com>
References: <20250521062745.3458-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 May 2025 14:36:46 +0200
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

