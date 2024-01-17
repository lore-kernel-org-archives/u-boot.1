Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CCDC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 14:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE52287B92;
	Wed, 17 Jan 2024 15:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UfoQikr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD7E87B92; Wed, 17 Jan 2024 15:26:47 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BF0387B93
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5ff59e0dd71so16683797b3.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 06:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705501604; x=1706106404; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iH4Q3fpSTCoocnhuziFoPzaL2GYbHXIBVxnI6CE9wDE=;
 b=UfoQikr7m56Ih9f7pkW9skGIl4tONWH+cqitIz3LPKsTR0OIm1/9rpidTw91hRDgJA
 YVruAnVUqE12Cw6NsKCsF8DqAB5tWfq7xXbZmD9rC4QAw/Jn58DxI6LlUu62viFb9IVe
 Z5fmXwO5BBjnFCfX+f0X+6AOdQ+pU3SBXxz2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501604; x=1706106404;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iH4Q3fpSTCoocnhuziFoPzaL2GYbHXIBVxnI6CE9wDE=;
 b=rJpL3liTFsZXDXADAmcVwMj1RRsmCaJ67rC72XIjkOdbH8JiCjnadypbV08tgsqG+x
 zYn59cdR99rmpfD0NYYnFx1/FXmdXtOuDlcfNJgqZupAGQWDt6J5mLbWvwLDpd2NRNpn
 vLxEDzDs4knsKQ7vMvuBaxhDFjo0ghK8KM3KEA2gLJahh58bTghUmWF5Pl7Zw+Uj4UpK
 iNoUMseVRqrmlUZEVXduN6C5cybtze/b3ROO85wbUsyYOmDk8tjQX6CQrZXe4tHwpgOF
 wsA9JFRP1gFm+IV1eKTfHNFp2+MF1cjUs79S0YtIh/hopntOdbsJAmnCxMwj/rB9i1cf
 Rlbw==
X-Gm-Message-State: AOJu0Yx6UfShVd54DXTUh6Kg9Ct76qsFqInGlM9o24V+XphumARM9jE1
 stBh7ypAbUHA4aU/GO8J0CvDBfNd/3z8Xy/lO5YXOJ3xfSA=
X-Google-Smtp-Source: AGHT+IGH4hfe59e5aeIA9ZXATXs6GfXESx6/9wD24s3F8DrazWjwDSjAfLU7R7a0XZonVou8TzwASQ==
X-Received: by 2002:a81:e602:0:b0:5f9:3694:3f7f with SMTP id
 u2-20020a81e602000000b005f936943f7fmr6232162ywl.98.1705501604206; 
 Wed, 17 Jan 2024 06:26:44 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 x140-20020a0dd592000000b005ff48b0ffd5sm1870016ywd.0.2024.01.17.06.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:26:43 -0800 (PST)
Date: Wed, 17 Jan 2024 09:26:42 -0500
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de, nm@ti.com
Subject: Re: [PATCH v4 2/2] doc: board: phytec: Add phyCORE-AM62x
Message-ID: <20240117142642.GP12635@bill-the-cat>
References: <20231220091811.80373-1-w.egorov@phytec.de>
 <20231220091811.80373-3-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eGbYKuW9CdcJy4hd"
Content-Disposition: inline
In-Reply-To: <20231220091811.80373-3-w.egorov@phytec.de>
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


--eGbYKuW9CdcJy4hd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 10:18:11AM +0100, Wadim Egorov wrote:

> Add documentation for PHYTEC phyCORE-AM62x SoM.
>=20
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--eGbYKuW9CdcJy4hd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWn46IACgkQFHw5/5Y0
tywWlgv/XM96QmZtPjdk7T6PopSuQ3YnK8KXOChK2oAm0NvpSz9jeK1i99i8sPZg
W4TdiBdGPHRrjZBy2AmCuqFLAznxE6a33tEz9tnMlU4Pbjq60prhkF2ccxSi2MX8
ftlBcuBCGz8VlgTcSbN0XLOFOu54QDxBYLwP6O9JqLZwIEHDBEX36F02dkhxMkh2
1LgRdy3YkARF5KKsxpAplNzPqbxpHvtnCJDT4M+7MF1wdIy1xeorF/kWLy0Kkk7q
7kVZOErbmemQ759pGb5l3IGA3b+VEpqpy+O1tlj4kp3TyZWGGQfxGP4eynMQcajf
G5tmqcbiO8P08+bRYf9QvhzbxjTsU6HfUfauewdef62ZoidM3Zuv8GN5FStpYHCI
70JejEFtRXlbVNLDpaHG/AhhrnIJVntUJrbwhYUFpU90pIsSip/MWSDjU/bdyTSd
cqw8Ip9S8wR7H170kFMjt8Z9OK0306x5Gj1jwrw+V7sbHlJloQwHeA3oFJUiqP8+
hpVOCFyF
=/Rtx
-----END PGP SIGNATURE-----

--eGbYKuW9CdcJy4hd--
