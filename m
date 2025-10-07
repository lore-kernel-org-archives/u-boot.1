Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E07BCCA476
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 09:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FA0C83F63;
	Tue,  7 Oct 2025 11:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="zHSC6rle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3447983FBF; Tue,  7 Oct 2025 11:04:52 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8311A83F60
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 11:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 7A1CAC085E1;
 Tue,  7 Oct 2025 09:04:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BEF24606EB;
 Tue,  7 Oct 2025 09:04:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3B1C8102F1DA8; 
 Tue,  7 Oct 2025 11:04:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759827888; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=mxA+ObKsX37LmhKpwXDbNDozNVHEBxJt7eD46QA2SJI=;
 b=zHSC6rlekkDg5b+6PJbstwFooBgVVRbnWRffFVjG9f3DXjpueRwCdZcW2fLRanlAJxLScy
 yOmh0C5o9dzgJsaRPurM7tCU7O8oRB1hDvfYLB9FAHdbG/AN7u0RTpj5AUz2qSimzk4kCa
 aj4x31gfAca0BPhUVP7nOVKFjkOoDiFElHTTArDWflDZWq4khvMwsfI/YxNDN8DoiCeRFO
 HItERbqxA8qBnUGuHmKA2KGFz0YQ1kmf4M4Ne37gkNwXEw65wFex1i/ZQoK01MYW8uSZ9s
 PKMQXNt8pplEAJOHFZBfyt55MypvG62IWcnSOkdSZiXsaX6YSeHkh7uk/rwWog==
Date: Tue, 7 Oct 2025 11:04:31 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede
 <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 00/16] Convert extension support to UCLASS and adds its
 support to boot flows
Message-ID: <20251007110431.4d007b8b@kmaincent-XPS-13-7390>
In-Reply-To: <20251003203735.GW6093@bill-the-cat>
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
 <20251003203735.GW6093@bill-the-cat>
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

On Fri, 3 Oct 2025 14:37:35 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Fri, Oct 03, 2025 at 06:33:40PM +0200, Kory Maincent wrote:
>=20
> > This series converts the extension board framework to use UCLASS as
> > requested by Simon Glass, then adds extension support to pxe_utils
> > and bootmeth_efi (not tested) to enable extension boards devicetree load
> > in the standard boot process.
> >=20
> > The UCLASS implementation provides one driver that manages all
> > extension boards (alternative would be one U-Boot device per
> > extension board). Simon is that what you would expect?
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> This seems good overall, thanks! I'm assuming you were able to test this
> on a few platforms? Which platforms should we try and find someone to
> test this on to make sure there's no surprises down the line?

On this version it was only tested on the ti BeagleBone Black board. I first
wanted acknowledgment of the current design development.
For the v2 I will test more thoroughly the sunxi DIP scan and the sandboard
scan. The only board I don't have is the imx8mm-cl-iot-gate so I hope someo=
ne
could test this one on his side. I also can't test the efi bootmeth changes.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
