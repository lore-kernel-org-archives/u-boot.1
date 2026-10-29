Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF833606A31D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NPl0wZ8e;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=uscFKqVH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE94680F7A;
	Thu, 29 Oct 2026 16:51:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AyMpfx1aGbBV; Thu, 29 Oct 2026 16:51:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1158280E50
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793292706;
	b=KPuBVlYsFFdvNZ1va3/3IVQj/ivAfnziLta6Wgl6gxVAHO9EpbDMUpf0w3lkKBIKAQyA
	 NoD2Z4mjhZB9nf49tmr0tkpgTlLfu5lFaIKRzaMI9kAkHqwdKe4SA2zbOs3jerYOcd8Xl
	 OO7kwFrLNbUoebcUWkzKk+V1//dSNBbt1BAyDmweJqs3EfDL6JWa58pgIcLFR4ZD5CB4E
	 L9nOBh3+zsEQu6j7gPIb0Jq5WFA7v8bA1g1PDbtAtnAGKbA3J2JJlHFXKtT4jiBR7jPNR
	 9i9tOEjrm7WJdSUSt4orM0jSQmK86AzReLIBZ5n/+sDJ3Pv7AGhZbPjnBbJd6E71yCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793292706;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=I4eiDjrlWpGQAvIf/qPpXSi8j2YjvqP+z4eErC67hhI=;
	b=Tn+7fnZmHb4+S6lzFRFJmqIpFuzmlb4kxihmhK31kIUxpGnYuYoeXGX1HwWmPfEA2LAp
	 B/inepKHU00LDQ/vmZd6iHmfEW7zrKVQw+Z06IEyVI7tL58ScIYtNWF7NNXhNSJXflsiI
	 K6uZujF6WaxRJ4PEb5YPbLKNZMryGilBU1Ykl5kHR9hkyEt0uCaEKCmIG61GFMokPwxB/
	 WQofB1RxfV3xlNtDpISf1JcoZKlz1oifAqzFwvB5H4ofx/rWgkJ1TxFANdi44cPe83EdU
	 A9WnG3KSnjggHOEIxdbF1DfujKKTqkKFT2pvS3+nNbXzmh6PcSuLlxDXWe5zOpK7joQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793292706;
	bh=I4eiDjrlWpGQAvIf/qPpXSi8j2YjvqP+z4eErC67hhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NPl0wZ8eyYp+jWbb8JtMe3dq7h0x31LsZiJQQKnzla3459VJ46m0jJVPJIHFC4zqv
	 ireSdu+0IN4QtE4s23OX2ET2h4BVnjJ8e/Jp33muvY/ZK/O6T9RCwWOpIOYuwVZznS
	 L+iTKIS4HmNpZwWz2lOoHglDUJc/sqMIPs5PdaZLA/1HlmIwkDwDfp7GiDsGsBhijb
	 sATZqkH6dBIXVYjPElExQnLuogg1BlJ9+ikBMQJNX8ZGtor9vEADyzKNXrHCo4uIe4
	 JuaafNMLL2wy3UDBLseEdeygLpIdFgDtSZG14RsH6kFkWi4f6otGAo45UUl+riBaEO
	 7KdKCnm3irppg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1158280E50;
	Thu, 29 Oct 2026 16:51:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C26D61DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3D9740694
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:51:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 87KyzcRTnkZy for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:51:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E06D740647
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793292704;
 b=HnwBvG4srtpQ6w7xb24D+ZQBzGgv8Ij8vrv9x/ttBOpjXXmS588jqDCvKMisNsnBW4ed
 I+Yi4Wk4ws2ZzqHhpRm2nCwq2qXMnXbMAZSuDQwJAVHIUgpvXP3fVa9dn634zZ2nwglfg
 h12gdkLN685g2H0C64Relp+3lTQXQehg7n7mVJ/KBt+hS33NuoZYGt1+meBNqu3stdG5A
 XiKjXGtbuzMq/MvelunENNtgiIlG3+J81F7kgZOYWY8EXR5L4R7g0q60vDrredOsnxHBV
 ewsTl+tqfyB7zu7XIeGOydTro82Zp5JGRKsMgV7i9dmzq6X6A+KYkQHXUfM2c6jJhqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793292704;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=I4eiDjrlWpGQAvIf/qPpXSi8j2YjvqP+z4eErC67hhI=;
 b=XRndiDS61UgTpCgPvY+D2GvGWOphGFBw7QA9JYfD9KDuiZqT2oMqvuIX5tqFAy7dT9Aw
 tTCuKt75OgbgUz4uUxuEHE0EJfXeWi54ghL6ZaVXMFJ70AkjMkeb8q88DbJ5CeK5e9zVn
 KFN7lccjGAuc4qH6tpNNLurSwKdkIGefKzz6C/SzIZ3JX9G3upb2I3DBRCKd72ULtgc1w
 2jklBZXyBXi6oIFye+2InHaqdPTlqSV5coTbj+9YEGz3Kt1f6ff0LcyoPZ1Er0XLa0jOS
 60hEuORs5fQ3MNk+ksCOgSwipPR/x7HDvOKoiTJ79+l7QhWHFrf66HgY3Kgq68PiU2w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=uscFKqVH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=uscFKqVH
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E06D740647
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:51:43 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-703be215729so1279438eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793292702; x=1793897502;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I4eiDjrlWpGQAvIf/qPpXSi8j2YjvqP+z4eErC67hhI=;
 b=uscFKqVH4eDyhfcKWn2KPicawh+6nyKJEx2G3S0kL1GZY2DwWjzIUOghr5r0MoDqsC
 +96IqVAMtbI1VOSMA/JEEsGkxLS5KFd4AQ+s2ZrKZys+8OwOFxpMYuHwAckcDadTTYIU
 ejW0HUk9Q7iPj8ojO20bV8lz0Jq2RmLC3/fbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793292702; x=1793897502;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I4eiDjrlWpGQAvIf/qPpXSi8j2YjvqP+z4eErC67hhI=;
 b=bMHJDsdAiISsBx93tFhcpyVOY6itLMyO/ryQo9PeNqyhVbGVpUQaOOskwU4hHoObAo
 Now5RXkUoAisum0R6FjfVDzHF1uUFwk//t0vNZGPI5IlaH/MbyjNJI8+a2DQeN+3q0QQ
 pvT4C/tTx0tlhQP3qcZak3RsAC/2vCRo1btVDt9DGKJ1c0Q7iuQYzfiHARDrTanGkSw2
 8NzMvfpNkUVVQvg00W9GtbbO35Gv6rUj29B5/i3jrGpAEM0AgmUhJ1s8Ayvdd9ctvfmH
 C8aMQIRaxk8YufGmWhyk5oJks37epW4Gm6bwNpD/h3ibIC8L6dBCaJu2ktbr1Q8SYpLW
 kqRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwh/ssQnMoR4aWCX4dbmGeyHyHWUP7ZlXD1tnTyzttppo7ph26I2JDYnWMAshpem9NOEzdKWFk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLFVP8d46ot725Ya9CTmNKsnu+6BQXH5kD8ozgI+W5xTU3O2ca7
 kJejQevj4KK/k1zFUJhgmiiE7ea38oT6+E8dISDVcIIYf+WRgMioAQLHwncprdqaJrQ=
X-Gm-Gg: AYBFou3ZD31LzRu0uUbciPlCWdizfMMgafRhrt2DtEo3bju5GUFuD1uLxB13sO4AbIR
 0iIVXilLckMJJKqjyKwVucOhHeU8fmn34uAGRp99bco7xN0/IDUQ84wU59DODX4wIkpTnOfIfLp
 MvJT4iJ6ftNeyYVRSl6/eGul/8fDYZuWrrcVvmtzvcItutti7I+MsuVSLxC/tzA2zbQ11M5nKxQ
 ehjG/AEUrp1MkC2K5x7PWiLIv3lRmigwInODjk0IgoOoya4HmM12ryZPkqz3ogPxhF/jK7i4KjQ
 XwfJfD5VXgYAfwdbyYdCum19IhRKR3Vf7dErldSZ7r7M21EdtBeTsLTL6dOwySMuOlfJDufrtGk
 OC+OJ+MqqfXFu0IFRBoLsHUuJ2TQrRjiwuppUDa23NwSaOw3E+oVbfAfFGVGw2ucyJ0bQnCVaEA
 UXGaP5gL+8ZSBWh7mSxTuwnxyJOOa3KWDYJ6w52SvP2aP8TFWxYtW1fJCERtpt1dd+mU7eQFqiE
 z/DHYyvoQWZmgKjXpFryF0eHK9LVGBoGdpTdnY2eKu0XZjmVT4Pyoo6AbAb2groFS+bQd926oY6
 4IqOeL4XvlFVpDbL86/P+jFIdJpD/1bkvt/dxhVRekn2EMaJKe7oKQN3fRs3oSPpYMhcBsUH3Iv
 TNwMYtmRxv24Xf4MQ4bmTVvD9bixn90pKIHScBQs6faUMhtOlIk3NzzF+BD4gvVwBDcUjU49O1f
 r2FjS/dQrh9OvLMGVJwe5qNC4ge35NTLY=
X-Received: by 2002:a05:6820:c3c7:b0:703:10:aac5 with SMTP id
 006d021491bc7-713edbabde4mr2535794eaf.22.1793292702426; 
 Thu, 29 Oct 2026 09:51:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d33fcb0f8sm378982a34.14.2026.10.29.09.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:51:41 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:51:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Abhilash V <abhilash.v@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: Re: [PATCH v5 05/13] arm: dts: shikra: retain QUP SPL dependencies
Message-ID: <20261029165138.GE2976463@bill-the-cat>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
 <20261029105746.3487456-6-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3FIgxoBm7OOlAPiD"
Content-Disposition: inline
In-Reply-To: <20261029105746.3487456-6-abhilash.v@oss.qualcomm.com>
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


--3FIgxoBm7OOlAPiD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 03:57:38AM -0700, Abhilash V wrote:

> Retain QUP, console, pinctrl, clock, power-domain, RPM,
> and MMC dependencies in the SPL device tree so the firmware
> loader can use the boot medium once probed in SPL.
>=20
> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
> ---
>  arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 44 +++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikr=
a-cqs-evk-u-boot.dtsi
> index e807b91ef1f..c79c63ad732 100644
> --- a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
> +++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
> @@ -20,3 +20,47 @@
>  &usb_qmpphy {
>  	status =3D "okay";
>  };
> +
> +/*
> + * Keep SPL console and QUP dependencies.
> + */
> +&gcc {
> +	bootph-all;
> +};
> +
> +&tlmm {
> +	bootph-all;
> +};
> +
> +&qup_uart0_default {
> +	bootph-all;
> +};
> +
> +&sdc1_state_on {
> +	bootph-all;
> +};
> +
> +&sdc1_state_off {
> +	bootph-all;
> +};
> +
> +&sdhc_1 {
> +	bootph-all;
> +};
> +
> +&qupv3_0 {
> +	bootph-all;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +};
> +
> +/* Retain the RPM clock and power-domain providers for boot consumers. */
> +&rpmcc {
> +	bootph-all;
> +};
> +
> +&rpmpd {
> +	bootph-all;
> +};

Why aren't you upstreaming these?

--=20
Tom

--3FIgxoBm7OOlAPiD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauN5mgAKCRAr4qD1Cr/k
Cj22AQC9DUYFnSeAuDNRvh7gvdOtdkzefdEtvlccDdzjBP+53gEA4aoPmMcDg181
hh6hkgL5ak455vQRT/ABtK9h3AzzqAE=
=sZRt
-----END PGP SIGNATURE-----

--3FIgxoBm7OOlAPiD--
