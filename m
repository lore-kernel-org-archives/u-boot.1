Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D988CAC587
	for <u-boot@archiver.kernel.org>; Sat, 13 Sep 2025 16:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 886CD82FC7;
	Sat, 13 Sep 2025 18:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NypMffjV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC91583043; Sat, 13 Sep 2025 18:49:51 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88BD282AE1
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 18:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1757782188; x=1758386988; i=xypron.glpk@gmx.de;
 bh=azUEpTeboBurJL8ek1c/0NDmmvhojKTrMeA3niBZAuE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=NypMffjVrnW/YxXi/RS/PSMA2a+V5LmB5I2QbAnTuLCFMWPGBeW2Pvuky3w6QmKD
 5JET60VPoOJuagQApcwmRi44vX/ggr1CKLV4FkNIr8X7Uur+30S3hBctSRJ45DMiv
 lfxSjs22SDyikSftXwK3R3dVYlR1qEx6nVf/E/gfwZtXxXp+OwWdckcgq3Wax2GyX
 rFmromUj+S3QlrvnMp84jG1V7rOLE0VWfzsyYMoDvGKdb3cyfA4DwpJs3O0OQVnjm
 OjngN1+pKtOeTrGyCitV78Bjh4jVyId22NIpY43BUX6m+I1DXx6mc6Fr2bavvFqAr
 vr3gi/uHrzDnPGejiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([46.114.107.82]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MacOW-1uQtmL3R50-00l7Zb; Sat, 13 Sep 2025 18:49:47 +0200
Date: Sat, 13 Sep 2025 18:49:46 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH] doc: Convert README.commands.spl to rST
User-Agent: Thunderbird for Android
In-Reply-To: <20250913151807.GE124814@bill-the-cat>
References: <20250912230257.4145026-1-trini@konsulko.com>
 <19c6abe0-c71e-4542-bf61-0e9f57c74c58@gmx.de>
 <20250913151807.GE124814@bill-the-cat>
Message-ID: <8581B186-2D03-4905-81CC-1AECC3E5C1B2@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:avYNs/tmyEFxEDCQceIwG0tOZv6dl0TwG+2uYmNz+dYTw1W3LVJ
 asAUBivgAcAWoBPtKhcz/HcIlucHn03u4grFrndpvM2Mxm8SMUgPzh74lJD4xknyrl5CrTt
 FhbLHzNH4+OfFVGJXVDF+HGSRE2T6a1NIqAFL+hkxSBvcKm8/iFcok4aTerlZhTNx4g2EhW
 9s9RBzJbhkgnQNwCUUpgQ==
UI-OutboundReport: notjunk:1;M01:P0:fuP355MMmfA=;3uwX3iCT1LRg+rJtqvM3ypQ/cIY
 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
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

Am 13=2E September 2025 17:18:07 MESZ schrieb Tom Rini <trini@konsulko=2Eco=
m>:
>On Sat, Sep 13, 2025 at 02:32:26AM +0200, Heinrich Schuchardt wrote:
>> On 9/13/25 01:02, Tom Rini wrote:
>> > This converts the existing README=2Ecommands=2Espl file to rST as
>> > doc/usage/cmd/spl=2Erst and adds it to the command index=2E Minimal
>> > rewording is done to the previous contents, to make it fit better wit=
h
>> > the overall style of documentation now=2E
>> >=20
>> > Signed-off-by: Tom Rini <trini@konsulko=2Ecom>
>> > ---
>> > Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>> > ---
>> >   doc/README=2Ecommands=2Espl | 31 --------------------------
>> >   doc/usage/cmd/spl=2Erst   | 48 ++++++++++++++++++++++++++++++++++++=
+++++
>> >   doc/usage/index=2Erst     |  1 +
>> >   3 files changed, 49 insertions(+), 31 deletions(-)
>> >   delete mode 100644 doc/README=2Ecommands=2Espl
>> >   create mode 100644 doc/usage/cmd/spl=2Erst
>> >=20
>> > diff --git a/doc/README=2Ecommands=2Espl b/doc/README=2Ecommands=2Esp=
l
>> > deleted file mode 100644
>> > index ecfd3ca9ee58=2E=2E000000000000
>> > --- a/doc/README=2Ecommands=2Espl
>> > +++ /dev/null
>> > @@ -1,31 +0,0 @@
>> > -The spl command is used to export a boot parameter image to RAM=2E L=
ater
>> > -it may implement more functions connected to the SPL=2E
>> > -
>> > -SUBCOMMAND EXPORT
>> > -To execute the command everything has to be in place as if bootm sho=
uld be
>> > -used=2E (kernel image, initrd-image, fdt-image etc=2E)
>> > -
>> > -export has two subcommands:
>> > -	atags: exports the ATAGS
>> > -	fdt: exports the FDT
>> > -
>> > -Call is:
>> > -spl export <fdt|atags> [kernel_addr] [initrd_addr] [fdt_addr if fdt]
>> > -
>> > -
>> > -TYPICAL CALL
>> > -
>> > -on OMAP3:
>> > -nandecc hw
>> > -nand read 0x82000000 0x280000 0x400000	/* Read kernel image from NAN=
D*/
>> > -spl export atags			/* export ATAGS */
>> > -nand erase 0x680000 0x20000		/* erase - one page */
>> > -nand write 0x80000100 0x680000 0x20000	/* write the image - one page=
 */
>> > -
>> > -call with FDT:
>> > -nandecc hw
>> > -nand read 0x82000000 0x280000 0x400000	/* Read kernel image from NAN=
D*/
>> > -tftpboot 0x80000100 devkit8000=2Edtb /* Read fdt */
>> > -spl export fdt 0x82000000 - 0x80000100	/* export FDT */
>> > -nand erase 0x680000 0x20000		/* erase - one page */
>> > -nand write <adress shown by spl export> 0x680000 0x20000
>> > diff --git a/doc/usage/cmd/spl=2Erst b/doc/usage/cmd/spl=2Erst
>> > new file mode 100644
>> > index 000000000000=2E=2E59471c65a623
>> > --- /dev/null
>> > +++ b/doc/usage/cmd/spl=2Erst
>> > @@ -0,0 +1,48 @@
>> > +=2E=2E SPDX-License-Identifier: GPL-2=2E0+:
>>=20
>> %s/GPL-2=2E0+/GPL-2=2E0-OR-LATER/
>>=20
>> Cf=2E https://spdx=2Eorg/licenses/GPL-2=2E0-or-later=2Ehtml
>
>Yes, and it's not a hard requirement to use the new tag, checkpatch=2Epl
>doesn't even complain=2E I got this from the existing command I copied,
>FWIW=2E
>
>>=20
>> > +
>> > +=2E=2E index::
>> > +   single: spl (command)
>> > +
>> > +spl command
>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > +
>> > +Synopsis
>> > +--------
>> > +
>> > +::
>> > +
>> > +    spl export <fdt|atags> [kernel_addr] [initrd_addr] [fdt_addr if =
fdt]
>>=20
>> Those brackets cannot be correct=2E I definitively cannot remove the
>> kernel_addr and provide an initrd_addr instead=2E Do you mean:
>>=20
>> spl export <fdt|atags> [kernel_addr [initrd_addr [fdt_addr if fdt]]]
>
>It's what the command itself says currently, however=2E
>
>I'd be happy to do a follow-up patch to fix both=2E

I am fine with the current patch if you supply the follow up=2E =20



>
>> > +
>> > +Description
>> > +-----------
>> > +
>> > +The *spl* command is used to export a boot parameter image to RAM=2E=
 Later
>>=20
>> In the current state the man-page is not very helpful=2E Please, move t=
he more
>> extensive description from doc/develop/falcon=2Erst here=2E
>
>As I said in the commit message, it's a conversion with minimal changes=
=2E
>I'd be happy to do a follow-up however improving it (and making
>cmd/spl=2Ec's help text also better/correct)=2E
>
>> * I would not know what a "boot parameter image" might be=2E Please, ex=
plain
>> it for a novice user=2E
>> * Please, describe what each parameter is used for=2E
>> * Please, explain what atags refers to=2E I would assume you mean what =
is
>> described in https://developer=2Earm=2Ecom/documentation/den0013/0400/B=
oot-Code/Booting-Linux/Kernel-parameters-using-ATAGs=2E
>> But don't expect a novice user to know=2E
>> * What does the command do if "fdt" is used?
>>=20
>> > +it may implement more functions connected to the SPL=2E
>> > +
>> > +spl export
>> > +~~~~~~~~~~
>>=20
>> This heading makes no sense=2E
>
>I just copied doc/usage/cmd/acpi=2Erst for format as it's the first file=
=2E
>I'd be happy to look at a better example=2E
>
>> > +To execute the command everything has to be in place as if bootm sho=
uld be
>>=20
>> Bootm can for instance boot a FIT image with an EFI binary=2E
>> I wouldn't expect this to work when booting in Falcon mode where EFI is=
 not
>> available=2E
>>=20
>> This sentence should be replaced by a meaningful description=2E
>
>I don't understand what's unclear, sorry=2E And yes, Falcon mode and EFI
>aren't compatible, but that should be spelled out in
>doc/develop/falcon=2Erst and not here I think=2E
>
>>=20
>> > +used=2E (kernel image, initrd-image, fdt-image if used)=2E The first=
 argument
>> > +passed to the export subcommand must be either atags or fdt, which s=
ignifies if
>>=20
>> %s/signifies/indicates/
>>=20
>> > +we are preparing an ATAGS or device tree for export=2E
>>=20
>> Isn't ATAGs the plural form of ATAG?
>
>The most consistent usage is "ATAGS" and not "ATAGs"=2E
>
>> Why would you write 'an ATAGS' if there are multiple tags?
>>=20
>> Please, describe under which circumstances and with which values these
>> environment variables are filled and what they are used for=2E
>>=20
>> * fdtargsaddr
>> * fdtargslen
>
>These are covered in doc/develop/falcon=2Erst which should be linked from
>this document I think=2E
>
>> > +
>> > +Example
>> > +-------
>> > +
>> > +On an OMAP3 platform with ATAGS::
>> > +
>> > +    =3D> nandecc hw
>> > +    =3D> nand read 0x82000000 0x280000 0x400000	/* Read kernel image=
 from NAND*/
>>=20
>> What format must the image have to be used for booting? A FIT image?
>>=20
>> > +    =3D> spl export atags			/* export ATAGS */
>>=20
>> Is spl export atags never used with kernel_addr, initrd_addr, fdt_addr?
>>=20
>> Does `spl export atags` without further arguments create any ATAGs?
>> Where would it take the values from?
>
>Working with ATAGS was indeed "fun"=2E I'd honestly rather follow-up and
>remove ATAGS support from Falcon mode since it's 2025 and not 2012, but
>the point of this patch is to move doc/README=2E* content to rST so that
>we can then go "oof, that needs work" and try and improve it=2E
>
>> > +    =3D> nand erase 0x680000 0x20000		/* erase - one page */
>> > +    =3D> nand write 0x80000100 0x680000 0x20000	/* write the image -=
 one page */
>>=20
>> What is written to nand here?
>> What relevance have these magic addresses?
>> How would a user know which address to use?
>
>More of the magic of ATAGS, which we can be glad aren't relevant
>anymore=2E It's always at that magic 0x100 offset=2E And the "on OMAP3" i=
s
>the key to decoding the rest=2E
>
>> > +On an OMAP3 platform with device tree::
>> > +
>> > +    =3D> nandecc hw
>> > +    =3D> nand read 0x82000000 0x280000 0x400000	/* Read kernel image=
 from NAND*/
>> > +    =3D> tftpboot 0x80000100 devkit8000=2Edtb /* Read fdt */
>> > +    =3D> spl export fdt 0x82000000 - 0x80000100	/* export FDT */
>>=20
>> Why would anybody use a device-tree from a TFTP server in conjunction w=
ith a
>> kernel from nand?
>
>It was the example at the time=2E But, because there's not a device tree
>on NAND, that's what spl export is creating=2E
>

It is unclear what the command does due to the incompleteness of this man-=
page=2E

Is it copying the device-tree? Is it creating ATAGs?

Is it adding ATAGs to a device-tree  copy?

>>=20
>> > +    =3D> nand erase 0x680000 0x20000		/* erase - one page */
>> > +    =3D> nand write <adress shown by spl export> 0x680000 0x20000
>>=20
>> The address seems to be gd->bd->bi_boot_params which is hard coded in b=
oard
>> files and not visible to the user=2E This is just gruesome=2E The addre=
ss should
>> be exported to a variable to be usable in scripts=2E
>
>Preparing a board for falcon mode isn't a general task, you need to know
>what your platform is and where things are because you're about to make
>it a lot less flexible=2E
>
>> Which customizing is needed to use the spl command? These settings seem=
 to
>> be relevant and should be described in sufficient detail:
>>=20
>> CONFIG_CMD_SPL
>> CONFIG_OF_LIBFDT
>> CONFIG_CMD_SPL_WRITE_SIZE
>> CONFIG_SUPPORT_PASSING_ATAGS
>> CONFIG_SYS_BOOT_RAMDISK_HIGH
>
>Some of these I suspect so, yes=2E

All of these impact the spl command=2E

Best regards=20

Heinrich=20


>
>> Which return values does the command provide?
>
>Only the standard ones=2E A quick grep on "on success" in doc/usage/cmd
>says we aren't consistent about this phrasing nor inclusion to start
>with=2E I think we should update the "General rules" section of
>doc/usage/cmdline=2Erst to state that "The return value $? is 0 (true) on
>success and 1 (false) on failure unless otherwise noted=2E"=2E
>

