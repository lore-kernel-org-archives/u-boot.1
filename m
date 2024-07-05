Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B31C38150
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 22:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69542889CA;
	Sat,  6 Jul 2024 00:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ttGxp0Cf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C047889EC; Sat,  6 Jul 2024 00:40:18 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EC9188636
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 00:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5c661df5db4so306400eaf.1
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 15:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720219215; x=1720824015; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dRmRE5xiD41emkozkHyA56tIlun7fA2TV7zxQuICWzg=;
 b=ttGxp0CfuEaiRmJ/yoGTq0w64DhgOkJ33ZqHZxj/Fk7AcSpifCjUI5dK2Wkz+KUBRY
 x7xjnY0YBvJkTMY7FQ1zGOcLKSOOCcPO/NgpdWts+bnSfUoxUDUCn2JI36gOYiX1F1f2
 4iwEh6Mc+LDjjetsoWLJoCadLa3qckrtgizAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720219215; x=1720824015;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dRmRE5xiD41emkozkHyA56tIlun7fA2TV7zxQuICWzg=;
 b=YSwSxE5M/ppJbLupHDoZnQKlkECMCbUihaKEEZmi3/7AYB0zMJaxPjuVtvvTNPZxGu
 iTRfBtN5W0+SNdtZyijYgqNhIZ5FXyTQble8mJp8n7uSHZTCRiMTqqsYADwjkdVEcb7X
 V5Yn36/kFvQJK+Srhnawfr+a3V+U31LMNt2WEFF6HFLIVfk9aewC7QCJT8XBDYdH9LdH
 UGXEZd8gPnPNgYjanieX2Ij6SQnwyOQ88/gGBK//CflwHbLtw91EficKto3lt3rPycu7
 YdciIk/VPopLA7Qzd+RXG2TbwvKY0typWWyoTljJBmz0UyckIClLJnJTR7j5tCtBe1+x
 NPSg==
X-Gm-Message-State: AOJu0YyPOgkMZ9D9AUU/H8DHjs5Cp3RUmLeHL+QUL7BdKn50xucGv0T1
 u1eBQKdDT4brT/hGHqSfcZK1rne9DodqZm+7VZup95yRdQ+Tl3rHQm9E6nGYlLbNKVFZDFl8a0T
 hDF+LEQ==
X-Google-Smtp-Source: AGHT+IGnGKabZpC+dcshHH+qJ3DwGnA6gyNgRt4y9diaELgStSyrGUGdZXRCyuEzdq3GaRJirWL1qQ==
X-Received: by 2002:a4a:5ac1:0:b0:5bd:c0b4:cf67 with SMTP id
 006d021491bc7-5c646de8d36mr1010680eaf.1.1720219214971; 
 Fri, 05 Jul 2024 15:40:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c4201326cbsm2246859eaf.18.2024.07.05.15.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 15:40:14 -0700 (PDT)
Date: Fri, 5 Jul 2024 16:40:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] e1000: add support for i226
Message-ID: <20240705224012.GW38804@bill-the-cat>
References: <20240624191532.57693-1-marjolaine.amate@odyssee-systemes.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OTgzy9UL13U54drB"
Content-Disposition: inline
In-Reply-To: <20240624191532.57693-1-marjolaine.amate@odyssee-systemes.fr>
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


--OTgzy9UL13U54drB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 07:15:32PM +0000, Marjolaine Amate wrote:

> This patch adds support for Intel Foxville I226
> devices LM,V,I,K in e1000 driver.
>=20
> Signed-off-by: Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>

Applied to u-boot/master, thanks!

--=20
Tom

--OTgzy9UL13U54drB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIdkwACgkQFHw5/5Y0
tywwwgv8CoOkkbcVhBm0ajoJdUaB71VA04Dc5LP4oJbVD4tN8sEW4RKirFuTpoXJ
Ldf/D7EQnK835MKb5oNB8lDrUQDYo6QrvpE4MfAirj91hYmd7mUqWKzCpkazRTx1
BRjyQKbeaq0zMPlOqZqlOpiUqfMu2qAhVJ73ODsF3XcTVRfZ4i5AlM0dLjoZkGsM
v/mtVtezI4/mFqAY6PQe718BTC54luB90OX9sxW4q50u+FsXGnYQI5GxrDb7q12f
LD3sUq5Tpjsu0Byq6N6eEV7wOBgV7NuF6Ojn/Nrly3HvXgsCrSW5omm9Cv6r9jaX
Jzhbg+nvYKFmyj4AA8bP595W0J0o+wJE5gPl9BS4kZh2M5RPQFfdpVOMc/H+jy+e
h+WI4hoTOv0AwnJGwfk6bO5K8YcvwLURf1v1Upb5NK8yRbxxNLMOZ3VgnxQFCaD0
E5IY+QWPQlx0ogsMFaE3E6vkjCIsZHtljTXxWCTufcQ7b4Li/duRhL5ELSwYe7gI
ovHpf/F2
=8C2g
-----END PGP SIGNATURE-----

--OTgzy9UL13U54drB--
