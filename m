Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82782EE14A9
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 01:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4F848698E;
	Thu,  7 Sep 2023 03:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PCUIRUnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13FF186998; Thu,  7 Sep 2023 03:53:12 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4866C86989
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 03:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-591ba8bd094so4708727b3.3
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 18:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694051588; x=1694656388; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c7XFZMhqpEh7pmFw72kHftx5/ZZcFf1MVCw3mQg9Atk=;
 b=PCUIRUnnaCBI0O5GrjCPktyCaXXNeuvvoofOBZxjUcyxFjgaW3K8egMZTnueOKnrgH
 RmKyLwaRcY7wYmO8pD95C6ntup1B0K2aXqJySMpQdMJLSScgL0wCW7YpL7YLZWw2RLv7
 CO1P02q1UppAoc1YSfyQCln1HfbJIwvrxRTmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694051588; x=1694656388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7XFZMhqpEh7pmFw72kHftx5/ZZcFf1MVCw3mQg9Atk=;
 b=OQJYcF+cndUr3eaS7P07fWXDufHxmfqB9262i/LhpEvQx8+w64fVyQmsYrg/rZRnsn
 qRIEwJYfMfyGaWG0MBSffNpZ9uCbXY8RzXy5SlTJnKv/HaY/8OVgBLrFPtIq8uhjcZiO
 2AQVrlTleED/8F1OgHk7hdWAIVo25iAbLSy5Q/MtYomoT8xZmbjBGtYhKLdT57G5o5Nr
 nN2I59AHe371tSWmvH8HFND0ik13Oe8wL3AEcFo5Oqdziq9frfHHjk1GGjYzT5NKDITu
 5IJbcHz9X7/bp/k4HtNF8GcZkHNL6UdmLUfLEHQvymjiv/vidCCU6STsqHkX6mxToHnW
 kcIw==
X-Gm-Message-State: AOJu0YyitmxWMxuaoPo9BV1ywmgaxsYFLxAc0R+kyFfvcRSepeeXSNzj
 cvgDc76+yCAZ4XQu+3MLpBFHeA==
X-Google-Smtp-Source: AGHT+IE6y5UB8PEXxcJ3w4ofcjUWket9gS2n/X6VewEktVsT8d8uU/xdVP8/Gv7BNIl5cHV/EI8SKQ==
X-Received: by 2002:a81:94c4:0:b0:595:2de4:c991 with SMTP id
 l187-20020a8194c4000000b005952de4c991mr22411018ywg.29.1694051588107; 
 Wed, 06 Sep 2023 18:53:08 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 g126-20020a815284000000b005956b451fb8sm4051372ywb.100.2023.09.06.18.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 18:53:07 -0700 (PDT)
Date: Wed, 6 Sep 2023 21:53:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Mario Six <mario.six@gdsys.cc>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] test: print: Fix hexdump test on 64bit systems
Message-ID: <20230907015305.GQ305624@bill-the-cat>
References: <20230825081940.5866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7u86nSPltkdKoHxE"
Content-Disposition: inline
In-Reply-To: <20230825081940.5866-1-marek.vasut+renesas@mailbox.org>
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


--7u86nSPltkdKoHxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 10:19:40AM +0200, Marek Vasut wrote:

> Use the following regex to make this test compatible with
> both 32bit and 64bit systems. The trick is to use %0*lx
> format string for the address prefix in the test.
>=20
> "
> s@\(ut_assert_nextline("\)0\+\([^:]\+\)\(:.*"\)\();\)@\1%0*lx\3, IS_ENABL=
ED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x\2UL\4
> "
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--7u86nSPltkdKoHxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT5LQEACgkQFHw5/5Y0
tyyrVAwAnA3b+hmYC6yrQ9xp7R+niB88Tv5EFWvwwPkUmZ1YNHyMafU7X1s66xY9
AYM8RFluDv6gfA3PfaRe/GejLUuF3ANYL8lKKQhW7JhjB2ibsv0kD6e/uRlDlUi5
eP5OFpmTmOGrfsNdh05rVWb/DQ+djcg/ueN0y8nSLLNa4W/mdaUkbAAaiZH+/s7f
7fc91AzAPDRONdCwXwjaGwn7MWewm01IjFoSAXM1JFqAt7XKHr+VIMfY5hU4uVa2
oNyMMkGmZHgoGx38nTyVT9nr4lMqWi8n+Uj+7o6jpN2YNW4XkZNFnKUo2D8GsLUg
sFF7o0/uxzyFqtRjgUs+5TvriVCqFOvSWJCqleAhFmLmE750y/vBA/3SDfdVClcR
oH2OVyr1WqwdCRjpJJafHw+EzgAG3rwhE+valKyaHvTcEhOZl9ELEBQKxgOvk2Xa
IdRbXojbOgNAk/d9roMQqVqgX+ufJI4aTjzD0/ocEMo3B2g8lUiL1Nh4hx+h7dTc
kbckCrxP
=1mRO
-----END PGP SIGNATURE-----

--7u86nSPltkdKoHxE--
