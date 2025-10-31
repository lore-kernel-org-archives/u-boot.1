Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294EACCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 18:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A511483A98;
	Fri, 31 Oct 2025 19:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="mew5AV6V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 982DA83A9A; Fri, 31 Oct 2025 19:11:12 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C490B83A97
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 19:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 657F41A17C2
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 18:11:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 28D7860704;
 Fri, 31 Oct 2025 18:11:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6C1A911818007; Fri, 31 Oct 2025 19:11:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761934268; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=gev912YycFPB9k5GGU8nHgsmMJ0+XtZZEDGc/AVZUG0=;
 b=mew5AV6VKIzt6lOQN2dmtdBr7Nbkd4NhGWxHMOyqbwJr+35n9Oblv76HK3cPXameT+8vRO
 HDR9jd2I3FF80xwHRlAc/pNOLbL5aFF9QcZX03BWtDVllvoTgvYTyq8Mqq+4/e1r5lXyTJ
 OZyTNdZY3gZN4BkqMmFo5EWIVE7CjeaEwbk447l+eVPQRMkd4N1PlDL4v+vkp7zDCyiBiC
 l/9Qc8Vv4pd9G8Bg0TwRNd0SjVQt4w10qCywIUGeC+WqIFq9Y9IVG//fWBP/C4wqt5weuJ
 x4lfKttsqA3BzJjWJ2F9rfuDjunQujGAe6cZelUz5gbMLCTnMAccnxkww1kt8Q==
Date: Fri, 31 Oct 2025 19:11:04 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 0/2] Add support for customizable find_distro_rootpart
Message-ID: <20251031191104.797c6b4e@kmaincent-XPS-13-7390>
In-Reply-To: <20251031174733.GE6688@bill-the-cat>
References: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
 <20251031174733.GE6688@bill-the-cat>
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

On Fri, 31 Oct 2025 11:47:33 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Fri, Oct 31, 2025 at 05:36:02PM +0100, Kory Maincent (TI.com) wrote:
>=20
> > Add a customizable find_distro_rootpart command to allow each board to
> > define its own logic for locating the rootfs partition inside the
> > config_distro_bootcmd logic.
> >=20
> > Convert am335x_evm board to this new find_distro_rootpart customizable
> > environment variable to locate the rootfs partition dynamically, instead
> > of finduuid which hardcodes the rootfs partition location (mmc 0:2).
> >=20
> > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> > ---
> > Kory Maincent (TI.com) (2):
> >       distro_bootcmd: Add support for customizable find_distro_rootpart
> >       include: configs: am335x_evm: Replace findduid with
> > find_distro_rootpart =20
>=20
> The first question here is, can we migrate these to standard boot
> instead, or is that kind of functionality also missing there?

I will let Simon confirm but I don't see anything related to the rootfs
partition or parameters that could be used by the "root=3D" Linux cmdline o=
ption.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
