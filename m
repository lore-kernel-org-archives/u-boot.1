Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A262BCD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E336B848A9;
	Mon,  1 Jun 2026 15:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VD1iWn/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0259C848B0; Mon,  1 Jun 2026 15:21:04 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF631848A5
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 038B63F289
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 13:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1780320060;
 bh=TAfu5BkoSXesjlc4l6qR8Ag+whUIKhnr0qH0mAFHeXM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=VD1iWn/LGjwOi6K1AT/fjK5glEeblAFUFt10nXD8Wd0siY0b8ymAEJIh00S1HorXJ
 z7r84B1O62y+Qcnu0QFoM3tb8OIqOgkIjUUNveJ+Kjgs+OT/K4/A5r17Ni2MvpnFTH
 I4o2bMFP8JDPqET4WtZQQwQRvg1xlXNhWCmZ4kWt2TiXOsDiJmZC3DlNci4AeYckx8
 lN3kGs51iNE+t+4ep0KATRY8h9xGDhMIcqFdG8E/TUTYwBmBPc9TuVZGro+otQqqHO
 i7+OhiufP5Sc0u8eXxRXS4nGfZt9tznZn7Fh8iVQR+D9SS8MOXIQPJIrSiDA0QNRLP
 xsF5FlxkLRqPZLk/jS9yHGOs8FYlGLYf/cI4mP4HeCoHuOp92ZbSDZQfVfek+J5pCa
 Z84CbWuFSmd7R/5HduZjCaYuC1Y/WYH7+aV50SOQP69RLjZ1dd5EjcVCINHB0v6Sv5
 P2M7ZyrWYwDH1Bo8LtShWeWBwL3vB7ZBBnO2e2V9zBMoz0d6X0t/930iv+J5y/emJ4
 mEJrjQSbN6bVWmn3p8IQbuYutQnZv0a5Ug9n4uKi4wKdjzlNJ/tekPI9rM5ca89gY6
 hB5nPBMtmQpYLXHaEBQ8mWZ9ZAycm3/CxJIIAY7U5RONJTP04hgBOwoohzLC9QC28R
 Ja0HHhE2xmomRBDupbCM6QJA=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a762bcbaso12318005e9.0
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 06:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780320059; x=1780924859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TAfu5BkoSXesjlc4l6qR8Ag+whUIKhnr0qH0mAFHeXM=;
 b=gr0r3f9ykKCd7+yu74pCTjrUsI7QmdfDKV6O51LxloEpR9HU6d4ksNiUfWgRW1fhTZ
 Foya32tS1UEkwPUy0PmJWq5q7ZxZGYd33G8CHMZmAQuW1QWUEZrCkJYSg4n49ZUpKCKR
 8oRWh8U1lXLjEURa+xiBh1Z1imZQ0sqnEJ0x/84nVl/+OHthC9kTaV1bSaM6Fv03pLTM
 3l4jxxRW4sjXEoRHFKtUcOSq+C2nAsN/Df9U+wKHhitKMjs9NbZ8GM0d8NeG20Reyg2i
 jGWzhrPyMVhzRiI4qj7Y37z8IfTxjGHni/zdeyPlWljPXm+MDPFcfwsPgj9D9yP7VUtq
 0+bA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+L/nwzJUPiyATQ4y1/MZbZMkif+KfeihrTz96JXeZpkwh8Jj1U+njRDsLlqCJyGzJPrS/xn/8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0HshHHCLLiSPTauXYWTlj4ZcQBmijMyPTXyhkyog0TRhy2VDu
 5vu1gBag1lgw6r+/UmVObTLbZVmLmeMjc2Q6FfD6f4N4iYpbJQlc8o/XC4A2nj9eK83+UMzeR1o
 Y6IPfOA/hYZs2IvGu9co5zuqIr/+enHz5EeFdZzjw6r84K+5sVfULKIA2OosLFDFp2e29Yf4=
X-Gm-Gg: Acq92OHCTucc9TkeSoutLRgKAkkLWPbSN6SbjpjdREzjOPlWaY9UhCi6ihch7sSehFn
 jwmTeG7j16zox8MDSrF5GcsBw2DHC3/MNxWKpthfHvNRSGBiPXgeQY5xOSCnDkz4NBg27Ngn/Ja
 HpCQbB48egKx9Ue2TRfJEHQghzyEw1+yEN7eCHBD2Fzh8gidirCuiJNUJBjTZCs2ExyCh4YbRSj
 CkPcfq38+yshUcpEWxC8nnG53958FtBvk3hk/5oVJDWHZ6VJfHH4lQZrDeWFZQKzmthJ/Nph1la
 cmOfFVeSUhVzdJqrsg3OWy9oqzwapFu53o/yLdvB/6QaHBUMwbcXoMYZBzc2SFiRdIWkVDinn33
 uNAHwnMAIASncA8ZQW89p6lsYblKxmwBRIb+nZrHPXk9xziQJv5zhkNLiF70hIOrksX8+ZsoFdp
 TS2UprhXpSjQz85s9712hYJcH1OcHTttpQ+s9yMiG9nuUyMfS8s5XfgxT0Gz4U
X-Received: by 2002:a05:600d:848c:20b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-490a2939559mr143223975e9.22.1780320059600; 
 Mon, 01 Jun 2026 06:20:59 -0700 (PDT)
X-Received: by 2002:a05:600d:848c:20b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-490a2939559mr143223525e9.22.1780320059201; 
 Mon, 01 Jun 2026 06:20:59 -0700 (PDT)
Received: from workstation5 (ip-176-199-115-125.um44.pools.vodafone-ip.de.
 [176.199.115.125]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6f3612sm254891205e9.12.2026.06.01.06.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 06:20:58 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Anas Cherni <anas@calif.io>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/1] efi_loader: validate PE-COFF relocation data
Date: Mon,  1 Jun 2026 15:20:53 +0200
Message-ID: <20260601132053.186064-1-heinrich.schuchardt@canonical.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v3:
	add new parameter virt_size fo efi_print_image_infos() description
---
 lib/efi_loader/efi_image_loader.c | 86 +++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 11 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index d002eb0c744..f9a2d2df405 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -108,11 +108,13 @@ void efi_print_image_infos(void *pc)
  * @rel_size:		size of the relocation table in bytes
  * @efi_reloc:		actual load address of the image
  * @pref_address:	preferred load address of the image
+ * @virt_size:		virtual image size as provided in the PE-COFF header
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
@@ -122,34 +124,95 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
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
@@ -163,7 +226,7 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
 				break;
 #endif
 			default:
-				log_err("Unknown Relocation off %x type %x\n",
+				log_err("Unknown Relocation off %lx type %x\n",
 					offset, type);
 				return EFI_LOAD_ERROR;
 			}
@@ -970,8 +1033,9 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 
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

