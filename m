Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9C3CD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 18:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42D43848BC;
	Tue,  9 Jun 2026 20:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="RyY/BGdd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6B5848D7; Tue,  9 Jun 2026 20:26:50 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC9F84869
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 20:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bf1cdcfd6deso719353966b.3
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 11:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781029608; cv=none;
 d=google.com; s=arc-20240605;
 b=RGmj7LXfa3AYLd1CrL9DGuukzlhHhcmPsyWRfgUw3VG5z0N+Sd1laazrn+gbjANs16
 5ApP4ZjXRuv10CZplxaA8UKX32fbHC12XsqnOG3CtBb3p/IS+1z+Wb5vxUKYNm2xXZQj
 ZyjFKswU+1DFX26HKBx12qwvlOr02yOTvPI27AMkoJ3KXjYh6MWvcc5LLPJa+YULmDVi
 99w7GrlB9DiTejxQK+tJCKFI85t/vpBuSTquZgrNXcpMUMewJlKElI0I4fj71wWje/Mi
 OsrqPINOoZcwA4VqSGomFL5ZX3CXtF4npzS59sZB1dFfcie2GVog07NagwXdPqgOzwLD
 UBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=afi4Gjp30Wt5a2oE0VhUDtcMojW3qv4/QJR2AgLDG7E=;
 fh=2e0WOH0hwjn2iwz+Eu0MPcAlLPc6kLKk93lD71nuBnI=;
 b=iUSksF2hGXKAQf5+tUvZj3rhrneWgRsB9XB4moR7C6R+qKifvsuC7XqY4N4v6rzFl2
 /9NoHdsG/63MxXlbcIi+3O/yswi48w/QKkewjW+f9XrUqzFuQQWeWXD4Yq85fmQXFRLH
 5jDmtrv1GC9y5lWW4D7L83RoD4LLWQQpl9PMFodA3QgVGNyE1KWUqgMPgiUFL11ZeUAu
 SAHN6WUHCt4l2zNCfGNG2YQ02HqRBZzu0s5xtJDWo6eABbilzOLn89KcGTlIPSl6LuuW
 FMYJtMftSs9NBU97Vlr7Dp0I4u6qkxeaKXttXVe4RSYbBYdV7f11F6ngOsiQP4vW8dDU
 22/Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1781029608; x=1781634408; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afi4Gjp30Wt5a2oE0VhUDtcMojW3qv4/QJR2AgLDG7E=;
 b=RyY/BGddVP5RqwULUsowPBWgxUEl9YRL+AcCUWcwZuMn6wL/Jxo85qa6W7wJDtrAKc
 ffdBjQ6PNKWJ746seySA3kCter92Ij7fo35tYWiEY3EiQ5s31+Bg5T42DfqHMRQtIVrw
 EK4aVRGqYar3GtfniWB/x4Th9ip2vqkPsvejBGcC8ILD+QsBfCUz6r3g5DinonKwjde0
 XjtlQuqVuEpklhOwguLjOvLMSInqtta56dW+vyLtPuABsuAI2ISGAihcRdLzAtfs83Zs
 pFLhqhYhBWU837t34CC1wj0BhFPB101v1pUul3/ehBNeQbic37CwcKbNuevhKdoBZde6
 4jfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781029608; x=1781634408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=afi4Gjp30Wt5a2oE0VhUDtcMojW3qv4/QJR2AgLDG7E=;
 b=FsdgsFk8md444pSQHlvp9e+YdrC4sume+Oe50YHqnRr/HZT0HSKXDhgIi43J3ZH+62
 cv/PVZmBghuxYz5LGhQ+z4bUqc+Sya9BdD234/48y5bvR+wUc/rI0MEYm0dXk2Pdm9J2
 bNfVRVieyvgqu5+tRUq8LT31rN/kOoKxDVOzKG+YV4L8qviJwSgzaQj0rxVDik9dIAgb
 kuEHWacmBNr5ogoUrkStXxNzaC440ed25T6MrjrVYnT7s3WqlKOkbR5lEbe5v817KCv1
 iMzFVJE0XNtrMEMqcTx04mu17DQov553J1Uqj6r4cPAVsIRLGZjzPuR8ETks9+XSUADn
 j2tQ==
X-Gm-Message-State: AOJu0YwP35e40pORwQ15nWYeavK9RoMxkyAtG6X/pSux3aDZh7lJFiwb
 UVPGgWWrCIKXDcdlzu2h5pDdl52BzBcUOrgkS/YiQL5DS+iPLoafFLdJXRDOZTeoSB4sLB0m1Q1
 ThkwCmhOENeUjulwbLlRpMnW+UzpaMw9Nw8c0dAbpHkibXUYJpgBvL/M3nqiI
X-Gm-Gg: Acq92OEUVjkMM7e3hdbN3UhBR+am5AwlQXZVGbPf7u4mFBbwgr7lPGyIDqeZEO/8nVR
 +os6qHaJ+rtnOYmTai1pdy3l2lYZRQMGiSZwja+obRif/gADhsjhixoCkvs/HBevUAsuCxhCWHY
 4QzdlUZET1LgtfRNJsjM2FNPEf757OAAOIuAQ22wAvEsyMtHskhDFG4jF1W4QXnzeKvw+gxXUrm
 3beo6nWUApaoKwHoGGwc3PkiPPsD4Znppp347v+4yrL9yCjmU7BH8y0CcOsHCc8VEwwLMAkyEml
 SxjTD4A2UhtmkWJeq5FO/xosBouKH7NYKgSYIXPDIWAgISMSAsA=
X-Received: by 2002:a17:907:267b:b0:bec:bd4f:e495 with SMTP id
 a640c23a62f3a-bf37155192bmr783586666b.12.1781029607614; Tue, 09 Jun 2026
 11:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
 <20260609-atf-falcon-v1-4-2b20c5e83615@flipper.net>
 <baf04b5d-ef0a-4c58-a796-d09edd6c84b7@kwiboo.se>
In-Reply-To: <baf04b5d-ef0a-4c58-a796-d09edd6c84b7@kwiboo.se>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 9 Jun 2026 22:26:36 +0400
X-Gm-Features: AVVi8Cf_umxCT5vW2KrGItZwTbLLKUmK73fpd5JtaGdYwmyLYxylL63rpM5tQSI
Message-ID: <CAKTNdwEQx6SfKgD=RbbznVgLuMLA5P1UbJ3b+KR4j4L4GyCfoA@mail.gmail.com>
Subject: Re: [PATCH 4/4] rockchip: binman: Add support for Falcon mode FIT
 images with ATF+Linux
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Jonas,

On Tue, Jun 9, 2026 at 9:54=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wrot=
e:
>
> Hi Alexey,
>
> On 6/9/2026 6:52 PM, Alexey Charkov wrote:
> > Modern Rockchip SoCs such as RK3576 require ATF to be running to provid=
e
> > firmware services to the OS. To enable booting Linux in Falcon mode on
> > such SoCs, add binman support for generation of FIT images containing
> > appropriately split ATF raw binaries (as is currently done by binman fo=
r
> > U-boot proper images), externally preprocessed DTB and a Linux kernel.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >  Makefile                           |   2 +
> >  arch/arm/dts/rockchip-u-boot.dtsi  | 109 +++++++++++++++++++++++++++++=
++++++++
> >  tools/binman/etype/falcon_fdt.py   |  26 +++++++++
> >  tools/binman/etype/linux_kernel.py |  22 ++++++++
> >  4 files changed, 159 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index 4e5c1dd6a1c4..844e5adb7b31 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1690,6 +1690,8 @@ cmd_binman =3D $(srctree)/tools/binman/binman $(i=
f $(BINMAN_DEBUG),-D) \
> >               $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
> >               -a atf-bl1-path=3D${BL1} \
> >               -a atf-bl31-path=3D${BL31} \
> > +             -a linux-kernel-path=3D${LINUX_KERNEL} \
> > +             -a falcon-fdt-path=3D${FALCON_FDT} \
> >               -a tee-os-path=3D${TEE} \
> >               -a ti-dm-path=3D${TI_DM} \
> >               -a opensbi-path=3D${OPENSBI} \
> > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-=
u-boot.dtsi
> > index 4ba6a87e78ab..866a6ab654ca 100644
> > --- a/arch/arm/dts/rockchip-u-boot.dtsi
> > +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> > @@ -161,6 +161,96 @@
> >                       };
> >               };
> >       };
> > +
> > +#ifdef CONFIG_SPL_OS_BOOT
> > +     fit_falcon_template: template-falcon {
>
> Not sure it is possible, but this looks to add lots of duplicated
> content. Could we try to re-use more, e.g. is it possible to extract
> @atf-SEQ, and I also think we may want to support loading of TEE-OS?

Makes sense, will try to refactor a bit to reduce duplication.

> > +             type =3D "fit";
> > +             description =3D "FIT image for Falcon Linux with bl31 (TF=
-A)";
> > +             #address-cells =3D <1>;
> > +             fit,fdt-list-val =3D "u-boot";
> > +             fit,external-offset =3D <CONFIG_FIT_EXTERNAL_OFFSET>;
> > +             fit,align =3D <512>;
> > +
> > +             images {
> > +                     @atf-SEQ {
> > +                             fit,operation =3D "split-elf";
> > +                             description =3D "ARM Trusted Firmware";
> > +                             type =3D "firmware";
> > +                             arch =3D FIT_ARCH;
> > +                             os =3D "arm-trusted-firmware";
> > +                             compression =3D "none";
> > +                             fit,load;
> > +                             fit,entry;
> > +                             fit,data;
> > +
> > +                             atf-bl31 {
> > +                             };
> > +#ifdef FIT_HASH_ALGO
> > +                             hash {
> > +                                     algo =3D FIT_HASH_ALGO;
> > +                             };
> > +#endif
> > +                     };
> > +
> > +                     kernel {
> > +                             description =3D "Linux kernel";
> > +                             type =3D "kernel";
> > +                             arch =3D FIT_ARCH;
> > +                             os =3D "linux";
> > +                             compression =3D "none";
> > +                             load =3D <0x48000000>;
> > +                             entry =3D <0x48000000>;
>
> We should not hard-code these here, they seem to be RK3576 specific.

Fair enough. Should probably come from configs.

> > +
> > +                             linux-kernel {
> > +                             };
> > +#ifdef FIT_HASH_ALGO
> > +                             hash {
> > +                                     algo =3D FIT_HASH_ALGO;
> > +                             };
> > +#endif
> > +                     };
> > +
> > +                     fdt-1 {
> > +                             description =3D "falcon-fdt";
> > +                             type =3D "flat_dt";
> > +                             arch =3D FIT_ARCH;
> > +                             compression =3D "none";
> > +                             load =3D <0x52000000>;
>
> Same here.

Ack

> > +
> > +                             falcon-fdt {
> > +                             };
>
> If I am not mistaken we can already inject an external DT to be used as
> control fdt during U-Boot build using EXT_DTB env, maybe it is better to
> use that instead of passing in a new FDT?
>
> We probably also want to use @fdt-SEQ and @config-SEQ to be able to
> dynamically load a config based on e.g. board_fit_config_name_match()
> that some boards already use to select config/fdt for U-Boot proper.

Indeed, that would be quite interesting to have to make it all less
hardcoded. Does board_fit_config_name_match() also work in SPL?

> > +#ifdef FIT_HASH_ALGO
> > +                             hash {
> > +                                     algo =3D FIT_HASH_ALGO;
> > +                             };
> > +#endif
> > +                     };
> > +             };
> > +
> > +             configurations {
> > +                     default =3D "config-1";
> > +                     @config-SEQ {
> > +                             description =3D "RK3576 Falcon Linux via =
ATF";
>
> This is rockchip-u-boot.dtsi, drop RK3576 specific parts :-)

RK3576 is the whole world to me! :-D

Will do, thanks for pointing out

> > +                             fit,firmware =3D "atf-1", "kernel";
> > +                             fit,loadables;
> > +                             fdt =3D "fdt-SEQ";
> > +#ifdef FIT_HASH_ALGO
> > +                             hash {
> > +                                     algo =3D FIT_HASH_ALGO;
> > +                             };
> > +#endif
> > +                     };
> > +             };
> > +     };
> > +
> > +     falcon-fit {
> > +             filename =3D "u-boot-rockchip-falcon.itb";
>
> Do we need to export this file? the old .itb-file is exported because
> some distro build scripts or flash instructions still use the older
> files instead of the preferred u-boot-rockchip.bin.

Yes, this is the file you would actually flash onto, say, dedicated
UFS LUN to preserve Linux-to-U-boot fallback path.

I'm currently overwriting my main U-boot by `rockusb write-file 16384
u-boot-rockchip-falcon.itb` but in a normally working setup one
wouldn't want to do that, so a pre-packed image with the SPL and the
rest is less helpful in Falcon mode. The combo of
`idbloader.img`+`u-boot-rockchip-falcon.itb` is what I believe should
be used, with the former going to W-LU-A and the latter going wherever
there's enough space for a Linux image.

> > +
> > +             fit {
> > +                     insert-template =3D <&fit_falcon_template>;
> > +             };
> > +     };
> > +#endif
> >  #endif /* HAS_FIT */
> >
> >       simple-bin {
> > @@ -260,6 +350,25 @@
> >               };
> >               };
> >       };
> > +
> > +#ifdef CONFIG_SPL_OS_BOOT
> > +     simple-bin-usb472-falcon {
>
> Do we really need this? As you notice the BootROM loader is not really
> optimized for large payloads, I thought using a 1-2 MiB payload with
> TF-A + U-Boot proper was stretching it, sending a full Linux kernel seem
> like a big stretch, as evidenced by the 6 minute load time?

It's neat for CI workloads and quick testing to jump straight to Linux
without persistent storage or TFTP servers. I'm hoping to resolve the
slow boot ROM execution one way or another, maybe by poking some CRU
registers from boost.bin.

There have also been attempts at enabling opensource TPL on RK3576 and
RK356x, so if/when they land we would be free to adjust clocks much
earlier, hopefully making the boot faster. After all, it works
brilliantly when booting from fixed storage, so there isn't much
reason for it not to work from Maskrom, apart from the particular boot
ROM on RK3576 being capricious (not sure if it applies to other RK
SoCs).

> > +             filename =3D "u-boot-rockchip-usb472-falcon.bin";
> > +             pad-byte =3D <0x00>;
> > +
> > +             u-boot-spl {
> > +             };
> > +
> > +             payload {
> > +                     type =3D "section";
> > +                     align =3D <CONFIG_SYS_CACHELINE_SIZE>;
>
> nit: blank line between props and nodes.

Ack

> > +                     u-boot-any {
> > +                             type =3D "fit";
> > +                             insert-template =3D <&fit_falcon_template=
>;
> > +                     };
> > +             };
> > +     };
> > +#endif
> >  #endif /* CONFIG_ROCKCHIP_MASKROM_IMAGE */
> >  };
> >  #endif /* CONFIG_SPL */
> > diff --git a/tools/binman/etype/falcon_fdt.py b/tools/binman/etype/falc=
on_fdt.py
> > new file mode 100644
> > index 000000000000..7c5b13b60d05
> > --- /dev/null
> > +++ b/tools/binman/etype/falcon_fdt.py
> > @@ -0,0 +1,26 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +# Copyright (c) 2026 Flipper FZCO
> > +#
> > +# Entry type for Linux DTB used in Falcon mode FIT images.
> > +
> > +from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
> > +
> > +
> > +class Entry_falcon_fdt(Entry_blob_named_by_arg):
> > +    """Falcon Linux DTB for Rockchip maskrom Falcon image
> > +
> > +    Properties / Entry arguments:
> > +        - falcon-fdt-path: Filename containing the Falcon Linux DTB (o=
ptional,
> > +            defaults to 'u-boot.dtb')
> > +
> > +    This allows selecting the Falcon DTB from an environment variable =
passed
> > +    through binman entry arguments, while defaulting to the built U-Bo=
ot
> > +    control DTB when not provided.
> > +    """
> > +
> > +    def __init__(self, section, etype, node):
> > +        super().__init__(section, etype, node, 'falcon-fdt')
> > +        # Entry_blob defaults filename to etype when no filename is pr=
ovided.
> > +        # Treat that as "unset" and fall back to the control DTB.
> > +        if not self._filename or self._filename =3D=3D self.etype:
> > +            self._filename =3D 'u-boot.dtb'
> > diff --git a/tools/binman/etype/linux_kernel.py b/tools/binman/etype/li=
nux_kernel.py
> > new file mode 100644
> > index 000000000000..15a1da690c4f
> > --- /dev/null
> > +++ b/tools/binman/etype/linux_kernel.py
> > @@ -0,0 +1,22 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +# Copyright (c) 2026 Flipper FZCO
> > +#
> > +# Entry-type module for Linux kernel binary blob
> > +
> > +from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
> > +
> > +
> > +class Entry_linux_kernel(Entry_blob_named_by_arg):
> > +    """Linux kernel image blob
> > +
> > +    Properties / Entry arguments:
> > +        - linux-kernel-path: Filename of file to read into entry. This=
 is
> > +            typically an uncompressed ARM64 Image.
> > +
> > +    This entry allows binman FIT templates to consume a kernel provide=
d via
> > +    make variable, similar to how BL31 is passed to atf-bl31.
> > +    """
> > +
> > +    def __init__(self, section, etype, node):
> > +        super().__init__(section, etype, node, 'linux-kernel', require=
d=3DTrue)
> > +        self.external =3D True
> >
>
> New binman etypes require new tests for 100% code coverage.

Ack

> Also do we need to update Rockchip documentation to cover Falcon mode?

Yes, that would be right, thanks for pointing out.

Thank you for looking into this!

Best regards,
Alexey
