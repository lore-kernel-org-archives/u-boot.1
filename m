Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64DFEE49A5
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 17:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D426B86F9B;
	Sun, 20 Aug 2023 19:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N91fjbj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D227086C35; Sun, 20 Aug 2023 19:38:26 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEE0B86C35
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 19:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d73ee75a796so2577833276.0
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692553102; x=1693157902;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KGDhHDOpfct4+rvQ5T+iYsymM0gibihyA9GQgU7/bK4=;
 b=N91fjbj7LzZaRH8dCs+VWHfMNU0x3ImEglaAEDY911UN9fQTclC+6FdbQ/CO37PFJj
 4NQU3Thoy/O4vikRuVxY/J8no4cODpQdvn2OjKG+va/LFX+bJzSwJ2v/CLvxxse5sg7o
 ZCv1245PD0Qs3fsgmBmPnAqAeB10FRwgfGxjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692553102; x=1693157902;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KGDhHDOpfct4+rvQ5T+iYsymM0gibihyA9GQgU7/bK4=;
 b=Pvh7lAuA0+CQOVve6BZvPAvx09N+OtUwoURITRyUCZmis/uitTBfl0lyzKvsxTSZVZ
 iFYzM3yicBdA+b97oP/9sYHgkMO49Tf6VjywcfNaXRJmqGW40h0GgHrWIf7zTRLQ4EzA
 DKxY11WcJyUIT9Af26CcZfC1E2RmmvaPEzWLNIqjofuo2t+FAOLJOGOxcwKiZ9mHVU8T
 2D72I7PR4UytLd67wY/nfsoWonkdm4m6v6PUzl5UakOoxnKTY7fQmLVVlauwnGRFMnhz
 bgTDFWm4FGKr3DgXzuVGDMaxQRhHCvvNX03w8X1mX+0EKPCsL7HGxGiV+QTY2fKO5fej
 1hRg==
X-Gm-Message-State: AOJu0YxWNtOQgr4nVPKJsb9bS8vcVZhcosqc/32E63xcGyUCKFPv+6oT
 boGhfpJRXpjhhjQX3lAgEtDVMg==
X-Google-Smtp-Source: AGHT+IF2jYB3Fn+EhYoBGsHaNWojQNNumk95CTOvpyJkx9CaqMRSPBcJJm1zFCVvZjV2TurkFPYt1Q==
X-Received: by 2002:a25:b90d:0:b0:c60:982f:680c with SMTP id
 x13-20020a25b90d000000b00c60982f680cmr4791818ybj.63.1692553102323; 
 Sun, 20 Aug 2023 10:38:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2d48-63ba-cc6c-366e.res6.spectrum.com.
 [2603:6081:7b00:6400:2d48:63ba:cc6c:366e])
 by smtp.gmail.com with ESMTPSA id
 h186-20020a2521c3000000b00d1d0841d911sm1537020ybh.17.2023.08.20.10.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 10:38:20 -0700 (PDT)
Date: Sun, 20 Aug 2023 13:38:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/master
Message-ID: <20230820173819.GQ1515023@bill-the-cat>
References: <20230820014328.779175-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4p1on/Q8RnnXGY8A"
Content-Disposition: inline
In-Reply-To: <20230820014328.779175-1-marek.vasut+renesas@mailbox.org>
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


--4p1on/Q8RnnXGY8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2023 at 03:43:28AM +0200, Marek Vasut wrote:

> The following changes since commit a5899cc69a99379f01e8e2f9f98e0e09b24f16=
56:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-watchdog (2023-08=
-10 11:40:09 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
>=20
> for you to fetch changes up to dbada49554edd16da39134815635fd0015725c9e:
>=20
>   arm: rmobile: Fix off-by-one error in cpuinfo (2023-08-19 16:34:41 +020=
0)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--4p1on/Q8RnnXGY8A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTiT4sACgkQFHw5/5Y0
tyxQygv/V404P4ao+B1kxkRtwYczxuWykxNuo+9CqxyVDzF26LeMNcw1Qa/JETVP
ss3Vvut8TiaYQmJsZgYQPLJz99BeNLoRuFOM9Cp0zfyxUipql5q1Mh82N7DKaucX
sQfVoNVTQBC3+/SePYhJqdazVwhcvfKaSoxyfgfThrXuREA/IIWz7NL5bjNWYYcQ
9a1arYxxH9Md2CxmR+RWpso92hYb7kJsaqFTy6rtCYfbszrjUc1uxL2zFI9D0HaK
ygxFhcStJ9Oa2YrukrZh+ULvloRHWcAPTq+UP+YoTKBBvkP58isxv2iWMTJANz8Y
63EzutlB+38PRhl3GffY3J9DZhZ9kbAiQHdt4fYMk3YkZzBKnEuRnw6ub+FsLLzD
b0vOnVL9i6IpAV2mAqProSFF6AxzP9bDkdqSCzdpsT6U4Tp2OCHlAkciUCsk4+X7
csCyCkb1k1esi82MBwRvHZnu/ylOBw6+nXikG4+7VfvgYmidZJepgatgvXDtzy/n
6oToc9F6
=SiI1
-----END PGP SIGNATURE-----

--4p1on/Q8RnnXGY8A--
