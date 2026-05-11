Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EAECD484C
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 18:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2EEA83E76;
	Mon, 11 May 2026 20:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YYbB2N6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CC5A8460B; Mon, 11 May 2026 20:27:20 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F8083E36
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-67e24b8ef55so6411344a12.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778524038; cv=none;
 d=google.com; s=arc-20240605;
 b=XqHYAEBeCorlMU5xDMxOEo+gtn5/dfBY/0mr/t9fLHOgzVn9cl4JTfdEMjiFZ+TvmK
 Z8OLXlomnv4LTS3svF07gNK0Q3rqy2L1g7kk8Le92LcQdd0wI8GrHnVyEldpnHHotVIV
 zvs9NIrwCwV8mAMjPItff7zTXcAMCxFGMjOjBWZDWJJm5rDINycTu80tCst9h0/Sn6Tr
 6Rxk4E/oshZPhQiJRLXIjvrvEGnTeYzbIOZQr8KTDgWevl9/bwaT3qSOxtaw7ahjZGeL
 oPZzgBovfITKrFbbshYc+zp3GlLVobJEeVqZ+STCVCNEVskWB49cxlB5MvfWTZ500g88
 0XrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zL8nPTUKgN2HZpW+rKmmSGsrgoI0lcT+HU/P09Y1qW4=;
 fh=xWnM4bI9v4rl2OMQOk0VFj7YBxWYjPj0eDwE45J8Sx4=;
 b=ig0/XNIS560lB1Z0mZ77knsOj1bpjMgFiy4neWDMCiI90R4nehqbseuBXMNHCxpGc2
 NrAnP3Ah76QBqfwil2x442+ZOhDt99TWGoPBhiJ3eAsjvsJNok2yg4nI4qBRxVoVkxNJ
 1XO0K2zjJvNwBYslh7sgMx76j5IO3SV5RvVvlFDh96h0omBYc8yb+X1ByeOiyI9imJ3Y
 zdYux2KBLKV4GJEWzrRcMrk/ppBHSgb97HyTPCmjVNxtir/f3A8F6+/XuBkpb5b5H8TZ
 CKx5wrNrF2tNxvb1e1ZnYF87olY52tVW6vYQ2cQeaMeEsG3clIkj+W+VAaxBPR+tjJXu
 ZHdw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778524038; x=1779128838; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zL8nPTUKgN2HZpW+rKmmSGsrgoI0lcT+HU/P09Y1qW4=;
 b=YYbB2N6MVkF1KWe0sGs/ONw6d3nMeue4BWpJm74rIAntAMmmk5lUYtlkRluLNcmvJe
 KnoK6OoJQ35cFd6Ozu91CgtX9BYpXnAdAimPcEmXs56Gibdui5RZcO0jUrj1v0oXopz/
 zEO3KCB/5vh3UHQ9TyptzRj1DnPjqrtQRvpk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778524038; x=1779128838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zL8nPTUKgN2HZpW+rKmmSGsrgoI0lcT+HU/P09Y1qW4=;
 b=i80BxV48ugi0by3VvG5R4XupeDq/YReSPMaQhhSsLRuY0ESbHuByDM8hoXx/hJGhrc
 0GD33loiAJ0mwT2kAg4odcvWRgngzplGhZbN8yJL8NxtJ4gMKZd+aaDUwP/7Iv4QBwna
 qWaHYNO5SttRKtwNTkwWu5GGYO+yNB71PJcet4ujsOsoC2XgvtSBQmfbqSML78i41C3d
 Syquqecre0sBSYkBAezBqTYGki+Z5wAXgSjE84OBVolDpSVfq/vPSCYM1Ir/yHkrj9M5
 2qownLiUu2SV5S2P82Koc9+zl31bPcAmBjwuu+bmim9GHTuWsnVd/d2g/7R+NpE+bnIh
 3UCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9G2n7cIlQatAlDD1uQ3VkfHylLROF84BoUKv8FmvNl1uZke0/mHxi1TBGmhPp8tzzf9nneXp0=@lists.denx.de
X-Gm-Message-State: AOJu0YwzMhU6V3xG/K3mHqnEwwxMizzwsLdeHynCmeO5WifDCCPH9EMr
 di2XYk2+goQI+C7S+UhfvGAna7RGO0MyRzXawHhv0UQaSXGkjdnm4C5eZOrfkoztCrr0sQGkJhw
 OYYK4Idq5CiA9pRMhLWiovbyqZQdCeIce4w7zYQFG
X-Gm-Gg: Acq92OEqMswK5ADx1Arzix3jwdkt8lWlc7r1QRI0PjCkC/8xHWIPA+EFC7R/ffEZ/Du
 +w2jVoNO1QWAcl2TjBJiLAEoHhlOdd+KLwFq9UZpUDouQ///EG/Q4X3qDGwnSulV2PPpZilI7Cn
 wsYqQoHohwYLtesvj79xhSfMrpcSKEW81vcaEdogcLULCnDHsO0N1hPx47kAShaYq9xDXxuLhVA
 1wph4Y6zSAGtHwENRIxqLZtE/chbrmGRBkAnbER0A4xoIAWUo5K1qfa8gaOUy7RycKIKk2in1w9
 2Q6B3g==
X-Received: by 2002:a17:906:fe07:b0:b9d:8697:73b8 with SMTP id
 a640c23a62f3a-bc56dd15335mr1488237066b.22.1778524037873; Mon, 11 May 2026
 11:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260508222911.450165-1-rs@ti.com>
 <20260508222911.450165-3-rs@ti.com>
In-Reply-To: <20260508222911.450165-3-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 12:27:06 -0600
X-Gm-Features: AVHnY4J1ty1_aZ8-Pa6fXs14E43coBoyLAH6Z2lzog-23PZ0vVvQZPErlp-_fU4
Message-ID: <CAFLszThwhR=BaySior+Bev7Phi0AEGaR2_ASOVSFr00-cLPKpQ@mail.gmail.com>
Subject: Re: [PATCHv6 2/3] boot_fdt_add_mem_rsv_regions: free old dtb
 reservations
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
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

Hi Randolph,

On 2026-05-08T22:29:09, Randolph Sapp <rs@ti.com> wrote:
> boot_fdt_add_mem_rsv_regions: free old dtb reservations
>
> Add a free flag and an initial call to free allocations covered by the
> global FDT. This assumes that all calls to boot_fdt_add_mem_rsv_regions
> occur before the transition to the new device tree, thus we can access
> the currently active device tree through the global data pointer.
>
> This allows us to clearly indicate to the user when a device tree
> reservation fails. How we handle this can still use some improvement.
> Right now we'll keep the default behavior and try to boot anyway.
>
> This functionality was broken in:
> 5a6aa7d ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> arch/mips/lib/bootm.c |  2 +-
>  boot/bootm.c          |  2 +-
>  boot/bootm_os.c       |  2 +-
>  boot/image-board.c    |  2 +-
>  boot/image-fdt.c      | 55 +++++++++++++++++++++++++++++++++++----------------
>  include/image.h       |  2 +-
>  lib/lmb.c             |  2 +-
>  7 files changed, 44 insertions(+), 23 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

with some thoughts below

> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> @@ -108,12 +124,16 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
> +     /* Remove old regions */
> +     if (gd->fdt_blob != fdt_blob)
> +             boot_fdt_add_mem_rsv_regions((void *)gd->fdt_blob, true);
> +

Recursing through the public entry point with a flipped bool is hard
to follow, and it relies on the implicit invariant that the recursive
call will not itself recurse. I'd find this clearer as two named
helpers. For example you could have boot_fdt_reserve_regions() and
boot_fdt_free_regions() sharing a static walker. Then the intent at
the call site would be obvious.

Please also add a comment explaining the assumption from the commit
message: this must run before gd->fdt_blob is swapped to the new tree
(since nothing in the code itself enforces it)

> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> @@ -69,35 +69,51 @@ static const struct legacy_img_hdr *image_get_fdt(ulong fdt_addr)
> -     } else if (ret != -EEXIST && ret != -EINVAL) {
> -             puts("ERROR: reserving fdt memory region failed ");
> -             printf("(addr=%llx size=%llx flags=%x)\n",
> -                    (unsigned long long)addr,
> -                    (unsigned long long)size, flags);
> +     } else {
> +             printf("ERROR: %s fdt memory region failed (addr=%llx size=%llx flags=%x): %ld\n",
> +                    free ? 'freeing' : 'reserving', (unsigned long long)addr,
> +                    (unsigned long long)size, flags, ret);
>       }

Dropping the -EEXIST/-EINVAL filter only works on the reserve path
once the free path always succeeds. On the free side, anything in the
old fdt's reserved-memory that wasn't actually picked up by
lmb_reserve_common() (a non-enabled subnode, or a region since
split/coalesced inside LMB) will now produce a spurious "ERROR:
freeing fdt memory region failed" line.

I'm not sure if this actually happens? You could try it on a board
whose memreserve/reserved-memory layout differs between the U-Boot dtb
and the kernel dtb? Perhaps for now, best to tolerate  -EINVAL on the
free path at least.

> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> @@ -108,12 +124,16 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
> +     /* Remove old regions */
> +     if (gd->fdt_blob != fdt_blob)
> +             boot_fdt_add_mem_rsv_regions((void *)gd->fdt_blob, true);

Just to check - the cast drops the const from gd->fdt_blob and we then
walk it read-only, which is fine, but boot_fdt_add_mem_rsv_regions()
takes a non-const void * for no good reason that I can see? Worth a
brief comment so a future reader doesn't try to 'fix' the cast.

Regards,
Simon
