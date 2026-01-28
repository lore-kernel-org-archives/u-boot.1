Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3776D46BE5
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 17:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F33883E88;
	Wed, 28 Jan 2026 18:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q457oude";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E115983F2D; Wed, 28 Jan 2026 18:56:20 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A86AF83E4C
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 18:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45c889aba0dso611233b6e.0
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769622977; x=1770227777; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t6XsL1gnjoc3CAQo/+xkgxdmyW2fazXhHXo3dPyRLLs=;
 b=q457oudeYWS0o53vi0T0x2+RxSTdYCDuYcPneRRl8SHLXOlyfuluVYpilBlLIzZ7Kk
 j1HcSMJ9wp6e1t6L42DgZYUdw80S6wUokCUZZfxn0LzjepACt1GvYRC4i3mmNl/D72Sc
 NUzD9b+z2msoyO+8p3bMugCuEJzxja6ZjziuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769622977; x=1770227777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t6XsL1gnjoc3CAQo/+xkgxdmyW2fazXhHXo3dPyRLLs=;
 b=OOuxqQgvIZRcnDGykPwCzSfTD2dEPrzrojUigqWB5RmDnQynjjAiZ9FNGzhLXZbIiA
 jLnYRyyIqBC7R+xbhRO7QWweuO4cORfic+CYrS+BWqksnHpF8K97+sJremcKEabs0W5N
 VtiCLcBkiVBHYLeiDoC1QG5OLnEhgHeQzhqo16hTPd4vOGrbbYLpOy7wSfHJTCatsBbL
 B2RUXxo6za7wxhTely5iaiPEwqK1knyGVXOKFCMK39w8dzFbzkP/jgtqFRg2hDT2+bil
 RZ6sSNEDeQkvGYmo8zfww/zLIWeMITXNTFSwFm5oN3kYrOB4+q1xNr0fkCvPLOF9Bd/Q
 bg1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXccYOwGYnmcxpVq0MuAKyTbBkryhB1Fe7qnuIMnqxsnjEUoQ8KRvQ+3i3w8kHH2AzeSscPb9k=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3ZmyFPE/t3lk67DR6mCRvNJLIYO2jvZEqUBxtNjLu3/pUVCFP
 x5/YvUUL5+RpDIgMZVI2A1SM3FIUhgMMQ4cVBtQz8bCi1GCRZ51K41dZF1orhrroOOc=
X-Gm-Gg: AZuq6aKnsE5JDl8/00MW0XMCM1g76avmXTPnq7Zc0Xqju8oUUmeD4O4Q7p5qaMoF2b+
 xAOqkgo9zxwaEsjBWW/WXQ3GHQiouOX5iZE69IUtfZ8bniNNOgskmf9/rxmtnxq9RRnzinCMuhV
 LgT86K3ixXKgIaQo2mIFjmMkKLmd/RuWageo6VCYz0NnNDXmMSR6xo2lm0cr3a+jiAgSMy7//8g
 FkmVyUa5MJLax5Yd0tudhJ4LsQS08XEY6zoz4raYI8jvCzgs4HeSJXgH4zgoHojhtultm+WdSPM
 WnDTFM/9aVRchQPQE+LLhkPAg2FrlB1bhjuLaxl4F+djQGxRMaOYYEoH1vQVSzXQUbtxkmNRrYE
 uOTUk77a2gHYzwSSiXVVyx+kj8Og1KPD+0/c5NuMF2ZAF16b3I+XQPVgn1jZ4ol1PziXlzUZFob
 gmsTFv9SBuH+h7v49XdLOOwlu9shjjMF6AB94vqJ3nZy1lof0ohSO/+NmwQfNtcG+aOAk8Q3QvT
 +qGPpHN3BIkoT7LaKu28suoQ/XNfoHqXow270mVCg9rSBn6Uw==
X-Received: by 2002:a05:6808:19a9:b0:453:ea2:36d9 with SMTP id
 5614622812f47-45f1e407e0dmr129245b6e.32.1769622977372; 
 Wed, 28 Jan 2026 09:56:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08f22826sm1600703b6e.11.2026.01.28.09.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:56:15 -0800 (PST)
Date: Wed, 28 Jan 2026 11:56:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Sean Anderson <seanga2@gmail.com>, Beleswar Padhi <b-padhi@ti.com>,
 sean.anderson@seco.com, ilias.apalodimas@linaro.org,
 malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, marek.vasut+renesas@mailbox.org,
 james.hilliard1@gmail.com, anshuld@ti.com, afd@ti.com, nm@ti.com,
 vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, bb@ti.com,
 praneeth@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v4] tools: fit_image: Fallback to 8-byte alignment for
 flat_dt images
Message-ID: <20260128175613.GP3416603@bill-the-cat>
References: <20260128141834.2322865-1-b-padhi@ti.com>
 <708253cc-be1d-f375-0427-91658d5e88fe@gmail.com>
 <3432c5f4-ad37-46fe-bac3-ec0fc7778767@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zM7J5GLV8ilBAi9I"
Content-Disposition: inline
In-Reply-To: <3432c5f4-ad37-46fe-bac3-ec0fc7778767@mailbox.org>
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


--zM7J5GLV8ilBAi9I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 06:23:20PM +0100, Marek Vasut wrote:

Thanks for taking my request and doing what you're suggesting should be
done.

[snip]
> -	for (node =3D fdt_first_subnode(fdt, images);
> -	     node >=3D 0;
> -	     node =3D fdt_next_subnode(fdt, node)) {
> -		const char *data;
> -		int len;
> +	fdt_for_each_subnode(node, fdt, images) {
> +		const char *data, *type;
> +		int pl;
> +
> +		if (params->bl_len)
> +			align_size =3D 8;//params->bl_len;

This should be params->bl_len, not 8.

> +		else {
> +			type =3D fdt_getprop(fdt, node, FIT_TYPE_PROP, &pl);
> +			if (type && pl =3D=3D sizeof("flat_dt") && !memcmp(type, "flat_dt", p=
l))
> +				align_size =3D 8; // or params->bl_len rounded up to 8 ?
> +			else	/* Default alignment to 4 Bytes */
> +				align_size =3D 8;

If not params->bl_len, then 8. If params->bl_len then whatever the user
asked for is what they get.

Then post it on its own so patchwork picks it up and I can grab it
please.

--=20
Tom

--zM7J5GLV8ilBAi9I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXpNvQAKCRAr4qD1Cr/k
ClHLAQCqc23XYIRoJztCOFjMaYJ92AljpKIyIe7Eax/9F7NyQAEAuxuPlHnWLp7G
s3JINyfXQ3USFuMGyunemOykFrayNgk=
=6i2j
-----END PGP SIGNATURE-----

--zM7J5GLV8ilBAi9I--
