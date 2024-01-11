Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2D3C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 07:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C0A687738;
	Thu, 11 Jan 2024 08:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="X407XSNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 888C88750C; Thu, 11 Jan 2024 08:48:58 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97EFA87738
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 08:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D451140002;
 Thu, 11 Jan 2024 07:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1704959336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kTWz+UjwawoWRlfILNlnW2yTSlmbBBR4iCakbnTCZ4=;
 b=X407XSNCOaVKbKw5LwhCkqOM1RFlcD3UGFOG4QHZWzwsiymeuejLsMNOA3IZyipExuHXKK
 Qeg/yRwBMIb7+NieX0Kj6GqVPoYItt9G977DSDa+YEnpRfoXAGAnOcSNHWhQcvr1iZStGN
 mu4yrzKLf1t5RcVVoehYWkZD2CCByE8IrKHNRzJcA7jLOf4q5NpKCQn6Sxt17VS1bXC/W4
 BCSa6q58HoIzHWBLjWToAK4C1k+xVwxGSrydh4eyD4tPGiWIMxUE/IOtY8Vnf8Xueq0BiO
 Gcl8YaVVnKgJ66TFhzEpTlDrMuRBzHXaZ5iGnq9U4QZYyNd4GcMiVPoaGpA5bA==
Date: Thu, 11 Jan 2024 08:48:55 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Stefan
 Roese <sr@denx.de>, Boris Brezillon <bbrezillon@kernel.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] cmd: mtd: avoid unintentional integer overflow
Message-ID: <20240111084837.2c7b46c4@xps-13>
In-Reply-To: <20240111073155.19545-1-heinrich.schuchardt@canonical.com>
References: <20240111073155.19545-1-heinrich.schuchardt@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

heinrich.schuchardt@canonical.com wrote on Thu, 11 Jan 2024 08:31:55
+0100:

> mtd dump beyond 4 GiB will show incorrect results.
>=20
> Multiplying two u32 will yield a u32. Add a missing cast.

Good point, thanks for the fix.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
