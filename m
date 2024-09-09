Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F2EECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 11:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 406E388DD9;
	Mon,  9 Sep 2024 13:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48A0288DD9; Mon,  9 Sep 2024 13:20:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4F48088CBD
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 13:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59C2DFEC;
 Mon,  9 Sep 2024 04:21:17 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D81623F73B;
 Mon,  9 Sep 2024 04:20:46 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 6/6] fwu: print a message if empty capsule checks fail
Date: Mon,  9 Sep 2024 16:50:21 +0530
Message-Id: <20240909112021.1962801-7-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909112021.1962801-1-sughosh.ganu@linaro.org>
References: <20240909112021.1962801-1-sughosh.ganu@linaro.org>
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

When dealing with processing of the empty capsule, the capsule gets
applied only when the checks for the empty capsule pass. Print a
message to highlight if empty capsule checks fail, and return an error
value, similar to the normal capsules.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: New patch

 lib/efi_loader/efi_capsule.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 635088f25a..22677f395b 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -563,9 +563,14 @@ static efi_status_t efi_capsule_update_firmware(
 	bool fw_accept_os;
 
 	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
-		if (fwu_empty_capsule_checks_pass() &&
-		    fwu_empty_capsule(capsule_data))
-			return fwu_empty_capsule_process(capsule_data);
+		if (fwu_empty_capsule(capsule_data)) {
+			if (fwu_empty_capsule_checks_pass()) {
+				return fwu_empty_capsule_process(capsule_data);
+			} else {
+				log_err("FWU empty capsule checks failed. Cannot start update\n");
+				return EFI_INVALID_PARAMETER;
+			}
+		}
 
 		if (!fwu_update_checks_pass()) {
 			log_err("FWU checks failed. Cannot start update\n");
-- 
2.34.1

