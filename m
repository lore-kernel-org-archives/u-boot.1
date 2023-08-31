Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D1DC83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55CA786598;
	Thu, 31 Aug 2023 16:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JaV7JANb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6508386583; Thu, 31 Aug 2023 16:07:07 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2822286598
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 16:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d7bae413275so2272412276.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693490823; x=1694095623; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zky6RGO22HqTlea/mia/fpdFXpgoLeJ7iltsDTxZwJA=;
 b=JaV7JANbaDswCx6xDa/R/J1a5+QhxGcrKOqYa0Tsoi6Mxb+p8WZ6t8c1wqaGqTEA5u
 kHizstkG9bxP1/ODOmSCl+4tlG8JY+tML0Ev0ftp4rPuwdDmvAXwAIGMeyYlxcQ543Sf
 +MMza7S6i5buWy5TCQrCI+UwVyIbmN++e2XEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693490823; x=1694095623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zky6RGO22HqTlea/mia/fpdFXpgoLeJ7iltsDTxZwJA=;
 b=mFyh0T2sVuNCVPpRzYP1zqZV+0qH+YNwwih2ceXSw2gxl/g6+5XPJbOWcztRGFJpDY
 vtiZaViScf8ltdmvIDoqIefOeTBc9t3IAcNyE+iLRcpmd6y5DvxsCGrowyWOshkyexr5
 SzYbLx0FzDhWeMmQHyXrWluw2ur3gfcIwg8l/DkGIV+5GsplHulnOMBDiJOgLMietoxn
 SQAj3GT5l0lfz39tAvgAmw41JUBDVf5YzLYQ6hlJoSg5JbHGxaCmYbR1dv/1znjxbOY6
 u9NfgnWjTF52BYHXY3GhASUXEmaIUdVTsTFFLYrrE/WVPCfpr3ORSwnvqJj/wtRu8QYU
 aNhA==
X-Gm-Message-State: AOJu0YxRjZ/FGZPWprN1nY2DWzT7+/v+HJaN1ZnSSmzObEQCmxFBHi0w
 RKVq0RrXPer9jAxlFtDgBqmYeLKFNxLlhkqyi0PKnw==
X-Google-Smtp-Source: AGHT+IGCgwmahzTi8NO59fOftSG1RpAFdO7CvXsg4AItLwkpiihfgqyvutJivtbEH/Fevl0zCdBZsg==
X-Received: by 2002:a25:db84:0:b0:d74:6cb3:bb77 with SMTP id
 g126-20020a25db84000000b00d746cb3bb77mr2791572ybf.28.1693490822697; 
 Thu, 31 Aug 2023 07:07:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 j136-20020a25d28e000000b00d7e339ada01sm328038ybg.20.2023.08.31.07.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 07:07:02 -0700 (PDT)
Date: Thu, 31 Aug 2023 10:07:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 03/19] video: Hide the BMP options
Message-ID: <20230831140700.GS3101304@bill-the-cat>
References: <20230831035319.2316665-1-sjg@chromium.org>
 <20230831035319.2316665-4-sjg@chromium.org>
 <96711E1B-FA6B-44D5-ACB8-421C85373432@gmx.de>
 <20230831135846.GP3101304@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5f69i5OeNr/GFj5a"
Content-Disposition: inline
In-Reply-To: <20230831135846.GP3101304@bill-the-cat>
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


--5f69i5OeNr/GFj5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 09:58:46AM -0400, Tom Rini wrote:
> On Thu, Aug 31, 2023 at 06:05:22AM +0200, Heinrich Schuchardt wrote:
> >=20
> >=20
> > Am 31. August 2023 05:52:57 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > >These appear prominently in the main menu at present. However they are
> > >selected when needed so do not need to be visible.
> > >
> > >Make them hidden.
> > >
> > >Signed-off-by: Simon Glass <sjg@chromium.org>
> > >---
> > >
> > >(no changes since v1)
> > >
> > > common/Kconfig | 4 ++--
> > > 1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > >diff --git a/common/Kconfig b/common/Kconfig
> > >index 0b09bd68bd13..844531a59eda 100644
> > >--- a/common/Kconfig
> > >+++ b/common/Kconfig
> > >@@ -1169,12 +1169,12 @@ config IO_TRACE
> > > 	bool
> > >=20
> > > config BMP
> > >-	bool "Enable bmp image display"
> > >+	bool # Enable bmp image display
>=20
> Just change this to "bool" and don't add non-prompt text.  The help
> should be made clearer if it's not already.
>=20
> > This must depend on video.
>=20
> Since it's only select'd, no, it should be selected with "if VIDEO" if
> the options that actually use them don't already depend on video
>=20
> >=20
> > > 	help
> > > 	  Enable bmp functions to display bmp image and get bmp info.
> > >=20
> > > config SPL_BMP
> > >-	bool "Enable bmp image display at SPL"
> > >+	bool # Enable bmp image display at SPL
> >=20
> > Why should I not be able to deactivate the logo display?
>=20
> That's SPLASH_SCREEN not BMP.

Sorry, you're right Heinrich, the further options here depend on, not
select SPL_BMP.

--=20
Tom

--5f69i5OeNr/GFj5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwnoQACgkQFHw5/5Y0
tyxXfQv8CPYS7X4wMbupbjqXH8rhXYmbuJjnXEmmsIvMGtJ1/h3mlEoAR4F007sC
qbCXuFXGgbIAmIQuk6LDirt2QyFQREFnggd+w+66ZjbwdYkT6WumFvcNl329wudE
/q4mQ3/r/mFHaGMLd/y5jukz4cE9sGI78DiW0RNvB3m7r+JxEaUi5KtPoClcNyo+
MNHwV9BDS5a4JpZmxLGfWlozJNtvCMGlRtIr+w+pc+P0T3LjdiN2ufQbL/zTnkWE
9R0aPeJNK8yEta4jQHV/XRfNVjoDyXitIL8rLDyeHvxaaBvOhXgwyR0VL4Orv54t
G7ArA1J33W1GUJ0gdBOeJvS/5p9ZTZLpVSfhdzyYZ1x+BV1lcuhLJDodw9e816ss
SgmPVCPaDO7Dpa1LixiVRv56OvWxKCx/iT+N9MXKxa3sHgxpLUCCHbDnCRiOpGS2
zMs5Mc9LkVD5iWlQ3UXX7xx9xwA6So5u+wkq+6+8yxlevCI/SFvfbkFLnUU8iGvZ
H/GIc+f8
=7bvN
-----END PGP SIGNATURE-----

--5f69i5OeNr/GFj5a--
