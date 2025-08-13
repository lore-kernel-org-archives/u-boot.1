Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB10ACA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 17:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D043A8365E;
	Wed, 13 Aug 2025 19:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uoRHiaQD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D68E783666; Wed, 13 Aug 2025 19:13:03 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 424BB8334F
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 19:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-74382002fa6so12201a34.3
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755105179; x=1755709979; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QyNiT04c61MTjtkUTO2O1Sku7SQOwbkGz1jBF7IUFKw=;
 b=uoRHiaQDjpNiNGcQU7MWRVYUlFBED3mnxgiDidHNGcX4S/9ZMlQVYg01iXZZEQTEBI
 1pTzrT4nvijVELZH6fRgeeMhE1n7Ip6lUaHSJvxLp3r8kD8yCnKVA4uzZURE4ZYI7Dch
 T1pOR9egAuq+NCMpzFxqBw2OODNgVtTyC1Fy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755105179; x=1755709979;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyNiT04c61MTjtkUTO2O1Sku7SQOwbkGz1jBF7IUFKw=;
 b=DYHjLKVnhoZzGZ/3QrTQn40gGLExdhDZhmIsonB55dk4uA6bZUGWN23kGQsd8gwKAe
 2XeptP79Eh6OHfvEkJJ7wnixvTS0MuDWNUOa0POGaZDAo3C/WzOhmpuyA+caev2YyLJR
 sOqJeKEDZJDzHA4qIffK1zsU7pDl+YtisvOQOYoda2nlP9JHI2A/QG3Yq0VBNgE1oomO
 nz79rlDIt/x5MMhnZLF7XhV+3w+UKuW+eoqg+2T8daEPoC7hKrkBnFUM1P7kvDGcG8c+
 GGSZ8ZBUyFADI4DvT24XsK8c8XKZxzz8gNqTYQXOPyh2VKWFlY1aWvnzI5ESLqoo7Sk9
 MwHg==
X-Gm-Message-State: AOJu0YxfI0rUiucLIRa9gaZFTfXle5RNoVq/We+L19ki3UWs0O1fYCAL
 /b04gEStLFn//KhBx1xSsolylAWBjuX7zmJU6ONpoHM63q6s5yMOc7klgyH2w/Ekfas=
X-Gm-Gg: ASbGncv/wG9Guj3h/Dz8So2qAAKx3v/uAM+GqMD6l0Ebv0Wm+03xHMUtotCih9+Eogy
 hnGMRa6UBFuni1Oz61W3ymb4UV2gSxKXr7MENmKJ1h24fx5Cv2Os//vC9cFjHm2SQ1sZ8ghRgR9
 wIVeDEyr0VpuuHQuLwJJo+iiLLJitKelrdmE8/x3so2Vi95kUzWCaxC5rKbqhUZa3df5g7KClzm
 B6HumJF0lJAWMffh273kfzOrqL7AEo1nXJ8SaOFckbo9dok182vuSAXOX/x5sTbnSaeN8caDOuF
 OkNVpy0zB1zlLZ4UP5lR5L4w886fDW+/0J41xUKdRNtqsNCh+jFoZX0UtvNC1IC4iNe74vLRo9g
 N9Ds+afsBJIjoGKaxKNUnjptrpQN7GAr9EOEi1E3anm2rUEPxwOSIV0Fu
X-Google-Smtp-Source: AGHT+IHzEufQI+kuIGAbLBkL9Mu8Ee+y5dk/yyY03/CrHhLWXuKCQGq8v5AmZgTRTN8wabwgyYY2Ng==
X-Received: by 2002:a05:6830:719c:b0:741:213e:2212 with SMTP id
 46e09a7af769-7437546e9b8mr2297145a34.17.1755105178883; 
 Wed, 13 Aug 2025 10:12:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61b7cac2c52sm1711818eaf.26.2025.08.13.10.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 10:12:57 -0700 (PDT)
Date: Wed, 13 Aug 2025 11:12:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Eric Anderson <ejona86@gmail.com>, linux-sunxi@lists.linux.dev
Subject: Re: [GIT PULL] u-boot-sunxi/master for v2025.10
Message-ID: <20250813171255.GC124814@bill-the-cat>
References: <20250812105605.1344927-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NUjOA6iejJWKj6lI"
Content-Disposition: inline
In-Reply-To: <20250812105605.1344927-1-andre.przywara@arm.com>
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


--NUjOA6iejJWKj6lI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 11:56:05AM +0100, Andre Przywara wrote:

> Hi Tom,
>=20
> please pull these sunxi changes into v2025.10. It's mostly smaller fixes,
> and some additions that were dependent on recent DT updates:
> We switch the S3/V3/V3s over to OF_UPSTREAM, the DTs were already
> identical anyway. While at it, Paul sent more fixes for this SoC, I am
> pulling in two easy fixes that were ready and low risk. Apart from other
> assorted fixes, this PR also enables Ethernet on the new A527/T527 boards,
> made possible by the DT update from the DT rebasing repository.
>=20
> This passed the CI, and was boot tested on boards with Allwinner A10, A20,
> A33, V40, A80, A83T, T113s3, F1C100s, H3, A64, H6, H616, A133 and T527 So=
Cs.
>=20
> Thanks,
> Andre
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The following changes since commit acfacf452441d0a659e3afbd55fd6061aa17e6=
47:
>=20
>   Prepare v2025.10-rc2 (2025-08-11 13:47:46 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master
>=20
> for you to fetch changes up to 553c5a69a5f1e36c8c6cd654e48601322979b8fb:
>=20
>   sunxi: H616: dram: fix LPDDR3 mode register settings (2025-08-12 00:50:=
57 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--NUjOA6iejJWKj6lI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJzHlAAKCRAr4qD1Cr/k
CjujAQCmln0aOco+YcLgqrg5R23zQuxq2lfYgtPBqU/JEo41vQD+NT4t8y46gwpw
LOlFM6bcMwfDtA0MaiupVMNjAjOuEw8=
=6emM
-----END PGP SIGNATURE-----

--NUjOA6iejJWKj6lI--
