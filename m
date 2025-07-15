Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DC3C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 14:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C702D82E37;
	Tue, 15 Jul 2025 16:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tXPYvjE+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B20882F14; Tue, 15 Jul 2025 16:31:57 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4304482BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 16:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-73e5d932ab5so233584a34.0
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752589914; x=1753194714; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RsoK/vFvFfjba2wzNrjaYnKMir5dJ5e9dBBRofO2Jy4=;
 b=tXPYvjE+nViLYUMHawepMQm83Vqtfhnl9UWG/kL0kJ6MSG9XgQUTA7oli9vF+Eho+q
 uBRAZHBySsVPJ5TNjbpEsl94P75WybWwLsnBO94zVfa9sG6iYEYdgfRpYs2II3lRRg6R
 wbflGqhcdMfKp5yDnmugNYy0nZE/7dSQzRvJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752589914; x=1753194714;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RsoK/vFvFfjba2wzNrjaYnKMir5dJ5e9dBBRofO2Jy4=;
 b=xJy9hy7yPum1OIxxGJcLzHpnByW94J2iIuVMJ4bG+HTpgn9Hy4BW+NOtB59UcDR8gP
 TqX+O/SUl20Pi12zPXKFhHXBsLLMUkoWoqj3kpo5mTw1/pNnod613UjqQo7dibY+Qq9P
 HqapaQXeiiLtxMATCCOktCHEGXAsexsjOZOHpo97CRtMyTGSXjsBQA9y39+gWTp6o+xw
 r9xtgt8/qLrwCPX9rgM9MC+HIwv1aSU2c4TdHuKOSKM8Bc4HWw2/tRi1hlcex5Az1Zgj
 +qhlI5eMlLD/PCxzK8Hr+c/xgEbSKJKw3bK41Gr3IRDng6+P7AjLCjSDNcU6aciVYKkF
 0T+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3J+RRk0+e4lzalcCof5ujxQ2CxJ5bvxq4yUpcxzH/PzdG80BAlGlU4XHW3t6nDt2SwpvM9F0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9fzcHqovpnqwjZMQt5OSeB35LIhPGmOCv0aqXFX4xyXQmHK7H
 TTkbuLo6G112ei8T/5QUKYRD39eEhNaP+phYx2jL9Xwik/uiPXoDutPFBfGYhRsyQ5LxDHniDq0
 9IOKl0ko=
X-Gm-Gg: ASbGncutiaVQXymVVu2HMSeqdlioh1sw57ltNeOvBbRZjF/DR2lRRGeSTkckvgXKRuj
 wlAtTByYV35UtECEoqLwn8s6f6ncXcJ5c5hqa07Wrn473RssrtIa6Q5N8iQTSOKvLxecU85AzOb
 zedClDaFLLY8XYu2WXv0p5W8IYz0a+pJKZxdpO1DSoiQRq6N3AIMqeJ0sgvy6WYQLPFYqRrWg7B
 /CXG0QcGlDqCDt6Y0PqRdpbYNXRyVGLR1AfgIiy6Pi64BdjyigtYEPBaU7o9z6eZ3VEbf+GhpNf
 /8yFQ2S8kKaeCmp3az1W2Jq6qyFiAXDLhZyC0K8CdXktI7sdQRZD6TOw6fugGRJyTU7oAODu8W2
 cI79EbKdJUQmfBf1QsvDEmbjdZ5R/lZYumfCAUFbKRmmRhajDSH0CuDgm
X-Google-Smtp-Source: AGHT+IFA78fmuZEdmq/uJOYHJVvj44UH0jnEE3S/EecCQM1G8AVJBgiq0ZdXFrXLSDm/j2eDTQdG2Q==
X-Received: by 2002:a05:6830:8089:b0:73d:baa3:82c7 with SMTP id
 46e09a7af769-73dbaa388d5mr6340043a34.2.1752589913829; 
 Tue, 15 Jul 2025 07:31:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf0f147e7sm2150445a34.0.2025.07.15.07.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 07:31:53 -0700 (PDT)
Date: Tue, 15 Jul 2025 08:31:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Biju Das <biju.das.jz@bp.renesas.com>, Adam Ford <aford173@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Chris Paterson <chris.paterson2@renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] configs: renesas: Set CONFIG_TEXT_BASE to 0x0 for R-Car
 Gen3 PIE builds
Message-ID: <20250715143151.GE193579@bill-the-cat>
References: <20250715111103.1092458-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/HE3PhJSPaCUXO3p"
Content-Disposition: inline
In-Reply-To: <20250715111103.1092458-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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


--/HE3PhJSPaCUXO3p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 12:11:03PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> For Renesas R-Car Gen3 platforms with CONFIG_POSITION_INDEPENDENT enabled,
> override CONFIG_TEXT_BASE to 0x0 in each defconfig. The top-level Makefile
> already compensates for our PIE builds by appending:
>=20
>     OBJCOPYFLAGS_u-boot-elf.srec +=3D --change-addresses=3D0x50000000
>=20
> so that the flash_writer and legacy recovery tools still see an SREC load
> address of 0x5000_0000. This change prevents the "Program over size Error"
> reported by flash_writer when programming PIE U-Boot on these platforms.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  configs/hihope_rzg2_defconfig    | 2 +-
>  configs/r8a77970_eagle_defconfig | 2 +-
>  configs/r8a77970_v3msk_defconfig | 2 +-
>  configs/r8a77990_ebisu_defconfig | 2 +-
>  configs/r8a77995_draak_defconfig | 2 +-
>  configs/rzg2_beacon_defconfig    | 2 +-
>  configs/silinux_ek874_defconfig  | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
> index f5bb28cb0c7..931183cc34b 100644
> --- a/configs/hihope_rzg2_defconfig
> +++ b/configs/hihope_rzg2_defconfig
> @@ -5,7 +5,7 @@ CONFIG_ARCH_RENESAS=3Dy
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_COUNTER_FREQUENCY=3D16666666
>  CONFIG_ARCH_CPU_INIT=3Dy
> -CONFIG_TEXT_BASE=3D0x50000000
> +CONFIG_TEXT_BASE=3D0x0
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0xFFFE0000
>  CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a774a1-hihope-rzg2m-ex"

With POSITION_INDEPENDENT=3Dy the default is 0x0, so on the next resync
these lines will be removed. Please just remove the lines setting them
to 0x50000000, thanks.

--=20
Tom

--/HE3PhJSPaCUXO3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh2ZlYACgkQFHw5/5Y0
tyyhKQv/bZBKpwWLhv/GkmEZtIt68gYMoQBBpeZ6vM0r5YAxqWCIm8X9b2F+Xc1H
lyqOdc7EXs/fzopaFEZbHc58akaJCIdCwrT2loDnDJqeO4671Jmtq0/U8hl7gMhu
WCR6+tu2ahyjVSrH51fZ9XyT6Jyc4Ix4oJaE4JHcfFSklNB6exkc0r/FhF2XhYpr
SQMjHm/17btWjpvnt85F4Uipy7j/8S+MASvg9FYhtMG/FOIJCDuWBoqQMaHZQVl2
w3mvVfvgv9sgucJOS3qIesYMByILbUCw+Udn1dCWhYq8LeaozJvgt50WegYFaBwy
V/nS6h9i1e/egOxvlr5xwDBhVh2aA0pL4FAWeQtfBVeEVNgzXamXDfMxSo6d325+
dgKJAZetKerf/I7bmobiH64PUGBO5DLOkQwV7gT6lEJZvrD/2h9nCQ80Nf35ubnB
CUJADWWQ1ZpTK8fDdlmQZQs3Lgzv40Irk3PrNhg2wZUXe+NZNgLhXBfPobTDIvpP
sjmjdV/S
=fGua
-----END PGP SIGNATURE-----

--/HE3PhJSPaCUXO3p--
