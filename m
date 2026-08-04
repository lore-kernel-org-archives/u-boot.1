Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EE3C55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 20:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF1934073B;
	Tue,  4 Aug 2026 20:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CDJwZB2LFohZ; Tue,  4 Aug 2026 20:10:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B816A4072E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785874228;
	bh=L91a6mmlrhwtvlNkaj0KFAAtllRsHSCerx/Ff/IFjSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R/gT2x7FhvATm8rQRrL150sPATisMDBS2UemAJDsd+PWFN2LXlGcbAyF6UvOGw3TG
	 V5oG60wp1pWEiPjDs0uvGWzvZ068ZZmT3QY5rKBKDJW5Lw4Z+AODD+IsxHAb2rYFQQ
	 pLSErWgpttlT3k2EpCSV+ke6ug5JcJMFdWm/SdcKMpwM8DLCRyU6oDoDoPUrT3j37o
	 elskwqRIlmK5gS4+Udqc077eUMvd6zS6Xs6uY24j+LZgxCttNEJjUCxZaKp5bpqrxi
	 ZM2Q40aG3Fv/jbiRLLwCRzWBGKPK6AB+6G2AC1gGR8RbbzG6EH1EgpTIDCNWJ7UKTg
	 q4EJ71zBkFF6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B816A4072E;
	Tue,  4 Aug 2026 20:10:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E28EE218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 18:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D42EF403E3
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 18:46:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jt2kejnZYZKK for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 18:46:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 63F30403E1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63F30403E1
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 63F30403E1
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 18:46:10 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8eea2so232995a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 11:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785869168; cv=none;
 d=google.com; s=arc-20260327;
 b=OLJL44l/JREZjb3Iprm2wyk+2GmDp7fF3jEVZxRGLsPKpdZiGoXTQ85LWDHGuJuXXn
 9JxzjyJriRyHZPHmoWdhisTFw2S4mXlECu/MKD/WdNOF5eQrloe+TEzOAtTNupDe2MPj
 iIiyXdYkVkud8jalVF/iEpeZ7ZaNVGLKCL4tno5FifkKfasjhaBT3m48Gd1lAL/xX+9a
 3iEV16qXtcC+Ezht9uQTXXKqZHdKBmkkTc1RF6TyU4W+zotiJr63jx9DdesZ8i5NzmgZ
 XZTbx2vVynW9ojQ1foP7vS3+KvDDCeiKv0kdtIvq4D5m3wLegmcOP/ikwRPEblB1BzSq
 om/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L91a6mmlrhwtvlNkaj0KFAAtllRsHSCerx/Ff/IFjSo=;
 fh=IzScIBPEqXDc38dJAdsZ9BkhmTqefgr4mnMGLkLVUM0=;
 b=ZxoY1WowOxJRdS2J9MgnUqusGs1vHy9XpCETukcfG9UnHwfc6WoqndzwkOe7FNHXP2
 IXSin5EOFYNQ0NRp32R6SOamkXlJIG1pn//bS/aibbCvhNi/TFrektV3LSjjQNgg7SKB
 Gkmx0v6AxnGsSyaZdx4tKTZ+sXt3g2aQUkXmVcncAAYJGV0aCBW18DvAZu/Qr60xOqVS
 5l7NPBkr16laaVXau+ia6BGOuVw2RtG2QbXtFLegEex1nBw6qQluID1YV4JW/UHWjq/8
 73gOTl3sdj0gdhN6Mq+V96MT6VpmrLyNwHFULwCLECt7atRqosEfttTPTw/geYVjjXTc
 SORg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785869168; x=1786473968;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L91a6mmlrhwtvlNkaj0KFAAtllRsHSCerx/Ff/IFjSo=;
 b=iSI+zIecOifuG9kjOzviFffTgZNTgRyAhpl1xRTfAOomqkruACmxodSi/F0wfY0pL+
 c7lkoOrOCgd4juQ8fzRZqc+X7W1aPG6LoZdw4qAaVC849cKqK53SAsFO0OOG92TdIcKe
 RUvYSieJb165j1ru7YOVv+q50W8ds3JJctpqGl8EpqkYg1m6j+UWWinLxR7BHpaApnts
 P/mcPvTNHEmYp5xP3KenolSkVjHcm/ZO1O6DSOjSwf9H6e7LtU5L+7KPt5JRp1NksTKW
 HvwmigVczuY+IKkq5FsaJPBP6mIqGarx1weawrRlykwcVl3hwBZEzbNgx8j4xWeEFVlA
 /sjw==
X-Gm-Message-State: AOJu0YyaI2NEn8+NH0gPrzvMbkA/FH7frdscpVhXWjwQdZrqN+cViqRh
 +kyT1NZAujPGMU8pduJT7olbJLSKts5gECU3kcSHFRnah5V1HbtumnO7PJ4YLeBnN/tAG4Erjnc
 AgDH6ODBmOAkvVN0quc9Ig9XwmuuOGf3CmQAZfCuR
X-Gm-Gg: AR+sD11GtaLVjNjLZ59gZqucq6Zninyhy8Xlel56rs4U4ics2XGYULIYKZL23aaiHoY
 LcvL1jpPGbCH09y/JW0kNl8DVFpy5ivgXRwwXdUm2e2glbP3mtzbpNdgbsjkV5Lk1iMmic/ObTC
 UGp4iw19dig5zJCOGCalW0yQi65ebwvf+7sow0G5phhqmpbqBrn69RrhJr2UNZkStNwgSzHldl9
 r7lYrbMz1I3guc1drOMeixqqnRGNzgHBJeEpm80eylzk+HYFu7Gw+aJM5AfO5pJr0t4IAgnMDCe
 vX3hfACfpYYfI13vbhzPnRwP8UbwFvqez4kO/vnVRis=
X-Received: by 2002:a05:6402:2b87:b0:6a0:6978:bee0 with SMTP id
 4fb4d7f45d1cf-6a14f0e4910mr675781a12.9.1785869168182; Tue, 04 Aug 2026
 11:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-9-acb97c172993@flipper.net>
 <CAFLszTgXZxWP2KCweVgD27bGQiusRx6G3RDiG8BuQCe6Mdat4g@mail.gmail.com>
 <CAKTNdwEDbR66-wn9fvmVFxGpOGjCmhJVcxgvVYbD_pCOb0SL-A@mail.gmail.com>
In-Reply-To: <CAKTNdwEDbR66-wn9fvmVFxGpOGjCmhJVcxgvVYbD_pCOb0SL-A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 12:45:55 -0600
X-Gm-Features: AUfX_mzkVmW9edu8YIppHX1tYNWMuKL_WMHjUh49xUEn9Bc54pyHXdKEdFvp5os
Message-ID: <CAFLszThhBtMemqqMt6fji_kqe+L7CEZc2KXq7Fp1JSLv=qxZpQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] rockchip: binman: Add support for Falcon mode
 FIT images with TF-A+Linux
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Aug 2026 20:10:27 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785869168; x=1786473968;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L91a6mmlrhwtvlNkaj0KFAAtllRsHSCerx/Ff/IFjSo=;
 b=ElSahiyKKdQbjCDvmHN4HR4Gd2V43R3p2+YXAu45lpDHkjjVrqkvYyiEQPBzM9VlBI
 69hjE+4ivfeIWOIFuCODeeOyliTRsUkE/BWchF9Hm77uGcSacSOPsKcfk1hRIxQuUSNl
 6eN1zFz5xcFdDPyVf5idFCxtjJaDkjSDztzEg=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ElSahiyK
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On Tue, 4 Aug 2026 at 08:38, Alexey Charkov <alchark@flipper.net> wrote:
>
> Hi Simon,
>
> On Tue, Aug 4, 2026 at 5:03=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Alexey,
> >
> > On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> > > rockchip: binman: Add support for Falcon mode FIT images with TF-A+Li=
nux
> > >
> > > Modern Rockchip SoCs such as RK3576 require TF-A to be running to pro=
vide
> > > firmware services to the OS. To enable booting Linux in Falcon mode o=
n
> > > such SoCs, add a binman template for generation of FIT images contain=
ing
> > > appropriately split TF-A and TEE binaries (as is currently done by bi=
nman
> > > for U-boot proper images), externally provided Linux kernel and optio=
nally
> > > an initrd.
> > >
> > > Any FDTs provided to the generator will be pre-patched with a /chosen
> > > node containing an initrd load address and size (if an initrd is prov=
ided)
> > > and a bootargs property containing the kernel command line (if provid=
ed),
> > > so that the kernel can be booted directly without external preprocess=
ing.
> > >
> > > A config fragment rockchip-falcon.config can be used to enable Falcon
> > > mode boot and the building of TF-A+Falcon with binman, e.g.:
> > >
> > >   make nanopi-m5-rk3576_defconfig \
> > >         rockchip-falcon.config
> > >
> > > [...]
> > >
> > > arch/arm/dts/rockchip-u-boot.dtsi     | 204 +++++++++++++++++++++++++=
+++------
> > >  arch/arm/mach-rockchip/Kconfig        |  49 ++++++++
> > >  board/rockchip/rockchip-falcon.config |   3 +
> > >  3 files changed, 225 insertions(+), 31 deletions(-)
> >
> > > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchi=
p-u-boot.dtsi
> > > @@ -260,6 +372,36 @@
> > > +             payload {
> > > +                     type =3D "section";
> > > +                     align =3D <CONFIG_SYS_CACHELINE_SIZE>;
> > > +                     /*
> > > +                      * Must be named 'u-boot-any', unlike the non-F=
alcon
> > > +                      * image which can call this 'fit': SPL declare=
s
> > > +                      * binman_sym(u_boot_any, image_pos) unconditio=
nally, and
> > > +                      * binman resolves that symbol against an entry=
 of that
> > > +                      * exact name or one called u-boot[-elf|-img|-n=
odtb].
> > > +                      * Those only exist here by way of a U-Boot ima=
ge inside
> > > +                      * the FIT, which a Falcon FIT does not carry, =
so without
> > > +                      * this name the symbol cannot be resolved and =
binman
> > > +                      * fails. The type property is what selects the=
 etype.
> > > +                      */
> > > +                     u-boot-any {
> > > +                             type =3D "fit";
> > > +                             insert-template =3D <&fit_falcon_templa=
te>;
> > > +                     };
> >
> > A node called u-boot-any whose type is fit - needing a nine-line
> > comment to explain why - is a strong hint that we are papering over
> > something. Patch 8 already adds binman_sym_declare_optional() for the
> > payload symbol on the RAM_DEVICE path; the cleaner fix is to make
> > u_boot_any similarly optional (or key off SPL_OS_BOOT/RAM_DEVICE) in
> > common/spl/spl.c so a Falcon-only image does not need this pretence.
> > Then this entry can simply be named fit like its sibling in
> > simple-bin-usb472 and the comment goes away. What do you think?
>
> Hmm, that woud be nice indeed. Let me give it a try.
>
> > > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchi=
p-u-boot.dtsi
> > > @@ -161,6 +182,97 @@
> > > +                     ramdisk {
> > > +                             description =3D "ramdisk";
> > > +                             type =3D "ramdisk";
> > > +                             arch =3D FIT_ARCH;
> > > +                             compression =3D "none";
> > > +                             load =3D <FALCON_INITRD_LOAD>;
> > > +
> > > +                             linux-initrd {
> > > +                                     optional;
> > > +                             };
> >
> > Just to check - when LINUX_INITRD is not provided, does the outer
> > ramdisk image node still land in the FIT as a zero-byte data blob, and
> > does SPL then try to load a zero-byte ramdisk loadable to
> > FALCON_INITRD_LOAD? _process_firmware_prop() skips missing entries
> > when populating firmware, but I couldn't convince myself the same
> > happens for the enclosing image node itself. If it does not, please
> > add a testcase (or drop the ramdisk node entirely when the inner entry
> > is absent).
>
> The node still lands in the FIT with a size of zero, and the loader
> skips it based on its zero size. See also a related fix here:
>
> https://patchwork.ozlabs.org/project/uboot/patch/20260730-b4-spl-fit-clea=
r-loadable-v1-1-6f10c724f2b5@flipper.net/
>
> > > diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/=
Kconfig
> > > @@ -758,6 +758,55 @@ config ROCKCHIP_MASKROM_IMAGE
> > > +config ROCKCHIP_FALCON_KERNEL_LOAD
> > > +     hex "Falcon mode kernel load offset"
> > > +     depends on ROCKCHIP_FALCON_IMAGE
> > > +     default 0x10000000
> >
> > These three offsets are per-SoC in practice (BL31 / OP-TEE carve-outs
> > differ between RK3568, RK3576, RK3588=E2=80=A6) yet the defaults are th=
e same
> > for every Rockchip target. Please either narrow the default to the SoC
> > families you have validated, or add a note in the help text listing
> > which SoC the 0x10000000 / 0x1c000000 / 0x1e000000 layout matches, so
> > users of other Rockchip parts do not silently overlap BL31 and wonder
> > why the kernel never starts.
>
> Indeed, I haven't checked which segments BL31/TEE want to load to on
> SoCs other than RK3576; I only checked the addresses they hardcode
> elsewhere in U-Boot. Let me revisit this part, thanks for calling it
> out.
>
> > > diff --git a/board/rockchip/rockchip-falcon.config b/board/rockchip/r=
ockchip-falcon.config
> > > @@ -0,0 +1,3 @@
> > > +CONFIG_ROCKCHIP_FALCON_IMAGE=3Dy
> > > +CONFIG_SPL_OS_BOOT=3Dy
> > > +CONFIG_SYS_SPI_KERNEL_OFFS=3D0x0
> >
> > CONFIG_SYS_SPI_KERNEL_OFFS depends on SPL_SPI_FLASH_SUPPORT &&
> > SPL_OS_BOOT and is only read by common/spl/spl_spi.c - none of the
> > boot paths added by this series use it. Please drop this line, or
> > explain in the commit message why it needs to be forced to 0 here.
>
> The nanopi-m5 defconfig enables SPL_SPI_FLASH_SUPPORT, so without
> giving this option a value I end up with an endless loop of prompts
> for it when building non-interactively (even though it's never used in
> my setup). Maybe defaulting it to the U-Boot offset inside the
> relevant Kconfig would be cleaner - let me check if that works.

OK see how you go, but if you do need it, just mention it in the commit mes=
sage.

Regards,
Simon
