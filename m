Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA875CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 12:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0E4084857;
	Tue,  2 Jun 2026 14:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K8eoPODZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 631ED8485F; Tue,  2 Jun 2026 14:58:37 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD72784855
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 14:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7e1916922b9so30213187b3.1
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 05:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780405113; cv=none;
 d=google.com; s=arc-20240605;
 b=TvG6DuVjeHLXeIiqqc4VGz/p4fewKTCNHnRHLB9GcZMpp3E1Et20ZTQQCiUow558GT
 B1rK7IAQNDxffSFYrHptFzV47L28fpt+o8EBpsIISSPOKR6Nao+dojSgJHzj7hAUYc/6
 QLMk257OogMrQTczvZ1YydDdxX2EeWQah3D6/xZhW9ausjtIK1hOXFRxjJWDvYRtJdTe
 Giq9Pv8MCziaTFb47DOPz7rUHD9BaoUq2ThQolu9c2eXvBmZXlemcxGNdzt99iH6sZuv
 xFbeg0fwA5LVjzmziStq0PtoSOlsd9dX8CHOBLNmNkgZkXaLfzzKaX6Fy2VaxW2t5zYA
 3m/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wxNQZUGzdvX5Q/wWDWBzFNaMb8kc6DYvhVFDbC9ya4k=;
 fh=3/9eoeoKSf/hOpj320kFmi4Vc5qdwcxTt5nqs509eME=;
 b=RQ8WAMOv1viCHPpyLglKHMYZHBZ3L/y1O+1Lksf5OXSkipB+8WVVHwJfpeMqNXL1IR
 TZhvvKdn9Gnmh765WojQC4gDYr57fc/R5x420GFi/yGbelOA77p0LFUR/zx5s2EwZ/eA
 oTOgprDJA9iZAMDw55vsMVQGdvp85meIZIEOe+I2BJL6G0amiBYNMFkc1t20sfDd7AvX
 pKZeAb7E65DXlV/kgeSYb8hYvEI2nJF1EcBEg5a99afTy/ORpPFo6axO5TFPRCktxz8n
 OOCDhjim5nvippEDxFn5US+XDQ0/PKUpvolE4XpMvcka+n0sPtKH6OrVxgGUiZ6OlerQ
 KFWg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780405113; x=1781009913; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wxNQZUGzdvX5Q/wWDWBzFNaMb8kc6DYvhVFDbC9ya4k=;
 b=K8eoPODZzHW+3m//oXKJFOCwO49nNtcCdUpvEStxU8TyRRPdEgNZ5gDZLFCeHT+pWl
 bn+/3VdvQOhei8odne1o81t/SUZdaWV5VPnHlB39Ly1kJaMA4Jw0gE+NEKBijhcGt6C4
 UbGdA2dGGva2KT2K7nz3xaA4+Cc1QzCnFksn35WHSoPbfxf+7tVvGnmf8p7CEsuoZHL3
 8Db3WJXPhef0XcQ6WwUVlbKWEBakz0hE/Jh2uCGQq7RXSWponucjKCjJXN7gX/plUNzT
 wzpsyAV8Dp9okOlJj2S4QPuei8jdLbrf56hflxCcBRPxfFmCgex83rEpE2dJ5CluUHri
 DqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780405113; x=1781009913;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxNQZUGzdvX5Q/wWDWBzFNaMb8kc6DYvhVFDbC9ya4k=;
 b=NJQ0gtddk9cks4ROxSpNTEBlNYaJ1RJmfGUFyKAhp6lTdCrFcRn6oNZLznbXur5Jjb
 hpOReLgoU8szhdE6u9TliKakci1TJnzC7InmJyIVRgF1TrTPlxX9qfmVVl2RzFT6pJJT
 noxm9LJj2gwzomUU90Kbxe0dm0Kt9cW/j/XRiO63axSyqCA74m0urmwGiIO3zNQsea2N
 dwkPok0bUitn1qxuOhnilxNLPBtY3inHuNiumbyh2KMtuoOTucx9Ghbz7X9Vgr4gWLmU
 57EZMIzpdulQU9q3Ga6YOZVQRFTgkjiwLicD+ypPmF1lrQ9yq+cmT/K7h9OuCqggtHPx
 aKJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hgLfUIqyPiejKlowSO7kUAAv0uMvhJHzlcXVWc38ou6cObexrwmTAXu3BPis5r0Dx1tj0310=@lists.denx.de
X-Gm-Message-State: AOJu0YxACwx3wz2WyT4Z+QlJ4hVlxUUNeebSTsXYCh2uoCvl312zF+vx
 dYLSAV+iJAjjT3YM1ncIuMzU8d7UpTzS+ZwmUmMlM5BET0GmYvg/TteVyIs2tpEk15u/B6oeyjU
 7t7nKpx6bHQsfFq5fjbPVFLtlKi4eSlpoQOdbGWR7HFnFbJQkgOJoeA39XA==
X-Gm-Gg: Acq92OFBb6WRr4AYnjiSm/10pNxPBdKl6Cpoy4KlsZLpxR6aKNccD7DSMPctJF9gCVn
 CKcpYaN00ZV2lLGzfuuDHOFF3yuPsjwVMrw9KyLdZDPxxCSo9viCf2ORw8K/Z3liEF6QmaVSQ5u
 v2XVuNRgFnOjBNFnaY/lAfsmhywllo0kwD23ysimCqGFRhjF9/ZdmK9v7QzkJJzaGNeKa8tEKB6
 xvIZMIIrolx/DsJe5PZSP7qqfA4olt/dCIja5/bLyjXbZgQF6LwLA36iaxOceJccetgwkcCmpda
 awaV3YzdUUMO64qQc4cu2nPPW6X2MYZbTk3/qyHgTigPrvch9ZDFZ4EVnpPV4kJvU/dmnd1Ba1Y
 oHo9v1feVjkVPG0qNP+01t5+xT/F/mOtH6OyEAqDXgtnnMqqFYkyOx2XlmGrSC1bG4bmYzX4AI/
 n/RN53jq/fFtF8L/sLEzIsmOSuzvn3lGn/eXofLXVYRoEXYYs3x0kGX4/a9LQrYj8+zYE1iP5X2
 igZ+kuHRubKCLqNz7icbkzkHcD/xdoNi8SFpoM3HXBGPtUeh7ZJ7YIsRG27WrDUui0ASY3cPTSs
 BsatCTHNlNnvcuGlI1kKsiLhhHCEfPHUNXcBOWECurKcdEHF835UNh8WkHCCzyOFW3472ZSfogy
 Ra3Z+g4/eJb5csUvD
X-Received: by 2002:a05:690c:260f:b0:7d1:cb48:6690 with SMTP id
 00721157ae682-7e05e854f52mr133979137b3.40.1780405113068; Tue, 02 Jun 2026
 05:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260601132053.186064-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260601132053.186064-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 2 Jun 2026 15:57:56 +0300
X-Gm-Features: AVHnY4JEcIdH7Ku62_Ie5Uya_-y7Iy1CvPRBOyMwxXtjgZ5YEfr0utqIR8H3Kio
Message-ID: <CAC_iWj+KNaUsyYRZ8-awtaVZpGjUs21na3MgEhYoroUzeVCKaA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] efi_loader: validate PE-COFF relocation data
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Anas Cherni <anas@calif.io>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 1 Jun 2026 at 16:21, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When applying base relocations from a PE-COFF binary all data must
> be treated as untrusted. Add the following checks to
> efi_loader_relocate():
>
> * Reject relocation blocks that don't start on a 32-bit aligned
>   address.
> * Reject relocation blocks whose SizeOfBlock is smaller than the
>   block header, which would cause an unsigned underflow when computing
>   the entry count.
> * A block with SizeOfBlock == 0 is invalid and does not mark the end of
>   the relocation table.
> * Reject relocation blocks that extend beyond the end of the
>   relocation section.
> * Reject individual relocation entries whose target offset, together
>   with the access width, exceeds the mapped image size, preventing
>   out-of-bounds writes.
>
> Pass virt_size to efi_loader_relocate() from efi_load_pe() to enable
> the per-entry bounds check.
>
> Reported-by: Anas Cherni <anas@calif.io>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> v3:
>         add new parameter virt_size fo efi_print_image_infos() description
> ---
>  lib/efi_loader/efi_image_loader.c | 86 +++++++++++++++++++++++++++----
>  1 file changed, 75 insertions(+), 11 deletions(-)
>
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index d002eb0c744..f9a2d2df405 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -108,11 +108,13 @@ void efi_print_image_infos(void *pc)
>   * @rel_size:          size of the relocation table in bytes
>   * @efi_reloc:         actual load address of the image
>   * @pref_address:      preferred load address of the image
> + * @virt_size:         virtual image size as provided in the PE-COFF header
>   * Return:             status code
>   */
>  static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
> -                       unsigned long rel_size, void *efi_reloc,
> -                       unsigned long pref_address)
> +                                       unsigned long rel_size, void *efi_reloc,
> +                                       unsigned long pref_address,
> +                                       unsigned long virt_size)
>  {
>         unsigned long delta = (unsigned long)efi_reloc - pref_address;
>         const IMAGE_BASE_RELOCATION *end;
> @@ -122,34 +124,95 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
>                 return EFI_SUCCESS;
>
>         end = (const IMAGE_BASE_RELOCATION *)((const char *)rel + rel_size);
> -       while (rel + 1 < end && rel->SizeOfBlock) {
> +       while (rel + 1 < end) {
>                 const uint16_t *relocs = (const uint16_t *)(rel + 1);
> +
> +               /* Each block must start on a 32-bit boundary */
> +               if (!IS_ALIGNED((uintptr_t)rel, sizeof(uint32_t))) {
> +                       log_debug("Relocation block not 32-bit aligned\n");
> +                       return EFI_LOAD_ERROR;
> +               }
> +               /* Relocation block cannot be shorter than its header */
> +               if (rel->SizeOfBlock < sizeof(*rel)) {
> +                       log_debug("Relocation block too small: %u\n",
> +                               rel->SizeOfBlock);
> +                       return EFI_LOAD_ERROR;
> +               }
> +               /* All relocation entries must be inside the .reloc section */
> +               if ((const char *)rel + rel->SizeOfBlock > (const char *)end) {
> +                       log_debug("Relocation block exceeds relocation data\n");
> +                       return EFI_LOAD_ERROR;
> +               }
> +               /*
> +                * Relocations must be within the virtual address range.
> +                * This also ensures that there is no overflow in the
> +                * entry_offset check below.
> +                */
> +               if (rel->VirtualAddress > virt_size) {
> +                       log_debug("relocation address out of bounds\n");
> +                       return EFI_LOAD_ERROR;
> +               }
> +
>                 i = (rel->SizeOfBlock - sizeof(*rel)) / sizeof(uint16_t);
>                 while (i--) {
> -                       uint32_t offset = (uint32_t)(*relocs & 0xfff) +
> -                                         rel->VirtualAddress;
> +                       uint32_t entry_offset = *relocs & 0xfff;
> +                       unsigned long offset;
>                         int type = *relocs >> EFI_PAGE_SHIFT;
> -                       uint64_t *x64 = efi_reloc + offset;
> -                       uint32_t *x32 = efi_reloc + offset;
> -                       uint16_t *x16 = efi_reloc + offset;
> +                       uint64_t *x64;
> +                       uint32_t *x32;
> +                       uint16_t *x16;
> +
> +                       /*
> +                        * Relocation address must be within virtual address
> +                        * range.
> +                        */
> +                       if (entry_offset > virt_size - rel->VirtualAddress) {
> +                               log_debug("relocation address out of bounds\n");
> +                               return EFI_LOAD_ERROR;
> +                       }
> +
> +                       offset = rel->VirtualAddress + entry_offset;
> +                       x64 = efi_reloc + offset;
> +                       x32 = efi_reloc + offset;
> +                       x16 = efi_reloc + offset;
>
>                         switch (type) {
>                         case IMAGE_REL_BASED_ABSOLUTE:
>                                 break;
>                         case IMAGE_REL_BASED_HIGH:
> +                               if (sizeof(uint16_t) > virt_size - offset) {
> +                                       log_debug("relocation address out of bounds\n");
> +                                       return EFI_LOAD_ERROR;
> +                               }
>                                 *x16 += ((uint32_t)delta) >> 16;
>                                 break;
>                         case IMAGE_REL_BASED_LOW:
> +                               if (sizeof(uint16_t) > virt_size - offset) {
> +                                       log_debug("relocation address out of bounds\n");
> +                                       return EFI_LOAD_ERROR;
> +                               }
>                                 *x16 += (uint16_t)delta;
>                                 break;
>                         case IMAGE_REL_BASED_HIGHLOW:
> +                               if (sizeof(uint32_t) > virt_size - offset) {
> +                                       log_debug("relocation address out of bounds\n");
> +                                       return EFI_LOAD_ERROR;
> +                               }
>                                 *x32 += (uint32_t)delta;
>                                 break;
>                         case IMAGE_REL_BASED_DIR64:
> +                               if (sizeof(uint64_t) > virt_size - offset) {
> +                                       log_debug("relocation address out of bounds\n");
> +                                       return EFI_LOAD_ERROR;
> +                               }
>                                 *x64 += (uint64_t)delta;
>                                 break;
>  #ifdef __riscv
>                         case IMAGE_REL_BASED_RISCV_HI20:
> +                               if (sizeof(uint32_t) > virt_size - offset) {
> +                                       log_debug("relocation address out of bounds\n");
> +                                       return EFI_LOAD_ERROR;
> +                               }
>                                 *x32 = ((*x32 & 0xfffff000) + (uint32_t)delta) |
>                                         (*x32 & 0x00000fff);
>                                 break;
> @@ -163,7 +226,7 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
>                                 break;
>  #endif
>                         default:
> -                               log_err("Unknown Relocation off %x type %x\n",
> +                               log_err("Unknown Relocation off %lx type %x\n",
>                                         offset, type);
>                                 return EFI_LOAD_ERROR;
>                         }
> @@ -970,8 +1033,9 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>
>         /* Run through relocations */
>         if (efi_loader_relocate(rel, rel_size, efi_reloc,
> -                               (unsigned long)image_base) != EFI_SUCCESS) {
> -               efi_free_pages((uintptr_t) efi_reloc,
> +                               (unsigned long)image_base,
> +                               virt_size) != EFI_SUCCESS) {
> +               efi_free_pages((uintptr_t)efi_reloc,
>                                (virt_size + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT);
>                 ret = EFI_LOAD_ERROR;
>                 goto err;
> --
> 2.53.0
>
