Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706C9C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 10:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F47866BB;
	Fri, 25 Aug 2023 12:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HX36xdy9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F8B868AE; Fri, 25 Aug 2023 12:46:45 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D79986612
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 12:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cryosay@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6bda8559fddso590163a34.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 03:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692960401; x=1693565201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=djtHhPCsrtFqx82gHhor79iyVPp6c9vquMAHEiKZkeY=;
 b=HX36xdy9FQylhu9Gbv6SN/txRUosXGeseALMItU4Hfd0BWRVKnshhHB/wY1hDrsacB
 spTbQ5IaxQndpKWY2E351UpoBW/hgTdP8H0sQPFUYSzbT2YwAC8vjkGjXkeoBMZ3nvwD
 uEFZ20oVnTwAetndhpS8oKuUwTOAzGm03GdKFe5ua2vrL2zytynQnkiNS2QEfTCcnfk7
 UrspcPAUY6VhW5U3M72Gi2cpFKBj9FHQ2/F6TWNQaqM0cNmsziaABwOrwqsEjGLzpWde
 D5qnoOwuueuFRJcGIdLgvadVcr4O3a4nQYiMdatsDXTcVe/IZhcpfUQ5GSpsMFf2JMDb
 OBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692960401; x=1693565201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=djtHhPCsrtFqx82gHhor79iyVPp6c9vquMAHEiKZkeY=;
 b=AKjBJW1HMbT2caUfIj76rXwIlPPUfH+1+tjJvu6k+cZwMDjI5ibBx4Rey+7uIalOqd
 xSYo6fI0q/xGoB7dYDaoi3rqsXTnX1mjXmkrWTrbeYAoGroHSzw/kGgTpVE9UR+g0Wva
 YXYd11Y/TtssJSDZxymxmoLWUNUjJa90ParPBwM6RKHP+nJiWnoZZhL23T/kdaXnklaX
 MsZkTqoLpV1cGN6xmWXF2ER8gDceg22EYcTJwuZn0udgQnyGzdIbgSk5S26CbFdLNDtm
 CyFQuj8wWAHc/d0hHIpSIxuIC/IzkZdZTkEYN/KjGg/HVugpvLjrYWYX+/bBEivdiSYl
 +J4g==
X-Gm-Message-State: AOJu0Yz+ttNrCJDI2pEVjqrD4pbw4OnNLmYTGgMjmlekiWiJvWSMLY30
 kooEU+JHNZZX0WA9GicEa54FD1ihowOPTYZ7O64=
X-Google-Smtp-Source: AGHT+IH+HypOj0Kd1SRXimyVyUV/ECB7TdxLnCB5Rp0XfzFVqn8Xc/vl0oKLyT9XdktehNi23nt/NaIAAn4hf+NLLAg=
X-Received: by 2002:a05:6830:4dc:b0:6b9:9288:613c with SMTP id
 s28-20020a05683004dc00b006b99288613cmr6046305otd.13.1692960401058; Fri, 25
 Aug 2023 03:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230823182156.32353-1-oleksandr.suvorov@foundries.io>
 <3ff9dce0-4eee-16b8-9e8b-26842b4c9aef@denx.de>
 <CAGgjyvGj1WgvSMefWLopS+rPnbomDM17RgK8ahxRktTifTUYJw@mail.gmail.com>
 <7f4953cd-f0cb-2fba-e4d3-b1a24f35004a@denx.de>
In-Reply-To: <7f4953cd-f0cb-2fba-e4d3-b1a24f35004a@denx.de>
From: Oleksandr Suvorov <cryosay@gmail.com>
Date: Fri, 25 Aug 2023 13:46:29 +0300
Message-ID: <CAGgjyvF_O=2PxOz7W35H8qL4zbDga-T_b04xRJLOov=bka5FcA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: Fix renaming SPL_USB_HOST_SUPPORT to
 SPL_USB_HOST
To: Marek Vasut <marex@denx.de>
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
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

On Fri, Aug 25, 2023 at 1:39=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 8/25/23 12:27, Oleksandr Suvorov wrote:
> > On Wed, Aug 23, 2023 at 9:29=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> >>
> >> On 8/23/23 20:21, Oleksandr Suvorov wrote:
> >>> In the usb/dwc3-layerscape driver the first option should be renamed
> >>> to the latter as well. Do it.
> >>>
> >>> Fixes: 333e4a621df ("Rename SPL_USB_HOST_SUPPORT to SPL_USB_HOST")
> >>> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> >>> ---
> >>>
> >>> Changes in v2:
> >>> - [asked by Tom Rini] shrink the code using CONFIG_IS_ENABLED()
> >>>
> >>>    drivers/usb/dwc3/dwc3-layerscape.c | 5 ++---
> >>>    1 file changed, 2 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/usb/dwc3/dwc3-layerscape.c b/drivers/usb/dwc3/dw=
c3-layerscape.c
> >>> index 79cf71f7a85..58baa017ad1 100644
> >>> --- a/drivers/usb/dwc3/dwc3-layerscape.c
> >>> +++ b/drivers/usb/dwc3/dwc3-layerscape.c
> >>> @@ -134,8 +134,7 @@ U_BOOT_DRIVER(dwc3_layerscape_peripheral) =3D {
> >>>    };
> >>>    #endif
> >>>
> >>> -#if defined(CONFIG_SPL_USB_HOST_SUPPORT) || \
> >>> -     !defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST)
> >>> +#if CONFIG_IS_ENABLED(USB_HOST)
> >>>    static int dwc3_layerscape_host_probe(struct udevice *dev)
> >>>    {
> >>>        struct xhci_hcor *hcor;
> >>> @@ -194,7 +193,7 @@ static int dwc3_layerscape_bind(struct udevice *d=
ev)
> >>>                driver =3D "dwc3-layerscape-peripheral";
> >>>                break;
> >>>    #endif
> >>> -#if defined(CONFIG_SPL_USB_HOST_SUPPORT) || !defined(CONFIG_SPL_BUIL=
D)
> >>> +#if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_SPL_BUILD)
> >>
> >> Why not CONFIG_IS_ENABLED(USB_HOST) here too ?
> >
> > The original logic is not equivalent to CONFIG_IS_ENABLED(USB_HOST),
> > so IMHO it would be better to fix it in a separate commit.
>
> What's the difference ?

The original logic in this function always enables USB_DR_MODE_HOST
switch case if we build u-boot, not SPL.
I've already fixed it in a separate commit. Please review v3.

--=20
Best regards
Oleksandr

Oleksandr Suvorov
cryosay@gmail.com
