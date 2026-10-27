Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC0606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tE+CV/w7;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=a7i6YlVQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79AE2606D7;
	Tue, 27 Oct 2026 18:23:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PTnw8eWhCkf3; Tue, 27 Oct 2026 18:23:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 641F260699
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793125390;
	b=QsDdkA1wAAoHv0cfPHyGPUwlSWTV3ofC0TL9u7J0uhZM8WD4E87ZFWcrsprqxHokj/a4
	 l1IHHDanH33gRPcAsnnwFPd/vl3A3JQQA8uniXX3n5PDeY24B5A22B6AvRaLlS/UsHY68
	 Q+ch9RX3j5gIrWWmGkCMNQWnzDtv/yI9cL9mOZ+mDgkwy+e3+cZht9aLjfWP/gwbsH/Fi
	 brAGTWT/lWCMvG5kjSDqSVR5QMpUZHCUr+M3eoHWCtQi17i3INw22lQopYQxi1ipHqcMh
	 sK+5H2s//Z4d58H8hrF4zM/IpUXcVIYkazfd9xU++Eme2lzBRbt4j3Y3z+TdI320bbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793125390;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d2ysAuHwxTgEv64sw94oBBUPFcHtjnlzzFewRK+8PY4=;
	b=OSyOEuuoWRIrls2jNA6AdIf+y+wwz0KGKqp3IKud68WPIkB1IRG49CR7VYCBc575UTPF
	 5gjjsVohYCNCeCdt51VgIoNvgczuWUuk9L+gffCY+5IPHdkAIKtsBGWgg4SRKShbhFGMP
	 7CGYD0baup/SU/cWQseweWgjqGhNqMVAmoyyuz1rnqhqbBTB8j0FcfimJMTNQdGrt/qHE
	 4Z9pdMNVomD4KtmcWJ4Yq9A+JUJO3SqPwfEdayuEIQNJIN0laKzj9+2fB2Jda3UZ1V9jI
	 /NzU7Gh+KvErwNgmAMbW+84DpXyLWZ9yTa1DVmwTkbu9n9QCZ+/tJH+U/ZX0uCOeoEw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793125390;
	bh=d2ysAuHwxTgEv64sw94oBBUPFcHtjnlzzFewRK+8PY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tE+CV/w7emt2lsutXgT4GbxSzdNPaMmoTNenxzHakTU0BV97hrS6l5uGne8OxESJL
	 Ydgb10IgCwUPIRGH0qakvd6iwH7ba4YSie9GqvjefAss7Rv8RH3ObgAs2XMWgfUYsx
	 zde5OAy8pWTGtHSnF+G9gUjvRhLita+fIrunh23m5i4S/da1LAU8i7bsTl6kxldqgH
	 tbVinRbHSBrnytCz4clQWivK7FPGo7MSS8ut0RGYr6R1XqRqCcL3gaxRGa2kpfoa/G
	 wvGVyvxfEzJiv6KKo7eIuMMBIxpXSTJssEILQQaAoceMckL+EX4ERLsME0CLuIxCFC
	 4zboxEx/ajv8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 641F260699;
	Tue, 27 Oct 2026 18:23:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B71F4D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:23:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D0194016B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:23:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U_GbWf0zGOW9 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 18:23:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 245B04006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793125388;
 b=b2dPetC0fxwI0M995byU31bzD0pE4ffGu7qd83kM1hbDydbTswZVCGocUd+0ZNA0pfj9
 SoZvfRODQw3pmeBmEKJ+PrEGxE9skGDBly0e1JemuELsAlOj70uKmcno92/wawDb8van5
 XFgSWq+9lxgq7qWjCpeM7TzZ1m48F16ueyuFh5n2+4+aex6hsDxOqgHaUxdZQK5fhLU2A
 2PLTwcNXkFFo0zo7hdpok+dt8BUqskjWdyMdybo2aNOlGCwuU0SrgX4G8+GmQ23glVjZF
 rM/G7XVfjdi+U4qZn5bgGKgm+U+sqM2I+veRZ6YNotOu0DqV4HauaoGMU/xgqFWSUQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793125388;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=d2ysAuHwxTgEv64sw94oBBUPFcHtjnlzzFewRK+8PY4=;
 b=ZjMpFKsZCvEjBEHV/k33S3GNzI/AymTeZSEMbmautvWH5tvBcs2aUYbkrbbBAQuJlxPO
 XZwyjlIwXGAlwcLN1dGnowzWZ0ssbbizSn8dqqvbw6fFT8mcyEcflHn5jV6KgRPa66NJe
 CfY45L9i+L+Vo7QhQcmR9697pZIpdBMWFfFU+4R8wsmQwEtxKHIQytne6HyAJo3QwC0UH
 TvH9sbXLFTxgn24FAQAM7tK5AX1PGoQM3+MO8jkeWUpUhwAyUY6eEmMpX7br6YEaYG6mX
 enQq0YaBD7NGCjvKnAst/YPt/92JWbpxJ+pqIFnynXJaO0P7gnNCnHDa4UiZ+GNn7pA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=a7i6YlVQ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::b;
 helo=mail-oo2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=a7i6YlVQ
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 245B04006F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:23:07 +0000 (UTC)
Received: by mail-oo2-x0b.google.com with SMTP id
 46e09a7af769-82757b1535eso60307a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793125386; x=1793730186;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d2ysAuHwxTgEv64sw94oBBUPFcHtjnlzzFewRK+8PY4=;
 b=a7i6YlVQbZKpi6f9JGwEkgx2PoJKgizCCgqvW96z7BRb+nnW2In+wAkRsqKwjLBIXG
 scQtptjMBbNPHlf2lo2DaX8fkuNbXdfMBDzmDltEVIvH+2cirfpFYUYXUizMUf05qURO
 4G5iu4GzLyoTfS7PlZ1UzBqH0ABtb5BHAD2GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793125386; x=1793730186;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d2ysAuHwxTgEv64sw94oBBUPFcHtjnlzzFewRK+8PY4=;
 b=MLSKc5CDN2ZW1uGkUyHMTQFAqNSRH3b17HI8p/o8weeYmtRUZbQVfnjXFyrX+D9zIW
 azmbqKVuFUzS5uzsQEpuhYamBnuTVbI/Kglr0S9jTMMX9tHKt7Kb+N0cZuMMO0f0h01s
 T7BssMb5Suy2+spMvk0iCNcCKjewDXiHF274PuLAqCoAWSsCein3907MI+7w39qCwG0b
 NNz+/KtcM5+ZX736RoJqkmvfYFStwpq9hEAMs85uan7IiVewfLQV6CiH9nE2qs52Qjz7
 QooTrkOYNJLR8maPYcg7jt71CjwZ76fCNB0gsx09J/mHn5jSxoRG7xJMW6TFGfzNapkX
 h+KA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxz4HlVRsXm0t+qhqq8jbtDRxgl5/qTXliLCBcpQaOYwotEPS/fHRnO5N7NH3IPCFEsG/CI0TA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLxEUksuT6VlnWopJjULqz9ZrKEPnvkJW+KqAim+ub2AZjmRYDU
 Mrsng+XKnbvIcVbbgiXkTDCBI0jpr4HJPfu3t8kRv9JBoVUTLdY2FwWXyZdjIiLWiR0=
X-Gm-Gg: AYBFou2YgVqn+Djk1ubUE3iqdiPBQxhING4oqkWTqAG6mePAgGbmIDUChMhSvpwthot
 fEoZ3vEyt69ss1v36qdfe8celTEp/hY36HNSgKWvoSSRHo2o5MBY3fuGr8emItWhU5XvmQTQznw
 dZYBoUu8lq/Eq7i4be+LVWT3ma3NUw4Njq8mGhxKPnI2VLgejhoRQje9vC/i0Ea/jlcpUTxZxMb
 pJknbeDwQzGmN5r06GpUv4rYUQ1XRx2RSEhzrAzELUEn7V8O/ier4F3TX4kUQ/MPkesoe1AGhWi
 mW+zzqIpqL6xYZfwGd6O1d7ABSN3LsARy8klTVAr0Zqok9sj01k4oPe7xvYn+LrwDoPGxQ2u1C/
 qzTI0rikiQhvMVc8icudbKqBh8dIfOQii95uRPpR91kVsZs6DJtit1XF4xixqVchwIhQnFmLO6i
 15a7Q7gnsAeSsotgRcI/cvpM0zs2vm87v4w6VdkZCTstxOpOBcKLtdQPIoG1QDQ0hfSjpuUBHa5
 GM0BNE+UKntVASfmt03Gu18oy3L78pyAeP8m0sKwooUWsHeJmY4j1NVLyINcQsqF43gPvyiThmZ
 qDKDL2c5osJcOsf0eXe98LjqZGTBh8LclVUTD5jqWxudolczKjopoaGsfIRX13cpRk3rx0cLMKS
 P0D49J7GbTcKwqfnJy0ieyVTd1mgPpBP+XngigmiDeP6xCv5DZhe3Y5JUPkzO1EndoQpQeHNVCR
 wVJZk=
X-Received: by 2002:a05:6820:6fc3:b0:6d8:462d:2759 with SMTP id
 006d021491bc7-70ba0ff3d29mr4973367eaf.90.1793125386367; 
 Tue, 27 Oct 2026 11:23:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9df06f1asm10677723eaf.5.2026.10.27.11.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 11:23:05 -0700 (PDT)
Date: Tue, 27 Oct 2026 12:23:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Eddie Kovsky <ekovsky@redhat.com>
Cc: Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v4] Add support for OpenSSL Provider API
Message-ID: <20261027182303.GA2414934@bill-the-cat>
References: <20260429180247.83091-1-ekovsky@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yvYGoVFsDgfL5cFZ"
Content-Disposition: inline
In-Reply-To: <20260429180247.83091-1-ekovsky@redhat.com>
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


--yvYGoVFsDgfL5cFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 12:02:45PM -0600, Eddie Kovsky wrote:

> The Engine API has been deprecated since the release of OpenSSL 3.0. End
> users have been advised to migrate to the new Provider interface.
> Several distributions have already removed support for engines, which is
> preventing U-Boot from being compiled in those environments.
>=20
> Add support for the Provider API while continuing to support the existing
> Engine API on distros shipping older releases of OpenSSL.
>=20
> This is based on similar work contributed by Jan Stancek updating Linux
> to use the Provider interface.
>=20
>     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
>     Author: Jan Stancek <jstancek@redhat.com>
>     Date:   Fri Sep 20 19:52:48 2024 +0300
>=20
>         sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >=
=3D 3
>=20
> The changes have been tested with the FIT signature verification vboot
> tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
> Engine library installed and with the Provider API.
>=20
> Tested-by Enric Balletbo i Serra <eballetb@redhat.com>
> Tested-by Mark Kettenis <mark.kettenis@xs4all.nl>
> Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> ---
> Changes in v4:
> - Add comment that @engine pointer is null when using pkcs11 provider
> - Remove extra line break
> - Add pkcs11-provider package to build dependencies
> v3: https://lore.kernel.org/u-boot/20260120164524.253188-1-ekovsky@redhat=
=2Ecom/

Hey folks. So I think at this point we're still expecting a v5, and that
should be able to be merged, yes? If so, is there some update on status
there, or some way the rest of the community can help out? I think this
is something that will really need to be sorted out for the v2027.01
release or a lot more projects are going to start having problems
building U-Boot. Thanks!

--=20
Tom

--yvYGoVFsDgfL5cFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauDr/AAKCRAr4qD1Cr/k
Ch2xAQDB6ZRS9U/ffTeLVtaz3FyeicPYyHeEbZMjSYqd7nhEmgEA2vxlYhLBHT40
r9E9N5Eq51eSohjp0vzpFkU8Nrbp+gY=
=dDAT
-----END PGP SIGNATURE-----

--yvYGoVFsDgfL5cFZ--
