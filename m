Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10949606A322
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X91FiV2H;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VdUNvh1p
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 558E16084C;
	Wed, 21 Oct 2026 14:43:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dz8D_eGcVWgE; Wed, 21 Oct 2026 14:43:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6DA1C605E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792593828;
	b=Dq9v3YH3/LEDnUmbnAkTZGxN6l2QowqLW21tkdXrzZfUmUNS+kC2955QMPehDnzAf5WB
	 aBeJowBhk67JVMxenUryjo9vkJ2M3vnPIkXvoM58rPkUYzYHQ7fh670uVDY3KrkGQuA1N
	 EVDU0n4qLbR56avkZfBWTcemgxYDEWOHg1iqntJ1ppyopjhD1rmkJAVubZqjDPY10fwm+
	 lIm7gMKkoH//sE+O1QJLY7bfluZbFpFJHeF9nF2l25XNSYfKAlg5OXXJVLEoslYmVg568
	 wnuLRwoeoP9O2+W2l3FEu7BOd8fTRCu75Gq1RJUe9jXGZad20bUwZcx8gINQ/RTAIoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792593828;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Or2r2aHoMXFvXn9hFkjpmcYJydUOUdrOwpUI/Pr1zw0=;
	b=I105Yr3PpOqMFezUwINjpoAKXInrdYPpOa0SRimpNyB895dfXKnK+0KD5yut5Kamz4tq
	 tq8YAtJ4heza+F3BIULZsm0Lo/S/PEBXTuDeY2II8eASOzHxnsYZf+8Vzn7VUhkXWSnNc
	 UUEQmkF0ki6lo7r+BE3daX6Mbmo+V13tx8cWy5pAutFLgWxWNJhtu5bQRUjXAgh5UsoTw
	 6NNwsJr3KnCLxm3Vx4oG/OfgwDju/Pd5FDgLJzQL2oMdP9PZpKN/AS2fV7fnZ0wb94T/j
	 oowJkUeqj8xFojO11D9SDLobqfjc3MqJST7fIm3Y+cmOgXjM5mq/qvldE5scPUjFd9g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VdUNvh1p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792593828;
	bh=Or2r2aHoMXFvXn9hFkjpmcYJydUOUdrOwpUI/Pr1zw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X91FiV2HbMMwhevo0LrVee2abGOg6D2M61wIWbGIht+Qvwqe3XW/XegVf3oSm+GUr
	 FQcHl5xcy9YbpBMIpvweVe+uV5he+mbs11TU4/jajdp8e88clGVKtUyFZjrD47ugO1
	 LVC4vbzxqpJbPkDkvIsckopk9RXzANcdG/IjwIxCs2RU4iBuE2enhqNHOHA8jZIqGs
	 e0HrJh3mokUTz6q1O7qYJXOG5UEJS6qvvKhyBOqroTpkgDZMNZrfqRfQWVC020jBJN
	 7C8s0PAB7mF863/NZAvE5ZagXd2M4H4yIZ8nbb+cBsCFNzSTrSsvIt+2J4aBMOzCZi
	 fDUe9abCKspzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DA1C605E7;
	Wed, 21 Oct 2026 14:43:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AEBF63AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94268605E7
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:43:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NibChM7awiPv for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:43:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AAAF8605C7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792593826;
 b=ePWa7S0nGQ2nRftMYHe7M2IyyQNZLy069kI7QP9qihta8+3p8FYw10kx/Y22uyt7V8E1
 hP3t5D8l2pBw5FLpiNPV+yyJxXclfuYYz4EUsn+GDVggP/D9Jlw6bhtf1a47OYYeJFBtN
 DHrWznqf/x+DL7zaS9BPFobmPPJbmvWNUObwnWCYKuEs5Fkc0hFM5s+NVaXwDAZy/Oht+
 u8D5kyteVKI1yr8/PqR7/VQAORz06Jzv4K2VstXfPhCT8CNGiBqrcBEv86S53HEbPNSLh
 yHe0UGslZ5pzS+wzraXxNC/GHc39fFcXJzaIo4RQ0RPBfrQlCbU8LXRZ/0/dQ7AYcUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792593826;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Or2r2aHoMXFvXn9hFkjpmcYJydUOUdrOwpUI/Pr1zw0=;
 b=dKBM+5NdAqnLeyoxjbii02UPSlCe0vJQ1uy2mgZ2vi9nv8hQoWfIGOHEgXsDvQucdsZr
 F77YZHAnHy1O/sM+apwaoYrvj9E79VWLAzTe+dZLSwnzjpzY90+mXSa4U9m/zB8RIx4Ql
 aLHOLyLMHFcFveiivNi942RNpu9WqNVouSMP5/UE8Yc55p73qeb414GGHX9B+kcv6nyS5
 7ZgWvQBNMJ+Q91pqgx7VzQ5qkqAopGkM05MLzbH5CJU662iynD+7XvtR/RfwWFuRRov0f
 OuCxZigY4mQ5Ag/p7QRn2Plf+XkUbQxsUglr54hIaZh+BRI7FAmYglNjSLCRj1+525w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VdUNvh1p; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VdUNvh1p
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAAF8605C7
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:43:44 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7fccba9c675so2540013a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792593824; x=1793198624;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Or2r2aHoMXFvXn9hFkjpmcYJydUOUdrOwpUI/Pr1zw0=;
 b=VdUNvh1pnIzJBb85TRDNWnZ9piV0mokzt/0qHrARrK3LbHUesesIGWd42WaEQNKnv3
 SH5ZLOZWLwIWLwcFrDWamNZi7jlar1vZygJPS6D1rm+gUO+T2FDu8LgEGaeCE1tdZ7lD
 XK8JVLC/dJE6UbJpmlnNsnxa6DFXrOrogjX3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792593824; x=1793198624;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Or2r2aHoMXFvXn9hFkjpmcYJydUOUdrOwpUI/Pr1zw0=;
 b=iggnk+blAZnRWVLUO58MAkMbDKcIbw+n6bRUyHWjsAeQUicO1zVIhkoW5fSBnAV/CI
 D0fIovc8zhKqGMcVaCEQb5caEXIqKztNctryMeD2Gsayd9qA62yY9AX2XvNlEAQo0uIH
 co4AgCbon9mmoPUwjnxhKbmp7EtI10INSG3sV4O7mJnRWFPsOFHmkxu8VKG5Pmr4nEkd
 ZLUHV/L6LzzHyKzFl7zc+uX3Seo5a3801SyIL6bHofjkZcNfK6+tr2U1Gx7avnNgHSHP
 FRtLtFfET6Mk6IjG/Hh6nfrNPfGL/H+kznxkDKb9Iy0MfFpjbjZoD8l8fdb9D8YYkxFy
 O0JQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXcmiUvXlQSAYlnNCZErw+XIwWXpijBC217sCm7R09gyYo3DZ0OJSZsZi9HlGdTXFRFZRsgrM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKWX2+hXGPZneW+54i41O28ExPYAU0o/8dd51FMHJIV3AsiIP9c
 ng8CguvohAHp0N+hqMZ/Z0cSSw2Ecw4BqslFLALJbkWqKW/2PmTb0Om5pPPRIFGuxs4=
X-Gm-Gg: AYBFou0QazruGtfGC/N1BKCAzPg/bMy2/xlaaZD9BxQQDLrWefSi5u5EAfyPi4CcXJ9
 Wjv/ECe6JJOfvkaeZ0hiQNw9v2h98PG4jkKQxukgPeYGjmRV/gvhLSS3zmpV/4fT4ryF2mafl71
 7RYLxp1CFEmAwEtQnCrX4rOkEeSl6CsjxuAGrUmSnU6vMkdUYp/XTOmQ7odpEJdrLB0ZPamrmXb
 DhwESyWe6A2Y3hhHl/Ifggb58uZpZwDiW1UeaNdYM/NHlfeNj6J84W7Lwpb+Yjun3wn888fGdp6
 YLjySL+yXoOs/rLvFNWsXesdrYSlQU6uR1AJqIa03lCdPZBnfGolE3NS5ewapUiSlycg42kyWk9
 qAdhvuU8UX3ZA/KqmFrfkaaoFAahbdtu8A2fo4A/nMTsUNLYkjaCqizZfRTrpsMXBkiE7ttRwQa
 Zp0/s4UwdHEb8tkbC5K1P7EJcjaNnvH3ByEcXUT5k+FWZkyoJtZ5X2pU0OyILBfFgmrf6oixxUV
 UJ7xziVDP6QP58g+E+N3gle4oPUEz0hbX9J+JYKq/WB0pLFEl4g41iQJPCBeYmolXDfXKtgA/SN
 keEEKDX/zMKXRyW5iUTh17TCEcN5sjEMsrlGyp1dHWiwhQG666CckolCLBD4dxsa61J1M0MpdVt
 4
X-Received: by 2002:a05:6820:4def:b0:6d9:c309:6479 with SMTP id
 006d021491bc7-707bdb0ceb3mr2977484eaf.58.1792593819061; 
 Wed, 21 Oct 2026 07:43:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbc7d9afcsm2386327a34.6.2026.10.21.07.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:43:38 -0700 (PDT)
Date: Wed, 21 Oct 2026 08:43:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, ilias.apalodimas@linaro.org,
 marscheng@google.com, eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/4] arm: Add Google Tensor SoC architecture support
Message-ID: <20261021144336.GN720525@bill-the-cat>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
 <20261016040216.3636305-2-visitorckw@gmail.com>
 <CAFLszTgxQdAq5Q0cFM4yHLt_mFnMWaUWrUgaWOv+cYTjzZUXUg@mail.gmail.com>
 <atiCtIU2JWtiQcwU@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ww53ePC++oV0wA5n"
Content-Disposition: inline
In-Reply-To: <atiCtIU2JWtiQcwU@google.com>
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


--Ww53ePC++oV0wA5n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 05:15:32PM +0800, Kuan-Wei Chiu wrote:
> Hi Simon,
>=20
> On Mon, Oct 19, 2026 at 06:27:33AM -0700, Simon Glass wrote:
> > Hi Kuan-Wei,
> >=20
> > On 2026-10-16T04:02:12, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > > arm: Add Google Tensor SoC architecture support
> > >
> > > The first four Google Tensor SoCs were offshoots of Samsung Exynos
> > > SoCs. Starting with the Google Tensor G5 SoC in Pixel 10 phones,
> > > Google Tensor SoCs are of Google's own design. Add ARCH_GOOGLE and
> > > the mach-google directory to support this SoC family.
> > >
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > >
> > >  MAINTAINERS                  |  6 ++++++
> > >  arch/arm/Kconfig             | 21 +++++++++++++++++++++
> > >  arch/arm/mach-google/Kconfig |  7 +++++++
> > >  3 files changed, 34 insertions(+)
> >=20
> > > diff --git a/arch/arm/mach-google/Kconfig b/arch/arm/mach-google/Kcon=
fig
> > > new file mode 100644
> > > index 00000000000..a9e605ebb82
> > > --- /dev/null
> > > +++ b/arch/arm/mach-google/Kconfig
> > > @@ -0,0 +1,7 @@
> > > +
> > > +if ARCH_GOOGLE
> >=20
> > The SPDX header is missing, and patch 2/4 adds it to a file this patch
> > created. Please can you add '# SPDX-License-Identifier:
> > GPL-2.0-or-later' as the first line here, and drop the leading blank
> > line, so the file is correct from the start.
>=20
> Ack. Will add.
>=20
> >=20
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > @@ -2252,6 +2252,25 @@ config ARCH_GXP
> > > +config ARCH_GOOGLE
> > > +	bool "Google-Designed SoC family"
> >=20
> > "Google-designed SoC family" would be more usual. It is also worth
> > considering "Google Tensor SoC family" since that is the name used
> > everywhere else in the series and in the help text.
>=20
> This prompt and the help text below were taken from the Kconfig in the
> upstream Linux kernel to keep them consistent. It uses Google-designed
> rather than Google Tensor because Tensor G1 to G4 are also branded as
> Google Tensor SoCs, but they are supported under ARCH_EXYNOS.
>=20
> >=20
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > @@ -2252,6 +2252,25 @@ config ARCH_GXP
> > > +	select OF_UPSTREAM
> > > +	select POSITION_INDEPENDENT
> >=20
> > Just to check, is POSITION_INDEPENDENT actually required, or just a
> > convenience given the BL33 load address ? Forcing it on means
> > downstream boards cannot opt out. If it is only needed for the current
> > defconfig, 'imply' would be a better fit than 'select'.
>=20
> I'll change it to imply in v2.

Don't change it unless there's some reason you'd ever want to be
hard-coding the address.

--=20
Tom

--Ww53ePC++oV0wA5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatjPmAAKCRAr4qD1Cr/k
Co4KAPwI6yoa8W77S8u130VumBiueTzVrACtGyqofcZqQfnv/QEArPtOdisYlxe0
hWWlv1MQbwgzwuKR4ztledaBxJUXJgM=
=pRYw
-----END PGP SIGNATURE-----

--Ww53ePC++oV0wA5n--
