Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3890CD80C1
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 13:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0F0486E0B;
	Tue, 10 Oct 2023 14:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a18pIpGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6C1686D9D; Tue, 10 Oct 2023 14:58:54 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2A6486B79
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59f6441215dso69012647b3.2
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942727; x=1697547527; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NgypEbsgnXyMgmjmcjcak3EJh4DyRHE2X+ufA4pmNDk=;
 b=a18pIpGsJvDVBsjGtXT9CEn8DwHIxGrRuk4zqQR9G4gOjK2NtcEh+WuNiXv5xfdpsU
 oHg0p4CN4Abj2Hz5zONRAo9YksoOfGvIO1QSElqY0t1kxBW+HkKC9BRAvp1LhvhdDNJT
 qK/k2sO/mOAOliytkmre93XTPrP3vo5QFwhXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942727; x=1697547527;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NgypEbsgnXyMgmjmcjcak3EJh4DyRHE2X+ufA4pmNDk=;
 b=TRySKfXEG9E88ynhM0H8Qoyec81696mfcXYZmlTpJwVrfmZ2DtIP2vKjgeDu993PLi
 DqUkdavMnBGva6SLU+i04pR5ufyGRrovT2rgOn4Uwm+c7scZ6+wSKcmtUxD71myRbL09
 z13zmdBhDUU/nYIOaJeaPJ01HxC1fHPB/VneXjWu4p17BcCSTfBTxE8OsiGcg8DBCjun
 eomvqaSe2150qNkWw1EZCkDTPrF5hlnTdf8kfmNwfQ0sevrb5VexNFEZFWETH68FS6hK
 NAmJSbDxvzaZY/PaJ8Wp3iacDfbxtb6UOBCYycAwSicZm1BwMGh12cPxGE0vCOnfWkAz
 L7VQ==
X-Gm-Message-State: AOJu0YwSIP2qGum3Yl+p/ZverP/a2jPKuV4yaJAn9L8rRCkuaL41s3CR
 vmBoERa6bza2fr4BwkrC80YxCA==
X-Google-Smtp-Source: AGHT+IHxn7WKMF16mvA50wpfFpFRxyPOTLSRxYmHSeAzXAoid3/DoLOywbaA8FiAItvCpQc+Jj8edQ==
X-Received: by 2002:a81:ab42:0:b0:5a1:e4bf:ee5a with SMTP id
 d2-20020a81ab42000000b005a1e4bfee5amr18003985ywk.41.1696942727649; 
 Tue, 10 Oct 2023 05:58:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 w16-20020a81a210000000b005a0f9718a5fsm4374008ywg.78.2023.10.10.05.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:58:46 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:58:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Patryk Biel <pbiel7@gmail.com>
Cc: u-boot@lists.denx.de, Kristian Amlie <kristian.amlie@northern.tech>
Subject: Re: [PATCH] ARM: vexpress_ca9x4: Add missing flash width config option
Message-ID: <20231010125845.GD2227687@bill-the-cat>
References: <20230920074120.394487-1-pbiel7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O/XrIlYnL4ojofNe"
Content-Disposition: inline
In-Reply-To: <20230920074120.394487-1-pbiel7@gmail.com>
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


--O/XrIlYnL4ojofNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 09:41:20AM +0200, Patryk Biel wrote:

> Allow for a proper configuration of CFI flash banks avaialble on the vexp=
ress_ca9x4
> board. Without this option, the CFI flash incorrectly detects that the bo=
ard has two
> banks of 32MB flash devices, while in reality, the board provides
> two flash banks, each with 64MB size. As a result, it becomes impossible =
to e.g. to
> save u-boot env in flash. According to device tree for this board and
> its implementation in QEMU, the CFI width should be set to 32 bits.
>=20
> After applying this fix, CFI flash will correctly detect both flash
> banks each with a size of 64MB. As as result the functionality of e.g. sa=
ving u-boot
> env will work correctly.
>=20
> Tested on QEMU 6.2.0.
>=20
> Cc: Kristian Amlie <kristian.amlie@northern.tech>
> Signed-off-by: Patryk Biel <pbiel7@gmail.com>
> Reviewed-by: Kristian Amlie <kristian.amlie@northern.tech>

Applied to u-boot/master, thanks!

--=20
Tom

--O/XrIlYnL4ojofNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSoUACgkQFHw5/5Y0
tyyokwwAslYVM4PWzEQZpl+5YPkd3FqlfiVE6sSK0MewNEOq/FZeZko++iV3kq5v
Y1nC2SMbsggWspwWv4Hn/YQWcXaBK24r6GF4fLD91Mdtx/BhkXIzLhBfYLMPem+K
acZUkZI79LWk8jKAvKhAa0yoTFEDuG1jiY7lcVX+OU+5oq7JYJf+flnDLzgyvi7w
+d1zEzR8qsWSVrhvCHrkV12VtlKhALSbjzy9HZkIwQqMZ97wm0pimPzyn7oGxqHp
hwTf/nppla1mkA1PLNFQawuIB025ZjJk3vlsAcxz/x2/jyy+cuax2HamaKDlpxxX
bpA29Bo0TMJTmTPwx0xX1dl819YmF1a1Fk5dKJlT0K1hWXafvZQye8Cj/KoGesH+
76oYPsxbpGgwjEIZGOSkyZ7vZGqKCWB1KaRO8jxbZZ4WX9Es7jGABIl+24bRI3vJ
LWCHElv59vuQ1zfDdRgGkIFZHpvlHkvVHAuPYdIAYGeo0uxp5CQlNlIoZMDBXDQl
HzXoSk9Z
=KMe6
-----END PGP SIGNATURE-----

--O/XrIlYnL4ojofNe--
