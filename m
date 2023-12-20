Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFE5C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 21:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843E58784F;
	Wed, 20 Dec 2023 22:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AWg8XCHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E129877F3; Wed, 20 Dec 2023 22:01:47 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D69C8784D
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 22:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-35f71436397so316585ab.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703106104; x=1703710904; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nOkVFC1xIhmrIwzXVj9pciWDDk+6RUTQDf6nrXJTIOk=;
 b=AWg8XCHcckYgRIUSJ+R7H20dAVpVHBO2f6DZzvSg/X3Zzs20SN58eJVxqZuDWevBLL
 E88UvDWWwx1+5INcXoE4SeWK5/7raLDrdZJy0XVmYe4ZULHe3w+dVLK8Sa/dcbRtWqoI
 FCHh/bEzsUnI5TL4wiAGuk4+ODvdXANZKnBaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703106104; x=1703710904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOkVFC1xIhmrIwzXVj9pciWDDk+6RUTQDf6nrXJTIOk=;
 b=g5nAADNre8KevhF19itXqHbATl2ObGxi0zLYv2SXM/gAkdCCyeVHvxLclKMImA6tuH
 z4YPIwveGPqSX+KkJiv6Al8heg/7Rks7rAv/VRAQDvNh9xxhw/LmoM3H1EnPRqc/Xq6o
 bf6JIo5FBNk3aBcIf3EuabdZR85sI50ZWdi+kzJdUJpXCw+3CP+1sU4fyUimuJdUG1Vo
 FFn89aCNV2OlPn2U89lqDo9i5/xOKnVbZi2bNukTFV4EdGp+TfuDwrXBHyokuRupjqau
 N285lX/LGMWwxN+Q4TxOmbTAAf/+j5ynYUZXzyAk/3K4rz8676DKMFppz/z5u0vZ2Vxy
 JQaQ==
X-Gm-Message-State: AOJu0Yyo7HknTC5Cdt9mBd01YZhp68/LYGM3Soe1gW/2GpAYxmYAivxN
 S9gjsMxpaalb4CgQ0tOtrRayFA==
X-Google-Smtp-Source: AGHT+IEsVpBNN0CR+ShD77Q11wBBYWc+vvLiburPTjn/VQU7aK5PPqVYlwR+pYGyrq3VfNms39tfFQ==
X-Received: by 2002:a05:6e02:198f:b0:35f:d1aa:f41c with SMTP id
 g15-20020a056e02198f00b0035fd1aaf41cmr384909ilf.10.1703106104168; 
 Wed, 20 Dec 2023 13:01:44 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 z201-20020a0dd7d2000000b005d9729068f5sm238885ywd.42.2023.12.20.13.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 13:01:43 -0800 (PST)
Date: Wed, 20 Dec 2023 16:01:41 -0500
From: Tom Rini <trini@konsulko.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Simon Glass <sjg@chromium.org>, linux@yadro.com,
 Nikita Shubin <n.shubin@yadro.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Ovidiu Panait <ovidiu.panait@windriver.com>,
 Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
 Stefan Roese <sr@denx.de>, Daniel Golle <daniel@makrotopia.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] imxtract: specify max gunzip size
Message-ID: <20231220210141.GU2513409@bill-the-cat>
References: <CAPnjgZ2qsvtFui1Q97t8TOxMXWq8LLzvr=KEdNU=MG9Vm0aJ=g@mail.gmail.com>
 <20221219080527.17996-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t1eLtDfC22y6Vc1a"
Content-Disposition: inline
In-Reply-To: <20221219080527.17996-1-nikita.shubin@maquefel.me>
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


--t1eLtDfC22y6Vc1a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2022 at 11:05:27AM +0300, Nikita Shubin wrote:

> From: Nikita Shubin <n.shubin@yadro.com>
>=20
> Specify max gunzip size from config to override SYS_XIMG_LEN
> default value wich is 0x800000. In case we have a large portion of FIT
> image, for example gzipped kernel with decompressed size large than
> 0x800000 we should enlarge imxract area, otherwise extracting it will
> fail.
>=20
> It used to be a hardcoded define in cmd/ximg.c and we are moving it to
> config.
>=20
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--t1eLtDfC22y6Vc1a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDVjUACgkQFHw5/5Y0
tyzyWQv/bNzCM0OJugBfUVyyCMUTOmk2+68rmd+ui8gaqw9JAZNdzeGuOhmAUizp
xCdwoxZbllVW6yL6H7kmNRhsizERWu2cP3hvYRdY4CY9zPwIPSSelI7HfgvZx9Li
LSZzWZiQNtEy8V+GWmhMvzL2CYLynzp6Mm03qb488zRe9yNHNjqAZi7iwrD39wA+
/4raziriHR55G+O3By/A++jINyGsw5drmH2jf8eaPWQNu950iDN35V3ItmR001+X
icYKkalh/ZpI++dcqqeVGPmMtKamKOl2FVR6zBQaqZDAf1LmGfVpMC/smKR8erqX
vt+BBe1+ZsJp2II9IDVmvN0UirHwmNPk/FZfseCS1Y55pkemFNj3TUmjJ1yTgI+U
QQ4YxShg5CgBBbd3QT7njci9KrWB0M0Qvxf4SmDx68GWDDSTVfBZm82FaehlRBvJ
83pfRgWX6HNo9FqpnYLmrHFIiDzpyz1E5aKW32u01n2NU/cG8nDr/dh7Xqb0jw9C
l9jTlcSC
=T1yd
-----END PGP SIGNATURE-----

--t1eLtDfC22y6Vc1a--
