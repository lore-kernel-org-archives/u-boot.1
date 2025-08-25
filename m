Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7441FCA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 16:28:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0B1382FC7;
	Mon, 25 Aug 2025 18:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="MlPwGCbK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9FBF83020; Mon, 25 Aug 2025 18:28:10 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9FF982DA1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 18:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-61bd4e14054so2234935eaf.2
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1756139286; x=1756744086; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKfPEsAgNgPWHdj25b2Wm3bowqw2d94ypJotf0Firog=;
 b=MlPwGCbKACZ5qzhxckf+yUvqMW334hWTLVRJfUMuohCeul6x7p/WawYNim1aU1wqkD
 PhYoruLEJid1iDYLZSl9e8yylEkth37EyushTlCHfaugXQVp2ADBma5tnnL2P5Xg246N
 Ut1gtnJij0MjoYvO2hXs1VW4E8NrV2ZMUUZaxkMfx5Eht/l6FZeAG7rziF6lf7LsyQGq
 bc2GF+0hNi1b9opgcOAbTX3q3dCAXB/WkLTYvWLA1nARGRAmiUSCom42DV4jQDjG0BEP
 np9Ns4RP6Yaxe9qr56mD9csanitmVUY6INuCqYndAeU9P9suVgQdetcu4KNH/7dmjVas
 03kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756139286; x=1756744086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKfPEsAgNgPWHdj25b2Wm3bowqw2d94ypJotf0Firog=;
 b=K9YpT2zU1M01vyiQXhfZ4svmXT/qXgpG9gSOC2KsrohDSTlcsnjMVp0M2vg+Zz2s8w
 +jDnBVmZStXzOyA1AL0NXew8BW4Rf5/xZqSieXv9imwLP/kyji5QK3JCv3LVfOL4V+5B
 BW0w26b2VnVs1XoiErYHC+hgEC14TOSkui+E5oH+Ij/zhelNxzS68jYywRTuNDVD5l94
 U4rqGo/HekW3uEDsEVIef0Umvat8XZUBgrwIAAv+Kjor3CEIhbKWpLxOE+CQjfk55nS3
 hZXvgAdFuP5laWzcsvQYqkUKnLMBX3JAGjTInWknWbprbmjh35VUyGazpAr3q4B/ZB7U
 jhSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq11VeC279l1f96tke1BHdrnwGu7EuJ1evYDEmKKNW1mZqv8diKAVXJgWY3yP1FeA27QEKVJU=@lists.denx.de
X-Gm-Message-State: AOJu0YyOrwQ/8PUQwzE094s3VIoLG/BaLrFTBPotGOeCq8nJiOGBZdcm
 4Vi9fjSofKrFB0tTxC1SnMhBVB7cEIgP4DKQe5vP1sncS5/hIgQgjWBfFL4VvAL4DhmzaUHl9Pr
 gSrrI8oyndnyQZ9BFnRJMpAMKYKuarOlBLzVttZDwNg==
X-Gm-Gg: ASbGnct3iknWuSOcwauIDtwR+gdp61lu5ko5H/SI0ZbBrRf4Rfk6S5MdIhuvzUDQZnI
 lQ3SpS9vhgbmuwUId9iyHf4p2LOl5X3w9vNNNV1ea1nMYfGYEJGbwYTI7S/k0VaUz7hFwb2wpVD
 BnMus9rY+fHQ2mZXAn8c9krzN8FIofnOQPwnfw0fdvb3y7m4/o7zcVv0/fjyENrNLfcfTIx7hUG
 R0BrTUWv6MI+rM5RQ==
X-Google-Smtp-Source: AGHT+IHq8EwRMAvW9kT3JY5Zoy635Nja8SRfff7AN/uROTzIw2DaK+zohshg8oiLVKLx8ilTYahYEhoP+FkSANIaKEg=
X-Received: by 2002:a05:6820:1caa:b0:619:844f:2d0e with SMTP id
 006d021491bc7-61db9beeb19mr5603573eaf.8.1756139286100; Mon, 25 Aug 2025
 09:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <pqr4l75nuc57vmrp4r3hjwjxi4p5dgwxlz7h5nrn77rfxwpfmr@dto7364jv2ei>
 <beef5a40-acb8-4f47-944d-d876f5634cdc@kontron.de>
 <CAJ+vNU0pWaYCG86_XNwb9dMOLhTUzw_9hdFE7xpbMh4G73X0nA@mail.gmail.com>
 <2d34d634-8fa5-43e2-ba03-788b5865b751@kontron.de>
In-Reply-To: <2d34d634-8fa5-43e2-ba03-788b5865b751@kontron.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 25 Aug 2025 09:27:54 -0700
X-Gm-Features: Ac12FXzMPPBZd1bBspplrmaTd8IvEQFPzbvpxDNQgbaGkc1pv2HPffvCPT3OPj4
Message-ID: <CAJ+vNU1iXa-UXJpMdiuJnx87fo-BK-JGBaPmsQjwkZwcfo6fsg@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: imx9: scmi: Fix booting from USB
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Francesco Dolcini <francesco@dolcini.it>, Peng Fan <peng.fan@oss.nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
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

On Mon, Aug 25, 2025 at 12:50=E2=80=AFAM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> Am 22.08.25 um 19:05 schrieb Tim Harvey:
> > On Tue, Aug 5, 2025 at 11:53=E2=80=AFPM Frieder Schrempf
> > <frieder.schrempf@kontron.de> wrote:
> >>
> >> Am 31.07.25 um 20:47 schrieb Jo=C3=A3o Paulo Gon=C3=A7alves:
> >>> Hello,
> >>>
> >>> On Mon, Jul 28, 2025 at 11:25:04AM -0300, Fabio Estevam wrote:
> >>>> What confuses me about Jo=C3=A3o's patch is that it was not tested a=
gainst
> >>>> the mainline U-Boot.
> >>>
> >>> In the end, the code is nearly identical between the downstream and
> >>> mainline U-Boot.
> >>>
> >>> On Wed, Jul 30, 2025 at 08:35:40AM +0200, Frieder Schrempf wrote:
> >>>> I have the below patch in our downstream fork to fix the issue menti=
oned
> >>>> here for i.MX93. It is derived from Fabio's patch [1]. I'm not sure =
if
> >>>> it's correct, though.
> >>>
> >>> We are also doing something similar on our branch.
> >>>
> >>> I have two proposals. My goal is to prevent the board from hanging wh=
en
> >>> booting from USB if CONFIG_ENV_IS_NOWHERE=3Dn (since the current code
> >>> assumes it is always enabled) and/or if the environment is defined
> >>> elsewhere:
> >>>
> >>> 1) Imply CONFIG_ENV_IS_NOWHERE for i.MX9 (as mentioned earlier), to m=
ake
> >>> it clear that it is required by ARCH.
> >>>
> >>> or
> >>>
> >>> 2) Doing something similar to what Frieder showed for USB boot (which=
 is
> >>> almost the same on i.MX8MM/i.MX8MP), but preserving the current
> >>> behavior:
> >>>
> >>> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/im=
x9/scmi/soc.c
> >>> index 13f13ca7d105..f973652d0cbe 100644
> >>> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> >>> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> >>> @@ -635,7 +635,8 @@ enum env_location env_get_location(enum env_opera=
tion op, int prio)
> >>>
> >>>         switch (dev) {
> >>>         case QSPI_BOOT:
> >>> -               env_loc =3D ENVL_SPI_FLASH;
> >>> +               if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
> >>> +                       env_loc =3D ENVL_SPI_FLASH;
> >>>                 break;
> >>>         case SD1_BOOT:
> >>>         case SD2_BOOT:
> >>> @@ -643,10 +644,16 @@ enum env_location env_get_location(enum env_ope=
ration op, int prio)
> >>>         case MMC1_BOOT:
> >>>         case MMC2_BOOT:
> >>>         case MMC3_BOOT:
> >>> -               env_loc =3D  ENVL_MMC;
> >>> +               if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
> >>> +                       env_loc =3D  ENVL_MMC;
> >>>                 break;
> >>>         default:
> >>> -               env_loc =3D ENVL_NOWHERE;
> >>> +               if (IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
> >>> +                       env_loc =3D ENVL_NOWHERE;
> >>> +               else if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
> >>> +                       env_loc =3D ENVL_SPI_FLASH;
> >>> +               else if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
> >>> +                       env_loc =3D ENVL_MMC;
> >>>                 break;
> >>>         }
> >>>
> >>> With this patch, I believe Peng's concerns are addressed, and it also
> >>> works for our use case.
> >>>
> >>> What do you think?
> >>
> >> On first glance, this looks good to me. If possible, can you please al=
so
> >> send a patch for i.MX93 (arch/arm/mach-imx/imx9/soc.c) to align the
> >> behavior of both platforms?
> >>
> >> Thanks!
> >>
> >
> > Hi Jo=C3=A3o,
> >
> > This does resolve an issue I encountered as well on the imx95 while
> > booting via USB2 SDP.
> >
> > Can you submit a formal patch?
>
> I think the patch you are looking for has already been sent:
> https://patchwork.ozlabs.org/project/uboot/patch/20250811-v2-fix-imx9-usb=
-boot-v2-1-3d89974e2881@toradex.com/
>

Hi Frieder,

Indeed it has - I missed that. Thanks,

Tim
