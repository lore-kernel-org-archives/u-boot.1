Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC1DC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 18:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC97840702;
	Tue,  4 Aug 2026 18:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r_4-JtGX48Qd; Tue,  4 Aug 2026 18:13:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B72834070A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785867208;
	bh=n5E3HrSfHP1ohaglGrQUl35YnfzrmGW59ijAHqmW45c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rdIAPMCRXnzU4/8KApU9EX9ErMTdJFvOwr4i0Pf6MSbqpD7eXQs4G8xO9TLr89OcJ
	 44LAOQDER2flCJl1qxrBQrNNLihzD3h2jOO8glnYnEuyl+srhKdNMUWXaNET5mkR2y
	 bzFgxSB/vEawfMneC1iXpSgGPsO4Dj49Abg/thFuuspgO07t2O1FetEBDOJdDT30vx
	 X3x0t6mM733OOY+7XhTsAKizKzFmmk0Nh7JXTRHffXV9U67/CNV31BjmF0jPyBJp96
	 mAhUeTxnaERAcNPX2C9bhaAAPrRvY9+AJKTQh+zBMH1pVqAsbrakNiiPrxA596I+qs
	 3OumaCLfJMFjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B72834070A;
	Tue,  4 Aug 2026 18:13:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0553A2AA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6CD26065E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:38:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9VOVe5GbOUiX for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 14:38:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D4BBE60633
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4BBE60633
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4BBE60633
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:38:51 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38dd55ad76cso1116660a91.1
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 07:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785854331; cv=none;
 d=google.com; s=arc-20260327;
 b=AF83/tEYB92izybLKBpnTsVlzL9osuAj1X1BcJn67vj1O6xvtnGjWNl9B/OZFnh0zT
 qVDNCta6a/ZDLfbVC76GGApAW/yxohkDggdWYDcNwAr6Dbbof8HBUWXu70e6dOu3vkGD
 ylyv7aKBCEiTWS5GUADjXsOVLkAitjowzhQngugWB2BergMnFD1f3Aa3XOgfS4GOvLEb
 7YgCWT5dqrOXZGa1b6ezoVfrWE5qqxAnA+JSeo2MvcJBI5G4pd+BVGiTRzGpzN49C+cA
 pXHljXBQh3rTyItRUjQKqL6OjtXTy1FJMTimoBeW5NCV1HMYLrfUv/lOT56FmVuZbw2m
 Oluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n5E3HrSfHP1ohaglGrQUl35YnfzrmGW59ijAHqmW45c=;
 fh=mVR9Y/rQZk34FU/ncVJcP5o4w0wahIppgQrEM7okHPo=;
 b=rvGHn6vBTrguCa+EeoUZg2Eud7n99xzx6UenmbZ1Vv73I6Om1jAKYnH+wkTBrbCd+d
 0vaXQFjaKcxdW0T2aAtdeamwiybrHiTP5EjwfJD/WwbESynWT4NR/7qfwYxbkST/puz3
 nogB9VquWlutMvk1k/XZBjnoLr7vyuh+bG3rtGM/2Z44Yi1iJjapinZWXc2XzR5LLhKF
 9ZsSUYEMfrP0YdOZPMuV1VXEKoG5s1WdjBGj46PG2aSz0sqmP8cd0OgroM3VAj8c+efy
 maz0Kb0p3Uca5LQtwhJpvorpS9vBNz4UMk4+JgwDP1qycUcvpMBBDHRSIz4ZpWhaH5gd
 fhIg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785854331; x=1786459131;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n5E3HrSfHP1ohaglGrQUl35YnfzrmGW59ijAHqmW45c=;
 b=RullSG1gjNk4v2GDqYs2l+K6mTg2eH0LrfrAXoIU3SxQXdgQw1s6BNybOkhS+UgjEG
 spHsWvUNk2QiXK8EXUaCi7ZV7fqlPmnmAef2mWdkarmaUk6AJk6NJbm+SXYMTZzTNCny
 A4oUlCWzsBkhluonSGwv/CBXqn7elbgEyNqWti8FoLviwhumxPn3oHMe2ZfCOiiEAnhi
 Fbm5CcbgTmcDZRFOW/iVeXdPIbSRDT7zUwLuxIJcMYR5pAP9wEQyRni6oizkDXrnzpT6
 GrOLGzLVaYVlWWKzoPRkSHcsF/OC/1Ou64Ayvf6jpq7G9yP0+4tLVBz8EK/C7KhjGl40
 fEMQ==
X-Gm-Message-State: AOJu0YzvLGvyidpGSt2RqsP9ZX3apAs6TkxPNOre8lm+w7q8+w8rU9B6
 QHzG/2mgc7/FwE00JXh8OeA4zghMRlnKYKMWNiFIV6Ahdyatz/86/c9UvR1ZxOJ7h2uMv9tnFqh
 RAIPkYVctgUyiXklOz3QaGoijED9E705RWAfx3ZlZJA==
X-Gm-Gg: AR+sD12Z+6aaMcT4LtABvY6dd4bmscPt7f/DSN5Js9qnCUyNPANKqp5QkkRPwZWRELB
 lOsjVoBak15EnlKvGqhRkHNXAqyJwbL2ISHv9WmCm/MTm3DhUcJ2bSSpffgLmRXWi6TjvUN9MHp
 I4rrW5ZL/64kQ89JYz0sXX6WTfK80kHiGsVycvT4vVAdTGalG8hj58jGe+yEeF4jRVXidmbr31H
 xNvKfmEsmKSpsUPei2vOEMFjVvjcwaJwz72HSOGVUzNw0x0SxEHHprtw0ap+UMdSLC+4yhOH15t
 iNyXT/0QH0Ncuq2wjQ1c6LdaW6tKZOs62WdVUH7vg2H+ckM2tKp/YoqXg92Yo9grx+1lMNYhtir
 d
X-Received: by 2002:a17:90b:3f47:b0:36b:de66:92c3 with SMTP id
 98e67ed59e1d1-38fec1815c5mr3826850a91.10.1785854330890; Tue, 04 Aug 2026
 07:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-9-acb97c172993@flipper.net>
 <CAFLszTgXZxWP2KCweVgD27bGQiusRx6G3RDiG8BuQCe6Mdat4g@mail.gmail.com>
In-Reply-To: <CAFLszTgXZxWP2KCweVgD27bGQiusRx6G3RDiG8BuQCe6Mdat4g@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 4 Aug 2026 18:38:41 +0400
X-Gm-Features: AUfX_mzBZs3ljeDo13t_SX40A1YOFvtvikvkNgUa2LouMB52KZI5kNuCFxFbUAc
Message-ID: <CAKTNdwEDbR66-wn9fvmVFxGpOGjCmhJVcxgvVYbD_pCOb0SL-A@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] rockchip: binman: Add support for Falcon mode
 FIT images with TF-A+Linux
To: Simon Glass <sjg@chromium.org>
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
X-Mailman-Approved-At: Tue, 04 Aug 2026 18:13:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785854331; x=1786459131;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n5E3HrSfHP1ohaglGrQUl35YnfzrmGW59ijAHqmW45c=;
 b=hcPFIKQEA7TMoCT3HPbt1T8b8ON/O9pWed04Tisjm0gN6WSU/duhESY7fv1BMppNHl
 qQZcSyTfclXcgjrsJStyDzuFSQIsfuz4z57SajEqaV6qRvgBdBJ/fAhhYE0Rby9cjWLN
 gJSooLbj6UdXYJEzkenFLTganYD5CibZKJbTQen+iiL/90e16E0KAsPfP45qdm9vXwTs
 tfAm0Vsq0sLVGKPupcIAePO5T3UktAW3RBwJt894+MoamgRu9vu+HCp3RTHBw0Cei/Wt
 YzrzkxisK/RAjQMFn9fwLkwzottklfwFK1+SkYNGEKgoBSCQ8wWWE+hf3gH8GF1nkQ7d
 pYaw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=hcPFIKQE
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

Hi Simon,

On Tue, Aug 4, 2026 at 5:03=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Alexey,
>
> On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> > rockchip: binman: Add support for Falcon mode FIT images with TF-A+Linu=
x
> >
> > Modern Rockchip SoCs such as RK3576 require TF-A to be running to provi=
de
> > firmware services to the OS. To enable booting Linux in Falcon mode on
> > such SoCs, add a binman template for generation of FIT images containin=
g
> > appropriately split TF-A and TEE binaries (as is currently done by binm=
an
> > for U-boot proper images), externally provided Linux kernel and optiona=
lly
> > an initrd.
> >
> > Any FDTs provided to the generator will be pre-patched with a /chosen
> > node containing an initrd load address and size (if an initrd is provid=
ed)
> > and a bootargs property containing the kernel command line (if provided=
),
> > so that the kernel can be booted directly without external preprocessin=
g.
> >
> > A config fragment rockchip-falcon.config can be used to enable Falcon
> > mode boot and the building of TF-A+Falcon with binman, e.g.:
> >
> >   make nanopi-m5-rk3576_defconfig \
> >         rockchip-falcon.config
> >
> > [...]
> >
> > arch/arm/dts/rockchip-u-boot.dtsi     | 204 +++++++++++++++++++++++++++=
+------
> >  arch/arm/mach-rockchip/Kconfig        |  49 ++++++++
> >  board/rockchip/rockchip-falcon.config |   3 +
> >  3 files changed, 225 insertions(+), 31 deletions(-)
>
> > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-=
u-boot.dtsi
> > @@ -260,6 +372,36 @@
> > +             payload {
> > +                     type =3D "section";
> > +                     align =3D <CONFIG_SYS_CACHELINE_SIZE>;
> > +                     /*
> > +                      * Must be named 'u-boot-any', unlike the non-Fal=
con
> > +                      * image which can call this 'fit': SPL declares
> > +                      * binman_sym(u_boot_any, image_pos) unconditiona=
lly, and
> > +                      * binman resolves that symbol against an entry o=
f that
> > +                      * exact name or one called u-boot[-elf|-img|-nod=
tb].
> > +                      * Those only exist here by way of a U-Boot image=
 inside
> > +                      * the FIT, which a Falcon FIT does not carry, so=
 without
> > +                      * this name the symbol cannot be resolved and bi=
nman
> > +                      * fails. The type property is what selects the e=
type.
> > +                      */
> > +                     u-boot-any {
> > +                             type =3D "fit";
> > +                             insert-template =3D <&fit_falcon_template=
>;
> > +                     };
>
> A node called u-boot-any whose type is fit - needing a nine-line
> comment to explain why - is a strong hint that we are papering over
> something. Patch 8 already adds binman_sym_declare_optional() for the
> payload symbol on the RAM_DEVICE path; the cleaner fix is to make
> u_boot_any similarly optional (or key off SPL_OS_BOOT/RAM_DEVICE) in
> common/spl/spl.c so a Falcon-only image does not need this pretence.
> Then this entry can simply be named fit like its sibling in
> simple-bin-usb472 and the comment goes away. What do you think?

Hmm, that woud be nice indeed. Let me give it a try.

> > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-=
u-boot.dtsi
> > @@ -161,6 +182,97 @@
> > +                     ramdisk {
> > +                             description =3D "ramdisk";
> > +                             type =3D "ramdisk";
> > +                             arch =3D FIT_ARCH;
> > +                             compression =3D "none";
> > +                             load =3D <FALCON_INITRD_LOAD>;
> > +
> > +                             linux-initrd {
> > +                                     optional;
> > +                             };
>
> Just to check - when LINUX_INITRD is not provided, does the outer
> ramdisk image node still land in the FIT as a zero-byte data blob, and
> does SPL then try to load a zero-byte ramdisk loadable to
> FALCON_INITRD_LOAD? _process_firmware_prop() skips missing entries
> when populating firmware, but I couldn't convince myself the same
> happens for the enclosing image node itself. If it does not, please
> add a testcase (or drop the ramdisk node entirely when the inner entry
> is absent).

The node still lands in the FIT with a size of zero, and the loader
skips it based on its zero size. See also a related fix here:

https://patchwork.ozlabs.org/project/uboot/patch/20260730-b4-spl-fit-clear-=
loadable-v1-1-6f10c724f2b5@flipper.net/

> > diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kc=
onfig
> > @@ -758,6 +758,55 @@ config ROCKCHIP_MASKROM_IMAGE
> > +config ROCKCHIP_FALCON_KERNEL_LOAD
> > +     hex "Falcon mode kernel load offset"
> > +     depends on ROCKCHIP_FALCON_IMAGE
> > +     default 0x10000000
>
> These three offsets are per-SoC in practice (BL31 / OP-TEE carve-outs
> differ between RK3568, RK3576, RK3588=E2=80=A6) yet the defaults are the =
same
> for every Rockchip target. Please either narrow the default to the SoC
> families you have validated, or add a note in the help text listing
> which SoC the 0x10000000 / 0x1c000000 / 0x1e000000 layout matches, so
> users of other Rockchip parts do not silently overlap BL31 and wonder
> why the kernel never starts.

Indeed, I haven't checked which segments BL31/TEE want to load to on
SoCs other than RK3576; I only checked the addresses they hardcode
elsewhere in U-Boot. Let me revisit this part, thanks for calling it
out.

> > diff --git a/board/rockchip/rockchip-falcon.config b/board/rockchip/roc=
kchip-falcon.config
> > @@ -0,0 +1,3 @@
> > +CONFIG_ROCKCHIP_FALCON_IMAGE=3Dy
> > +CONFIG_SPL_OS_BOOT=3Dy
> > +CONFIG_SYS_SPI_KERNEL_OFFS=3D0x0
>
> CONFIG_SYS_SPI_KERNEL_OFFS depends on SPL_SPI_FLASH_SUPPORT &&
> SPL_OS_BOOT and is only read by common/spl/spl_spi.c - none of the
> boot paths added by this series use it. Please drop this line, or
> explain in the commit message why it needs to be forced to 0 here.

The nanopi-m5 defconfig enables SPL_SPI_FLASH_SUPPORT, so without
giving this option a value I end up with an endless loop of prompts
for it when building non-interactively (even though it's never used in
my setup). Maybe defaulting it to the U-Boot offset inside the
relevant Kconfig would be cleaner - let me check if that works.

Best regards,
Alexey
