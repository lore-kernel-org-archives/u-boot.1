Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C35E63CA2
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 13:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE13783A5A;
	Sun, 25 Jan 2026 14:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="MU9/1n67";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 399BB83C4B; Sun, 25 Jan 2026 14:33:31 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916B583A36
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 14:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=benjamin.robin@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E43A24E42275;
 Sun, 25 Jan 2026 13:33:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9C3E66073E;
 Sun, 25 Jan 2026 13:33:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B1451119A80E2; Sun, 25 Jan 2026 14:33:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769348006; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=RBXr2K+52zmyuu8XWcPfN1dDrxLIwurGrfvWhq7Tau0=;
 b=MU9/1n67F7PVVkDhH3Y3CFX9muAaAmBTfaffgtis9rcKLAYwAYGymmz4kvVZUW37PvTDFA
 h49iDlDp2dCRjnO3nAmD4bh88Lhl/I9ArET7OaINVj3jNH0owBiLsQlSddf6D6/it/owgX
 ujTc11z6lU06Ks+UDRArxzBR1CQhjvS48z6gGBflsPwFme4OL8P97Bo6vndqUmwR1spdgz
 J94eCFGayQ8NKrcDhMWkK8QKvRgzy9q4K1aFTFtQWxhl6DvRir6+yDFDQb0WEWVV+1uV/a
 GIpFaHuzY3ycPUYAYa0f35q0W0MSZHrck2t0KUML/ZwGaUHSdohyXMcsOoTPgw==
From: Benjamin ROBIN <benjamin.robin@bootlin.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>
Cc: Benjamin ROBIN <dev@benjarobin.fr>,
 Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1] env: add w flags for net config in explicit write mode
Date: Sun, 25 Jan 2026 14:33:22 +0100
Message-ID: <8634622.T7Z3S40VBb@brobin-bootlin>
In-Reply-To: <31984d37-7857-f6f1-fe58-96d064d45019@nabladev.com>
References: <20260124054040.7597-1-hs@nabladev.com>
 <2397776.ElGaqSPkdT@brobin-bootlin>
 <31984d37-7857-f6f1-fe58-96d064d45019@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Heiko,

On Sunday, January 25, 2026 at 2:03=E2=80=AFPM, Heiko Schocher wrote:
> > Users who enable CONFIG_ENV_WRITEABLE_LIST typically want full control
> > over
> > which environment variables are writable. The new default behavior
> > introduced by your patch might not align with what all users expect or
> > want.
> >=20
> > Would overriding the flags using CFG_ENV_FLAGS_LIST_STATIC not work in
> > this
> > case?
>=20
> Good question, I have to test... or may Adrian has already done
> such tests...

Please test.

> But looking into code.. if we add this variables in ENV_WRITEABLE_LIST
> the results would be, that this variables are twice in ENV_FLAGS_LIST_STA=
TIC
>
> include/env_flags.h
>   87 #define ENV_FLAGS_LIST_STATIC \
>   88         ETHADDR_FLAGS \
>   89         NET_FLAGS \
>   90         NET6_FLAGS \
>   91         SERIAL_FLAGS \
>   92         CFG_ENV_FLAGS_LIST_STATIC
>=20
> once through NET_FLAGS and once through CFG_ENV_FLAGS_LIST_STATIC

Yes, the variables with the flags would be declared twice.
=20
> So, that is not good, and I think, code will find the first
> entry, and parse it -> so it will not work.

What leads you to this assumption?

If you examine the code, you'll notice that:
 - The env_attr_lookup() function returns the last entry.
 - When iterating over the flags using env_attr_walk(), any previous attrib=
ute
   flags are overridden by subsequent flag declarations.

> Should we instead in case CONFIG_ENV_WRITEABLE_LIST is enabled
> only set/allow CFG_ENV_FLAGS_LIST_STATIC in ENV_FLAGS_LIST_STATIC ?

I haven't tested this myself, as I currently don't have a test environment=
=20
available. Please test it, and if it doesn't work, the correct fix would be=
 to=20
ensure that any future flag declaration overrides previous ones.

=2D-=20
Benjamin Robin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



