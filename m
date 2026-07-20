Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BFAC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 15:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CF0482991;
	Mon, 20 Jul 2026 17:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bgIpt53L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7318A80517; Mon, 20 Jul 2026 17:42:08 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D85380433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 17:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7eb6573bd52so5484813a34.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784562125; x=1785166925; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hbwnJXEweHa7ml3YVI4R5k6Fl26RZoy0foG1iUaJeLM=;
 b=bgIpt53L6TukkpOHl4EAM+8QQ6psS6brsr+z8sAP3XfWmp3bFsloXnUHbvN5bBOehl
 rqIlBp4j85GjrprJys2Wu08XEN0k0cCiJo9evW9jBhcLCB0j34VsEL5Nlnb9EfxxJ9i0
 eucGH1WauVDsVkNiHL9R2YiwvJMnMZiyOFegE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784562125; x=1785166925;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hbwnJXEweHa7ml3YVI4R5k6Fl26RZoy0foG1iUaJeLM=;
 b=rxorsrZloZ8j5LtAT5Ti6JtGscr9daU49IUiHONzpascUno1O33VvVj2mMayrMpxV+
 sYaCs9Ik+Mg4HU4uB2VWexdZ6nXxWbyKzTnaOO+xTB73Ic0oCt7GxONPNkSrO8JuRVxt
 c2dN2hV6zNprxsy2ZhfPRK28UGDhqWg+Eo0I9A02FM03xVD6WVUF4OWMuRALFN5ArRhC
 fEyZEBHc5Ni47TGNs7FovAUw94iT7qDRhnlwu9Xx8e1drK0MwRF+E1rMf9vwVaaKqXBp
 aCfTCed9+8xMCn/KqcJTdVOeVPO2nkLZ5dakVcveitxN2N/Ukdw/0Dn4O9agtc9i31u0
 FTnQ==
X-Gm-Message-State: AOJu0YxfNNRnm9TcRo6EiErx8W2OnPywzPj8ECH0G2B56JhmV4R1MJqE
 PK+zC5R8eqYzaEa6/cducLqAOAhqxb18ecq+5OumZvXtdV4rcVnw0cFqPrcp24Bu5CD/nBAYB0B
 lieWDAaY=
X-Gm-Gg: AfdE7cmrzmKcogyLQ3E17mLmF0teja5PaeuqkeRVMi6kN6iHOwEJZVqVLceC6r38EnG
 eqvwgvLuOZN1dsm8sKGv+/bD/CJ4eODv8pU6ErQhnirJyONAz22wRrsvFR2npwAgX71KvJLHW63
 YYA2YPMOmTKpzu9wnr5gCtzFNJFS81fuec8gOzkog4o4qn6r/QoTlEZQJe92UWVbYZRTsTWuITY
 QeBPsKCLPVKJHTI+/riVj1gw0/CRK+mdx4QnAmm5uEmrFtQc252vqHB8A725NedFArFVRauPR9B
 UbbAf05qbNTypfho9IM2YLd0q5TySqTjYH3Hlo+DN/eVE7WvzDm+O8jVYVRHZUNzYMrySq+FRSS
 uNXFLs6hb6/qDjUyzADDfkNFJpYxNaL6t5aBonM8YaO2gm1+NIqnlxGQIgGT7NGn3n/HsiJNYmw
 84MTP4GsOaPiV12EqNH0s6fv8LLN9DU1QauYj/lSklMDQBqtIoUBfpUuIzBaYoXR7Z9IA+k2h9I
 YliaCzqIcgzEkdSO7V7E2z1tQ8b9xIg3opI0A==
X-Received: by 2002:a05:6830:6adb:b0:7e9:e8a6:6389 with SMTP id
 46e09a7af769-7ed9aa576e2mr7797923a34.4.1784562124953; 
 Mon, 20 Jul 2026 08:42:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edad91b8a5sm8401609a34.5.2026.07.20.08.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 08:42:03 -0700 (PDT)
Date: Mon, 20 Jul 2026 09:42:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] rtc: pcf8563: add haoyu,hym8563 compatible
Message-ID: <20260720154201.GA749385@bill-the-cat>
References: <cover.1784423738.git.daniel@makrotopia.org>
 <d9576ac4c07fe3055a76dcb1bd32ad605c9a68da.1784423738.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RoQOXL2g2bnLLg2k"
Content-Disposition: inline
In-Reply-To: <d9576ac4c07fe3055a76dcb1bd32ad605c9a68da.1784423738.git.daniel@makrotopia.org>
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


--RoQOXL2g2bnLLg2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 02:49:27AM +0100, Daniel Golle wrote:

> The HYM8563 is a PCF8563 clone with an identical timekeeping register
> layout and is found e.g. on the Radxa ROCK 5B. Match its compatible so
> DM_RTC (and with it the EFI GetTime/SetTime runtime services) can use
> the existing driver with upstream DT.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

I see this compatible upstream, so:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--RoQOXL2g2bnLLg2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal5BxgAKCRAr4qD1Cr/k
CqldAP9tNoDODqwq8K+n+J4FQHrCKKR8VMU5xOK1egBK+ElzcQEA4h6pW8VBA3XE
OHkumU1/e3q0NMCzZqrlN9dT9Kr1aQk=
=bG2k
-----END PGP SIGNATURE-----

--RoQOXL2g2bnLLg2k--
