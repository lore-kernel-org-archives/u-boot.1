Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0137D2E9D6
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 10:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43BB088580;
	Mon, 11 Nov 2024 11:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zc6dZflY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71D9989377; Mon, 11 Nov 2024 11:47:17 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58CBD88599
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 11:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e2e2d09decso4029063a91.1
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 02:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731322033; x=1731926833; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cftWLT8r29JyL4e/25rUxfDwaIIxwOcp7eGkNZNwlsA=;
 b=Zc6dZflYL5VL3+fQGeVQBYhpVKcAfyNYyrSUmTlhDbUAVsk4gO+1dPoovgJNAB+MQt
 +6O/WoDLJaIyV7ARqAQi7VmrM8cMz0/gAgdMWrxJW+1pqh78/HPzJynkfD8Mil3kMGBU
 SEFoV9OWgMW3WASFmFjAhLiswDOYUQPerJtUsXMjJvstldOxjA74pscAfuYw3W3DLwjF
 qqA5EmK2tRRuYY6gebFcTY0825XcsgvbTPMzY8Lad/0+97QLAyOQj7W5zhgtzRJR3xx9
 Wwjo60TgZxZgIQxA2t8eKbCUbh3OYG0W7ufIh2xz7Hc5CmfGRzp9eHttgTMxK+HUhCJ6
 thxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731322033; x=1731926833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cftWLT8r29JyL4e/25rUxfDwaIIxwOcp7eGkNZNwlsA=;
 b=g90XBuFyji6AOOauZGWWKvjI54FTeeHA/veurHU/Aosk8MGMqYnFTFX5qEciKm1qhA
 lQlZdwXz9b9jlJGqFuflo+oViUDl+wilRjXdMaHzu6nQqHvN599SsHY28f1SxIKgfu+4
 YF0gxISJOMC0D9C1Dth+FDJxJXq8WlkRMyDzO7b8sXn0N8+/VWxsnsZjVD1Siul98OwJ
 2ZmjDoIgnwaeDmVvBGRxzkH+46RD+dcslsv8pEwUf6MtGQBac7t/zXJ3Fr77FQvQygPc
 U0+0bxM4lKePNAD3uJaaBny7X1MNs5fqnGEOY9rgZc6XbMirDiCfZ5wRBYdTiJ9p2Lgx
 IMYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlUA4ArQ5l2CZZ3jDcjaUBGklbaU4Wk3XHmB8/KHj+4F+b9rj7pxhOGbk4mgxwAh1sBDdEKdQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yzg7/7kfgde3Qf5Evb+MBi45xg6GAnOKjwtFJ9zvuG5EJuJEqVU
 ox3mv02RWNo3ZToCyHlZRoXLPst2sm424+Ej1aP3r3m5lj8e4uSkPy184swozlKBxkNquWseHbS
 9M9wf9fuiLNZetse5OtDYqlUsJrOSVtjv6opypw==
X-Google-Smtp-Source: AGHT+IELULwXSCtaa1bvYTffQjv7H33ADAXYkbFBZOVu4JbsAaoQ5Ross7kWF++Cgc2AJnlN1swTIjEbKOVd//UR+7Y=
X-Received: by 2002:a17:90b:4b0f:b0:2e9:20d8:414c with SMTP id
 98e67ed59e1d1-2e9b0a30173mr18325130a91.5.1731322032726; Mon, 11 Nov 2024
 02:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-4-sughosh.ganu@linaro.org>
 <35b2ecd1-5d92-4bbe-886a-82c567f0e20d@gmx.de>
In-Reply-To: <35b2ecd1-5d92-4bbe-886a-82c567f0e20d@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 12:46:36 +0200
Message-ID: <CAC_iWjKikR4QuPODRbAw3i7v0jjC3JnEaHJ3eTcj4=P4_S0pSw@mail.gmail.com>
Subject: Re: [PATCH 3/4] efi_loader: preserve installer images in pmem
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

On Mon, 11 Nov 2024 at 10:05, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/25/24 13:14, Sughosh Ganu wrote:
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > One of the problems OS installers face, when running in EFI, is that
> > the mounted ISO after calling ExitBootServices goes away. For some
> > distros this is a problem since they rely on finding some core packages
> > before continuing the installation. Distros have works around this --
> > e.g Fedora has a special kernel command line parameter called
> > inst.stage2 [0].
> >
> > ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
> > don't have anything in place for DTs. Linux and device trees have support
> > for persistent memory devices.
> >
> > It's worth noting that for linux to instantiate the /dev/pmemX device,
> > the memory described in the pmem node has to be omitted from the EFI
> > memory map we hand over to the OS if ZONE_DEVICES and SPARSEMEM is
> > enabled. With those enabled the pmem driver ends up calling
> > devm_memremap_pages() instead of devm_memremap(). The latter works
> > whether the memory is omitted or marked as reserved, but mapping pages
> > only works if the memory is omitted.
> >
> > On top of that, depending on how the kernel is configured, that memory
> > area must be page aligned or 2MB aligned. PowerPC is an exception here
> > and requires 16MB alignment, but since we don't have EFI support for
> > it, limit the alignment to 2MB.
> >
> > Ensure that the ISO image is 2MB aligned and remove the region
> > occupied by the image from the EFI memory map.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   lib/efi_loader/efi_bootmgr.c | 22 +++++++++++++++++-----
> >   1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index a3aa2b8d1b..16f75555f6 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -18,6 +18,8 @@
> >   #include <efi_loader.h>
> >   #include <efi_variable.h>
> >   #include <asm/unaligned.h>
> > +#include <linux/kernel.h>
> > +#include <linux/sizes.h>
> >
> >   static const struct efi_boot_services *bs;
> >   static const struct efi_runtime_services *rs;
> > @@ -358,13 +360,16 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
> >       }
> >
> >       /*
> > -      * TODO: expose the ramdisk to OS.
> > -      * Need to pass the ramdisk information by the architecture-specific
> > -      * methods such as 'pmem' device-tree node.
> > +      * Linux supports 'pmem' which allows OS installers to find, reclaim
> > +      * the mounted images and continue the installation since the contents
> > +      * of the pmem region are treated as local media.
> > +      *
> > +      * The memory regions used for it needs to be carved out of the EFI
> > +      * memory map.
> >        */
> > -     ret = efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
> > +     ret = efi_remove_memory_map(addr, size, EFI_CONVENTIONAL_MEMORY);
> >       if (ret != EFI_SUCCESS) {
> > -             log_err("Memory reservation failed\n");
> > +             log_err("Failed to reserve memory\n");
> >               goto err;
> >       }
> >
> > @@ -486,6 +491,13 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> >               ret = EFI_INVALID_PARAMETER;
> >               goto err;
> >       }
> > +     /*
> > +      * Depending on the kernel configuration, pmem memory area must be page
> > +      * aligned or 2MB aligned. PowerPC is an exception here and requires
> > +      * 16MB alignment, but since we don't have EFI support for it, limit
> > +      * the alignment to 2MB.
> > +      */
> > +     image_size = ALIGN(image_size, SZ_2M);
>
> The code regarding .iso and .img handling seems to be misplaced. Why
> should we treat a file loaded from a block device differently to a file
> loaded from the network?

If the installer is located in a block device, the kernel will find
the image when it scans those devices during boot. It's only when we
have it on a memory area that we need to preserve it

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> >       /*
> >        * If the file extension is ".iso" or ".img", mount it and try to load
>
