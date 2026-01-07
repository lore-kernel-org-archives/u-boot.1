Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD13DCFD624
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 12:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252C483AC5;
	Wed,  7 Jan 2026 13:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dOc8xyV5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8992836AC; Wed,  7 Jan 2026 02:04:24 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7641F80050
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 02:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4557f0e5e60so1008197b6e.3
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 17:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767747861; x=1768352661; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G4pGzZvLHZHtOpZdh9fFJIUBKBlFC3VhwwgXs0cco+w=;
 b=dOc8xyV5CYhgpGUZEiG7f7HFAGKfOvB+Ukkw8PbSCNGU8CZ5Ghs64aVdlQEOeu908X
 3ezjMx1zt8vg98IO4qheB+tET+rGE5G4DGrb3gIfdPbA1yH5VB5kBAooU3Df8pLtB9Gk
 VJdzUMq9P1U91O9kyvVph0gtLHBPCiTgt/la4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767747861; x=1768352661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G4pGzZvLHZHtOpZdh9fFJIUBKBlFC3VhwwgXs0cco+w=;
 b=iJDRHmb/CEaGAmVJU0hCCSdIoXgPS5bQVNSBlh/UrgdzoKhK2eE0rO8UvoKPJfyKgj
 QWHIEypn7pOfyMH9pZb0QZ+tM8vxAm5DtUheCCl5j02cURmePB9BwiRtSUMSi9jRV2i9
 ZIRJ4NiVVAwRQMGnKD6Ob1F2+qfEfUM22WCGZsHwReWmgvFxfnBNkw69ywkhhWW0w7uX
 FTj7S1rzNAm0TqGZWDZZK+IQ+3jcmVdCDTw+bf3NN58zkYD2aRUbOeavG/hSWhidjNu9
 N+j+pKXnjmEDwxAqBb3DbsAvMt7U7AIAmY1U0hEklWbAdQgrZVjIE+5dKjdam4QpkKXQ
 O3DQ==
X-Gm-Message-State: AOJu0YxVo3KoENc2gtEKUSpgDmDJGWiRP39lZDVs/9EOOOlJfS9PPkQ7
 nhxTVvbQWDwj4ZKUsTsVAIwgcIVdYQXFMkDj3cUzwC0VYzdEFBsHChxfniivz99Pxik=
X-Gm-Gg: AY/fxX6e6PfP5aeeN08vg3odCUzn4DxHxmPTM+N2P/LuF/cjt/YJZk+wQRT5xECZO0j
 Sp5LLqF6tZYPpQWtbV9IhyuiIuFdChxmzctHa2Ulb4SPh83R0amy54nbRFnjyzUmH2illDPTZmt
 7UKYs869i61eDu52LSTYvrCACUp2Qc/ZI+vPpHHeu+a7x3pkTQ4qbRJvwfUwXzouFqp2DRyjAtM
 DzfjM8nYxwjNcdzhY4nLtVY/35JBmNV7rMLPOf5frneOA23Lld3xRAfODc3PAymtHuToFq2/42v
 T4YbgkTMFfZWR2auBMMLJM31JYJVUmpRq99/Fk/eiKQHSfJKsGYnLLX4pWtbY8QSjdpTkYNSORj
 PoEH7I4A/p+/Ix7s7dTB3QfpN/8lEv3W0sevPoAx2t54hkTVzwFu9kW2PC35TopofRBezreeJfE
 9O5Tp8QgEmDuz8gr+qZc/6Uq0n4zDU/ZYEjqwcxILADFZxgt1ycVB9BH58TMr6jVJPS9pYfXsHH
 2WJ4m1oB8oZo/U8olOH1iJbANJR51OWUW1i8Po=
X-Google-Smtp-Source: AGHT+IHDF+A7KIPDVOVIlRzUsr71zz2BsLbHLlYgqa7g7No9RBRiH+nhQ2KPZ0hkuGhvx0Cw+D8rxQ==
X-Received: by 2002:a05:6808:4f66:b0:455:830b:14fe with SMTP id
 5614622812f47-45a6bccf4d7mr464577b6e.13.1767747860961; 
 Tue, 06 Jan 2026 17:04:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e2b74e0sm1719723b6e.16.2026.01.06.17.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 17:04:19 -0800 (PST)
Date: Tue, 6 Jan 2026 19:04:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Bin Meng <bmeng.cn@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>,
 Rick Chen <rick@andestech.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: Re: [PATCH 00/10] bootm: Clean up arch-specific, pre-OS clean-up
Message-ID: <20260107010416.GM3416603@bill-the-cat>
References: <20260107003131.3064800-1-simon.glass@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kESwPNEqlxixVDxh"
Content-Disposition: inline
In-Reply-To: <20260107003131.3064800-1-simon.glass@canonical.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 07 Jan 2026 13:39:07 +0100
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


--kESwPNEqlxixVDxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2026 at 05:31:17PM -0700, Simon Glass wrote:

> Each arch does something slightly different before booting the OS. Some
> archs even do different things depending on the CPU type.

Not that you should v2 anything right now, but, all of your patches are
doubly signed off, which is wrong. And, since you're no longer at
Google, for stats purposes, where should your contributions go (and
would you like any previous pages re-generated) ? Thanks.

--=20
Tom

--kESwPNEqlxixVDxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV2xCwAKCRAr4qD1Cr/k
CubvAP9VBaXd28ayGfqFkq+jrBJvN+P0+I/tRCrPTQd3tM8xgQD/SyJzcVYOdg/l
V1qQMTUIHGshLgNe5fSWDnrUXzXlugY=
=zQQV
-----END PGP SIGNATURE-----

--kESwPNEqlxixVDxh--
