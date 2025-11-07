Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69509CCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 09:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4B7383C94;
	Fri,  7 Nov 2025 10:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="rOQjzzFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EDBA83CB4; Fri,  7 Nov 2025 10:05:28 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C655A83C60
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 10:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 61FF71A18E2;
 Fri,  7 Nov 2025 09:05:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 374626070B;
 Fri,  7 Nov 2025 09:05:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4DE0911851A7A; Fri,  7 Nov 2025 10:05:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1762506323; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=UgaYf5S0pp9636BTY/neyCznL1V94dmq9WZWPzTZX3I=;
 b=rOQjzzFCxhOjwz20iJfLd50AWuqMPQYr7EhwtYRjDOERcCcg9GUrNpusbBUEur8Bsee8Sr
 X3OCSvy+K30zjdUqgrmk0zpFycFpGhuaUWHxDCIW6rvP6jDb4pfFlgZYuDNG+8W570Fox1
 xo1iE/IDT+dZ8p9paylaQDZ8BILuDoZKJ81XW3homT9JvC6hSjP0X7KGTjKKQ9DekWCTDS
 6U+c6eqB4qPVsE3UUJ3u5m9FPLyV1i6YvittNYBnCZJjtQBOIbjQ3NGlIJScachTi0fyKa
 YMEtkIVyJ02WhDdjZcmtF03jDNgg9FHrPfIuHPEOrO6NLprG7aN5GhMWXEp5Og==
Date: Fri, 7 Nov 2025 10:05:17 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/2] distro_bootcmd: Add support for customizable
 find_distro_rootpart
Message-ID: <20251107100517.6c79a976@kmaincent-XPS-13-7390>
In-Reply-To: <20251106182329.GY6688@bill-the-cat>
References: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
 <20251031-feature_distro_rootpart-v1-1-4e7c465708e8@bootlin.com>
 <CAFLszTicHdtY73+asYQ9NF_uEFg7BsSfN2cW+21FbQoxH9V_JA@mail.gmail.com>
 <20251103115225.381126f1@kmaincent-XPS-13-7390>
 <20251103171630.4df1efdd@kmaincent-XPS-13-7390>
 <20251103161905.GP6688@bill-the-cat>
 <20251104102916.3df33d55@kmaincent-XPS-13-7390>
 <20251104163816.GB6688@bill-the-cat>
 <20251106190001.0e5a4504@kmaincent-XPS-13-7390>
 <20251106182329.GY6688@bill-the-cat>
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

On Thu, 6 Nov 2025 12:23:29 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Thu, Nov 06, 2025 at 07:00:01PM +0100, Kory Maincent wrote:
> > On Tue, 4 Nov 2025 10:38:16 -0600
> > Tom Rini <trini@konsulko.com> wrote:
> >=20
> > Other question: Is it possible to not add the environment to SPL image =
using
> > the new text environment format. I have tried to update am335_evm board=
 to
> > it but I got a SPL too big error.
> > I have tried to add "#if !defined(XPL_BUILD)" but it is not working.
> > It seems the same generated environment file is used for all images.
> > I still haven't found were it is included in the build of the SPL image=
.  =20
>=20
> It shouldn't change the environment size, but also environment is likely
> being pulled in to SPL for network boot support which does require
> environment. What do you mean by "same generated environment file is
> used for all images" ? And are you building in separate object
> directories for a given board or is it not being re-generated on config
> changes? Or did I misunderstand? Thanks.

Sorry if I was not clear.
For the am335x_evm most of the environment is only in the main u-boot image
(i.e. not an xPL image).
https://elixir.bootlin.com/u-boot/v2025.10/source/include/configs/am335x_ev=
m.h#L78

I would like to do the same but with the new text environment format. Is it
possible? Something like: board/ti/am335x/am335x.env for main image
and board/ti/am335x/spl_am335x.env for SPL image.
If that is not the case could you point me where the change need to
happen to help me on that. I didn't find yet where the text environment is
pulled into the images.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
