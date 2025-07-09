Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D80FC83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 09:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A71D083423;
	Wed,  9 Jul 2025 11:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="i8IOliXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5722283439; Wed,  9 Jul 2025 11:24:28 +0200 (CEST)
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 266D8833F9
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 11:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail2; t=1752053065; x=1752312265;
 bh=OTynS/OM9CFel2CS9jWZ7kGw9QFROzwTs+jU8+SZLGM=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=i8IOliXGseuaApxanQEGzI49ZGcSCvq8mPlmjcXkGXboBBNDIjpOHq0yEkT9ryNmE
 uFzHsYf8/xvbUL2pysJBQvE5B/275xhvrhapNYVqOWT0/11UfSlTamH4Ht1gsnTJcm
 tMqhQPU+OZihsna/CLzSZ69rTW0xXoyGyir6Sz5U9uQaMHCDtRXkhY2YzDUZovEL2q
 fSpYnqWznPFD1hl0YDWIbgLB854i933N5hU8aBVNmTGxvb8xUIn66LUd0J1EFiJb9N
 fjKiRwflDNQbGL/T6V6HhYBF9m331eRMa3KmWgmDwuEvKGKx1PX33KnLTlpGywe186
 JNb2AWrWM0qtA==
Date: Wed, 09 Jul 2025 09:24:16 +0000
To: Greg Malysa <malysagreg@gmail.com>, u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: adsp-linux@analog.com, Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>
Subject: Re: [PATCH 08/10] board: adi: Add support for SC598
Message-ID: <202e6781b0df0e8bddd2ae9b2bde0ad48f24f7eb.camel@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: 9bbe2ba8b92081a1fbc3e36aafa408f33323d551
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 2025-06-02 at 15:44 -0400, Greg Malysa wrote:
> > This adds support for the Analog Devices SC598-SOM and configurations
> > for using it with both the SOMCRR-EZKIT and SOMCRR-EZLITE.
> >
> > Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
> > Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
> > Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
> > Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> > Signed-off-by: Greg Malysa <malysagreg@gmail.com>
> > ---
> >
> > =C2=A0arch/arm/dts/sc598-som-ezkit.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 166 ++++++++++++
> > =C2=A0arch/arm/dts/sc598-som-ezlite.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 82 ++++++
> > =C2=A0arch/arm/dts/sc598-som.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 237
> > +++++++++++++++++-
> > =C2=A0arch/arm/dts/sc59x.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 183 ++++++++++++++
> > =C2=A0arch/arm/dts/sc5xx.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 137 +++++++++-
> > =C2=A0board/adi/common-sc598-som/sc598-som.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 34 +++
> > =C2=A0board/adi/sc598-som-ezkit/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
> > =C2=A0board/adi/sc598-som-ezkit/sc598-som-ezkit.env |=C2=A0 18 +-
> > =C2=A0board/adi/sc598-som-ezlite/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
> > =C2=A0.../adi/sc598-som-ezlite/sc598-som-ezlite.env |=C2=A0 12 +-
> > =C2=A0configs/sc598-som-ezkit-spl_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 123 +++++++++
> > =C2=A0configs/sc598-som-ezlite-spl_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 123 +++++++++

I assume `-spl` was added to the defconfig name to distinguish it from the =
defconfig enabling falcon mode? Seems like it makes sense to remove it for =
mainline.
