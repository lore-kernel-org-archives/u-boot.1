Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D91CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 06:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C2CE84150;
	Mon, 18 May 2026 08:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BZrw7lAN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E811784659; Mon, 18 May 2026 08:30:33 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB95A83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 08:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779085831; x=1779690631; i=xypron.glpk@gmx.de;
 bh=18XznmxwhJc4bnB8ceiGnsJ0K67PEFyn05SVYZYB6Bc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BZrw7lANYjw5nxxxGZKoNIvLTxBOyIgxhBkzsaJMGkKVrmSY9gwOKsDs0Y6puoc/
 cXzfEKN4lmwwv76c1rlCwCpuTsmzGQ7dM+O21/18Dxp9SPMkBGypGW8HjmW4dgPxj
 BwSvMhJDZgKwgLpEKyOdhAdD7Har8sAvZxVaFPKx5sOIzVCrWeIdXJSBof17xwE2M
 XSEMuqJiN6loytu61SCf5HIIfO6WBXfKsaJQ/bg/MladqsvQ6gt7SG5BbgxaGivTJ
 s/KeqYNLXU+yt8tcosxAsjDDDW99ZXlZAxxWBiMWzvetQc+vlolrUiK7R1MPMx5A1
 qEQxzFyH4/Ao+9hEYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1xB4QY40ie-00d6c7; Mon, 18
 May 2026 08:30:31 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Anas Cherni <anas@calif.io>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi_loader: validate PE-COFF relocation data
Date: Mon, 18 May 2026 08:30:20 +0200
Message-ID: <20260518063020.181443-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cwMhCC62cjHClB3UdxudZ6NHlXRPEND3fyNzxeInqgfVkJ2voK8
 IQfavJbO0US4PznFabIz/aWq9x6DtDam5Ztz6fWbO3jyQRiJMD4twXfFjXetIqfXhz5Bzn9
 YdTPuaFFdrnfN/i3L4VvmJFVVvpW6q8R3tThwyajnhc9m6TXtpvwvttDbLrz3h3SJlLK4e2
 W+Tr6ea5RDxOnroqftvpQ==
UI-OutboundReport: notjunk:1;M01:P0:73k3SmXBzxw=;hNcyFbGP5uqUcP8MewbEUVHUKzC
 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
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
* A block with SizeOfBlock =3D=3D 0 is invalid and does not mark the end o=
f
  the relocation table.
* Reject relocation blocks that extend beyond the end of the
  relocation section.
* Reject individual relocation entries whose target offset, together
  with the access width, exceeds the mapped image size, preventing
  out-of-bounds writes.

Pass virt_size to efi_loader_relocate() from efi_load_pe() to enable
the per-entry bounds check.

Reported-by: Anas Cherni <anas@calif.io>
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 lib/efi_loader/efi_image_loader.c | 76 ++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 11 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_=
loader.c
index d002eb0c744..0bc66a0f732 100644
=2D-- a/lib/efi_loader/efi_image_loader.c
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
 	unsigned long delta =3D (unsigned long)efi_reloc - pref_address;
 	const IMAGE_BASE_RELOCATION *end;
@@ -122,34 +123,86 @@ static efi_status_t efi_loader_relocate(const IMAGE_=
BASE_RELOCATION *rel,
 		return EFI_SUCCESS;
=20
 	end =3D (const IMAGE_BASE_RELOCATION *)((const char *)rel + rel_size);
-	while (rel + 1 < end && rel->SizeOfBlock) {
+	while (rel + 1 < end) {
 		const uint16_t *relocs =3D (const uint16_t *)(rel + 1);
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
 		i =3D (rel->SizeOfBlock - sizeof(*rel)) / sizeof(uint16_t);
 		while (i--) {
-			uint32_t offset =3D (uint32_t)(*relocs & 0xfff) +
-					  rel->VirtualAddress;
+			uint32_t entry_offset =3D *relocs & 0xfff;
+			unsigned long offset;
 			int type =3D *relocs >> EFI_PAGE_SHIFT;
-			uint64_t *x64 =3D efi_reloc + offset;
-			uint32_t *x32 =3D efi_reloc + offset;
-			uint16_t *x16 =3D efi_reloc + offset;
+			uint64_t *x64;
+			uint32_t *x32;
+			uint16_t *x16;
+
+			/*
+			 * This first check covers VirtualAddress + Offset
+			 * resulting in an overflow.
+			 */
+			if (rel->VirtualAddress > virt_size ||
+			    entry_offset > virt_size - rel->VirtualAddress) {
+				log_debug("relocation address out of bounds\n");
+				return EFI_LOAD_ERROR;
+			}
+
+			offset =3D rel->VirtualAddress + entry_offset;
+			x64 =3D efi_reloc + offset;
+			x32 =3D efi_reloc + offset;
+			x16 =3D efi_reloc + offset;
=20
 			switch (type) {
 			case IMAGE_REL_BASED_ABSOLUTE:
 				break;
 			case IMAGE_REL_BASED_HIGH:
+				if (sizeof(uint16_t) > virt_size - offset) {
+					log_debug("relocation address out of bounds\n");
+					return EFI_LOAD_ERROR;
+				}
 				*x16 +=3D ((uint32_t)delta) >> 16;
 				break;
 			case IMAGE_REL_BASED_LOW:
+				if (sizeof(uint16_t) > virt_size - offset) {
+					log_debug("relocation address out of bounds\n");
+					return EFI_LOAD_ERROR;
+				}
 				*x16 +=3D (uint16_t)delta;
 				break;
 			case IMAGE_REL_BASED_HIGHLOW:
+				if (sizeof(uint32_t) > virt_size - offset) {
+					log_debug("relocation address out of bounds\n");
+					return EFI_LOAD_ERROR;
+				}
 				*x32 +=3D (uint32_t)delta;
 				break;
 			case IMAGE_REL_BASED_DIR64:
+				if (sizeof(uint64_t) > virt_size - offset) {
+					log_debug("relocation address out of bounds\n");
+					return EFI_LOAD_ERROR;
+				}
 				*x64 +=3D (uint64_t)delta;
 				break;
 #ifdef __riscv
 			case IMAGE_REL_BASED_RISCV_HI20:
+				if (sizeof(uint32_t) > virt_size - offset) {
+					log_debug("relocation address out of bounds\n");
+					return EFI_LOAD_ERROR;
+				}
 				*x32 =3D ((*x32 & 0xfffff000) + (uint32_t)delta) |
 					(*x32 & 0x00000fff);
 				break;
@@ -163,7 +216,7 @@ static efi_status_t efi_loader_relocate(const IMAGE_BA=
SE_RELOCATION *rel,
 				break;
 #endif
 			default:
-				log_err("Unknown Relocation off %x type %x\n",
+				log_err("Unknown Relocation off %lx type %x\n",
 					offset, type);
 				return EFI_LOAD_ERROR;
 			}
@@ -970,8 +1023,9 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj =
*handle,
=20
 	/* Run through relocations */
 	if (efi_loader_relocate(rel, rel_size, efi_reloc,
-				(unsigned long)image_base) !=3D EFI_SUCCESS) {
-		efi_free_pages((uintptr_t) efi_reloc,
+				(unsigned long)image_base,
+				virt_size) !=3D EFI_SUCCESS) {
+		efi_free_pages((uintptr_t)efi_reloc,
 			       (virt_size + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT);
 		ret =3D EFI_LOAD_ERROR;
 		goto err;
=2D-=20
2.53.0

