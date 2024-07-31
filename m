Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A25CC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 23:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44E1E88614;
	Thu,  1 Aug 2024 01:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZHS/YSDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F5D2884A9; Thu,  1 Aug 2024 01:51:54 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D79488614
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 01:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-70944d76a04so787421a34.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722469910; x=1723074710; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/pkl+23iiG8vibgYr8xyMFati/4uGwlnTYS/SpuaJgo=;
 b=ZHS/YSDeDrLb+2DY21yoGZJbHNLHHJkvDTA54T4mUDMWK3CDjXQ+grrBd8AvBaVKwO
 Wq8O6nZzf91+guMT3wcwRWsxVOlI/jkfOxikrIu5I0sWgK8zgmPeg34a9yAeWJ1Srz2K
 gt77YJ57DW2+UVwGRZkhF7DKzT68tTCleY0PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722469910; x=1723074710;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/pkl+23iiG8vibgYr8xyMFati/4uGwlnTYS/SpuaJgo=;
 b=R+fARLoI/bhQZYxfznotb/p0a9aWCcXlcnvdTv9GE+Q/dvQKaksnJ6yzVsOmf+W9Id
 h9JUPabsoahzIl0L2CBBY2aVURY+LtjenIkiQqcigcAUa9dceAPR7NYVgXyNBCVm5NZq
 Lj60EZuV/bXSrlsO3GJgeuqnwzeAbK9DgmSr2/PCAsxDqR8LMKro9c4uzrDuwqRJrsx+
 tRXrSO0d1QUgVdKo+AjRMwCdYms0jXBXCeBZinVsbq/hZpyyF68zK1OdHlb9YzaVgty0
 acXFzEsOf8OC+u+yvp2rt7CBpE59Xhzr7tYCJRk1DKO15h8PuDzuk45qu46WXlzqa7+0
 mLcQ==
X-Gm-Message-State: AOJu0Yy96FpLsuUW3k9AcqVzYY2SIRAj9anv6nNgPuhMA765rVaNFjd9
 r8D35SyOgF0Nm/K8plcE3VTGZQ3PjYUTIzebDBmHNUzOdvcyl4kR7amv07ybTt1p38ch59BRPGf
 2nOw=
X-Google-Smtp-Source: AGHT+IFpuSjP0fgJoth3UxuJucha7yoSD7tw0CiZMP270lYvrkAOJSXOnb1sMRWjlwryXy2JzUccYQ==
X-Received: by 2002:a05:6830:1212:b0:703:6c9d:cb81 with SMTP id
 46e09a7af769-7095b7ad86dmr2981588a34.3.1722469909865; 
 Wed, 31 Jul 2024 16:51:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7095aeb1b80sm1135547a34.71.2024.07.31.16.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 16:51:49 -0700 (PDT)
Date: Wed, 31 Jul 2024 17:51:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] u-boot-video/video-20240731
Message-ID: <20240731235146.GG3794063@bill-the-cat>
References: <20240731204037.509e2017@crub>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lGEKd8o2bgbdc0R7"
Content-Disposition: inline
In-Reply-To: <20240731204037.509e2017@crub>
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


--lGEKd8o2bgbdc0R7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 08:40:37PM +0200, Anatolij Gustschin wrote:

> Hi Tom,
>=20
> please pull video driver updates.
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-video/-/pipelines/218=
23
>=20
> Thanks,
> Anatolij
>=20
> The following changes since commit 8877bc51a8a4d921ba2f163208b8b1a57ba47c=
18:
>=20
>   Merge patch series "led: implement software blinking" (2024-07-30 14:31=
:24 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-video.git tags/video-20=
240731
>=20
> for you to fetch changes up to 521d377f7852c037e338c66756982084b1cb0132:
>=20
>   sandbox: Drop video-sync in serial driver (2024-07-31 16:56:06 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--lGEKd8o2bgbdc0R7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaqzg4ACgkQFHw5/5Y0
tyxK2Av+I1Gf+mmVJb8FSVwA78J1s7OWgrgKGW9jHi10dyXit6XMcr7KD6hzPvxn
VSVA5hIM0gm4a6IVrNJoxvIBskJkV7tCX2YKwzvnmz62ggE6xab0CgyIDET1xtVN
6UsVNj4EMEu+dsYPoO1rAeH2mulyPvA7S/rf2CxdsnPeoaOHnWCjGNAWGmoq0q2y
Quykbkg/C6ywmH22rXnAlFVddgDg85tPaWxlnT9ftYTJjT3yUzHIkAu8aaCR3L7Y
fCt8bUhAeujA0pzd9ao+UGaPX5zAOiCoYdyKbFl2WwFsVUJoimtN2sUTWWfBoQHT
RqoywglwgDeg/BUCShMQF8uawqTRsgyuZApjvI3rNgC5X3IU0EcvEZi2D+wczT1l
IT2i5bztIHTh7iGWWBythUVI7wz0Wuzei/dZogw+MjtpQjHm4ICrwPxmbVhohbiu
wK+5yT4/6QXY+Zgsxu2NeBIlEk28lGIs70WVgQqO62Mx+W6ZdGMJvQEzmktpdTq0
Ayt+gAIL
=qx/2
-----END PGP SIGNATURE-----

--lGEKd8o2bgbdc0R7--
