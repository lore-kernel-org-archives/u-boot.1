Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B38CCF9F5
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 09:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C505838F8;
	Thu, 30 Oct 2025 10:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="f4PofdCJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C9F83927; Thu, 30 Oct 2025 10:55:47 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B99838BB
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 10:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 9880CC0DAA9;
 Thu, 30 Oct 2025 09:55:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0A5136068C;
 Thu, 30 Oct 2025 09:55:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0D67E118084F2; Thu, 30 Oct 2025 10:55:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761818143; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xOzFDW1vYJ7xNb4tLrOk7sU6iIhCGpXB1BhU1Gh7HuE=;
 b=f4PofdCJfdmZeJfx25f6Ew09dtSxOENoCi1UMGfrmvBbkJuUCmT6UR0rqzUqdBAIU5Ddw2
 OxkZFTMJOX9DWZAOZ7LHFfMwJf3H+40hHXViYU/StleCHBG6x9EnPrjkI/szPJMpF7L9DZ
 dXgMHACuEPQE/aG91zPviaC6+rsh9LgdjFjOlbYZSM7IzZebDhNCc6oarlAllN9a5iKaaC
 Q6hqnc6TworddnfLw0smWT4uKcaG7yWLsq9w+76yQGYFvOAagd4DPMRz7WuDSwnSojYmO8
 ffyxD1pe3RPn9e2bKzFzrq2Od7sOfzKUV0x2KkT8m/j56POC09tXAbANxC0tmg==
Date: Thu, 30 Oct 2025 10:55:37 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede
 <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v4 00/20] Convert extension support to UCLASS and adds
 its support to boot flows
Message-ID: <20251030105537.0b1df227@kmaincent-XPS-13-7390>
In-Reply-To: <20251030003136.GA2558427@bill-the-cat>
References: <20251022-feature_sysboot_extension_board-v4-0-d24b5ef7b468@bootlin.com>
 <20251030003136.GA2558427@bill-the-cat>
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

On Wed, 29 Oct 2025 18:31:36 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Wed, Oct 22, 2025 at 05:20:11PM +0200, Kory Maincent (TI.com) wrote:
>=20
> > This series converts the extension board framework to use UCLASS as
> > requested by Simon Glass, then adds extension support to pxe_utils
> > and bootmeth_efi (not tested) to enable extension boards devicetree load
> > in the standard boot process.
> >=20
> > I can't test the imx8 extension scan enabled by the
> > imx8mm-cl-iot-gate_defconfig as I don't have this board.
> > I also can't test the efi bootmeth change as I don't have such board. =
=20
>=20
> This has fail to build problems on:
> sandbox_spl sandbox_noinst sandbox_vpl

Ok I will take a look at these build errors.

> Seems otherwise fine however, size growth on platforms not utilizing
> this looks good. It's a big big when you need it, but it's main U-Boot
> and I think in the end, something we can live with.

Do you see some improvement I could make in v5 to decrease the footprint of=
 this
support?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
