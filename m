Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819DDD58D4B
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 13:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFCA58997F;
	Mon, 25 Nov 2024 14:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xT4IeJ2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 192F9899D3; Mon, 25 Nov 2024 14:46:56 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE6B789532
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 14:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7245a9d0e92so5006919b3a.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 05:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732542412; x=1733147212; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BvE9FrAfkPCiEBwpyjG15EGArENnTww0/uNfS3NeLy4=;
 b=xT4IeJ2cgqN9tRDNG1o71z26DizQjDMPBxJ2DgWHg3rtVQxXiXDUSTEzaMg2MaZSP3
 5pM3++hOiVEMinpXgSjMKZfxztYsKRmbbypKzoV0fKyP8Ujc0owhQk4pIIGxVxZ/TxZr
 BiPK/NOM5FSG+yvXV6U7j2G9CyXoL2Z8WiDaVO0D0enGWWUgkxQZaPWLbnOScFuWC5uL
 qEzmXx0jLm9jh/7uB6UjVcYBTXlKFTOrpuE/WG3jdkITvfdfZ3tvvshvbQXqMWsX6e+P
 uVHYGEejeA8Zw73mGYJ3JR0uUouWvoAF1qw2oIYhp6oo6iEKgk9NjLcEIemscF5vOcN+
 pBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732542412; x=1733147212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BvE9FrAfkPCiEBwpyjG15EGArENnTww0/uNfS3NeLy4=;
 b=W+IctTsIXwiNFUNhHWShyiiZuscYe+86DaXAnHcMB+ucLCaN/xvITVbzEMvkEkDDrv
 sy9UJ64gnOGe86nCyw2ORLrA1G4Ao8lzu9EPD+2ZXvfaX7GaItojSlaGRoRXX9tDUlL9
 o90+rylWi2MiUIPbvAs9SIT77yuuznT5acgLLJALUhnOrfcq9ogY5HER6Nd/PviSUYji
 4Rh89+xiMX/QPTqLLONL+8rY1Z/rpnlE2K/H17o1kDAyggwCnGvc4ukMmU85J+gf3qog
 IiAaWiG5EwB1ZaCugqxY1cTJSlpee3L8o+ARDgxharnoqKwGHvcorTYQUlDbsVo5TCyK
 4LMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKQo32XVkFU1ym32lEI6FGSq5uBMhhySLvO2doPWXIAyvV0b+B7JL+YXkFCV6U3q0MXzPtfAU=@lists.denx.de
X-Gm-Message-State: AOJu0Ywjj30RH7/PoT27Orw93A+EUuBksj4kDmvnF/nqXr9O/VrppjU9
 RWY3z/wMLKwVzHHE47nw7Ka3zwjU0pfP2sgDqP92irBCQos8lifyIWzTbdNjrG7cksMiY/cOY4v
 fM4gEUmLgcvb2tLQECSRg9600oesAR1Ky4V9TyA==
X-Gm-Gg: ASbGncvWRG27pEBpqOS8pzkA3F8VvI8eJckxrots4MsgV5iBUNNChoLXBRkldMaMTGs
 2YIxrw4wP0kp81WIwy/P/kMp6Vvz2pg==
X-Google-Smtp-Source: AGHT+IH7NXRF2L2UBm5vcTvOeUsA8dG0vRjynlYN18BfQcdeEwj39SQ3VH2ZsvEWwJ8d4SD6o1ULly/s8NfCjKmq7as=
X-Received: by 2002:a05:6a00:17a1:b0:71e:7c25:8217 with SMTP id
 d2e1a72fcca58-724df6a4ac4mr16152688b3a.25.1732542412139; Mon, 25 Nov 2024
 05:46:52 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-2-mjg59@srcf.ucam.org>
 <e1592ca0-03aa-4f83-848a-70c8979a9b2a@gmx.de> <Z0N+kmEb9eYr8oBZ@srcf.ucam.org>
In-Reply-To: <Z0N+kmEb9eYr8oBZ@srcf.ucam.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 Nov 2024 15:46:15 +0200
Message-ID: <CAC_iWjJr7K=vGF8tZLHJBLk+TX-KwfEWsL36g8AaJqDRA8dZ+A@mail.gmail.com>
Subject: Re: [PATCH 01/10] Add EFI handover support to bootm
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Matthew Garrett <mgarrett@aurora.tech>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Hi Matthew,

On Sun, 24 Nov 2024 at 21:29, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Sun, Nov 24, 2024 at 03:43:12PM +0100, Heinrich Schuchardt wrote:
> > > +   /* That failed, so try allocating anywhere there's enough room */
> > > +   status = boot->allocate_pages(EFI_ALLOCATE_ANY_PAGES, EFI_LOADER_DATA, pages, &addr);

I don't think you can use this as is. IIRC the PE/COFF header defines
the alignment of the loaded image that's why we have
efi_alloc_aligned_pages()

> > > +   if (status == EFI_SUCCESS) {
> > > +           /* Make sure bootm knows where we loaded the image */
> > > +           os->load = addr;
> > > +           return;
> > > +   }
> >
> > Why don't you simply call LoadImage()?
>
> With secure boot that requires that the kernel image have a trusted
> signature, whereas we're relying on a signed FIT.

That signed FIT, contains a kernel compiled as a PE/COFF and you
*want* to jump the the efi stub right? If that's the case and we trust
FIT, why don't we just ignore the crypto checks on LoadImage?

Thanks
/Ilias
