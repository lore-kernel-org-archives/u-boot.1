Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB15C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 14:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED416882E8;
	Wed,  5 Jun 2024 16:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N12SPVaE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58A0C882E6; Wed,  5 Jun 2024 16:35:24 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EF67882E8
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 16:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-24c0dbd2866so3091908fac.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717598121; x=1718202921; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lkn8mWLp+0qSzwhb4tRl1txQFtp7e92bY82ED5o9LHI=;
 b=N12SPVaESfdUVVni1Ik2LrKBwYwc3Dtd4SmJhbT3FzSpf5hzqTxoC5sdafWlqXUrxi
 7n6UK9hlPAjQtyRt44a2SOyE1OO0lVefIg6wmzYssXEqxRlcvEK62mrMQ/2g11h9hyXb
 kPSEgZumYG5xSIAFMNaKt51RaO9zUt9NwgFuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717598121; x=1718202921;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkn8mWLp+0qSzwhb4tRl1txQFtp7e92bY82ED5o9LHI=;
 b=v5/C/h8hZwngPgY69wydX46EAHi/O7tp8l92TxAhWcTRPfZ79ExmblpGqYPmN88Aw2
 aWGwk1ZFU9nkCCiNERsiEPR7aQe68xFI2h8ncfcgnmLhherVS0CF1XIo3CAjjM/8u5/2
 +svoTPu5w+oyW3qWQFkMxGfTgvZJwM5ONrpmP4N37z58CYrfPtlvW7pr1B2UzHrBdWV7
 sM3x9eCODlrk5wGBB25Amfkcvzx5VEB6ffrrEvnQJ4waWaEh0DKgcaVBvO6hmnWWQ5jK
 yvCUYgm8rscMO6UrROr2YfQP1+xgitKV4N4mcmdcfvt8jiQ7/J9aJb2LO2elm+QChlvp
 iTsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdHo3+tanr4z/+45MT84M/KO8GtNV41kHYA3FLwgznUCRCGkQ1p6/PrqL16PPCz2VHXw/UqxoyxkyJuIBYke6Eg3tGEA==
X-Gm-Message-State: AOJu0Yx8kZ1MFfc6daJl9EGWKN6bOPUDLxwpGNs3wrBt1rbL3RTdRW0h
 qy5/lA5OSpIYuX5XaLR4x5fky62xGK/bOGTyJ0uKZWJCIz+NmAh/hSXZ6+Ht25w=
X-Google-Smtp-Source: AGHT+IG/eXzqaf8jggGTpOGGFXliBRzMXb2t5nd7pjSZG6vvXX1fUJAPNwb2+BYwsLCq046ZtC6Zow==
X-Received: by 2002:a05:6870:eca6:b0:24f:dd11:4486 with SMTP id
 586e51a60fabf-25121fec0e0mr2994740fac.36.1717598119401; 
 Wed, 05 Jun 2024 07:35:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-250853e5f19sm4018433fac.58.2024.06.05.07.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:35:18 -0700 (PDT)
Date: Wed, 5 Jun 2024 08:35:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: E Shattow <lucent@gmail.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 0/4] Sync StarFive JH7110 clock and reset dt-bindings
 with Linux
Message-ID: <20240605143515.GP68077@bill-the-cat>
References: <20240603132721.6522-1-hal.feng@starfivetech.com>
 <CANV2PTPjbYEWr67bMSM_fg3kSS4Q2kDYdcHTLVp0CrQyeT=dbA@mail.gmail.com>
 <ZQ2PR01MB13070E142612139A6D955820E6F92@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BMCEpGI7jUP/ooaM"
Content-Disposition: inline
In-Reply-To: <ZQ2PR01MB13070E142612139A6D955820E6F92@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
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


--BMCEpGI7jUP/ooaM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 01:56:13AM +0000, Hal Feng wrote:
> > On 04.06.24 04:32, E Shattow wrote:
> > Hi Hal,
> >=20
> > Instead of manual dt-bindings sync can we please adopt OF_UPSTREAM for
> > JH7110 ?
>=20
> Yeah, I will try to do it recently, although I am not sure whether the U-=
Boot
> drivers and Linux drivers are compatible so that they can use the same DT.

They must be compatible so that they can use the same DT, U-Boot needs
updating if it doesn't match.

--=20
Tom

--BMCEpGI7jUP/ooaM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZgd6AACgkQFHw5/5Y0
tyy9PQwAuN1JTsqntg+2Q+hMKOiOFSZKaPkQECbhGE+12phxfIOKUBmc+dM5iHfV
qygD+JiFDHmlXeVpdtsjY+2RfkMAi7rHiHGDnNygkBaHq6+xbBzLvfiNIYcEPa0/
8cFSVu6KhNIpFpRgWnyvl8maN0B2J0msxww2gUg3yHksb1uG8tenSRJffHeCKZlz
Tn1ujMDS930Prl4RHWRvk7otcDcFzTBs6OXyZubkEeuQZoAMXFsn6bwK8terQLdQ
haf0N/m8Pn2Qwj/B9ItiDFsMIosKc04HCn9ZVbO2K7reOXs2toc558jQ0WFQ1bgc
sk+ui/146RUDBNZO84V+Lak19sMTFrh8VQBB9liqGdpxQeGP5YxxHxfKeRGJitnJ
S9NzWYgBF+HIaJNBXS/pTf92due5Kua7ptRnIGH0DOlChSh0X5VyOiI255Xdk+P6
LkBlwhEEhhd7UW9sVJGwBVkGxkx+F9PMpyWQ6/1YZ7GWERHU3m0L7w21vdLsyGKW
I86xg93h
=BJgQ
-----END PGP SIGNATURE-----

--BMCEpGI7jUP/ooaM--
