Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A80C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 14:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B337B849BA;
	Fri, 26 Jun 2026 16:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="GWydJxDE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489C68460E; Fri, 26 Jun 2026 16:48:24 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DA2218497A
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 16:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 873541E7D;
 Fri, 26 Jun 2026 07:48:14 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.Arm.com [10.34.111.142])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33B603F905;
 Fri, 26 Jun 2026 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782485299; bh=3tvdRgHi79dcal+555PZiwY21C3zvfEZPD4jEMx+4Ds=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=GWydJxDEIv4TpgkdL7R+WekSN3zroaEvvhMaqY2RSf+fWc1s9qlRJWtpcvkHclEC8
 TVFwt//NS21ILcxuCCcIYkntkFMDKnGNCitfSmusB2E6O4wzMTtgszXEV2JUuemaoJ
 8CEtnZh5ptramwro834WmrUptA+wVgpjeO4kpECw=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Fri, 26 Jun 2026 16:47:59 +0200
Subject: [PATCH v3 2/2] efi_selftest: test block io revision and pointers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-rev-v3-2-12a0c0fc0965@arm.com>
References: <20260626-rev-v3-0-12a0c0fc0965@arm.com>
In-Reply-To: <20260626-rev-v3-0-12a0c0fc0965@arm.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3264;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=3tvdRgHi79dcal+555PZiwY21C3zvfEZPD4jEMx+4Ds=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqPpEvt3Rrod8M5ySh2KDqDK4MlXjQpWfYDdwBW
 NEZQFSu1ryJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCaj6RLwAKCRDLSfhWdqMG
 lI/aB/9eKh7ZBSoMiE3zGmOvigI8Eg64VC4zdiVSqDV68iF1kCi1Q4pQanmRoAZELQlOvw0afsX
 JzVGBcwzqIGoG0gFU4KHSuZWwJhdXporP0mm9Z0zu43vDVyUcIB5Txjvs3C5Nnp6Qg1SQABHF5X
 paStk/h8f3h3DCEBKA9yaOv+cJXLYCoaq4uVkcqDxCW9buo819bpwizsD3KoB/b4/XIMa7Zaig5
 zgMXRbFKBpnaWv/omAYoKd1Np7ZGR+AcpuX3bv9FR4qukV5pw9sp7AMnCneZ+Np7F7k6UmmDs6y
 FREMrITtA0skA7lwhOAUD5FXRMUvzOCc3eyPIENzSTrZPNGY
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

Enhance the unit test to verify all Revision fields and all pointers of all
the EFI_BLOCK_IO_PROTOCOL structures.
As the unit test registers its own block io protocol for test purposes,
make sure to initialize its revision properly, as it will be verified as
well.

This can run on the sandbox with the following command:

  ./u-boot -T -c 'setenv efi_selftest block device; bootefi selftest'

Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_selftest/efi_selftest_block_device.c | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_selftest/efi_selftest_block_device.c
index b5f6f9353cd..847d93693ee 100644
--- a/lib/efi_selftest/efi_selftest_block_device.c
+++ b/lib/efi_selftest/efi_selftest_block_device.c
@@ -173,6 +173,7 @@ static efi_status_t decompress(u8 **image)
 static struct efi_block_io_media media;
 
 static struct efi_block_io block_io = {
+	.revision = EFI_BLOCK_IO_PROTOCOL_REVISION3,
 	.media = &media,
 	.reset = reset,
 	.read_blocks = read_blocks,
@@ -615,6 +616,68 @@ static int execute(void)
 		return EFI_ST_FAILURE;
 	}
 
+	/* Get all handles with block io. */
+	ret = boottime->locate_handle_buffer(BY_PROTOCOL,
+					     &block_io_protocol_guid, NULL,
+					     &no_handles, &handles);
+	switch (ret) {
+	case EFI_SUCCESS:
+		if (!no_handles || !handles) {
+			efi_st_error("Locate handle buffer bad handles\n");
+			return EFI_ST_FAILURE;
+		}
+		break;
+	case EFI_NOT_FOUND:
+		efi_st_error("No block IO protocol found though one installed in setup\n");
+		return EFI_ST_FAILURE;
+	default:
+		efi_st_error("Locate handle buffer failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Verify all handles with block io. */
+	for (i = 0; i < no_handles; ++i) {
+		u64 rev;
+
+		ret = boottime->open_protocol(handles[i],
+					      &block_io_protocol_guid,
+					      (void *)&block_io_protocol,
+					      NULL, NULL,
+					      EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("Failed to open block io protocol %d\n",
+				     (unsigned int)i);
+			return EFI_ST_FAILURE;
+		}
+
+		/* Verify block io revision. */
+		rev = block_io_protocol->revision;
+		if (rev != EFI_BLOCK_IO_PROTOCOL_REVISION2 &&
+		    rev != EFI_BLOCK_IO_PROTOCOL_REVISION3) {
+			efi_st_error("Bad block io revision %u\n",
+				     (unsigned int)rev);
+			return EFI_ST_FAILURE;
+		}
+
+		/* Verify block io pointers. */
+		if (!block_io_protocol->media ||
+		    !block_io_protocol->reset ||
+		    !block_io_protocol->read_blocks ||
+		    !block_io_protocol->write_blocks ||
+		    !block_io_protocol->flush_blocks) {
+			efi_st_error("Bad block io pointer\n");
+			return EFI_ST_FAILURE;
+		}
+	}
+
+	/* Free handles buffer. */
+	ret = boottime->free_pool(handles);
+	handles = NULL;	/* Avoid double free on teardown(). */
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Failed to free block io handles\n");
+		return EFI_ST_FAILURE;
+	}
+
 	return EFI_ST_SUCCESS;
 }
 

-- 
2.53.0

