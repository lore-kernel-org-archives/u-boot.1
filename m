Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0725FFCB611
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 15:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A73083F86;
	Fri,  6 Mar 2026 16:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sxw7dlhv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D61C83F86; Fri,  6 Mar 2026 16:11:14 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDCF1839A8
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 16:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45f126d47b8so6459655b6e.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 07:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772809869; x=1773414669; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Tpmv95HfYxy7cDbdKs7nNpaLCSzxkwWULV4mOks4fsw=;
 b=sxw7dlhvwZHfexKHX3eaXFr3vCKoe16R+7+LB2pbMoJ4bgmk/mfHJ40BYuVo8GGLbp
 uAP67iPNSmLGfEJ14kZ1RMPgNpryY00/EuKNY+O3LQziOPNYLlKkoYVNFcPjNHf78QNz
 ykkdLuEbuNh4aPFqjniYCcLwgDdnPTSTU2wUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809869; x=1773414669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tpmv95HfYxy7cDbdKs7nNpaLCSzxkwWULV4mOks4fsw=;
 b=UX7xlFSGt38DpWqWeLUEtSg0tzruZWG95TYeV33d2gEAcDhP9amhOvtUqrNhIdgI6F
 sLNnE6aOZ4QzGPgycwx+I6ybTZb6QnrUcLKK0KD6tydmZHDDPxPPYRd+j08R3LazPTjD
 8wJRP7aELxz0qY03hfaD1BK1x9nQwEZqGWSv42eYc49/MOcI4qkFiubBUhZAlX4Adbc2
 MkgQRO1cgTst5gu9EmGES0QLT9rZ/QWcm7hhOf9qPgyojgLMAl193mA0CuxbWI1cAIwD
 wFkLQPmoJsdxuargk73ZZF+/GCEHCckRd71t9tw5YvD5hzZ2MwWa1Z+Fj/xLEgE6myFi
 PEEg==
X-Gm-Message-State: AOJu0YzdX8JT/v4B4bNRXfas0jh9liQxRgEgaqYAmsviaJQODJhkA6Im
 ZiMkO2YEKsJRRp6J261jzvD7ufXheKlRYmyjzv9mloA4HjDuOceRmnyAh22Rg7JjLyA=
X-Gm-Gg: ATEYQzzMBPg3zcCjeHM5Eoj0jTQZ/CB59sXJ/T6yzC1xNW/v6q9kvUAZCkpwzhxSAjo
 8Mn8xPbSdy1025sVfOqoy43BOcwFcrR8QbHOYCLOMJpbcyuUzUrOFmexlYph6uVwhguBlpkQfgP
 a8nGZVe4CPI00dfqwWNjErN7w3FanwNz1oddRcLCLQ71wBpfu//bWd4j3o3na5xSTwajfPAR5dh
 xWOC88Phcl042CvzofiMAcz61/Pqh9spxnwlVdECaDkrTsV1uOD1wf8jD9pklFmKJiUv4PyHbPg
 jbrAaP4pUXyQ6/C5+EKxG2cwZzl68Q8WfkXK/uuDgMOsplOt0IEqqtYrNeFhTRwOABYfB0wQmZt
 r5QbsNtUgBx63pgvcRODrMCJevYd6p7m7+fOFhV/F8+VOeFSstoH7X5eEGmyx9K61Oz+aG4lpzY
 WfqZ1EnAjeaP4DDQiMpbjj5oKlUE7IhyAOYGCaA/OBJp6RjVWnzgs6BlTlyqC6aoFFVURTapmBo
 znT9IKXq/82cpIvtK+5C7fOJk02wh/tccgQxBBEp/TZplY3wKA=
X-Received: by 2002:a05:6808:4f4e:b0:45f:66f:a2be with SMTP id
 5614622812f47-466dcb7e191mr1394980b6e.47.1772809869376; 
 Fri, 06 Mar 2026 07:11:09 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-416e6886c2fsm1581174fac.18.2026.03.06.07.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:11:08 -0800 (PST)
Date: Fri, 6 Mar 2026 09:11:06 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>,
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v4 00/10] arm: am335x: Switch to upstream devicetree
Message-ID: <20260306151106.GL1388590@bill-the-cat>
References: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YrKRhOZOrcP5y9ju"
Content-Disposition: inline
In-Reply-To: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
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


--YrKRhOZOrcP5y9ju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 05:48:14PM +0100, Markus Schneider-Pargmann (TI.com=
) wrote:

> The series is split into two logical groups:
>=20
> - Patches 1-3: Fixes for am335x-evm to boot and support the LCD panel
>   with the current u-boot devicetree.
> - Patches 4-10: Make upstream devicetree working with uboot. This
>   adds tick-timer, adds compatibility of the board code for different
>   USB probing and updates the defconfig.
>=20
> The series has been tested on am335x-evm. Note that I don't have all
> other boards built with the am335x_*evm_*defconfig, so tests are
> appreciated. buildman reports builds are working.

Bad news, good news. Bad news is that this fails on Beaglebone Black:
https://source.denx.de/u-boot/u-boot/-/jobs/1392729

Good news is, now that you have access to source.denx.de via the
custodian tree, if you use 'git push -o ci.variable=3D"SAGE_LAB=3D1" ...'
you can also trigger testing on that board (and you can hack up your
=2Egitlab-ci.yml and .gitlab-ci-sage-lab.yml to just test on that one
board for quicker iterations). I do want to warn you to not cancel jobs
in the Sage lab because I haven't added a "hammer" type job to
force-unlock all reservations, and a cancelled job will likely result in
the board being reserved and not released.

--=20
Tom

--YrKRhOZOrcP5y9ju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaruigAKCRAr4qD1Cr/k
CnIYAQDgTSBP0A+H9OlK/ErwP2/KNWq9fpBZiy5jKCBlU12YZwEAgUDWgKY5oGpN
eK/lqM+EzhvHvY1P99nzPoZxurtjdg0=
=STpF
-----END PGP SIGNATURE-----

--YrKRhOZOrcP5y9ju--
