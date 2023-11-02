Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65EEC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 10:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 852B2875A8;
	Thu,  2 Nov 2023 11:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="DyNXLd1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2690887735; Thu,  2 Nov 2023 11:27:53 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9AF3875A5
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 11:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yongxuan.wang@sifive.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5844bc378feso391421eaf.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698920867; x=1699525667; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72hBqAuuzQK8IeARQ42XmR/HvZN62nCkwjP4daIE+1E=;
 b=DyNXLd1E54FklTpeggCLNeTpZ4z+6dHFCvP7sjNygEyn8A0l6Tvm4Sy7rW6ewPPrHk
 0rjeQ7uCoVsrebHmV1BArX1w7BjjvH1GwAwoIFqEkSpAq8HBUj8mW+79pd4IfsUm7OWT
 nda+v2cOXmtDptJ+YBaBXAu7HOJEAM+8ODmIDiLo+Jeh9Lq5dLXLUaEvk2CWtwDmqHHi
 SzkdS9lADRlv57FdblwiRqFl62A7fHRDGK6OMnP0DLPsloOtr/DRxxfLwOYyeYbOIh98
 V6q3XkUNTL5Sz/wFbg3jBKdyZB9VRBzE2S2+QBNZeiFlFPxpq49vMCfOdTPFYOWyVyZm
 fduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698920867; x=1699525667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72hBqAuuzQK8IeARQ42XmR/HvZN62nCkwjP4daIE+1E=;
 b=wmdZ1AgJG9FFW2/IJwRgtJ5bPdrGGEKTPQ5DnVyltEASGeSThzVl8FmEd+g8r7rtHH
 QPKom4BG67tDx0fYtHy6uNX6M6fDUSWWCRJHd3urXBLgEtVYHwxE5SzGv8+RQ4qbkYDA
 I/XvxyvE0AUq7tD9HIDot428pVf0mbg8eDwPNkfS7NYP0VDLMJgIm+78+aAsaGvk7Fyg
 +uf2t0wIDlaegYJzmdApx2w67yBXcccpHk68BQsY/DNbxHtjdoKaaolGQ3eLS9tZX2PG
 tgWjOo15LrsUjDgcOhU4nhRYcmc3/MIEXwSVzhN3adWj6MrRn0DyV5ZEVr3j0sI0TTie
 Fd6A==
X-Gm-Message-State: AOJu0YxRSL+D88lEg0xN9Pr1gbHPcIpPFWEnjUaElXBs2HUrOATKzkh/
 dx+ypIWLkczG5p1NqPxJq975Gx7BYcIvZTFmP6zmaA==
X-Google-Smtp-Source: AGHT+IGUqTZDj0QR5UZm6O5jkqoGLN0du9AwNLmFZi/1t6DqnTj2ajG6VHWBTGNOAsru3HV/asn78lhj7oJ93kw/xPQ=
X-Received: by 2002:a4a:d036:0:b0:581:ea96:f7f3 with SMTP id
 w22-20020a4ad036000000b00581ea96f7f3mr17437050oor.7.1698920867369; Thu, 02
 Nov 2023 03:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231026032254.23043-1-yongxuan.wang@sifive.com>
 <20231027164307.GY496310@bill-the-cat>
 <CAMWQL2grduFNgGPLYryXOaXTzVvO6Y9s6o=2MMQ3h8Mj8z8P7w@mail.gmail.com>
 <20231031115406.GH496310@bill-the-cat>
In-Reply-To: <20231031115406.GH496310@bill-the-cat>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Thu, 2 Nov 2023 18:27:37 +0800
Message-ID: <CAMWQL2g=5QC4aPq2onYy1XsPVYXOv6LuAE+hMuL4y=KhP0KBgA@mail.gmail.com>
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

On Tue, Oct 31, 2023 at 7:54=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Oct 31, 2023 at 03:56:45PM +0800, Yong-Xuan Wang wrote:
>
> > Hi Tom,
> >
> > 0x80200000 comes from the result of the relocated_addr in booti_setup()
> > on HiFive Unmatched board. If we load the Kernel Image to this address,
> > it will not be moved. Currently one of the first two 8-byte of RISC-V
> > Kernel Image is j _start_kernel instruction, so it's OK to execute the
> > header of the Image.
>
> Thanks for confirming.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> As a follow-up, can you please work on migrating to plain text
> environment?
>
> >
> > Regards,
> > Yong-Xuan
> >
> >
> > On Sat, Oct 28, 2023 at 12:43=E2=80=AFAM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Thu, Oct 26, 2023 at 03:22:52AM +0000, Yong-Xuan Wang wrote:
> > >
> > > > U-boot initially loads the kernel image to the kernel_addr_r, and
> > > > subsequently relocates it to memory address 0x80200000. Setting
> > > > kernel_addr_r to 0x80200000 can eliminate one copy operation.
> > > >
> > > > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > > > ---
> > > >  include/configs/sifive-unmatched.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/configs/sifive-unmatched.h b/include/configs/s=
ifive-unmatched.h
> > > > index 74150b7d4b..de8bfc1123 100644
> > > > --- a/include/configs/sifive-unmatched.h
> > > > +++ b/include/configs/sifive-unmatched.h
> > > > @@ -36,7 +36,7 @@
> > > >       "name=3Dsystem,size=3D-,bootable,type=3D${type_guid_gpt_syste=
m};"
> > > >
> > > >  #define CFG_EXTRA_ENV_SETTINGS \
> > > > -     "kernel_addr_r=3D0x84000000\0" \
> > > > +     "kernel_addr_r=3D0x80200000\0" \
> > > >       "kernel_comp_addr_r=3D0x88000000\0" \
> > > >       "kernel_comp_size=3D0x4000000\0" \
> > > >       "fdt_addr_r=3D0x8c000000\0" \
> > >
> > > This is I believe subtly wrong. If you want an execute in place kerne=
l
> > > image (and are using FIT images), this can be made to work. But if yo=
u
> > > load your (Linux Kernel) Image to this address, the header will be at
> > > 0x80200000 and not the payload so you still end up moving it. Are you
> > > sure this is (a) not still moving it and (b) it's OK to be executing =
the
> > > header of the image like it's code (or is there some catch in the hea=
der
> > > to lead to a jump over it, in that case) ?
> > >
> > > --
> > > Tom
>
> --
> Tom

Sure. Could you please provide more details or examples of the plain text
environment? I want to ensure I fully understand your request before
proceeding.

Regards,
Yong-Xuan
