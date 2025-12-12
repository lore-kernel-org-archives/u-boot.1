Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DC9D4417E
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 11:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C04183849;
	Fri, 12 Dec 2025 12:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Wn3lZA8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30F9E83869; Fri, 12 Dec 2025 12:27:29 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D3783837
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 12:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (unknown [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 4C31FC1935F;
 Fri, 12 Dec 2025 11:27:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 58EDC606DF;
 Fri, 12 Dec 2025 11:27:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DDEDF103C8DA8; Fri, 12 Dec 2025 12:27:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1765538835; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=fle1MlWLPpqwVXUmQgQy0A2Av0GU3BlU5y2WvnQcuKw=;
 b=Wn3lZA8DnkaCOfMgSQO65v6SHopl3EBoYqNvHo8a4xk5NvDdKkm7kdDC0atpgJY4mEIQGY
 P8qznRcPFxT2AGmdAQ+eZRnbGaay6L7ypzMId7cllSqrRNTLyyMd8J6lTL7JAv67ExLQC9
 KVPIPGoLXHu/voBWbWoIEdRPW2IQbczlwpXqE6SXwmg8AQIUtZPbm9wjuVvTxLJLR7XlcB
 kyRj7Qf2/TnKdn0iUIRpGVkrewvhhZTCKxhiIModESEJs/z3V2sf5adcu1+K0B7ICfZgKn
 B1CPJHwe77klVG9On82duF+wjtZtYyNeigFrbO01SkaRsviuWNejyCWAZZ3JQw==
Date: Fri, 12 Dec 2025 12:27:11 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>, Tom Rini
 <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>, Paul Barker
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v3 8/9] am33xx: Support upstream devicetree USB device
Message-ID: <20251212122711.7a36f84c@kmaincent-XPS-13-7390>
In-Reply-To: <20251204-topic-am33-evm-oftree-v2026-01-v3-8-3d1566ce4dc7@baylibre.com>
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
 <20251204-topic-am33-evm-oftree-v2026-01-v3-8-3d1566ce4dc7@baylibre.com>
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

On Thu, 04 Dec 2025 11:25:44 +0100
"Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:

> Support musb being probed by ti,musb-am33xx. The non-upstream DT probing
> used a wrapper driver that probed ti-musb-peripheral and ti-musb-host.
> This wrapper registered as UCLASS_MISC, which is why it is requested in
> this board.c file.
>=20
> With the new devicetree the wrapper that registers as UCLASS_MISC is
> gone, instead the UCLASS_USB and UCLASS_USB_GADGET_GENERIC have to be
> requested.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
