Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05271CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 22:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D10783957;
	Tue,  4 Nov 2025 23:14:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JH8SvVwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C7E383966; Tue,  4 Nov 2025 23:14:30 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50F7A83942
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 23:14:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 970FE40979; 
 Tue,  4 Nov 2025 22:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762294467;
 bh=6NmSU7m+bQtIVaDtMoTqhALLX4K3YdOlKbfAu0EpVZg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=JH8SvVwRqNeUAiwysZKZ008aJ4ihY2bc/yjj0eCdc6PBa5uhljPSneOMgnE8TXz1+
 tDztMp5o7R/4XASXi6HmyWDfxXKQoZvSZ2dYwiqIsE0LBrqCpmPIZqMcVd1O9fJk8Q
 9VfeneJU0TzqzpojxFXw3oF5eTeMWgU/z8VX1l2TZ99ri6F86UaLFuaz4B334uZXCB
 Jm+B82Hin6D/efnoAvW5sFyfx/Q0wuX6Ij8zjz0NFMD4yZmmbQr/WBe/gy6eo6afi2
 1N/UUcI7ZRPoUljIPc4dDPEZ7TrsObLL2yGfV9DH952XtOAn4A/2VkmP2aiw3X1Wff
 z/rhxZg2Dyfmk7vr363mpMK7ekhx6WwXYHxNaWykiuqlvdLzG4IgyjL/eWZJ6jZN9p
 nNeJZGD2SXVaFnoEn6h3dBmBOFaUF2WVS9BVoOFzym7gAVHyTlT5UkK9SxJH3nNttF
 oroeclRl2oHnaen8l1khHf038gRkSu2df9n+5b09DaoDBn5DPxO+vdzeuBDTKHFyCB
 NoKvDUTYkbC9BzTjbBSB7x+05Vv++09JgFMMqSVT0cjmK7/vvbVbHTWkGdVBAG1Jcz
 YpLHGYYWuCT+EJjnU0RgCq0Eh9kYaLI97qBxLE1rw8TmRMyBoVUlBYlPMVQTNcRI58
 pBuU4j4iEYWOoQyDRREtsQz4=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_client: correct memset() return value
Date: Tue,  4 Nov 2025 23:14:23 +0100
Message-ID: <20251104221423.44514-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Memset() must return a pointer to the start of the updated memory block.

Fixes: 476476e73b14 ("efi: Add support for loading U-Boot through an EFI stub")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_client/efi_stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_client/efi_stub.c b/lib/efi_client/efi_stub.c
index a083c7f1e9b..da7972444df 100644
--- a/lib/efi_client/efi_stub.c
+++ b/lib/efi_client/efi_stub.c
@@ -110,7 +110,7 @@ void *memset(void *inptr, int ch, size_t size)
 	while (ptr < end)
 		*ptr++ = ch;
 
-	return ptr;
+	return inptr;
 }
 
 static void jump_to_uboot(ulong cs32, ulong addr, ulong info)
-- 
2.51.0

