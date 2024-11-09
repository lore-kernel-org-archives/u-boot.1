Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FBED5E379
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 17:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0477890DF;
	Sat,  9 Nov 2024 18:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lDXpojEU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50BB2890FC; Sat,  9 Nov 2024 18:26:02 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F9708909F
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 18:26:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9eb3794a04so482778166b.3
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 09:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731173159; x=1731777959; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gxBfctbwaMC8ocDpgmOVOD+PskaPMfzs44oTpTHyfyg=;
 b=lDXpojEUO4tgXYhQ9vWpjXcT+6Sg5oA948p9nZvTWTnARIFKMv0A2+ndfgYZbKwOnS
 wAKLJITphUk50lxlvS0vw39p2iGdabZGTPzZQMP1Ylr0a5WEGeUaiZ94wV9ZB6R0josn
 BNpDo3jUVNNi/B6oqeTyNbk7JOVO8TKMi4XYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731173159; x=1731777959;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxBfctbwaMC8ocDpgmOVOD+PskaPMfzs44oTpTHyfyg=;
 b=uphXywaWYe3kUEu9oBkIcS5rgVj3jRmMg/KL18GpCSmuvTtQ+z0mX5PwTD3TS6nk9k
 LzXEQFj5z5a0Ky1msfYcJQs6CrBCfCmv2pLNHCvqhDTIcMz/ZwQmBkzte9XygBmBZO+5
 OOcgY8JB7vrtTEA0/+K/vXGt2ark0oECWlCVZVHtHN3Hh89gQh71AzsG2V7GT8LbxMwh
 fQwQNn4DAQqpbkmo7rl5FO7Ao0fHrC9A6h1pPx5LUL2X8gr9lw5+VTrGGZc3t43WjpPD
 h2WDyTF+Rj/n+twvR1/xqlz+jXfgKHbiQazOYm5lih3pGnPt3T073Q5cV0HLAlNEyXrq
 jtiA==
X-Gm-Message-State: AOJu0Yz7AJMLPt+9enxYcqDsKnYZGfiZJjb9O+xJhw2wo+ATz5cXOkaz
 48gl+Fv3Q5fvXYTX9bhML8CjCQ7tr0wDP13aOyedw8h4g6Dv3mkNx6mJ8zT1vi4=
X-Google-Smtp-Source: AGHT+IFIkAHGGNUe2/FvfChftKLs7u6s/pwSaH5Z2z64xd02ap9tNadkg9hW0k/IimvslkBxSEoesA==
X-Received: by 2002:a17:907:72c3:b0:a9a:6b4c:9d2c with SMTP id
 a640c23a62f3a-a9ef00239f4mr644776866b.59.1731173159259; 
 Sat, 09 Nov 2024 09:25:59 -0800 (PST)
Received: from oliver.lan ([23.155.80.164]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0def4f3sm380604466b.161.2024.11.09.09.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 09:25:58 -0800 (PST)
Date: Sat, 9 Nov 2024 11:25:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Moritz Fischer <moritzf@google.com>,
 mason1920@use.startmail.com
Subject: Re: Pull request efi-2025-01-rc2-2
Message-ID: <20241109172554.GA70092@oliver.lan>
References: <efa929c9-b8a8-4264-8bd2-8e98bd61c5c6@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2w7EZZ4tv/v0YtC7"
Content-Disposition: inline
In-Reply-To: <efa929c9-b8a8-4264-8bd2-8e98bd61c5c6@gmx.de>
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


--2w7EZZ4tv/v0YtC7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2024 at 11:09:54AM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit a7a96a37cbd875994bc8d25adb0536bf00e4a3=
0e:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-riscv
> (2024-11-06 10:44:33 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git efi-2025-01-rc2=
-2
>=20
> for you to fetch changes up to 70b78d52937b5f18afbbc4257bd3b89b0e75a186:
>=20
>   test: efi: boot: Add a test for the efi bootmeth (2024-11-09 10:01:47
> +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23260
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--2w7EZZ4tv/v0YtC7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcvmx8ACgkQFHw5/5Y0
tywpwwv/e90Omy4fm1xrQpW2Ki3t8XJZHKr5I5gOZgZf2IrX380jKZwdhTItAoq6
LQ7/+9yApk6TWKcZ65o6jE6CEYIAOQ64398fglvbOuDL9SzQtrqcy/8pfA8WznD1
xuYNxLAqBLMdujOOMmyoPBoH/u1RoJW8RW9FTrxTvDPTDwh9AE34bHCNTvCy2pBU
pxUjiSeub4YjweiKAGE3CZoiERantjX8YqefFoqNHh++GNiRwCwyJV8yJzauoDMF
vJ+k4Unqjf/7eU0iirWAHLTynMVHqpMopHT5jL8nVzA8sL85CCOqzpMA1UTjNp0G
+ohb53rkuUZhdt86F0SodrBMoY3oFOdZgXHV4v26XoOOYyPjehbJhv1NyDmC6e0A
3d2jqjV+mABhoRUua0D88S+F33WMj69z/7eOAqPj/fKcS95VfK3kjRZ+EDozBRY5
QIhs+5crZaaCs71Obry6GTyfo0c95ij6bPsjzTpcVwvfvDABUj6DntnKJSyt6O0L
mBI69THT
=KQLC
-----END PGP SIGNATURE-----

--2w7EZZ4tv/v0YtC7--
