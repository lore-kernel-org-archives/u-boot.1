Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F7FC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 19:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574AB874BA;
	Fri, 17 Nov 2023 20:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RFVk0n5p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EE4E874A5; Fri, 17 Nov 2023 20:42:21 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D413E874C3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 20:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-677f832d844so4440126d6.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 11:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700250135; x=1700854935; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0zkZ61yWb6Qgj7rWsBnH2boRgiD7cpmz79MULqtm+eA=;
 b=RFVk0n5p9mVC8a1fF1iezvHCvnO9HB7zs7Smv/othtgENIi5aTJaE3tN0VQjdf9vXa
 sNWtAA2dPdUxyHOHqhUufnzPIFT0n6FGGojfqcn+A5wPzcXuA+SekX3kDH8TCotRTfir
 G6kthyHFczrSoehItx1N45gxub99pLutc9jew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700250135; x=1700854935;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zkZ61yWb6Qgj7rWsBnH2boRgiD7cpmz79MULqtm+eA=;
 b=vGzp42z+Qf2kSgNQl80jJEV8V45Scn/p1zEuMtGtkYkmYkZFurS7fhkdyfoCWYf9if
 8HRSjht5JqbN6HDPcs1pytqIVS3YeoIb9bY+pjmgcV2psckPY8togwsGJCAaERqnaqNm
 Nc3GW3YT9zukqN+XW+BepR5feoHM9D0XI/9DN4u1yG9EPxMd1BcYu9ipUVMnLxqhXflo
 qcvTCTJm/97H1Mh5j5kKLZ/sPHUjt7bsO6pTHrc0f3+NQHenB1fMnCcA5UVq/oDV0RQm
 TUXOD8GUg65A7sL2upRG8K2eLwInIoKGx4RDbjAAnsbPoIbMkFFDOcbFmu8bkFpuDWLp
 WLSA==
X-Gm-Message-State: AOJu0Yx/1dfZ3Is22eSBF8rXqZ4uy4iqppv7gRBP+s+uJS+VpTVnt1fb
 vZn0zt2qxmKooVcITUF+IbT+LA==
X-Google-Smtp-Source: AGHT+IHNKV/ex+mw1rNzdz3GiTJfse1t/OYADVwTnJka0Fe/7H2EgJ8tXo2co/XsPihqHHfjujiuyw==
X-Received: by 2002:a0c:8bc9:0:b0:672:e2d5:7a7f with SMTP id
 a9-20020a0c8bc9000000b00672e2d57a7fmr80787qvc.29.1700250135626; 
 Fri, 17 Nov 2023 11:42:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 z1-20020a0cfec1000000b00677f40b564esm760816qvs.117.2023.11.17.11.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 11:42:15 -0800 (PST)
Date: Fri, 17 Nov 2023 14:42:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Chris Packham <judge.packham@gmail.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Marc Zyngier <maz@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
 Simon Glass <sjg@chromium.org>, Ye Li <ye.li@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 meitao <meitaogao@asrmicro.com>
Subject: Re: [PATCH 2/3] Revert "arm64: Use level-2 for largest block
 mappings when FEAT_HAFDBS is present"
Message-ID: <20231117194213.GV170968@bill-the-cat>
References: <20231027002409.430285-1-judge.packham@gmail.com>
 <20231027002409.430285-3-judge.packham@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u+u6UlJGrSWd2qTQ"
Content-Disposition: inline
In-Reply-To: <20231027002409.430285-3-judge.packham@gmail.com>
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


--u+u6UlJGrSWd2qTQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 01:23:53PM +1300, Chris Packham wrote:

> This reverts commit 836b8d4b205d2175b57cb9ef271e638b0c116e89. This is
> part of a series trying to make use of the arm64 hardware features for
> tracking dirty pages. Unfortunately this series causes problems for the
> AC5/AC5X SoCs. Having exhausted other options the consensus seems to be
> reverting this series is the best course of action.
>=20
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--u+u6UlJGrSWd2qTQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXwhUACgkQFHw5/5Y0
tyzxJAwAsWXCV92pnr8mcwLP3uhv8Tm7tAyh/PDL00Ea5cLzQoYDAlWtSkKwEx4p
ebq7gkKggFPV4Njn6lwD5ro7jpr1oCL87ZXu1Xvx+CbfVnZS+Zm9Sd+ZmZmorrY6
1Ho4ZprgJJFeBwdPQcsMRyDfupr8GYUly2EuxJZbPAeOOZgwUprvnxZTsG+uujn1
B9ZMbeV3mRNKUzszfseSF40GiSIKB86ONc2IyhRbgR6ZTZM9kbfP0J3l3N2D1Uzr
llubdIP0qWKD80oiPgw2Hr5ZbbpGSVwpRrxF8aAmtPy4ITcAjYURk/TWx6eW0SvN
WvWsTFevpD7fDVj7Xvb4++ikRAMW5vkAId0mT8b49FTQJGnxi2964ueGGEGIT3/J
uU9RKiNHlkP0VGR+IVZpVSH3KOCuiYstrP3fzi5lSXb4riGQ4N4kDvLZmr096Pp9
a75xu3o7mCwRn1CqAUVJUlnkipU45/I/fRCd/LP8ICzUuU2FaBkUQsDjIx+t9j+A
6a70CbCq
=bomo
-----END PGP SIGNATURE-----

--u+u6UlJGrSWd2qTQ--
