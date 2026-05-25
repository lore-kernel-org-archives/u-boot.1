Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DD7CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7333284879;
	Mon, 25 May 2026 17:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GIYZpBKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0217E848AA; Mon, 25 May 2026 17:13:38 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B47E48482E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bcc9fdc959cso1725441266b.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722014; cv=none;
 d=google.com; s=arc-20240605;
 b=dVPtW4LYh9ENPRGrfa9OQuGSl8mvxIP9vSqN7UQwUG/KG6Eobo5nspa+7rGJCDAbpz
 VHftcrGR2/iw8cFmhz5a9nj0Yhd9TxTzUaDaozAyApgzg0WlLYVe0/2y/tkunbnPVCsx
 B+n+/gZl3dPKJzI/K+/oQtOWT9aQ4opQqCT+rSElbRWBOsvN48UB1b9z7RgXWk24SMud
 Q8SLyGeDTLGMWVF0+GDTBayDTY/+dKxN70k6VSyTE6x+iHstVc2RF28SJ/rVGKfrOb6v
 GtGsuFVEuGTF/s5Nj1KbAdrOhHRBX4tcLdkjuqTMHiYc2oWumpgAhXqnThSMB0KG3g5l
 sCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VKWktZ7R/H1XQvIPo3A2DSTkF50+RCuxLgTFLXGVs9k=;
 fh=0pR4YD3SJM2JcTxU1fvKGr+5JLXR8uWzsM/BA2iJ8uc=;
 b=JGx6fGVpg+aKubwNRu93iwPTvjFbs8sfP6DR1sn3yWsO1lTmnu+rHj5J+b+sgpkwcx
 tN2CI2Yc04sK8TcK/gu6fXN5aOq7K/VcZIVdcc3buORYbIJrr7UhQygKkACDO1wZvOnh
 0RgpxLIAltU2X38y7QNKFgCfb1nSVfOwL8PAoX//lGMANlsaD5fMiwOyjQH+bAkTe5yb
 UgyXR3ta7+MQb4YKhc9D5TbpxB1+4ya4Sw9ToiIkWJr8mo8e4aYnWyW0etbaM1zBgcDG
 0gt7PvedcK9ZGyyEu/9In9RaFqoYaL8y4pjmSleHMsU0SWSiOUz8lLt8NET1tzDQi9XU
 WLMg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722014; x=1780326814; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VKWktZ7R/H1XQvIPo3A2DSTkF50+RCuxLgTFLXGVs9k=;
 b=GIYZpBKYpxYsLDxYs0ymg2iTdSoLy6xNdU4y/rkd7rKkw32g1CV6FC4OXXajzgyuOY
 08etyRGXVptPZdl+YdGqoMKLsoATFgnM9biYUZahp6SG7nJbj3QTZpEBRyAV5Uu3eDFu
 z3WI436PVWZy6MgkE0afUXNSnjlGIxZNCeC0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722014; x=1780326814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKWktZ7R/H1XQvIPo3A2DSTkF50+RCuxLgTFLXGVs9k=;
 b=cXK9t17X/QXaeJShqFjFS04PdDPXi/4cpKIWSBvZ3Jeh6Mhx+UMXCfvkyajmgqr8Vz
 FogJKFrgi1yPo2PaOIPSqR/IZq8eDEY8d4f+fj6a05Q3EvUo6jfkIw6uqL10WnOehgW1
 7wZGw5W5NBl0scTuF5ut5ni0adqPdpuITWLvnhyHX4A5F9RqwE2dW/wh/1LjvKrdvq4V
 kP1AmOHuRjuAhLEuGhiMn+7GymuWGjgqDG33jFIYQgJolFN/kYnIaO0O4FVdZNMfYF4D
 HqO/bcG4JgJHJW6ECrRbTwQ2DAsSbBUFdFM8/4OruwDf01fCZGb0a8PnXM7bkw6r/7kG
 rZyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SployJ5yg+b47UYIqDIOs3W3dpnQq7SXid3dhUCRYoPQ3kouXKhMF+yOvasksFqfxF8I51IY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9exI0heyzJBT9tjqT12OYaiXFN58ubblhoHIqtup5p2bw8des
 zxtxsmwTSUw2XWwiZdDGTmk4iZaKu/XVdNOFiILf6HdPIVgv8n+PQfpbC1B59xUVAsIp3bLARy4
 kiGYQIUWFL7hUJOHpJ3iMqbbrBoDmRtmlG5ASPZ9/LwofsZb2sd4=
X-Gm-Gg: Acq92OFdLl1nsOfU+duUp6VdZ7kWE6tFVRHvN0qgVW3a5rXloO3N5Vtm+aWIkKh3SCq
 3pIoxMJnlVVzayA69htFuY+ZGdeCTVPaBZhlYcev2FXlklfmkUUEdoXmU2EhcjO6yESeDr/gbDB
 KEROkdgyCa64e2W2yaeolPV6FkXxuvJ8came1xMNPpsh+cmAeirDSs67yselLED2x9USDSxzi76
 bfAjKKzrFWXL3ZHGZBDRj+I9rhmyfNj9XdMXm3188S7X0HyJB1RebeYyHdDMyhrlT0PTrRFURI/
 rPzMNg==
X-Received: by 2002:a17:907:1df0:b0:bd5:156d:835a with SMTP id
 a640c23a62f3a-bdd260d4e2emr643689466b.41.1779722014102; Mon, 25 May 2026
 08:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260518063020.181443-1-xypron.glpk@gmx.de>
In-Reply-To: <20260518063020.181443-1-xypron.glpk@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:13:20 -0600
X-Gm-Features: AVHnY4KfNwhzl7MSmuoPnq3kLYdfkLMAX8opR-XyLs5lSsP92dj9oi3enXy9ncI
Message-ID: <CAFLszTgQE2srwjB6MaZDPcRF6+9cZBBQ9VuumqqKgnZviJpZXQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: validate PE-COFF relocation data
To: xypron.glpk@gmx.de
Cc: Anas Cherni <anas@calif.io>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On 2026-05-18T06:30:20, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> efi_loader: validate PE-COFF relocation data
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
> [...]
>
> lib/efi_loader/efi_image_loader.c | 76 +++++++++++++++++++++++++++++++++------
>  1 file changed, 65 insertions(+), 11 deletions(-)

> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> @@ -122,34 +123,86 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
> +                     /*
> +                      * This first check covers VirtualAddress + Offset
> +                      * resulting in an overflow.
> +                      */
> +                     if (rel->VirtualAddress > virt_size ||
> +                         entry_offset > virt_size - rel->VirtualAddress) {
> +                             log_debug("relocation address out of bounds\n");
> +                             return EFI_LOAD_ERROR;
> +                     }

The rel->VirtualAddress > virt_size half is invariant for the whole
block - so it should be out of the while (i--) loop so it runs once
per block, not per entry. The per-entry overflow check on entry_offset
stays inside.

> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> @@ -122,34 +123,86 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
>                       case IMAGE_REL_BASED_HIGH:
> +                             if (sizeof(uint16_t) > virt_size - offset) {
> +                                     log_debug("relocation address out of bounds\n");
> +                                     return EFI_LOAD_ERROR;
> +                             }
>                               *x16 += ((uint32_t)delta) >> 16;
>                               break;
>                       case IMAGE_REL_BASED_LOW:
> +                             if (sizeof(uint16_t) > virt_size - offset) {
> +                                     log_debug("relocation address out of bounds\n");
> +                                     return EFI_LOAD_ERROR;
> +                             }
>                               *x16 += (uint16_t)delta;
>                               break;
>                       case IMAGE_REL_BASED_HIGHLOW:
> +                             if (sizeof(uint32_t) > virt_size - offset) {
> +                                     log_debug("relocation address out of bounds\n");
> +                                     return EFI_LOAD_ERROR;
> +                             }
>                               *x32 += (uint32_t)delta;
>                               break;
>                       case IMAGE_REL_BASED_DIR64:
> +                             if (sizeof(uint64_t) > virt_size - offset) {
> +                                     log_debug("relocation address out of bounds\n");
> +                                     return EFI_LOAD_ERROR;
> +                             }
>                               *x64 += (uint64_t)delta;
>                               break;
>  #ifdef __riscv
>                       case IMAGE_REL_BASED_RISCV_HI20:
> +                             if (sizeof(uint32_t) > virt_size - offset) {
> +                                     log_debug("relocation address out of bounds\n");
> +                                     return EFI_LOAD_ERROR;
> +                             }

Five copies of the same check make the switch hard to read. Please set
a width per case and do the bounds check once, e.g.

   size_t width;

   switch (type) {
   case IMAGE_REL_BASED_ABSOLUTE:
       continue;
   case IMAGE_REL_BASED_HIGH:
   case IMAGE_REL_BASED_LOW:
       width = sizeof(uint16_t);
       break;
   case IMAGE_REL_BASED_HIGHLOW:
   case IMAGE_REL_BASED_RISCV_HI20:
       width = sizeof(uint32_t);
       break;
   case IMAGE_REL_BASED_DIR64:
       width = sizeof(uint64_t);
       break;
   ...
   }
   if (width > virt_size - offset) {
       log_debug("relocation address out of bounds\n");
       return EFI_LOAD_ERROR;
   }

Then a second switch (or if-ladder) does the write. That keeps the
duplication out of the hot path and stops anyone adding a new case
without the bounds check.

> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> @@ -122,34 +123,86 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
> -     while (rel + 1 < end && rel->SizeOfBlock) {
> +     while (rel + 1 < end) {

Since this plugs a security hole driven by malformed input, please add
a py (or an lib/efi_selftest case) that feeds at least one rejected
shape - short SizeOfBlock, unaligned block, out-of-bounds
VirtualAddress - through efi_load_pe() and confirms EFI_LOAD_ERROR.
Without coverage there's nothing to stop a regression.

> @@ -163,7 +216,7 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
>  #endif
>                       default:
> -                             log_err("Unknown Relocation off %x type %x\n",
> +                             log_err("Unknown Relocation off %lx type %x\n",
>                                       offset, type);

Just to check - every other new diagnostic here uses log_debug(), but
the default arm keeps log_err(). I'm fine with that split, but the
other new "out of bounds" messages probably want log_err() too: a
refused image is something the user will want to see without enabling
debug logs, otherwise they just see the load fail with no clue why.

Regards,
Simon
