Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C52FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 16:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89A4083BC4;
	Mon, 27 Apr 2026 18:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="fmLosnJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F43683C14; Mon, 27 Apr 2026 17:05:54 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id EE2B283693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 17:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B39DD1FC7;
 Mon, 27 Apr 2026 08:05:45 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.64.144])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2EDC3F7B4;
 Mon, 27 Apr 2026 08:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777302351; bh=DAcO3uAehutEJzwAc13cS+6/KYa2iX49VyeA+E7STs4=;
 h=From:To:Cc:Subject:Date:From;
 b=fmLosnJEk+FEbPSa6dtn2S+e78JNL1AKTjCrBujd8SqfSUiUvQ7s9vEGoEd7iOrYl
 HSbYUVshfjxnYdIUFeszB1JXAlaiIAVrqdyFGwwZ6vPPoCk0t1YF3nbxWkjf6novfv
 DVWWTwNvaMsGyLILMwHFM3wh2SK0aE7RLwzt0B9I=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH] efi_loader: fix AllocatePages overlap status
Date: Mon, 27 Apr 2026 16:05:30 +0100
Message-Id: <20260427150530.3156000-1-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Apr 2026 18:01:00 +0200
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

Return EFI_NOT_FOUND for EFI_ALLOCATE_ADDRESS overlap

When efi_allocate_pages() is called with EFI_ALLOCATE_ADDRESS, UEFI
expects EFI_NOT_FOUND if the requested address range is already
allocated or unavailable. U-Boot currently returns
EFI_OUT_OF_RESOURCES when efi_update_memory_map() detects an overlap
after a successful lmb_alloc_mem(), which does not match
EFI_ALLOCATE_ADDRESS semantics.

Return EFI_NOT_FOUND for EFI_ALLOCATE_ADDRESS requests that fail due
to an overlapping EFI memory descriptor, while keeping
EFI_OUT_OF_RESOURCES for other allocation types.

The UEFI specification [1] specifies that
EFI_BOOT_SERVICES.AllocatePages must return EFI_NOT_FOUND when the
requested address range is unavailable or already allocated;
EFI_OUT_OF_RESOURCES applies to non‑address‑specific allocation
failures.

[1] https://uefi.org/specs/UEFI/2.10_A/07_Services_Boot_Services.html

Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 lib/efi_loader/efi_memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index b77c2f980cc..63cf1a7277f 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -510,7 +510,9 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 		/* Map would overlap, bail out */
 		lmb_free(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
 		unmap_sysmem((void *)(uintptr_t)efi_addr);
-		return  EFI_OUT_OF_RESOURCES;
+		if (type == EFI_ALLOCATE_ADDRESS)
+			return EFI_NOT_FOUND;
+		return EFI_OUT_OF_RESOURCES;
 	}
 
 	*memory = efi_addr;
-- 
2.34.1

