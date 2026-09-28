Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E476CA5FA3
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 19:47:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A354E80B12;
	Mon, 28 Sep 2026 19:47:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id POEUcH10FE6B; Mon, 28 Sep 2026 19:47:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D5CC7809F8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790624822;
	b=rN9jBUPBSU93tExY2vUTOiUtLDRNm53KsLjOgcd+AmjeqKDS3UZAzt7F2aRNXsZzGKDT
	 PTjgikV2yTRXaTHLWUCxP50KzyR2RXqkjS66KfXVjEt8P6gpvkoFTPpyw23KmyFXoSlpy
	 8s8mkhpsngF69Gbbw0badsDcRmrAZrh3hsJRv/aU4IkW4lowpDQ0vPsOP7mX9pf0tHGtR
	 YXiE7ICP1UJUovni5yn2O2AlrDZvvsFQwP+yVoABl8n2MoI/utKLpJ0IwnKqNgy1AWfDB
	 eCnA86triy9VEtK5yFxPWkpEXIWobiG+4swgTzd0p6igf5DmkE8FtQWivAVhU1nRd5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790624822;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fvhvaEGNKTpTiCqq4ad73u0awfTeROdoHWrAgPUrXsE=;
	b=LW+GYPIlN44gjaPp3LIx1K6/kcVjoQHlnGqu1VNwEZW/tqHJPTi8etZwENb9MYq9bBOB
	 L0qiN32ob0JgReGjleL0v93jtxLnqP/IZsPp8trCaOH6vhE0XMcPf0d+/DXPmtPj4nfNS
	 g9Tubc8IlR3LtX6TRstKQvTGPXI/DHKBMu9GoREwonPLC+Oav1ZQDqPcovAOg5hVuMgbc
	 Cn9K3XUELA+ulVVaCD/CpZdDqFYihoWqtZVuOqHi7H/XuacKo6sAXG5OLzR90L2FIGxIg
	 bCccQX56gDmpb1Vu8npEL9UX8g9v3NCYujlp4coQKSZQIW002Kk6UC/fSitoX4Kp2Kw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=D9oK+xoD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790624822;
	bh=fvhvaEGNKTpTiCqq4ad73u0awfTeROdoHWrAgPUrXsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sgSO6VzOZJIbDam5GmTqa3hMoYEbxvvo1DHgLayWGC5Kgg+feJcKcrZwCS3auYsk6
	 AbPxRKhcGNpf+nh4MXppezCNxOKIsXz1KYpvfh3lPCeBc4fpJvEHoSiq2uI+ahlbb4
	 dfhg7BAxGCY8xFXzGtL3B/HFs0ZdbQh8XDjdh8FrFGdb0GUPgrxzzkNnJ1WAL55wyW
	 ofNjnLCdVxISYKGGQTcmx+5NW7TjIiE7+PG/Bz+3IboCWuyl6e7QH0ELWX/5tDE/aG
	 tWIB/6NpjcUP+V5jglmqyu3S/nMD5NLwe8AvceWZ9IZ4gpCzJ6ZFUPB+4uRjJ6GDb5
	 VgJhgraXBXdCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5CC7809F8;
	Mon, 28 Sep 2026 19:47:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A556147
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 19:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BD78809F8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 19:47:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9iEiMftOIjr0 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 19:46:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 57348809F5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790624819;
 b=gKyHywj3ff6T0wW7eBBoIGcaOgzwpvlJBPGdiph1WVRg5LlN5ne4bixkeNwge67swczZ
 C8vVlRteb1pnQfFmeG6ZFihktXfO9zI2LlcF8j3aly7DYoJyCQiCtKsFoAa8FiW2eM+2d
 tO5XkpMRdlfajqwmmZHXWNGFKlzQhELs92l71D64rwejsm44Pq1CVoTEEuRtWJD1VLu0a
 WrymP9wYuLugQXwYj0yaGOj6YSe1ujQ9t3HcaIRgDu9iiyqnhph1KAIfImq6NqyNqwVFc
 2GI67MPnZ8FhuuLkt9HYhoWU9M4za0rtrTYdcJOiE1ghJGvttdUC+7SMbbOGePVuENQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790624819;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=fvhvaEGNKTpTiCqq4ad73u0awfTeROdoHWrAgPUrXsE=;
 b=L7llGPYanHUur/SxSsBqW0xyLq3xSuhWvwtHajzFcNOfc+xhnOwxCby9qVlFqdpJtbDD
 ipR5xfM9Q5k5ND/M9FpvepxnQC24bwDZ3L2eo7ZfFuvb69RFE+T5Q1992uM6uHrpfg1FO
 8m7fzb1a5b9bXpuTNL7ECO+uCqnZyxrWmxfItYdO0ykbSaZUXpmsI/YO4qLUPrZda4X23
 a0yqMQwjhBYtY6GrxebqEfkhvzQgzS+lcf78Y0NdCndme1AZ0QM3FyZ+XQJSJL8fD6GDk
 404c2Ll5UXqDdu+ZepwcxbDE5dhNggmmCFMjA53HtMMfmLo5UkHuHeDVK3SK90Fqktw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=D9oK+xoD; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::e;
 helo=mail-oo2-x0e.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=D9oK+xoD
Received: from mail-oo2-x0e.google.com (mail-oo2-x0e.google.com
 [IPv6:2607:f8b0:4864:31::e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 57348809F5
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 19:46:58 +0000 (UTC)
Received: by mail-oo2-x0e.google.com with SMTP id
 006d021491bc7-6d797cfdd1fso609280eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790624817; x=1791229617;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fvhvaEGNKTpTiCqq4ad73u0awfTeROdoHWrAgPUrXsE=;
 b=D9oK+xoDoE8IO80B4bQ0wm09Bvf3OVkQLbNUxCCK0Wqm6E98Sz3ydzLytN5NcGX3ZH
 q0GMbDbSZ2cD4yfdS/GyrgFexTcjfMGwAdwBkSZ/HvtY8VobONTTVUSX2QH5f62gPYab
 K7OE6TuQd6wAemEua4jMc4sMu7caRz2gyjnEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790624817; x=1791229617;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fvhvaEGNKTpTiCqq4ad73u0awfTeROdoHWrAgPUrXsE=;
 b=VYmEfmuupnr7bgzd3AwUrWc8ydEQvA1+1cYbm6+oTrneTBoMQZHeXuUKvXc1yeC1/E
 W61G046t//xFaXpq5Q3WiPKAVqJmsqZwp9N8ZWPPKAMBNR+aY7mb+yV0xtbqJ2/j7gdO
 yYZo1BIHABarouXO3OFIOUBju+NHTRawZNdpaU7VMqNsusRTPoLoklQ2KzmelxZEpc6J
 gO8bf2eJkvMTaMc/528AclA1183EiSbXpQqxkNdVkm02/0mlDrlLoNdRWL6uGrmMOuyn
 88Fi+eHBuxkvyaIRtePFDShfuEbJHY+/uA2CkqVxaEHgbQ3erEgKNStl4sk2lJ6pS23s
 Nh3A==
X-Gm-Message-State: AFuF++klKYXS/TKzZDqI1JishyjFmXZuz1eEG8XmmXmJvXMSMzhwwyte
 WWGVHCiMn/95QejftrFlrpzWYg87VmFfRq87jMy1t8FmOahNAw8GszyJgPm4OWMcBOk=
X-Gm-Gg: AYBFou0aU6HKDWy0vIHMD3Qqg64mPDHprjclqVZ0UXAQie2W0N+MvkhGiHUayk1rQRE
 ZmPN5a4Y9q4Pz12Jqes9v3aUetJLRJyA3PcEKlsLm5NZ+bG7sPPHQVdB5hJB7f3srxPIu0cPFv6
 9ewDWJIQE5amDs8e/577RW9X8y9+6aHwBciSwgBYastXlII9XWajGJTvzIWhNIph6oelUB+FFdl
 IhdyYOB4eSAwZvNvXlu2dsBRUBoT/l5Mw4DsGremtCoDdAbChMkeOlLfDZ5SCmixWZ2SqABT5F1
 zDSKWJnVSmO5sG8B6if3iMdMXraYJboTwqTW16bqvny99K+YjRP0aTFg6d8LI1O2bNYurA4hzQ+
 WrwcdVN56CsWtEUf4+GNQ+lP9C7jEzDh3eYqjmHMf6TXBXco1gW9UQnVvbwGGi4Bxw1ITla9Ntt
 awcWAIKs4YHr13keMNf3upB5kdCoLd4oeODr/lE/VUnAcpEpWEXpXmdhQ+2uQpOy3FX2UGFs/CK
 uHvfp0ILbbN7oc95kZVvOwW0/6D4jmH9JWHYglhlgPmtFlKGjJ+3UJIT4MJKP31p9UrbZkV1P++
 7tvkAMqYDddqlTpDmo8=
X-Received: by 2002:a05:6820:160e:b0:6d8:ac5f:88af with SMTP id
 006d021491bc7-6d8ac5f892fmr4000463eaf.33.1790624816966; 
 Mon, 28 Sep 2026 12:46:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-493356565b6sm11092120fac.9.2026.09.28.12.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 12:46:56 -0700 (PDT)
Date: Mon, 28 Sep 2026 13:46:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH next 01/13] Makefile: Skip undefined symbols in
 keep-syms-lto.c
Message-ID: <20260928194653.GP858934@bill-the-cat>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
 <20260928110434.70686-2-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0gt0URn8COHXMVBL"
Content-Disposition: inline
In-Reply-To: <20260928110434.70686-2-pepe.schlehofer@gmail.com>
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


--0gt0URn8COHXMVBL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 01:04:22PM +0200, Josef Schlehofer wrote:

> The generated keep-syms-lto.c gets an __ADDRESSABLE() entry for every
> linker list symbol that nm prints, including symbols the input objects
> only reference and nothing defines. keep-syms-lto.c is compiled with
> the LTO flags filtered out, so such an entry turns into a hard
> reference that the link cannot resolve unless .discard.addressable is
> dropped.
>=20
> The turris_1x SD card SPL, for example, links
> board/CZ.NIC/turris_atsha_otp.o, which references the ATSHA204 driver,
> while the driver itself is not part of the SPL. With LTO, which mpc85xx
> allows later in this series, and without the /DISCARD/ rule that
> "powerpc: mpc85xx: Discard LTO keep-syms sections" adds, its link
> fails:
>=20
>   keep-syms-lto.c:5:(.discard.addressable+0xc):
>     undefined reference to `_u_boot_list_2_driver_2_atsha204'
>=20
> Pass --defined-only to nm, so that only symbols defined by the scanned
> objects reach the generator.
>=20
> Fixes: c1094987d1dc ("build: support building with Link Time Optimization=
s")
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Marek Beh=FAn <kabel@kernel.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--0gt0URn8COHXMVBL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarrELQAKCRAr4qD1Cr/k
Cg2OAQCbuX3vjFj73Pl6ZcXz7bCmd9rOa0QWPRXid1Xr9PRgLgD7B/SUgo16DKt/
fhwF6/sA9Wi5CiDcMtMi5xYztHU3vQw=
=kLwb
-----END PGP SIGNATURE-----

--0gt0URn8COHXMVBL--
