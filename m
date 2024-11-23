Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3963AE6ADDE
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 04:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F5CE89384;
	Sat, 23 Nov 2024 05:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qttpuUaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD3A893CA; Sat, 23 Nov 2024 05:06:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1117289383
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 05:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732334811; x=1732939611; i=xypron.glpk@gmx.de;
 bh=0+LtG0Rckg0nPlGplG95yV+CdX3x4cv7pJgusIjFoNE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=qttpuUaTJtFUItKds5XexxsA2Yh4JnYmvi2/AIFRvWT+7vXndn0oRBxp0hnuSBAt
 EjoyF0bo3vSC8nT5LpWutSSW9n1isooniOTBCZIGXbm33xBDwjxyqRumZ3RZoWCLC
 u6x5IyeQTU3Mprr5cu4BOCuPcqyJoXGMCqXsEgDRpuJ/xY4UzSVbdlBlCidcYqqRa
 CL/rDIHiBPNszL5/6lnmRFdYTZeF+NuMtyS4lcj4ja9OM18gx6oCMtFDXm7qh7NjK
 2YItyKCiaRc9B876JHWkDhsgfif276Mct941UHOK2qYdzPrKbTeKZfru45PM03kB/
 XfJQQ3zaWQcJhMAUvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.107.241]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QJJ-1tFWMo1WdR-00Bo5A; Sat, 23
 Nov 2024 05:06:51 +0100
Date: Sat, 23 Nov 2024 05:06:49 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v5 3/8] efi_loader: bootstd: Drop bootmgr for sunxi
User-Agent: Thunderbird for Android
In-Reply-To: <20241123020802.26cba055@minigeek.lan>
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-4-sjg@chromium.org>
 <20241113175017.GS3600562@bill-the-cat>
 <CAFLszTjVgz7HxO8jrvVhGORbccGCN6HHMy7fWz=FJYKrfdyQ+g@mail.gmail.com>
 <20241123020802.26cba055@minigeek.lan>
Message-ID: <3F1F4DAC-39AC-4D17-8C92-A467FE90DA38@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+/Zyva0rqyLK/Zhz3ZR8UhUZ1XAjqWxW6m8duMZw3dogdC+9Go7
 BZgileN62GlWifYFxDnvZOMsJy4Ak+OTYgGM4XyNoZEXD6BqzUNJpz3ohc22jdqT8/cjyqO
 bWnRj747vfY2OeawV8P8dOSIutdKnWYguvaxR2/CCe4z/k1SLOuOwxb4odaiuEuFTr6+IYl
 46IHQnU/1XSawAGMABAUg==
UI-OutboundReport: notjunk:1;M01:P0:QGbQ3PQyLEc=;tFT08N1N6vwStXboDkMs+1y5c4b
 uE7LU/G9k+1fKFsijVVH3GRXOrEpoSC102Apx70BF+38Cd+dE2s8IQ7yJ01+4wBKolkL/zzvP
 eUdNbuBrp8xm4nCqa9XUgjAX6u2h8OGYYqLoNFqXYotpkVeBWYYwBHw5B/7G9ptWAA6hMW0HS
 BgDzft4+RozyiUnMLWsp9gTX7oaJz2zn0nc5FebVsqFbthvY+zOxyrStHSGLnFjOGGURqSa0m
 wnCGanOhB7PpSVzK1v659iCBkKEYU/XxYjpHEN3jbWc0BcPzwmYTZEfDG16qJ8obQ+oJcA2Yy
 zyMM5cpQLQg9w3vgWc6RbaxXFX36ykzepnT0kM9fiRSBFN3LiKWMY/OkcGvTb5rYyDt4SUJw3
 lWEg+M6Ahbkn9ldrO6NbpzPQjfECkgMSzwHYKISQA/YRHwI6CfbPGEg62HbBpz6YT/hfTbCNY
 l0YUTly26hIJKX1r2HJaKEbqziWkmvhdc/1Aq4nO+IzfmYU+MtwYILxIj+5JE1/2HX2J/nvYF
 nvDdzwOdDFIaRNSLz3VRioSXUBIXq8pByA64Kk1cjHZ+yWE+7Bc8RN+t94d33T58sbtK6od28
 +TvUCG4VSCk/acCEmjmqEDfri3prZBGPzFNOJQFj0lnJeR0l3TlbIARO5Dzs+Uh9wO+PChK6W
 kQ/PVwue6fqsSAn9eF47szrbksqVkwZ6yefxqYjXltkJpZP8vqR+l0EapcuhX0MnndAdiAj+D
 Qew2OOBrUfu04pwCf1FDO4RreGYfbKFMjOsIbFsdAn7YekwcvM5o1FJ2qbFc4frZ/GHW3MG0S
 nUHKYsdoyFKBiWdHgKJQv//nhmset2dtd3lBlVHvAkLkuxEkdeOKyXDq5x+OfBykpZCcxdJBD
 GpL3wuQWq1GDXVRYsTBMxQgSXTUVra6/1chDillno0QveDxoYeDzW3Qyu
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

Am 23=2E November 2024 03:08:02 MEZ schrieb Andre Przywara <andre=2Eprzywar=
a@arm=2Ecom>:
>On Fri, 15 Nov 2024 07:21:53 -0700
>Simon Glass <sjg@chromium=2Eorg> wrote:
>
>Hi Simon, Tom, Heinrich,
>
>sorry for the delay, I was away=2E
>
>> On Wed, 13 Nov 2024 at 10:50, Tom Rini <trini@konsulko=2Ecom> wrote:
>> >
>> > On Wed, Nov 13, 2024 at 08:09:33AM -0700, Simon Glass wrote:
>> > =20
>> > > This causes problems with the boot order, so drop it until we can f=
igure
>> > > out a better way to know when bootmgr should be used=2E
>> > >
>> > > Link: https://lore=2Ekernel=2Eorg/u-boot/20241112171205=2E4e80548d@=
donnerap=2Emanchester=2Earm=2Ecom/
>> > >
>> > > Signed-off-by: Simon Glass <sjg@chromium=2Eorg> =20
>> >
>> > I would really prefer a short summary of the contents of the link in =
the
>> > commit message=2E I'm not NAK'ing the patch as-is, but it would be he=
lpful
>> > when revisiting this if there was a short explanation of the problem =
to
>> > solve here and not just "problems with the boot order"=2E Thanks=2E =
=20
>>=20
>> The summary is that sunxi supports FEL (USB boot) but bootmgr is not
>> aware of it, so boots the OS instead=2E
>
>So that's not the problem: FEL is working fine, since it's marked as
>global, same as efi_bootmgr, but with a lower order number=2E The problem
>is that the higher priority non-global methods (scripts) are "ignored"=2E
>
>So this is the list without this patch:
>Order  Seq  Name                Description
>-----  ---  ------------------  ------------------
>    0    0  extlinux            extlinux
> glob    1  fel                 FEL
>    2    2  script              script
> glob    3  efi_mgr             EFI bootmgr flow
>    4    4  efi                 EFI
>    5    5  pxe                 PXE
> glob    6  vbe_simple          vbe-simple
>-----  ---  ------------------  ------------------
>
>The sequence looks roughly alright, only that it's not the actual
>order, since "glob" takes precedence=2E So the actual order is:
>fel -> efi_mgr -> vbe_simple -> extlinux -> script -> efi -> pxe
>And that puts efi_mgr before extlinux and script, which is not what we
>want, because efi_mgr finds bootaa64=2Eefi *somewhere* (eMMC or SD card o=
r
>USB stick) and uses that, even when there is a tailored boot=2Escr or
>extlinux=2Econf on the *boot media* which should be higher priority=2E
>"fel" being first is fine, since it's *only* triggered if someone
>deliberately uploaded a boot script via USB: in this case they surely
>want to execute exactly that=2E
>
>So I think the underlying problem is the "glob" tag for efi_mgr PLUS
>the fact that it scans all media for bootaa64=2Eefi files=2E I think it
>would be fine if efi_mgr would just consider EFI boot order variables,
>and would ignore any "removable media" default files (bootaa64=2Eefi)=2E
>The "efi" bootmeth does the scanning as well, and it's fine there,
>since it's lower priority, so we can still boot EFI systems=2E
>
>I guess it would make sense if an installer on an USB stick should boot
>even if there is something on the eMMC, for instance=2E But we want to
>control that, and we can't, because the order is ignored due to the
>"glob" flag=2E
>
>So while I agree that disabling efi_bootmgr sounds like a hack, it
>solves the problem quite elegantly: We keep the (current) boot order,
>which prioritises scripts over EFI, but still retain EFI=2E If people
>want EFI first, they can change the order in the environment (I think?)=
=2E
>
>Without that patch there is quite a regression for users, because
>suddenly any bootaa64=2Eefi files *somewhere* would be booted first, and
>there is no way to turn that off=2E
>
>This has bitten me actually: for development I put a custom boot=2Escr on
>an SD card which loads a kernel+DTB via TFTP from my box=2E And I want
>that to be first, despite there being a proper EFI setup on the eMMC or
>USB drive=2E
>
>So I hope that clears that up=2E I am not a big fan of that patch, but I
>would like sunxi to be converted, and Simon seemed to be eager to do
>this as well, so in the interest of not blocking this, I am fine with
>that=2E

Disabling EFI will break booting for users that rely on it (like me)=2E

>
>Cheers,
>Andre

Yes, the introduction of boot standard changed the boot order and specific=
ally deprioritizing scripts is unexpected=2E

The priority sequence used to be

scripts
extlinux
efi
pxe

bootmeth_efimgr always running before scripts be fixed=2E bootmeth_efi sho=
uld be removed from the code base as redundant=2E

Best regards

Heinrich


