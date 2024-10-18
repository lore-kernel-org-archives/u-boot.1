Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48709D30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC59A88E90;
	Fri, 18 Oct 2024 16:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gWhgbmnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 507B288D5B; Fri, 18 Oct 2024 16:52:51 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3683F88C60
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b13fe8f4d0so148436785a.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263167; x=1729867967; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/L+Odyquh/UOsNojRsqkVbyyByiqMDxXwAfdu3JP7sw=;
 b=gWhgbmnzA6ISAeDh1IqYhWDJj1rufmN67HyL1MWAMcbtjjSrGwS0gZWziJw4GtzWC3
 ZvXDvFZ3usIV0fPIjdAi3hg73MUWPPoKAV5Ho6iDAeL9GX/HZJiiDcZ7RmDnZpghKhMK
 SKGBb50ckPSrR9qsl2WM05XrsKzRz+HDuJ2yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263167; x=1729867967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/L+Odyquh/UOsNojRsqkVbyyByiqMDxXwAfdu3JP7sw=;
 b=e0ofjt3t6Jm30QpuMVjqAc5g1K1kfSHbawXyBNTzRe4wGuNzx+Q9NsqWJiLGsKHO7I
 hQfutI9ofB2DuGub/mWCt9QrZcLDJh8vYqGCJRMUag2DcGNM4p80ujocEmitG2UP+0GX
 bBYAQqEX6ISReBUKecfqtMVqvkK5oz7VGcsDB4Yphiqc8LRhmIOpVZ/iTV4Mo4EZdNKg
 hWMnQJPdbtgoMAYCP75danMMAAh0R0idDlU7HE7akHXBv0I/rJwn+yuRjmZlOBByxDgs
 iFLd7jz7642+NYratwHg/bU77KH+wAzSB4hrs9LrmUIEDEixqi88XdwbRk6SEqUO++xy
 roug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrDavSUeXdAiA3WCjFlw6oW5IrCotUML7yTBVoJFLH/KsVovoU3RzULG7Xkqc5GBmRMucJ9ZU=@lists.denx.de
X-Gm-Message-State: AOJu0YwUrlcp0xRkpY17tlhHbxWs9QY+xmfOoKeGvuDmMJMCjWKTssbN
 eMKQ6MnjWHemnCVN7EVgu4Khju7qtyPWSusBXuXySeYiSjs+/vgaQ8Pm6/5c0Km8bpAaxr4vBZG
 K7nDtQ7fl5VPaoflhDgPc0k25LWhkCyrrtdP0
X-Google-Smtp-Source: AGHT+IFAlyc2ydy2qpUD4WcpjmDlHbpm4vuIxzF1zo9mKxNoKJ84tdBeHxEYmiOPx0w5kQRDv1mshpsYtVOt7ozzDZY=
X-Received: by 2002:a0c:f407:0:b0:6cb:be8f:a6b1 with SMTP id
 6a1803df08f44-6cde1530ee8mr27189146d6.25.1729263166948; Fri, 18 Oct 2024
 07:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241017180507.6261-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjL+QjOtzL2+hDysYxOYoJm2wEv5xt6L1t3BEkupwjHKEA@mail.gmail.com>
In-Reply-To: <CAC_iWjL+QjOtzL2+hDysYxOYoJm2wEv5xt6L1t3BEkupwjHKEA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 08:52:36 -0600
Message-ID: <CAFLszTi9BXuqYsy5HRrmd6_3tJ+=B3y6R+2VdUpPs52KFmKSvg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: add missing lf in error message
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
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

On Thu, 17 Oct 2024 at 12:19, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 17 Oct 2024 at 21:05, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > Messages written with log_err() should terminate with a linefeed.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  lib/efi_loader/efi_memory.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index b63b5cca71e..3d742fa1915 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -652,7 +652,7 @@ void *efi_alloc(size_t size)
> >
> >         if (efi_allocate_pool(EFI_BOOT_SERVICES_DATA, size, &buf) !=
> >             EFI_SUCCESS) {
> > -               log_err("out of memory");
> > +               log_err("out of memory\n");
> >                 return NULL;
> >         }
> >         memset(buf, 0, size);
> > --
> > 2.45.2
> >\
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Simon Glass <sjg@chromium.org>

I had the same patch locally :-)
