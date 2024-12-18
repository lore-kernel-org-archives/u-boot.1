Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A13E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 21:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8DC980241;
	Wed, 18 Dec 2024 22:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YpSf2hNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B3A7802EF; Wed, 18 Dec 2024 22:05:39 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F388021D
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 22:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6e5ee6ac7so3767385a.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 13:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734555935; x=1735160735; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+F0v6/zQ8w7cu6uIj+1EwvHuLrGhqk85p+iH4w3m5Og=;
 b=YpSf2hNK6WTXqiLiE/c/Rlj+085lgn/oU+AQfr/96DIFqmPOAeHe8aI627Lib4FOeK
 g+tAE5JH8AWTJgAFRxZkhj1af03h8WycyUrd0nOrwanY/S0h29BcNu3bdBkiJ9/2dGYf
 Vi24m0NHjDO2mP4r+O8IZ91X+j2p03eW8Ghuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734555935; x=1735160735;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+F0v6/zQ8w7cu6uIj+1EwvHuLrGhqk85p+iH4w3m5Og=;
 b=NHizewevtDcT8QkO/KpdT7fPZyvdzJZ7On51ePUXZcVEjtFrHth9APXvwppoRSpdhk
 COisvHBOlE+9CKkxm/TzNuyKiyd3fQt3FDY3Q9zd1kpg2AsogteSvOBUo4fkq3bRJtzd
 j6FKVJvZHI/5nzcfyaSB+V6WOpV3uBJC2QU7a3jJWQ4rThGRFsDw7Ks/KNODKTSIfzYm
 TN8nYyNAJeab46tK6Y8pMfWmDZi5we/cUEP9EE10o3pWXjuiHcLNNCjrEUq0SRlhR8Et
 9JPlZ4RXsIf67bmGItzDIOIwUvoXsPJ6m0BXJdO+ZMKhns0Xw6VYAkoOYmMCbEJ/u2Pw
 bYNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSgpbyg7qvO8pk46YFSV44KWgUmEILuU3rIpjoHIfuzJlrXtvHLgRvqIHRNjmHvgyQOc3asiw=@lists.denx.de
X-Gm-Message-State: AOJu0YwUbNeDlSbjwVp8/rnzK+ZvPhQiItrwonNj8GZQzop32VTnlEaR
 9HCsH1ZuoRSPFD32ZXR2uEEobj0T5gq/FeeoeOALUjmIgewbnTLlxHlGbAiFLoA=
X-Gm-Gg: ASbGncvZroaOJElLHNYXHT2bmwEchVlN4BsmHg05IQYZJ1O7kZvm5gy5bO0KENy5+px
 eDFSg9ZigfFmEYiNWCc2WNpjwm9ehUva4o1mTLLOl9KikL3z7N/831R+gJsOW8FWvG56F6C63nZ
 z+y+OD51J1gW44SJFj3vk7QjoVuPmObWL2jXjI9tvoYv99sxv6COSJUwOq6oU5k56QEWTTG6uQw
 3qg97tj42EnGUWzTln1JV/1Bkw4jW0zbewWAyJGaroKMXmiaFh4G8Kz
X-Google-Smtp-Source: AGHT+IEYpRl3+7MhcQMiKxEE4YfdaywJKt4gNyKuLF9HXKWaTUxbKpBrUilM84zrDNfpY7xN/Gi4IQ==
X-Received: by 2002:a05:620a:1d06:b0:7b6:d4ea:fe8a with SMTP id
 af79cd13be357-7b9aa8b47bamr154299885a.12.1734555935612; 
 Wed, 18 Dec 2024 13:05:35 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7047aa91dsm465895785a.15.2024.12.18.13.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 13:05:34 -0800 (PST)
Date: Wed, 18 Dec 2024 15:05:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Adriano Cordova <adrianox@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH] net: renesas: Enable TFTP_TSIZE on all Renesas hardware
Message-ID: <20241218210529.GP1505244@bill-the-cat>
References: <20241218194143.79136-1-marek.vasut+renesas@mailbox.org>
 <20241218194327.GO1505244@bill-the-cat>
 <c0733d18-e778-422c-af06-7fd33479e92d@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vevCj8apz4S4c9iR"
Content-Disposition: inline
In-Reply-To: <c0733d18-e778-422c-af06-7fd33479e92d@mailbox.org>
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


--vevCj8apz4S4c9iR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 10:02:36PM +0100, Marek Vasut wrote:
> On 12/18/24 8:43 PM, Tom Rini wrote:
> > On Wed, Dec 18, 2024 at 08:41:28PM +0100, Marek Vasut wrote:
> > > TFTP transfer size can be used to re-size the TFTP progress bar on
> > > single line based on the server reported file size. Enable it by
> > > default for Renesas hardware to avoid long scrolling walls of '#'
> > > character during long TFTP transfers.
> > >=20
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > ---
> > > Cc: Adriano Cordova <adrianox@gmail.com>
> > > Cc: Anand Moon <linux.amoon@gmail.com>
> > > Cc: Baruch Siach <baruch@tkos.co.il>
> > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Cc: Jerome Forissier <jerome.forissier@linaro.org>
> > > Cc: Joe Hershberger <joe.hershberger@ni.com>
> > > Cc: Ramon Fried <rfried.dev@gmail.com>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: u-boot@lists.denx.de
> > > ---
> > > NOTE: I wonder, shall we simply enable this by default ?
> >=20
> > Any chance you did a size comparison before/after this patch? That'd be
> > handy to know for making this default for everyone.
> r8a779f0_spider_defconfig
>=20
> without: 744640
> with:    752824
>=20
> So maybe this is not for everyone.

Indeed, thanks for checking.

--=20
Tom

--vevCj8apz4S4c9iR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdjORIACgkQFHw5/5Y0
tywMZQwArcmSIls/3AIOOBeUtPl2eBGqxGH6xWpxPEqsTI6KjDJ09yj4cPQVFzMf
jr3cDzuFscEDB0AodysUTsQHkji62NZ7GDUKESPTMBqE9n7Zw4lGN8maiT3nM6op
eezBFgNO3VHd4GlPbQAuan91mK+FtUUFAp/XB+HbZ1JVrTTiN8yo/FkUGGKuVD6p
u7x3LOWVj8AmZ0OlvoJLArAA1Kip1sdRpW/sacsHlZQRrvGTVLush9ld6WMknBJp
G++BcPTW06C9kZ7+xIrO+aVJkf7VlglgKrTnWUWBLZoE4RZxSzvaB894oNp+yf09
loUunc5Mm0x7YRtj0Tg7hMFYsTYm46WrbSysq2UsE2Cg2NI+/Q1a8aQc2HdnjLYc
JjVX8pY+xu+MvtO/GZtmizmuZRI09HLnbXOaNAxy1i2hxxu+4hEguK1Z9aZrAGMU
o3ROXknUOue9n+gZvmkSvPFfO8nsaKva6xWt5GsBpAgw0jAFDplewQF4/j0ntk3l
+neyxNg9
=fDBj
-----END PGP SIGNATURE-----

--vevCj8apz4S4c9iR--
