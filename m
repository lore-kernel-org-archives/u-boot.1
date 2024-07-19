Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6525C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 06:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54C887B77;
	Fri, 19 Jul 2024 08:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="pX/AyXZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63CD287D10; Fri, 19 Jul 2024 08:57:09 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 719FF83333
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 08:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [213.135.10.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id ADB1F5003;
 Fri, 19 Jul 2024 08:57:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1721372226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=y0b8cK+SoSJ2X+cNCKBpPvCqFbj5JZ50hsLjMb1WB9c=;
 b=pX/AyXZFLxddbxlJ18F9KZQJBWgau0jg87FByoArCu2ARWpPtePVpC1G13sPFPtPOjEaAj
 AyJxYdzlyoSEmI+Bw0er77PxXeHR+tD5H96k5pMxvLIhnVbBMP8jt7Wo+V11KoAfSDyoC9
 YX+W7Sqr7cIFJLfdiq3MX4l3r03iJ5aSUoyjZe8+ewHxaGHHlSO9MbBmhZsmYpzZXVRBf3
 RGy4y6WmTLeEHeFj/2kahXnzE87XoevceQ//ycDjQEy/U/Np2IPYclw65w71apjUGC7TkH
 5kTzcyJmxE+yDw68Gz+5/8jicSyrgV/U1AMK98K2zUGYPjkmdzlSGlEWD+roJg==
Content-Type: multipart/signed;
 boundary=0b5830369b81de9b9d7127e4ce2f02fa6bcea01dbae939112008cbdd27d6;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 19 Jul 2024 08:57:04 +0200
Message-Id: <D2TBIZ3HDGMJ.2S5Q1ZYD44D7I@walle.cc>
Subject: Re: [PATCH v7 0/3] Introduce mtdblock device
Cc: <kernel@salutedevices.com>, <u-boot@lists.denx.de>
From: "Michael Walle" <michael@walle.cc>
To: "Alexey Romanov" <avromanov@salutedevices.com>,
 <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <frieder.schrempf@kontron.de>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>, <bmeng@tinylab.org>,
 <tobias@waldekranz.com>, <jpewhacker@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <kever.yang@rock-chips.com>,
 <jbx6244@gmail.com>, <abdellatif.elkhlifi@arm.com>, <michal.simek@amd.com>,
 <mikhail.kshevetskiy@iopsys.eu>, <patrice.chotard@foss.st.com>
X-Mailer: aerc 0.16.0
References: <20240718054606.799665-1-avromanov@salutedevices.com>
In-Reply-To: <20240718054606.799665-1-avromanov@salutedevices.com>
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

--0b5830369b81de9b9d7127e4ce2f02fa6bcea01dbae939112008cbdd27d6
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> Tested only on SPI NAND, so bind is made only for
> SPI NAND drivers.

If tried to test this with the SPI NOR framework but I couldn't get
it to work. The SPI NOR flash didn't register with/was found by the
mtdblock subsystem. I guess that is probably because the SPI NOR
flash has it's own UCLASS_SPI_FLASH. There is some kind of
compatibility layer (drivers/mtd/spi/sf_mtd.c) but it doesn't
register a UCLASS_MTD.

Do you have any idea how to get this to work?

-michael

--0b5830369b81de9b9d7127e4ce2f02fa6bcea01dbae939112008cbdd27d6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZpoOQREcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+HVVAX9U0sVfheeXK/cUFju3uoEyC4yunEPleTyb
BWa0FSo7MN3pmJ4215u7OD6TZSpQcVEBgPUXy+EeNtn+8soQtXfzHP8OhY17+jWj
dvZ+tMR9hjCIMlwXwiQMZHKq8zIgcp4Edg==
=cmyL
-----END PGP SIGNATURE-----

--0b5830369b81de9b9d7127e4ce2f02fa6bcea01dbae939112008cbdd27d6--
