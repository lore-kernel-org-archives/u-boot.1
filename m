Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D08C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 19:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E5E687F24;
	Fri, 24 May 2024 21:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dZ+0ZwO0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6F5C87F69; Fri, 24 May 2024 21:39:26 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C2487E9D
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 21:39:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-79476195696so226049085a.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716579563; x=1717184363; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c10oJSAzldcCn2VrXjg2BgOzALeXmH5RpZeCXuJLfI4=;
 b=dZ+0ZwO0KDi2UVw+q1CrUm78P1MnOGp62zehX3yIzUuV4qKulpH3Jjp3ZZAevor8rX
 VGvFrVl8vy8PwiJlYbOto3muEnOb9CzL9yjXQuiy5Rt0POB9ert52/EvO8WTpi4XC4k8
 hEwMF3DDdscIczHOPZp/Cc0xomk08DM2S6xTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716579563; x=1717184363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c10oJSAzldcCn2VrXjg2BgOzALeXmH5RpZeCXuJLfI4=;
 b=D0inat7PD4mG9KSMWtOouP+oAYZBepHALT6mlgl4QOJlrq++9B40RmVT3VbOFnHY9t
 JIHA9nf29mKGnns+VDkHpua6kMSESrMn5ZAKePJQxvw8lgMznNMwvXfDHwGC+s55b3XP
 Zv1N+BOrK7QFJTCjD6C9Qi5AbGQM/Bw2nts0iOIHxNVrSMFEDXIYpGZZ9R3dOaa1zs1R
 dh+U+QM7X4RyM043KGCFPDV2QKz+P1J9zjeyPTcnpBKFHiauJTvg/Z4RAGdbrzFoTqVf
 ZMVCErrPQygQQfgF9PDV+K5tNJLeTRktckmSHnhipx/1CnWx7fpRWb03OS/0dijRMjZ6
 WenA==
X-Gm-Message-State: AOJu0Yw1uhnvXoP8XCJjOljumT75K/QazormgT/tG1K/POBpCx4nQa27
 J8920MHDoo9owsfs+Pgjf23Kh1DffcOpd3Rc1CIKTdyXpb11FBgeO2JKxYirlbU=
X-Google-Smtp-Source: AGHT+IGXT3A8TCli+7dxBCXdkq0fkSqZ1jUtdUJM4WpBew+7iQgfCynpesftj68/1Tp4IxyQMbnc6A==
X-Received: by 2002:a37:e306:0:b0:792:ca43:7222 with SMTP id
 af79cd13be357-794ab057756mr295073185a.8.1716579562989; 
 Fri, 24 May 2024 12:39:22 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abd44ec6sm87828385a.133.2024.05.24.12.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 12:39:22 -0700 (PDT)
Date: Fri, 24 May 2024 13:39:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20240524
Message-ID: <20240524193919.GE2568172@bill-the-cat>
References: <20240524162541.552282-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6Uyh0YkiQ8xIxu1z"
Content-Disposition: inline
In-Reply-To: <20240524162541.552282-1-festevam@gmail.com>
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


--6Uyh0YkiQ8xIxu1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 01:25:41PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/next, thanks.
>=20
> The following changes since commit 377e91c162ab09ec20f96f966f380cb55c590e=
dd:
>=20
>   Merge patch series "Clean-up patch set for MbedTLS integration" (2024-0=
5-22 08:55:35 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20240524
>=20
> for you to fetch changes up to 7457dc6f183303aaf2d58fff0a622e6791aba33c:
>=20
>   imx: hab: add documentation about the required keys/certs (2024-05-24 1=
1:33:15 -0300)
>=20
> u-boot-imx-master-20240524

Applied to u-boot/next, thanks!

--=20
Tom

--6Uyh0YkiQ8xIxu1z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZQ7OQACgkQFHw5/5Y0
tyx/8wv/W+fMMHSYTp3SGqMyaNUggF5jJFhR2BRRoWx79enYvX/S2WBVQbEkR9NE
VIrvPyraON4srF+B9XsoclhinFK/USqYS+ZCBT79W8orVbv9VirZrarx8gUUXQ6f
zVyWoCjWK8M6KITqa4aNofDaocJ5Zqzp7ekfL/fCiur9lEGcq5hTm6DqpGp4rz3y
II2ZNpQSBDXHTZgtRClyx4N7PZDEjZh47FPXkUWKbavCWGsGqC7BcDPntgC4OxE1
cZjjQnpxLNEEgCI3bXlfZeEH+T0PGdI5qyH0kFiFVPxQnV684d/TUSJuOp9bL2su
9az72cNKs+OwQg+8WeyGjL2V+AHm+zLpbAFM8ogOWmfsm6VnBQcMgGIROgV84OKV
RkytVBkgASvao6l2G1cIU8NrW/NvD/VQ27GfLOTG2SCXYLB9pkhEaL1JzEMJaUhx
BEpyGFxFx7z5ymksSyH1F46u4Pb6FkOFng+ecRRiQHEPfHzeZqLCJ12006qskZ6w
8vHjclNK
=+Ug9
-----END PGP SIGNATURE-----

--6Uyh0YkiQ8xIxu1z--
