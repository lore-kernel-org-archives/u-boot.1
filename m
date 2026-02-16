Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4A2E7BD92
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 11:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640A983B8A;
	Mon, 16 Feb 2026 12:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69D2B8063E; Mon, 16 Feb 2026 12:30:39 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 191C18063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 12:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21D49150C;
 Mon, 16 Feb 2026 03:30:30 -0800 (PST)
Received: from debian (unknown [10.57.12.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 671623F632;
 Mon, 16 Feb 2026 03:30:35 -0800 (PST)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Sathisha Shivaramappa <sathisha.shivaramappa@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] efi_loader: fix specific LoadImage() return code
Date: Mon, 16 Feb 2026 12:30:16 +0100
Message-ID: <20260216113017.4135639-2-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216113017.4135639-1-vincent.stehle@arm.com>
References: <20260216113017.4135639-1-vincent.stehle@arm.com>
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

When the LoadImage() UEFI function is called with both its SourceBuffer and
DevicePath input arguments equal to NULL, it must return EFI_NOT_FOUND [1].
However, it does return EFI_INVALID_PARAMETER instead; fix it.

Link: https://uefi.org/specs/UEFI/2.11/07_Services_Boot_Services.html#efi-boot-services-loadimage [1]
Reported-by: Sathisha Shivaramappa <sathisha.shivaramappa@arm.com>
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_loader/efi_boottime.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index b424d924896..de57823bd44 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2096,8 +2096,12 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
 	EFI_ENTRY("%d, %p, %pD, %p, %zu, %p", boot_policy, parent_image,
 		  file_path, source_buffer, source_size, image_handle);
 
-	if (!image_handle || (!source_buffer && !file_path) ||
-	    !efi_search_obj(parent_image) ||
+	if (!source_buffer && !file_path) {
+		ret = EFI_NOT_FOUND;
+		goto error;
+	}
+
+	if (!image_handle || !efi_search_obj(parent_image) ||
 	    /* The parent image handle must refer to a loaded image */
 	    !parent_image->type) {
 		ret = EFI_INVALID_PARAMETER;
-- 
2.51.0

