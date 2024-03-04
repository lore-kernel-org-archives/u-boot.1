Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696D9C54E49
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 23:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02F6787FC9;
	Tue,  5 Mar 2024 00:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nwcM194e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E18C87FCA; Tue,  5 Mar 2024 00:44:11 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 921E7871C7
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 00:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78833eb8fe5so15812985a.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 15:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709595847; x=1710200647; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AuD86H4DcMw3QjsOh3HRCyWn5vt+dhqB2id8jVde2cQ=;
 b=nwcM194euTfWcOZMNxCsThRV8TIHd/h+mxMKibCIslLwfW8VjX0W1j2aBU+rIbzdvu
 WFAoawip/rG5ubVt95tU/NO0nYi5uPBaTMx3NCSThvsssx7MoT6oXCQwaL2AXGb7WZ6v
 E3OkRA7psnxgJ8RCIWoRTmFT5ZeBXI3icBz9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709595847; x=1710200647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AuD86H4DcMw3QjsOh3HRCyWn5vt+dhqB2id8jVde2cQ=;
 b=htSo5//vG/ZD7Ediref+CobcAX2q4bQa4IKqfw1lv1d7dztF2yfXMPBgaysyUkL547
 haSXdOXKvF7MQ5fPQAeA+qeIjWyYDFP1TTZLQrbVywYv5g1vVAcLXW6RYzpfV/lePYVX
 IYWsCAE7l13xsxNh9B7+89YH/TqLMxX+57EDdXnmldTbtgKqMylZDcHFMjcy6FhLjzA+
 gRR+82leAoClAZ7Tl2XpdAU+MU2BX7gcf9dmXwrdr01hDHFzNBGDrJxP7ocdr0Iv/4rz
 rPKvFZaRiGAWuQVgdeufvQx17Wo2D2AOUydUwN6y5Wd+K3+FpBY3s38sbBraz4oUQnvV
 PChw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCHcHoaHzzJc2bQ1HjeQH+IRupDI8IDobNJkASm21DntWD2bw0NaSnMwo3XgX2PzPRpU7DeQJsV8J64ulk3gKzqL95Pw==
X-Gm-Message-State: AOJu0Yx5FlEQxBttKs3VDWq8n30yhAEBpiS6zZj9zul+gqpHnOvhbWJo
 Q3JNa9eSyDgSYaFkh8nb5FkOFRvMdDTy0bu8qw0gKErf2lUIdHrxmFb5UAYLI/bqNtbZ1JjbCv5
 X
X-Google-Smtp-Source: AGHT+IEqQO6eBF/ARizaP+fnfoV2Orrp5nGXPi3KkASDB+6421errzVMM9Kthir2A0M+5yBA9uDFDg==
X-Received: by 2002:ac8:5c50:0:b0:42e:e98b:dfba with SMTP id
 j16-20020ac85c50000000b0042ee98bdfbamr351121qtj.9.1709595847341; 
 Mon, 04 Mar 2024 15:44:07 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 m8-20020a05622a054800b0042dcfeda05asm4848735qtx.21.2024.03.04.15.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 15:44:06 -0800 (PST)
Date: Mon, 4 Mar 2024 18:44:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 2/2] arm: mach-k3: am62: Fixup thermal zone critical
 points
Message-ID: <20240304234404.GR1523872@bill-the-cat>
References: <20240208092951.11769-1-francesco@dolcini.it>
 <20240208092951.11769-3-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HB6r5JErVlGIBgtQ"
Content-Disposition: inline
In-Reply-To: <20240208092951.11769-3-francesco@dolcini.it>
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


--HB6r5JErVlGIBgtQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 10:29:51AM +0100, Francesco Dolcini wrote:

> From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
>=20
> Read the max temperature for the SoC temperature grade from the hardware
> and change the critical trip nodes on each thermal zone of FDT at
> runtime so they are correct with the hardware value for its grade.
>=20
> Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied to u-boot/next, thanks!

--=20
Tom

--HB6r5JErVlGIBgtQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXmXMQACgkQFHw5/5Y0
tywCcwwAs+GQnguU7upbuKb3s2uD+aHEIAiTVKnnEBqdQ/LJTtNu7Kv60rOHNxKo
Z75teNkMxANFsWxTsylZbN9D0pXQNC7c6bMDPU5nJBEpuiMPNire9kF16fhImKYh
31qjGqWQv7LfRv8LMFoizXnAaIjjRjkVT00lfLbhTAz5HrbIi/xwlW/IMuH4nnp5
wH709witEIUe4k92Ac10Acy68+xj6k12xJ6ACJ4To10fC2qzf+930lubt994QfvB
QIcD9UOBFLr2wzvdZbYApgtSczLAnvYVwCzizXt4mEFesObu56sTqWUUx5AID8KS
BT9wbqAme+/coHJm83L7Hp+NLsqQx7AiDVTPCJVCtQe7qqppYMqQx7Jm+RWYK+Fn
NYhsk5eYBr/7W6tdTgc4XOBWuaePa+7RKmk3Gr+rrHRS/0LWBoZ4ZeuP6mCkIDrn
bAMbJR4C7xc5HHqxAwOeYOjh6+oOrdACOclZKLRaobMv6UBrRV6NaLHwvPwSfpVi
HWa+xbT2
=mpIx
-----END PGP SIGNATURE-----

--HB6r5JErVlGIBgtQ--
