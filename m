Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECC4F53D85
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9814B84246;
	Mon, 16 Mar 2026 19:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="1ODMUjGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B525840CF; Mon, 16 Mar 2026 17:23:07 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18F4B840CB
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 17:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C4C4F4E42609
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 16:23:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 99D5B5FC4A;
 Mon, 16 Mar 2026 16:23:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9D3A910372204; Mon, 16 Mar 2026 17:23:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773678183; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=aOqswo/GAednT3RVoETgvKIY0gzb14T7M9g+NHdQav4=;
 b=1ODMUjGu4Hl28IMRRQ9TpxS/JEj1j+AAiFpajTxZu3+Wax5eJ/Qy279kd76bbK8fmHEXSC
 FT2y6yiUY8+IJrfd0jD0z1cXxiNFQLHhF5J3jSSks8aR71kmRgbA9/609RdSsZiJFJSD5L
 U0YUmRff5Do/8W9331E6Ma1qIwNSqhB37/09hGTBNNOJuNuggTFUy7zwbj3Tl/skm195U+
 GdrAbraF2egrfZgfgyTROtuP3q3OJ+4gPcKsvl8wqKvEokGQ6++zYpLTg1vmYCYP/XHrAT
 EZthNpXa4NwG+SG7jQn+RzNDGI9Q+TkXhphOhxZL3Key9iQ1t2AV17+dIW56AA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>,  Peng Fan <peng.fan@nxp.com>,  Jaehoon
 Chung <jh80.chung@samsung.com>,  Joao Marcos Costa
 <joaomarcos.costa@bootlin.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de
Subject: Re: [PATCH 0/7] Introduce SQUASHFS support in SPL
In-Reply-To: <20260313104229.1555236-1-richard.genoud@bootlin.com> (Richard
 Genoud's message of "Fri, 13 Mar 2026 11:42:22 +0100")
References: <20260313104229.1555236-1-richard.genoud@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 16 Mar 2026 17:22:59 +0100
Message-ID: <87jyvbg2vw.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 16 Mar 2026 19:24:17 +0100
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

Hello,

On 13/03/2026 at 11:42:22 +01, Richard Genoud <richard.genoud@bootlin.com> =
wrote:

> SquashFS has support in U-Boot, but not in SPL.
>
> This series adds the possibility for the SPL to load files from SquashFS
> partitions.
> This is useful, for instance, when there's a SquashFS rootfs containing
> U-Boot binary.

I haven't made a deep review, but I am very enthusiastic to eventually
see this upstream, thanks Richard!

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Miqu=C3=A8l
