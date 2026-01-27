Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C7ED340B0
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A87984158;
	Tue, 27 Jan 2026 17:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QnmLWl08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9FA884158; Tue, 27 Jan 2026 17:41:03 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EEFE8413A
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7cfdcae466eso3520525a34.3
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769532057; x=1770136857; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nNco1ydyi10w6osPn01FEBVAk2RUyAQ1/d7kyF7uvLM=;
 b=QnmLWl08tWMlBkC6/gibxpth76Pw+j6wrSrP1nMRE/PHbyLc6neCPGL5IOwlueCo2B
 Imgzu5IcHRYAW4Tx2lNZfS64h0Ygdyu9Fn1ZhvL/edj8gnyMuVFXkNOlxwO0MTRYpyiM
 zA14i2LutYXggvK7UW3Qp4dCBxwJrJLorj+TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769532057; x=1770136857;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nNco1ydyi10w6osPn01FEBVAk2RUyAQ1/d7kyF7uvLM=;
 b=oW/Evs5kJcCyq+iKSDczwT4TzvX1pGcfXVN51QSYZ9/0/2kk+YkuLuN3K1YPm1T2f6
 gk5xiSDSiLzzT4/QFPCdDCuvdW2+yn1mRqU0Ip2wsuo40F40THImBPWwSXSSeGxcs4jB
 S1Q+SOQsNlgyGmjCAhHWOHdvRlWwx10EB/lz4uC3qgS+ArgxFfIcM+3U1/nkdL0TuVR8
 +qaVMlUDmSb3rXsB2xZDIKrPRHx+O0c5xrg3vm5lhLLiE3OiYxY10ZlpjWP4FSouOSAL
 o4r1P6jRDwBI4m5IVcPwGo3A9sCO+PYyOoY1pwYfJ0fyIomTwuPOb7D5WP7ZTOYhhnJh
 JsyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi1qoIwycwndieMHiLtCjNeH2KtZmEEUvBfBNXFmKlAHx2fxqld26HU+YcTbOILJvGndUyRRs=@lists.denx.de
X-Gm-Message-State: AOJu0YzPHRyzR3gaeLJfPc4Av9kvSRel98RzFXF/i/xIVeNRJo+80b/7
 Ht6VN5dPFQ6V4qgVGrD4A8O0pA49dh70S6/bYYccAMVf8LMonbngzOao8d5qbNDRpwK/7bCvwAo
 J5ydjdlc=
X-Gm-Gg: AZuq6aIKdmuNQOjH5GFitvejZhxypeKZ7ZDh5uyifuhmHysGLHOLjsWPe/2ccrMjJjv
 /ONXPi2AwCwc6DKWb3iwZGMiifAGZoGp8pd8a4wA9zdM+eh5XVl4pmaFakDOBrGWEBcKGqJI3Vl
 7ImsXNOooiJKSvK1jtA6z0cyDDPzg70arBiHZbh5DJQ6IihOIeZJE/EFSYbNwcVdoC9hHdfoQNK
 qk0e9aH8AuWJYhT/CfPbagpBg4Y+IaUdRHwrDe7HCs1DegMaz4RGIVgPFxKoOuu/uR6pugaO03t
 KM6AweVyHho1Zo4oTeIaH+vMafN7ZH7IeBkd2iCJB7p//35U4SyQzIpCMnPHEEczcKCy1e9N9xY
 2JUsqCw9KLBhuRoPQ9CoIbS1yL8LMCZDurz12S9W0WiufynO8aNnDoHancJZvu470GW0ehbFvqp
 1JjikQnmunCHtKowwgejwQahuEV0AJQZ7jyP6G5JeJF/DIR+FN6MH3axUMep+LqOmROX30BbO7R
 quIZ9msnHq+twbT9ZVUx+5AXi3nkdU33/zpstNzYoPpCc+lJA==
X-Received: by 2002:a05:6830:911:b0:7cf:cb0b:dd10 with SMTP id
 46e09a7af769-7d18512076emr1293219a34.33.1769532057378; 
 Tue, 27 Jan 2026 08:40:57 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d18c8238fcsm107531a34.27.2026.01.27.08.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:40:56 -0800 (PST)
Date: Tue, 27 Jan 2026 10:40:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2026.04-rc1 released
Message-ID: <20260127164054.GF3416603@bill-the-cat>
References: <20260126204548.GX3416603@bill-the-cat>
 <c2737282-7001-46f3-8ada-58e4007329fe@cherry.de>
 <20260127145335.GA3416603@bill-the-cat>
 <CAOMZO5Bqx0OqKjJ22ekaN12mamEJbTpUg2UB13TWy5JdihJARQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2bMoSy4hzF6CE2Tn"
Content-Disposition: inline
In-Reply-To: <CAOMZO5Bqx0OqKjJ22ekaN12mamEJbTpUg2UB13TWy5JdihJARQ@mail.gmail.com>
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


--2bMoSy4hzF6CE2Tn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 01:38:10PM -0300, Fabio Estevam wrote:
> On Tue, Jan 27, 2026 at 11:59=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
>=20
> > ... Oh blah. I knew I got sidetracked and would forget something. I was
> > looking at the final linker / dtb problem (that Fabio reported) and so
> > forgot entirely to write a changelog.
>=20
> BTW, I tested your
> https://github.com/u-boot/u-boot/commit/380ddb473c6bdf87e66c0fb93e256d1e2=
33c6f5b
>=20
> It does not work on RV1103:
>=20
> $ cat spl/u-boot-spl.map | grep __bss_end
>                 0x0000000000015f18                __bss_end =3D .
>                 0x0000000000000268                __bss_size =3D
> (__bss_end - __bss_start)
>=20
> $ hexdump -Cv spl/u-boot-spl.bin | grep 'd0 0d fe ed'
> 000029f0  d0 0d fe ed 00 29 05 db  8a 18 03 d2 43 6a 1b ba  |.....)......=
Cj..|
> 00015f10  00 00 00 00 d0 0d fe ed  00 00 0a 43 00 00 00 38  |...........C=
=2E..8|
>=20
> FDT_MAGIC appears at 15f14 instead of 15f18.
>=20
> I saw it was reverted later.
>=20
> Please let me know if there is anything you want me to test.

Yeah, I pushed a few things by very much accident through to master, and
reverted them.

--=20
Tom

--2bMoSy4hzF6CE2Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXjqlgAKCRAr4qD1Cr/k
CjoQAP9eqlT8WQxTMOQT45gLBw12hMZAsGYjxL4p91slbFA35AD/fWUglNOCUyXk
6KMt6tNCKRWyCBUnMazb/ZcwHijaPAs=
=3Cuj
-----END PGP SIGNATURE-----

--2bMoSy4hzF6CE2Tn--
