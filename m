Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A851CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 07:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91D4483FEE;
	Mon, 18 May 2026 09:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MANstd1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82EDF84659; Mon, 18 May 2026 09:41:02 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB7CA80398
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 09:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-651d6347a69so3715220d50.0
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:40:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779090057; cv=none;
 d=google.com; s=arc-20240605;
 b=bi6yA8m2O2Q+RHFJm+YFTQhi/fz8JwK+nUrKzS/TDQH3cWLHXjl4BM8CnSzLkjrHXz
 6z2AcbllGiZjwQJI+dduGoIAIwi2nT6Xd8KC2sQEeTE1Uu9b2xWkLNYnlwVfaNQooI6O
 4PeE0eGDTRTY2A/FFiGoH+hiDr6viGR8L4QX3wl8afA9b3jucF9dWVKneIjdAnQr3/5J
 5GUMUU+EXwWtza8LS1YhhuojK/8O0PYWkLwleELy7cSwj6t8lGeGanCrVHo2hpyq4+wF
 BOo5dYE1/7kKjeGE4EMaksbOnh1aMGrz+3KUxig71lHdADPR5Kxw7ojeQjUjqfyD1J8E
 2IoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3Wf0TKUocX+/I3QqqFHj7nmE4jXzahKUSymzlBbxB7g=;
 fh=Um/mrHKmBjrFskrY7fdCHM/Zi3R9OYZCdNzf/VSKDfw=;
 b=VvYjJlR2uuRx7eiEZntmuAUmzNE4lq1/KKBuuY9yI4Y7EiGXTDi8XogncFma6ZQjZW
 +8LBsQxNxdabxJwD3H8wvCO32uGYWPQp2CIIEI9Y80YNltBYwqFOQeLSk0RmAI9oajnW
 h5BRVdLAcFpluZkIrHoUNi/8NGlUHuw66K6TrkdgLunQ9XwvylTam8EIEq4QQ7qgaPww
 OxprcVV60VAx1xScuj0eBUg9Zn0A3Rci4Bi1ccrqVd3lViAqtmyzuE5j1NXK7e5omXwt
 gi9gqMH2/p0+IkeXtwIAH99Kk+DPfIC4ddPSjbOhN5Avi29GCnAB/ktZzHV74HNq2zAA
 rDbQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779090057; x=1779694857; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3Wf0TKUocX+/I3QqqFHj7nmE4jXzahKUSymzlBbxB7g=;
 b=MANstd1Wc4YU4Y3UQE9M43Yic4pw5ZnqVl5bujF3AJwQU314Rk3ept1niY2VnOxVM2
 z8pYDbBmH+slbsjeHhC9YB+55Ym9jx9mG+S1LhD5srviIVQO+4JXT+dnRnu0AoX4q/iE
 K+PRQfaBTvyuTW4BOMIQcYCu5aBwya+0fnC3oDMsXXAGYFrx1/ctw/WuU+/VPwZMZMrJ
 4HtQG6j/c1/r1rig2l/wtyMvGIVOODMNNhJdBkL7rA87EZ/LWjXQFYHqXc3hRXPIbHTa
 xLDSjOQ/kwT1ctOww2HtftsiK+v8MSCE601WRxeGA5j4KNfDl1jvEBtUpYOa4YfRsPMd
 nLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779090057; x=1779694857;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Wf0TKUocX+/I3QqqFHj7nmE4jXzahKUSymzlBbxB7g=;
 b=IIPba5TggSClePa6U1ayMVcBFOpLvpXrceI/tkIGaFPHM72lYGZZ0PkpJVniZPVLud
 4bOvIER2QHv2MQhUkEFcbM24tha9Ly8DJ5E/lCXdiCkh10d13kfllUYOGPfFLgeOEfL1
 AiGqgPW0jew9ZJLNjZbNbydgu3Ceg26/IqCkybedUq4Qlk1BJ3XxB7U6SrlyDHwuS0JH
 RXbkIJoL4yk8q9/RO1vL5LNY7vU3XPofURddX9k0xdbUg90Y/Otx2IKm/mqNy+K9mEXm
 fdX1qMNkF7m/ZKcok+WjEtMTl7FWH1c5OueEBUu4JnDMMu1mPtKi1O0ywroVMkdIPGV6
 6nbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hdHez0Dxc9ZXWV2WBSoFMTDdZLhBq1X8fUwePSUmaCmR1KPNVMqRP/mJEFo411+iJuI2ZU10=@lists.denx.de
X-Gm-Message-State: AOJu0YwL4b+FGAOLrJLcTZPZ12rKoxgGjn4bTwEfpEEgo7cyKeaXUWix
 TdyKspAlNlibL/Ww9WKHqffhu9WSs3Dpj/QO1r/k3rYuuFRE1BHJIjK2xOpfbmSXjcRwYIizg7L
 7CEtaRDHfyuS0uxupcqGhfxS4nsovAmLeBkHgZ7ISxIBnvQpFaWwgzgI=
X-Gm-Gg: Acq92OHf4N4F1nZ7YoVcZ58Y3+tZWGB8jkOn86eRSz5KXesVzcx3qEjWza8Y6H8Kcl1
 U4J0yfo6Rgw+ZIwOiFvcoTyO2yOThu6AoYUqus1vJcl9PYvOuXZI+mIt0Cxib3i7WpioNNWGW37
 4PWyN7OktJRN4DQY5lBKl14v6049ID5m3MyZFjUdWxnRKiDTkgmgMU+tPNbPCD+LMqcwnEMvecM
 aNIL8SkKIk2xh88MyHEjzs/tqxb9zp39U2F0ScvM15zH7aB6MAYXHXyVurAweTqduTNecZs3LHg
 f15S3oPhxVE6Y1Ycmzw9egEPmR5lXSqvSFd838w6AQuxHutpBPcAJL1GoaUk4dTllTn7kKhuq96
 5eFJtrBAmb9vig73vp/T/rarShVbb7Ap3TnxvWqmsy56XRkeTk53jP7Pas41W9UpuAFjthL+O8N
 JB3cBRmyEvcUhwAli/BGOV21Uiosecp4W0Eo9NFAyJGsRialhs59upQN9+oowJ1wjpHOtPB+99c
 1MZ0XGZh9mWqxb6NoW8AMbI6jpYir+dzdc1x78/MJeXoPus751FsnhWPCvkHt1FJgopww7lSw1c
 kl+OLyktuqF0Q0aODq7OLwZXh9X3hQbmqBIGFNWrSDjPnzJdJBNGoBWdJzSYMWeHpN1bihJFumz
 a/XZvdg==
X-Received: by 2002:a05:690e:4141:b0:654:4441:75f3 with SMTP id
 956f58d0204a3-65e0afea072mr15390358d50.1.1779090057258; Mon, 18 May 2026
 00:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260518063020.181443-1-xypron.glpk@gmx.de>
In-Reply-To: <20260518063020.181443-1-xypron.glpk@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 18 May 2026 10:40:20 +0300
X-Gm-Features: AVHnY4I1fFQ0E0JNAufn5Dxk-VnXBf-9pE1Te0OMuNhIocZxRP1D1NUF75Qqygo
Message-ID: <CAC_iWjKwyj5jg=R-kJGi0i26hDrLAmjc+U7ZDVq7r2jLuBbwdA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: validate PE-COFF relocation data
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Anas Cherni <anas@calif.io>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Mon, 18 May 2026 at 09:30, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
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
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_image_loader.c | 76 ++++++++++++++++++++++++++-----
>  1 file changed, 65 insertions(+), 11 deletions(-)
>
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index d002eb0c744..0bc66a0f732 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -111,8 +111,9 @@ void efi_print_image_infos(void *pc)
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
> @@ -122,34 +123,86 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
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
> +                        * This first check covers VirtualAddress + Offset
> +                        * resulting in an overflow.
> +                        */
> +                       if (rel->VirtualAddress > virt_size ||
> +                           entry_offset > virt_size - rel->VirtualAddress) {
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
> @@ -163,7 +216,7 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
>                                 break;
>  #endif
>                         default:
> -                               log_err("Unknown Relocation off %x type %x\n",
> +                               log_err("Unknown Relocation off %lx type %x\n",
>                                         offset, type);
>                                 return EFI_LOAD_ERROR;
>                         }
> @@ -970,8 +1023,9 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
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
