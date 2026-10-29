Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC03606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pJj/4Z2h;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=P1+1DMu0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3237740589;
	Thu, 29 Oct 2026 14:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gb3Ct5hWFeuB; Thu, 29 Oct 2026 14:26:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 81DF64060F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793283968;
	b=N7X+BHqlSI4uBr4icxWRnlrgVfNmdU/ESWfrk7gamutoEu+wWLDOgrpXS5jaP/xD0IHJ
	 AewfhOdHASMXM2/IhAgeF26uVS+IbJnpIh2rQ1nsSMaPDuDM4RaO+RX0ACpfrU8QmEx+d
	 MWfXyLur0cvoQRXX/Ch/sF6Tml05rnj41tf0iS3FczpfIYhLSY2twqIrz720w9TfyTXz6
	 7qjmgq6eBvC9wrq3CNkwxa3E/HURiF6hrIjOGUc33+8snQBQ3gph81sjEHW7xiotTzDLn
	 Gp0vr3bKfBYvP3KJQYK26L8OAoACVU9tEiqVcx7L9d7wkhGsWjqtiQIoMAMohK9JUlA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793283968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GS+8K0pYvWsIewAPqzD0gvUFiMgnoOGDL9zZDU21iyY=;
	b=EsSmbIg+bdjIKG1GKsT3d+42QQLPwNQsNIzLABf2rjqrDliNnXN72zKM929EQ/1pUWjo
	 ACZkLOcyXiEzJH3Dii9+W+BbIt7MBcABVYGwyLgD/qRObQeFmxmRT3EXSY6LxNHIYlZV0
	 YB4xVAvao8ULS7D9EeyIQBt3EeLqX9qdVlTm9voazXTu+rRFYe5s8NirKxFso8HyuJqKt
	 7xik9fJQ58ABRj1ops0oLwZlEKjPIE3earN7fAsfcCYW+WkvFM8/moOt7KSATtybr394f
	 ayiJb2H9HszqrE+tLGA0GFRUv1FRlmgioqqbzv+hSDe2inl1O1VY7IDljFEP718vv+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793283968;
	bh=GS+8K0pYvWsIewAPqzD0gvUFiMgnoOGDL9zZDU21iyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pJj/4Z2hYTPcMQHICCGCBuDVSd7GwhdHrra+T/zIQL2dX/z+Bn58kdFyYaZ05OdIO
	 cmIJaCQiy6OSMh7CPOY4TM05+i3CYfudxyW32aM/PCxsZkvGnbCRlaBUC1//k7g6mL
	 9/+GE7kAIDrT/UVDKeciYfiW4flTBtBQMdrydcyfw/a1ItiLEg2Ljs/3F7Z/Vcsvdb
	 Inb9ZJ4MEoBBC4HdVOlAhUE8x//w4iJMVYfzVKEcuWOvt33b84h3HVqCUX/kbvkGql
	 XAH8KsoKvHQvK70u8heG1UjQYHXI+wPngyC+eNQ7viEFdLPuy/odcwdpTOZldfPV8p
	 gbkv71mvgoTjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81DF64060F;
	Thu, 29 Oct 2026 14:26:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8869A2FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:26:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E7ED80F69
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:26:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gxwjIXjj7LXQ for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 14:26:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A709080EB3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::234"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793283966;
 b=sR6qXVOp6RuKpZYzXr3E8AHHqizU+r8R0ixmc5WyZOMXlCGX8UWKfvIPn0qGTYrmzkRr
 9ajP1YGMu0L+97dZUI8Ojbr2FC94IaxqCHj7EZNjffDwDDqbEbtPSTMeuUymJ1IElRth3
 FKfbgQMLNyPkXpPaZZExHqgl6kOeaVLh5FGC1b/drX9/j5T58rgOYEoXHdd9TxN4fumPX
 AuB3NCIkgFL18lOeCU+dS/6a+H0Fkito+TKqzXaNwhUpI06hBUVIbCU96uPnY/bUW1NGM
 jDJCG/qa39RXaLyTtzqPiD2lB7m2bbMjCBylQXy+y9BcKLi8Zi4LdZUZvIxQqTn71sA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793283966;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=GS+8K0pYvWsIewAPqzD0gvUFiMgnoOGDL9zZDU21iyY=;
 b=KdR0PG2cP7jBxZzL/cBNWo8JDFuN+sPebMwoqAXtujFgWr6Atp9uW3CGlGnau4VNRvWN
 B1y42XRjblGIjyZ5I9m2vZeFu3yG0OoY6S2qigb0yoCGUfj94fykWODKOAJzDxSCI4Bbe
 fw90K0rCbZAKODevxJpeIJmxZvXnehOAb/VRogsNyZPPhdfJ4lMaQzCavf9NZ67YzJeYX
 kttFBxTwUCsAuqVqFzRvk8CxyontsR3fnVndEu1z1d7SnH7WDvKZjUFUTjTR3FjnWe+My
 iZkm/FLhsdkejM22FZHK2U6krIPIneN8ndrSEqNqmIOJI2n9LCLBBa1smoOWMj6YC8Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=P1+1DMu0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::234"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=P1+1DMu0
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A709080EB3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 14:26:06 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4c5d8c7f326so893592b6e.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793283965; x=1793888765;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GS+8K0pYvWsIewAPqzD0gvUFiMgnoOGDL9zZDU21iyY=;
 b=P1+1DMu0FVqMYy+mS7VBmJvbpnzccAFEm2IO+HvZt+mRYBevMWCLYsSz7xEJcQrnw2
 SoARFe+/0UXJi71XqVZmKa2iLIyAFdBVwWX8PJjCLIeAlK+o5J7qURYY3Ugf0rl2dvN8
 TLPHd88Lep1/3ZKS55w78gAdoZBt4TMuiV6Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793283965; x=1793888765;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GS+8K0pYvWsIewAPqzD0gvUFiMgnoOGDL9zZDU21iyY=;
 b=z3aUSar720DWHa9v4tPpdkBBC7YcLzDUF+FilwfwfyqlDNrUxYvEmfdbyO7Rlbbir2
 +niFkTuQczhNi3QTnFFZOl0q22o+ZOy46fkT8ctWvEJkcrZssDbTG3hCjWMWF8H5H77v
 OS1iVUPadOlEJIHScJx3u0ELp1yb6r8/5kXV9bgcnjtaLy8+usaugz+xYg6fJ7YbARZn
 bfzh54tifGnjfnwN47OACCNOhrXrAXmQaFnJDR5GRDg/dtlNoNeoVO3do6DNSOZCR3O/
 zb5h06PN3YrPHVf90iEX4cdyTX9LGHIDCNTVVodud9LojR+qdW+Ziy6b9JvdWVcVrV5/
 EhGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw39EqO3zQNLmF3PKqgiBkJ6EEeeub3FdvUv1PhFs7yglaE/kzCDGxvtR78E98HijSiLJ2LyM8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLfR+Cct1DssvrvKtYK4z3YczxjWz7t5ZJKl5Gq3P4l7b4eX0yB
 mCZas2HXekF5AdqYJvTylIxv7VRKoHjcVj29qV961le2vvny6GyPc/mfB9uPouCgnI8=
X-Gm-Gg: AYBFou2ZCMWW+8W6aS+kfvPpUfxiTTnsM5GJW4GpgpRhV1jx4okjjnegbw4FzR0rWFc
 iZ48JT8RwtYeUJ9qYzXdl4sFzYFL7WkEHyE9QXlL/zk2GoNdJZEjBmuKr0pJ53crNq3/ZTdoEch
 XU68skCcAmYLq+RQd7Rj/6oBA6lJM+wQJHk6ll2zN2QFX0yEg6a/sCnfZ1zJ3Uval1YcPYvyqfw
 bGzMiAkNC3PG+7bIG5B72DfZelioVWqxeXeKM6MERvtiwyczcCjKTYe8Q/xWRg+FgfS3aLmiBBn
 CwTWuuboulkQiZdwfL7H2kmIdpbyRdRifH/66UXkeI9T+y4Yqs2zN7+4BV6SrRjy7sna/bWsgu1
 ZedyJ0N+HPARqQAz8Nlkak/oTaesLw6mqI09eDbx54W33kGl9ltTn13+CYJYLtTiK3ULcwoG9yd
 W26N2MwC15mrDqHU+x3Jey2ctOPI+FGYkYZ2vGp0sclTdcrD52XWATEv8yT9PrAhAt0aFwToYt4
 cLGQaLp9iztxDQGD9e+gxgfArsp6rJ6yHAmOAUb4wjGKTaJ0iMIKrjQ3WjbNaRNJ6940UmZdz1F
 0i+HPOgI3zKA5qN0W2S9HULxgHxL1DUQ8f7GD7909ln8rSt1lg4AHQpU7i3rz0oC3zL7YEFNJK1
 H9hvKah+W1amFQ+4soE49ff2AFOKZy/q5p1VuteucjUHdJsfXdZlwJhFyDmBmjaa2La+SGTFdug
 q0rGCjsD3j5PEtC83nZNw/gJHqPTP72V4=
X-Received: by 2002:a05:6808:309c:b0:55c:6aa:14f7 with SMTP id
 5614622812f47-56382c81c64mr4322657b6e.21.1793283965048; 
 Thu, 29 Oct 2026 07:26:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8b7830d1bsm5260741fac.7.2026.10.29.07.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 07:26:02 -0700 (PDT)
Date: Thu, 29 Oct 2026 08:25:58 -0600
From: Tom Rini <trini@konsulko.com>
To: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 abhilash.v@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 1/1] DDR training: enabled DDR training for Shikra SPL
Message-ID: <20261029142558.GA2976463@bill-the-cat>
References: <20261029073007.385154-1-kr.sowmiya@oss.qualcomm.com>
 <20261029073007.385154-2-kr.sowmiya@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k0qcD2/rsC/kgLay"
Content-Disposition: inline
In-Reply-To: <20261029073007.385154-2-kr.sowmiya@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--k0qcD2/rsC/kgLay
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 01:00:07PM +0530, KR Sowmiya wrote:
> Add support for:
>=20
> Reading DDR training data from eMMC during Shikra boot flow and sending i=
t to
> QcLIB via interface table.
>=20
> Saving DDR training data in eMMC when QcLIB performs DDR training and
> sends the data via interface table.
>=20
> Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/Kconfig              |  66 +++++++++
>  arch/arm/mach-snapdragon/board_spl.c          | 126 ++++++++++++++++++
>  arch/arm/mach-snapdragon/include/mach/qclib.h |   3 +
>  arch/arm/mach-snapdragon/include/mach/spl.h   |   2 +
>  board/qualcomm/shikra/spl-shikra.c            |  35 ++++-
>  5 files changed, 225 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/=
Kconfig
> index 9e23d6d8948..92bce79b25c 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -93,6 +93,72 @@ config QCOM_XBL_SEC_ELF
>  	  The image is copied to the build output as xbl_sec.elf and embedded
>  	  by the platform SPL linker script as a Qualcomm XBL-sec segment.
> =20
> +config QCOM_DDR_TRAINING_SUPPORTED
> +	bool "Enable DDR training data save/restore support in SPL"
> +	depends on SPL

Since both of the valid options here depend on something else, this also
needs to depend on one of them being set.

--=20
Tom

--k0qcD2/rsC/kgLay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauNXcwAKCRAr4qD1Cr/k
CtNaAP960thgEBI7ABB0A7x6Gm1mUa/2uOWv7lg8vRHb9pkpsQEA4kjcdkG67MX5
EOsvelsfFFj4I4xb0QPG8wuUh3T9OwA=
=74S9
-----END PGP SIGNATURE-----

--k0qcD2/rsC/kgLay--
