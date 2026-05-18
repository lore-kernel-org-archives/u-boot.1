Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60F6CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51FCC83EF9;
	Mon, 18 May 2026 16:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=calif.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=calif.io header.i=@calif.io header.b="LVy9AlFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9733084688; Mon, 18 May 2026 10:03:29 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85F0783AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=calif.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anas@calif.io
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-393da8f389bso19809161fa.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 01:03:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779091406; cv=none;
 d=google.com; s=arc-20240605;
 b=QHwtsT9kte+s32v7/OX4GdAmA+w8BOa0tulsao2LEQs4r7L4Nhqs4+netMVqR8mBA1
 bhHABb2k613N/16jsYaYNaJmJNrRd8QmCKGS7AWSk+FYiGENkZtv+a7FvzZjxtGflEOd
 MWXNV2nMI0ECrxYKpZpj5psfEygwOu6qQq3B77tF/A9x3FQVlflRsNnqFGkWssYOAmmp
 F6ZFOwHixHbMDLkh1R4t7CvF5O0Aj0qNAyWUlJ+WZHQh8lQFRq60YVansYQEqzX7vBrg
 b2MB3f7cN2G3wan9qY/0wHfCle7PAfvJ1OEvHXXjw+AQjzwXJ257oAV4WKRRu8FI5oRv
 m4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SKLzULyhBm4+fXmnY5wqiiQnva0+QY9raWAMtkLHkQE=;
 fh=1z/AtB8f5r3LzqUle48E5ND4n5J6gqZRfbVDmF/s4g8=;
 b=Epo3nwPwBASrS4waf/LQj1T8UQKcdcwRhfwLu0p2SeK5n99aEI1AznpMJrku05rfI9
 zI2lsT42ysHV26L6i4+gf+C2ybnpDhaRjydn46dIRaHhs8iTyWUn13alcAVyL0izRHUX
 0eOCJZo7gM5x3YltkiNJJ36oQrtwF6lpXCM17P0fG/pIrRjIb+laKKNJoV+3ky99shnz
 0YLSgNnmtsqELCIKCAcg3jALdbP684ByoK5zBotP5j07Yi28pIp/aaPgYT25rftRfO1I
 xXnRr7D9E6a6anB9RohtQ7lTjp9045SNZQknboQ/jlGBNmH7q2nwl54x1L58t4OlZ88W
 3Zbg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=calif.io; s=google; t=1779091406; x=1779696206; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SKLzULyhBm4+fXmnY5wqiiQnva0+QY9raWAMtkLHkQE=;
 b=LVy9AlFgs2TXj+hixziexVv4DLJHn0LGb0wX2n6P5komh4uNfXXbFQvxzZi9J3OmVA
 BVMngMOgRtH9PaGZoOn72wcP6ZIlV5M+tMlrqJAEwLWPOTU7PJEaoxnKb3+mHXAsuFKO
 dXqhV+f+XS/i8ysgdobU2BhLNy6zcVT8uAAtKa8Oa2h+3vG/x/vl01wBBOep2IhxD//D
 +OANhZ4SidggBxPm4qIwbLsdGGTBtQx1CHFJtZyWB5+fUg4TQVIznEGf77COZaL+A0nd
 VJe3JiXYB1Y5eFAzyWK3KcBrjgZNK3m2mGd+pswCpAQTuIKbjLYy0fQbeqBKpevacsKl
 8neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091406; x=1779696206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKLzULyhBm4+fXmnY5wqiiQnva0+QY9raWAMtkLHkQE=;
 b=EGvDoQlgomeW1v3PWwPNlKJe+hjqu8mWn3TAMjoy0Yq+coUYnGzrZXsqhQfHlcll+k
 GpDe4zLHPa96uratWZB3h1lmKON7X/AqxxzBAdYBgbNNRZPiZjA8iUJASg942VHGKA/v
 iJQSQAdn+YdcW67YO3mzX+td+AvJw+lEdJRoVpd8clZcpKtEtOumk/A6loLQMtkfBY/V
 rK7akKxX+jhObNTW2BE7p+kuCdg8BBpJ2S2sxS9QAQar8M4OCPwXcoNIjFAyYJN98wrr
 BxwK0L0XUrThY59ECexP/lLiG5xWMlbeIni3BOVgy6nCVxiivOEwpe7vl6QtZuz8/OoA
 hWQQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9G0HCoOC92xmpVmpYU8LirmN434IeO4TA73+K5sL7pPGO5XcNYq4/1XO8+4Nhhh+dESM0oCws=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4IzovF/oRupHtPzaMxTSRhsAqRCyLMXBPnrsYku7KDlOz2nA2
 9/C4/qMLJw5Ob8cMXNObgZLNNTsHQidHpArw9UvGqexXh313l44jFZcrpMHnX9e85LNdT4NgXzS
 YF0vqsLW8gpcvKqLCT8aRg2GzSEu1UAizg60zaa5C2A==
X-Gm-Gg: Acq92OE5C41AskOxL69SWMuRCgNIC1lLIjK1WRBv2Q+g62Mon7Ub4n7w+qtSX7iBN6o
 kfoSZLkO1psCHS2uJJ3mY1ETnQrnfmp/O3uL1DxehEH7+i8S++uVMg4C1dhEqua1WDMjS9mxuNJ
 3bBKCI1F9Xo9lGZwSOKUb6ccsDNiRwYqfE3RHeLystdYwhMgl4K6VEWOW/Y1pqTuIb4H6/ZHxNL
 1O9pVXzELgEXyOcAeV0gtEgqi5RdLdqj+G7AMmrqfG51omnU4loVxi/SZ8tCu4ep494iNOZV7ta
 1nzqjC4=
X-Received: by 2002:a05:651c:b95:b0:393:ca4d:2313 with SMTP id
 38308e7fff4ca-39561c08b61mr30838601fa.5.1779091405375; Mon, 18 May 2026
 01:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260518063020.181443-1-xypron.glpk@gmx.de>
 <CAC_iWjKwyj5jg=R-kJGi0i26hDrLAmjc+U7ZDVq7r2jLuBbwdA@mail.gmail.com>
In-Reply-To: <CAC_iWjKwyj5jg=R-kJGi0i26hDrLAmjc+U7ZDVq7r2jLuBbwdA@mail.gmail.com>
From: Anas Cherni <anas@calif.io>
Date: Mon, 18 May 2026 09:03:14 +0100
X-Gm-Features: AVHnY4L1W6e7iiAy1492kxvumZrHifLFIreJDVoJDiLpAHrNITHZh0yQuKzJPKc
Message-ID: <CA+J-LAz5dYfDAOovThwQZM9u6Yk+0m6m_pAE_UH=U6EMBXw5bw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: validate PE-COFF relocation data
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 18 May 2026 16:52:04 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,

Could you please change the reporter section to:
Anthropic Research and Claude, in collaboration with calif.io

Best regards,
Anas


On Mon, May 18, 2026 at 8:40 Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Mon, 18 May 2026 at 09:30, Heinrich Schuchardt <xypron.glpk@gmx.de>
> wrote:
> >
> > When applying base relocations from a PE-COFF binary all data must
> > be treated as untrusted. Add the following checks to
> > efi_loader_relocate():
> >
> > * Reject relocation blocks that don't start on a 32-bit aligned
> >   address.
> > * Reject relocation blocks whose SizeOfBlock is smaller than the
> >   block header, which would cause an unsigned underflow when computing
> >   the entry count.
> > * A block with SizeOfBlock == 0 is invalid and does not mark the end of
> >   the relocation table.
> > * Reject relocation blocks that extend beyond the end of the
> >   relocation section.
> > * Reject individual relocation entries whose target offset, together
> >   with the access width, exceeds the mapped image size, preventing
> >   out-of-bounds writes.
> >
> > Pass virt_size to efi_loader_relocate() from efi_load_pe() to enable
> > the per-entry bounds check.
> >
> > Reported-by: Anas Cherni <anas@calif.io>
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> >  lib/efi_loader/efi_image_loader.c | 76 ++++++++++++++++++++++++++-----
> >  1 file changed, 65 insertions(+), 11 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_image_loader.c
> b/lib/efi_loader/efi_image_loader.c
> > index d002eb0c744..0bc66a0f732 100644
> > --- a/lib/efi_loader/efi_image_loader.c
> > +++ b/lib/efi_loader/efi_image_loader.c
> > @@ -111,8 +111,9 @@ void efi_print_image_infos(void *pc)
> >   * Return:             status code
> >   */
> >  static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION
> *rel,
> > -                       unsigned long rel_size, void *efi_reloc,
> > -                       unsigned long pref_address)
> > +                                       unsigned long rel_size, void
> *efi_reloc,
> > +                                       unsigned long pref_address,
> > +                                       unsigned long virt_size)
> >  {
> >         unsigned long delta = (unsigned long)efi_reloc - pref_address;
> >         const IMAGE_BASE_RELOCATION *end;
> > @@ -122,34 +123,86 @@ static efi_status_t efi_loader_relocate(const
> IMAGE_BASE_RELOCATION *rel,
> >                 return EFI_SUCCESS;
> >
> >         end = (const IMAGE_BASE_RELOCATION *)((const char *)rel +
> rel_size);
> > -       while (rel + 1 < end && rel->SizeOfBlock) {
> > +       while (rel + 1 < end) {
> >                 const uint16_t *relocs = (const uint16_t *)(rel + 1);
> > +
> > +               /* Each block must start on a 32-bit boundary */
> > +               if (!IS_ALIGNED((uintptr_t)rel, sizeof(uint32_t))) {
> > +                       log_debug("Relocation block not 32-bit
> aligned\n");
> > +                       return EFI_LOAD_ERROR;
> > +               }
> > +               /* Relocation block cannot be shorter than its header */
> > +               if (rel->SizeOfBlock < sizeof(*rel)) {
> > +                       log_debug("Relocation block too small: %u\n",
> > +                               rel->SizeOfBlock);
> > +                       return EFI_LOAD_ERROR;
> > +               }
> > +               /* All relocation entries must be inside the .reloc
> section */
> > +               if ((const char *)rel + rel->SizeOfBlock > (const char
> *)end) {
> > +                       log_debug("Relocation block exceeds relocation
> data\n");
> > +                       return EFI_LOAD_ERROR;
> > +               }
> >                 i = (rel->SizeOfBlock - sizeof(*rel)) / sizeof(uint16_t);
> >                 while (i--) {
> > -                       uint32_t offset = (uint32_t)(*relocs & 0xfff) +
> > -                                         rel->VirtualAddress;
> > +                       uint32_t entry_offset = *relocs & 0xfff;
> > +                       unsigned long offset;
> >                         int type = *relocs >> EFI_PAGE_SHIFT;
> > -                       uint64_t *x64 = efi_reloc + offset;
> > -                       uint32_t *x32 = efi_reloc + offset;
> > -                       uint16_t *x16 = efi_reloc + offset;
> > +                       uint64_t *x64;
> > +                       uint32_t *x32;
> > +                       uint16_t *x16;
> > +
> > +                       /*
> > +                        * This first check covers VirtualAddress +
> Offset
> > +                        * resulting in an overflow.
> > +                        */
> > +                       if (rel->VirtualAddress > virt_size ||
> > +                           entry_offset > virt_size -
> rel->VirtualAddress) {
> > +                               log_debug("relocation address out of
> bounds\n");
> > +                               return EFI_LOAD_ERROR;
> > +                       }
> > +
> > +                       offset = rel->VirtualAddress + entry_offset;
> > +                       x64 = efi_reloc + offset;
> > +                       x32 = efi_reloc + offset;
> > +                       x16 = efi_reloc + offset;
> >
> >                         switch (type) {
> >                         case IMAGE_REL_BASED_ABSOLUTE:
> >                                 break;
> >                         case IMAGE_REL_BASED_HIGH:
> > +                               if (sizeof(uint16_t) > virt_size -
> offset) {
> > +                                       log_debug("relocation address
> out of bounds\n");
> > +                                       return EFI_LOAD_ERROR;
> > +                               }
> >                                 *x16 += ((uint32_t)delta) >> 16;
> >                                 break;
> >                         case IMAGE_REL_BASED_LOW:
> > +                               if (sizeof(uint16_t) > virt_size -
> offset) {
> > +                                       log_debug("relocation address
> out of bounds\n");
> > +                                       return EFI_LOAD_ERROR;
> > +                               }
> >                                 *x16 += (uint16_t)delta;
> >                                 break;
> >                         case IMAGE_REL_BASED_HIGHLOW:
> > +                               if (sizeof(uint32_t) > virt_size -
> offset) {
> > +                                       log_debug("relocation address
> out of bounds\n");
> > +                                       return EFI_LOAD_ERROR;
> > +                               }
> >                                 *x32 += (uint32_t)delta;
> >                                 break;
> >                         case IMAGE_REL_BASED_DIR64:
> > +                               if (sizeof(uint64_t) > virt_size -
> offset) {
> > +                                       log_debug("relocation address
> out of bounds\n");
> > +                                       return EFI_LOAD_ERROR;
> > +                               }
> >                                 *x64 += (uint64_t)delta;
> >                                 break;
> >  #ifdef __riscv
> >                         case IMAGE_REL_BASED_RISCV_HI20:
> > +                               if (sizeof(uint32_t) > virt_size -
> offset) {
> > +                                       log_debug("relocation address
> out of bounds\n");
> > +                                       return EFI_LOAD_ERROR;
> > +                               }
> >                                 *x32 = ((*x32 & 0xfffff000) +
> (uint32_t)delta) |
> >                                         (*x32 & 0x00000fff);
> >                                 break;
> > @@ -163,7 +216,7 @@ static efi_status_t efi_loader_relocate(const
> IMAGE_BASE_RELOCATION *rel,
> >                                 break;
> >  #endif
> >                         default:
> > -                               log_err("Unknown Relocation off %x type
> %x\n",
> > +                               log_err("Unknown Relocation off %lx type
> %x\n",
> >                                         offset, type);
> >                                 return EFI_LOAD_ERROR;
> >                         }
> > @@ -970,8 +1023,9 @@ efi_status_t efi_load_pe(struct
> efi_loaded_image_obj *handle,
> >
> >         /* Run through relocations */
> >         if (efi_loader_relocate(rel, rel_size, efi_reloc,
> > -                               (unsigned long)image_base) !=
> EFI_SUCCESS) {
> > -               efi_free_pages((uintptr_t) efi_reloc,
> > +                               (unsigned long)image_base,
> > +                               virt_size) != EFI_SUCCESS) {
> > +               efi_free_pages((uintptr_t)efi_reloc,
> >                                (virt_size + EFI_PAGE_MASK) >>
> EFI_PAGE_SHIFT);
> >                 ret = EFI_LOAD_ERROR;
> >                 goto err;
> > --
> > 2.53.0
> >
>
