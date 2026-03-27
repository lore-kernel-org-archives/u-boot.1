Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A26910F2863
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 17:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B64BB83F14;
	Fri, 27 Mar 2026 18:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sSihoxaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62BE383FAF; Fri, 27 Mar 2026 18:52:29 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E24183E7A
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 18:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d7447778b9so1213365a34.2
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 10:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774633946; x=1775238746; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TMW1q/AM//MwFiPOdU8SBQqHP6Q/+zUdgmeyPaaEEtk=;
 b=sSihoxaV810RUf0XrV4MKfbKpN/lb6YJY4rBomka5swkvVVcNmdrxgyO/UqOPQkYN8
 nPjuuKFVoWfDJIy3QRMum3l3NHZIikG+U4UlkUYT3CEyLw2ED/fLNpI9rlk7FnxEhMJP
 smH0zqR0gh5mcvaPKi7rAvwZSiC6pSTuC2S4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774633946; x=1775238746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMW1q/AM//MwFiPOdU8SBQqHP6Q/+zUdgmeyPaaEEtk=;
 b=V2rzNAuhcPfrP5XTWYnxdbyLy3vzx8bzKl+bGi/Z+nOnxu9hPraNr/HKAAzxmrQTS4
 S6Q0BoJjMY6XrWfyyeRCAjFYmWQalxXYqcwxFLdB4d0qTOK4/SnzUwFw/v3/F7Wb+vCl
 iQjF6wE7Ha4ppQnE1yPpi6cjPOyE7PtUVW4iaix4vwPF69ipaqH3IqeYlwqQkzmfUZOi
 lJ6UPcapiLp2GQ/dR2f4NRGSjzxduzo+QsH0cEulEnJR3qIutbll+s5sAwb3cvVnnGtl
 jl4a9UZ0H6CUQxC/By0456AwWfEnxXbo+NB9VgqQYvIBEBm5HZAP3QRyuzak03Pkm+iU
 JDyg==
X-Gm-Message-State: AOJu0YwGQi8jb6y8x+vdcTVcHj5cT2mzPZsfQ0gvnKhiISIjCGbGOdZQ
 BswhXG4UB20gPAkVtlzU9dg+q1f8CxnyXL3DNmT1YbEiY1mkmzeQdZ7Ta8wAojVD6sQ=
X-Gm-Gg: ATEYQzyedzxvmZab6PBVboZ2Kw7H2klyhbu1xcJq9tSBCroFN0Z28HRdph0gAABc2Lr
 E8ytc0wjkuHot3vIxgTbnLPeooiV57HXRhdyP8SgVYZqF7c3HJPU+8afSwthWuoRR35AMNt0GLO
 HlQweSZyt5rkUAb/CWVWvoASjRo2uNMw37qfZYUOKCSCijRrsZ/h3upEx4AtbKaHBonQZVBB4s0
 5vqF6b/ewbL7fUe0zjdAHUiJ2sDW3/+KJ+8AvfjJTsFjB158GePmzS1ce6w4sw8F15L8EBPOz5r
 1TzUKo8ETcbj9QJeazO/yuxuib8ORonyz0smkifXT/HgiYXISMWyFhP1KEM37JbowfEpS8APouG
 lBDQMZ9SLveSbAFS87xEt4XlB137kvCc1yei90wXm+dsZvOOhnBr2MhttKx7lCLBH8b5abwyiyr
 qzIUYqOXG3m/hT4SeVPVtWPH7dwk6XDOLoA03DuGGVYvDwmh8VNHhIK6kAF98tymADGzR6Uq9xr
 Vl+KLRt6Xt8ShqQx5lJLI+J1vUhbcEALxe2P3j4W+RKD5f1
X-Received: by 2002:a05:6830:83bb:b0:7d9:71e7:abe5 with SMTP id
 46e09a7af769-7d9fadd0c2bmr1855397a34.10.1774633945861; 
 Fri, 27 Mar 2026 10:52:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e6fb2e11sm5904292a34.3.2026.03.27.10.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 10:52:25 -0700 (PDT)
Date: Fri, 27 Mar 2026 11:52:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] arm: Add ARMv8-M aarch32 support
Message-ID: <20260327175222.GE502704@bill-the-cat>
References: <20260325011414.288343-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="42MX5ni4uu99aL2B"
Content-Disposition: inline
In-Reply-To: <20260325011414.288343-1-marek.vasut+renesas@mailbox.org>
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


--42MX5ni4uu99aL2B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 02:13:57AM +0100, Marek Vasut wrote:
way that it either can't be upstream, or wouldn't be handled externally.
> Add configuration for ARMv8-M aarch32 core, which are currently
> Cortex-M23/M33 cores. These cores are treated similar to ARMv7-M
> cores, except the code has to be compiled with matching compiler
> -march=3Darmv8-m.main flag . These cores have no MMU, they have MPU,
> which is currently not configured.
>=20
> Unlike ARMv7-M, these cores have 512 interrupt vectors. While the
> SYS_ARM_ARCH should be set to 8, it is set to 7 because all of the
> initialization code is built from from arch/arm/cpu/armv7m and not
> armv8. Furthermore, CONFIG_ARM64 must be disabled, although DTs
> for devices using these cores do come from arch/arm64/boot/dts .
>=20
> To avoid excess duplication in Makefiles, introduce one new Kconfig
> symbol, CPU_V78M. The CPU_V78M cover both ARMv7-M and ARMv8-M cores.

My only feedback here is that I don't love "CPU_V78M" as a symbol name.
Since we don't support ARMv6-M does a CORTEX_M or similar name instead
sound OK? Or is there some other term that covers what is common to v7m
and v8m (and what we care about in U-Boot) without implying things in
other Cortex-M cores that we don't support?

--=20
Tom

--42MX5ni4uu99aL2B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacbD0wAKCRAr4qD1Cr/k
Cg78AQDN+20h2hjv+uEb3YaK7wKPuMPj3oLuCLon/yMfyoXTSgD8Dajfe2n9opAa
LhEqoqldYasebdUTVTynBZ+mdiMsbgI=
=nfQg
-----END PGP SIGNATURE-----

--42MX5ni4uu99aL2B--
