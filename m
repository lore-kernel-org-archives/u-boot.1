Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4303C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 07:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B653A886FD;
	Wed, 17 Jul 2024 09:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QlZvAfgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6413C885F4; Wed, 17 Jul 2024 09:59:12 +0200 (CEST)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 651EA886FD
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 09:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5E4540009;
 Wed, 17 Jul 2024 07:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1721203150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5yhz7xFbEaOrngXQYC9BemIMJ179euVxfl55d6iwbZI=;
 b=QlZvAfgE5s9gI+7vWHpa1Ir6gBuQEWKVP+dR9iy8oCx0qB0oC8XU8skhf/+B1iJxSIQqzO
 y/s2WbCaE4fY5hOiorZMeKcZy58JQgdCcBNwvyWX+ftvfqkvGNmoA74AGJfykZ8UiZmf7l
 MyZxHPC3/xntxvD6kr6mwRIhZHQTbMqdZpWVwp0SX1y5yIkYqms39HcHfzDZgdQLuirD/l
 586WWIXxr6483m53u55AyXKiKn395QMteRtO6cvBF8jlnmUdJU+sN0dpQ9pM2qb4Von1BN
 zTNdWq3AqUVKFrOSxaQuVIv27nLNAU/RZ88nkdbAIqF9DstBWI0aO3KiGiDGsQ==
Date: Wed, 17 Jul 2024 09:59:08 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, jmcosta944@gmail.com,
 thomas.petazzoni@bootlin.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at
Subject: Re: [PATCH 1/4] squashfs: Fix integer overflow in
 sqfs_resolve_symlink()
Message-ID: <20240717095908.67503d3f@xps-13>
In-Reply-To: <20240712082344.8655-1-richard@nod.at>
References: <20240712082344.8655-1-richard@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

Hi Richard,

richard@nod.at wrote on Fri, 12 Jul 2024 10:23:41 +0200:

> A carefully crafted squashfs filesystem can exhibit an inode size of 0xff=
ffffff,
> as a consequence malloc() will do a zero allocation.
> Later in the function the inode size is again used for copying data.
> So an attacker can overwrite memory.
> Avoid the overflow by using the __builtin_add_overflow() helper.
>=20
> Signed-off-by: Richard Weinberger <richard@nod.at>

Good catch.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
