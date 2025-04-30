Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C50C3ABA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E816F8081A;
	Wed, 30 Apr 2025 16:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cmueGyZN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F8C820E2; Wed, 30 Apr 2025 16:01:29 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39583807B1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c09f8369cso2021081a34.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746021686; x=1746626486; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=givJM5CYTZcU39HoIjqNenTGD+ULQw27+SNCLe/2PNw=;
 b=cmueGyZNMjuDrs8bilrAjq3YIEQ9ZN1+jpZU9Jx7gx1Ktf9epdewONFvQqBfyFeX9X
 WmfFQ4XkmzvDvU5jypj4imLtK4d0R7j+nnD8GDpdF3D2qkJWmsr6UJx1fcNkPwFUGH5Y
 fygfCl08x6o+zx6F2LkaMQnhLxj1G5HTKTezN8YuJ3ha9kykHT9md1CtKlOkWzH3/vMr
 jGIaqixzf4CwhEVfWAQDclLGkiyhIaYUq167x4qqqCWye2Ok3zCtPykobQwGvVSp3/Pb
 WCkwid+3rvD+L5kqwnJ6VJYtVa7z6hRS9R0PBt4sgqrH47qxrH6O31FrYGNzsAswCsY/
 d45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746021686; x=1746626486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=givJM5CYTZcU39HoIjqNenTGD+ULQw27+SNCLe/2PNw=;
 b=AfrIjWKos0Qrol24TmCcf45Hjb/fu7I3XSPfIplBdvXc1St/N3yPqeDH1YJqbdrPPJ
 aE1BIkoItskka4b/E69xSgcfIeQRcqDt2QFWuJ91L/9uklJDpNiIQP8MmnwD4paD6uZo
 XLu3IlhzZLrfcnG1CVDtgtmtO0EHk9+lNKGofGEvtTtrL+yvi8wLJ5hvPjvNf0nNIFdC
 +zsEmPo/t7VVzGMN14vFnKYqfquxCd/LVpzkEzoIbw/Ri4bgV0HFEfq0x2fSCzaZ9xBC
 Cuzbe+ydC6kEzZ+tT4bQ3yYK0bdgFPlU1X0Et+1TPZagxZaA6yrO6BVC0bluFQETPc2e
 jbQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxpYTS5wS0ujwP7sjO1DoF9Ayo2GnWi1dxCT6DW0hn4ZJv3FqI+lni/oPoVKN7xMVPDDADPCM=@lists.denx.de
X-Gm-Message-State: AOJu0YxY2uwRHmgelxWL7wz+KRzH9F+FRDjJ8yh3xy+k4mBQ3MxVm+0L
 JCdlqq1GuUtrpldRTKJbxRLwo6aRsIHLWopQyULO3rg2fphb/MvLQHqGTG699q+ug4T0zNLSfLl
 sX9kivaW7mh1rwncX3iiJcBQC5dZYuUyBCBbMFA==
X-Gm-Gg: ASbGnctOQcPK5RUnE+szhgCOlmJx/dbgkepF2pVnxccNT5/buM4Pjt9tS5a8IMkKgTz
 bqECxQysO03p9fzfsNocx9K7xM45f8iIcmaVYX2kuahXiIMb9qU9cNgKJlHmMZDIxIsUG6Ds9wH
 YT0AsDCeAz2PvXgXrlfaLdkHc=
X-Google-Smtp-Source: AGHT+IGII8vmvlNAXBn3I33VV1cqKLJn3e5wLuoorNXFD68IVEqD3Gb03GasONafJYLuAkBFkhvEOsodVbg6j6/2qbY=
X-Received: by 2002:a05:6830:4990:b0:72b:80b4:dbca with SMTP id
 46e09a7af769-731c09deaccmr2269072a34.5.1746021685632; Wed, 30 Apr 2025
 07:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250430105546.327442-1-heinrich.schuchardt@canonical.com>
 <CAFLszTiGDHWpEEhZZ_uN5KEjc52huun3U93qomaK8o2RZW1sUA@mail.gmail.com>
In-Reply-To: <CAFLszTiGDHWpEEhZZ_uN5KEjc52huun3U93qomaK8o2RZW1sUA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 30 Apr 2025 17:00:49 +0300
X-Gm-Features: ATxdqUGkxaFOEowoQ3s3nZ1MOLCOuietHYCasw-qpWSUrybn2SP-6lIG0fNJH80
Message-ID: <CAC_iWjLvCxHAb2yzpgqYL2PBT=iC-_bhKQe_h=3Pb1xc2UZBEQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] bootm: pass kernel load address not entry point for
 IH_OS_EFI
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>, u-boot@lists.denx.de
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

Hi Simon

On Wed, 30 Apr 2025 at 16:54, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heinrich,
>
> On Wed, 30 Apr 2025 at 04:55, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > The EFI sub-system needs the load address and not the entry point
> > to boot the binary passed from the bootm command. The entry point
> > is derived from the PE-COFF header of the binary.
> >
> > Fixes: ecc7fdaa9ef1 ("bootm: Add a bootm command for type IH_OS_EFI")
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  boot/bootm_os.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> > index dc9d3e61fca..a3c7cb5332e 100644
> > --- a/boot/bootm_os.c
> > +++ b/boot/bootm_os.c
> > @@ -498,11 +498,11 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
> >         /* We expect to return */
> >         images->os.type = IH_TYPE_STANDALONE;
> >
> > -       image_buf = map_sysmem(images->ep, images->os.image_len);
> > +       image_buf = map_sysmem(images->os.image_start, images->os.image_len);
> >
> >         /* Run EFI image */
> >         printf("## Transferring control to EFI (at address %08lx) ...\n",
> > -              images->ep);
> > +              images->os.image_start);
> >         bootstage_mark(BOOTSTAGE_ID_RUN_OS);
> >
> >         ret = efi_binary_run(image_buf, images->os.image_len,
>
> In this case ep should be set to image_start as it is with many
> methods. How come it isn't in this case?

It's explained in the commit message

/Ilias
>
> > --
> > 2.48.1
> >
>
> Regards,
> Simon
