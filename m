Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE20C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 07:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1DD687282;
	Tue, 31 Oct 2023 08:57:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="Cskp9sFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7755C87AB2; Tue, 31 Oct 2023 08:56:59 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52CB587134
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 08:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yongxuan.wang@sifive.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6ce2cc39d12so3411822a34.1
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 00:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698739016; x=1699343816; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJZHlgELWjAqEAG/rY84BjxVp2GRRJlABqs+exdNXl8=;
 b=Cskp9sFTRLy3RU6o+hGFwiD3j2bl156PTc8kmBnXBEK27QJ8eaUHadofSmpGLIIUGc
 gRFsno0rOv32x8LA0pzqSXJ/do4FZixGsoN1U+5wBWJhfZqSSLqIDZ1Pw77YgsZ+iF+N
 deIAxU77W9QXxottysK5ySfDEKja062NYZr75th2tAtUwtB68b/uexRpVTplW9TT+twe
 ubWcwVhcgPBn0mY5guLmWDgubjeNEwpiQO22X+SLTKo9jcmApAyoa0h6lNW8y8Eq+7CM
 hCDlGl+45AXlBwQ1OGk16itKsmAeFTdfCTs8Ns5DJxKlH4prXsmwLVKFe7xoZKzJjcFT
 KFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698739016; x=1699343816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJZHlgELWjAqEAG/rY84BjxVp2GRRJlABqs+exdNXl8=;
 b=NpdKyCB3DevdsLSheJFvTp1A3L++8PDj2Rg8SPmIDP61Arg6gheRUFxJbNXWsmW01s
 8mfrX5ucoggfrcvJ/3ww+7tDAsOcAktVANeZrx4Fd2Kt25zQj4tHJjZ1WVMaMnhoUMaq
 0LxXM4bhcyIeIX2/dy9bYohyYEDmb/O0ftRHoNNkGgaEHAeW95wvIb21n2qx85prKw2c
 JWGIF2llEW9La6btHiXukw9lGCIJhy6I8SuqeRX8qEJNSPjayAd9LOWr2t8C7Ro08G3P
 65fG0bKhA6sdHLzAC3X2WYn1FIx40TuDqN/HvqaYxFXGOip/BY4HH9efIacbuxLeigCR
 8Q0Q==
X-Gm-Message-State: AOJu0YyIOB4y4Skrk0WwtXnz3yJo0OiZP74Kj+AoiiEPMUM6ng3PoHKu
 wFBk1JzgkA+nBnJkEkL7pfon3F6kq8bRMMCCkHUrDA==
X-Google-Smtp-Source: AGHT+IEowVqXdkVCowek0f+4y0U2vXkAmrIAvctRLl2d0pIlMPN+oSHjOgzC+Hfeqr5Is6TUeOFaVFbx+dPaSbCbAdw=
X-Received: by 2002:a05:6830:14c6:b0:6ce:4035:b801 with SMTP id
 t6-20020a05683014c600b006ce4035b801mr12799488otq.13.1698739015923; Tue, 31
 Oct 2023 00:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231026032254.23043-1-yongxuan.wang@sifive.com>
 <20231027164307.GY496310@bill-the-cat>
In-Reply-To: <20231027164307.GY496310@bill-the-cat>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Tue, 31 Oct 2023 15:56:45 +0800
Message-ID: <CAMWQL2grduFNgGPLYryXOaXTzVvO6Y9s6o=2MMQ3h8Mj8z8P7w@mail.gmail.com>
Subject: Re: [PATCH 1/1] board: sifive: unmatched: move kernel load address to
 0x80200000
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, greentime.hu@sifive.com, vincent.chen@sifive.com, 
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tom,

0x80200000 comes from the result of the relocated_addr in booti_setup()
on HiFive Unmatched board. If we load the Kernel Image to this address,
it will not be moved. Currently one of the first two 8-byte of RISC-V
Kernel Image is j _start_kernel instruction, so it's OK to execute the
header of the Image.

Regards,
Yong-Xuan


On Sat, Oct 28, 2023 at 12:43=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Oct 26, 2023 at 03:22:52AM +0000, Yong-Xuan Wang wrote:
>
> > U-boot initially loads the kernel image to the kernel_addr_r, and
> > subsequently relocates it to memory address 0x80200000. Setting
> > kernel_addr_r to 0x80200000 can eliminate one copy operation.
> >
> > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > ---
> >  include/configs/sifive-unmatched.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/configs/sifive-unmatched.h b/include/configs/sifiv=
e-unmatched.h
> > index 74150b7d4b..de8bfc1123 100644
> > --- a/include/configs/sifive-unmatched.h
> > +++ b/include/configs/sifive-unmatched.h
> > @@ -36,7 +36,7 @@
> >       "name=3Dsystem,size=3D-,bootable,type=3D${type_guid_gpt_system};"
> >
> >  #define CFG_EXTRA_ENV_SETTINGS \
> > -     "kernel_addr_r=3D0x84000000\0" \
> > +     "kernel_addr_r=3D0x80200000\0" \
> >       "kernel_comp_addr_r=3D0x88000000\0" \
> >       "kernel_comp_size=3D0x4000000\0" \
> >       "fdt_addr_r=3D0x8c000000\0" \
>
> This is I believe subtly wrong. If you want an execute in place kernel
> image (and are using FIT images), this can be made to work. But if you
> load your (Linux Kernel) Image to this address, the header will be at
> 0x80200000 and not the payload so you still end up moving it. Are you
> sure this is (a) not still moving it and (b) it's OK to be executing the
> header of the image like it's code (or is there some catch in the header
> to lead to a jump over it, in that case) ?
>
> --
> Tom
