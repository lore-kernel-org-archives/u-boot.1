Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B852EE67819
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 23:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE74890DF;
	Sun,  3 Nov 2024 00:25:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RqjFxG2G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51568890F8; Sun,  3 Nov 2024 00:25:21 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AAD2890D9
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 00:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbe68f787dso20318806d6.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 16:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730589918; x=1731194718; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xMaX3aKJoSLOpYqNCcf2FWgWoVOtUPDw3iZ0Iq76UnQ=;
 b=RqjFxG2GxXSKho2PFn6LSHiRmKjSdDrpqHjaTszJhOEm3vpHjcHpnj5SuJVOal86Ik
 Y4ZArWJPrt2pHVEyWPbDvhM0m86GSPwDY36BAv5S/ptF3/2Ii8CfP9pN9nzXODMXBLsK
 8KBqETy9lEQWDheC1MFgP+z/gqRgJzTWIEPRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730589918; x=1731194718;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMaX3aKJoSLOpYqNCcf2FWgWoVOtUPDw3iZ0Iq76UnQ=;
 b=HA8Ac9ACISlLp9PkxQq+HqiEwF+eL9PhBYf0Gg0MlX64TDuqUtOGdx/CKMyqTNghxA
 4zjBeFCVk8zYyp7PTSNCnBujEBwtxTeBTXtGGZAYfll18Xbl74NLzsM7ewH5Ik0hZQ6d
 RKxAVZgMofW2gikPsZ65fTJG6EdzSjyTyEa+BPaM3e9u9BcdkUe7dgQLQv1IMd2pviI4
 v48gUGM19nBAtJX1d4CVh1Qih7EwJSXhlW361ZbFLbciC65X/hx2FacWYsWcdOkUTizh
 SSeZj0tRezk6gi02wDp0OM/aSeHuA5HiwmaZxf4mx9i37bcvXzIuIIkwiTzLH80I/U/F
 MglQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiQO/Kb72XTeJI4HuL4xQwwZpdWW+85fGXGCiT4UOG0gz9W6XUU6mAI+JCQiqGKMVpAr8i8RI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzh5C0vVcJikCvBYL+ryC7Xh4NsCGNZaaI8PsXhTw+sqE9bMVlY
 InwkWRbvBlvqL6w6vtk+PatrSqpvU5JS+YMGUSXAfrgQHkvsfPcVuTIVTJ2WBgZbE6Mmy6A77El
 h
X-Google-Smtp-Source: AGHT+IGBGfgsel9ZOjpBGIvn1Eax1OAoDzgdANsJxlR+qaxEZvnKy0QWNXxi+eloaJDF+H0RSpuNzQ==
X-Received: by 2002:a05:6214:3a09:b0:6d3:46f5:7d0b with SMTP id
 6a1803df08f44-6d351b07375mr142425806d6.45.1730589918137; 
 Sat, 02 Nov 2024 16:25:18 -0700 (PDT)
Received: from bill-the-cat ([189.177.125.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fa6786sm33904256d6.13.2024.11.02.16.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 16:25:17 -0700 (PDT)
Date: Sat, 2 Nov 2024 17:25:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] lmb: remove __maybe_unused from lmb_map_update_notify
Message-ID: <20241102232513.GX3600562@bill-the-cat>
References: <20241028062136.10742-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aCtJJvITc7H4tW1r"
Content-Disposition: inline
In-Reply-To: <20241028062136.10742-1-heinrich.schuchardt@canonical.com>
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


--aCtJJvITc7H4tW1r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 07:21:36AM +0100, Heinrich Schuchardt wrote:

> Function lmb_map_update_notify() is always referenced.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--aCtJJvITc7H4tW1r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcmtNkACgkQFHw5/5Y0
tyz+EQv+MGw6gVsO083QIEwJgq9Y85vQMussot7NoB9CeRvIwsyyvi87v7JMnd6W
eKcgWLIjab+I5ByiKPL2QPxh/dxOxMBNN0K17T8dNwk9k5A5vWHtilsPvCKjfN+O
CuNh0DSpxfYcT673hYAvTRtWVVypjdf1TilmytI/StQumd/f1/Pf0SLHgsEsdXFv
rsapCJou2jgRJMRPG/zr1lq+yFta2BRuxHmGDIuLj/fLMg2a1fpFFwjR2wGd67ZM
3bjsfhS7kfJy4qXAkBMDmWpcAD8c2DTOt9+ZK8Q7GUEtoGvErxacHM5xfQgAfcKd
XHh3AE1kbvoLGuHOD8lKjklDGAxa54YawqEV6w94xh2U6EgYehocf5g3rZW1vFrf
mgfSNANK40VTO4NZ8dq2kHl+9CIgcDExfXt287A5n6MrO9EevnpDqUDDtevbOBJ1
dlWWAnaexXs+Rg3iIpiTCFe7aOgpZmNdQaweyF+1AzHg59bunXiZGnuVeUmpO0qq
yeu4ER7z
=2lNX
-----END PGP SIGNATURE-----

--aCtJJvITc7H4tW1r--
