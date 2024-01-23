Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BA7C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 08:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C660A87B9E;
	Tue, 23 Jan 2024 09:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z1vMdm95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1531087994; Tue, 23 Jan 2024 09:33:51 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F41D88790F
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:33:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2cf1288097aso3355981fa.0
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 00:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705998828; x=1706603628; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=stJXmFFtI/YK0Rby/Qrfdw6H8MVUg2F/RxeuFp3j78Y=;
 b=Z1vMdm95iMfz5s1YKDeySt+hFS/H1dOMJ6uuVvCc57xGMwE6YLOh6YUgunMONFWS4e
 fBQkaKbkIzNQSKvim2w2hZpk+yoXnhHjRsL74W13e0dxVPiQjjOkb4Q5CcbLnuIRUqSy
 Ckca8lBWo0h+VGCx9UnW1XTTNfhNKPAdsFl0XxikTik4A7C6UmjIeqlYNkzB4WCXjRxS
 SA9VDFtQulSLgKrQELy3oESQCLJBD+9f3xGfPOhavW/iivYPlUwSTdrKx7w8fKXFqj4K
 /ZVA5etxN+1hw6bWLr5LXwWvA/9sP90W7P+F2sNwYGXPdssxbbXySwGhaPyMg5nNjVyK
 cYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705998828; x=1706603628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=stJXmFFtI/YK0Rby/Qrfdw6H8MVUg2F/RxeuFp3j78Y=;
 b=AuFiHVJra+fjcq4vzmXOWxwB2+GkGSwCT8SecP84UtipTEugIJgcHL3ECvjUtCtOnq
 60BsqZNrlTrc0R9YgFXDB3UcM5ZW0lidOIEhQcwFduH1xH+cCabRaQHRsgOWNHp3bZRD
 vM6epQcunHdvFiUcq88W+kS5H3+GRjmzDtmUCLR1FcvGi0CH83AH2GEe18tyJXLLSmay
 ps5rkvuWVw/8iJjQFS40NQmLTKmPD5iuzqx9Knn+zuU/V9NBOQ4oOWjKw+xuQi8pmHJ9
 CBmb+pffDritN2lKT25AhMEuwCaQQm4zHSvxcqE4CdLZwvnx8oIsfrFoRvkwVmNmJVYd
 L3jA==
X-Gm-Message-State: AOJu0Yy2JbOiaEWTaJ0mzl0wCCN2w1KBCKJUEOjrS2IptsoF9AgBs/ic
 jIyz8fhtmAsAODfchmOzkI3W0OddgVJHnhGsdClIJvBcW1RXf0zm4i3IAlVwxGVjbX+E3YcrSTW
 ZhTvAN1vaOlhpfJfBwCI27snEF47FhR1dGypf8A==
X-Google-Smtp-Source: AGHT+IHtjwbEEDNWIlpy9aQWJF5520P0CrynNU6MCkAcMzs8MPww2ql6zHbw4GNUW9lfGrXTFLtJ4Rp6sqzbuVUsqs0=
X-Received: by 2002:a05:651c:10bb:b0:2cc:e5ec:f6f9 with SMTP id
 k27-20020a05651c10bb00b002cce5ecf6f9mr2125632ljn.40.1705998828197; Tue, 23
 Jan 2024 00:33:48 -0800 (PST)
MIME-Version: 1.0
References: <20240122191242.2989327-1-tejas.arvind.bhumkar@amd.com>
In-Reply-To: <20240122191242.2989327-1-tejas.arvind.bhumkar@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jan 2024 10:33:11 +0200
Message-ID: <CAC_iWjKEMs_0WHyu7ttfvP30vG=sJnhY5XWY=5hGBTAW_5oxyg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader : Suppress error print message
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, trini@konsulko.com, 
 sjg@chromium.org, michal.simek@amd.com, venkatesh.abbarapu@amd.com, 
 git@xilinx.com
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

Hi Tejas,

On Mon, 22 Jan 2024 at 21:12, Tejas Bhumkar
<tejas.arvind.bhumkar@amd.com> wrote:
>
> Currently, on certain Xilinx platforms, an issue has been
> identified, manifesting as follows:
>
> Starting kernel ...
>
> efi_free_pool: illegal free 0x0000000077830040
> efi_free_pool: illegal free 0x000000007782d040
> efi_free_pool: illegal free 0x000000007782c040
>
> The issue arises when the ramdisk image is relocated, placing
> it within the previously allocated EFI memory region( as EFI
> is established quite early in U-Boot).

I don't mind suppressing the print for some time, but out of
curiosity, how is the ramdisk relocated? LMB should be aware of the
EFI regions by then, so I assume the relocation code doesn't check
those?

Thanks
/Ilias

> Consequently, when
> attempting to release memory in the EFI memory region during
> the handover process to the kernel,we encounter memory violations.
>
> Highlighting that EFI remains active primarily during the
> booting of an EFI application, and the lmb persists while
> configuring images for the boot process. Since we aren't
> utilizing the EFI memory region during the boot process,
> there is no adverse impact even in the event of a violation.
>
> Currently, there is an ongoing discussion regarding the handling
> strategies of three memory allocators: malloc, lmb, and EFI. This
> discussion is documented in the email chain
> titled "Proposal: U-Boot memory management."
>
> Therefore, it is advisable to suppress the print message during
> the boot process for now.
>
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> ---
>  lib/efi_loader/efi_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index edfad2d95a..821fe7616e 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -713,7 +713,7 @@ efi_status_t efi_free_pool(void *buffer)
>         /* Check that this memory was allocated by efi_allocate_pool() */
>         if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
>             alloc->checksum != checksum(alloc)) {
> -               printf("%s: illegal free 0x%p\n", __func__, buffer);
> +               debug("%s: illegal free 0x%p\n", __func__, buffer);
>                 return EFI_INVALID_PARAMETER;
>         }
>         /* Avoid double free */
> --
> 2.27.0
>
