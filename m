Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D53CD98F6
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 22:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 637AB83FC5;
	Thu, 13 Nov 2025 23:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eJJcgoCQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 802AD83FD3; Thu, 13 Nov 2025 23:47:10 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 793B583FBF
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 23:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b733707e0b5so202100266b.2
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 14:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763074028; x=1763678828; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YqxL2Fh5Kd5quCb75BiaVp+zQUgXoU9cxjO0tXEB+a4=;
 b=eJJcgoCQi/aaWETudkUNTQ1f/ZmmJfKC0vGlCyhB2NYaWSiBHi5KxzOTViNZPCCepJ
 r9pHOGe6o+b1o9g+CCu0K4KT/+JQRamivPD01LF3JeUuBC+nRBguyGMWjmaGVQ3NfbBD
 bMFZ9c0c/qLH2AlDtHnBvCPaxtrsqHYjE5GIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763074028; x=1763678828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqxL2Fh5Kd5quCb75BiaVp+zQUgXoU9cxjO0tXEB+a4=;
 b=hhQe8BeLjFb4mG6ABV8rUqFCzPL1TfdP5AdmQ/Gxq442uGGVzUUMFgZZf5C7OayRDh
 TvlUTUBquEr1lr9ustYH0AVGt5A+2oq5EU7D43Honlv6TdKH95OBU1BJb14eb4D3EKtx
 UEdaKtCLNOkdXyaA+7dRV+KYCO2rxlFSj2ockko4rKabuURV2M+fOsb10uxAodwDDEB9
 CsQJ6/tAGVqdNcPYtnOHASH+d7EQUQ9/8E+lTO2eTGYKi0gZanXkMoN29iVb+AiSq7cV
 TiJBVMzO2jxAu9kOlicrL4ZBfOQhHzlGvDvUSyzlcIo3zYUeN0T+OOEMHjHQhoQkogkz
 UAqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8uYHqE7OhYpUXPUGjSJYAGJ0bHB9rXXL2unpj87jH5d4YVn4dVMv+9gP/NdWHy0cRDqHe7K8=@lists.denx.de
X-Gm-Message-State: AOJu0YxBeZhZJI8CB+Wr71eha09T/EhCLuy3APwFedJhKaFjca/e/ReK
 /PfS2a7OvNI8WhP7GcTF4qQgH4VuP1JG/jvrm2LZlFP9/MaXESjEKiI+ymWaYj9rXfU7NXcO+51
 /B4eNztkbSFDfs2DHgyn0l7xBRLz22HQIW9iNufaC
X-Gm-Gg: ASbGncvwz8SRkQtS/JDXg31ZTQ5AvKMHFqrV61kQ2m/WE9mZEaTirjEmlMtU3OItmAY
 I34kZJL8b2mqQW1sqMjbv4Tls3XB3iroXJxw7Z/VfxfZEgmISVrgq95S1mA1UetmRpk2lZF0sWB
 ARcaCL+SG+y8vPYDwxTM6aaha2vsf+pFejXxsSPvl4RDiXW9kt7GR+TrnjyqIMN+CsCt47sOBHk
 XJrD2F/HHKGuKedebQIgyNB4puwYWs6JtCYwa5HmKhhoTHJ7HbkXYl2kExpmQWDv8QwVewV54xK
 yjP0
X-Google-Smtp-Source: AGHT+IGII9rz7ZN0c+bNlS4NKv6J2SLIOJKyAoq8nQfkBX0NtUUQyT2i6KRXfEggqANsPcZj/gK+dUPtI5raxiWLKXE=
X-Received: by 2002:a17:907:9692:b0:b6f:9da9:4b46 with SMTP id
 a640c23a62f3a-b7367949557mr94917466b.43.1763074027884; Thu, 13 Nov 2025
 14:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20251113115516.947835-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTg0ByjUGgX4MSbU=i0oG7fuidM4J0J128ER6Aq+r6HW9A@mail.gmail.com>
 <81115588-50c7-4ecc-975e-13994101955f@mailbox.org>
In-Reply-To: <81115588-50c7-4ecc-975e-13994101955f@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Nov 2025 15:46:52 -0700
X-Gm-Features: AWmQ_bmxAp4Qty9Slbtzi273kFAlNfWGC-zs4b34vqPjvlj5wpanKytllbaQ_hA
Message-ID: <CAFLszThNLoS7j0pe_8G93dHtX91j331DCBiUgWpUPXi4Oi2-9w@mail.gmail.com>
Subject: Re: [PATCH] boot: Assure FDT is always at 8-byte aligned address
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
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

Hi Marek,

On Thu, 13 Nov 2025 at 14:57, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/13/25 8:33 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >> The fitImage may contain FDT at 4-byte aligned address, because alignment
> >> of DT tags is 4 bytes. However, libfdt and also Linux expects DT to be at
> >> 8-byte aligned address. Make sure that the DTs embedded in fitImages are
> >> always used from 8-byte aligned addresses. In case the DT is decompressed,
> >> make sure the target buffer is 8-byte aligned. In case the DT is only
> >> loaded, make sure the target buffer is 8-byte aligned too.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> >> Cc: Simon Glass <sjg@chromium.org>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> >> Cc: u-boot@lists.denx.de
> >> ---
> >>   boot/image-fit.c | 9 +++++++--
> >>   1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/boot/image-fit.c b/boot/image-fit.c
> >> index 2f2d3e9304d..cccaa48f683 100644
> >> --- a/boot/image-fit.c
> >> +++ b/boot/image-fit.c
> >> @@ -23,7 +23,6 @@
> >>   #include <log.h>
> >>   #include <mapmem.h>
> >>   #include <asm/io.h>
> >> -#include <malloc.h>
> >>   #include <memalign.h>
> >>   #include <asm/global_data.h>
> >>   #ifdef CONFIG_DM_HASH
> >> @@ -36,6 +35,7 @@ DECLARE_GLOBAL_DATA_PTR;
> >>   #include <bootm.h>
> >>   #include <image.h>
> >>   #include <bootstage.h>
> >> +#include <malloc.h>
> >>   #include <upl.h>
> >>   #include <u-boot/crc.h>
> >>
> >> @@ -2279,7 +2279,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
> >>
> >>                  log_debug("decompressing image\n");
> >>                  if (load == data) {
> >> -                       loadbuf = malloc(max_decomp_len);
> >> +                       loadbuf = memalign(8, max_decomp_len);
> >>                          load = map_to_sysmem(loadbuf);
> >>                  } else {
> >>                          loadbuf = map_sysmem(load, max_decomp_len);
> >> @@ -2291,6 +2291,11 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
> >>                          return -ENOEXEC;
> >>                  }
> >>                  len = load_end - load;
> >> +       } else if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
> >> +                  ((uintptr_t)buf & 7)) {
> >> +               loadbuf = memalign(8, len);
> >> +               load = map_to_sysmem(loadbuf);
> >> +               memcpy(loadbuf, buf, len);
> >>          } else if (load != data) {
> >>                  log_debug("copying\n");
> >>                  loadbuf = map_sysmem(load, len);
> >> --
> >> 2.51.0
> >>
> >
> > We really can't do a memory allocation in fit_image_load() !
>
> We already do, notice the malloc() when "decompressing image" part.
>
> > The problem should be fixed higher up, in its callers, etc. For one
> > thing, the caller knows whether it is a DT or not, so putting this
> > logic here is messy. See boot_get_fdt_fit()
>
> This is triggered by a fitImage with DT embedded in that fitImage as
> non-external-data. That DT is at 4-byte aligned address, so how can the
> caller deal with it ? The caller gets a fitImage, which itself is at
> 8-byte aligned address, but the DT in it is not at 8-byte aligned
> address, so that DT has to be relocated somehow and that happens here.

OK, but don't put the code in here...see boot_get_fdt_fit(). But even
then, why does it matter where the FDT is? We are going to use
fdt_openinto() at some point and put it elsewhere, right, so we can do
pre-boot fixups?

Perhaps we should deprecate FITs with internal data, too?

Regards,
Simon
