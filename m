Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0719EBFD2C
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DB51841C2;
	Mon, 13 Apr 2026 11:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="t7/F+SBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2993841C2; Mon, 13 Apr 2026 11:51:49 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8622B839DF
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 085E84E42963;
 Mon, 13 Apr 2026 09:51:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CCB1A5FFB9;
 Mon, 13 Apr 2026 09:51:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 57C8E104501E1; 
 Mon, 13 Apr 2026 11:51:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776073906; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=dqC1N/EzsB7dvX4wmvGDySSfubQx3v3KIdqqgJtX7Zs=;
 b=t7/F+SBd4aDj/mJLIEe1NzC90Ig/0LYXeqlBolTkLNjY/KEBQ/wtB86tPpk5oq0MycYP0P
 gkq8fs8izqnBrEayrfogaDQONcZraMlfpQCxO6LRfQgvnRo0eQF3DxDKTiVCGrGidklJFp
 dZOKoenY4Vf3hnO6+VwvDwUIdWdkH3X0QdibF05NNxwwYxplrQGUTi6LG6HqDljhTIXp1K
 58CIw3t/UyeEHOaOqauLJr6aoBTgR6KiMyD74Ws4unhI6zR93ucMINotq7VxoXIidPW4yw
 Ttd80d7x6XDqlpi2Si/unlF4+211u7TpXqj12lNWwAE44BHF11Pb51v8AdiOfA==
Date: Mon, 13 Apr 2026 11:51:42 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>, Tom Rini
 <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>, Paul Barker
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, Simon Glass
 <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>
Subject: Re: [PATCH v5 11/12] dm: core: Split SIMPLE_PM_BUS into phases
Message-ID: <20260413115142.4e3ea458@kmaincent-XPS-13-7390>
In-Reply-To: <20260410-topic-am33-evm-oftree-v2026-01-v5-11-4b9c7aca0e3e@baylibre.com>
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
 <20260410-topic-am33-evm-oftree-v2026-01-v5-11-4b9c7aca0e3e@baylibre.com>
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

On Fri, 10 Apr 2026 15:31:51 +0200
"Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:

> Similar to SIMPLE_BUS, create a SPL_SIMPLE_PM_BUS additional to the
> SIMPLE_PM_BUS. Most boards will not need SIMPLE_PM_BUS in SPL.
>=20
> This is currently needed to reduce the SPL size for beagle bone black
> with OF_UPSTREAM enabled.
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
