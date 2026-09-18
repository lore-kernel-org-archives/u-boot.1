Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45CEC982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 21:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66909810FB;
	Fri, 18 Sep 2026 21:42:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FC-ZwXEzt0lR; Fri, 18 Sep 2026 21:42:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 98306811DC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789767721;
	b=sBokDHW89oCdoa0xFKW5dQh2UDNefFElR+MCA25Owd2A/Unx24V7K4/PNgasuxKueo8z
	 XqEmbHYpi/zE1j3oQI953VlfPKF0x3xpf6PWCllBLCSP1cILkXsFlBXKp8qu8yX2njphq
	 GGYcV274532A3iNIyz+NrIezDUdshCkmjieFFZTuc/T1hA5XTbvcBJl/qTFgEtWmQvtND
	 jkFDO6MRAJQrm2SEKXYZEZBkBheXlbsq8Sz3Q3oT6o/htKVsjiEEDsdfBii4loyDogT28
	 v12noClQadZTCpGlEBEyZggQGtoafu8cH+YxG498gWPvWz7W1eRqoUiiUWBJr7Bfz6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789767721;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eym1DRH+uNsCdvaTvTMzzC2n0twXTJu+1mMP8UHztiY=;
	b=QbO+TdZWHaw3QDqrBVjeDqN03sgH6E8goWrwB+a1fAc9nhDd1ZrC98T2ZPN7Is7gmGFX
	 wC8WscI49af0CQhEkZS7F2+sTrZNzFzvm//uS8+9/63ROHmIBHJ8ML/CUVnecNzg7upV4
	 UhaIPLV+GV5+z8HYJ/yhePfK79tMquol+a4822ZTqV2SXP8p5h07kcolCs3fr8/IYrpPs
	 IVAR6l6dbz4s9cd1QCci+yrPNrIne/8dTB/vFP0JRzYYW180Ui0/zQmcpVK7AzL0qULLq
	 rmTjmG5Nd7pPHh8W1YRb7fure7JWIzYFYwO26cvruUMolau+EAD5WwNl2xEeS3hGPow==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=oL+JOoFm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789767721;
	bh=eym1DRH+uNsCdvaTvTMzzC2n0twXTJu+1mMP8UHztiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XZUszU3b0+L3Ms5/KCwlAkO+DK6nKVWSmtxE9r3v5YqZSLBSfQ1+V1dI96I+CUAoN
	 k+Dpo0M4PRIzmBnrAbP6ZL+l+wyh4oCQEmZvRrZGtz4r8KwopVhy4nH64tmVD2x9y/
	 +h0WilQqyU+SyZcbKBgw01T/QiPNJ3PaTWfVne/Fkhis+rA+Ewmvln1qINTiZXDEPp
	 x2++BxK3KGubxK7DD8MUHepgWyfPg4Du+oOm8k2tV0uk3GWhhimymfWU+Y2nWuIsbX
	 Yq3a8RF0syYQD8Q4BBS/xScFFZRf4Hx7I0/OvPKmnBkehhHr6BiTyDBtXCtb/hEwn2
	 ibW8hgwmepgbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98306811DC;
	Fri, 18 Sep 2026 21:42:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2777A13D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 21:42:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D75B811DC
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 21:42:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KvAwNjnQrnKt for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 21:41:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2D34F810FB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::24"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789767719;
 b=N5tviRMP10IIs7v0r9W+n8FqHks810HBcXKsp1J+QlTeqGNzq+nkYmthRdZJeGvKokdC
 Tw8IoU0CQ66uJQ86x9gRGizm3Ps8RVgbWx2jue7q7HUKrh6uuZshWGZzkDRW0uR8NEroR
 4XtaLT0TowsEYhdbfHGMTAEzc0h2p7ZeAdU46rTIiYjt/cL4+YtQdx9aRNy9WsUAkhF0z
 8I88N1s7x1uU5WaFURXZZvzFcL8zmsOJucnSRo+kj8PLtzLT2WqveHpze5777hoCpGOoq
 HdrczS+ixl5Z+xaQypGvN/T8nsuy7UWjidWjCgprRRrob2aI1ocvh85YrcPSeyyfB8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789767719;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=eym1DRH+uNsCdvaTvTMzzC2n0twXTJu+1mMP8UHztiY=;
 b=oRspKWtGVsbfgyWAkD57WTx2LAiqMEJjeqGfiKl4Dtq5D3BvFNidyn4BIXTdelSTBSiz
 UYGEni5bBewDN1jffI9sliYnXVXdJBg89sspJp5Q/AJOxqm812INAPNQU52hsf1pQzfPF
 Q0si5i3ja1q9htT9ED+5XfgdF/pK5Nh2umbvswtHlc7v2gdtaVv+112TDJuTwSzkknRTF
 g/B4NoVn+35lfW8R+B4tRraCKcrsHK6wZjWl26wyuL1mjRtwlZBeiGmaUZ1hBY6Z3OmPA
 9xHI0UYZd9QZgmXAycp6SVw4RPXg++LATn0oE6R/LJoTSiyx1KhHFF/wlywYJUS+Tog==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oL+JOoFm; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::24"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::24; helo=mail-oa2-x24.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oL+JOoFm
Received: from mail-oa2-x24.google.com (mail-oa2-x24.google.com
 [IPv6:2607:f8b0:4864:30::24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D34F810FB
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 21:41:58 +0000 (UTC)
Received: by mail-oa2-x24.google.com with SMTP id
 586e51a60fabf-482620dc91bso913462fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 14:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789767718; x=1790372518;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eym1DRH+uNsCdvaTvTMzzC2n0twXTJu+1mMP8UHztiY=;
 b=oL+JOoFmQU4CR4dNtr08l5lID+G8NYRxhISZ6bphI/75jbOKXCJYWVtGV8c8J8GEJu
 JX9GCsynCHqW1J0mSwSaNXjQ9myhPaLn9fXAT+8ulS9CQ3u2U9MAXxY011NMH+pxRXat
 LpH4soXw3yLULwFA2NLyo2bi08Gy0wCbn4xpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789767718; x=1790372518;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eym1DRH+uNsCdvaTvTMzzC2n0twXTJu+1mMP8UHztiY=;
 b=0AFA9z2S/2wONJN4nzdqyX8f6U+IGnY/nrqmztF/eWlz2zDTfFPgVdxBiNFRdnfhZW
 XvpJfSlxhN9qIKzKkDyahucwVe7Axs5qam9MF2GO5NEVXRLqDlnYTaJqOe1XXXEh24/X
 6BSrFpLHXqeeOPz4pyx5nlkXkeImsA1YSXVDSs5uBsNbkbve3mlESetydgJjKKo/MK+T
 +3E9sPZpQ2zcjiYUfwsKdDRySFCaauU/VsYI3Ainz9lyHYRch/z+I3WeebF/j85OGJhQ
 LUnHUVqFKizZE7mtlhQIRnqlh/o6wOkcHd3UxEozpC1EGWWx7GNrByCgeX1gvlIe4VdM
 Eujw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7c5M1oGWglV1wyO5VpucaOgqPfjUVUCtb9UMsIK+f5dzgEajFexACmNGvFY4acpn7p+O99uE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k5vcMtMsZ+w8UHhNdJAGdI5xCgMjzVMorI7P0A+TfVQyttrNyZ
 2scVAaCURyH7fCMiuTsygNj/nlVHygUttQ1MPCa80iSCVOVagnJkEMtDSFGBUDnr8B8=
X-Gm-Gg: AYBFou3q55tnsX3rJEBgqWlAfImLZCKNQxxhC2ZTW8rJOPzpl3EZLgV6tyHuCys8FUv
 Oar32SNY2n4Sbr8DutK/49Rh/bKa5jkN9GdjNwe4qX5eL9ymeR6YVsk7AltvG9mN9Nrc58wxEgy
 yjGu1GrSybl/MmIgfeI9hPfBDsDyID8Kdjx4HEC7VI2QPEnGhU3Oce0zPOqzHXeDYC/KoA6s4G3
 CXwIjTozbK/4VPQFnbl6n7doQujtfQj5R2n/aqDEWNFIAn7aUNeIeSoYqD1I96lD+S+iBHterto
 9qnFIOUbXW2FV8yIw3Kn9I5SNoowamFMv8kpMSSht7TiaBDvEAnOofylhxzvjWPRzvpOVMom/8l
 RfuYntkEKQJMROIXDkO4wSgwspZutvaI/dF6E3+wGXvKTHdDtRvnyRoozZj0OvMu5bAof22kzog
 rSGQSPo+swoccodvzz1RIamBN+hI7SDHg3fSSe+2uM9spjRs/iAJqwd8OCmskSFrOKBUdfrTSHo
 eSjVYnjif7k0bECQrXIqwLTvlOlzYKEooy78L+mJvAz5xifh74j+0moXMvZpOrfgVxdso5JDuKs
 PpaEnRrYN5CmVHfrMzz+TecJU42/Xg==
X-Received: by 2002:a05:6820:4ccb:b0:6cd:3fdc:5ff8 with SMTP id
 006d021491bc7-6cd3fdc6046mr801824eaf.73.1789767717674; 
 Fri, 18 Sep 2026 14:41:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd34b35d71sm1053144eaf.7.2026.09.18.14.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 14:41:56 -0700 (PDT)
Date: Fri, 18 Sep 2026 15:41:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: jstephan@baylibre.com, u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, dlechner@baylibre.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/2] video: fix build with CONFIG_VIDEO &&
 !CONFIG_VIDEO_LOGO
Message-ID: <20260918214154.GV858934@bill-the-cat>
References: <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-0-9dc80d307790@baylibre.com>
 <20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-2-9dc80d307790@baylibre.com>
 <CAFLszTgGNjf2TLT3joC2P2b3c-iA-affy5SrbjXyM-FA_c89UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b/km14rqeqDzEsW5"
Content-Disposition: inline
In-Reply-To: <CAFLszTgGNjf2TLT3joC2P2b3c-iA-affy5SrbjXyM-FA_c89UA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--b/km14rqeqDzEsW5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 03:49:44PM -0500, Simon Glass wrote:
> Hi Julien,
>=20
> On 2026-09-01T08:52:42, Julien Stephan <jstephan@baylibre.com> wrote:
> > video: fix build with CONFIG_VIDEO && !CONFIG_VIDEO_LOGO
> >
> > Building with CONFIG_VIDEO enabled but CONFIG_VIDEO_LOGO disabled fails
> > at link time:
> >
> >   video-uclass.o: in function `video_get_u_boot_logo':
> >   video-uclass.c:593: undefined reference to `__splash_u_boot_logo_begi=
n'
> >
> > The __splash_u_boot_logo_begin/_end symbols are provided by
> > u_boot_logo.bmp.o, which is only built when CONFIG_VIDEO_LOGO is set:
> >
> >   obj-$(CONFIG_VIDEO_LOGO) +=3D u_boot_logo.bmp.o
> >
> > video_get_u_boot_logo() and show_splash() reference those symbols
> > unconditionally, so with the logo disabled the reference is left
> > dangling. show_splash() alone would be dead-code eliminated (it is
> > static and only reached under a CONFIG_IS_ENABLED(VIDEO_LOGO) guard),
> > but video_get_u_boot_logo() is an exported function and is always
> > emitted.
> >
> > Guard the splash helpers and their symbol references with
> > CONFIG_IS_ENABLED(VIDEO_LOGO), and provide a static inline
> > video_get_u_boot_logo() stub returning NULL for the disabled case in
> > video.h. Callers already handle a NULL logo pointer (e.g.
> > bootflow_menu.c), so no caller changes are needed.
> >
> > Reproduce with any board that enables VIDEO without VIDEO_LOGO or
> > enabling SPLASH_SCREEN (it disables automatically VIDEO_LOGO).
>=20
> I won't comment on the word order / mixed tenses.
>=20
> > [...]
> >
> > drivers/video/video-uclass.c | 7 +++++--
> >  include/video.h              | 9 ++++++++-
> >  2 files changed, 13 insertions(+), 3 deletions(-)
>=20
> > diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> > @@ -579,6 +579,7 @@ int video_get_ysize(struct udevice *dev)
> >       return priv->ysize;
> >  }
> >
> > +#if CONFIG_IS_ENABLED(VIDEO_LOGO)
> >  #define SPLASH_DECL(_name) \
> >       extern u8 __splash_ ## _name ## _begin[]; \
> >       extern u8 __splash_ ## _name ## _end[]
>=20
> We try to avoid #ifdef in .c files and prefer if
> (CONFIG_IS_ENABLED(...)) so both branches are compile-checked. The
> SPLASH_DECL externs do need the preprocessor guard since the linker
> symbols don't exist, but the guard around show_splash() and its call
> site in video_post_probe() could be avoided by keeping show_splash()
> defined and providing an #else stub that returns 0. The existing if
> (CONFIG_IS_ENABLED(VIDEO_LOGO) && ...) at the caller can then stay.
>=20
> > diff --git a/include/video.h b/include/video.h
> > @@ -418,9 +418,16 @@ bool video_is_active(void);
> >  /**
> >   * video_get_u_boot_logo() - Get a pointer to the U-Boot logo
> >   *
> > - * Returns: Pointer to logo
> > + * Returns: Pointer to logo, or NULL if CONFIG_VIDEO_LOGO is disabled
> >   */
>=20
> The stub is guarded with CONFIG_IS_ENABLED(VIDEO_LOGO), so the doc
> should refer to VIDEO_LOGO in general terms - SPL may have it disabled
> while proper enables it. Something like 'Returns: Pointer to logo, or
> NULL if VIDEO_LOGO is not enabled in this phase'.

Simon, can you please make sure you're looking at both the current
version, and previous feedback, when commenting on older patches?
There's been a v2 for about 2 weeks. Thanks.

--=20
Tom

--b/km14rqeqDzEsW5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaq2wHgAKCRAr4qD1Cr/k
CocMAQDacXzuBw1dl5vjSt2Lz3NJbWEleAVwOnVioYU/W80Z7wD6AzJtL3eGH7sw
NxbpGJBwQ0E+tsr/Gq4LrQxlhuSmuA8=
=TEc2
-----END PGP SIGNATURE-----

--b/km14rqeqDzEsW5--
