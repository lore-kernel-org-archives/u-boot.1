Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E763E9A05A
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 18:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 302A683D17;
	Thu, 19 Feb 2026 19:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5FC783CEE; Thu, 19 Feb 2026 19:44:46 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C04E883D17
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 19:44:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD466339;
 Thu, 19 Feb 2026 10:44:37 -0800 (PST)
Received: from debian (unknown [10.57.12.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D8E573F62B;
 Thu, 19 Feb 2026 10:44:42 -0800 (PST)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] efi_selftest: remove unnecessary initializations
Date: Thu, 19 Feb 2026 19:43:58 +0100
Message-ID: <20260219184400.257008-4-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219184400.257008-1-vincent.stehle@arm.com>
References: <20260219184400.257008-1-vincent.stehle@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The UEFI function LocateHandleBuffer() always writes to the value pointed
to by its NoHandles argument (in the test, `count'); remove the unnecessary
initializations.

Remove also one copy to buffer_size, which has become unnecessary.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_selftest/efi_selftest_manageprotocols.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_manageprotocols.c b/lib/efi_selftest/efi_selftest_manageprotocols.c
index 0334a074866..7fe7b285011 100644
--- a/lib/efi_selftest/efi_selftest_manageprotocols.c
+++ b/lib/efi_selftest/efi_selftest_manageprotocols.c
@@ -219,7 +219,6 @@ static int execute(void)
 	 *
 	 *	handle1, handle2
 	 */
-	count = buffer_size;
 	ret = boottime->locate_handle_buffer(BY_PROTOCOL, &guid1, NULL,
 					     &count, &buffer);
 	if (ret != EFI_SUCCESS) {
@@ -257,7 +256,6 @@ static int execute(void)
 		efi_st_error("LocateHandle failed to locate new handles\n");
 		return EFI_ST_FAILURE;
 	}
-	buffer_size = count;
 	ret = find_in_buffer(handle1, count, buffer);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("LocateHandle failed to locate new handles\n");
@@ -303,7 +301,6 @@ static int execute(void)
 	/*
 	 * Check that the protocols are really uninstalled.
 	 */
-	count = buffer_size;
 	ret = boottime->locate_handle_buffer(BY_PROTOCOL, &guid1, NULL,
 					     &count, &buffer);
 	if (ret != EFI_SUCCESS) {
-- 
2.51.0

