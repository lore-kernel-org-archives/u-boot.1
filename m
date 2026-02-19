Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE73E9A057
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 18:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB36B83DCB;
	Thu, 19 Feb 2026 19:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FF8A83DCB; Thu, 19 Feb 2026 19:44:38 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 74E6B83D17
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 19:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C1BF339;
 Thu, 19 Feb 2026 10:44:29 -0800 (PST)
Received: from debian (unknown [10.57.12.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 834D73F62B;
 Thu, 19 Feb 2026 10:44:34 -0800 (PST)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] efi_selftest: fix buffer overflow and memory leak
Date: Thu, 19 Feb 2026 19:43:57 +0100
Message-ID: <20260219184400.257008-3-vincent.stehle@arm.com>
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

The test of the UEFI UninstallMultipleProtocolInterfaces() function clears
a buffer returned by LocateHandleBuffer() at some point, but there is an
error in the size computation, which leads to a buffer overflow.
The buffer is also never freed, which leads to a memory leak.

As the buffer is in fact not reused during the test, fix both errors by
simply freeing the buffer.

Fixes: 927ca890b09f ("efi_selftest: test protocol management")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_selftest/efi_selftest_manageprotocols.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/efi_selftest/efi_selftest_manageprotocols.c b/lib/efi_selftest/efi_selftest_manageprotocols.c
index ccffa59095d..0334a074866 100644
--- a/lib/efi_selftest/efi_selftest_manageprotocols.c
+++ b/lib/efi_selftest/efi_selftest_manageprotocols.c
@@ -319,7 +319,12 @@ static int execute(void)
 		efi_st_error("Failed to locate new handle\n");
 		return EFI_ST_FAILURE;
 	}
-	boottime->set_mem(buffer, sizeof(efi_handle_t) * buffer_size, 0);
+	/* Release buffer */
+	ret = boottime->free_pool(buffer);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("FreePool failed\n");
+		return EFI_ST_FAILURE;
+	}
 
 	/*
 	 * Test ProtocolsPerHandle
-- 
2.51.0

