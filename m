Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC88C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 06:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A84268303B;
	Tue,  8 Apr 2025 08:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b+IahL9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BD1983095; Tue,  8 Apr 2025 08:07:09 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C313682FBE
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 08:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53866xtw588144
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 01:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744092419;
 bh=peM/cmKimvBfvp8QRbeOcki2zDCQEKYwys1R3BXJ5R4=;
 h=From:Date:Subject:To:CC;
 b=b+IahL9FEvTAxicJ2K15kRccdWMxbcwxrmi95VhN3fPFLcazWmaXywsHjbAm5aYl6
 BolWE0jAI5qcdIJjiRyS18Hu1LmSrNJxwiBSgcl7ABovRu1895pMRIkv3MxAYzK9DL
 CqPw/EK/qZ75OTI73jiqd2Lhh/+msaHPMHInzo60=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53866x3d079270
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Apr 2025 01:06:59 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Apr 2025 01:06:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Apr 2025 01:06:58 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53866xR6080407;
 Tue, 8 Apr 2025 01:06:59 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 8 Apr 2025 01:06:58 -0500
Subject: [PATCH] efi_selftest: remove un-needed NULL checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250408-efi-selftest-fixes-v1-1-69ae449160f2@ti.com>
X-B4-Tracking: v=1; b=H4sIAAG99GcC/x3L2wpAUBBG4VfRXJsax/AqcuHwb6aE9khK3t3O5
 ddqPWTwCqMmesjjUtN9C0jiiMal32awTsGUSlpILhXDKRtWd8JOdnrDWPISQy2Z1ElJYTw8/hC
 +tnvfD72IQTFkAAAA
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Because we've already returned early in the event 'handle' is NULL we
don't need these extra not NULL checks. Remove them

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Hello everyone!

I noticed the extra NULL check and decided to clean it up. They could be 
considered an extra precaution but the other calls above are unguarded 
so it made sense to remove them. 

Happy Hacking
~Bryan
---
 lib/efi_selftest/efi_selftest_hii.c | 84 ++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 48 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_hii.c b/lib/efi_selftest/efi_selftest_hii.c
index c363df466dc11..228dc29695078 100644
--- a/lib/efi_selftest/efi_selftest_hii.c
+++ b/lib/efi_selftest/efi_selftest_hii.c
@@ -609,14 +609,12 @@ static int test_hii_database_get_package_list_handle(void)
 	result = EFI_ST_SUCCESS;
 
 out:
-	if (handle) {
-		ret = hii_database_protocol->remove_package_list(
-				hii_database_protocol, handle);
-		if (ret != EFI_SUCCESS) {
-			efi_st_error("remove_package_list returned %u\n",
-				     (unsigned int)ret);
-			return EFI_ST_FAILURE;
-		}
+	ret = hii_database_protocol->remove_package_list(
+			hii_database_protocol, handle);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("remove_package_list returned %u\n",
+			     (unsigned int)ret);
+		return EFI_ST_FAILURE;
 	}
 
 	return result;
@@ -711,14 +709,12 @@ static int test_hii_string_new_string(void)
 	result = EFI_ST_SUCCESS;
 
 out:
-	if (handle) {
-		ret = hii_database_protocol->remove_package_list(
-				hii_database_protocol, handle);
-		if (ret != EFI_SUCCESS) {
-			efi_st_error("remove_package_list returned %u\n",
-				     (unsigned int)ret);
-			return EFI_ST_FAILURE;
-		}
+	ret = hii_database_protocol->remove_package_list(
+			hii_database_protocol, handle);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("remove_package_list returned %u\n",
+			     (unsigned int)ret);
+		return EFI_ST_FAILURE;
 	}
 
 	return result;
@@ -792,14 +788,12 @@ static int test_hii_string_get_string(void)
 	result = EFI_ST_SUCCESS;
 
 out:
-	if (handle) {
-		ret = hii_database_protocol->remove_package_list(
-				hii_database_protocol, handle);
-		if (ret != EFI_SUCCESS) {
-			efi_st_error("remove_package_list returned %u\n",
-				     (unsigned int)ret);
-			return EFI_ST_FAILURE;
-		}
+	ret = hii_database_protocol->remove_package_list(
+			hii_database_protocol, handle);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("remove_package_list returned %u\n",
+			     (unsigned int)ret);
+		return EFI_ST_FAILURE;
 	}
 
 	return result;
@@ -851,14 +845,12 @@ static int test_hii_string_set_string(void)
 	result = EFI_ST_SUCCESS;
 
 out:
-	if (handle) {
-		ret = hii_database_protocol->remove_package_list(
-				hii_database_protocol, handle);
-		if (ret != EFI_SUCCESS) {
-			efi_st_error("remove_package_list returned %u\n",
-				     (unsigned int)ret);
-			return EFI_ST_FAILURE;
-		}
+	ret = hii_database_protocol->remove_package_list(
+			hii_database_protocol, handle);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("remove_package_list returned %u\n",
+			     (unsigned int)ret);
+		return EFI_ST_FAILURE;
 	}
 
 	return result;
@@ -918,14 +910,12 @@ static int test_hii_string_get_languages(void)
 	result = EFI_ST_SUCCESS;
 
 out:
-	if (handle) {
-		ret = hii_database_protocol->remove_package_list(
-				hii_database_protocol, handle);
-		if (ret != EFI_SUCCESS) {
-			efi_st_error("remove_package_list returned %u\n",
-				     (unsigned int)ret);
-			return EFI_ST_FAILURE;
-		}
+	ret = hii_database_protocol->remove_package_list(
+			hii_database_protocol, handle);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("remove_package_list returned %u\n",
+			     (unsigned int)ret);
+		return EFI_ST_FAILURE;
 	}
 
 	return result;
@@ -991,14 +981,12 @@ static int test_hii_string_get_secondary_languages(void)
 	result = EFI_ST_SUCCESS;
 
 out:
-	if (handle) {
-		ret = hii_database_protocol->remove_package_list(
-				hii_database_protocol, handle);
-		if (ret != EFI_SUCCESS) {
-			efi_st_error("remove_package_list returned %u\n",
-				     (unsigned int)ret);
-			return EFI_ST_FAILURE;
-		}
+	ret = hii_database_protocol->remove_package_list(
+			hii_database_protocol, handle);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("remove_package_list returned %u\n",
+			     (unsigned int)ret);
+		return EFI_ST_FAILURE;
 	}
 
 	return result;

---
base-commit: 2015662a670ca69b5b6636f518c0dde9c229f92d
change-id: 20250408-efi-selftest-fixes-046eb9030916

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

