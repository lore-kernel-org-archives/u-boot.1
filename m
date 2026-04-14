Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222C6ED7B8B
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 09:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86999841B9;
	Tue, 14 Apr 2026 11:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vl1d0Xq9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8E4E84181; Tue, 14 Apr 2026 11:17:47 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E7C4841CD
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 11:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 394E2C5AA96
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 09:18:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3074B5FFBB;
 Tue, 14 Apr 2026 09:17:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5DED410450093; 
 Tue, 14 Apr 2026 11:17:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776158264; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Lms9VHwybC4O364iAvPNW7+860fAl7hg+UtIui2DdoY=;
 b=vl1d0Xq9LE7nUZ3FzD1gr+NG4qi4LnfDO+lwqnvP7HYAvCrvuNzkju2dQDbSK04ib7DnfI
 qzc4eHrRvvgYmuvOidf3G5DWr5nMxGCLlOOlra/NcknQ8isnMtYLiiLdrnVXc/gtp57No1
 pGn7UtthqPSiZX5FYdNRYoA5Lul6G+4+F+072qdIn3WoJ1ZdNST1IXX0acrO5sg3gH9tSh
 dRnZAvAX8Dcc5f6ZGV7i5hb4NUIlXgHxeeE/U5B8vo4GiBCZlENWVktk9uPhiFJ/lT7XsW
 opQWuxufKWtRxjnjOTq7KI9mltEmhyuueYxj/03z2C4Ly09s6I2BhghSqLOqzw==
Date: Tue, 14 Apr 2026 11:17:41 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] board: stm32pm1: Fix board_check_usb_power()
Message-ID: <20260414111741.511707e5@kmaincent-XPS-13-7390>
In-Reply-To: <20260414-fix_usb_adc_meausurement-v1-1-8cdbd4c10dd8@foss.st.com>
References: <20260414-fix_usb_adc_meausurement-v1-1-8cdbd4c10dd8@foss.st.com>
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

On Tue, 14 Apr 2026 11:06:50 +0200
Patrice Chotard <patrice.chotard@foss.st.com> wrote:

> Depending of plugged power source (computer, wall charger, ...) it can
> happen that we got the following message:
>=20
> "****************************************************"
> "*      USB TYPE-C charger not compliant with       *"
> "*                   specification                  *"
> "****************************************************"
> "                                                    "
> "### ERROR ### Please RESET the board ###            "
>=20
> This issue has been detected on STM32MP135f-DK board.
>=20
> It's due to max_uV and min_uV value are initialized at beginning of
> board_check_usb_power() and can then be used for the 2 iteration of
> adc_measurement().
> max_uV/min_uV values issued of the first adc_measurement() iteration
> are used as input of the second adc_measurement() iteration, which
> can lead to incoherent pair of min_uV/max_uV values.
>=20
> To ensure that adc_measurement() returns coherent value for max_uV and
> min_uV, initialize max_uV and min_uV at each loop start.
>=20
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
