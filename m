Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E0CCAC597
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 20:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A293782C84;
	Mon, 15 Sep 2025 22:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mi268yR9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3BD88344E; Mon, 15 Sep 2025 22:16:23 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E1C581E13
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 22:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1757967381; x=1758572181; i=xypron.glpk@gmx.de;
 bh=C/0Bk361diP7ZYM8PS0tLk4MhBn9ORfElZH/Ck1dwwY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mi268yR9pTbmcExqkw+SvcnSzbwM20GXQ67FXD67D9EbzMdqgt0r+zAv6pavcSoD
 WJqCVTejDrlWP+Y2XZ4jaEibhbLy3rOdQh07QZE/PwWFe+LaCkHWNSB6zXoJ9a2Gj
 uZepMjC2Yw5MfAyFvn/DLOjiS2Oy+bZpzUxVZ3KgnERFtGDL86w0UnonuADNNy75y
 hw2pX4euBmNKKJFoV/oMi4y9v9rI2C6YZ+0TGYG6rTN94QccflbHjfAXcXq/264cy
 pE0rnMHUPDKommp4kLpcNpOL7g3eT3y/eVCGfAHHsxw4S/DjhfRHheazVoEc5lMLs
 hH8tCpEbkuW9oxCT8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQJ5-1ueGLj3dDD-00mTS4; Mon, 15
 Sep 2025 22:16:21 +0200
Date: Mon, 15 Sep 2025 22:16:19 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH] doc: Convert README.commands.spl to rST
User-Agent: Thunderbird for Android
In-Reply-To: <20250915174231.GM124814@bill-the-cat>
References: <20250912230257.4145026-1-trini@konsulko.com>
 <19c6abe0-c71e-4542-bf61-0e9f57c74c58@gmx.de>
 <20250913151807.GE124814@bill-the-cat>
 <8581B186-2D03-4905-81CC-1AECC3E5C1B2@gmx.de>
 <20250915174231.GM124814@bill-the-cat>
Message-ID: <23D1F8AF-AD2A-4900-A127-A58B59F03007@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sxI6hqOZrCJLaYTX8cQp0l5n2/YCn3Bso+fXfKRjXInL49HtJW8
 MXOIAN1k5ZFrk5WcMEttSFFFBJF7/CpxoOlI9tGAUtnS10J+I/QsWZtAaouzsqO/HGk8ZZx
 X1jQA63wC3cnwTMXBZ674HnfzQu5qR7hY0qzLKsqMofBxcI6APYoAnlRCtJWND0p+ZyQ81L
 QRmuqFS0dL3gtzFoEinQg==
UI-OutboundReport: notjunk:1;M01:P0:G3uKHuZsCqw=;I3RI1DodjeYjhgWs46NpxdKQkPe
 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
 hc0nbEqXlY
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

Am 15=2E September 2025 19:42:31 MESZ schrieb Tom Rini <trini@konsulko=2Eco=
m>:
>On Sat, Sep 13, 2025 at 06:49:46PM +0200, Heinrich Schuchardt wrote:
>> Am 13=2E September 2025 17:18:07 MESZ schrieb Tom Rini <trini@konsulko=
=2Ecom>:
>> >On Sat, Sep 13, 2025 at 02:32:26AM +0200, Heinrich Schuchardt wrote:
>> >> On 9/13/25 01:02, Tom Rini wrote:
>> >> > This converts the existing README=2Ecommands=2Espl file to rST as
>> >> > doc/usage/cmd/spl=2Erst and adds it to the command index=2E Minima=
l
>> >> > rewording is done to the previous contents, to make it fit better =
with
>> >> > the overall style of documentation now=2E
>> >> >=20
>> >> > Signed-off-by: Tom Rini <trini@konsulko=2Ecom>
>> >> > ---
>> >> > Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>> >> > ---
>> >> >   doc/README=2Ecommands=2Espl | 31 --------------------------
>> >> >   doc/usage/cmd/spl=2Erst   | 48 +++++++++++++++++++++++++++++++++=
++++++++
>> >> >   doc/usage/index=2Erst     |  1 +
>> >> >   3 files changed, 49 insertions(+), 31 deletions(-)
>> >> >   delete mode 100644 doc/README=2Ecommands=2Espl
>> >> >   create mode 100644 doc/usage/cmd/spl=2Erst
>> >> >=20
>> >> > diff --git a/doc/README=2Ecommands=2Espl b/doc/README=2Ecommands=
=2Espl
>> >> > deleted file mode 100644
>> >> > index ecfd3ca9ee58=2E=2E000000000000
>> >> > --- a/doc/README=2Ecommands=2Espl
>> >> > +++ /dev/null
>> >> > @@ -1,31 +0,0 @@
>> >> > -The spl command is used to export a boot parameter image to RAM=
=2E Later
>> >> > -it may implement more functions connected to the SPL=2E
>> >> > -
>> >> > -SUBCOMMAND EXPORT
>> >> > -To execute the command everything has to be in place as if bootm =
should be
>> >> > -used=2E (kernel image, initrd-image, fdt-image etc=2E)
>> >> > -
>> >> > -export has two subcommands:
>> >> > -	atags: exports the ATAGS
>> >> > -	fdt: exports the FDT
>> >> > -
>> >> > -Call is:
>> >> > -spl export <fdt|atags> [kernel_addr] [initrd_addr] [fdt_addr if f=
dt]
>> >> > -
>> >> > -
>> >> > -TYPICAL CALL
>> >> > -
>> >> > -on OMAP3:
>> >> > -nandecc hw
>> >> > -nand read 0x82000000 0x280000 0x400000	/* Read kernel image from =
NAND*/
>> >> > -spl export atags			/* export ATAGS */
>> >> > -nand erase 0x680000 0x20000		/* erase - one page */
>> >> > -nand write 0x80000100 0x680000 0x20000	/* write the image - one p=
age */
>> >> > -
>> >> > -call with FDT:
>> >> > -nandecc hw
>> >> > -nand read 0x82000000 0x280000 0x400000	/* Read kernel image from =
NAND*/
>> >> > -tftpboot 0x80000100 devkit8000=2Edtb /* Read fdt */
>> >> > -spl export fdt 0x82000000 - 0x80000100	/* export FDT */
>> >> > -nand erase 0x680000 0x20000		/* erase - one page */
>> >> > -nand write <adress shown by spl export> 0x680000 0x20000
>> >> > diff --git a/doc/usage/cmd/spl=2Erst b/doc/usage/cmd/spl=2Erst
>> >> > new file mode 100644
>> >> > index 000000000000=2E=2E59471c65a623
>> >> > --- /dev/null
>> >> > +++ b/doc/usage/cmd/spl=2Erst
>> >> > @@ -0,0 +1,48 @@
>> >> > +=2E=2E SPDX-License-Identifier: GPL-2=2E0+:
>> >>=20
>> >> %s/GPL-2=2E0+/GPL-2=2E0-OR-LATER/
>> >>=20
>> >> Cf=2E https://spdx=2Eorg/licenses/GPL-2=2E0-or-later=2Ehtml
>> >
>> >Yes, and it's not a hard requirement to use the new tag, checkpatch=2E=
pl
>> >doesn't even complain=2E I got this from the existing command I copied=
,
>> >FWIW=2E
>> >
>> >>=20
>> >> > +
>> >> > +=2E=2E index::
>> >> > +   single: spl (command)
>> >> > +
>> >> > +spl command
>> >> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> > +
>> >> > +Synopsis
>> >> > +--------
>> >> > +
>> >> > +::
>> >> > +
>> >> > +    spl export <fdt|atags> [kernel_addr] [initrd_addr] [fdt_addr =
if fdt]
>> >>=20
>> >> Those brackets cannot be correct=2E I definitively cannot remove the
>> >> kernel_addr and provide an initrd_addr instead=2E Do you mean:
>> >>=20
>> >> spl export <fdt|atags> [kernel_addr [initrd_addr [fdt_addr if fdt]]]
>> >
>> >It's what the command itself says currently, however=2E
>> >
>> >I'd be happy to do a follow-up patch to fix both=2E
>>=20
>> I am fine with the current patch if you supply the follow up=2E =20
>
>OK=2E But I also think that based on some of your questions, the first
>step is to just rip out ATAGS from here=2E We have zero cases in tree of
>ATAGS and SPL_OS_BOOT support, and this is an extremely legacy case=2E
>Deleting that will make things a bit clearer overall=2E The next part is
>that yes, two sentences doesn't explain what's going on here well if you
>don't already know what's going on here=2E
>

From=20what I read ATAGs are used to boot ARM systems that do not yet suppor=
t device-trees=2E This seems to be incompatible with our driver model=2E

Thus, eliminating all ATAG related code is a reasonable way forward=2E

Best regards

Heinrich

