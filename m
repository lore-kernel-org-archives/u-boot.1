Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE087C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 13:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8666086BF7;
	Thu, 26 Oct 2023 15:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ronkrnNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FCFA87619; Thu, 26 Oct 2023 15:27:05 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBD4686BF7
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 15:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-777754138bdso70734185a.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698326819; x=1698931619; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nf82tgVDAjcI5xtofG4rgmALuUwnBZT6+TkCjNhIFm4=;
 b=ronkrnNhveU1RQAU4bWrIH5ft3EYfAJtO3bLrXH+SMxjAW/4+xOcDO6LD+zI/q+AyL
 V9n5PZKLJgloMWHAGb+gZFB46pndjNI4VGtUI2mGFklfY4/uFNdGeUMTTn8rIzACuJ3l
 OJx+KDy72/COWkfWUxTpwdYaJbbjpaqVXeEoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698326819; x=1698931619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nf82tgVDAjcI5xtofG4rgmALuUwnBZT6+TkCjNhIFm4=;
 b=JhvrOCcNKwg4HemdnyDm99bPntDesg17uYbK2IUkosdRjxwFESUuV57pMo5KWW0Rh6
 j2jWVcb4bABlaZZJ7AaXdXfjN6WUal4v6prA9r9BMe+jYQvlbOyI+XlngYDP+JS05d8W
 EmtDgM4UzTr4GTNnsDRcEu0dMtB00ZOdRCqdZqrATeHUIyj1u3qBq8bN89+6tIzRBadL
 r83S5IXGx2SsBaYp9r4USLzqrlJjzBCfFfwfIdmQHcbWgNfhg1AzgyF/wXR6kRUVYdig
 Fu8TgT8IChXhnkjTMRWd6CHckEUfegdKumdPzzHOJpqWeh/HZuv+zu9YDd+vLCu1l0WU
 IrZA==
X-Gm-Message-State: AOJu0Yz5wCmf2iHAZYiM4URuB3v8zPO8+nKtWzUobsWOkKOcYkcrdLre
 +LVas7AmYuVMS91a/ocjzXsGYw==
X-Google-Smtp-Source: AGHT+IECRMyB6Hui5WXVWOU59RDgYvL4VTeTS+Bw/9f7/4llLyJxJwU8k71i92BErV4NL3g7JN4Tqw==
X-Received: by 2002:a05:620a:3909:b0:778:96fb:736a with SMTP id
 qr9-20020a05620a390900b0077896fb736amr21097934qkn.57.1698326819634; 
 Thu, 26 Oct 2023 06:26:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-7a1b-75c0-d849-e3ce.res6.spectrum.com.
 [2603:6081:7b00:6400:7a1b:75c0:d849:e3ce])
 by smtp.gmail.com with ESMTPSA id
 u2-20020ae9c002000000b007789072e445sm4999776qkk.31.2023.10.26.06.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 06:26:59 -0700 (PDT)
Date: Thu, 26 Oct 2023 09:26:56 -0400
From: Tom Rini <trini@konsulko.com>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, agust@denx.de,
 bmeng.cn@gmail.com, msuchanek@suse.de, rasmus.villemoes@prevas.dk,
 yangshiji66@outlook.com, praneeth@ti.com, nm@ti.com,
 vigneshr@ti.com, a-bhatia1@ti.com, j-luthra@ti.com, nsekhar@ti.com,
 n-jain1@ti.com
Subject: Re: [RFC PATCH 1/5] arm: mach-k3: common: Reserve video memory from
 end of the RAM
Message-ID: <20231026132656.GH496310@bill-the-cat>
References: <20231016160611.1353458-1-devarsht@ti.com>
 <20231016160611.1353458-2-devarsht@ti.com>
 <CAPnjgZ1y1Strc7-qiDA6hG6sQaFKarYGaQZ1dGv_NSCyMbzK-Q@mail.gmail.com>
 <ab69f5bc-763c-6c0f-13d5-af10c56faaf6@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3uFvQItJVWcgotCq"
Content-Disposition: inline
In-Reply-To: <ab69f5bc-763c-6c0f-13d5-af10c56faaf6@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--3uFvQItJVWcgotCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 05:41:10PM +0530, Devarsh Thakkar wrote:
> Hi Simon,
>=20
> Thanks for the review.
>=20
> On 19/10/23 19:26, Simon Glass wrote:
> > Hi Devarsh,
> >=20
> > On Mon, 16 Oct 2023 at 10:06, Devarsh Thakkar <devarsht@ti.com> wrote:
> >>
> >> Move the function to setup video memory before page table
> >> reservation so that framebuffer memory gets reserved from
> >> the end of RAM.
> >>
> >> This is as per the new policy being discussed for passing
> >> blobs where each of the reserved areas for bloblists
> >> to be passed need to be reserved at the end of RAM.
> >>
> >> This is to enable the next stage to directly skip
> >> the pre-reserved area from previous stage without
> >> having to making any gaps/holes to accomodate those
> >> regions which was the case if previous stage
> >> reserved region say somewhere in the middle and not at
> >> the end of RAM.
> >>
> >> Suggested-by: Simon Glass <sjg@chromium.org>
> >> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> >> ---
> >>  arch/arm/mach-k3/common.c | 21 +++++++++++++++++++++
> >>  1 file changed, 21 insertions(+)
> >>
> >> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> >> index cc755dd1bf..3978b9ccca 100644
> >> --- a/arch/arm/mach-k3/common.c
> >> +++ b/arch/arm/mach-k3/common.c
> >> @@ -27,6 +27,7 @@
> >>  #include <env.h>
> >>  #include <elf.h>
> >>  #include <soc.h>
> >> +#include <video.h>
> >>
> >>  #if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
> >>  enum {
> >> @@ -522,6 +523,24 @@ void remove_fwl_configs(struct fwl_data *fwl_data=
, size_t fwl_data_size)
> >>         }
> >>  }
> >>
> >> +static int video_setup(void)
> >=20
> > Shouldn't this be in generic code?
> >=20
>=20
> The reason I kept it here instead of video-uclass was since this function=
 also
> uses and updates gd->relocaddr and not just reserves the memory region an=
d I
> don't see any function in video-uclass playing with gd->relocaddr
> and this is inspired by and parallel to reserve_video from common/board_f=
=2Ec
> which is also static function defined in board_f instead of video-uclass.
>=20
> This basically is a wrapper function which calls video_reserve and also
> uses/updates gd->relocaddr, since I am calling this for SPL I could not f=
ind
> any common layer to define this since most vendors call board_init_f from
> platform specific file which in turn call this function.
>=20
> Could you please share your opinion and suggestions for generic location =
if
> above still not look good?

Unless Simon speaks up, this is probably fine enough and we can always
do further cleanups afterwards.  Please do a non-RFC where you address
Simon's minor comments, thanks.

--=20
Tom

--3uFvQItJVWcgotCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU6aR0ACgkQFHw5/5Y0
tywN7Qv+MSsp/pgkV3vmyIF0G9+1VYLKETVnz1cFivrnNVd78ypFKEgVJSzMOGys
ax5LDP6bMzLVVjUW9tuWME5BITD5A/LQjpfPC23axVT7nqGUFaFhPpI5t9GxSIZd
iNk7yHL4UUVvEOSwHM4PLstC92PCuhZKN9VIX2UV3hhkcJVQaeZkB0JdpSOc2CkH
TINqXz12C7RuXSKDbAnHescxgb0udHZZZN8VyQuHnf0BE9OeVEOgBstC7+SOIwnc
sgTuc40zB1O40PSpk5inqhZR3ZKRbGhBmnFuHI0tZ/u3mq1cDxSVhhVCTII76INM
GFKH8//jPqlUMC4g7thYG7ZBT+bSNuGubAaZ4Yq8WsjfObi3SMjl/C/OicfJIxkg
rSfFioS62fdrVksD9CIwP7ZCJdrUto1UfjwT6A+ax0ejTU374ITxpW1VC5NYlR6B
/vuCOSGXqkly5r835Y6Kbpkh5UZsr2CUdRymb2/6Byb43lKuaXORHd/neUCAgCPM
QACrtgNp
=6bNi
-----END PGP SIGNATURE-----

--3uFvQItJVWcgotCq--
