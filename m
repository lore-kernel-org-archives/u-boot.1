Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F3DD132CD
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADDFA88936;
	Mon,  4 Nov 2024 14:57:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RVXindm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 970C388F41; Mon,  4 Nov 2024 14:57:10 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89E5F88936
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b15467f383so314093685a.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730728627; x=1731333427; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cy2ZLNP10Ex+OWxOU63gpOp3n153xPJ3Tj1Dg86ffJw=;
 b=RVXindm2KumLXGzRPmv2EL4FIzSvNPkWDNuCL6mPhtVPbd+uOj9ejyGHYhJq4HiRS7
 UP69LczwZFXHesFzrCXE5pgXQlHc6z0+Zg/OWxVGvfwGU8Dc1C6jrit9RCY/E97JTV1b
 cmdkJo/K80sh432i7zVft17wxHy2eq7dBZnWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730728627; x=1731333427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cy2ZLNP10Ex+OWxOU63gpOp3n153xPJ3Tj1Dg86ffJw=;
 b=bopP4UsWiYcprc3lmxtcdIF3ntEr+Ld9NOllg0V/CPDOjUls+8iBGr/2QeUKhyOqL+
 zc5Za3o9kKyKhUpF5nrJGR05zCxQsTPQetAExf8LydzjvLJppa03x76Qf6YbhVMUtqgr
 Agls4oJdn/IhQzlGPgtaiNQpmlA0yq1i//Bgej65pUMd3sVws7cSESfui9xbRjMhq694
 AxG0ZooWav8bHSE9m9+0t2Pux0QMeiEL2ZdRXMlBSQ/+tHGESv6le7kKa77DSr5jRxZX
 ab3sTMcQzEgd24td263sRE6pj62MVaLOk04ePfmGaTXqUttGXaBj6TXBIbAnmfyNIpgX
 +TUA==
X-Gm-Message-State: AOJu0YxIfL9FIQ6cKfwOFMcNjG0MHrMsj8qR0WxHWhy8lCXaiWQo7s2Q
 FT95tDb4DjEu24wD+1sXQQA94AeukS0qDSy9KMR6hBmeESmr4wZLV1819Zt8LRQ=
X-Google-Smtp-Source: AGHT+IF4q1eVFlM5vBLr4tTWXAXmap9gfM7XO0PbpDHMZVFqOFmfcnrByXjoppk150IMZi4R5EiyqA==
X-Received: by 2002:a05:620a:f01:b0:7a9:a1b5:26f5 with SMTP id
 af79cd13be357-7b2f24ebd79mr2878456485a.26.1730728627426; 
 Mon, 04 Nov 2024 05:57:07 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a864f3sm420998585a.118.2024.11.04.05.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:57:06 -0800 (PST)
Date: Mon, 4 Nov 2024 07:57:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 9/9] CI: Add platform variable
Message-ID: <20241104135703.GP3600562@bill-the-cat>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-10-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yGYlNWG83B5sw+1m"
Content-Disposition: inline
In-Reply-To: <20241104133954.840994-10-sjg@chromium.org>
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


--yGYlNWG83B5sw+1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 06:39:53AM -0700, Simon Glass wrote:

> Add a list of possible platforms that can be used by gitlab runners.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--yGYlNWG83B5sw+1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmco0q8ACgkQFHw5/5Y0
tyx+sQwAppc1GhEdt4r9nfHhor1HqTQWJrdWF6yC/u5nu/B1pdGLToyfBOb8O7mC
v0cCe16zExUDVP7oBeQRyxJ6QkPl9/xyFT0bC19N/weIXY0+BKCNL9+2MWKX1WST
xjuyKvChiOnMhp5RZaDtMf96vldrmBoQP6DUjOkxAOuxrLgtxts/SUGInFOWIQOU
YKqTZa0JWweE+63bkbh7YFIPVo0mac7jyof1Zdr+oREUVDKHzA4Mb5W1sq3EjKoW
xs1tdNQg5L1+L9qJGEclkOn3uRe8YaF74POIPZxQN7eJQh6PjCyVnVIlGFwhHSz4
LlLQuOaF5gEAtMVSyKlAsPNBOxdWFNEfQh75+ER4M+Yqsy7bOLGYMygMPw5TEUld
W2BYukbDRhGQcOT24NrnJdqE0Dhu6GThHF68bmg3uzVFK3FVCXAWfIeMdZ9z2qLC
MuNJWtVUWDkA2uPvd9oWnTBXgR+RFICqcUuLqTKCg+SL/7yh0A1hDi1L6NgQqzEC
q4qiXUd8
=3U8n
-----END PGP SIGNATURE-----

--yGYlNWG83B5sw+1m--
