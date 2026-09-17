Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51CBC982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 19:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51B8B80DE1;
	Thu, 17 Sep 2026 19:52:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPKOsTKdIgcy; Thu, 17 Sep 2026 19:52:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8DADA80D8A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789674752;
	b=N91DRZUNWZSvRrs6KeNlk/wTnkfTzmsWhMUM/VivlFi/x/BkFS/4E1Yl5iGmmWUs9RRL
	 CQ/fQqQV3C0q0SghF4Ch+WqzCqrmyc/4wP5QjEoPG8Tb5nJZxF+VFwHQfWUaZ5uh5Sc/y
	 JJDPRwql08sgbzg43l4E1iluI/wmnwrSmpWNHPHlqCLuKBsY03RaOuWpfHHLAyu+bsX27
	 +FHp3/0ZfWEXeTz82yJxzNNQRStEN/vRBg7N1lGbrWnRwVTtQXBIWQe37B2umY2zaeULo
	 jmbfsLFWim3ETvpcsDpumFDTNBm3tjnP6IxoPNPppMsI3HfRqadcpKKhO9SOVS9oATw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789674752;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BspFAR+3uwoyRRhe0FcPFMbh+C40XW6lQa1zRuoRPUM=;
	b=nxaT3OoaLgqBSB4C9Y/KnjG08+vGRLc8yEh+qxV7AwXIZScyWzP6zwJP043457JoYEnS
	 6wYNl/2uIE9XE9H0d68G4+e6p861+YUk9OMdO+OX6+E1K1CDV6QTdlbx0BxtN31pG3M4z
	 ClVPA4ShOH4DRUF90eM+aLjRf3tp+VUGa9khnp0AQL1Whnl41M04nesTpIf4AgZW21Ha7
	 JNqsI6KIiAFDr0dR5T2oHFld2lzr+OamUHx7xpSb9RGOPi4MDly4MdZt8tJAQfq1hH/Y/
	 6zw97kE9tTH2OAiWb3vf5yExuThPm0E4X5L6UurSnJbOy08YUAswAraJQkU2DZ/3YNw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789674752;
	bh=BspFAR+3uwoyRRhe0FcPFMbh+C40XW6lQa1zRuoRPUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FW9etimhMglh6AgseiLmZjBxSvFGazLB54VuB34rpHOaVI60a9urn2dtrFvJX+4QY
	 FY2GMiH/4P6cvrWXA7G+AJTo2jHtJ7p2GjtsNjIxv69YTbAXjl5VFpdWzILDKylE3l
	 BJ1hHey6ojWYo7IKOqRbuj3ONqBjUFz/Mo7Ji6c14h+dCrk7KiC/M4Bs034qUqoDwd
	 GzQUdJqTMbDDJBQIOJU2RUcOfQPacBUoaXF8ZdvtNLOaHkPYNmhkn75oqWRDr0Y7up
	 X3T/ywohKbGR/RVt3YzHwwUPlZwXzkNwPv2UMywy4ueJ1yFqz0oQPS3Zx9uGXcytn1
	 4rgKcEf9bM4yQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DADA80D8A;
	Thu, 17 Sep 2026 19:52:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 96748352
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 888D340454
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:52:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kVUiQVt5TpBR for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 19:52:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B6FCA40452
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789674751;
 b=jcjsChlHAc5/fz2LYsatwIEZF4F5lSKhFNDyzo+ZYDKnXvjQru2K7Vbe9SkJo8WWVuKB
 Yc345M4XOMYbNmzbiNdUPTcyleCp0Gi+svP9Ez3hF8qZbQELnuGKASNgL/xpbPHV4xZsI
 TjWK0dhTN8HH/qG5vpGOS122Bu1sC4w21Cz480K4kir26KrKES+vlOo0DBdXqhHhuyvuu
 Ng4wLp8bytGhmAMEaXVUYUpV3ZSOC9pM1XayC3VkdQdgAUKRpKnegPYtkeieIwMz9HMXj
 aY8HLrFY5spwq60TYszNQ9+4ugOxtJdCiwb3uqg8NMahySIv16+u1FGEzoIJa3906Tg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789674751;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=BspFAR+3uwoyRRhe0FcPFMbh+C40XW6lQa1zRuoRPUM=;
 b=hkk6NK80g6GwmjsE8PwY6UXw++Na/BbVLTEtFWqdJfJcBUc3GRGZ0FBlgZD4RDeM8RKu
 /+CYOVocEpUN0wyzStJ7r5bYKsrGEd/whF2oLT+K8Uavswr2ogUWDHs8gU4h9wMp0iAej
 3+Cha7DxL47HORLxi/GI4X30acF0sRUhEY7HcRpMLOOGeM0RcKlIM0aLplVOsSByZPmne
 0seoeLoo871Qo6mUZ9yNA4JKlS+R9Px058kr+0ywDIdf94coidS6yTt+3yc6LAFEAANDV
 sqgeCVsjH+UfZHOR5hLS552NobpB3qZWcyCzDD2Cnmi7ppgwWruFWI3IDvdt+UslSBg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RlxvlFvX; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=RlxvlFvX
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B6FCA40452
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:52:30 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c6d6660191so36880b6e.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789674749; x=1790279549;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BspFAR+3uwoyRRhe0FcPFMbh+C40XW6lQa1zRuoRPUM=;
 b=RlxvlFvXnW8sCfBiwIAYmJzR1WL8N5Ecc2DNQWnkn7DPBaSOumcUaQ/H8KpZh0HpZe
 IaUNsckvLDWnwwi9ZNwfDGgRcwQTCzL9lmVAk2UWEcF70SecT6xc2a5xSz/RdCBNoEhb
 1Uix0cXOIc58Sqsh6lyWMjmziFE32dbu8rqlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789674749; x=1790279549;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BspFAR+3uwoyRRhe0FcPFMbh+C40XW6lQa1zRuoRPUM=;
 b=lZZHrL8Sk9PJHCMvbUxHtVHGoj9oK3/WxLC+d8ErKxwiDcwLL2GV87n2dkNnmcFlBC
 /R71J3auHiK1jDHO5/sYAt0LVKHIIjeHbyu9Jpnd3IZ3/dBysXyxs74QqSVabTxsLvF0
 C9GpoRT9izJrm7/9U4l9cEzGSriNyZvxUbGS5v6uDF5FK5lWf4QWW0Lt/kA0Uaig5qb/
 4TRZk0FoEa6GC4BJtl4iq9r29M8nsCTyFttSSm4Up/C8CsfzconMT240wQAbFiR4SWys
 UZY+L08CQvjXPxVxx8yIEcnnVS6c4P4xFYJK0jXploxIWXz4D6z2eZvThWjFC61PtLoA
 t2cQ==
X-Gm-Message-State: AFuF++mXZ0i66fjZY7tDZ79KPrmMfmqRIPnbhvVniphDluK2Q/9AQ2q0
 5x3P6CrKiHs++iGnHVZZ4OIpSFszrkE7RA5wB7Xaz99GM9KpY0bKQfYBD0dBCa658VY=
X-Gm-Gg: AYBFou1X0b4hcTFKz/lkFHwj2oO3Gn2L/ALNl1AspzC2hkaqSYfdTFoRwb95MhoC4wb
 7btK36hl+y1egQhhlQkDtoyccY4lM2ZUKr0CimxBdZhjpYrsigtzc/mJWKI6+ATokYtREq/BvrX
 FZP/crxAZo/bQ7hwCBoE8pN5bKnsziDgyWGjc0RImkVYgkovJcobtLMw+w8AO34wUI0CINgmZ86
 AbvLkIovI4cZZtMXN/FKD24AkmaV+2bu9Obh4Cse4wEMjH1A6aW4FcD+SR0XJ9kzyDhTfG3cYhH
 ItQkj7z/kXzqrB2EpfehLBrnb8T9HAjkJr8UrKV2/9dbBXhEHeSJ15Suhu0RF9yq2L9rHiTGoA4
 x+jTaV4qQpW7N173PBFXirgOF5k6+8805LRuIjbjU6+sV4cDNkepU7dT6Yun3u5P2C8bsYUS4ru
 U3bpSHBUK4fs2mOVlAufpKP8H7jDVzDB6melGbXo4tgniw4xHwIdhENk9YRNM1+7rkAwVhlzn4E
 Nvf4pNqz5mQlemoaVNgjDY5oEIGeaFzMFZdgB66b+rWiQzp5St08clPnb+KEHckEXu9op6XJISE
 DNu1xXAJS9rBofoG3RMr
X-Received: by 2002:a05:6808:13d6:b0:4b9:a829:f01c with SMTP id
 5614622812f47-4ccf7debfcbmr333076b6e.40.1789674749314; 
 Thu, 17 Sep 2026 12:52:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4cb6a3d7a4fsm3642297b6e.2.2026.09.17.12.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 12:52:28 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:52:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 02/11] lib: Build xxhash in the SPL phase
Message-ID: <20260917195225.GK858934@bill-the-cat>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
 <20260917-spl-fit-compression-v1-2-7985ac56ee9e@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aaHjFMnFF9CAns0i"
Content-Disposition: inline
In-Reply-To: <20260917-spl-fit-compression-v1-2-7985ac56ee9e@flipper.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--aaHjFMnFF9CAns0i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 06:02:23PM +0400, Alexey Charkov wrote:

> SPL_ZSTD selects XXHASH, but xxhash.o is built from inside the
> ifndef CONFIG_XPL_BUILD block, so it never reaches an SPL link. zstd's
> decompressor calls xxh64_* from code that survives --gc-sections, so
> today the option only builds because nothing in SPL calls
> zstd_decompress() and the whole library is discarded. The first caller
> would fail to link.
>=20
> Give xxhash its own phase symbol and build rule, the way the other
> compression libraries already have, and note in the SPL_ZSTD help how
> much heap the decompressor wants, since that is the other thing which
> may stop it from working.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  lib/Kconfig  | 12 +++++++++++-
>  lib/Makefile |  3 ++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 6b6b90bc915c..6e6df5b3b191 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -833,6 +833,9 @@ config CRC32C
>  config XXHASH
>  	bool
> =20
> +config SPL_XXHASH
> +	bool
> +
>  endmenu
> =20
>  menu "Compression Support"
> @@ -1011,10 +1014,17 @@ config TPL_ZLIB
>  config SPL_ZSTD
>  	bool "Enable Zstandard decompression support in SPL"
>  	depends on SPL
> -	select XXHASH
> +	select SPL_XXHASH
>  	help
>  	  This enables Zstandard decompression library in the SPL.
> =20
> +	  Decompression allocates a 94KB context, and nothing else: the
> +	  single-shot API it uses decompresses straight into the caller's
> +	  buffer and takes its window from there, so the compression level
> +	  does not change what the SPL heap has to hold.

This is good to explain here.

> With
> +	  SPL_SYS_MALLOC_SIMPLE that memory is never returned, as free() does
> +	  nothing there.

This is already noted in the help text for SPL_SYS_MALLOC_SIMPLE so we
shouldn't repeat ourselves.

--=20
Tom

--aaHjFMnFF9CAns0i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqxE+QAKCRAr4qD1Cr/k
CnpZAP91435mlxCRHMLiCoSJ7HA0SASHVjkg2knq6c04HA5w6wEAtnO5ZBRx3y63
Be7wFEv0PE/72WJa3xroCG3MRiwu8wE=
=dxt1
-----END PGP SIGNATURE-----

--aaHjFMnFF9CAns0i--
