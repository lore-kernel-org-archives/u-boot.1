Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9869BCDE004
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 09:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80CEF847C8;
	Wed, 24 Jun 2026 11:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="R4lSWFBU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D870848DC; Wed, 24 Jun 2026 11:26:41 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D64ED846E1
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 11:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50209263D;
 Wed, 24 Jun 2026 02:26:33 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.Arm.com [10.34.111.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 079E33F632;
 Wed, 24 Jun 2026 02:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782293197; bh=w0BLUoxpDsum0dZg+nPX5zMM2NaxZqg+nFRl7pI9oIk=;
 h=From:Date:Subject:In-Reply-To:References:To:Cc:From;
 b=R4lSWFBUobcdKgeQSoPkhxzWek9dXk5veFn3QhjyU5VZLf8mTKGH82czAIZWI+g6g
 e8jKEHnnyaJYfXVu1Feei9KrvGhfiPpzwTgucvDJfkeR8DHZWOvv5qCzBLEKgKwoXl
 a4wV3t3N7iijseG4WCm925Wl5Ab57RYqOBFNCyE0=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Wed, 24 Jun 2026 11:26:10 +0200
Subject: [PATCH v2] lib/efi_selftest: test block io revision
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-rev-v2-1-68beb809891a@arm.com>
X-B4-Tracking: v=1; b=H4sIALGiO2oC/zWMywrCMBBFf6XM2pFpoK268j+kizwmdhZtJClBK
 fl3Y8DludxzDkgchRPcugMiZ0kStgrq1IFd9PZkFFcZFKmRRrpgPeE0KcfOGOWdhvp8RfbybpX
 HXHmRtIf4adHc/9a/f21+7pGQrNU8GE/eDncd17MNK8yllC8tcRhGlAAAAA==
X-Change-ID: 20260608-rev-772dedbb2fda
In-Reply-To: <20260609-rev-v1-0-0ccae5bf0fc5@arm.com>
References: <20260609-rev-v1-0-0ccae5bf0fc5@arm.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3162;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=w0BLUoxpDsum0dZg+nPX5zMM2NaxZqg+nFRl7pI9oIk=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqO6LMFgeuzv2cCEy4wlZY2CosNIVron+cuxUVe
 4evAbBtjnCJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCajuizAAKCRDLSfhWdqMG
 lCHwCACfZHWlOkvwtxqCXD7FyYx39822rzKJVWgZS2BKNEm9oPLvotUqr197VD0lx2rN+XKKsxJ
 ZBoBkRHxGYedDnO5ocL1mhmtBR6RpjPPpfgEDhlWp3FjztYR0kDNFCAc4gd7NkAZtx/VMCzVPCT
 2C3PW3sRnvPTBP0wap9zRtOCcVHiBs1vwCoZXwTRWk19wYvnCBgWvOqLMWQx9eMFoMjCX62uQiH
 Mb4jR6aFqaHW72qEmVzBIucJ/lS+ZAelaPdIVDOPWq3Hwpjp8AwlKjvvNh+jVf6FM5KRMspFWk3
 n2PcuwoA/UTEseN2pNm3bcPwEdIjpdDunqawItOr0uNcPNQy
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

Enhance the unit test to verify all Revision fields of all the
EFI_BLOCK_IO_PROTOCOL structures.
As the unit test registers its own block io protocol for test purposes,
make sure to initialize its revision properly, as it will be verified as
well.

This can run on the sandbox with the following command:

  ./u-boot -T -c 'setenv efi_selftest block device; bootefi selftest'

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
Changes for v2:
- Deal gracefully with no block io protocol found.
- Print revision with %u in case of error as it is unsigned.
---
 lib/efi_selftest/efi_selftest_block_device.c | 56 ++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_selftest/efi_selftest_block_device.c
index 9c4be834eeb..d2a1f2dc5d4 100644
--- a/lib/efi_selftest/efi_selftest_block_device.c
+++ b/lib/efi_selftest/efi_selftest_block_device.c
@@ -170,6 +170,7 @@ static efi_status_t decompress(u8 **image)
 static struct efi_block_io_media media;
 
 static struct efi_block_io block_io = {
+	.revision = EFI_BLOCK_IO_PROTOCOL_REVISION3,
 	.media = &media,
 	.reset = reset,
 	.read_blocks = read_blocks,
@@ -603,6 +604,61 @@ static int execute(void)
 		return EFI_ST_FAILURE;
 	}
 
+	/* Get all handles with block io. */
+	ret = boottime->locate_handle_buffer(BY_PROTOCOL,
+					     &block_io_protocol_guid, NULL,
+					     &no_handles, &handles);
+	switch (ret) {
+	case EFI_SUCCESS:
+	case EFI_NOT_FOUND:	/* no_handles == 0, handles == NULL */
+		break;
+	default:
+		efi_st_error("Locate handle buffer failed\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/*
+	 * Verify all handles with block io.
+	 * If an error is encountered, the loop exits early instead of
+	 * returning, to free the handles buffer.
+	 */
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
+			break;
+		}
+
+		/* Verify block io revision. */
+		rev = block_io_protocol->revision;
+		if (rev != EFI_BLOCK_IO_PROTOCOL_REVISION2 &&
+		    rev != EFI_BLOCK_IO_PROTOCOL_REVISION3) {
+			efi_st_error("Bad block io revision %u\n",
+				     (unsigned int)rev);
+			break;
+		}
+	}
+
+	/* Free handles buffer. */
+	if (handles) {
+		ret = boottime->free_pool(handles);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("Failed to free block io handles\n");
+			return EFI_ST_FAILURE;
+		}
+	}
+
+	/* If we exited the loop on block io handles early this is a failure. */
+	if (i != no_handles)
+		return EFI_ST_FAILURE;
+
 	return EFI_ST_SUCCESS;
 }
 

---
base-commit: fcda974e36033ad5331a9b4a4a551af4e141ad7d
change-id: 20260608-rev-772dedbb2fda

Best regards,
-- 
Vincent.

