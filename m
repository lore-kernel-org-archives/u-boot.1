Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063E7C25B48
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34DA787A17;
	Wed, 25 Oct 2023 01:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I4BEfNh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6B17879E8; Wed, 25 Oct 2023 01:16:47 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CB8487994
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b3e7f56ca4so3020867b6e.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189392; x=1698794192; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AviOv4IMZHoCkYdnk4H91zNvjv8eRDywH1/Kz1Xc4rY=;
 b=I4BEfNh3m7kY3moUgJiTqvFK2oPM+/Z3wlvbcSd/57y0HIgH1Aen7olHl7bScsqVLg
 TPD7GIoUsvaB/w0AN0qO0rqsJwDTxGoePEaxZ5/3yLI6tuUn13jiucSIlYJsU8m/RyjJ
 foVMTjUseITgpHlCbeW7Ngfe4oA5tWJ/YVfs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189392; x=1698794192;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AviOv4IMZHoCkYdnk4H91zNvjv8eRDywH1/Kz1Xc4rY=;
 b=PZytm/KC9qLmn2Qg9VcpS/r2YQFXB7L2t7e3b1p1dgDIBxIIx71ACihpuBFU506RAg
 MF9JN9rgQSr3Rrx5SrNLKX0BSMDm8J2P+H9DFSpnXOQGm71vqo3k53881Y8UoviGllXk
 uE6hm/n939O3iBG8jw0ChevJMvZcs9KbXEgoreRzWTTPGKJVv6wqGFhE+zYNyoY2I+n2
 bfIzBeym7iJ2rUPO+me6swm04J82iOAscIrwHYGF4nekAyjvZBA1sO/lc/pqg95lyVXe
 j41x2fu/ghmJppDU+DPYskVKHvYBTjEIJ0y2dJj1pxZv3syku66bDitUmvlXNBGYQ3jZ
 5spA==
X-Gm-Message-State: AOJu0YxAii57PvCfeHxDQrM6U6jlF7fv0lh8xd0u2W7kTydh21qBYHCc
 j8El5ZrFj6zlmyKQXXFplod+ww==
X-Google-Smtp-Source: AGHT+IE+dhqvoa6CTvM6Ab1uesntg7aTq23VkK09UzEqSVeiJg45cX1C4XiGXxq0rcvA/CYD13mHKg==
X-Received: by 2002:a05:6808:238b:b0:3af:cc96:cb6d with SMTP id
 bp11-20020a056808238b00b003afcc96cb6dmr16769987oib.46.1698189391851; 
 Tue, 24 Oct 2023 16:16:31 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 x130-20020a81a088000000b005956b451fb8sm4428374ywg.100.2023.10.24.16.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:16:31 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:16:29 -0400
From: Tom Rini <trini@konsulko.com>
To: Alexander Gendin <agendin@matrox.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Simon Glass <sjg@google.com>
Subject: Re: [PATCH v2] cmd: mbr: Allow 4 MBR partitions without need for
 extended
Message-ID: <20231024231629.GX496310@bill-the-cat>
References: <ZSCw7eCcnSRpgkBN@alg-gentoo>
 <CAPnjgZ1jyvKku8V5UKqVxBHC4qEy7EtHN+yBuUNQW0pxxHpwkg@mail.gmail.com>
 <ZSNWVGTjPEt2jXn5@alg-gentoo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dwKEX1WrMdLV3cSG"
Content-Disposition: inline
In-Reply-To: <ZSNWVGTjPEt2jXn5@alg-gentoo>
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


--dwKEX1WrMdLV3cSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 01:24:36AM +0000, Alexander Gendin wrote:

> Current code allows up to 3 MBR partitions without extended one.
> If more than 3 partitions are required, then extended partition(s)
> must be used.
> This commit allows up to 4 primary MBR partitions without the
> need for extended partition.
>=20
> Add mbr test unit. In order to run the test manually, mmc6.img file
> of size 12 MiB or greater is required in the same directory as u-boot.
> Test also runs automatically via ./test/py/test.py tool.
> Running mbr test is only supported in sandbox mode.
>=20
> Signed-off-by: Alex Gendin <agendin@matrox.com>

Applied to u-boot/master, thanks!

--=20
Tom

--dwKEX1WrMdLV3cSG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UE0ACgkQFHw5/5Y0
tyzJSgwAinG5Hj5VrPh9xtcZIIA+lFBeliYL7FpePuyM8ypIzPpwCjNlrCgzdet7
puuGs3Y8j9KHy05QFUmuVACZQmxf1gGucbYkCw/nG67WuMLtnolwEXlmprID2rhc
87KkuHyjT/KdE240tW5y6RKACNBljesqpPA/HtHS45fMPNFi3LSCDHr/qXm/eVJT
sE0PywBJFbGX2ZaHw7+xAqAwCKMGmBHSx5VL3M1QIacQfZdM4OkApNk6UUrOBPRS
7bshKpbuDXjP0sZGp2ijfsSeuF3QA29TpIRYxAZjyqiLh9ohtwXibPPEkykL9s5W
E53WEoedJTJZBhBbWhcPlo63vVrQHQZYv/sEz/AFIv8FQmbmNEsVAfhAfsou4RJR
l8pRpPIntyv3vYIR9UDI+LODHvKthcf67lqh+ok8qeqvnIQnvHzAI4TMYV81YrSj
nAWLk5acHOGuWFYceElQ9nV2QFXNT8QgtJsoLBU3xEp7zP7FchA9sT0Z9FHwL1Ia
v2WDt0Qd
=HrYR
-----END PGP SIGNATURE-----

--dwKEX1WrMdLV3cSG--
