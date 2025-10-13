Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0E0CCD18D
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 14:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FF718391C;
	Mon, 13 Oct 2025 16:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DB3383695; Mon, 13 Oct 2025 16:21:24 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2313B8391C
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 16:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88076113E;
 Mon, 13 Oct 2025 07:21:13 -0700 (PDT)
Received: from debian (MacBookPro.nice.arm.com [10.34.128.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 668E23F738;
 Mon, 13 Oct 2025 07:21:20 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 1/2] efi_loader: dbginfodump: use guid definition
Date: Mon, 13 Oct 2025 16:21:08 +0200
Message-ID: <20251013142109.77652-2-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013142109.77652-1-vincent.stehle@arm.com>
References: <20251013142109.77652-1-vincent.stehle@arm.com>
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

Use the Debug Image Info Table GUID definition from efi_api.h instead or
redefining it locally.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_loader/dbginfodump.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
index adbbd5060cc..55186bd03f4 100644
--- a/lib/efi_loader/dbginfodump.c
+++ b/lib/efi_loader/dbginfodump.c
@@ -24,10 +24,8 @@ static efi_guid_t guid_device_path_to_text_protocol =
 
 static struct efi_device_path_to_text_protocol *device_path_to_text;
 
-/* EFI_DEBUG_IMAGE_INFO_TABLE_GUID */
 static const efi_guid_t dbg_info_guid =
-	EFI_GUID(0x49152E77, 0x1ADA, 0x4764, 0xB7, 0xA2,
-		 0x7A, 0xFE, 0xFE, 0xD9, 0x5E, 0x8B);
+	EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
 
 /* EFI_DEBUG_IMAGE_INFO_NORMAL */
 struct dbg_info {
-- 
2.51.0

