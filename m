Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B021C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E23A4878C1;
	Thu, 21 Dec 2023 18:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r5SSxgpR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB99878BF; Thu, 21 Dec 2023 18:53:48 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64BE1878D5
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-42788536cddso6416571cf.2
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 09:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703181223; x=1703786023; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o4hAXQKS9wgQzklXIS1pgHlN0pXvRStGFa0io20EDKA=;
 b=r5SSxgpRr93akEntp2BVywcvrnMfCt7KePJ6O6tjZW3/Z1fQhVnA/AmSKveBh1WJn8
 GfYtxW+iYSdAs4Sb2O7v905Kv0P1aAUspb7CV9BbcKiOehyhRPuYts21dHDHmSi2rqMY
 0KDt5WRj5iLRwU3eWFteOwuyN9I2wJInX/yXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703181223; x=1703786023;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4hAXQKS9wgQzklXIS1pgHlN0pXvRStGFa0io20EDKA=;
 b=iKKNqtmYN57eZnGoK1dxt/0QkZbn5ECIXmAtPCV17r7vVJC/S5cTOGKoIMjxhBsc5v
 Mi+i2bVketu0PtyEvK7I6JENMeR8zJalLeNAA1T1Ibrmamwcy7RzaUFr/LItSOtl8lWn
 pPVFXr6TbcjL+XSQkUggof91u+JKgAxn9a5UmkNzuM4hW0Q9rB87gFimdBwO1LbbkHOm
 JQkVf86QX5GIAKGAz0vg+fDPXNKoUou2QnGu/2iNN29/jr/BIcMn4m22Gjb6SR6alIku
 4t+fUAOibj2L7GOvvb1fTrpXdMhyxHMgzUbG1IrlyIDkMtIgveTL5STGMWFRLryv/hCg
 832A==
X-Gm-Message-State: AOJu0YyJ70VgIeKZV07qsFeog/qIGZ1zbzbwCEShcAvInAyisDogeErk
 AphfuwW4Jk+y/mvY109f3JiVe8GQ40/OQQ==
X-Google-Smtp-Source: AGHT+IG1C6Te5MQEAIq65GmTlp+1n8vuAKE9/GvAtkYMeGAJTMkCTuVeHHtcyMVWDr2EXxisLTQXGw==
X-Received: by 2002:a05:622a:3ce:b0:427:7da3:13d5 with SMTP id
 k14-20020a05622a03ce00b004277da313d5mr136635qtx.39.1703181223474; 
 Thu, 21 Dec 2023 09:53:43 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 ef10-20020a05622a53ca00b003f6ac526568sm117680qtb.39.2023.12.21.09.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:53:43 -0800 (PST)
Date: Thu, 21 Dec 2023 12:53:41 -0500
From: Tom Rini <trini@konsulko.com>
To: Moritz Fischer <moritzf@google.com>
Cc: sjg@chromium.org, bmeng.cn@gmail.com, xypron.glpk@gmx.de, pro@denx.de,
 marex@denx.de, stcarlso@linux.microsoft.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 RESEND] pci: Enable dm_pci_map_bar() for 64-bit BARs
Message-ID: <20231221175341.GK2513409@bill-the-cat>
References: <20231217005209.2789651-1-moritzf@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CCfwjY/AXVKNqn1Y"
Content-Disposition: inline
In-Reply-To: <20231217005209.2789651-1-moritzf@google.com>
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


--CCfwjY/AXVKNqn1Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 12:52:09AM +0000, Moritz Fischer wrote:

> Allow dm_pci_map_bar() usage on systems with CONFIG_SYS_PCI_64BIT.
>=20
> Reviewed-by: Philip Oberfichtner <pro@denx.de>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Moritz Fischer <moritzf@google.com>

This causes a failure to build on qemu_arm and a number of other
platforms, thanks.

--=20
Tom

--CCfwjY/AXVKNqn1Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWEe5kACgkQFHw5/5Y0
tyzC0Qv/Zo6W9pTOaHQjmbXq88942pCgBO1XCm69fuPyr+lXUq0jC72qrAUl9R5p
OzBBKZSP9Xg010q1yRmQYhrXdF14Qwx+Iwi7MpHH4WoRC25bq69def4PEfRV0D0u
Z+UeciU0jc9zAsx+YElKRy3LqBikzn2DdghPwzXO4EnJJxH6dhVj/Mz5NgeVz3/N
2CQGRqsQ2715F7fNLz1ugxgjbXAO5jrxz+Bk5R7pMSO33Qr4j6AKbgzoLbT0Mdxx
2Eq3eV2xgssV3Cn/uOZCulzcam/2HDPZMUKJnu/b0EqA4WXe0CYh3CiqQFH0CWhh
+wIFmNvFf8vB1jiprGnQXJvo4LgMBPU6sbF+OoMimvu5jaj7uuo190Z8OS3Oeap9
5l3srZKqQtnddE/Z5T+FOzMYRydibkuAp85jwtL4mxmIRbeB5Lu9EPNBi9j7QzQP
GoxMYkrRo1N89WHoCsctk9p4BV3681hnanRJovfv/ojl76YPzGiGN5rBlUulzisP
pE8O0dMu
=JY5z
-----END PGP SIGNATURE-----

--CCfwjY/AXVKNqn1Y--
