Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552ABCCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 09:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB8B282C84;
	Mon, 20 Oct 2025 11:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="FutyJXgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71312831D6; Mon, 20 Oct 2025 11:50:32 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E290A807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 11:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id A49A0C0AFD7;
 Mon, 20 Oct 2025 09:50:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0B138606D5;
 Mon, 20 Oct 2025 09:50:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1F292102F23A5; 
 Mon, 20 Oct 2025 11:50:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760953823; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=50NTcOCkTu+fs9O7XMVCb30VK0XjVpJb9jK6s20qxTc=;
 b=FutyJXgq9bfZVWicVOzQLhMhDtVoC1N3wWRPn9p7RrLa6MmpOjJ3DdUu4Wmkyd8VSpIfV8
 Mn6U03MuxdwHas9kG7YvvmapyqGVYmREFooKEYYJKkzwh8AB9PfiBEd1bjw7JOn5Yhica0
 4fr1WYvzm6BwArhtENxIaDKsTUM6nzFVgs7lsWRbbPaMNBVVtQFCjjxTU7SReGlh0/47rl
 4Bi8hFYAP5h4bHWN0nPD2zQfrmbDJR91CjZ4kUN55szvcBSM7sRnJgIGxP3XNWVaV0cIe9
 aItFqgEoZE/j42blRpjbUFF4fY0PVs+2ato4whVHO/SnXS22X0YXf13m9BLG6Q==
Date: Mon, 20 Oct 2025 11:50:09 +0200
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
Subject: Re: [PATCH v3 00/20] Convert extension support to UCLASS and adds
 its support to boot flows
Message-ID: <20251020115009.532a1a99@kmaincent-XPS-13-7390>
In-Reply-To: <20251019162234.GQ6688@bill-the-cat>
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
 <CAFLszThGVL1powrtDa+niBuxU-b_3YDs6TQ96igx-cj-PGvf=g@mail.gmail.com>
 <20251019162234.GQ6688@bill-the-cat>
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

On Sun, 19 Oct 2025 10:48:37 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Sun, Oct 19, 2025 at 02:05:51PM +0100, Simon Glass wrote:
> > Hi Kory,
> >=20
> > On Mon, 13 Oct 2025 at 14:32, Kory Maincent (TI.com)
> > <kory.maincent@bootlin.com> wrote: =20
> > >
> > > This series converts the extension board framework to use UCLASS as
> > > requested by Simon Glass, then adds extension support to pxe_utils
> > > and bootmeth_efi (not tested) to enable extension boards devicetree l=
oad
> > > in the standard boot process.
> > >
> > > I can't test the imx8 extension scan enabled by the
> > > imx8mm-cl-iot-gate_defconfig as I don't have this board.
> > > I also can't test the efi bootmeth change as I don't have such board.=
 =20
> >=20
> > You can test this with sandbox, using one of the bootmeth tests,
> > perhaps. Let me know if you need help with this. =20
>=20
> But the question is, does the real hardware platform work before/after
> this, not does the sandbox test still work before/after this.

It seems the bootlflow scan is not working on the sandbox on next branch.
Is this issue known?

=3D> bootflow scan -l=20
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------
---------------- Scanning global bootmeth 'efi_mgr':
     efi_var_to_file() Cannot persist EFI variables without system partition
   efi_tcg2_register() Missing TPMv2 device for EFI_TCG_PROTOCOL
    efi_rng_register() Missing RNG device for EFI_RNG_PROTOCOL
Hunting with: simple_bus
Found 2 extension board(s).
Hunting with: mmc
Hunting with: nvme
Hunting with: qfw
Hunting with: scsi
scanning bus for devices...
Hunting with: spi_flash
Hunting with: virtio
Scanning bootdev 'qfw_sandbox.bootdev':
[1]    487232 segmentation fault (core dumped)  ./u-boot

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
