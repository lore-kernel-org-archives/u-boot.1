Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F824C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EBAB88A1A;
	Wed, 17 Jul 2024 10:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="i4Z2P3NX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77F2988A1B; Wed, 17 Jul 2024 10:00:32 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C558886FD
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CDB211BF205;
 Wed, 17 Jul 2024 08:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1721203230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vxf/ZjqdL08uns3pJNGJQmJ5G9PyaFb2QMf6E0f9XXs=;
 b=i4Z2P3NXmNs73uSP6kVQu0jNLi986NtEzSp7xQdwWqvaoqo7Pp/ofTm9bVsbovT35EegnY
 IDnK4hk3WxGjTMgTQFyjRvKYNGvRIY+7RCFEdrWt5AJWNlHDn9W3yCn89GA+j1qx9NYjjf
 6w1O+AlVAs2yvfXVlDeNr4VMPRdgJYFRJAgFPqIxvOcyQT4Gd0DlaZhZ0h6RlZ5jB8Pr9j
 nmVF/6TEmMLufWOfbQFWstiy/GC1GUCg+pe+GZeW864x8NMAwMKNnahnG5lZcelyjjwv6L
 ePXmDBf5D2ErFL3KQaw99h4s9N8aVeUhoUH95h//Tom1A7+btUWMH01I9YXTAA==
Date: Wed, 17 Jul 2024 10:00:29 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, jmcosta944@gmail.com,
 thomas.petazzoni@bootlin.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at
Subject: Re: [PATCH 3/4] squashfs: Check sqfs_find_inode() return value
Message-ID: <20240717100029.3bf31ecc@xps-13>
In-Reply-To: <20240712082344.8655-3-richard@nod.at>
References: <20240712082344.8655-1-richard@nod.at>
 <20240712082344.8655-3-richard@nod.at>
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

richard@nod.at wrote on Fri, 12 Jul 2024 10:23:43 +0200:

> The function can fail and return NULL.
>=20
> Signed-off-by: Richard Weinberger <richard@nod.at>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
