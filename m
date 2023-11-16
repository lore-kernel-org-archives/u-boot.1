Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05691C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 18:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72BF5870D2;
	Thu, 16 Nov 2023 19:41:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="igWee6rC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59ED48744E; Thu, 16 Nov 2023 19:41:05 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C758269F
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 19:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-421ae930545so6592301cf.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700160055; x=1700764855; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x1Af8PencbuvYvTf+0b34wHzkHPwEOv9VaQgqxgyJbM=;
 b=igWee6rCgo5Mca+Oh1UQ0tK0ZhrpnRm+gISvMwU+Xeg/Q/URZM7zar0s8B7Ex2Gta+
 saGDfEMrnS2W5tfuaqhRa4H16qx/ZEPZEivnmuDu3zMpAZ9gWbFVHhV/qXZGbU35Wdjt
 G5UKJXxY4kxT1N369hXMIIr1qkRhAjTbR4xpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700160055; x=1700764855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x1Af8PencbuvYvTf+0b34wHzkHPwEOv9VaQgqxgyJbM=;
 b=WikJ4bZta/wxyJQH1sHJYgpFCNjAMY82DwlmHhkKpkz1qXSvagX16w4kDC2QbKa4Td
 IIi4tYzvaKcx8yqi8tQN+1tW1KhSaR6zvxmSA8eijbLNwhtsw31Og5hvtraZvXQVaakI
 XvwzqfrIXJfcybBRr+qoukrJRI6XVZjCXOCHtzpUgysUDf9iPQaK4zFStAo6mgh5uiHp
 bmsvpE8mN+yPyvQ0J8KnzfaH2hAO0y1OjvbFPH7cEXV6c7ZesOuJdqsxV5E/44uMyekh
 JTU9Az2V6zbcXn0uwGqOFX4BQcWT+Plg8MsIMqkxXWX2VgEyYjjHgQucI2KyXTMyzcvm
 pL2w==
X-Gm-Message-State: AOJu0Yyp7NnS/VH5qfVljc/N/bsjFT7SrcKjB0yNVBKHCs02mCAuWBNM
 05tKesrkC//bDwrqPNwVtkdJTQ==
X-Google-Smtp-Source: AGHT+IGNSGM3Tu6OJi4fhE26uEcKctclfiJy8/HyFGCkj6J11ArSZkjhWwTVcEigPQErmIx5q8X0DQ==
X-Received: by 2002:a05:622a:11c9:b0:421:c2ea:fbd4 with SMTP id
 n9-20020a05622a11c900b00421c2eafbd4mr11590336qtk.32.1700160054866; 
 Thu, 16 Nov 2023 10:40:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-31e8-20a7-2ee8-ec91.res6.spectrum.com.
 [2603:6081:7b00:6400:31e8:20a7:2ee8:ec91])
 by smtp.gmail.com with ESMTPSA id
 y26-20020ac8709a000000b004197079f2f8sm4485749qto.64.2023.11.16.10.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 10:40:54 -0800 (PST)
Date: Thu, 16 Nov 2023 13:40:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, nm@ti.com
Cc: "Kumar, Udit" <u-kumar1@ti.com>, Keerthy <j-keerthy@ti.com>,
 u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH RFC 10/10] board: ti: j721e: Enable ESM initialization
 for J7200
Message-ID: <20231116184052.GE170968@bill-the-cat>
References: <20231003081038.24299-1-j-keerthy@ti.com>
 <20231003081038.24299-11-j-keerthy@ti.com>
 <838b07a0-8490-c05b-b08f-3ab6d3e1737a@ti.com>
 <20231003151033.GD8465@bill-the-cat>
 <726d44fe-bd81-4409-a9b2-776eea34fd67@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5vsyn1SxdbsETFon"
Content-Disposition: inline
In-Reply-To: <726d44fe-bd81-4409-a9b2-776eea34fd67@ti.com>
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


--5vsyn1SxdbsETFon
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 11:43:50AM +0530, Neha Malcom Francis wrote:
> Hi Tom,
>=20
> Trying to bring back this series here.
>=20
> On 03/10/23 20:40, Tom Rini wrote:
> > On Tue, Oct 03, 2023 at 07:57:04PM +0530, Kumar, Udit wrote:
> > >=20
> > > On 10/3/2023 1:40 PM, Keerthy wrote:
> > > > Enable ESM initialization for J7200
> > > >=20
> > > > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > > > ---
> > > >    board/ti/j721e/evm.c | 6 ++++--
> > > >    1 file changed, 4 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> > > > index 42fa94b7a5..070b28326f 100644
> > > > --- a/board/ti/j721e/evm.c
> > > > +++ b/board/ti/j721e/evm.c
> > > > @@ -543,7 +543,8 @@ void spl_board_init(void)
> > > >    	}
> > > >    #ifdef CONFIG_ESM_K3
> > > > -	if (board_ti_k3_is("J721EX-PM2-SOM")) {
> > > > +	if ((board_ti_k3_is("J721EX-PM2-SOM")) ||
> > > > +	    IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM)) {
> > >=20
> > >=20
> > > Could we align on one kind of check,=A0 For J721E check is done again=
st
> > > board-id, whereas for J7200 checking
> >=20
> > We should look at figuring out how to split this file in two.  One for
> > "generic J721E systems" and one for "TI EVMs", as I've mentioned in
> > other threads, so that it's easier for custom platforms to drop code
> > they don' require.
> >=20
>=20
> Yes that does make sense. Would it be okay if we solve that problem
> separately in a different patch series? We can move along with this curre=
nt
> series for now (after making the required change in CONFIG/board-id for v=
2)
> since ESM support is important for these platforms.

Well, I think part of the answer to your question is (and this is a more
general TI one too), what outstanding changes need to come in now to
make existing platforms functional for v2024.01 ? My first thought is
that this series would be taken to -next, if I took it now, which means
there's time before it would be in master, and so if it really makes the
re-org later easier, we could take it, but if not, can we re-org then do
this? But if we need this to deal with regressions, OK, yes, we can take
it like this now.

--=20
Tom

--5vsyn1SxdbsETFon
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWYjQACgkQFHw5/5Y0
tyysBgv/VLwu66XPRi7pQsZNwWgVt2KcpHqRms+QMQajogy7IoXPw5YHs/LtIwfP
07NtpTn1f0Ht4wiyfYrZZkNDTXNX+EeEnjyJhyYpFAmjlEjEEK17Hc5DICFrmypq
og9eJJtCVDpFVpKgfjliU5XIz9hOgQ6TCqSWDNRzsGNNj7ukQpGEZfCvZ0bEjNl5
Wcee60MlOjZhitLgWk6z4IzD0xE9SrYpG2tLhdxCXbFqYRm9b04NhTxsJAcX6Tqe
WYlif1cN+FRHyvM7ItXbtqkuODt/6e6l+fZNS0sbjTT4SygkA/DMJYbgM7hOHCAI
cuRMIJhPJ0TyjfemtZvhs0imHSY0Cj0Y3z4HmvqssYm1Nm/rsLzmEXQv/WUDDwnQ
ZbqQhKqndUleGwQ/D2fh7k/M4oJYuBdMTWNbysLmzGGRzCzTyoCVVWE5t9AsSaFV
ivxyuYBDc1ZrCzpZvtpELyoZvckvwGLtmKw6Kuy8PLYeGYHduMZ0lI2BWN6MVuoc
Arvv4utl
=S6ME
-----END PGP SIGNATURE-----

--5vsyn1SxdbsETFon--
