Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89F5ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 07:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27A1F88F03;
	Tue, 10 Sep 2024 09:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="N9Pa6lPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C73D388F21; Tue, 10 Sep 2024 09:30:23 +0200 (CEST)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE06488EBC
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 09:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E972D1C0008;
 Tue, 10 Sep 2024 07:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1725953421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oq9MdESWnviB6nhjEEfP4vTrnKFVCKXjBtcUtL7Dq60=;
 b=N9Pa6lPUI6XSXZwkdC0CEhZAb1ikcXAKtW44cnsFfNpxeKq8EljzXubTLpf+SVb12V/2q0
 dS4fjnUKYCniCfT2F2kBIXMQOYSE+x9At4EUuAhV0udFvKH7NSYDbdfvKO7tVHLmYOhnUj
 nQJ3FgqDPIHTlA/7UDaF4Hy0cVDl+KkjsFzcrHWR44R5LK1pihX4vUOPOIE5ZWdGPTCHou
 FvkUzDjCz7gYJS6oG/qJwKYG94AbYjKO+e5ltpcmuasI0ZtEaigH2N81HA/DP49dA7Tpn5
 Q+N/6tE8A0n2BW5IvGcHpBUIk/4a+D2NhxjOkeYqS9j3SGkj6ScOalTE0+n5NA==
Date: Tue, 10 Sep 2024 09:30:20 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] cmd: mtd: simplify mtd_show_device()
Message-ID: <20240910093020.14b72fb4@xps-13>
In-Reply-To: <20240909232335.20440-1-heinrich.schuchardt@canonical.com>
References: <20240909232335.20440-1-heinrich.schuchardt@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Heinrich,

heinrich.schuchardt@canonical.com wrote on Tue, 10 Sep 2024 01:23:34
+0200:

> CONFIG_DM=3Dy is always true.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
