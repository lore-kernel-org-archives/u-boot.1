Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D8DC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 00:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17BCC880FC;
	Tue, 16 Apr 2024 02:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jbVaaR0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C547488081; Tue, 16 Apr 2024 02:36:08 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44F1C87FA1
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 02:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78d7558bf10so346924985a.1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 17:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713227764; x=1713832564; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Uxvztcm+C+Kn7KVUMx7aWBbHTURkXL4/mDLjluwb/L0=;
 b=jbVaaR0DFwuSnLzMPd4QkhhX7pidTyxwWyshDedVm9+3gJOREDP9MNKZc3vSSnhKcl
 dd0KtSsXI/a3yRR34jNI/7ew8eUFe8ExL5cG0FgVumwKQo9Ep/p8bx2obAqtKj69MmcN
 Chh9C9kzNcDUJlwsGJ665DFa8yPJrg2yYU/1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713227764; x=1713832564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uxvztcm+C+Kn7KVUMx7aWBbHTURkXL4/mDLjluwb/L0=;
 b=wrki/Z8iWrver4NEGAzVynUVFvT4bjkfz4AYXfCTFKSVQSmaZ61WzHa7OCxLhfsLXt
 5mutX6ppLpf2jKe2DJDLOre4Q13LNb/Fo869lxaJDthJGEKQ61Zb5fXLBuzcw5F8UxhM
 VNXLxHg9VuZnxhP/CMCb+fo6wQ+hEn7R5BpsnX0RLeJ80CTTSUVgd85nFkJTQng85zTe
 sHA+E7aUmXSA0Am/MajsjZyRX9g5bhIsuZYvkxQsleeN+L5l3Baz7T3FPiYprCs7Ug2P
 IAvDCiVGPBE28Tuqd9BSvXbQDAWrQeZYn9buq0JExw83IYvZk8L+6e47hhs0YjSMxw1o
 zGDg==
X-Gm-Message-State: AOJu0YzIgn4yQ+Txm4Q+7XJtjVFTivl+qEzekFV9YoeLkfO05tVkEZEn
 dcSAuyh8PIsdKDEx2YgRsGP7Ng99TJOAexXY1V2c/rKfYOsJP+NrTo1WHSDWVapMW1xIspSzUKx
 ia/4=
X-Google-Smtp-Source: AGHT+IEgnSBo1+jwPcSREmTOfRdytBBWZhH60r1A2cvOQ6pWCzlHp6UCyes0ae3i+5kNEY+QzBA8eg==
X-Received: by 2002:ac8:7c48:0:b0:436:89d4:d5c6 with SMTP id
 o8-20020ac87c48000000b0043689d4d5c6mr15057973qtv.54.1713227763989; 
 Mon, 15 Apr 2024 17:36:03 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 z8-20020ac84548000000b004349bb95e01sm6660715qtn.26.2024.04.15.17.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 17:36:03 -0700 (PDT)
Date: Tue, 16 Apr 2024 02:36:00 +0200
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240415
Message-ID: <20240416003600.GH1054907@bill-the-cat>
References: <20240415123340.3620031-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vtfNsfRujzylyu9Z"
Content-Disposition: inline
In-Reply-To: <20240415123340.3620031-1-festevam@gmail.com>
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


--vtfNsfRujzylyu9Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 09:33:40AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit b03b49046af5dfca599d2ce8f0aafed89b97aa=
91:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2024-04-14 1=
5:58:31 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240415
>=20
> for you to fetch changes up to 8ecb0931940cc19728d686b9dba06585f4d93709:
>=20
>   clk: imx93: fix anatop base (2024-04-15 08:09:41 -0300)
>=20
> u-boot-imx-master-20240415

Applied to u-boot/master, thanks!

--=20
Tom

--vtfNsfRujzylyu9Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYdx/AACgkQFHw5/5Y0
tyyu+QwAk6rc7MYMArU4G5+OWkgfHcR4Ed8lWLMFFB4tK1M2HbuMI22ZP4fm7Xzz
01u2AeROrcl05ZcDVCeUAcF0kf7HxQyYbDwFsRLvWtEpXJ+9IT3wNJEOSQjfL1PO
JsWk+2cekJuDoTjNaPu0xcEUgFz8Qyc/uggd9MQZPusDkI2PGX1mvtK22RHeruCD
FeIID1z+e6d5OlbhkIU+N2RmQG5zTc98vARl1y5y8fxB8hC1m++1Pan8Eoj7gNt8
YlPUYrSP7jiEvbewMpodxA6Y0jrUB0O2nhDAW3Qa2s/pFgYShgnf0dEicL8De2EJ
/es2FPrFRVF128vJ7P9WSRm/KqgRJBeswWwffUqEDhyMrG/shZbCOMcSNw9rMkcD
hbUkSmuRbY019WNZ4aU1W9PU8Pew/ke44Irzk72SXZY5/B9c5HlPL7flgBosaczc
62SBoyxWce7i9+GaVaQYomkE6ZEfoZJx0jsUVM4psi1SkDmXtO5rx6yPT0c8Tl/V
NnKmRWo+
=okzj
-----END PGP SIGNATURE-----

--vtfNsfRujzylyu9Z--
