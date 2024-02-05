Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9ABC4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 15:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EBFB86314;
	Mon,  5 Feb 2024 16:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="actU+yLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2479875E9; Mon,  5 Feb 2024 16:16:43 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 708BD8206E
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 16:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3bfcbfbfd92so1406128b6e.2
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 07:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707146200; x=1707751000; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iOa91RF/dngRmag+PF7Ts1/nXHF8tWGruFYoxhIoxos=;
 b=actU+yLwHgYlATOacZnIgdy32GTrQPYxbAvCuXXyoqbKqarsYlzBDR5pX/HVoBEaod
 CNlqXq2Yzzlbl7DinWMht17mKYUQm7dyFhswT7IWxeyx1KHpcbPPChMilCtCcq+GLAQj
 eDwjC5kLaSDjJIRmqY+Ndic/a3dxw7GzNhFrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707146200; x=1707751000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOa91RF/dngRmag+PF7Ts1/nXHF8tWGruFYoxhIoxos=;
 b=Syy31QwJfDWk5xno3ruucE9BjEQPJz/eDQ5N0obs4AtBEEq+yWOSi6vfFmFX5dw9wn
 TLOvUayqRAjGYLMaLs7cjIq6Uvx580AK9YSesmw2z+9oXwBEsqtrbmlBau7vNEf//dqj
 w2SJl3m6f+VCT15eeBJPMjJNo5xpcPTKiiZU7eyRqEjHUjw8+sRX1WITUueK3M+/SnYq
 VBdnOQooGQwBOk68Dnqk1+oGcGGhfj5Fn7HiOouEDn6HU7eWyxkNycsFVKwepbDiHwc/
 c4mybZ+ZyikuiPDWxJ3QRE3AKumCqNwDPu01DSQCvxq/fv/+QdFuIfdzKuUhUeuSjBhS
 F+nA==
X-Gm-Message-State: AOJu0YxFTW9BMycHdFdfsyHfIgyDTf3wESD3bqBhmv5yKD18m5rpEj8Z
 K/Y0A5mV/ZnF9RK9qH+vRdlT6qxKo7gbQ28lQ67LMYridzGUA2kQBylGf3ClOvo=
X-Google-Smtp-Source: AGHT+IF3arhlC0GFnlJSmTcVIie1o5q9keYZcX9B4riR55OJlM95ofVZxcjWILygdozNVGxVHd8GCA==
X-Received: by 2002:a05:6808:1905:b0:3be:3de9:68eb with SMTP id
 bf5-20020a056808190500b003be3de968ebmr15874870oib.39.1707146200033; 
 Mon, 05 Feb 2024 07:16:40 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVnDRD77Vcqb7UG1pLuSohp5tEf9ken58Xcsnv73XGed5otJ2jBnv0qMK2yT1JZ3IIYsWQeBjQrSgCgHtBjxgn1D/UtQjAnNXm9Ca0atdsN7eUcVkjxJnyoE8xyRuIxllvOUETF1/XVdImCGRJfaWso
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 j20-20020ac84414000000b0042c2382a53csm20770qtn.61.2024.02.05.07.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 07:16:39 -0800 (PST)
Date: Mon, 5 Feb 2024 10:16:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Dmitry Malkin <dmitry@bedrocksystems.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] rpi: updates for v2024.04
Message-ID: <20240205151637.GI1152441@bill-the-cat>
References: <37425599-aba9-4abd-8fb1-3fc9fb78dd8d@suse.com>
 <CALeDE9OgMjnqa+CWdGfmooBN0j0jzgjEtFcAq+HJWmMBSZYEuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7bJPmtwu9PC2XOtS"
Content-Disposition: inline
In-Reply-To: <CALeDE9OgMjnqa+CWdGfmooBN0j0jzgjEtFcAq+HJWmMBSZYEuQ@mail.gmail.com>
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


--7bJPmtwu9PC2XOtS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 10:42:27AM +0000, Peter Robinson wrote:
> On Wed, 31 Jan 2024 at 17:00, Matthias Brugger <mbrugger@suse.com> wrote:
> >
> > Hi Tom,
> >
> > Here come a small set of patches for v2024.04 for the RaspberryPi.
> > It adds basic support for RPi5 to be able to boot on a SD card.
> >
> > You can find the passing tests here:
> > https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/-/pipelines=
/19512
> >
> > It's the same commit ID as the tag, although it's not the same test-run.
> >
> > Regards,
> > Matthias
> >
> > ---
> > The following changes since commit 6faba41927bdc8973b59678649ef83c564cc=
421e:
> >
> >    Prepare v2024.04-rc1 (2024-01-29 20:53:19 -0500)
> >
> > are available in the Git repository at:
> >
> >    https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
> > tags/rpi-next-2024.04
> >
> > for you to fetch changes up to 12d479d01849c164020e17c3ae921f974b96372d:
> >
> >    configs: rpi_arm64: build position independent code (2024-01-30 17:4=
0:13 +0100)
> >
> > ----------------------------------------------------------------
> > Add RaspberryPi5 basic support.
>=20
> Acked-by: Peter Robinson <pbrobinson@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--7bJPmtwu9PC2XOtS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXA+9IACgkQFHw5/5Y0
tyy0igv+Pkbt+hchFFxwXCo0o8QSTkRv3jUh1qMXeWG9K1HMpziUwjFHoDEguIg8
1yg/UFf/Hhr882jq6IqvFhojscZfy15w8eyFco+dBtGFkg/Z4oKuT+UEswL2Z9Le
bYGGDFTo9sa84Ukq8a9l9vIi56jgsm4HjfZSYPPCkIHNAnO0f83kDhExxlld8CGv
JhNnONZnhzNiYZk41byB+krKZDY+aKTnDYHs9qsgUbp/d3GDRy9y/3QjmNb8EgIA
khcWEwIQ7eonKB5NvDXqJNM2QI1QJHKjdx+GesqFSVybJ5+RHYoSDitxpwFJx+ls
pz8JP5llnt9RJ6J6rRGFeMO9xaWksA8u+s2buRY6IODLllG3I3Qwr4vGdwnzA1u1
UCcumSrgswgIIcEDdVOZyK6rhaLPTG8FMxc3qr9kcPZJI08bYLR705T1T6cXmaUA
uq0HszKXHAuSZzGMt15FuwEcx6mGmZB+9EbhCdJ+KRj0cstYr+OR5zPKCKd+jx6D
UVGwjB6V
=WoIb
-----END PGP SIGNATURE-----

--7bJPmtwu9PC2XOtS--
