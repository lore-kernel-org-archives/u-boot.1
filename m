Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAB9C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 07:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D13FC8857C;
	Mon, 12 Aug 2024 09:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jRTZiQLa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 264C586E85; Mon, 12 Aug 2024 09:51:43 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A3258857C
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 09:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6826AC0002;
 Mon, 12 Aug 2024 07:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1723449100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=laevIuMSeX0B1hCaGQG8QszuWVQXVA/ZFpD6fELIZFE=;
 b=jRTZiQLa/vfmYDMbHAAT+55plQnp5GnGAu5JTj8gNpTAeD8SxtKnSblykqYAm5crzSwLwj
 dwBsx03rPTML+BSvtIlb3xBpRAp3HS+DA+/kfeY+9qeb0FMIbNoKDGevszshn1spWphMJy
 KxUvxNFTWpFoFeky9waaoX2J53mmmmAJryWc6DTBtBgdx4MbhUoh2NHCrAX7BT43xpAUVX
 e9e31lliSFae/D6cmIW3BIZ7Hcbb0HOCYKOTkT6kPndoWX/9dHY8d7evSdgR7NSw95JvMJ
 97BGf7OudoJJrL5OgLxe0PJECWJTxTICTSrxwmsjDqgMKKE0mcUrP3p7aKe9Dg==
Date: Mon, 12 Aug 2024 09:51:39 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, upstream+uboot@sigma-star.at, trini@konsulko.com,
 thomas.petazzoni@bootlin.com, jmcosta944@gmail.com
Subject: Re: [PATCH v2 4/4] squashfs: Fix stack overflow while symlink
 resolving
Message-ID: <20240812095139.32c5cf66@xps-13>
In-Reply-To: <20240802163647.26674-4-richard@nod.at>
References: <20240802163647.26674-1-richard@nod.at>
 <20240802163647.26674-4-richard@nod.at>
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

Hi Richard,

richard@nod.at wrote on Fri,  2 Aug 2024 18:36:47 +0200:

> The squashfs driver blindly follows symlinks, and calls sqfs_size()
> recursively. So an attacker can create a crafted filesystem and with
> a deep enough nesting level a stack overflow can be achieved.
>=20
> Fix by limiting the nesting level to 8.
>=20
> Signed-off-by: Richard Weinberger <richard@nod.at>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
