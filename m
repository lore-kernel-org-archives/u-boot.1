Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0B0E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 17:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B228030F;
	Wed, 18 Dec 2024 18:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k0cdZl7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC949802F2; Wed, 18 Dec 2024 18:40:16 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8246180241
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4679eacf2c5so61762551cf.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 09:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734543613; x=1735148413; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JVsLyH8h9A6HyMut46Sp7xPCNuPqiS8NLTjIfjPc8O8=;
 b=k0cdZl7BRY6Aorh9/uBLjuvWYhfjQglMvg7cpUI29LCBHJFTtCM1IDBIC1FKmnDV8O
 hIqXPAVpgpDT4eJAiMtfQH7fhI89SUeq/Hl2HU8vJNXkLroZxs3NRbp6NjLJ7wgNj72L
 OxzYjoGr25agAtMgeKAnpETBLXBL+D87EjU10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734543613; x=1735148413;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVsLyH8h9A6HyMut46Sp7xPCNuPqiS8NLTjIfjPc8O8=;
 b=iBs6SEaUOnGDoqxK9Twm0KgRNa/roCyfv9UAThQws2xUfszRaWhDcrVILAGFyL9Fj/
 GsbyVq5AdbrZ+ZeVX9StLhuPlkbRPbm6MULG4Z5N2+10jpX7xrLdAnlWn5dxme7Siwtb
 +TcXU2tRfVFxSiU89wQjjGk2YLu0sgI2LscX8zTvhxVpXoPtbGpgxy4s1iT6vA3oagJK
 mA/pX6fL2oSOk/Yjwz9hx7Sm1e3nVHbNIiWthvLqpYaYMcvRlI8vE8y57/urGF+0EF9a
 DiJ+/1I5zvnmFzCgHC70ztPq3lDlV2CiLfIU+eD0C6r7dQIynW2DpUXBe4/H1Hnl2AXI
 XVZg==
X-Gm-Message-State: AOJu0YwTvVn9Sd+JfCRBDsjua7/g0NHbHqcQ1wFpwzCIos1w60kX3JA3
 1/OID7s+6K9/PnZIqruJvRmZIacgYS2lhUFCJJDBjUwXp/LPPqlvv0Ubr5vjQwRzvLGp3bEghxi
 X
X-Gm-Gg: ASbGncs359mUHGOHbdmmd1Eh+iUe/1+REhUjn1j0/VsotUnbiPnEb9qXG3Nz8UKVqll
 IWJ90VwnbRVskZU/RAm6p+zdekGSMEwd2paf9qAbMiib2X7SPVMyzyauO2j2gvsxkRpjN9P+UbW
 32bJQcJi2pzpUS7wwnSs89xsDJllo3DptKfvOEFk3HKpVN2s4TrM8WCtTR61hK9k+dvO1IVhFAv
 Y1UuQArrB5rBj1OArCCcLft7q7c2dMTUyWmOT4NZ3zv60S4suJZUY+m
X-Google-Smtp-Source: AGHT+IHr8S80AnLcK4VWNRI3ceQzYwynj7ewxrj2pOxlA57orgewAMiy+84B6uK+Vrdqiu2AOaIppQ==
X-Received: by 2002:ac8:59d3:0:b0:467:5e61:c10c with SMTP id
 d75a77b69052e-46908ca10c3mr54486511cf.0.1734543613368; 
 Wed, 18 Dec 2024 09:40:13 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2ca087esm53342021cf.28.2024.12.18.09.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:40:12 -0800 (PST)
Date: Wed, 18 Dec 2024 11:40:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PULL] Pull request for u-boot master / v2025.01 =
 u-boot-stm32-20241218
Message-ID: <20241218174010.GM1505244@bill-the-cat>
References: <b8bcc71b-f390-49bc-9202-0c3746683f7e@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+e5V/vrLzh1sbbBT"
Content-Disposition: inline
In-Reply-To: <b8bcc71b-f390-49bc-9202-0c3746683f7e@foss.st.com>
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


--+e5V/vrLzh1sbbBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 01:11:56PM +0100, Patrice CHOTARD wrote:

> Hi Tom
>=20
> Please pull the STM32 related patches for u-boot/master, v2025.01: u-boot=
-stm32-20241218
>=20
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipeline=
s/23931
>=20
> The following changes since commit 25fb58e88aba0c4af0af554d7b141be3f2e5e0=
b5:
>=20
>   ARM: stm32mp: Fix dram_bank_mmu_setup() for LMB located above ram_top (=
2024-12-17 09:14:01 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm=
32-20241218
>=20
> for you to fetch changes up to 06a8063ec95c127a8efea5274955bea6a38fc057:
>=20
>   configs: stm32mp1: Restore boot SPL from sdcard for Engicam i.Core STM3=
2MP1 C.TOUCH 2.0 (2024-12-18 11:34:10 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--+e5V/vrLzh1sbbBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdjCPoACgkQFHw5/5Y0
tyzMsgwAgrZoDbbCZUJ31N7BmcAGidf3VGtrU2VaKIWd2qoOtIKMdtGDfMEX4X96
E1/+MJOFjozsvJ+K4kxz+Z1BlSi9y5oNBdMYAJlVbHiMyHZMlAd1zHxHWA3UCaRc
AmFvppxSIdEDvZH6lRmEQY4WI+6stNjfMzbtxdLbW1AEOySFlm73JVDtUkAIbmkF
JLLDYl6KXwqM91+PAwpV/iiLuo6ZeeDkF3rxX/KJxSLa4+tYjWlmlf7cQbM7A3ga
EFMV/S7wDFzRze6CgyHQ14/zQzRjb5cXh/WQJbrBqQhFdMc3apeOeKkUHn9owyRD
mVNM4WAk4P/DgRgaok6YoMR/zXydkF/sh/7qJaH9HWob9VD2dx2FMBZGj5KdQVb3
W+FTAVtzY3jA5VfpVwu0H3IRoL7lBKeM+ijOXJon7ZVlUR88Nn6+p/DkP8bauFDj
dcN5o2+GD229LnwgDr1KoJIZyF/R1mjVNozqMJXdk83kzJfI3//b8SXxghk8IG6v
8ozmmXzB
=mbap
-----END PGP SIGNATURE-----

--+e5V/vrLzh1sbbBT--
