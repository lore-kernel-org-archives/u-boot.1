Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C5BE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB43C89780;
	Mon,  9 Dec 2024 20:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p8xl1Pcw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92ECB8975E; Mon,  9 Dec 2024 20:01:41 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 348AA8975E
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4677230a9ccso5525551cf.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733770898; x=1734375698; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LNO4xXGN0f7vTvlytM5BWrCQ44ppDX4qLNjzYcwtZ7Q=;
 b=p8xl1Pcw+U63gYp4hSXz9ZE+w7yIelvWcRTQb83AIz2bF+jstnI0dtW0H/YqSVGmUF
 1ATMHbNzE+vxuS2uH+z7hK/WOKlgTHlTe+6p3XCM/WNDMj1JhmjsdQIq8OapjA0m5PNt
 ND6mYGCNI/52kO+ijkg37doRi71gyEixAhXIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733770898; x=1734375698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNO4xXGN0f7vTvlytM5BWrCQ44ppDX4qLNjzYcwtZ7Q=;
 b=BQR/JApI8nrH75dVzdvz1oSwr5B8OKBLqa/JIgI36Gilmoxy+w2TKZVa+STurIPLQR
 6Ds2vX0mD6fwqL7dnl7wrf+5cUfbhNKWKGFIt+iQcDzBh4wmhZKd8iboRUf9A0rVWVs1
 zvgsnBObA3YXaoYBjWnOCK+qRAudq7WUT9EuDPp/Kq/hJEqt3STKsjzBLMRxyfF/aA2o
 ImjDmUMMnEL398yZ+0Ll4//+ixRiM7ntyBGdEn5JviF2ncuZ/gNvZu1Mbs/birOARnPm
 nRhrFsdhueYz49fjCKIJDrYXThxbztx6e9ZTHaa1iVRCkG/7bBVNFSch70RyxMkZRgLo
 JguA==
X-Gm-Message-State: AOJu0YzhX9KIJu3Ji7r7Mpodc/u4Lz+2YtOz1qAPPVjbH01wa6FUuKKb
 me8Rvjd66BlGCYdSL2bxiEHUFKRXIGLFWaOX0DRl1b8+nQruiXxGNBlexqXGkzpZ9RT8Im6YPcy
 daa4=
X-Gm-Gg: ASbGncu2ZpGB7Q9ofn7qqejVwgLkxTRaw0z72Wn8TqD0SlBXZ/xClasUd/ic3rmJNVs
 ByeHAxzRMnd1KCWhb++AGfyFp3toA+8bwbp7yAQnhZxFhPFlt3SA7Fmvkwe6eYdMzeAobGJ8jfB
 TlvVRhscfaZvOosBzt3Gl+Pt3KvAOjdLLwPawPABCX/6vNyoQ/4Jyz93xonLN4v410BB7kwBVYB
 hhPBuTry/Tbl9+JspgZRuMi49HM/wYF242mnYYTTsQp3I+AwYheNnI=
X-Google-Smtp-Source: AGHT+IGCrIrVrpDrxAUKlpFfmJMZqIxxCHXRezv+1FoCgB8rxvnrQPy9uDKOZ/I4qg6gYl2ysyD/yw==
X-Received: by 2002:a05:622a:1aa2:b0:467:5f17:94d with SMTP id
 d75a77b69052e-4675f1776bbmr118627921cf.52.1733770896644; 
 Mon, 09 Dec 2024 11:01:36 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d4d7dsm54107771cf.34.2024.12.09.11.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:01:35 -0800 (PST)
Date: Mon, 9 Dec 2024 13:01:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20241209
Message-ID: <20241209190133.GQ2457179@bill-the-cat>
References: <20241209122043.1208400-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M8zRHJtq+N8QNdud"
Content-Disposition: inline
In-Reply-To: <20241209122043.1208400-1-festevam@gmail.com>
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


--M8zRHJtq+N8QNdud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 09:20:43AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/next, thanks.
>=20
> The following changes since commit 39759bf9fe3a5b6d4788164fc046f5f8aee5cb=
ff:
>=20
>   Merge patch series "board: ti: k3-am65: covert last board to OF_UPSTREA=
M" (2024-12-06 16:39:26 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20241209
>=20
> for you to fetch changes up to 1c9fe756edba755679e8e4dc525d12e7deda3808:
>=20
>   board: dhelectronics: Sync env variable dh_som_serial_number with SN (2=
024-12-07 09:07:45 -0300)
>=20
> u-boot-imx-next-20241209

Applied to u-boot/next, thanks!

--=20
Tom

--M8zRHJtq+N8QNdud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdXPo0ACgkQFHw5/5Y0
tyyy6Av/cdpo52EGdG5OwitZTTNDPStB8+fC9Akxey/XqAJePFoFTjVVtkGPSscq
ZBtvLsnon/rTbqo3lmI/NRunhEF4JJNpWygS2SkIbW+N4rE6oo2ucBouOpZeT//y
RXA96C2TKHFGS7yolARvsaD763PINomQSGzcomjwhk9krw0EowLZvxg1vJkPSMey
Od+HPSK2uH0X/CRj+mbHOqUJ1eKqMJx9BOaokclD/FdzuQ/m9e1In3lyVBEk10Ko
ZdwwwehjRKhx8/Jr56pMlb8ARqJnnCi17uKI+SSb4lXcBV8TK9RKt5G7/qcBbS6g
BdYNVNZxj9cbIHRxgZau8KwBXavi1G2kMwcQ549SoC8akL67zZT/Z3HQuNyeo3fx
SWOu/VsoAjLZ4vt1PBhg+1ahfQ8Q2u8QAa7k6d4GMOw4SCi5+iLTtBdk8ZbgGG9v
xm8swvF70q+ux1p949qtBvHXoreFwO13q/DOrpBkkqhLy+Rj8jL7XZJ1iWxt5jiZ
73LHIcIL
=Kp8f
-----END PGP SIGNATURE-----

--M8zRHJtq+N8QNdud--
