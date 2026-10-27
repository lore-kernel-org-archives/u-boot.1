Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A01606A31E
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Uv8eUhxl;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ep61tVDx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB4DA40412;
	Tue, 27 Oct 2026 17:38:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 80XovknE29mh; Tue, 27 Oct 2026 17:38:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0ABCB4050A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793122731;
	b=cq6kyLnHLLevPpmHKOdkj8xqcUQsJIjfLrk6+sYgSyLEDHhJBi0ywxyV7n9Vdfl16y4q
	 g1At/N1SMiWwDwt4v0E1J6yF/vfp1sqUurXpA76L3MmBHzo81CFJ1Y0F+QYY/X3F+U1sA
	 asSP6Y+bMOTTFqTB3+paZhTouPAtftbdQe7ZOqvCFPWBh28njJ8ZSN3AASS8kTrKiOllU
	 o30nZ1O2X4Y3vdW1SfjW7Q0dDiq7Tx7cjmF+zlal0nMwqZ2IHpciHTdMKc0KAA+OXvx58
	 hOT+u6emlYEaKnkJNrzyZaYWtoD8iQ1rpFDQmCXjoxUQdJDM7iDOeEBdRq8Z0CGLDSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793122731;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FxoY90vvVd/1o8RaaQunEKmaLxCe3VxvfQbR6mtzCdI=;
	b=XjN44KTJx0eBb/pAJFR7WoO/KXAMkG2JLQJLLXdxuSXW2nce0K0jZPvKGkTwqBgsGaC6
	 w+8XQ4jWsOHw9ivniggy/zw1QKaaM8IlzZCMhQEOQ35BDPh9fsteCt3A0cubvQI7KAZR4
	 HIRcayvZtru/X6vWaG0o39s37g9VrQ3MUarGsregwkrxIQJGkhh20+uUNSQhyyxRnCnuO
	 7zC94ejxNr1DbflvIigQ5qFKQxfpqmePVeanoGYZgSKpb5d4D8hGUczR446B0f7LL9gF5
	 6+g6UxPVnRPacUT6i+I6RNqhEVGc8H52dBa8cptGdJQfp4htJVArQaxxPM8aKx+6DOg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793122731;
	bh=FxoY90vvVd/1o8RaaQunEKmaLxCe3VxvfQbR6mtzCdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uv8eUhxlbMfMKg2HvvWCgYh7o/O+Bn5osDnPcHAEHfugfTzn5ihPaKWOCMycNuN+2
	 vUgLxWYFR/QJ3H+iPj6DxzdhfqyxFFHtxDVo7kIpC78HSHtAzxw7B3lgiqXPGpYIuM
	 aSGVTlL+I4Ti3Et/m6ILllF79lddtpbko9hNAGOnhPGJlKgSgGrxOOKLSD4eX2ivqf
	 08Br4eqi+xVnKfYqRbfXyhKcwigq/H0bQGVhlNJwROthE6Km5EQwI/ES6Ll3R19S5P
	 hA7QIkZcbHNb8T3mmma2EXyi+CMEQPlTI+9Ru3ViMIxXIBl/XDpsZy0q7xclwohFgc
	 XMzgTO22EBHYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0ABCB4050A;
	Tue, 27 Oct 2026 17:38:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3827F4D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:38:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A124605D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:38:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ogogeZzZRUek for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 17:38:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7E0D5605D7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793122728;
 b=n6S258A3qJSflhkqCQwugvq/dJHlN+NY/WxBZKgg6QQ5VY/T0zw2jr0iJ+SyPEZC00ow
 IB7Fzl5dVILDZ6exY9TRIHSFxY6XMz1txdqk5PyslhwMXZLopFK095EBGi37MSr5G6Mob
 aFbHK05nN5Pfgu76K0qecft040Ci8Gs9vIz43mtt2C+QrqTVdqopi74+tGBaP7GULhVL0
 RVsWyVzuM1/b/rrOrlL9Ht1nqXtCoQMvJYhXqv2lik4Q2z+6aHZmhvGUdw95WY29viiej
 /kuFyTz4spA4eiUjc+6x+5XQVG45SzkTlzyzY/nQigFT0zqK6VarWtGTt+NkWuGL3nQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793122728;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=FxoY90vvVd/1o8RaaQunEKmaLxCe3VxvfQbR6mtzCdI=;
 b=Sm3c52gDkSp+H2bYgv/tsmxIqOCI/W6ntb+nucQp+K9sJMUtIea26dvTW0ruJzwWj6yY
 drb9C+VD8MR6ftuYlqfrWOaHnARM/y69j4I6755ujpsr4A/mP+JktBFe58W5rOh+x9+Yv
 Jq39PcNi89B+hPaXgdGOLP88m8+FlqABRox3ugkV1GN+S2xp1RydNsfspilhfUZc1TB0Y
 jrwlQ68Wt9LXv3QRekJObRWi1V2k8mmnYckUlvcv4UMwgpe2UV9306fiNBxfOVKJI2QFQ
 eIf+vp96Iyr/O8IWK+JdwWZijy4f+bulE+1lcXvls0lT6rkrBwNLISdd1wEas7OQm0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ep61tVDx; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ep61tVDx
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E0D5605D7
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:38:47 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7f48c750afcso89639a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793122727; x=1793727527;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FxoY90vvVd/1o8RaaQunEKmaLxCe3VxvfQbR6mtzCdI=;
 b=ep61tVDxh3GpQDBl+xQBBeorJbApfsndV17dyI6ieOqZno4NyH1I5Yo9HV+Ha4uv26
 WeSLwVvQCdLTFgunX1uJiAGbR61z1kKptzhe7k+eJUZTKTnhcB8EuZEZ5urER3MUZWmJ
 w4YIgn5UN1eHka/Q528iMG39iAuSI3Qfa0H/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793122727; x=1793727527;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FxoY90vvVd/1o8RaaQunEKmaLxCe3VxvfQbR6mtzCdI=;
 b=hBqmuvxfw+Jwad9W0z5kWH/6rEjcTkKlaayv83ZLDxCx688bGnjTPzskRudSx4lODd
 AJ0w5TSECpkdv8h1AJ5efb5we0Moshg92AseyZ9h3gQtTXnoBtje9kL6h90IlBhYhV+p
 Ho11Ta4ZyLiOrukkVxfWQpnDVPVzAcMbc5CcwZ7//PVUb4neiEsY58CZAxqVMllxYr91
 yykXfyzVVRhXUX963C8fOu7DXDuQbRVhjIaXX/rFNIHOll718B1L4Z9JeXIILyhpw4VP
 /tJOoavwQK/WagP2ZZx7f3Q4J3ibc8KXh+cgVKQvVD39s6GdiXbsad2ax90NlvVCOyp7
 aRJQ==
X-Gm-Message-State: AFq9FYK9ONopB8dktpFzVoTvm0KQ6Z9/W7egPx5AMXzUe4zU0sVXEccq
 csfBFw49J4okB6pc7/TAhsNOhQX4sNIZqaK0P3EuFoZuhoFp7DWaytlj3K/SgzkpsrE=
X-Gm-Gg: AYBFou0Vh+MqE+QCU+aQ3pD1oaF7ixAUTv7ueYStlGAAw7GWvG+dc4k98X0MCJpXk0D
 tQm0Cctlr5rP92QCzsZ3Swc92B2xcM1mPruMnka3Ds9BAXp1+mqyxlzSrRlRfQHrjwB/aGLIUoC
 VC872My0OwZigg1CpV8deVyZwXsWWLurj2n2j1ORZqGaZatwLYQAP4ewK9nCU1VpgFgIGF8uziN
 PTSJ5NKRi7UQ480sZ3R2pIgJ4lfQ62qKhK00uuQzaZisufPxoEUKah2D/1K+qdFpMTxkqs+9Joy
 e56qevuAj5qDy/dxq0qkvaVCUgWv62T9d/QiqhfVorbR3QHoKROnW9mekWf7VvVKVMu+amr6bg3
 Dovz7mf0BsOtS4FJs+PyEIU4PPWkZxSQ9UGnMnBChGLnjsQrhY5gcTVg3Dm+kjYcKlPqKwENS57
 fxrMxVx+T0G36FSIUecb/oY8dP9e+vQFe0i1GkfrOmzNS8wWNfdas5vPbr+yrrAxbLkzu5tWbK0
 UhRIKf7RJtni40XAnqBX6TqGBs+8b8iKjVHIAhXe3FDc9j8IJ/89/l3EB0ls87LJGoxSIpYNWf+
 B5cnbawdtS2fmqwM2TfGSH5h8MgrvsT2I6LNBsGrmQmhyPj2f9LbSgJiL+uXrgW+Tp4pq81mA5X
 tGfaOGaIdcQVH/vMZTfUFOFx5YesHuYIfjJFGFYxQMHWFe3L4d+hNXcQ/kQ==
X-Received: by 2002:a05:6830:6e42:b0:7fa:ac4f:79a with SMTP id
 46e09a7af769-85ac0af2d3cmr120924a34.22.1793122726840; 
 Tue, 27 Oct 2026 10:38:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fa99bd27sm11254194a34.7.2026.10.27.10.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 10:38:46 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:38:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Tycho Kirchner <tkirchner@emlix.com>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/1] tpm: use phase-specific CONFIG check in
 tpm_uclass_post_probe
Message-ID: <20261027173844.GI2177077@bill-the-cat>
References: <20261027163252.378154-1-tkirchner@emlix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K6ncc1TE6YB+ufJb"
Content-Disposition: inline
In-Reply-To: <20261027163252.378154-1-tkirchner@emlix.com>
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


--K6ncc1TE6YB+ufJb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 05:32:52PM +0100, Tycho Kirchner wrote:

> CONFIG_TPM_RNG has no SPL variant. With CONFIG_SPL_TPM=3Dy and
> CONFIG_TPM_RNG=3Dy, if a TPM is used in the SPL, device_bind_driver()
> then fails with ENOENT. Thus, make TPM_RNG a phase-specific symbol.
>=20
> Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--K6ncc1TE6YB+ufJb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauDhpAAKCRAr4qD1Cr/k
ChT4AP4sUaTdn7O1SGZG7YrByg1osL7QqxhKPQ/C3JMvNONCKgEAuMlSYaG3Ct1r
F1khg/UEWotDrrCNspRWz+Uamxc96gc=
=6Gyg
-----END PGP SIGNATURE-----

--K6ncc1TE6YB+ufJb--
