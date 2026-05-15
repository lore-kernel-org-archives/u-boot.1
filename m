Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395ACCD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74E68846DB;
	Fri, 15 May 2026 16:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eF+QTOws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47CFE846E2; Fri, 15 May 2026 16:48:21 +0200 (CEST)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC90C846C3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-479d593a0c3so1144660b6e.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778856497; x=1779461297; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IYJJ2k09ykrmdSGYvCi1A4ldhFDmBPGTLK5cg6Yb2VE=;
 b=eF+QTOwsHdwZydT8N3xtRYvCZoBBSPeDqi1ybKQy9zpsT8Mud0F/ff8Ya0eTj5AExi
 CVQ9ykUmALrE0fYT3KoaC0/v87XKTg1Kv+Ly4uUoccavB9wcVFcNuMDcPTElslbUpr+h
 cJEl9ay20Ifpt4WG5YeJl6D8yUtIRaect6aJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778856497; x=1779461297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IYJJ2k09ykrmdSGYvCi1A4ldhFDmBPGTLK5cg6Yb2VE=;
 b=Qoiq+qCoYBeDzaenkwVLMChRJxC45hzilzva19tAG6XqXOMmNs5tRV9Cd+ZhIBRlR8
 rpNAtFnTLgcS8mrLOr8FTvODC/vvL2OHGR8SDGN/UwwjSHm8/UgTpE5FqhCHqMl7UeKO
 MizBA9x62xXCHpBtuJqrVlks89ct+AFhTxvILJ/x9seyyrp+NVEoKHDUrrF2C8YQ32l4
 LFR9SnzwVlNz8AXK3QvZuRpJ+6FI2UFtQ8MoFPDLHeLILkEPLHSB9uthmXSraWjBcjGb
 /2OD7a4xi9+/b5cAfptjqQUSYa7q07DZno02K3OZwbzu0t7fO34eObx8LzkdceNGtcWs
 JlFg==
X-Gm-Message-State: AOJu0YwK9Y7L3ryesB+KY2eSIwTU4ITQfx9jyXsaLOAZueZJTVocybzZ
 KtU8IwOXDk3LuJL8uA1IY4w+yvya7RSpDqat/+v2kuZAMrhWGVznM9mvHLiJw2E2GFI=
X-Gm-Gg: Acq92OE89q/CB62GPuEzoZLK4DVwAarhZQIkdaMn8ttKW+mvh6ljiVBJa1O9wdnXNX9
 Jsz+zE+h+EOkhVDuFrelwYe+qIdYyh+sl6rczhDgOLujiqJbgND7sMX/6EcuIyCi6IciiqJGKk7
 +ZHTaod8Iso8TR66ozYZ8+NTgJmnSSqVxQD4EO2c/jlJws/+iE8s1OSB1T6e96TfIXf3qINnYpD
 h2GkSzCkHYGi1ObSUvXaXkHpyLKFJ3OpLyVsDyeTJxFx+VlY+EINEsxYw+GarGbil9puP09dqWO
 MSeTANNUVhb44uFlT8nAd2I695Eifcc+4+DyKLdZLdTtSzp+qgkDo5mgK6kUIpHJa+irgvmN+X6
 ye8vGDt9cjBj8TrzvVrGYcBlLsXX6Gx6hdzQOZbfjj7esW3JJZCYg/4iDfdGSzyuf6CdAZYyB6N
 xc5YCAZ5q+ySxzClk5EJXdF3z7PTzNfX/HO8comh9tPZcxbjZ77lyKahUUKv7fis58Edq/dJ+7G
 P380wJRdGUD4naZa+6430cY3jCi4etL/97fQ2tVhwAFFnmXsgE=
X-Received: by 2002:a05:6808:5289:b0:47c:7407:c0a7 with SMTP id
 5614622812f47-482e418bbf2mr2466509b6e.0.1778856497354; 
 Fri, 15 May 2026 07:48:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee333d00sm948460b6e.3.2026.05.15.07.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:48:16 -0700 (PDT)
Date: Fri, 15 May 2026 08:48:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ferass El Hafidi <funderscore@postmarketos.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v4 0/6] Improve FIT signature handling
Message-ID: <20260515144812.GA1858239@bill-the-cat>
References: <20260513141027.351280-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7Hq/umgxn5agtd8I"
Content-Disposition: inline
In-Reply-To: <20260513141027.351280-1-ludwig.nussel@siemens.com>
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


--7Hq/umgxn5agtd8I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 04:08:10PM +0200, Ludwig Nussel wrote:
> This patch series tries to improve dealing with FIT
> (configuration-)signatures a bit:
>   - make signatures work with QEMU. QEMU brings it's own device tree at
>     a memory address. U-Boot expects public keys in it's own DT though.
>     So merge both.
>   - (optionally) enforce signatures so we can't accidentally boot
>     unsigned fit images. Quite an easy oversight, esp when qemu
>     previously didn't even use the built in DT.
>   - make iminfo verify configuration signatures, not just image hashes
>=20
> The tests were created with the help of copilot and manual fixups. I
> have to admit that the log output of those tests is not something I can
> grok. I've left the tags copilot added in the commits even though
> checkpatch complains. Not sure what the policy is.

Well, part of the policy currently is following:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/process/coding-assistants.rst

But as Simon asked (so answer there instead please) what output is hard
to follow exactly?

--=20
Tom

--7Hq/umgxn5agtd8I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagcyKQAKCRAr4qD1Cr/k
ChUJAP97OujWjqlG1g9S+Y8YxDLWdZMp4DbikjDW2fVgSIdY5wEAgYzT8lLppLcE
aku3mbQ2LyZoRCue+Yj+c6v0SmzPvAs=
=mmBq
-----END PGP SIGNATURE-----

--7Hq/umgxn5agtd8I--
