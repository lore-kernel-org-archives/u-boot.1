Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF65C982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 17:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C598981324;
	Fri, 18 Sep 2026 17:53:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 52beD6p36aOT; Fri, 18 Sep 2026 17:53:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C8F6281303
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789754032;
	b=OnqPufGycOTQe1IriG4ivLJlJD9yXXczp5G6R2hmFkm14QLXKBS3iY8pwyuN1rKI3Oh7
	 sYHlwfYwCkslhNwAbt1S0nq8dnDMPmz6ecui5jteCX5KXjb4KEUltzcEsm8JuEtrqPIsY
	 RLoMj5KytsmZNszPOlWjHCk8TQ8IpaKgSNil4i+8Dv0xAb3fxuvL47txaNDm+yEd8yfG4
	 y858EZ7n0SQcLU+Mvk5sqj/pNNGYg4rP5z9HBlK7+zBjmjS9Jc2OPy7ZMJXmNaYuBAobq
	 j9WDGz+d0ycGxglosKe4g4B3WtLmpag8zRZP2kHeldHkVOO3fKsJdTuxB66VqfruTbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789754032;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3NG291JIqqB+P/mE0+ZxRuXPN9gR9+ec/9pd83HCCK4=;
	b=hle+jojSTWbCpjPKHXIfbMwoMCEXTG7sAxJeV0WKe2VbFn1K0h3CuPC0GrXaztj1ZNqp
	 7f0u+eZvx4vrBHhCNBR6l3F3qQq/L/D9RcrYmXQMYs9qtp9tcIIxO0U+9Z3jSc3yDQQFr
	 VGIGJpu25Xbka/76jYbI1OKTtlgAPcFYNDWs4A7Z9GSyzXkABmurKN/YQXctOHBtLmKJ+
	 r+utYqXw83TUg7841v6evFZbqFdiNCs2vWPttWx/u+6bliapTlmXXiBtIitXar28U756l
	 VnudwmiSy1gJxBa8spEYbN5W7aab55b/ECRJwZDE6CRlMHunJ4nnFnvhFaLO4J+bAxQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789754031;
	bh=3NG291JIqqB+P/mE0+ZxRuXPN9gR9+ec/9pd83HCCK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uoOD0BRNQ5BrX3tgNR0zuirXdRazuREdxofmmqkVvFtRboVkvbBMW3cKI34zWPJsz
	 uHU4Ey9xjXNRw3ehGn2Z50O5hpGWMdL5sk0wDyZq9pQp0fULoQ7ZVzdHHuIcHjxlyB
	 WVJwxHXnOFAjxO0pqtIHQb62jKbpCwfeQg1FCUSJgvUt8Nvai1lq61HuiTJ4llpCWj
	 naDlh4TzQXTkqQdT8UjV8nlC6NKb+TccyQfydHEaFdRBpshLcTFQpJ7of2fjKe01Im
	 aFXxoMKsuK2OJbRfrRMteiErfWg6NAC5Ta3uGUDZL0CwqxJGu6My7MSZVlLVsofT0P
	 cnf/kqd/5O2AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8F6281303;
	Fri, 18 Sep 2026 17:53:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B1864237
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9759760D86
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:53:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KI49--AVUjK3 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 17:53:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9BC4160D5B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789754029;
 b=LUP9pkBSTdvxnpEb+ZyLpdFLp9ZnBHuJ4F5otJUQsWtI8X7QL4cgcRRPxcqF6iDIuKbV
 otR7h0nTPQPmQ2+RXCLadY/VX5MU+KqX0kSDhbnSf6e0VkAEUKHTlkTts51fk0TzxZNN5
 ULgFbHpkmd7WGdGQeU3582fmlFk0/WFcqTZEBLeIvMOATTVArdyo+8oMfUpGNE60iap0N
 IKfKE8R7m3ZBqmAOP0v3r6qd/kATYdcdq4iaK4mrtbm+aNI0AEULS7DXkGw0kR4TmKLVE
 FDXJTp67p3RUpme2pUxXoxw2tUHBqAAa22hkiHRaSc3B32XHFK0S+GDs6btdwzM5yxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789754029;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=3NG291JIqqB+P/mE0+ZxRuXPN9gR9+ec/9pd83HCCK4=;
 b=iiNjI8pFdDmaJ5uGeNcUJoZmE5YNdq7Hil1kEnSw4nk2JaLla0nP2irUcGTrjyo+spVz
 RdCkAZgSXFIA/Zy6S38LxNf+g3pie9gUxgNmNa6YcxtmL+Bw7EqV8aLRq7Myp3ZWznjq3
 UIbGH3b0cxLfdDwm9bM6CRxy6BVFojP1St6l8zqxapv6MghGiqmOppCYmOCOHdzm3aFPa
 h9Um5y2il1RLOEti3lnJRsfJD2BeydtVPI6QriSHKv//sgQ5zqA8d0WJzTmcjX0tf+GHR
 0fz7MmuevbkEDZiB/oBBQs3ZLJOAewNQwXYiX7hwl9vl7OOgiAYBrDHsMTy+ai29r+w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=SzUQR4Lf; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::a;
 helo=mail-oa2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=SzUQR4Lf
Received: from mail-oa2-x0a.google.com (mail-oa2-x0a.google.com
 [IPv6:2607:f8b0:4864:30::a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9BC4160D5B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:53:48 +0000 (UTC)
Received: by mail-oa2-x0a.google.com with SMTP id
 586e51a60fabf-47bbb846425so483103fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789754028; x=1790358828;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3NG291JIqqB+P/mE0+ZxRuXPN9gR9+ec/9pd83HCCK4=;
 b=SzUQR4Lf9xC0P3uXChP1YQ1GDWXhkwnbjlrSIIWeDUKUdtflpHoN6Zh7orqH1RPpVU
 N04G4pUoK321Sc0XTyiZ7ZQneTPAZjJPY6mBL+e4DshOg/bMMCp71tz+DRWkB/vx8/Jh
 fwUwnyGzCcNkFQzlFsvy/+UIPrENETOwU0o6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789754028; x=1790358828;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3NG291JIqqB+P/mE0+ZxRuXPN9gR9+ec/9pd83HCCK4=;
 b=OQCJ6Rs12LFXZzfsKCmwHysxeUDIxZcFRJJLRHe9fywx0ZTQLqnilbrMpwq49CRP9a
 ULzjJz75LLaKLuRvs2ZecrxLO5N21SLx5eWiFB66dmJRQpBguqVIovfQsEaHos9I42J6
 wK4NnsWH1Ehnih9NHXzD/44R8mLW8PUBESuzDIxSB5gVaJAsV4NrD6GAHL0KO8pu3KV1
 m1WsCaVz2uxZRFxb1YMxbLTJBMwWxWZbGVQlQZjIqpIaNWw182IjeYrmqzOQTxW7BJCU
 VyaXKxuJVpYXBQmxcltwyTAGAQLj3xeux1rQ9stlDMqz1tEhrl6gDCZ0vSFD+wew/lr/
 PxSQ==
X-Gm-Message-State: AFuF++mOV27kssHw7vh87/2wRml0ebn8yvI0wvqbCbeoLrJHbUky/MjN
 AigFWDCV2zvvkVBHy/DnDfE5VodmaBpPFaZErU7Kx4qnrXN+sz0Ix8k6e52yBacfpeI=
X-Gm-Gg: AYBFou2sOvWjRH7C9rpmSUlIdY6e03wyiK4VBU+CYRKZGDTK2HX+v6RxHYTIAQMxl5J
 IUPaSZ32f2KiXu5hFsWvN8c6eQsDJO3x7oMCPWBHR9YjRUG7zfkMUMBctXy/H/l2INHLUIkVQ6n
 hfPK7GQr01tZ1Tr+j/L/93jXLa3NkCcM75vlZy3YER1n9AQMV2S+kTIb/AbJNXIIePn4mQzz8AB
 v7vEKXFX4zRI8Jw+xkxWtGSWgS5WPjiYs+qMPUGTl1b7vv8UdnHL1YVebTv7iNtcml7hfy6OFXC
 5ld5PY0wArHxMC1kUIv2nvTcBQlt8s0eVKfgPswVc1ogPuMbHJSHqaHk1zWNjJxHxry03XBunIw
 AhjeybNIKwLcFPTHDwlQ34v5g1q5bhb6x7inLfIYjC41WOOTjbg3qiKfilVFvE02ltZqSFs4aTJ
 Ggk5ZCkvrsuUEjAaV7UHc1+PrZyywx26ysE2EpcBfVijaiHIumfX1XFR/OhRX4pLADzDeAIJzYu
 MVG73C5trQMo56xjet7LIJ/o3lsCz73gO+FHfiJDDSqoY9eE4aCU6wzGgy91G+9i2R31q0QJqlt
 awuBp4EoPsYTEiWZmMjUR0ioCcpIL9g=
X-Received: by 2002:a4a:e909:0:b0:6bd:b927:673d with SMTP id
 006d021491bc7-6ca9a134a29mr3081776eaf.13.1789754028013; 
 Fri, 18 Sep 2026 10:53:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd34b3101esm512854eaf.6.2026.09.18.10.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 10:53:47 -0700 (PDT)
Date: Fri, 18 Sep 2026 11:53:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Ayoub Zaki <ayoub.zaki@embetrix.com>
Cc: u-boot@lists.u-boot-project.org, mkorpershoek@kernel.org,
 sjg@chromium.org, ilias.apalodimas@linaro.org,
 marek.vasut+renesas@mailbox.org, pbrobinson@gmail.com,
 dlechner@baylibre.com, hs@nabladev.com, xypron.glpk@gmx.de,
 heiko@sntech.de, raymondmaoca@gmail.com
Subject: Re: [RFC PATCH 0/4] crypto: add FIPS 204 ML-DSA verification
Message-ID: <20260918175345.GT858934@bill-the-cat>
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JbGmj1/ZTZRcCngL"
Content-Disposition: inline
In-Reply-To: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
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


--JbGmj1/ZTZRcCngL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 06:21:23PM +0100, Ayoub Zaki wrote:

> Classical signature schemes such as RSA and ECDSA are vulnerable to
> attacks by sufficiently powerful quantum computers. This series adds
> ML-DSA verification as a first step towards post-quantum cryptography
> (PQC) support in U-Boot.
>=20
> This RFC adds generic verification support for pure FIPS 204 ML-DSA
> without an external message prehash. SHAKE hashing remains part of the
> ML-DSA algorithm. HashML-DSA is not supported. See FIPS 204 Section 5.3:
> https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.204.pdf
>=20
> It supports ML-DSA-44, ML-DSA-65 and ML-DSA-87. The implementation is
> verification-only. It contains no target signing code or private-key
> handling.
>=20
> This series targets U-Boot proper. SPL support is not included.
> Verification allocates approximately 8 to 12 KB of heap workspace
> depending on the parameter set and ABI alignment. This excludes
> allocator overhead. Any future SPL integration will need to account
> for heap availability, stack usage and code size.
>=20
> The verifier is adapted from the Linux crypto library implementation.
> The series preserves the Linux licensing, copyright notices and source
> provenance. Linux facilities are replaced with direct U-Boot equivalents
> where needed.
>=20
> ML-DSA requires SHAKE128 and SHAKE256. The series adds generic one-shot
> and incremental SHAKE interfaces backed by Keccak-f[1600]. This code can
> be used by consumers other than ML-DSA.
>=20
> The public ML-DSA API accepts raw FIPS 204 public keys, raw signatures
> and one contiguous message.
>=20
> The tests are based on Linux KUnit tests and cover all three ML-DSA
> parameter sets with valid and invalid inputs. SHAKE128 and SHAKE256
> are checked against FIPS 202 known answers.
>=20
> Validated with sandbox and qemu_arm64_defconfig builds plus the SHAKE
> and ML-DSA unit tests on sandbox.
>=20
> This series does not add FIT semantics or mkimage signing. A follow-up
> series can add a generic incremental transcript, target FIT verification
> and host signing.
>=20
> Feedback is welcome on the public API and Kconfig placement.

This is interesting and something that does have to be on our radar. My
first question is, should we not just update to a newer mbedtls release
and enable their SHA3-{256,384,512} supports, and anything else we need?
Then we tell people that need this that they need to move from legacy
crypto support to mbedtls (where we get to leverage a wider community
for security audit and response and so on). Thanks!

--=20
Tom

--JbGmj1/ZTZRcCngL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaq16oQAKCRAr4qD1Cr/k
Ct+VAP4x2d96j8CbwCtELotBuBQ0treymyoh6S7FaZ9YHlCMYgEAixjsLj1+9vaS
FKn8CW4Q5G2AtkERnw3sf4/4fdVaygc=
=y0zv
-----END PGP SIGNATURE-----

--JbGmj1/ZTZRcCngL--
