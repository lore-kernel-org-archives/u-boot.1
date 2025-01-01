Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D3FE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 17:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D839A8031D;
	Wed,  1 Jan 2025 18:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="As8pRTtO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 844E380352; Wed,  1 Jan 2025 18:55:26 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09A9180317
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 18:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b98a2e3b3eso523564985a.2
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 09:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735754123; x=1736358923; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LqkeiEs4kUIa9AksArmS8ttZnna/lJ9Qb1x9kRQ0RLI=;
 b=As8pRTtOWUoln+C1vuJSvyTg/oz9ktyOfQqtngdfVTF8qRsBBeDdyOZstUvGj7+8WN
 db/fimdwDi+dkYqtP3OQPcuDH+yMCB8nB3/fEfcjexhvshkRTjrOZeC5dMGfwh3ErQ2k
 RbtyO9D+pcSKxEPr9nfc8hbjL9ihyLtVe9+u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735754123; x=1736358923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LqkeiEs4kUIa9AksArmS8ttZnna/lJ9Qb1x9kRQ0RLI=;
 b=c7GkGscHp30HKgTuzlpPISKPl5gFLNk7b4m6AwOvSxfjpWNlOYy+PzJfOC0IyOlc2A
 kC7yKDcxcbgcmVc2YYpXmPzGoTAZ4/qlXnCkmxiTcovYCEdQSIEBctbsR+xybV9cQ7YQ
 fSENVUQmCbb2cramXv3Uc+WupBGr0hN0W/NNKZwQZ5TFHfiYrgOJzc3xmNQzxcRGlH+K
 uwz0x5sljpF+3/uAZ22C29yWlrGR9YBzsjAdTt5WOXdrFBPGlaJc1iktUrBVCwo+b/SX
 fGvFLfCk/jSylYrx4LA2gYCcqacbUVpmRG0G9SpbHdgRxR7cbfsBliLG49wpkPB6hDzQ
 5DZA==
X-Gm-Message-State: AOJu0Yzva4AWTQnpk1ckxSzwy5f7oBY9kOQvrgroflecVu+gzIjbCB+p
 WaOOa8mhAHTSGHlgfhzEkk3qyG8HWX6is85OtY7rX5P4j/QTtR9TWwD9PjNQBHQ=
X-Gm-Gg: ASbGncukEfqfee9Z19XjSZ3HdN/RjPVb6mWLJOXmeIG1E/aeaAkdQv8oj+VyZXHjhr9
 zstmrHSYenEN2tY2bE+/Y629n+HtT0wXzzS/WDPlHXf/BlrsidbB5w8yz8mRFbpdiMYb1Fcea0j
 RZe6tm+NGHOFnxqPgngkFXTPWRYLBdaFjq2eFWZvJLfgR4N6JkL21jwuXT4l8Tb+9bJVqtsCOz6
 0xq16qZC3JnNyQYJIBYI4ts1tgc+Ko6aIlZ6GygnJpkDsCEsvLLNkLdwg==
X-Google-Smtp-Source: AGHT+IEtRZ5cTaqy//U+8uUuDsp9NGuH0xkWVech5Y1dgla1Xu/ZFpm5o/pokXDkrOyoWkfrYKam0g==
X-Received: by 2002:a05:620a:244b:b0:7b6:d8da:9095 with SMTP id
 af79cd13be357-7b9ba6efa03mr7390113885a.13.1735754122925; 
 Wed, 01 Jan 2025 09:55:22 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2bc076sm1107078685a.10.2025.01.01.09.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 09:55:21 -0800 (PST)
Date: Wed, 1 Jan 2025 11:55:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2 0/5] Static initcalls
Message-ID: <20250101175518.GA1682161@bill-the-cat>
References: <cover.1734537135.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AXDAEsSD81EfKn//"
Content-Disposition: inline
In-Reply-To: <cover.1734537135.git.jerome.forissier@linaro.org>
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


--AXDAEsSD81EfKn//
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 04:53:53PM +0100, Jerome Forissier wrote:

> This series replaces the dynamic initcalls (with function pointers) with
> static calls, and gets rid of initcall_run_list(), init_sequence_f,
> init_sequence_f_r and init_sequence_r. This makes the code simpler and the
> binary slighlty smaller: -2507 bytes/-0.23 % with LTO enabled and -1232
> bytes/-0.11 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
>=20
> Execution time doesn't seem to change noticeably. There is no impact on
> the SPL.

This leads to run-time failures on SH:
https://source.denx.de/u-boot/u-boot/-/jobs/986701

--=20
Tom

--AXDAEsSD81EfKn//
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd1gXsACgkQFHw5/5Y0
tyw6fAv9FJgD4JNyrxvV/4h36Y7DcfytAEeak52DxoSwqxtq344vvXvgsDeLMx41
TvF9U5slOwfXeEZx/arZQrjrHifhkx/asXb6NT1c/FApqEuczFHQqN9HVdhVFkNQ
weG+RXFKZZIIniMkv3bGB9dMkK4yMa5fJGsXGc6uZcxl3BUXJ4TO4op6orN/9dcX
pOFdIfIgl4/ev1etDcIbh/mQHDQCN+P/auMxB77WrQA6XjA2IHTpGnlM7KnkStaK
IbJ8nbshBKm/KLsgYHul63A9xbheL8wW6cAx4+FTm0TgJLNQ7bWd+a6iGteC2qzd
dYF5W8ZV41Op1Se5xr23ax1wm3am80712guAOEolPTsbb58gH+IERoCnezCkP9FL
xv22bEI4hMd4rj6j1pRX8LAAkYBVM6ogJXGx9CXDaioZrfMR687qOrO+b9A4VR8Z
52bKc9m3JJeE/fnQ/cX0kTIHm8Fry7X2CDW7vV8WLiaHRF0OdmEL2gobpUoUOHdZ
EPbUuSxa
=mk6H
-----END PGP SIGNATURE-----

--AXDAEsSD81EfKn//--
