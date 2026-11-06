Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD98606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ml47w/y0;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=TQzXa48q
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18C75608C6;
	Fri,  6 Nov 2026 19:25:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aF-ovzI5LXr4; Fri,  6 Nov 2026 19:25:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 51CD1608B9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793993117;
	b=U5JZvE2LE+z7FxRVr1qy/SGG9FYSbCDiftRZcthQa0gim4df2+IQxGAzwGUpkphN0fAD
	 se/Jy3KbL/BfqZZO1Wh0laOdZysQnSZxfoJMhN6NGju9lSjoI/nfs1Xfqs5aPlnwD1sS9
	 XLcyMTfxn2HB47HG6VtAIvsfp2ZIylpmxHx+pjejdQqJs75OsGd/5bXVlOXdBw+Zi/KpY
	 8Rgw2pNpxh4LEDxGtQpq30wY79FPg/LlEF+/QcP1drSw1LdFX4iWqg+z+2Oegxow8wmMt
	 irJerUWI0AZLMwfUlk7AyxRXyaPeRgHw9T789SXBn3KBdl4RecH0FBuRGaDpijruAWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793993117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fpxY3nDlevXakNGjnXpA+3FXoTgAXji9hs+rADTVsq0=;
	b=Gl4E9j76ekOb+jmi9tllEPxkJPCgShQ585nPdJdspUeNT32DNkfZ9hxZ20WAGiTc69nb
	 MzoZi96QpfkT05sIIZD/2Qlc7lausQPX9blzjum1m8/4J4w+XkEYOkjvMSXe9nnBHI9/f
	 5Nw49zFDGn5km7wYWe9eQK3qhUvVdcjG2ljrleFEcR7J34ilzk/uFevmOXqZ80YgTG9hx
	 h0dL24Nvyv3s06bc4qfJYBI/aAUs9k0ESwnhY50dODsSSvr9TWfUkNCEpDiVlCVlyUM7i
	 EmVjvoLJtNnPWhfFdXWQL/oHYIrys7L0CKFQcbtfupfOvN91T4PWO88ltxaRZLWvNSg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793993117;
	bh=fpxY3nDlevXakNGjnXpA+3FXoTgAXji9hs+rADTVsq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ml47w/y0oji6I3FqGF/UBIT3OEU14IM/wJlSyQYKOu3z0KwiPoEi3TmpxS5rbp8Tb
	 R++0g86J+Vz2cQgIeDHrS803HTtCqW2QuwcbFDWf93wibPJ5dz9EliZGxyiyySBZhs
	 hfgpwsAPikMCKkhxnH7oRLycei0lOhaxSumODanGi5KbvrSo8SPJRMjqRs9RE7MEmJ
	 45jHB1xBc9BgFRU0Hdc/9Dnh9IwvZu4+rGQYDn1+bp7nBd4RRNO2OIbznOX0xxTo4C
	 KMu6KyA+CVmL4VXQ5P1qTwUUjO0xct2koRaybz88BbLKSR5MRSP7ENsehuUJuvMhDL
	 c+I9L8pmQf4yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51CD1608B9;
	Fri,  6 Nov 2026 19:25:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7616C2E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BF3281332
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:25:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PeSc08t5xRcg for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 19:25:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF78D812CE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=TQzXa48q
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF78D812CE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:25:15 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-55651e7de9bso473190b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 11:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793993114; x=1794597914;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fpxY3nDlevXakNGjnXpA+3FXoTgAXji9hs+rADTVsq0=;
 b=TQzXa48qXS3yeKXO6lvbsbqkYqsb5FgAbAioTUkDyTK7xDuhQfcySsA9z1cNQdeiDD
 k/HVOeJJF3SPZgWd2fjRot4rmrPuAdMrqmiDL7LDd33J59uz6JfL85K+PfKA0xxVCZ/A
 VrvjD8B7BoUM13bnLbA00C4Rq7q2hheH955WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793993114; x=1794597914;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fpxY3nDlevXakNGjnXpA+3FXoTgAXji9hs+rADTVsq0=;
 b=rgDNeJ3Qi2otVHtFrs++inSmtXPa6lYKs9pbnL0zT2+4XrH4nqDkoZNJVt1cmJCrVq
 0+fFuKFEoDEqc8VeLarw6+qTOe4YHKkjGinjO7d13vikJtxgQqyAT+kEfgABpu/uxcQY
 F/I+0Izo+EbMkYcZLHKa6GUdrByh0s+LrJ5Xv8+QGcUfV2kLopV04N6FsqxisdzVWxAM
 jIZYiOaJiL9X5uiTBIDj9k2q3HP5PBUOqBkcvHZ33fey3YEgH2lR83g3oXy4n6B5O5xq
 2+KxBoC4FSB0sqy7DGDSOQPVuz3s/dfxTzQK1e7H9PSYev6ifZ0YgUDIcqMWE4wcVJN7
 WZdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1R/eQVdSz9BumpUHKINM2TxDbji/qiVMQWjGcElyZNmralbNj20JIBq2KunDRkUuljJo+e88=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8JaimZq3RDiJK0V3h0y2MzKHIlaAg86wWVuZ8POLMkHgJo1pSv
 a5AcJspNOCrFNg+2Jlrpsjvy2ojf450E4+Jwn7jcBHtMOCuMDILnbEyBjs/y16xg4WZgfUOe2dn
 dulFp3gmETZMt
X-Gm-Gg: AYBFou3xtpJPPLcKnjVogtddwKgX1nkN4Xb2Y4StqhLE/8M+lf4vRw7RymHglgRyzPd
 1lePOgRpG3aDW2ZzGh+qe3c1aYeJ2nHqoPedGvXRZ9PK4tueBeVD4uPOtghOHWm/UkKSl+S2hF1
 tNZc1w5WK58tj4sQQsEjYAG+lszMw8wVVkDZo95b/UsBSMFfEH8fqYQsWtlccGIzrWSmcp6VMaj
 ZIbW4su5UK4rLGLqU8OnEG8uM334V6c76O7NrZsFSDbWIgnYhjITBN/N0ktYVz14K0YFq+0aMMj
 xg3a12WLt6RCyz3Cj+7cmm9f9fA/oWJnnDCPDJjPHH5ESRao247WmCXjRAWlbovF515YyMyVh3M
 usGnB35RhsKpJd8WLejHcxmmRpQWIyRor5DpUD+ZlpopJmxp9lq08Fn1Vtx4vjC3fCJaqIIAVpw
 +etfAKZ8q4RcPP9sRgdUya21kfSVSKqkQV2GsAa1KQph1FfUgKboGZVDvxt9XVIZ+oheg97FUkD
 sDSKb3IDLobijZpjGBLQDa5ZZMi6Bf7p48aL7LbZ3KCOywM1Rv7QAp/Sh9pOHeC3GLfy8sCrbFY
 VrWt7hfnXb5d+XsjlOp4DRSm2Qg5ZGDDKxRufNOW9I4nT1qv1Gt/X5LU7n8G51NGQtbNatdxJbT
 RHzb7SI0UD2oYALIPaZXGNBtgyaCND5GhAobXpAafSK9QJM9b3M2IqbFm6DuEtLWpenPivxbrKb
 0gP6/wWO/TdcEwb8mlR5dcuMjmffyusoppoyAkLIvhzU0LzHe/kVM=
X-Received: by 2002:a05:6808:6f92:b0:54e:7cf0:c0b9 with SMTP id
 5614622812f47-567e145b62dmr2744684b6e.64.1793993114254; 
 Fri, 06 Nov 2026 11:25:14 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567e7f278edsm2091578b6e.15.2026.11.06.11.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:25:12 -0800 (PST)
Date: Fri, 6 Nov 2026 13:25:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
Cc: E Shattow <e@freeshell.de>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] riscv: spl: Add BOOT_DEVICE_UFS
Message-ID: <20261106192510.GB3741582@bill-the-cat>
References: <20261106173439.GB3669968@bill-the-cat>
 <20261106191654.923266-1-urvashi.sharma@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="49PLipC0OV9jSiNy"
Content-Disposition: inline
In-Reply-To: <20261106191654.923266-1-urvashi.sharma@oss.qualcomm.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--49PLipC0OV9jSiNy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 11:16:54AM -0800, Urvashi Sharma wrote:
> Hi Tom,
>=20
> On Fri, Nov 06, 2026 at 11:34:39AM -0600, Tom Rini wrote:
>=20
> > Is it too late to ask you to pick up and make include/asm-generic/spl.h
> > instead, and use that for at least RISC-V ? The history here is that we
> > have a few cases, such as arch/arm/include/asm/arch-omap3/spl.h where
> > the values matter as the values match up with some ROM. We also have
> > lots of cases, and it sounds like RISC-V is entirely one, where U-Boot
> > itself figures out it booted from $dev and so return BOOT_DEVICE_$dev.
>=20
> Not too late at all, and thanks for the background. That makes sense to
> me, and it looks like a better approach.
>=20
> For v3 I'll add include/asm-generic/spl.h with the common list,
> including BOOT_DEVICE_UFS and with BOOT_DEVICE_NONE kept last,
> and use it for RISC-V.
>=20
> From my initial analysis, other architectures could benefit from the
> common file as well, and those can be converted in follow-up patches.

That sounds good to me, thanks for picking it up!

--=20
Tom

--49PLipC0OV9jSiNy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCau4plgAKCRAr4qD1Cr/k
ChSCAP0db9sq7hvcgVPZgZUwb3B9EoD8m6+1JMyJTPgnzon1KQD+I0gmLQsLxWAA
LQ10o6ZSxv5fwnSaMw8AinoaEIT9agQ=
=ugSj
-----END PGP SIGNATURE-----

--49PLipC0OV9jSiNy--
