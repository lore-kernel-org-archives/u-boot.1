Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E20C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8048C8699C;
	Tue, 15 Aug 2023 16:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S2Z6Cwzh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00AEF8699C; Tue, 15 Aug 2023 16:43:39 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36810869C2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-58c68c79befso323097b3.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110615; x=1692715415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Woij98d/m8oj6qg0XMNSfqCk28eeWPtDCbkq6Sj3kZo=;
 b=S2Z6CwzhhF76UMjYM3EOtLZYo6TawlTzrHbrk6qltK6LrqTmlxDXQEVnWnD91QC3ZR
 etFqxS8KHKTVMT6ish0WAaT5o3BaLqpp4kg2m4z9EXAiwWFKf/dBcOquuPbD3bF3+lRS
 YH7pC0Kj2tdkt/HQARe+bStACrdzbm1HYnV8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110615; x=1692715415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Woij98d/m8oj6qg0XMNSfqCk28eeWPtDCbkq6Sj3kZo=;
 b=M2y5LSF/YBn03Fsw6pptxytaQ7Pw2sBZ5wZV04d1C4ZLfhZY97fDesJI4rC/SJTQ+m
 Qf/iUZNC6S716ewyD+oEos+tkK5JHdBrd7RpaHqej+8Pl2thxoIW0IzOb4kIgnHVBogz
 ZZdsLKWY1rrQA7aqplWEThAXTavSD0wpuTQLQDpmcvZZCyaYP/OfOFaUYFtxlYWZriab
 KZOEzbi8fHhHlrtUUkisdEdujcaZ5NFiieI/XiOQ3R2OJ9Vmknq7dOummHcdlw/+6KzF
 i6VSy5GUXxkKmf6BitEV/+mUta0r7lznhexWI9okV0cNPP+jL5gjrLxNg+EiMJXrw6ZM
 V+Hg==
X-Gm-Message-State: AOJu0YzLUz7Vt0KmmvonB9092lTnJoxdaPrsAKlWo2v7TfKb5qe+mNMy
 msRJDzA31/0rmeT8i9nBb11reA==
X-Google-Smtp-Source: AGHT+IHWHvqJcoTXTU7cxHi+phLlmNNF4kTceVFM/3e/tEG49TO8CKB52iSfzDrhFEiIFeeQnCbe2Q==
X-Received: by 2002:a0d:e041:0:b0:584:bfd:bb66 with SMTP id
 j62-20020a0de041000000b005840bfdbb66mr15399990ywe.30.1692110614966; 
 Tue, 15 Aug 2023 07:43:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 e185-20020a0df5c2000000b0057a6e41aad1sm3404176ywf.67.2023.08.15.07.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:43:34 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:43:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] fs: fat: avoid multiplication overflow
Message-ID: <20230815144332.GU3630934@bill-the-cat>
References: <20230730144404.232564-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LJPNPOJnYMpUiWbY"
Content-Disposition: inline
In-Reply-To: <20230730144404.232564-1-heinrich.schuchardt@canonical.com>
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


--LJPNPOJnYMpUiWbY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 30, 2023 at 04:44:04PM +0200, Heinrich Schuchardt wrote:

> The product of two 32 bit integers is a 32 bit integer. Hence
> clustcount * bytesperclust may overflow on > 4 GiB devices.
>=20
> Change the type of clustcount.
>=20
> Fixes: cb8af8af5ba0 ("fs: fat: support write with non-zero offset")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/next, thanks!

--=20
Tom

--LJPNPOJnYMpUiWbY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbjxQACgkQFHw5/5Y0
tyxVzgv/ZwyHW65y5RlEQM/hs3ZqwnJOJ2jG0r7A4XQ5tCVgYb/tMKPW83zFmJCD
9nG1vi430gyDHaaYyv3e1q4iKX6ycAYkCzcL9u0GYP+XEg2r1mBBUDMF5T8cXlFF
qHDccMj3xGzeaP21xVhqwVcsOijKFXZiaoelYyLcAp7PBEN+yT+3BhE37rnCGmWX
1bLy+qyMkFrEuW2bOypDBDyZZqqRyRnT71Ut0x1NWaMxAHWjP3KwwjybVScZc85p
fpLC9BdH1QDOfSUL1Acsh9S4GuQ915mn+FNVsVsKJu9ia7om3oybR/sGi6TZPhNS
SgT/6p8Yj8m0m2PmVyF7uOV8VgNJ3MkYT0JD+rVqrBvvjwGGrfianGJGcqMueeeS
Jz4gDvSLZhvyEAq3Xjo7XWtQSFXc5OiyE9cmnOuCXFSC3Mec8awLpvsXTtiRdXLY
RH5VIkyvqxiv7zyvIf8CxZaecSFXOBN/Y4bp4FM+AoEbdxWzV2da/9ldSQVPPtm2
iFJKUMsX
=gLPT
-----END PGP SIGNATURE-----

--LJPNPOJnYMpUiWbY--
