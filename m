Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2D2606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GNrV38QZ;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VEhXeKyn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B93C760681;
	Tue, 27 Oct 2026 19:05:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I2CLpZxxMGlY; Tue, 27 Oct 2026 19:05:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1662C60687
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793127926;
	b=GW/BCn073BtPWxRCTQUZ+qJbpq4lL5k0D2VaAAd0lnT5mycyv5f0Q13kGWD3SVOiGo9i
	 XcCSfY3PeAZI1ltJDPMJbu15l9VWWv52cxU7IeHPqW6lRR8WDsXxNxjM4fmKe1KQRONva
	 6C/gtbDouleQ6doJRSD7uPi29WwW+HFhIwVWZp1v+0FR+P7JrNgzJiSuReaJebLnhdrDn
	 4xZN4HXDolI9a/IalGd/uB+QsShhwA2ncXr6Zz5PdRGOmQrzsP35iwH2g2gWZVK2cirAN
	 m1NrEUoXAfLMWjjRiQIE6EG8CiWeRcMiSEUx1RACKxFSfgGSc01wBbZhE+LySOVyfqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793127926;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eufXDTZGftJ4uXBuW7QF+ZjMLawAdv3vXrfrUHi39iQ=;
	b=sjE8QYAoMVEhl067zmNzRDbWc9RM7ZcbBCX4xMSGMKL+i0l/MOkP5ZP/l35RD4Ic2ImA
	 wkqnnjML2n51GHdzmo2BoCRwUHb3UZaVHJOGYAq1BLvsDVtdb8Hn3Xf1xwXylmX146uCE
	 Jxjl18x31TJSGpQVfNPxLur7gdpm2NsyaUnYcpuUgiBm5M7VuP20qlN0GojXlV0XovwIL
	 nAQUAJn4NAI5NlK35TfJlyWmrf1mUKEqYSJlkejSmHT07LU855Hs9xPEUMEqeMUFuc/uO
	 xgnH4J7e3FdOoi425dYlfwtP++hSnzYYAJVyR6yWW0NBM9veB5RhJ9X5MfQwalHFnMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793127926;
	bh=eufXDTZGftJ4uXBuW7QF+ZjMLawAdv3vXrfrUHi39iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GNrV38QZHXPoofQPC0W4ubsrhITg7HiZFPckop/x89OZNTnoWetGR+xJ8U2F5bW1S
	 Wv1+0Q3C4v5Mh/MaP1Oy8cuVkUS0ZmyVxBiQ2o4FeuYIgMPqT205h0t1+gqlGYSL3x
	 wyAR4b1hv92LACtRnW7tjjR97KyajkkoWN1JQ3rCucMVo3lJZ/XJAltSudl3Fuobdt
	 PGcWPHQJPWKrJwb5F1ojduZTcrpqExx4uruPtSr3VA5xQJwDd5pQCx7NDucoStVPae
	 o66QUJpA/GQyaApwKTSFc/X/8rRQEZdUU91M9SjRT0WukIlyp9WY1MgbapjfnXpJkD
	 45GSXwwOOFVuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1662C60687;
	Tue, 27 Oct 2026 19:05:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 941D14D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 19:05:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A98E4058E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 19:05:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6N-ttupAptLB for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 19:05:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C01D34059E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793127924;
 b=frwR4zVQFLniQQYRZPwTl+FS+q6maS03vnHjYKtGMAqP4qeH8x6CdDERirZFXhob8ZUy
 16+UY5QZwlay/w2OX/Tm+OhD1lGQ6gcFxiDxesc95KrcYCBA+Q/IAmVn3apZsI4cUBK5j
 zDEfj1z+41tSAwryVgYXdA0rQwInjrJ+pVJizb54uwPBuM/8MLOwXjfzYUVkInlF0W+26
 GebqeW0t7sukF/qW2Uc9gClciWSfuMvWCRZe3+Et/AM65frCD+jmpJnPTbO/BUNQki+7k
 eveEjqT1CT0pai7voFmpS72ukfRzLP29ajirqU7uRXVfzpx6CYwP6l/o1LapmPV+5iA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793127924;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=eufXDTZGftJ4uXBuW7QF+ZjMLawAdv3vXrfrUHi39iQ=;
 b=VC/9PdKRUYA1slBBLsxZoGev5IB23nJGdhyjwguD6go1rqXbuOPdrFw9/pepASE0kL7X
 a4ecqYBT8gywe03DZO6dmCydpGxPRW4zLBDoDgNKpE+3B7gKiEQlDnBZ723bi69w/MccC
 7zJ1pUAUOTHY2fCplyvkmtGKvNghcy21Or8d32ndDeTv8ZfKzPgh5GBzpARfB624BbYEz
 SgqBcjaUd8wrMGjYm0CJXXErjtIwFCRHLRvFCi+ktFCGCrU2G6Gt1MCA/OWXZ3ab8yjU2
 dNw9A9gBlczAGJYuwCAvMY1/DTZvscENEjuvjraZOROY3jojTcFRtdcITDU0zI1A3vQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VEhXeKyn; 
 arc=none smtp.remote-ip="2001:4860:4864:20::33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=VEhXeKyn
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C01D34059E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 19:05:22 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-47b47de8b4cso157578fac.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793127921; x=1793732721;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eufXDTZGftJ4uXBuW7QF+ZjMLawAdv3vXrfrUHi39iQ=;
 b=VEhXeKynuqPpyVmfoXCFqMNADGVNR3ug2q+b0VYs3Qozng5kzprN1/8/MonuDpFGi8
 FHNmrOyPrAViRb7SVVniLShaUdgAojRGuksqcENivRnb/PBXNbLktQp2YhgKgOWoH9Rt
 xS2NIMzd05l0ivZYvBud8SGVEZkA0e5YFiyc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127921; x=1793732721;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eufXDTZGftJ4uXBuW7QF+ZjMLawAdv3vXrfrUHi39iQ=;
 b=u6feqUtz8V+FrH5NIjmHubzRJ8Ux/KbQCsLWq1QrHza9fQhhHrkh7owjztszjDmg+b
 zfYHMrgO/Pl7qnL9uTroVcU7bHo8YmDKXW/QBnp6zy5pmxYouZTR1pDvU7IJ2Y1epg66
 1fEGHcEyd430JT4rDuqVSeYsyTRCsO13/1UQc8L0NVabZ6tl3v20up9BcN0wqNZtV+2H
 YdlRtcWYULQ+AI8fQ3pvEMH2DcZZSWBbKeq7Nb0vGK7EGdB7WU5LP3TzhmPz8uIYd6ng
 j8oUyjYHLd4UEFIRN/fMfM51vxzlXhep6G5jFWMB2/eDzeg+UpkXT7hMZ8FrTbO5Byy0
 XkDg==
X-Gm-Message-State: AFq9FYLZ2IAd6eGimGdO1sO1UQF1dg7DINmmcJm40pE4JrKlX3pcOAkK
 KAKkcZUEo3XEm488LfzHyTdv0v9E4SwOta5FmHVlWKT1NMT0X7tsg+llPIOebT385lFec0lxupc
 HZeXrg3GLuYqz
X-Gm-Gg: AYBFou2rbKWwbb9YkDzM7uakTul9ksJyfeZhgUV7mhhIDtlNADuXBj5YjnTphgZ1kWr
 4KkXwMZcPuvmI8BzrUY/zWZoQZvRaP50gnSemPateSuo1IYNOi82jSCsTWwnUo5a7pwy4sP2Bil
 ttjGbxDuO+s5idBfnLa1sCYo6qXENWJ0o7/1TBaFQc8WvXl6aet8/KhS4WJxHsGAzzIrtrL3gtJ
 XNuzdnmIVAzFHV28Tz7EMmND6VtsF4t7eshxHZ/JBuAF56hvmA1+2OScLE7argUdNqjU41v8yv5
 q2+YRyueQ9Vo4PBm5jQemFc6cGHFnVWEW/ReTRZGS19MNHZagDKsce3lA2okc5LJEd65qV74rUf
 PJ3dNnKZcMg/KYl3GRB0XpaJcITi6i6/uT9siXdSA3OJ9JbfC6Fy253Aj0BiFrqgQt71BUGBuKI
 HJ/Y2ntaX7czyPFcl7NV1U4tpShlfkh3u55opMcAkegmhqQ4PPs9Zi0eQ/860TZuYMs0qqajn2a
 ccO6VRuEmbWXGsVqOBMKdEpikUsYCHkxfCdoZrRFCoBhygKVMr6aaRONnERmkAmmCpBdjDVuRXr
 Fr1cAq7y/llsj3pyWHDnOqW5YyM+VBnhk+vx0PMu2jnlu5V2GYjyI5K3OAcehWPfHDl+oElU/0H
 YmZ9myxqQ86LOA89cv3ISiAaMTp+z5tXvoYT/Iz1rXUd9Fz35HmXcnWvbQnjFrOritYSNJzrMyu
 Ur16cXHL5PGZKNdjzacsQjAHe0yeCJxEI=
X-Received: by 2002:a05:6870:f61c:b0:4a7:42bb:9af6 with SMTP id
 586e51a60fabf-4a8bb54aa4cmr343609fac.39.1793127921404; 
 Tue, 27 Oct 2026 12:05:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8b793fe7csm713158fac.15.2026.10.27.12.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:05:20 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:05:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Vencislav Atanasov <user890104@freemyipod.org>
Cc: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>,
 Mark Kettenis <kettenis@openbsd.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Subject: Re: [PATCH v2 04/14] Make CPU_ARM1176 and CPU_ARM920T dependencies
 of POSITION_INDEPENDENT
Message-ID: <20261027190518.GK2177077@bill-the-cat>
References: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
 <010701a17a6cae4e-403750e7-2448-4b7e-adb4-65bfeec8b0c1-000000@eu-central-1.amazonses.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="obR+zqFyNlgTxbBW"
Content-Disposition: inline
In-Reply-To: <010701a17a6cae4e-403750e7-2448-4b7e-adb4-65bfeec8b0c1-000000@eu-central-1.amazonses.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--obR+zqFyNlgTxbBW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 10:55:05PM +0000, Vencislav Atanasov wrote:

> This allows enabling POSITION_INDEPENDENT for these CPU types too.
>=20
> Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3e9f3b51031..cfeec2a98cd 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -42,7 +42,7 @@ config COUNTER_FREQUENCY
> =20
>  config POSITION_INDEPENDENT
>  	bool "Generate position-independent pre-relocation code"
> -	depends on ARM64 || CPU_V7A
> +	depends on ARM64 || CPU_V7A || CPU_ARM1176 || CPU_ARM920T
>  	help
>  	  U-Boot expects to be linked to a specific hard-coded address, and to
>  	  be loaded to and run from that address. This option lifts that

You should fold each half of this in with the commit that adds the
assembly.

--=20
Tom

--obR+zqFyNlgTxbBW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauD17gAKCRAr4qD1Cr/k
ChATAP43w/ZhL/FxNiAkMli8GvSnzI6e7vPxkjGRnmFy0L3g/QEA7hEbz+/zMGE4
4o2DdCVETeAAQgtZ9HnU4kKStA0Htgk=
=5wqu
-----END PGP SIGNATURE-----

--obR+zqFyNlgTxbBW--
