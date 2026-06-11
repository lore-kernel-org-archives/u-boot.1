Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04743CD98C7
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 09:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DDFE839A8;
	Thu, 11 Jun 2026 11:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="A2gRGzwe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 256EF83FEC; Thu, 11 Jun 2026 11:29:33 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E81E3838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70BE1169C;
 Thu, 11 Jun 2026 02:29:25 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.129.1])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 07C6E3FD88;
 Thu, 11 Jun 2026 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781170170; bh=NDJz7KKtM+TurpDsoYrPj5A/bFfecF9oKyU7yA4EQmM=;
 h=From:To:Cc:Subject:Date:From;
 b=A2gRGzweiSu3Z+gKAhpV2IEa2QPjx9YwgV8nWKvKYPO0eQCWFP1Ivl9eTBY8W0tnb
 ozhsbR10qsObGR3JRu0xt5Z2KHfUMH53Y3ZfMnk5nniK17zaPh30OkrPxyDpqPJpc9
 JSURn2f0XATlZtXrL9TqLEV5+R+kvOylcC7+XmBA=
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@suse.de>
Subject: [PATCH] efi_selftest: fix guid comparison
Date: Thu, 11 Jun 2026 11:29:26 +0200
Message-ID: <20260611092926.578977-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.53.0
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

The `loaded image' efi selftest is comparing protocol GUIDs with the wrong
polarity.
This can be verified on the sandbox, where two protocols GUIDs are
retrieved by the test from the image handle in the following order:

1. Loaded Image Device Path Protocol GUID
2. Loaded Image Protocol GUID

The test matches on the first GUID, while it is in fact looking for the
second one; fix the comparison polarity.

While at it, use guidcmp() instead of memcmp() to spare the size parameter,
and use the Loaded Image Protocol GUID definition from efi_api.h instead or
redefining it locally.

Fixes: efe79a7c0de0 ("efi_selftest: test for loaded image protocol")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Alexander Graf <agraf@suse.de>
---
 lib/efi_selftest/efi_selftest_loaded_image.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_loaded_image.c b/lib/efi_selftest/efi_selftest_loaded_image.c
index 5889ab12617..48890a66db7 100644
--- a/lib/efi_selftest/efi_selftest_loaded_image.c
+++ b/lib/efi_selftest/efi_selftest_loaded_image.c
@@ -9,9 +9,7 @@
 
 #include <efi_selftest.h>
 
-static efi_guid_t loaded_image_protocol_guid =
-	EFI_GUID(0x5b1b31a1, 0x9562, 0x11d2,
-		 0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b);
+static efi_guid_t loaded_image_protocol_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
 static struct efi_boot_services *boottime;
 efi_handle_t image_handle;
 
@@ -60,8 +58,7 @@ static int execute(void)
 	efi_st_printf("%u protocols installed on image handle\n",
 		      (unsigned int)protocol_buffer_count);
 	for (i = 0; i < protocol_buffer_count; ++i) {
-		if (memcmp(protocol_buffer[i], &loaded_image_protocol_guid,
-			   sizeof(efi_guid_t)))
+		if (!guidcmp(protocol_buffer[i], &loaded_image_protocol_guid))
 			found = true;
 	}
 	if (!found) {
-- 
2.53.0

