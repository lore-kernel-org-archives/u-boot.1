Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AAEC43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 14:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7443084979;
	Fri, 26 Jun 2026 16:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="bMQaR/9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1DE584987; Fri, 26 Jun 2026 16:48:20 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7F71584987
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 16:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CA0A1F37;
 Fri, 26 Jun 2026 07:48:13 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.Arm.com [10.34.111.142])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E85A63F905;
 Fri, 26 Jun 2026 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782485297; bh=oZSj66xuL+ixABkAqbC1qhuzLs48BL0PmiDHETfzAo0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=bMQaR/9wzZ1Ii0+SdDz2237LKm00NvicQaik4N21tOKzTVdVa7rfbyJJqPDOAhT3V
 QFRB1FffTaHG4MIdXY+Xlwv8xjF7ZAa8bMHn7VOTbxyUIr2S1IGlBRT/MyIJ3v3+dE
 NvgQFLpVepjD/BGHKSFErUZ+uSZ7Rnk+QOqKOiS8=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Fri, 26 Jun 2026 16:47:58 +0200
Subject: [PATCH v3 1/2] efi_selftest: free handles on teardown()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-rev-v3-1-12a0c0fc0965@arm.com>
References: <20260626-rev-v3-0-12a0c0fc0965@arm.com>
In-Reply-To: <20260626-rev-v3-0-12a0c0fc0965@arm.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=oZSj66xuL+ixABkAqbC1qhuzLs48BL0PmiDHETfzAo0=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqPpEvPkYNEZ3sd5OHAaTUdVgJ3iL6/Dfk1zfw3
 CsTh8z0tjiJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCaj6RLwAKCRDLSfhWdqMG
 lAlaCACCf4fhRqg2z3SbtAS8En4J/kaidHBAOw7KZ65/vmtekH0SVdd7bvfp18rmsCZht4q9ibA
 GhZit1vjpvZECrb9gPih6t3TL87d+fFbgwCFCbJ244ErKWNL/iGFosOcNBoiguFebYxsQYlD3hU
 WzT0cjLgteGlw3y7/pNgKf3tzh3+CAfBvcHmIc34ByOSCe0Sqv0R8sGfHHkg9jn+/m4x479V+M6
 jpKdhvTvLQV76ecYncQt4fGbOh8GgvCGQkUbF+ArEKZXEp3QQIJS8KTBppmKkp3V+17ybebdQpy
 30q5EhBO/sxBxVc5RGzFTcNrB7b3VEeFzo8Y59pra5mPJsNT
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

In the block device selftest, make the handles pointer global and free it
also in teardown(), to simplify error handling.

We also need to nullify the pointer after freeing it on the normal path,
to avoid freeing it a second time during teardown().

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
---
 lib/efi_selftest/efi_selftest_block_device.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_selftest/efi_selftest_block_device.c
index 9c4be834eeb..b5f6f9353cd 100644
--- a/lib/efi_selftest/efi_selftest_block_device.c
+++ b/lib/efi_selftest/efi_selftest_block_device.c
@@ -58,6 +58,9 @@ static const struct compressed_disk_image img = EFI_ST_DISK_IMG;
 /* Decompressed disk image */
 static u8 *image;
 
+/* Handles buffer */
+static efi_handle_t *handles;
+
 /*
  * Reset service of the block IO protocol.
  *
@@ -276,6 +279,15 @@ static int teardown(void)
 			return EFI_ST_FAILURE;
 		}
 	}
+
+	if (handles) {
+		r = boottime->free_pool(handles);
+		if (r != EFI_SUCCESS) {
+			efi_st_error("Failed to free handles\n");
+			return EFI_ST_FAILURE;
+		}
+	}
+
 	return r;
 }
 
@@ -303,7 +315,6 @@ static int execute(void)
 {
 	efi_status_t ret;
 	efi_uintn_t no_handles, i, len;
-	efi_handle_t *handles;
 	efi_handle_t handle_partition = NULL;
 	struct efi_device_path *dp_partition;
 	struct efi_block_io *block_io_protocol;
@@ -372,6 +383,7 @@ static int execute(void)
 		break;
 	}
 	ret = boottime->free_pool(handles);
+	handles = NULL;	/* Avoid double free on teardown(). */
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("Failed to free pool memory\n");
 		return EFI_ST_FAILURE;

-- 
2.53.0

