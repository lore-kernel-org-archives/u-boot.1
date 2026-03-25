Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F0F103A99F
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 10:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1758E83E76;
	Wed, 25 Mar 2026 11:29:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WZaBxltJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 898D783AAB; Wed, 25 Mar 2026 11:29:36 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6044D83FA7
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 11:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 5D27DC580A8;
 Wed, 25 Mar 2026 10:30:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 99D99601A1;
 Wed, 25 Mar 2026 10:29:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 772DE104513CB; Wed, 25 Mar 2026 11:29:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774434571; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=MAUiYDrLDQcnYqXuYeZDi5Fzg99axSVXQYuPp3Z1UqU=;
 b=WZaBxltJCohaIsUf1SbIBnz65ujwWiB37tNtsWz3+cUbVPvx1M9FWjdwXQsrIbmNdDbNL9
 gtIjFseL1FN+dcdGy4ioFjUwhYTYAbA7+inKXdzar8tUCFT1otH6VMn1Z7TqKl0sIiamdk
 7/RCsf7La8uY13pc0EZOOcxt3D7oTPQIhEpvLZlxpjHEokYSr3BvPBwr9C7ixM/rDhcuxK
 U0uhWqPg6IotLRp9byLSlJjKLBgE2zWdC3kgIV3aIXCgBZsJ2CECebt60pAW7NZ05ZfHhT
 UChjbqoKP/iYadcWBkl8vT4SlEc6ENqPLeuNI1bV+CNIf+OzjRLMQbxoBfIP9Q==
Date: Wed, 25 Mar 2026 11:29:16 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: alif.zakuan.yuslaimi@altera.com, arturs.artamonovs@analog.com,
 daniel@makrotopia.org, duje@dujemihanovic.xyz, e@freeshell.de,
 hs@nabladev.com, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 l.anderweit@phytec.de, malysagreg@gmail.com, me@ziyao.cc,
 mkorpershoek@kernel.org, nathan.morrison@timesys.com,
 patrice.chotard@foss.st.com, paul.henrys_ext@softathome.com,
 peng.fan@nxp.com, raymondmaoca@gmail.com, sjg@chromium.org,
 stefan.roese@mailbox.org, sughosh.ganu@arm.com, sumit.garg@kernel.org,
 thomas.petazzoni@bootlin.com, trini@konsulko.com, u-boot@lists.denx.de,
 utsav.agarwal@analog.com, vasileios.bimpikas@analog.com,
 xypron.glpk@gmx.de, yangshiji66@outlook.com
Subject: Re: [PATCH v4 0/6] Add support for fwumdata
Message-ID: <20260325112916.7000ec98@kmaincent-XPS-13-7390>
In-Reply-To: <20260318112800.21578-1-dario.binacchi@amarulasolutions.com>
References: <20260223-feature_fwumdata-v4-0-680ea4ad6ce6@bootlin.com>
 <20260318112800.21578-1-dario.binacchi@amarulasolutions.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 18 Mar 2026 12:27:54 +0100
Dario Binacchi <dario.binacchi@amarulasolutions.com> wrote:

> Hi Kory,
>=20
> Thanks for the series.
>=20
> I have tested the fwumdata tool on a STM32MP257F-EV1 board using
> metadata with banks containing 3 images, and everything works as
> expected.
>=20
> Tested-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Thank you.

Ilias, Sughosh any new on this series?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
