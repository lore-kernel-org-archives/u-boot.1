Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38482C28B30
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 23:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B236C8205A;
	Sat, 15 Mar 2025 00:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fNOAZ3r8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DB4A82063; Sat, 15 Mar 2025 00:46:17 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE60B81F7E
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 00:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7c0892e4b19so308172085a.3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 16:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741995973; x=1742600773; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ylj8QcuCmc0LuQqhP5WHV6Rh0+pFi4VLyx/F7lgduEk=;
 b=fNOAZ3r8hV/vUM6sozJ09l2vE9tN2sgXz61O03cUmtO9hJxjPLj+lgAGZAElYqOl/E
 H+BeVDf01Wh9k/tQdnAWpdjEGc9X6whO65RZc3AJcAQw2oNvLc687FKH7gob3ed5Uyie
 Omftytr5YnDXLDPCAyAvC9p2t7FjriXMsdCvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741995973; x=1742600773;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ylj8QcuCmc0LuQqhP5WHV6Rh0+pFi4VLyx/F7lgduEk=;
 b=XXPXXUpMO1jvRJqp3H+b6chq54DVxSOZcGpUnKQSQKndBHiQx5b7pav2t8xgJ/oEQc
 8MtAuKpTfQKs5ac6siZSQVA42QhAo7O4Fq4NQW8BYfSN6aZL35NeKvmgDJvKycdZqsWf
 AFMnBQOl6Ysii1i5sLuu+JDYArRi7A3JNWtazTr6G30J57MxbB/Ul0o0TxUNwod3CgHB
 SBXQZbX+6VHvllzg1E4HfAfsN9lDWQEeYoadVHohdj6hLMN8u0hwSlTWud+HVANP0zL0
 ctlUq7bw3jrCs89YKe6GaAYJlClZIBPsE8FQz6LEpHTYrq1Boe6XJCkUtir0zC0aHWcn
 u4vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWajR1CEQTTyA8z3qX5FTLb1FvuOSeFar8L8ptiqelA74eznyj8Udei5fcRGryWDxQxOw933H8=@lists.denx.de
X-Gm-Message-State: AOJu0YzQaHjf5ifNUGb6IySIyVetacJD4IEJUR06yVpPnA4SHO/+3gTi
 GFUj5+ozjVrSBZh2XZHMYAq3QWVBMwqgd15DFLCtAnuRD5u49S1CYyTKMBE6nG4=
X-Gm-Gg: ASbGnct1coPfpb8giJiWn6NzbVC2qQpxZ6r/AeSxtEGY7C58wyNXRimgC/lXL8zz8DO
 /G9QC5tFRHoBZBcJOgTNA9uOLunvsqOppKiWRjw4cMofA7OHJiGbVSNJxRDICQVWbHw1vsoE4b9
 j9vb2RslUJRYGqbE8Ow0D4nMi+rXJllJQgGyGaHkLVlsbM26Hh1Un5WS/0J8Yr/RqoiuV6f1hN1
 KKxlkOpQUi5aJxxtguRdMmFZvUMCMaurt/NkLUPSjFMBL4aV56iHwb5wYJKsIFHhlDJ70V6sdXv
 HMTGbj2BAUwK2HRLHUXea2+IynIqA0mv+cxvY4IO5QKwaw==
X-Google-Smtp-Source: AGHT+IHur0mlovnFPByQkQpeBIbHsNQH1+gvaAGBrct3wsHH6iB/DYyHb36HdVd5S2uqGJ/0C5mzWA==
X-Received: by 2002:a05:620a:6402:b0:7c5:65ab:4ff5 with SMTP id
 af79cd13be357-7c57c8fc40dmr702918985a.45.1741995973552; 
 Fri, 14 Mar 2025 16:46:13 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c9e081sm313941385a.56.2025.03.14.16.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 16:46:12 -0700 (PDT)
Date: Fri, 14 Mar 2025 17:46:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Ben Schneider <ben@bens.haus>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de,
 ardb@kernel.org, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Baruch Siach <baruch@tkos.co.il>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] lmb: change the return code on lmb_alloc_addr()
Message-ID: <20250314234608.GG2640854@bill-the-cat>
References: <20250314105703.277315-1-ilias.apalodimas@linaro.org>
 <at3MKdVWObOe2t0ulEO_390BtudxQ52-_iW2VGgpz0spI-UhNxRfC9TCtcUduXUIHSuBPt7vTR3iC4bOhT1IZTyI9hKIrHhBt8-82P4PIqM=@bens.haus>
 <CAC_iWjKGxqF8L=3r1-EuDN=Jmb0rPV+-54+g7x79m8dm-4o=yg@mail.gmail.com>
 <OX9trAy3JSNd8o9Ho8NejmCIh32WQR9El_tPJG0UAcHsn_TB3VsPbNFz2l5E0hXPExObST2VM91xgLD5Ak1AvY3xRgQQEHz1LZCwadhyOYI=@bens.haus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ytVRYP6sjbqbj6w1"
Content-Disposition: inline
In-Reply-To: <OX9trAy3JSNd8o9Ho8NejmCIh32WQR9El_tPJG0UAcHsn_TB3VsPbNFz2l5E0hXPExObST2VM91xgLD5Ak1AvY3xRgQQEHz1LZCwadhyOYI=@bens.haus>
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


--ytVRYP6sjbqbj6w1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 11:26:59PM +0000, Ben Schneider wrote:
> > Thanks Ben.
>=20
> Happy to help. In case the context is useful, I wound up here
> because I use U-Boot to load systemd-boot which then, in turn, loads
> the kernel. Unlike GRUB, systemd-boot does not provide decompression
> and recommends using EFI_ZBOOT[0].
>=20
> Perhaps it is uncommon to: a) have the first good memory entry
> start at zero, b) use systemd-boot instead of GRUB, c) use the
> compressed kernel on aarch64, d) all of the above? :)
>=20
> Thanks for everyone's help!
>=20
> Ben
>=20
> [0] https://github.com/systemd/systemd/issues/23788

Oh interesting, so now we're at 3 years in to having some form of now we
can decompress a kernel image again.

--=20
Tom

--ytVRYP6sjbqbj6w1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUv7kACgkQFHw5/5Y0
tyys9wv+MvpQebwuIEKYw8fwc3R/xqUckU0CdaBfbHIh42vk6pZ6CIge2IvEP5rZ
A3rkd3hHAOO/TIwNegObTbD4VZ96FEHbJIMlQHGL1hl8Ory+njBWlVkSkMnnHuh8
6fbXb98S3575nnBaG4kkazZHlBG+8r7XWsHKFBgx5fyey5XBtO4FPdSxPvHhN+7z
PCu2IILiEVztqfrz4ff7jvht6ai+dAFv+xcgoyFVMU/fcXiGls01eVTM/R2tVvPK
lkJ6nPE8pmRqKFuRWsD/egyADUXxUPmVlCm6/ZUUKksc8iGlTYcBkQu6mMI1H6KA
biymOYTSUXWUg0h9qxtmOnaJPxPd99ne8LqBQY6iYZxGmNhK9ncRu3uZKLPx2v0u
Fcarpjfej4b2vReynvvMSH3L8vW3BMrqyY0zxppLhqTrKurMJqxknSkoy01wh1qb
m2nnf5o9ihA3sD3aHs1CNZxdHuVzAVipGO5eksOb5VDCAXxrsrovHedlUxN2mW56
CmiLKECv
=WQLJ
-----END PGP SIGNATURE-----

--ytVRYP6sjbqbj6w1--
