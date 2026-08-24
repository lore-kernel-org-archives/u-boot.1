Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32AAC5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 15:21:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E931E6062C;
	Mon, 24 Aug 2026 15:21:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m8JoE9WQk5nW; Mon, 24 Aug 2026 15:21:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787584911;
	bh=m3Q89KsPQXYNt8clk0xfJjejHwg95exCAFSjPJM6/LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kuBtJs0sPNDtJKMDf3cUSDSJF4yhtHevBMS0YXX53bKqhWny3nKSDQen5xFgMfmWU
	 9Y9L9gNPFf3q1g189934NSikBdQE9Lx51/NWv4eOdYq9KFWZPjS8glT0+qfH5kntur
	 21p0Wx9TeqqzafqFY9DJReAKJGqaaGooG87+TjaZvu8nNbcVtx00urobleeLsNqA8Q
	 FUzacfc++T1cq0DGQd37chvpuA704cwUkNH0FoSkQF1Gh6dbOVj7xclEOFHeET8zYy
	 YQjBL/OGhTKhQrcdzi7aJQVRjB/FGlt6mHnsQZJgnWW6PAMxzrxF1JFk8I5WSNye8R
	 zwAYYdfPM5phQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99BF9605ED;
	Mon, 24 Aug 2026 15:21:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 638F6386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5562F80730
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Pad3WYEmw9D for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:21:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::a;
 helo=mail-oi2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=sTcvojES
Received: from mail-oi2-x0a.google.com (mail-oi2-x0a.google.com
 [IPv6:2607:f8b0:4864:32::a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A8888071F
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:21:48 +0000 (UTC)
Received: by mail-oi2-x0a.google.com with SMTP id
 5614622812f47-4aeb53198ceso1166685b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787584907; x=1788189707;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m3Q89KsPQXYNt8clk0xfJjejHwg95exCAFSjPJM6/LE=;
 b=sTcvojESrkZrQqKPAeroTRO1gb4FH1vHpPpy79Y3AlAAPg5cJeYnNbB5cLiNTW485H
 LAZ79ex/mO7qUiibY6AdTtcZXHDCFmd6YDR7GOo2rDhP6++APQIuzHBZJlG6HKOC5wh8
 v6tYpSVatbJmQuDsrBMfhgcXEvj47jVA2bM2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787584907; x=1788189707;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m3Q89KsPQXYNt8clk0xfJjejHwg95exCAFSjPJM6/LE=;
 b=WBPf5twxhX7jtGxZHkeFS0gBEo3MB4FoAlRps6BxTIEo/i0dt1gF9o9RGVqeZUqCXf
 deAPeuKo8pnAmFafURT3cwPzbqmWrqYFO4i1Ouhvax8XTdvXdllfcaIkb2y4WcdWn9/D
 Ih8q1PTs6RJXTdN9iEJ5GbgOGBIzA9VcIirjPfgs4gOtrshDMJ+A+EFlZ4daS4flUmeU
 mhYiosl399JlEooAB2jfky9vvzmerQUdWW2ACQbKq0kuo6jw/djjTiY7eNiz7O5tdeqV
 BTWeugwwlo1Ejm80ttZs7TTJ5oo523AmA8SlMdkSrTOqokCsYA1IFz0vOOmLju4JYHgQ
 HZrQ==
X-Gm-Message-State: AFuF++m8+IWuiPFXxmY2qn7gKfcxrRYblOTfuOvJpQ8AfG8p49xsf6wN
 qiFLhprr19/Ct3WFLO7hPsaw7vAl2mxA0TiSf++PypZNmsnMrDzjyGwHKRWC3sVw9Ns=
X-Gm-Gg: AR+sD11bX2JGegTT9P65jPeAOStlgLvkHkEwAcU4/J1NB0x0Jvr3jNbv2hV1QS0WDYj
 sh1JeDXpQUbZDJtp3PPYkv7ZPKPpuarMxFcbsSyxD2vm9fuPv/kpYE3lmRW2zlHaANwqrR90C+4
 k9aD52xOEcZeyrvSqC/iq6x3ENYmDeA3kEhmuC6fJPtA/nEwdO3/nBvII1ObXuR1QCSsumdVPdL
 gZeq7HJjxVVPvIQBuGdVJG2dZFRrm62tVY5gopzB6XIu1AWqkvZPoyTXoSK4Cc1SFbEfN8WyDji
 1sAl1jaVZzMS4gU5LTVdQTDUUA5NPzwIobMmQxtKsvLMeh+8jW5hc4N4ddcCVscOHwtsPRYvNsf
 MFr44OljXn3f45h4zL0oMmf3cHD2UZyHSu48hQTae0W+m1glnOLiBGQQDeoQpXbasPmEs4rIoBV
 /32m1JkP5XOOCFeeNpOX7WqQ46JZYCuL9CyEcIQTUb3GSfKG5hvNDyOVoxjSdHPcglHmg49Fu4q
 FiwyzBnjUtOuoZbdjUu2rtleRTrmrfA97P7dX5imMjGsWHm4zDCd/6wYXDH5XJXj31N0Ayfuv/w
 H09tXEa23g==
X-Received: by 2002:a05:6820:848b:b0:6b1:333b:ffcb with SMTP id
 006d021491bc7-6b1591d562emr19611556eaf.6.1787584907045; 
 Mon, 24 Aug 2026 08:21:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4638353a37asm5411904fac.15.2026.08.24.08.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:21:46 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:21:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com, marek.vasut@mailbox.org,
 Andre Przywara <andre.przywara@arm.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Subject: Re: [PATCH] MAINTAINERS: Remove unused emails
Message-ID: <20260824152143.GE523975@bill-the-cat>
References: <a14a6d0d7de1afe226edd49b3f683a3cf26cc50e.1787556953.git.michal.simek@amd.com>
 <76c794f6-379f-4ead-a687-d65a3f238df0@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6VA2vWnix9uihp/x"
Content-Disposition: inline
In-Reply-To: <76c794f6-379f-4ead-a687-d65a3f238df0@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--6VA2vWnix9uihp/x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 09:38:30AM +0200, Michal Simek wrote:
>=20
>=20
> On 8/24/26 09:35, Michal Simek wrote:
> > Remove inactive developers whose email addresses no longer exist.
> >=20
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > ---
> >=20
> > When I sent previous series I got replies that emails are not longer va=
lid
> > that's why better to remove them directly.
> >=20
> > Not sure what's the situation around denx.de but I see a lot of referen=
ces
> > to denx.de emails and also in git-mailrc.
> >=20
> > Marek: You have a lot of fragments there.
> >=20
> > ---
> >   board/altera/stratix10-socdk/MAINTAINERS | 1 -
> >   board/bosch/acc/MAINTAINERS              | 1 -
> >   board/intel/agilex5-socdk/MAINTAINERS    | 1 -
>=20
> These two should be also removed. Got it when I sent this email
>=20
> -M:     Jit Loon Lim <jit.loon.lim@intel.com>
> -M:     Dinesh Maniyam <dinesh.maniyam@intel.com>
>=20
> I think it is really good to do this cleanup.

For this cleanup, at least a few of the intel addresses are now altera
addresses. Do you want to v2 checking which people have been active
under altera.com or should I pick it up and do that? Thanks.

--=20
Tom

--6VA2vWnix9uihp/x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoxhgwAKCRAr4qD1Cr/k
Co01AQDfQn6Qbxiebv8cqdwNjNosRAXtRXk614Sij/ZZU7pN5wD+NYzqhZtYdzyo
DBiU2It05sN1X8PJOKWqokQSok2kXQM=
=Zt6k
-----END PGP SIGNATURE-----

--6VA2vWnix9uihp/x--
