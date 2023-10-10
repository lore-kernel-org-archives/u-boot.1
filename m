Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96BBCD68E5
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 09:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2748086E00;
	Tue, 10 Oct 2023 11:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 752AD86DF4; Tue, 10 Oct 2023 11:12:10 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id ABA0286DC3
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 11:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1A541FB;
 Tue, 10 Oct 2023 02:12:44 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6A453F762;
 Tue, 10 Oct 2023 02:12:01 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 3/6] binman: capsule: Remove superfluous [address,
 size]-cells properties
Date: Tue, 10 Oct 2023 14:40:56 +0530
Message-Id: <20231010091059.375036-4-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010091059.375036-1-sughosh.ganu@linaro.org>
References: <20231010091059.375036-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The #address-cells and #size-cells are not needed for running the
capsule generation binman tests. Remove the superfluous properties.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* New patch based on review comment from Simon.

 tools/binman/test/311_capsule.dts               | 3 ---
 tools/binman/test/312_capsule_signed.dts        | 3 ---
 tools/binman/test/313_capsule_version.dts       | 3 ---
 tools/binman/test/314_capsule_signed_ver.dts    | 3 ---
 tools/binman/test/315_capsule_oemflags.dts      | 3 ---
 tools/binman/test/316_capsule_missing_key.dts   | 3 ---
 tools/binman/test/317_capsule_missing_index.dts | 3 ---
 tools/binman/test/318_capsule_missing_guid.dts  | 3 ---
 8 files changed, 24 deletions(-)

diff --git a/tools/binman/test/311_capsule.dts b/tools/binman/test/311_capsule.dts
index 8eb4250b14..0a62ef81dd 100644
--- a/tools/binman/test/311_capsule.dts
+++ b/tools/binman/test/311_capsule.dts
@@ -3,9 +3,6 @@
 /dts-v1/;
 
 / {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
 	binman {
 		efi-capsule {
 			image-index = <0x1>;
diff --git a/tools/binman/test/312_capsule_signed.dts b/tools/binman/test/312_capsule_signed.dts
index d1c76e269c..4ab838efed 100644
--- a/tools/binman/test/312_capsule_signed.dts
+++ b/tools/binman/test/312_capsule_signed.dts
@@ -3,9 +3,6 @@
 /dts-v1/;
 
 / {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
 	binman {
 		efi-capsule {
 			image-index = <0x1>;
diff --git a/tools/binman/test/313_capsule_version.dts b/tools/binman/test/313_capsule_version.dts
index bafef3609e..19e7e83348 100644
--- a/tools/binman/test/313_capsule_version.dts
+++ b/tools/binman/test/313_capsule_version.dts
@@ -3,9 +3,6 @@
 /dts-v1/;
 
 / {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
 	binman {
 		efi-capsule {
 			image-index = <0x1>;
diff --git a/tools/binman/test/314_capsule_signed_ver.dts b/tools/binman/test/314_capsule_signed_ver.dts
index 85c784bba4..649b8ccb2d 100644
--- a/tools/binman/test/314_capsule_signed_ver.dts
+++ b/tools/binman/test/314_capsule_signed_ver.dts
@@ -3,9 +3,6 @@
 /dts-v1/;
 
 / {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
 	binman {
 		efi-capsule {
 			image-index = <0x1>;
diff --git a/tools/binman/test/315_capsule_oemflags.dts b/tools/binman/test/315_capsule_oemflags.dts
index f736e8758f..45853f69c3 100644
--- a/tools/binman/test/315_capsule_oemflags.dts
+++ b/tools/binman/test/315_capsule_oemflags.dts
@@ -3,9 +3,6 @@
 /dts-v1/;
 
 / {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
 	binman {
 		efi-capsule {
 			image-index = <0x1>;
diff --git a/tools/binman/test/316_capsule_missing_key.dts b/tools/binman/test/316_capsule_missing_key.dts
index 2080b50e3d..a14a74ee77 100644
--- a/tools/binman/test/316_capsule_missing_key.dts
+++ b/tools/binman/test/316_capsule_missing_key.dts
@@ -3,9 +3,6 @@
 /dts-v1/;
 
 / {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
 	binman {
 		efi-capsule {
 			image-index = <0x1>;
diff --git a/tools/binman/test/317_capsule_missing_index.dts b/tools/binman/test/317_capsule_missing_index.dts
index aadb61f647..99a54d55c3 100644
--- a/tools/binman/test/317_capsule_missing_index.dts
+++ b/tools/binman/test/317_capsule_missing_index.dts
@@ -3,9 +3,6 @@
 /dts-v1/;
 
 / {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
 	binman {
 		efi-capsule {
 			/* Image GUID for testing capsule update */
diff --git a/tools/binman/test/318_capsule_missing_guid.dts b/tools/binman/test/318_capsule_missing_guid.dts
index d76afba853..85d3317ecb 100644
--- a/tools/binman/test/318_capsule_missing_guid.dts
+++ b/tools/binman/test/318_capsule_missing_guid.dts
@@ -3,9 +3,6 @@
 /dts-v1/;
 
 / {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
 	binman {
 		efi-capsule {
 			image-index = <0x1>;
-- 
2.34.1

