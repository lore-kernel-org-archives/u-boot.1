Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95620C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 07:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30792885F4;
	Wed, 17 Jul 2024 09:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="EKnCg8RU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD6A988621; Wed, 17 Jul 2024 09:59:47 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03B898851E
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 09:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B23CFF804;
 Wed, 17 Jul 2024 07:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1721203185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MNauLN4HRpm8+x6m8QGQxq/PdsObXGxVrOXI6AEe//Q=;
 b=EKnCg8RUdBzhWQOmHpPduTx7o98W7GQmIyKDS1F51YCgN8Jdb76b8S539kG+gA++F0lDP3
 itDdZ452rSuPpmD6YQQ7oalYo5viAwLjCh/Yovv4Y7Z7qOCyn4oq7OKGAM1MP9neTKdukS
 dYKDS6dT1hZSrw2bIYA8OwJZjwjYg8FlTYZctuN1dhF0bvCZWNG5XGEVBAXSPHRAGgD89a
 zLjtt+WqKPodTaluUxfqiWWEmAhkkOpXBdvScTpUdrPhCKSJPOIVUDatiqNAdbCxcJMX29
 E81CojGgnsO6tXxPRujCiQ2QzKi1p/Z44UZuI/2/OhVToZ2BfW5UI5yHIIIlbA==
Date: Wed, 17 Jul 2024 09:59:44 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, jmcosta944@gmail.com,
 thomas.petazzoni@bootlin.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at
Subject: Re: [PATCH 2/4] squashfs: Fix integer overflow in sqfs_inode_size()
Message-ID: <20240717095944.6bf7e96e@xps-13>
In-Reply-To: <20240712082344.8655-2-richard@nod.at>
References: <20240712082344.8655-1-richard@nod.at>
 <20240712082344.8655-2-richard@nod.at>
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

richard@nod.at wrote on Fri, 12 Jul 2024 10:23:42 +0200:

> A carefully crafted squashfs filesystem can exhibit an extremly large
> inode size and overflow the calculation in sqfs_inode_size().
> As a consequence, the squashfs driver will read from wrong locations.
>=20
> Fix by using __builtin_add_overflow() to detect the overflow.
>=20
> Signed-off-by: Richard Weinberger <richard@nod.at>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
