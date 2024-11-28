Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E012D70DEF
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B72489D0B;
	Thu, 28 Nov 2024 20:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R1uspCeq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C829689235; Thu, 28 Nov 2024 20:11:05 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FE628938D
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d036963a6eso1325324a12.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821063; x=1733425863; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lFM9QdgZLgKruiuOfW2A/cHt6riL2yvLIk8BCpTo0UQ=;
 b=R1uspCeqZwaEaUdlaInjKw77zbldXNZ+JkOunzfvYFpVRIcakRqACUl1vMd9peDY/o
 XteollK1TNg+uCRI2lPUXYbtq/zFHCTt0f2Pd9hu7anojtlXd9ZkK4wMk9fDDv7Z+5NQ
 a8fv5JaQg0RT15nxjwT01Bu4AHsHn5oAK8TFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821063; x=1733425863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lFM9QdgZLgKruiuOfW2A/cHt6riL2yvLIk8BCpTo0UQ=;
 b=WsrTERuJ1LTzCya8zQKQh7eS9COODzDbAUaH+A9OxsW55eUHxYV3wBz+E6qkiC+ujc
 cVbf9NawB9wM1pVja6HRu88439CBbU7ELrHUvEUwbAHU/rNqJCf1S4OkLiwHE8ZgvJhj
 vvPzVx41DoSIOn6vEll9+otj232x58G+zFNSM1jq0EeRT9i9w3U/Uh6jDE7Qc0In9pUu
 JQwslvQp9OKW66oMdd3dzSBI6/iZr9wvW491iB4mq4qONBqKa9+C/xqozRKy5+28FGcg
 XSf0yHO9hKuarvwShe26MSuJb7eUTJJe+tcS5KoCNVMiV6Uz7h+Jo3R60pqnEOjZBeAE
 bmdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq//QONQ6sB+KYjRqKsFaiimw9OsCINTH8BGrEbcrI+Vq6TXELXEfq+uG07+qJrDXw3lm3LpA=@lists.denx.de
X-Gm-Message-State: AOJu0YxB3HZfm1VIg7cDQMW3w9G6k6osc5DfTOfqBZtIQRCYuenbR9Us
 /x+1VeIYUf2KyZeuRkG3v9V1BXy/KRxfqkGBzpO+UF2pqLpzidBjkm6sQQluMccAo7RZO2Es+/6
 mqsbHLhpJResML2swzEy6jH12WYzYly1KeHbji6ZT7+DEi68=
X-Gm-Gg: ASbGncuQKc4N+lODj/JDxNe5X/21YdqturftSDxdPA2x7Eb/2FZCGAhTTOnGBznjus+
 2/7hCOLuSLmCEydiYYOT+L2MhawxyOxM=
X-Google-Smtp-Source: AGHT+IH1RPIWNEb/LIsxr0jSte5eWeOqYS6PcSaFN+on9+pugGJT8JIlpMTCN7Cj9RXYQZXT7HLBY2aFwsxHDyOVJVQ=
X-Received: by 2002:a17:906:319a:b0:aa5:1ef5:261e with SMTP id
 a640c23a62f3a-aa580f01a3bmr728128566b.17.1732821062861; Thu, 28 Nov 2024
 11:11:02 -0800 (PST)
MIME-Version: 1.0
References: <20241128154727.771871-1-sjg@chromium.org>
 <20241128154727.771871-29-sjg@chromium.org>
 <e04cd688-a39b-488f-a599-b8b1311ca366@gmx.de>
In-Reply-To: <e04cd688-a39b-488f-a599-b8b1311ca366@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Nov 2024 12:10:49 -0700
Message-ID: <CAFLszTieNRkDR=+Xtp+8-C_nLUA_dDsmrUwVmgEUC2DKPe3EJA@mail.gmail.com>
Subject: Re: [PATCH v2 28/28] efi_loader: Simplify efi_dp_from_mem()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, 28 Nov 2024 at 10:31, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 28.11.24 16:47, Simon Glass wrote:
> > This function should take a pointer, not an address. Update it along
> > with all users.
>
> This function never was meant to take a sandbox virtual address. It
> always expected an EFI_PHYSICAL_ADDRESS which must be convertible to
> void * as UEFI uses an identity mapping.
>
> A reasonable commit message would be:
>
> "We can reduce the number of locations where we convert from a pointer
> to an integer by passing the address as a pointer instead of an u64."
>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Drop patch 'Convert efi_get_memory_map() to return pointers'
> > - Drop patch 'efi_loader: Make more use of ulong'
> > - Significantly expand and redirect the series
> >
> >   include/efi_loader.h             |  5 ++---
> >   lib/efi_loader/efi_bootbin.c     |  3 +--
> >   lib/efi_loader/efi_bootmgr.c     |  2 +-
> >   lib/efi_loader/efi_device_path.c | 20 ++++++++++----------
> >   4 files changed, 14 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 4e34e1caede..1269907fa3c 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -919,9 +919,8 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
> >   struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
> >                                        const char *path);
> >   struct efi_device_path *efi_dp_from_eth(void);
> > -struct efi_device_path *efi_dp_from_mem(enum efi_memory_type mem_type,
> > -                                     uint64_t start_address,
> > -                                     size_t size);
> > +struct efi_device_path *efi_dp_from_mem(enum efi_memory_type  mem_type,
> > +                                     void *start_ptr, size_t size);
> >   /* Determine the last device path node that is not the end node. */
> >   const struct efi_device_path *efi_dp_last_node(
> >                       const struct efi_device_path *dp);
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > index a87006b3c0e..7e7a6bf31aa 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -136,8 +136,7 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
> >                * loaded directly into memory via JTAG, etc:
> >                */
> >               file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> > -                                         (uintptr_t)source_buffer,
> > -                                         source_size);
> > +                                         source_buffer, source_size);
> >               /*
> >                * Make sure that device for device_path exist
> >                * in load_image(). Otherwise, shell and grub will fail.
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index 98799aead84..e3b8dfb6013 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -515,7 +515,7 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> >                * will be freed in return_to_efibootmgr event callback.
> >                */
> >               loaded_dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> > -                                         image_addr, image_size);
> > +                                         source_buffer, image_size);
> >               ret = efi_install_multiple_protocol_interfaces(
> >                       &mem_handle, &efi_guid_device_path, loaded_dp, NULL);
> >               if (ret != EFI_SUCCESS)
> > diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> > index 9c8cd35b97b..025a17b19fa 100644
> > --- a/lib/efi_loader/efi_device_path.c
> > +++ b/lib/efi_loader/efi_device_path.c
> > @@ -11,6 +11,7 @@
> >   #include <dm.h>
> >   #include <dm/root.h>
> >   #include <log.h>
> > +#include <mapmem.h>
> >   #include <net.h>
> >   #include <usb.h>
> >   #include <mmc.h>
> > @@ -975,9 +976,8 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
> >   }
> >
> >   /* Construct a device-path for memory-mapped image */
> > -struct efi_device_path *efi_dp_from_mem(enum efi_memory_type mem_type,
> > -                                     uint64_t start_address,
> > -                                     size_t size)
>
> The parameter used to be an EFI_PHYSICAL_ADDRESS in the UEFI spec terms
> which is an UINT64.
>
> > +struct efi_device_path *efi_dp_from_mem(enum efi_memory_type  memory_type,
> > +                                     void *start_ptr, size_t size)
>
> We only can use a pointer here because we do not expect addresses above
> 4 GiB on 32bit systems.
>
> >   {
> >       struct efi_device_path_memory *mdp;
> >       void *buf, *start;
> > @@ -990,9 +990,9 @@ struct efi_device_path *efi_dp_from_mem(enum efi_memory_type mem_type,
> >       mdp->dp.type = DEVICE_PATH_TYPE_HARDWARE_DEVICE;
> >       mdp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MEMORY;
> >       mdp->dp.length = sizeof(*mdp);
> > -     mdp->memory_type = mem_type;
> > -     mdp->start_address = start_address;
> > -     mdp->end_address = start_address + size;
> > +     mdp->memory_type = memory_type;
> > +     mdp->start_address = map_to_sysmem(start_ptr);
>
> An UEFI application loaded by the sandbox does not know anything about
> the virtual address space (phys_addr_t) of the sandbox.
>
> The device-tree node must contain addresses that an UEFI application can
> use as void *.
>
> map_to_sysmem() is wrong here. You could use
>
> mdp->start_address = (uintptr_t)start_ptr;

OK, so this is actually a pointer, by the sound of it. I'll update the comment.

[..]

Regards,
Simon
