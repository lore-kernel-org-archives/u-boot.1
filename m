Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E992E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 09:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9023F8007D;
	Fri, 20 Dec 2024 10:16:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jr70ZsJQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D794780087; Fri, 20 Dec 2024 10:16:08 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B40880079
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 10:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC5FA40007;
 Fri, 20 Dec 2024 09:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1734686165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWquvTzzR5/gjtBQ05SK8BLWq052VStefVbpmDVYRiI=;
 b=jr70ZsJQtJuJIaYl3heugucQbD65+W5d2Y4JVu8xhB4d/jj8aEzML5nZW1XfWyimP34lLi
 bgP0N319gE/JaXPjwkj81ux/GVVyoA3aYDONzYdesf8n0ZaI8EBHQ2DXcQzmKrdIKkfuFS
 vfTnyeC1WMl2+Xm5cVXWcf1NuIUQlPpe5d1P02Lymu8EJL0WUytLdGaK/9d0IJtSbFAFmM
 oSGRe6cXVgBwsRnp5PRsWTxDOVQyP4Kc520f8h0MB++4pjOCKtmnNIhWIHSRqvrdV/Fg8O
 sqAvljsYcysDtc1oO0E4IkCPTWryj6pddNO87X2i+5hyfMrNsvSf6ib3DcXmmg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,  Lukasz Majewski <lukma@denx.de>,  Sean
 Anderson <seanga2@gmail.com>,  Simon Glass <sjg@chromium.org>,  Jaehoon
 Chung <jh80.chung@samsung.com>,  Anatolij Gustschin <agust@denx.de>,
 u-boot@lists.denx.de,  Ian Ray <ian.ray@gehealthcare.com>,  Michael
 Nazzareno Trimarchi <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 00/13] Add imx8mp video support
In-Reply-To: <CAOMZO5B=4eoMxxFKieUgXVWMpJOad-V-o+NmG3JhAMFptP4DgQ@mail.gmail.com>
 (Fabio Estevam's message of "Mon, 9 Dec 2024 09:12:17 -0300")
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
 <CAOMZO5B=4eoMxxFKieUgXVWMpJOad-V-o+NmG3JhAMFptP4DgQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 20 Dec 2024 10:16:03 +0100
Message-ID: <877c7uww8c.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Fabio,

> There are errors in CI when this series is applied.
>
> Please take a look at the sandbox test failures:

I observed errors while locally testing which looked unrelated. I'll do
another test round and see what I can fix.

> https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/23735
>
> Also, please make sure that v3 passes Azure CI tests.

Am I allowed to push a branch to this repository to validate the CI
passes? Or is there a command that spawns a container of some kind and
runs the test which I'd missed? Any pointers will be appreciated.

Thanks a lot,
Miqu=C3=A8l
