Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00962C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227DE88967;
	Wed, 14 Aug 2024 13:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qCbc1N+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03096889B8; Wed, 14 Aug 2024 13:49:25 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE91C88763
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f1798eaee6so61496471fa.0
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 04:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723636162; x=1724240962; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAPnpXoxYrgMuwLIJdGsLO8de7c3ysxJVm/6+8fTsXE=;
 b=qCbc1N+efT9jLaGWeC9zkSu0gMBhDBpBHtFlc1HGvUgxQyblsAPgeqFuiGObNER5xw
 /+kXhQPJgbPAku5brG3o8gMDX4xFPZ1IZwxyA64Nfs8a0q0CXzshMD8Udg2/Ie7j5gO9
 AurnaSrCDD6qPNNHcQ3pAbPP9XqQ0bmsJXTJM6Y1+tmvv9AHoyLr7ZzYiRs/rlhHnDXJ
 h4YlQ5sb6DeV+lujkcLnvoAq0e8AawmqxvcMnrrcynvlA46m/vjEAlm6sC0ttCJdsPN0
 Pr9/wPJJzh9mKhYo28HI7z/8yimHuFLK00J9SQAVPmbOtFqVjekiUDvOzXJaabXJyRlw
 fPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723636162; x=1724240962;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAPnpXoxYrgMuwLIJdGsLO8de7c3ysxJVm/6+8fTsXE=;
 b=r/zbwsztcAReO1j/eXEP+g93L92hBkwSre/1v9VZEoG+C3pGIKY7D7YrMaSgH0/tCy
 GWfAbIEDsD00KtM43EK8sQQZNuUj69WQpDolji7H4rMieJP6oxtx+Ewnic93WpB9U/gN
 rJ0vzm9T/O48LQdmUb5Be3YefGHQopP2j7BLHiDQEIPaEg6T/WVyBEt9huNO3csf/XDx
 2sVuKZkBC1X8uAjC92u7fSJx8aStDqRlc4H8cEhKfnzaOvfzp1XewCB2XSI9aadyv/nw
 1ISa+RWtkdyFRKSYcRK6yFHroOENzKw/5O2BLolpqKnYYhu2lfTahyCs2iVsThdYODT/
 HrAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKmXCqu/HSrJ7MrfsWQdye7WY2ghh4/WvIm33wr0FdhS28J79DKBJzPErcgUDR8XuGS3cXk7FprFdy1yy0CEn8I9uGRQ==
X-Gm-Message-State: AOJu0YxJGGGcUbFNHbolmXhL+IQq2rRHNqtNYZD4sZyOenME8YsS5+4z
 mlrZSd5Hvp6t+Ifb8QnsnBzyNw6SzN6QVDA6GF7lud6AQ2xyopb4d0eeCtHnkzuGLJjZsWzhVng
 XNvr914S/aUA95DMrlHzNeAKpRn3sdSWnPPf7YQ==
X-Google-Smtp-Source: AGHT+IEVVTRRYLx4uR80LWhRMfnPuRBibfazR8jkyk7alOb3XNDVEYB1txhG3eecFM5RIBLH6Il3NYi61eiOS6OkNLU=
X-Received: by 2002:a05:651c:19ac:b0:2ef:1db2:c02a with SMTP id
 38308e7fff4ca-2f3aa1a5766mr17798941fa.6.1723636161881; Wed, 14 Aug 2024
 04:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240814071422.54193-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjJ8iCYb0HyaGWq+yCwfPVk25MUsLjdTEjN+ctxdGnrR+Q@mail.gmail.com>
In-Reply-To: <CAC_iWjJ8iCYb0HyaGWq+yCwfPVk25MUsLjdTEjN+ctxdGnrR+Q@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 14 Aug 2024 17:19:10 +0530
Message-ID: <CADg8p96CR5M30-p1bqof6KewiXAiSWbqK-u2YkKL0s6WEdPhag@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools/mkeficapsule: correct printf codes
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Wed, 14 Aug 2024 at 17:10, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Heinrich,
>
> On Wed, 14 Aug 2024 at 10:14, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > uint64_t is defined as unsigned long long on 32bit ARM.
> > Convert uint64_t values to unsigned long long and use %llX for printing=
.
>
> Why do we need to convert? uint64_t is a fixed width type

We get warnings on a 64 bit host like such

tools/mkeficapsule.c: In function =E2=80=98dump_capsule_auth_header=E2=80=
=99:
tools/mkeficapsule.c:694:67: warning: format =E2=80=98%llX=E2=80=99 expects=
 argument
of type =E2=80=98long long unsigned int=E2=80=99, but argument 2 has type =
=E2=80=98uint64_t=E2=80=99
{aka =E2=80=98long unsigned int=E2=80=99} [-Wformat=3D]
  694 |         printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08llX=
\n",
      |                                                              ~~~~~^
      |                                                                   |
      |
   long long unsigned int
      |                                                              %08lX
  695 |                capsule_auth_hdr->monotonic_count);
      |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                |
      |                                uint64_t {aka long unsigned int}


-sughosh



>
> Thanks
> /Ilias
> >
> >     tools/mkeficapsule.c: In function =E2=80=98dump_capsule_auth_header=
=E2=80=99:
> >     tools/mkeficapsule.c:694:66: warning: format =E2=80=98%lX=E2=80=99 =
expects argument of
> >     type =E2=80=98long unsigned int=E2=80=99, but argument 2 has type =
=E2=80=98uint64_t=E2=80=99
> >     {aka =E2=80=98long long unsigned int=E2=80=99} [-Wformat=3D]
> >     694 | printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n"=
,
> >         |                                                      ~~~~^
> >         |                                                          |
> >         |                                                          long=
 unsigned int
> >         |                                                      %08llX
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  tools/mkeficapsule.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> > index f28008a0829..d346c217f09 100644
> > --- a/tools/mkeficapsule.c
> > +++ b/tools/mkeficapsule.c
> > @@ -691,8 +691,8 @@ static uint32_t dump_fmp_payload_header(
> >  static void dump_capsule_auth_header(
> >         struct efi_firmware_image_authentication *capsule_auth_hdr)
> >  {
> > -       printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
> > -              capsule_auth_hdr->monotonic_count);
> > +       printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08llX\n",
> > +              (unsigned long long)capsule_auth_hdr->monotonic_count);
> >         printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.dwLENGTH\t: %08X\=
n",
> >                capsule_auth_hdr->auth_info.hdr.dwLength);
> >         printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.wREVISION\t: %08X=
\n",
> > @@ -724,10 +724,10 @@ static void dump_fmp_capsule_image_header(
> >                image_hdr->update_image_size);
> >         printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_VENDOR_CODE_SIZE\t: %08X\n=
",
> >                image_hdr->update_vendor_code_size);
> > -       printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08lX=
\n",
> > -              image_hdr->update_hardware_instance);
> > -       printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08lX\n"=
,
> > -              image_hdr->image_capsule_support);
> > +       printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08ll=
X\n",
> > +              (unsigned long long)image_hdr->update_hardware_instance)=
;
> > +       printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08llX\n=
",
> > +              (unsigned long long)image_hdr->image_capsule_support);
> >
> >         printf("--------\n");
> >         if (image_hdr->image_capsule_support & CAPSULE_SUPPORT_AUTHENTI=
CATION) {
> > --
> > 2.45.2
> >
