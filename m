Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E962FD13572
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 18:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB1088C53;
	Sun, 27 Oct 2024 19:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hSpiNL87";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9194888D1C; Sun, 27 Oct 2024 19:32:21 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BED85889DA
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 19:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b147a2ff04so321922685a.3
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 11:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730053930; x=1730658730; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+wrQzS56/mZC4/rpA1gFIp8zA72o/OSE91TmJaWvNAQ=;
 b=hSpiNL877jVhTCscRp4lObgyzhhu4vzZUfDHV59/wZQKr1WHtsu9kb6Mlc3bnrBBQx
 c90CJ8F/eOjApmnWM6FVuf+6QrjR7MUd70PbILfJuVbAmkYymYVXwv09mJWBXc7aCzbw
 A309S5I17X5lri+pYKqyKLylUfyPFx2y7lOlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730053930; x=1730658730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wrQzS56/mZC4/rpA1gFIp8zA72o/OSE91TmJaWvNAQ=;
 b=DBDQTHxXRksGKrn3ybe9f7QsrdZkEuonT0JusDG7gV4pfYw4KNPuN8J0L4e01CqPaz
 NkVrlq3typnjXwM8dP0+bWIfTY7AOcimhw4+e40HsnQy606etwqD5uUQRGiLhbUZ2r7o
 jIFUFulqT87z17j/w1Msz358e8Cj4wx5orgliU299/k7vA+xJlRSTQSEbddx45EKBaLa
 wxKfQ/kcx7kFMgSZDF4BPhlYEu6jqhT/5Z2NQaFpL+an+Juuk9C4oMjulbKOwEv4x8qq
 hD/GuEZ2J6ATePlRFhtBes/Cod7k4qfc0vH7PpmNENJmG4W6C2S9/fSvVNHEZXN1H24T
 xCMw==
X-Gm-Message-State: AOJu0Yz5UjHlgDMiVwGbt9A8EwsNGoY3TzN9IdfgeZC1CMPXTVoSu35Y
 XleuZuFgX3PoiadBrqdAgDTeEuE0WoVwQK/b4wBSB5G5T9SXVFtyFntTcD6iNFM=
X-Google-Smtp-Source: AGHT+IE7A7d6EKsPrDhxaL5AN0phKGqGWnh/V79EVWClwtwC2Akl9zOITrquEMs/wVXetnEd4QqDYw==
X-Received: by 2002:a05:620a:46a1:b0:7b1:4e01:547c with SMTP id
 af79cd13be357-7b193efdec0mr979861685a.27.1730053930611; 
 Sun, 27 Oct 2024 11:32:10 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d294b3fsm254504585a.33.2024.10.27.11.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 11:32:09 -0700 (PDT)
Date: Sun, 27 Oct 2024 12:32:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] net: wget: check strict_strtoul() return value
Message-ID: <20241027183206.GM4959@bill-the-cat>
References: <20241008094646.4052174-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8LTcV67jslnR0vVg"
Content-Disposition: inline
In-Reply-To: <20241008094646.4052174-1-jerome.forissier@linaro.org>
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


--8LTcV67jslnR0vVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 11:46:46AM +0200, Jerome Forissier wrote:

> Check the return value of strict_strtoul() when processing the
> Content-Length header as recommended by Coverity [1].
>=20
> [1] https://lists.denx.de/pipermail/u-boot/2024-October/567050.html
>=20
> Reported-by: Coverity (CID 510464)
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  net/wget.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/wget.c b/net/wget.c
> index b4251e0f293..a3821495e03 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -256,7 +256,12 @@ static void wget_connected(uchar *pkt, unsigned int =
tcp_seq_num,
>  				content_length =3D -1;
>  			} else {
>  				pos +=3D sizeof(content_len) + 2;
> -				strict_strtoul(pos, 10, &content_length);
> +				if (strict_strtoul(pos, 10, &content_length) < 0) {
> +					wget_loop_state =3D NETLOOP_FAIL;
> +					wget_fail("wget: bad Content-Length\n", tcp_seq_num, tcp_ack_num, a=
ction);
> +					net_set_state(NETLOOP_FAIL);
> +					return;
> +				}
>  				debug_cond(DEBUG_WGET,
>  					   "wget: Connected Len %lu\n",
>  					   content_length);

This leads to:
U-Boot> wget 200000 EFI/arm64/helloworld.efi
Waiting for Ethernet connection... done.
HTTP/1.0 200 OKwget: Transfer Fail - wget: bad Content-Length

On for example Pi without lwIP enabled. This works otherwise.

--=20
Tom

--8LTcV67jslnR0vVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcehyYACgkQFHw5/5Y0
tyznZQv8DtBfdxwLZlfTlEfc5HJyPsZ/u5F7PCX6aeFs/V2WG8jiyoAuN2phkpwi
EywsyFeQ8vowgTv2l9pUoIyzhSrIDc815lLEP/FMeoXovTYdtejwtBHZkW7GS4NM
T2L9TBlljcNcLPVsfUQ/x1januSYF8RtOeovN1Pyj2tqHF0L/dUSOdJE1JJ/Z0y+
8qf+NnNZuKljMMSnPmy3UKIVtn56TFwchNvSYhuQ38et+CRGJQFrMC/XBrpL0UVB
Jaga6v4HYLWW/C2GnzSI9LHQ8thml91bVGi7ixvXsgkiRDVMLmKEQ0YxeO8FORjb
/6jq/yf8Adhe85FRJ8bQNWfmq21QJsDCZh9OUzndfySY0uH8K2B4Xqdgwp1sNz4m
1CtXRhDpcEydDLpfiva2XFzpDA6O1VNIkhXpDsWaH2XBikVRanrUxdK/vc+pkDNw
ir5OVyYz6HlYHaDxnmKm6eCn4X9Qqral8A0vgzYxhTEVyTUbegzyW7I+XsW+1/3x
uIt+U3FV
=qTKD
-----END PGP SIGNATURE-----

--8LTcV67jslnR0vVg--
