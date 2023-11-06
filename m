Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6B1C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92DBD870BC;
	Mon,  6 Nov 2023 17:32:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rWCkrdZx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9796587087; Mon,  6 Nov 2023 17:32:54 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B68870A2
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-777754138bdso302013385a.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288371; x=1699893171; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eaLmVxakOh4j7Q/dpmrouKEsKJEtH2PRZCNEaA261BE=;
 b=rWCkrdZxxazEoTHpW9Owf0LXQ+nj9QnnqfpCjSkmWJUEAUgp+45cjc2jAwMBpkqFgH
 z/81KRklA9Q0/apu+rZ/mBQ0vWNjHN/D2PlPh4DcHCBqZ3fZwsj58ODoXPpYfXBi4cIO
 AE8krQYWGbBHiEeDwXSUdX0eIxt58I+IjaWnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288371; x=1699893171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eaLmVxakOh4j7Q/dpmrouKEsKJEtH2PRZCNEaA261BE=;
 b=SSJsUvB8fyacLPHsUDR6MmwtCAoebvceg0ZWyETcP776yiIkYxO07f6zU4HYFe4qW2
 5AzW0VAbokuFfPYuOSC+nAD+sMGilvVB1DCrkSspyh4ZEclsEcvnTeWVvhQJPIbMp1rQ
 2h876GKnIL0hBU2cPkFTqoEIJUUaf6+yWq/8Ps2ZmU39Eu/7mN/Rb29QZXXOO7FoLVjw
 BaQSfCdmOfC7DTfFFQ8OPBLlJ/Hu4A1wkyWcdgW9Xi2qdKWzej+06ALKFgrhJZLe4sx9
 53cdnyJ3tbnwGx7HuxwsmD/Q5xIyP/NJPtu67MPiAHI9JLi62glBFP5M0KYmS3v/TVd7
 AcOQ==
X-Gm-Message-State: AOJu0Yyr3P87bLypWfNETmMa2V/uvYy7fj0r3GUjaqPm0DJyKw4HpLZL
 7WM6dyoShYZjIk+pVwyIHhRZUA==
X-Google-Smtp-Source: AGHT+IFdSotJKtVJ2TNaWxpVeejB1ONLXJc5L439ZNgKCsNrE+yMBP/ERpyIjcJgWs2FiKu+KDUlxw==
X-Received: by 2002:ad4:5943:0:b0:65d:475a:a2f6 with SMTP id
 eo3-20020ad45943000000b0065d475aa2f6mr32528323qvb.40.1699288370971; 
 Mon, 06 Nov 2023 08:32:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 a12-20020ad441cc000000b0063c71b62239sm3586357qvq.42.2023.11.06.08.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:32:50 -0800 (PST)
Date: Mon, 6 Nov 2023 11:32:48 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, LW@karo-electronics.de,
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v2] net: eth-uclass: Improve error message when MAC is
 not found
Message-ID: <20231106163248.GN496310@bill-the-cat>
References: <20231020124151.1968187-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E0WPpdsl0B1I21Ar"
Content-Disposition: inline
In-Reply-To: <20231020124151.1968187-1-festevam@gmail.com>
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


--E0WPpdsl0B1I21Ar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 09:41:51AM -0300, Fabio Estevam wrote:

> From: Fabio Estevam <festevam@denx.de>
>=20
> While bringinp up a new board without the MAC fuses programmed,
> the following error message was observed:
>=20
> Error: ethernet@30bf0000 address not set.
>=20
> Improve the error message to make it clearer the reason of
> the failure.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied to u-boot/master, thanks!

--=20
Tom

--E0WPpdsl0B1I21Ar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFTAACgkQFHw5/5Y0
tyw0fgv/REbpoiMwgneF9NLb/6XVrHtOiSb74ucbQqGlhHU3sdqGL6KJ+HwZc52A
xhbAca3NoSoJHD3gWfU+PNlDCg/SfO4LdNYieDc4nhG5HA0hXBWUYpPX8rNedjkO
mckwiq4dWwVIMsxN+sLxd3PAloYYWdKfQPunHV416o9qB/BCjHghr7ZAlStG822O
MgXOjnJ4HZXTiku1BzTDRneZNwzFhUWm8I25LDULth7WPuRpMmpWKlNIc6sDT6dF
Ma3ETNqeKS/xH3FgN+QmPbsx3jKIU4MSCmaoGpa2nFffarrkQexun35MvMx7k+HP
6k3j4EAloA431UmQeO8cwuEanL1PxCj2jmsUFiXiYWtOLAS4e70WCMKKvvvJTnb4
2e+8x6w7spnOGbJodZ6NrSjufeKJnRL4iz8pOqckqKrHzBKdcrITeE654+yWjsSo
jqfsiWP060/tyeOV19xnI7FNr2JX8EA3hcpug8c60jNcGq3XuRNRvoAu6I8dQsRC
YoL8TZq2
=xnpA
-----END PGP SIGNATURE-----

--E0WPpdsl0B1I21Ar--
