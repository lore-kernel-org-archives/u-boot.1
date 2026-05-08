Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C18CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 18:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2FB884DC3;
	Fri,  8 May 2026 20:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FCm5+cSE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A8584DD6; Fri,  8 May 2026 20:57:55 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D553D84D1B
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 20:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-434e69e943bso1815491fac.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778266671; x=1778871471; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N6hq6jRph7nH/lCl4n9NaRxHNUrepy7nifySleLLGdU=;
 b=FCm5+cSEyfv7gU11PzR/DVD9nfGR+PSczTNYg8KfAYF5XPe2o2ojRBDE/B+8RGOd3S
 bAKEVkMS5ngjeHcFtVPixyZwpAtTDNCyeJJDl68R0J7fXFt5ph2PMiPa8A0e+bfIqiZx
 4nADwXG9Q57zWIlVI1gzXUsIY/4QGhJcWv6G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778266671; x=1778871471;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6hq6jRph7nH/lCl4n9NaRxHNUrepy7nifySleLLGdU=;
 b=LaslkV4F4yWA8bDXXTY8iWa5Wwvpw1xxKTapk43+jbML58azkUWI7fHXkNRKoqZ5EN
 U001bxZhLS0YYGNUd6C2Vmegtf4XsD8wiNONncooSMFtla27hbe2cNOAMTBr3aqbs3Qs
 i11PCvvrIKU2BeY6MmsypSy7ADDxA50oZxPv80FQs5V/eOSt76zVumcT9Te/AJ1EFZqE
 nbuRCNJCDfCDwG515Ojf9ABdE3fU7w+7znQdj1/WGnR6PfLGgaQ17Ftqdd178loDUccl
 MQ2tw7SdPFaUUK6SpcqbikzYlwF1CqT/k2ELzbKCnI7OnPpzpzfyvQpynZrmhaJmpd/n
 JOMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ81B05+P3FYTjasc7j3EQIFm6hh7jSTc7hCjayAAhVs37HpE72Qa/RMSnUZxOun3K+TL/vxGBs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy644xZo0DTRh8VIHn5boL90v8VfHlTkG5iknbrGfqcVfFzfmyZ
 +1WnyNv6kg8SU5Fekv5RFQu4VMT6B6U2rkBzwT+N1N72XgY6dVZ0fFVTfDDVQHxF+ZQ=
X-Gm-Gg: AeBDievQKSOkhEpmp1S58BCI7d51z6u7Bbr6sfD8/x6b3tqY+CzfOjIhGC2qc2l0cBn
 /UdlLiKvajICrE03Kk2DC3Lo+e6DrS/7WhMP90lLbH9gztH+zwUzQrmhCp2jLz/fIk4GsxgvFqF
 6alNAqZIHQ4X3nhOLhvzMVJmCAX7IU/TC4Jw8KSW3McqhEtbEDaOJHBSlB/pKjvoTuIfHU3bWLU
 s2NLJjwX5Q14LcdBsES8aLwy4TkEQCXomRbloYrZoN7Ni5ZuFJbHfBbg/oWK3MCvUnDC53GJkQD
 AyTL31kDOo5smGKshjyxjVzkSDgNDAXY5qZy5hAgAYYhdZywnPhc6r1WMKVhSONRs9ekXlSk+a/
 e3Cnx+XlEH+ohTKbw47kStKd33RV0kuixQ8lm/b/kk3MjQcW6vU27kHRCVimQje8pMLX0aLTYv3
 WbLMcn5XeEkt+tYXk1PaakvwcgvvVEn5UNzuqq9sgbiEni7ND+gimA6Hj9t7hxOnz2e/hvXbU1N
 7lqrrRZ5ECLFIn9aVBv0GyIfyKQwp1F4osxn0HzCPFlyPZ6JcdyRX+Yw80Fng==
X-Received: by 2002:a4a:ec45:0:b0:696:924c:43cc with SMTP id
 006d021491bc7-69998d35da6mr7597852eaf.47.1778266671069; 
 Fri, 08 May 2026 11:57:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435570ad8f4sm2427396fac.4.2026.05.08.11.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 11:57:50 -0700 (PDT)
Date: Fri, 8 May 2026 12:57:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/7] fit: dm-verity support
Message-ID: <20260508185747.GC1858239@bill-the-cat>
References: <cover.1778171184.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1UhQtqOHGY9IAtG0"
Content-Disposition: inline
In-Reply-To: <cover.1778171184.git.daniel@makrotopia.org>
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


--1UhQtqOHGY9IAtG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 05:40:15PM +0100, Daniel Golle wrote:

> This series adds dm-verity support to U-Boot's FIT image infrastructure.
> It is the first logical subset of the larger OpenWrt boot method series
> posted as an RFC in February 2026 [1], extracted here for independent
> review and merging.
>=20
> OpenWrt's firmware model embeds a read-only squashfs or erofs root
> filesystem directly inside a uImage.FIT container as a FILESYSTEM-type
> loadable FIT image. At boot the kernel maps this sub-image directly from
> the underlying block device via the fitblk driver (/dev/fit0, /dev/fit1,
> ...), the goal is that the bootloader never even copies it to RAM.
>=20
> dm-verity enables the kernel to verify the integrity of those mapped
> filesystems at read time, with a Merkle hash tree stored contiguously in
> the same sub-image just after the data. Two kernel command-line
> parameters are required:
>=20
>   dm-mod.create=3D   -- the device-mapper target table for the verity dev=
ice
>   dm-mod.waitfor=3D  -- a comma-separated list of block devices to wait f=
or
>                       before dm-init sets up the targets (needed when fit=
blk
>                       probes late, e.g. because it depends on NVMEM
>                       calibration data)
>=20
> The FIT dm-verity node schema was upstreamed into the flat-image-tree
> specification [2], which this implementation tries to follow exactly.
>=20
> The runtime feature is guarded behind CONFIG_FIT_VERITY. If not
> enabled the resulting binary size remains unchanged. If enabled the
> binary size increases by about 3kB.

So one thing is that sandbox needs to enable this, so that CI can run
the tests (and we can see the tests run, and there's no new warnings,
etc). That can be a follow-up and not a full respin, pending other
feedback.

--=20
Tom

--1UhQtqOHGY9IAtG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaf4yJwAKCRAr4qD1Cr/k
ChDlAP9pHmo21Rjo7kz5pfeS3apRrYWZYu5vdgmCNtyOYfccoAD9Eg58cT7f2223
1TrJgEg+Gqmfee0marzmM1QvvfvSyAc=
=gubg
-----END PGP SIGNATURE-----

--1UhQtqOHGY9IAtG0--
