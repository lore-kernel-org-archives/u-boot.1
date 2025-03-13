Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A102C282EC
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 16:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 303CA80F9C;
	Thu, 13 Mar 2025 17:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ssx13xoN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E40980FF7; Thu, 13 Mar 2025 17:15:48 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366E180540
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 17:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7c55500d08cso105929885a.0
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741882543; x=1742487343; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FDirA7dAp3IEAyF43rzMrZRKY+SoFep39HHTHLz76cY=;
 b=Ssx13xoNRm3jyba+EJHSFEo0h/ZJ5dgCJVwVTYMSTyxX0CVRk+8Zfsx3MqWPUIW3j9
 Xmg29JDPuJZM9vciMpg/p/xkK+yA+3TzTZqFJhJDsDoU/uGoRHemBJVwgi5IqF6NsdRl
 H3FzrSNKnyMrvryLwBPdg/aKYGwGwNzD09w8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741882543; x=1742487343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDirA7dAp3IEAyF43rzMrZRKY+SoFep39HHTHLz76cY=;
 b=hlIOR8soYUXsCh5uwl/3dgEdvo2YK5FsJGUz/5tk31ezmaEuOdOS4yUBzTeBv00q+3
 UuwtPMgqYOw3Ztt/GB+QvCNO6WbaDSsGecKQBcNzrJbqG1OVCNh+HlS3J01XTJ4oMoBm
 TiuVXRjnU+p87CYVEyHWbghB/vrmxBhjMDtp+7T77rcveF9XO0tIM9gtJeikcU4+5oJp
 1BT9MZhv8924w+yUOYGjdKD3IlQLnVRuRJO9DsUxFabw/P0yKsxwxrKwmpWiSVQdT8JN
 7u8LiTK+FIDdL9iuTpLwSqWbiEOcdkKrarLu7ERvui7NrNlw8/zyT/DY2GVMkqqiWsdZ
 XAMw==
X-Gm-Message-State: AOJu0Yzr2d3Gc93yC2MZuE40zgY4evJ+UKfIE1/qnJG3QYzBcLIvm4uY
 GYoiCtEfcdk6ZXvzEwUSKvJ+VGxDCm+qoIcAhr3iYYGRPantAXs3LI8vNnUOw1AJrLbSXjDQMBl
 T
X-Gm-Gg: ASbGncuiA8VixYSv0r71EiuWJvfKTLs+cg9SogybuMgNN4TQiTPnXEOhhonA2UELs8m
 sdxWA0kyW/+3G7lthLxKRVffnERETxUNA1w+CHlbPWfkUKMgcSYZP15FQ6rjTGtyyZrR6U0Xnqp
 7YNRacUdRLYm7iLapHkdS73LZKTreUYaK+97VA5bop2FfzTejMLx8mkQVAHFeX0WrqPR0CmIQeN
 f1xq8r7otTc0jDm5+4u5Wb/pu9guX844sHKiEo/m3y0WBMeunVYn6ijGT66YhQKn8bliXxUIyeR
 nE/GZqFz4Xaq8E/VvcusFS3P83AW1PB94fYSXUr3zNC1+w==
X-Google-Smtp-Source: AGHT+IFkKN0gHNfFMvqWwPrna5ff2L/tUo2CDXNKqTwY7t0tnA8NK+++/krI4romAOIYJhJ/GHLYjg==
X-Received: by 2002:a05:620a:808a:b0:7c5:4b91:6a41 with SMTP id
 af79cd13be357-7c55e929eabmr1842781685a.42.1741882542936; 
 Thu, 13 Mar 2025 09:15:42 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c4e8b9sm116862585a.2.2025.03.13.09.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:15:42 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:15:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: u-boot@lists.denx.de
Subject: Re: [RFC PATCH 1/4] cmd: fuse: Remove custom string functions
Message-ID: <20250313161539.GE2640854@bill-the-cat>
References: <20250313115517.1181829-1-h-vm@ti.com>
 <20250313115517.1181829-2-h-vm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uioESmBOJsvJOKSY"
Content-Disposition: inline
In-Reply-To: <20250313115517.1181829-2-h-vm@ti.com>
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


--uioESmBOJsvJOKSY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 05:25:14PM +0530, Harsha Vardhan V M wrote:

> Remove custom string functions and replace them with normal string
> functions. Remove the custom strtou32 and replace it with str2long.
>=20
> Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>

Thanks for doing this.

> ---
>  cmd/fuse.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
>=20
> diff --git a/cmd/fuse.c b/cmd/fuse.c
> index 598ef496a43..9f489570634 100644
> --- a/cmd/fuse.c
> +++ b/cmd/fuse.c
> @@ -15,17 +15,6 @@
>  #include <vsprintf.h>
>  #include <linux/errno.h>
> =20
> -static int strtou32(const char *str, unsigned int base, u32 *result)
> -{
> -	char *ep;
> -
> -	*result =3D simple_strtoul(str, &ep, base);
> -	if (ep =3D=3D str || *ep !=3D '\0')
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
>  static int confirm_prog(void)
>  {
>  	puts("Warning: Programming fuses is an irreversible operation!\n"
> @@ -54,14 +43,14 @@ static int do_fuse(struct cmd_tbl *cmdtp, int flag, i=
nt argc,
>  	argc -=3D 2 + confirmed;
>  	argv +=3D 2 + confirmed;
> =20
> -	if (argc < 2 || strtou32(argv[0], 0, &bank) ||
> -			strtou32(argv[1], 0, &word))
> +	if (argc < 2 || !(str2long(argv[0], (ulong *)&bank)) ||
> +			!(str2long(argv[1], (ulong *)&word)))

I didn't know we had "str2long" which is a differently rarely used
function. Why not just simple_strtoul inline? Am I missing something?
Thanks.

--=20
Tom

--uioESmBOJsvJOKSY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfTBKgACgkQFHw5/5Y0
tyxPcQv/bWmSNgow7mR1XWSRiJi9dShonqZVUlLnUExGdq42mVscPTg2zJSyFTzn
lB20ZdtlFRWMakvNptXaKjMYOuqw3jWBlGpsvtE2tM+iUxSUIlfo5kCGEJjTPnCe
PtIK9rW0MTwQg8SFEaUmvUdfWEYAZBynB3kyiIWs92SrOHN+F4QKi/7dl7RFCvtp
43ibB51qhkF2d6LntwTmSWLFJOWqReIMrL6WMg4yCGxYUFu9NFt63caC39oaNKN0
6kP0kNCU3+Ygpj/TbdNWwhC4fy9aGQtvU1owyknweP2uTtNkgZzSGBUUvadXdHWU
pdicRRtFnXCb2RFyqUUagxjTvoMoF79EavQdG23aoF+JyfPvJTwP1f+9QG2S5JvK
XV2XhnFtHhP6n56JynmlnlvgmpAQ/siEP0/iHLr3Uyvbh+qaaK5+nS899VKCw9X2
kOre/lqV9RTyR/6rqEiksUA8x2Ee5bP4fYbw7CdyuJ3n3x8lp9PWuhjxlyF9gJOX
8KdRAczz
=ILCa
-----END PGP SIGNATURE-----

--uioESmBOJsvJOKSY--
