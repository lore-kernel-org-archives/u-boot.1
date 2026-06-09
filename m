Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C35BCD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 08:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378F98485F;
	Tue,  9 Jun 2026 10:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="pM7JyEWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD8D18466E; Tue,  9 Jun 2026 10:07:25 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 775F6846A7
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 10:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBACC236D;
 Tue,  9 Jun 2026 01:07:17 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.27.167])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5BD83F93E;
 Tue,  9 Jun 2026 01:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780992442; bh=k/F2dqsbdgDxGeff2VZVp3r5X+cLq7D38BMPuOBeOXQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=pM7JyEWJ8fWVmHkauwVP3wpoioVvOJYakwPTGFEgFfI9PBuGOflpkTySIM2Rceb2R
 ACVE9/dA02HXyopY9e7ag07ZTElOQmJ6Qh+v2ocAMY7B4cbzlWuBkQof5qjCvfVPB4
 z4wPAp4SddiSD/GfxlCZjqUq1vv8mgmD3SjYqXc0=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Tue, 09 Jun 2026 10:07:05 +0200
Subject: [PATCH 2/2] lib/efi_selftest: test block io revision
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-rev-v1-2-0ccae5bf0fc5@arm.com>
References: <20260609-rev-v1-0-0ccae5bf0fc5@arm.com>
In-Reply-To: <20260609-rev-v1-0-0ccae5bf0fc5@arm.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2792;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=k/F2dqsbdgDxGeff2VZVp3r5X+cLq7D38BMPuOBeOXQ=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqJ8m2fVf92hHalSuxgjH8bpLPXtmbpXyjeTP7U
 MZgQ/Ym2biJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCaifJtgAKCRDLSfhWdqMG
 lMXaCACCANu+b45r6sJnf05EQJQsl1lq6mfZWYl6qz/i8NYiCyNgwkM+j+MJTr7EQF66NUPQCG8
 +RpK5trCCm54MQE8aBJ/Nnqwyr8vGNP6aq2n0YibTqvBroamIFgmr416KtW/rgu1JhzPgnUBOtz
 9Of37+EsVOxBjxizeb2EWA5CNRtI+5qxxhyUG4ESYMmUc1vqal8Wfn1wrEMGhYBGU8CtZZreyb6
 0T5SSeA/zZdYseYstGjCPfRC6uQnY0QCIK2RejYAyH/cQYPpC8wag0lRWOSCncKo4uZ+k2pjsig
 RUVjjwU7w+GDVsqe+pSnQy1swYaNdWjDG0WkWfL5H5ca57Ju
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
 lib/efi_selftest/efi_selftest_block_device.c | 50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_selftest/efi_selftest_block_device.c
index 9c4be834eeb..6fade3e9159 100644
--- a/lib/efi_selftest/efi_selftest_block_device.c
+++ b/lib/efi_selftest/efi_selftest_block_device.c
@@ -170,6 +170,7 @@ static efi_status_t decompress(u8 **image)
 static struct efi_block_io_media media;
 
 static struct efi_block_io block_io = {
+	.revision = EFI_BLOCK_IO_PROTOCOL_REVISION3,
 	.media = &media,
 	.reset = reset,
 	.read_blocks = read_blocks,
@@ -603,6 +604,55 @@ static int execute(void)
 		return EFI_ST_FAILURE;
 	}
 
+	/* Get all handles with block io. */
+	ret = boottime->locate_handle_buffer(BY_PROTOCOL,
+					     &block_io_protocol_guid, NULL,
+					     &no_handles, &handles);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Failed to locate block io handles\n");
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
+			efi_st_error("Bad block io revision %d\n",
+				     (unsigned int)rev);
+			break;
+		}
+	}
+
+	/* Free handles buffer. */
+	ret = boottime->free_pool(handles);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Failed to free block io handles\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* If we exited the loop on block io handles early this is a failure. */
+	if (i != no_handles)
+		return EFI_ST_FAILURE;
+
 	return EFI_ST_SUCCESS;
 }
 

-- 
2.53.0

