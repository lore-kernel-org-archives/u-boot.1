Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6844FEBFD22
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E67983F75;
	Mon, 13 Apr 2026 11:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="gGfEGBuM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0FCA841D7; Mon, 13 Apr 2026 11:49:31 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60EBA839DF
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 01E5F1A320B;
 Mon, 13 Apr 2026 09:49:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C99695FFB9;
 Mon, 13 Apr 2026 09:49:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 848A3104501E1; 
 Mon, 13 Apr 2026 11:49:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776073767; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=bOvLgF9VUNM69oeFoOFWoB+a5gdCEit3fgE+AAqOAdk=;
 b=gGfEGBuMA41B+9KJlUO6LkIAr3ZbC9eJK3GO2xMf9XXeLVmBQklLQQliFChdpRmoBrmYoS
 xyIZ5kYdasf6l5WKD2OtlA5D5jS6ZG8qFFYNxe/i8duZa+HAzL0jojNX50uvpNTpFkGaAy
 5MWoil70c9b2DZj2+E/LFhkSv700BA3ekiwQ40cF6JDP0ys1CJD7BEhhDRh0LtV/ySEz50
 HTGBiyOhJebOycd6X7/mw8F3TgjzDKRat2GDMvEyR2SpYmMqcAPQWay7ggy9dmpslYE/Qm
 U87fNDcp0rbNKSgvyzuM/uzEFhkRjq/OZa05YJ8WrGp/l9SnzpFl6GZWfo3FAg==
Date: Mon, 13 Apr 2026 11:49:22 +0200
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
Subject: Re: [PATCH v5 05/12] configs: am335x_evm: Unify evm board defconfigs
Message-ID: <20260413114922.150466aa@kmaincent-XPS-13-7390>
In-Reply-To: <20260410-topic-am33-evm-oftree-v2026-01-v5-5-4b9c7aca0e3e@baylibre.com>
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
 <20260410-topic-am33-evm-oftree-v2026-01-v5-5-4b9c7aca0e3e@baylibre.com>
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

On Fri, 10 Apr 2026 15:31:45 +0200
"Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:

> Much of the config symbols between the evm boards are the same
> independent of the actual board. This patch creates a hierarchy for the
> am335x_evm configs:
>=20
>   am335x_evm.config
>   `-> am335x_evm_defconfig
>   `-> am335x_evm_spiboot_defconfig
>   `-> am335x_hs_evm.config
>       `-> am335x_hs_evm_defconfig
>       `-> am335x_hs_evm_uart_defconfig
>=20
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
