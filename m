Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32674D277C1
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 22:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D387843E2;
	Fri,  9 Jan 2026 23:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZJGl0B7h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FEB5843E3; Fri,  9 Jan 2026 23:32:07 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42326843AD
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 23:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45a84c6746cso682988b6e.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 14:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767997923; x=1768602723; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fDJx1yQVfHMExHPy9maWgiWfEvpO8AAbKQJOnUTq/og=;
 b=ZJGl0B7hU1xLRz52xVzPXPb0+ro0Viil3Sdyofq+1ddBtYKz3UxjQUR6SGaJoFxSxg
 wgoi4AbS/rJfeSTOi/uekIAenXg+FsFGHCYoNVEf6lpemLWeKC64ffsFbdva3iWRie09
 7jxbud6rT8Ie5U+CW/BwHVKpJPyLNUsJZGGgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767997923; x=1768602723;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDJx1yQVfHMExHPy9maWgiWfEvpO8AAbKQJOnUTq/og=;
 b=wte1y0DhVoRrvK3ORLDPZMgZ3sDSr0WMZLSCqsghZflbv5eC1yQJZcX8VtoeRwHnDi
 nN+n/PLKNZWrVXTKp+DDfcqPoobATUKTyWFA2USsezG1eEYusxXE4Cg3gUPC8mUW3Mns
 +/Ff+ezXU9T5H864unlSSWq6bB6Yk1jYS+LKxh1+oQ/8dhk0xgTmNSnGZiPxub7TwkkT
 fELXizR9eax+W3gsVoXjoGihNo6LhFT8M5WvaM0h1TwYu2isziAT/QVWIpIYsR7BWMOz
 ml/tM9vNiYgLxGokZPRrjKcxxv5dRnzORnY+hwSvuQR7MPYj2VxCqHT6gKCQ9/GkScih
 Oq/w==
X-Gm-Message-State: AOJu0YwKS9Ch5VcceLGJBHmDbcDJ0RZsNrDK8Ygtil2wz2OS1c1PeWL+
 rLB/kC9WIUZXiJmWESU/vi8+vajIXspXXi1o5RgIaY+JLvVIiCo6/N2PevQmpLnonrMPmjIi+AO
 /MejwEIc=
X-Gm-Gg: AY/fxX4sMF9botNwEPN3w6il8luWjUyDc06NsZzXcRFNFLA0Fu8SJ4fM9VBZ4NMuzdm
 X8CN2AAK6A/b5mGNksqvEmY7wANcc5IILRBd4HPhFmFUwK5GpqL5OSnsU4+KbK7bVLTWDzfKgI+
 VjuTlUd3npA5JBauV/f74aXMYSi3pt2uEE1ET7q3SnEUfflOQNbfOaDr6IoVOf699MXf8BLv4pw
 QzRS3JWCCeRAg7zHtfyRFjxBJ+Js18CnO6fjTX9Ssqvd9zP7guxTu9xPTxD17PeqcTOvpaOOAhd
 KqGGMM2MyROgmFZQ+eFzPCtsYUnpKg1VedTdQjINX0RAmXvrblsuQ2hwGFRfmMdi8JZmniMKARc
 MjOhZGRdrj5LR96Qe8dilYCAEkZB4Uqzf3N7q+59mHz2+BNO+KzPmTXNLLKJhI1pcXuLJQnqw4x
 /2ACO3zHsq0XltCmAYtunGMF741bURFsbdAOPbpdFYRrVjxdJqzHDHuZkyOhG3hlA+8cQCW+5Rl
 hWTcbR23ZwnuY7UzIPhp8WR8ugppcbD3teU1q4=
X-Google-Smtp-Source: AGHT+IGsk+pZVBKhNAs2aMaYE2Yys9QkfdoYEkBdd6gBz5ubnKPCst1JkWgPSucjWqtO/LoKfyYQWA==
X-Received: by 2002:a05:6808:148a:b0:459:b48b:d11f with SMTP id
 5614622812f47-45a6bdb8c1dmr5660872b6e.17.1767997922979; 
 Fri, 09 Jan 2026 14:32:02 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5dfb6256sm5499199b6e.0.2026.01.09.14.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 14:32:02 -0800 (PST)
Date: Fri, 9 Jan 2026 16:31:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH v2] binman: elf: Check for ELF_TOOLS availability in
 is_valid
Message-ID: <20260109223158.GN3416603@bill-the-cat>
References: <20260109-pyelftools-warning-v2-1-e27784f14c56@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MTZoEtxFGeGFuWpw"
Content-Disposition: inline
In-Reply-To: <20260109-pyelftools-warning-v2-1-e27784f14c56@gmail.com>
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


--MTZoEtxFGeGFuWpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 11:03:28PM +0100, Dmitrii Sharshakov wrote:

> Check if elftools package is available before running DecodeElf().
>=20
> This clarifies the error message.
>=20
> Signed-off-by: Dmitrii Sharshakov <d3dx12.xx@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--MTZoEtxFGeGFuWpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWGB2wAKCRAr4qD1Cr/k
Cp6MAP0eh+C3SGHe0SKu1Pl+g/RUOw1hVp5srFA0ZyWPXLarqgD9ErjUdfg07MEf
WwgP8JHaaeY6yDlwZhlEoHEqyDoGmAs=
=16LJ
-----END PGP SIGNATURE-----

--MTZoEtxFGeGFuWpw--
