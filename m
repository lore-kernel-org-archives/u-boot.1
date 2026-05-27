Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC7ACD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 06:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58D4C839A8;
	Wed, 27 May 2026 08:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dxK6auP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CC3383FF5; Wed, 27 May 2026 08:29:44 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDEA08341A
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 08:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 12F61418E9; 
 Wed, 27 May 2026 06:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779863381;
 bh=Y/1nrT5hEGI78ER81sypmQOiERopImBo+9BqefqiWgk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=dxK6auP125mK2wyxaK+Adnlc9J/SW6UtK2RmYjIr40lknQXtO5QcZvWJArHYHS0ZR
 77s8CdT3BLOH/2GjdEzs4HX88bfH0bJOi0/U6lJQL/H21hbGFXwxF4oI3mndOupigb
 lwaNLv47OfHXbdkxmCHUmcUoqwxmhFjJCoMLVKURTFbDOkD43OQe8Nn8PWoKGkLL11
 cRCJhcONR/tznHLEJU0N7nYzhU6rekXQ7X80kACTI+KMGfsYcZ8sCvnU5zYOHc8Nma
 LKo5ydFBUItTrO3BKS6kYcdSoY+U9P4opzdF1QUJHht14y3Q0zU1jpg6srpspblElW
 vCDd3Vdpwr0TDmt39WBd6pLJwYLC7B3YNP4QolSlCWWU1+4iEfu//jzNEjZ0Ut6Tsg
 GLcRIaDVaEbIQ/dtmpB/gdirnMzJf443uIhVDXmenXXoNrloykPka5951BqxtTLCEr
 rJ6XEdqyN3HO+GmIDwfdVA/SK1yra8igkymkIoxDuD8AacQsnt6KxeO90uuRIvyyTU
 OF/NLY6vZlp2gdt0tFZsFMhnxGd+3+sJg0LB5vixW3FKy7JTnk1l22QMVvKjpt+PC1
 zUYsL5ebhMFLD7Yn+bs3MEK9JWtzLoE/GMXI/K26ohoW4mc0JDoC/cOgNwrZHjwp+a
 tpFmuU2qQtMbOvazcwmsJZQM=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Anas Cherni <anas@calif.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] efi_loader: validate PE-COFF relocation data
Date: Wed, 27 May 2026 08:29:36 +0200
Message-ID: <20260527062936.26895-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

When applying base relocations from a PE-COFF binary all data must
be treated as untrusted. Add the following checks to
efi_loader_relocate():

* Reject relocation blocks that don't start on a 32-bit aligned
  address.
* Reject relocation blocks whose SizeOfBlock is smaller than the
  block header, which would cause an unsigned underflow when computing
  the entry count.
* A block with SizeOfBlock == 0 is invalid and does not mark the end of
  the relocation table.
* Reject relocation blocks that extend beyond the end of the
  relocation section.
* Reject individual relocation entries whose target offset, together
  with the access width, exceeds the mapped image size, preventing
  out-of-bounds writes.

Pass virt_size to efi_loader_relocate() from efi_load_pe() to enable
the per-entry bounds check.

Reported-by: Anas Cherni <anas@calif.io>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	move rel->VirtualAddress > virt_size check out of inner loop
---
 lib/efi_loader/efi_image_loader.c | 85 +++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 11 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index d002eb0c744..88400f9efa9 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -111,8 +111,9 @@ void efi_print_image_infos(void *pc)
  * Return:		status code
  */
 static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
-			unsigned long rel_size, void *efi_reloc,
-			unsigned long pref_address)
+					unsigned long rel_size, void *efi_reloc,
+					unsigned long pref_address,
+					unsigned long virt_size)
 {
 	unsigned long delta = (unsigned long)efi_reloc - pref_address;
 	const IMAGE_BASE_RELOCATION *end;
@@ -122,34 +123,95 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
 		return EFI_SUCCESS;
 
 	end = (const IMAGE_BASE_RELOCATION *)((const char *)rel + rel_size);
-	while (rel + 1 < end && rel->SizeOfBlock) {
+	while (rel + 1 < end) {
 		const uint16_t *relocs = (const uint16_t *)(rel + 1);
+
+		/* Each block must start on a 32-bit boundary */
+		if (!IS_ALIGNED((uintptr_t)rel, sizeof(uint32_t))) {
+			log_debug("Relocation block not 32-bit aligned\n");
+			return EFI_LOAD_ERROR;
+		}
+		/* Relocation block cannot be shorter than its header */
+		if (rel->SizeOfBlock < sizeof(*rel)) {
+			log_debug("Relocation block too small: %u\n",
+				rel->SizeOfBlock);
+			return EFI_LOAD_ERROR;
+		}
+		/* All relocation entries must be inside the .reloc section */
+		if ((const char *)rel + rel->SizeOfBlock > (const char *)end) {
+			log_debug("Relocation block exceeds relocation data\n");
+			return EFI_LOAD_ERROR;
+		}
+		/*
+		 * Relocations must be within the virtual address range.
+		 * This also ensures that there is no overflow in the
+		 * entry_offset check below.
+		 */
+		if (rel->VirtualAddress > virt_size) {
+			log_debug("relocation address out of bounds\n");
+			return EFI_LOAD_ERROR;
+		}
+
 		i = (rel->SizeOfBlock - sizeof(*rel)) / sizeof(uint16_t);
 		while (i--) {
-			uint32_t offset = (uint32_t)(*relocs & 0xfff) +
-					  rel->VirtualAddress;
+			uint32_t entry_offset = *relocs & 0xfff;
+			unsigned long offset;
 			int type = *relocs >> EFI_PAGE_SHIFT;
-			uint64_t *x64 = efi_reloc + offset;
-			uint32_t *x32 = efi_reloc + offset;
-			uint16_t *x16 = efi_reloc + offset;
+			uint64_t *x64;
+			uint32_t *x32;
+			uint16_t *x16;
+
+			/*
+			 * Relocation address must be within virtual address
+			 * range.
+			 */
+			if (entry_offset > virt_size - rel->VirtualAddress) {
+				log_debug("relocation address out of bounds\n");
+				return EFI_LOAD_ERROR;
+			}
+
+			offset = rel->VirtualAddress + entry_offset;
+			x64 = efi_reloc + offset;
+			x32 = efi_reloc + offset;
+			x16 = efi_reloc + offset;
 
 			switch (type) {
 			case IMAGE_REL_BASED_ABSOLUTE:
 				break;
 			case IMAGE_REL_BASED_HIGH:
+				if (sizeof(uint16_t) > virt_size - offset) {
+					log_debug("relocation address out of bounds\n");
+					return EFI_LOAD_ERROR;
+				}
 				*x16 += ((uint32_t)delta) >> 16;
 				break;
 			case IMAGE_REL_BASED_LOW:
+				if (sizeof(uint16_t) > virt_size - offset) {
+					log_debug("relocation address out of bounds\n");
+					return EFI_LOAD_ERROR;
+				}
 				*x16 += (uint16_t)delta;
 				break;
 			case IMAGE_REL_BASED_HIGHLOW:
+				if (sizeof(uint32_t) > virt_size - offset) {
+					log_debug("relocation address out of bounds\n");
+					return EFI_LOAD_ERROR;
+				}
 				*x32 += (uint32_t)delta;
 				break;
 			case IMAGE_REL_BASED_DIR64:
+				if (sizeof(uint64_t) > virt_size - offset) {
+					log_debug("relocation address out of bounds\n");
+					return EFI_LOAD_ERROR;
+				}
 				*x64 += (uint64_t)delta;
 				break;
 #ifdef __riscv
 			case IMAGE_REL_BASED_RISCV_HI20:
+				if (sizeof(uint32_t) > virt_size - offset) {
+					log_debug("relocation address out of bounds\n");
+					return EFI_LOAD_ERROR;
+				}
 				*x32 = ((*x32 & 0xfffff000) + (uint32_t)delta) |
 					(*x32 & 0x00000fff);
 				break;
@@ -163,7 +225,7 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
 				break;
 #endif
 			default:
-				log_err("Unknown Relocation off %x type %x\n",
+				log_err("Unknown Relocation off %lx type %x\n",
 					offset, type);
 				return EFI_LOAD_ERROR;
 			}
@@ -970,8 +1032,9 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 
 	/* Run through relocations */
 	if (efi_loader_relocate(rel, rel_size, efi_reloc,
-				(unsigned long)image_base) != EFI_SUCCESS) {
-		efi_free_pages((uintptr_t) efi_reloc,
+				(unsigned long)image_base,
+				virt_size) != EFI_SUCCESS) {
+		efi_free_pages((uintptr_t)efi_reloc,
 			       (virt_size + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT);
 		ret = EFI_LOAD_ERROR;
 		goto err;
-- 
2.53.0

