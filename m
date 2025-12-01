Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A363D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 10:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F6A83AA0;
	Mon,  1 Dec 2025 11:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WsIAYf+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B86E483AA4; Mon,  1 Dec 2025 11:10:11 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76BE3839A5
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 11:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E175AC17B44;
 Mon,  1 Dec 2025 10:09:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 09009606BB;
 Mon,  1 Dec 2025 10:10:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8A3CD11918072; Mon,  1 Dec 2025 11:10:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764583808; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6py32yhdCss2nKs+cYDzu0Pk1dbPUrvlgz0vGHp7Xz0=;
 b=WsIAYf+BwSMKAFWb9ccy77Hw3ZnzTLSeC4G2lN4qKQKA8pWXcoeJJREbmlvZ3QTHxzx9TU
 w8UD1eJ1bXAYFL8NMUoBQ6nKY+6YBS3cwVrpS4llHavfjaiLGjTtWBOCjgE95toF+U+ijX
 kxTN+ECpbuaRqqRdiKw0Hx1xIrKtBY2khcXrdyyQc5wEtHFE7LNUGnHe+DSb+piVgpiSTj
 hUnG3fKwnjuN29Ih7TFedOzXjjktB2q+wEd4SVrOMU/6++QY562SdRkg4BZo2F7JGvu13b
 RldTzQuHZsKN/Grw9fXFRAmdC+QFJwSAL6ZpL/Sk+yyQ0IsTfrOdkDw7JF64yA==
Date: Mon, 1 Dec 2025 11:10:04 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>, Tom Rini
 <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>, Paul Barker
 <paul.barker@sancloud.com>
Subject: Re: [PATCH v2 2/7] configs: am335x_evm_defconfig: Enable panel
Message-ID: <20251201111004.4be48ff7@kmaincent-XPS-13-7390>
In-Reply-To: <20251128-topic-am33-evm-oftree-v2026-01-v2-2-42a863304498@baylibre.com>
References: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
 <20251128-topic-am33-evm-oftree-v2026-01-v2-2-42a863304498@baylibre.com>
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

On Fri, 28 Nov 2025 21:46:32 +0100
"Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:

> Enable LCD panel support on am335x-evm:
>  - CLK_CCF and CLK_TI_* for display clock tree
>  - DM_PWM and PWM_TI_ECAP for backlight control
>  - VIDEO and AM335X_LCD for display controller
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
