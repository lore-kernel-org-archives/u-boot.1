Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4C3606A330
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sMXosmld;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=tNaaVfcX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC9EF810E1;
	Fri, 30 Oct 2026 17:59:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IPcrQ1-0-RSL; Fri, 30 Oct 2026 17:59:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B391810B8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793383153;
	b=eBRhAq/myln2WBgxd/rZQfiVd+Ii52pKA7AIlmlLuLFWE5H+LnkuoIAcdQwoP8MRcYZH
	 lqPukUjmnLirva1mBhrvCs/FxtopRDHAozKa9LFF6J1kV9Ii6Pj48bn6M5pCJxzGJ7k/m
	 9xzy4OcYsa2sR6ZYJw3AC/UGXm1ki1dqXFwgNl9j8iQO4fwfcMlYQ025XbA+WsbiFyOBC
	 BWQmaIltVlgBMnbUSN438NgEZxn3nuPX716slVEEF/Zb2g8cj1aasrVv7jlgl35Bq/HzI
	 ZjL7Rzd6FZc1tSg1REUKa7YuyAK4EUlXJwCwmx6O/hp7J7udI2tjiBSlmRHVphX67/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793383153;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2G+0euyW+uBlKgiBhrZHQzsfQJzXvigO3j0hcb5lyBM=;
	b=CggUB2aggw/0l2TnEVNTScBaYl+kgB8cdWDJgLH3k7odSF/Dr1HOs5XxCPtWlFVPKUCj
	 FIqZZYM1xfTITeEschE8gJamCWGM1OgbLMJGoEwr6z4jpqttBhKlCxvqLq4LYo5bIOMfl
	 +p1XHByvrU15LUnxG13Wvn2DPgdcCI33y/tK8/zesRYdXS2K676Ay6rP4+FPWpS33vMgI
	 MXpt7UT8yzQNARS1koW65e06CP588r9bZnE/GtTClTlzEWzPWfITVB7Dud5MRBZYak4Ko
	 daLpeQNQz44KyHaM7OV9YHnsZ2EuVyD6PCoHJZBx+XXxO8QRVs/yNmNURRVoVbX9L+Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793383153;
	bh=2G+0euyW+uBlKgiBhrZHQzsfQJzXvigO3j0hcb5lyBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sMXosmldNHJlvfGL9I2upzyRWizxq32qY9isk5D5T/5B2NcNV3nIbobv8/b6x4Svx
	 vUxqw9zoTi8PkUO9VdVMPSLHZnwzg/p+5Z6LOOltYTQNQ6lgoGxlBOEi5K3uLX4Rnw
	 HSbJDGHe8H8fOeOoEkwNxuIraRhjrfZ5VWgdBsBZ6nkJgF+u7lxK+GJIwj63vC7KWX
	 jmHMx2EYqcJlgBZOLdnpLAsfwOH9fjcToIfs5yzZ0m7tkQ18QoX/tMRd7tdEGqE+3e
	 XKF0Jhif0MlW5i/jFkqezMlwWnuB1ybLBt3TnopzzyvURQheLUqzjM/lhgDRQnuUfD
	 N2eeppN+u238Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B391810B8;
	Fri, 30 Oct 2026 17:59:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A4E26156
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9655940ADE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:59:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GvgAY84eg4pW for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:59:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D8B7F40ADB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793383151;
 b=fIM9mzklApmpEsP5gC5o2qDIf0Fe7FUwnoS20NMCo1QL0JaoRa5toLMqzui1O/Xhm4h/
 brZev2yGvMqV6bBX2aFic28oyI6en/O/B67CgQQkvJi74Kz4NSv3KjnaLCtXso9EO3RHd
 cirDaUUTKR3KHBvwwIOwinXOpz5azV302hJdWPR2bnbc7DT0ib+EPH4KLU2iBpSl9BdrB
 H0vIrQ6HhsI+CQP2L8IuYe5L4RLiQ8KJBGmisszwPosWBMqA3fUQrwuppHFA69CLRp7dn
 YYOxPQ2AfNbyjonPn79jXDq9Y8QEHjgH5DJ92lO3KCcDiASvj8O07D6uvvv3LO+TwXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793383151;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=2G+0euyW+uBlKgiBhrZHQzsfQJzXvigO3j0hcb5lyBM=;
 b=Zk7++0kBBxH702Lz/WlGWiJxezmBVeq/U8OPPqp68CaqqvwLcAi4FJ0VXg1UwK7BU55o
 yT6wpVpMlFUIHqnB4q6KIdeKFLHu0Gpbep7edyIGl32eblo5hV12ZqgTqRBz0dKbbX6/e
 oW0ZzToOhG08+SCG4NBM2ezQBCtiP835suNyTfeifPG4kZeOr8+aM1HysQ5DSGE67fPLt
 rCUq7GNOLlp/kOjGNXyRoL/osQPNUZ4hW5/sMB7Yf2TPOz/PrVxR7k8SjJUEoHOQx06vG
 UYKShAhyDF/Cjrcqo1PwNpH2f/TcAXH2AG+T+LWyNYObcSw/gYiX+08+xdhHlHLjXzw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=tNaaVfcX; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=tNaaVfcX
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8B7F40ADB
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:59:10 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6b1afdf5196so331233eaf.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793383149; x=1793987949;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2G+0euyW+uBlKgiBhrZHQzsfQJzXvigO3j0hcb5lyBM=;
 b=tNaaVfcXEAC4T0TV9zeDy924LMt+Kb6IUuRQLrLAOWcrcUXm8TPA2gfK1BQsPXjAGG
 YgWLmOmWRaI4aW1fPeQUgdZ/FasNrUvjaeZBTs5WMuYeuhr6JR6tC7A4Y5ogLD1NWghn
 wQuI2SM3d+xXwm8xW2n3xR2nVlabRd6BBRXi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383149; x=1793987949;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2G+0euyW+uBlKgiBhrZHQzsfQJzXvigO3j0hcb5lyBM=;
 b=cXK4vnwQ4owOCjXuz3CVqcKwEJjpJ56cyQtczMQQ0efjbsQjzRnMSHZP//239e5NVZ
 H8Afm+2QFbCNCv2ClZ5Oys0Ho5B3yc1ImTkbiw3V0KDmviJVhFEpEGRGtD6F5tqqJNQL
 nd41x0MHEnchQZM3He5vedYw5zBoguyAPY2S1xcIQ7htknpPAC23KaKEdE9r+03V0fs+
 F5n8EmO9cKwi8QpVr2bsnqZzuG/KRyW7ImHE0c+jLZN4eU1lfaet6pCE7Z5oY6BmwsNo
 ngpyprC3nDyOOxzIQcpkFjnGyu/Po5XCi4R2XKrOeoOx5lQbgGvzakTsnVCucCgGQLLV
 ICFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxh9l/Wj8MiRnbK6GXhO5OKjv8cbnIpdBTTpAEl16HOKJ/uTBbObR6YcuxehSXyka7SIVrSfsM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKvXLenvNUKfKz3YWRq9KBuugu25SqvYeZp2D/2psAZjl23/3pT
 cb4rIJwq1EUTHMGhM+rUbYDs15CnDX5k6hP+iuS6qhb8WyhR8+sJkQUmdroyheoxysQ=
X-Gm-Gg: AYBFou2rtkHm2v2/y1p4tjvoP9FxnWUgIypYwKtAtST/R0NVy+T4ae5B0lQ/kB1Lkq3
 2GiMy88WvwmXxBld0Am6TuoYqlAPv9DglbptQy1wuvgph6ALoNhgdhK+0CysEN74A/zedkmcycC
 w+W1sgfnFPfFsjv6Ls+FB/Rrlqd1qtI+AEhmrwxg9UF1QFRedGPwJcBaAOsqFeOEarnWvUn41rq
 RuNBNWjh33mDentuCXtcO75Umgvyjckyt9dc/46CvxbuctEQGHroWXMECS4hW5wSRXQemrj/R06
 EJXAXlnzRxSVAY05pvmKhWy9X1CEUxoi6BvgAggO63tRGMYWdmachO95d+ERVE86WGXfir52vb3
 KLBi4zTFK1S8iqmkcBzbtjbcsy7T3SR4PM9D4wlT/NncpT0p3UE+9zTQqf2+T+Ri0beN1tjWEZA
 HnzhmqoS8ea2jMBOS20xJRkefRPLwPtbxAC/RfkF5A/v5bCjUYP5mJEF+PVp/k5GzsvetMPSngC
 EqvwqEC9xO2rLj7uIFw456N4g4RA9qey2kws3xuZzIDx/GL6GKJaljxGFNtUDm858cjxCtadnGS
 KDv1lua8iUKPImAWGTMi8oDyVz+fGS9un8K58u5naqMJUAzsTIBAOYXJbARDKsxWE0+FXY7ijJm
 E2dE3nOo83XhCxJ6NkzIidYxsV7LmIqqzEYdm5Y3W6VBsgnFJurgxJfGgTlKXySdWRwqyhKivMH
 ctKdrarc0JXsoB45bAz1KaFdyg2dQFiiw=
X-Received: by 2002:a05:6820:1692:b0:6be:139:c032 with SMTP id
 006d021491bc7-714f28d03abmr1773526eaf.18.1793383149418; 
 Fri, 30 Oct 2026 10:59:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f2e3c910sm2294857eaf.9.2026.10.30.10.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:59:08 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:59:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Anton Ivanov <anton@binarly.io>, Vincent Jardin <vjardin@free.fr>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: Re: [PATCH v2 11/11] test: boot: imagemap: caller-owned region not
 resized
Message-ID: <20261030175906.GA3333978@bill-the-cat>
References: <cover.1792591479.git.daniel@makrotopia.org>
 <18ba08d92985d340aed6dd006b99321f0c443f17.1792591479.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MZhUWsOKhZpCwBqU"
Content-Disposition: inline
In-Reply-To: <18ba08d92985d340aed6dd006b99321f0c443f17.1792591479.git.daniel@makrotopia.org>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--MZhUWsOKhZpCwBqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 03:10:12PM +0100, Daniel Golle wrote:

> Add a unit test that locks down the fix in imagemap_map(): a larger
> request against a region recorded by imagemap_map_to() (which the
> caller owns and is not LMB-reserved) falls through to a fresh LMB
> allocation instead of resizing the caller's memory.
>=20
> The test reserves a caller-owned buffer inside the LMB-managed RAM,
> records a 64-byte region there via imagemap_map_to() with a guard
> pattern beyond the payload, then issues a 256-byte imagemap_map() at the
> same base. It verifies the returned pointer differs from the caller's
> buffer, the guard tail is unchanged, and the new region is LMB-reserved.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

This fails CI:
test/boot/imagemap.c: In function 'imagemap_test_map_to_not_resized':
test/boot/imagemap.c:375:11: error: assignment discards 'const' qualifier f=
rom pointer target type [-Werror=3Ddiscarded-qualifiers]
  375 |         r =3D alist_get(&priv->regions, 0, struct imagemap_region);
      |           ^

--=20
Tom

--MZhUWsOKhZpCwBqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauTa6gAKCRAr4qD1Cr/k
CrbgAP9nsd35VSN6QjGsk9PnjGjJcExQr4bTHWRUUojzwD4nSQD+JDL8PVQwmk2v
Hhd2RhYJVBaj2xiT/niqiCs9KrsaFAY=
=8qFn
-----END PGP SIGNATURE-----

--MZhUWsOKhZpCwBqU--
