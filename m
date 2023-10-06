Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0434E81E1B
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 16:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0AEF8638B;
	Fri,  6 Oct 2023 18:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CHopOpqs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3252486CF4; Fri,  6 Oct 2023 18:48:03 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 877F985095
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 18:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a2478862dbso28907517b3.2
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696610879; x=1697215679; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81FQgOY311jckuZ8jut7ivaItCddripN2NiOBYAXc0I=;
 b=CHopOpqsBODRYENSuiOsLTHmyRI8lMkJpr+svQsEiVXmakGSF9lhhR4HAXQ3vHcQ/K
 ZUD2ZWzjel76r8ifyEvp15CAuOlXaV3W5t7Ag1dVSzcU5H65YOW68RfzvBTFOwwLI+kF
 iwg1KcbOzpjihI8b8KDRO5tHHOdWZonX7ous8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696610879; x=1697215679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81FQgOY311jckuZ8jut7ivaItCddripN2NiOBYAXc0I=;
 b=CkzusJ33LtUkwnolxq+OoooWSxI0eJ04tZFYdmz0uMFzO7n0AFUl8UyUlsBqu21q4G
 XdWYZkQZnQM+dTY0o05kICqylIHmtKdIdQH9R/O+AvH3p/4wKewUMw6Ll5hJdSUN1orK
 c/07xusQxVlQIVk7KWDHBzhpzsyHfsUU72m9WtTj0CHeq93rkRw8tngoq7e0/k3vEw2s
 J+3nTqcDzk9JWKxwtXF8og6bY7PEtT46dpxAV9iwLofHj4fm+gBN+yFBZcEQ+T/vdZ9D
 W5xK+KQPAgTx/YS3ZrZcHtR/76iAXZr+Y0phDuhhJpDz5kfoMiLHEWK2le/H2HuOTdzq
 u/hw==
X-Gm-Message-State: AOJu0YzNploRPSGhC7I/nkM9Nhrph0KBX0anZC/l4K5deJfnE4+/Ln8c
 iEdt/m9Kk5kc2pkUvvnXVmKmYmj2nGKIIODBbfqxfg==
X-Google-Smtp-Source: AGHT+IHUrO9efjoq3WXXUlSjBN4gqIh3ZApkGCHBE5gJUqa/llDNI/9t96TmHI6U62MJKg+TytbiUTR/t/K0R3GYhMU=
X-Received: by 2002:a0d:f542:0:b0:59f:5361:d18c with SMTP id
 e63-20020a0df542000000b0059f5361d18cmr8615295ywf.41.1696610878808; Fri, 06
 Oct 2023 09:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230710145026.128481-1-rogerq@kernel.org>
 <20230710145026.128481-3-rogerq@kernel.org>
 <CAPnjgZ1odo6F7RTumJ6A=+kgZ-pm0JnRvxNYB00HX7YpAyrFXg@mail.gmail.com>
 <574c8eb0-4c19-72ef-5920-e506e4be6203@kernel.org>
 <20230713184438.y3ac7c425fwu575b@radiantly>
 <263918be-381e-44b6-899e-321ecaabb2bc@kernel.org>
 <20231006152625.68903ab6@kmaincent-XPS-13-7390>
In-Reply-To: <20231006152625.68903ab6@kmaincent-XPS-13-7390>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Oct 2023 10:47:41 -0600
Message-ID: <CAPnjgZ1UQ6YxrDcSeC0+XAAG295ZCJFYWF8ojiFSqkvZYYoz7A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] board: ti: am65x: Move to using Extension
 framework
To: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>
Cc: Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 vigneshr@ti.com, trini@konsulko.com, 
 srk@ti.com, robertcnelson@gmail.com, u-boot@lists.denx.de, 
 "Francis, Neha" <n-francis@ti.com>
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

Hi K=C3=B6ry,

On Fri, 6 Oct 2023 at 07:26, K=C3=B6ry Maincent <kory.maincent@bootlin.com>=
 wrote:
>
> On Wed, 4 Oct 2023 15:39:23 +0300
> Roger Quadros <rogerq@kernel.org> wrote:
>
> Hello,
> Thanks for adding me in cc. Also it seems I forgot to add myself to MAINT=
AINERS
> for the extension_board.c file.
>
> > >>> Before this goes too far I think this should move to using a linker
> > >>> list to declare the driver (or a driver-model driver if you prefer,
> > >>> but that might be overkill).
> >
> > So I've been working on this on the side and got linker list way workin=
g
> > with custom script booting but as soon as I move to standard boot flow
> > it no longer works. This is because there is no code in place to
> > apply the overlay and pass it to next stage e.g. EFI.
> >
> > I see the following note at
> > https://elixir.bootlin.com/u-boot/latest/source/boot/bootmeth_efi.c#L30=
4
> >
> > "
> >                 /*
> >                  * TODO: Apply extension overlay
> >                  *
> >                  * Here we need to load and apply the extension overlay=
. This
> > is
> >                  * not implemented. See do_extension_apply(). The exten=
sion
> >                  * stuff needs an implementation in boot/extension.c so=
 it is
> >                  * separate from the command code. Really the extension=
 stuff
> >                  * should use the device tree and a uclass / driver int=
erface
> >                  * rather than implementing its own list
> >                  */
> > "
>
> I agreed that the extension implementation should move in boot/extension.=
c or
> common for general use. I am wondering what the advantage of creating an =
uclass
> interface?
> I am not an uclass expert but there is no per driver ops and usage. What =
do you
> dislike about using its own list?

I looked at this briefly for bootstd and left it alone, partly for this rea=
son.

The operations I know about are:
- scan for extension boards to produce a list: needs to happen at
start of 'bootflow scan' I think)
- applying relevant overlays: needs to happen in the read_bootflow()
method perhaps
- listing available extensions

I think a uclass makes sense, along with separating out the
'extension' command from the actual functionality.

>
> > Another note at
> > https://elixir.bootlin.com/u-boot/latest/source/cmd/extension_board.c#L=
198
> >
> > "/* extensions should have a uclass - for now we use UCLASS_SIMPLE_BUS =
uclass
> > */"
> >
> > So are we better off implementing a class driver for extension stuff?
>
> I think the first point should be to move it in common or boot and makes =
it
> generic for using the extension function everywhere. I will let Simon ans=
wer
> about the uclass part.

I believe this relates to boot/

>
> Regards,

Regards,
Simon
