Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D66AF94CBC
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 02:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C76E842E7;
	Wed, 22 Apr 2026 04:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b0Hl/ra/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E100B83936; Wed, 22 Apr 2026 03:15:32 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB86805D7
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9c01854477so849256066b.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776820530; cv=none;
 d=google.com; s=arc-20240605;
 b=IcrGha0dTQoRxuD+55Yksc739DPMcNctS4HsgBFjWH1Q85tfGrUPKDLsDDX5h4hNVu
 G5p4+8HxhYLudEQ2MkwTJCB6y/FhV82rCVxmr3MaKgQ+JgSvjlltDMbYbz97yGnb6ZCr
 d9wbYcPRytuxiRq05S1vORFkg0JO3hIyAdD3DHQ/OGxBgT7Diw8GRcwDJf9DASpJy2wF
 Wt4veJ4HUpY9JXY5GWBaSObwd6RQTtIYo9BMtVrs3bZuMIrrYZ6aKAAecUNOdNZ/OpS6
 vHE+tyb02Nc7MfDcSsUbOoBetLq7eEce6/dfmYoaBnr7GWmgSjI25d6bJkTDOOzhzd+J
 ieCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kJTcAKtGzzsGTU6Wij8LFxv0zF6h2OtTfuh/N0hox6s=;
 fh=Dn+NeNbT7H4eiBBsAHUTxg/DffLNi1t5upqfabkK5bE=;
 b=jfPhzn5GG56D8hr2VD+4Vyd9wKSN2OObteLs54BtbAXfFXsJ2CUcdeYQBX10IKipxb
 oE/yAZi+hJVmckFKVO/JC5/nuk+X30eTYmqfd09TybL5SNQzeRyUm5uLx8ZlfZf3XOft
 XbiP/U/op0v67D6dXrbqSkRwWjGfw7KTxpAOMOttyWOqsB2mTCD7O2hLz1gHDLFCORgt
 +faRyI8CeMKBAehxSnMobwasfgiftAfQfN2F4ueKzVITfkxG4/4SW/Wtl8vCUWwdc2x2
 HmbCoxz0HNyLYt6CztSPVUH73NIYyef1Yoo8zIt5A2I4E6LBRVMO4vPDcPcWGueEGI5j
 Bcbw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776820530; x=1777425330; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kJTcAKtGzzsGTU6Wij8LFxv0zF6h2OtTfuh/N0hox6s=;
 b=b0Hl/ra/v41zuufTRpkVECNLXUm7cSvHjfFRErPhMWdV8bpewWXTzg/9mKIf86SgVO
 cJw/BBxEp9qD7pvJuZjSsQMvJ/0dpdL7BwQxcaokC3h4bxOWodyXVBeY/euitCFKmIji
 UHUkDVHcwtRl1a7Fhg13bk+w9MaJCcEQgzV1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776820530; x=1777425330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJTcAKtGzzsGTU6Wij8LFxv0zF6h2OtTfuh/N0hox6s=;
 b=Me0La9Tv081WoWv+I8DmH6a246uQygAo6Gx2OqvueOGIr1tm5koq8UmFF+x0aaz6Qh
 Eeew+y5HSf89vkrF6IRujdmUA+0fTzep0FqV8vrGAbVNEMoWBkhXw07OxKDn4XlcAzBV
 v9zDiZEfZT+mDI84ZlJuyBjvpb97RHKE1yg7t8wSobigzk5usVI/plSW+7j7BGRtL+ae
 scFsqH6O0o0PjFU2yLkBFpfZ0hroYM8Vam0/X+LS7qCApc3GVey03/E+BxHvEBbtWEpX
 1w1RP6GhIHnAgFvhxOqjgeip2/82m2dG6dj3zdGT298Gj8Ncpi1BSqxHLq7KyeYO0OZm
 svSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BexKFFld2FwR7keE5NKXCE2HLJmzvQipVzWqmD/cT3mBm8FD9WPNDn1dJ9T9xocMvbEbkO+w=@lists.denx.de
X-Gm-Message-State: AOJu0YzquRQnDeBCyaad12WYkejGQOgbDnGi9cs+IYVGO3YLZzJQ1isR
 L58vg5+NLHGHwHLKO1L38wH+ISQ9PNCkGrmDMgSRt0/LSi2uj3kPVupwV+TUc0S2KA4s9KmsyZA
 7mzrbArQ6Bmwf5pr6auz1c1EGQkVOrZ20R9eN2NZU
X-Gm-Gg: AeBDietE/MYIHvHDmXax6FGbqN1TvSVIvJ/5FqQNeLKtkDCX3xywIp8yz+7lq/Y4XLk
 rvm85zwQaXkBDC1ggCLPkY9Irb4RZc4qOjnOajyeWltppGO0CoRlQgpQJQa+XSscmTB+JXNO1Y1
 C19HXci3XJk2vNA/J1A3Ik59rzmgXieRjfxsMoWVh9/gSLT83jXYG13HDuWVc8r+tC/7MZ1hRTO
 DPSeHEa0y8MlIj/FmiBSCfYWLT+fYBVOneV1LhN+sP0D/b4u8hpGFSsZXbxfp+ce73tNtUYOaFN
 /oOGCIUcSoHBvd6xILyx0Y+ftCOQNfw=
X-Received: by 2002:a17:907:1c96:b0:b87:173f:61b with SMTP id
 a640c23a62f3a-ba41bacff3fmr859763266b.9.1776820529776; Tue, 21 Apr 2026
 18:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-3-varadarajan.narayanan@oss.qualcomm.com>
 <aeYpRSg2S6p8dNZt@sumit-xelite>
In-Reply-To: <aeYpRSg2S6p8dNZt@sumit-xelite>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 13:15:16 +1200
X-Gm-Features: AQROBzA2eaZAukTB9F1WJZux94QZtHKoPIqnyCSGVuRYpQXwKdfiyWgkmgrNxyo
Message-ID: <CAFLszTjhes-C6dmAVhUhn8EphOXbqQ3JBD_FCj=C9dm=nAHG3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] doc: board/qualcomm: Update RDP build instructions
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, peng.fan@nxp.com, 
 jh80.chung@samsung.com, lukma@denx.de, tien.fong.chee@altera.com, 
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com, 
 alice.guo@nxp.com, quentin.schulz@cherry.de, ilias.apalodimas@linaro.org, 
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, h-salunke@ti.com, 
 alchark@gmail.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com, 
 andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com, 
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com, wens@kernel.org, 
 jamie.gibbons@microchip.com, david.wronek@mainlining.org, 
 alexeymin@postmarketos.org, james.hilliard1@gmail.com, 
 michael@amarulasolutions.com, richard.genoud@bootlin.com, 
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, michael.srba@seznam.cz
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 22 Apr 2026 04:42:51 +0200
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

Hi,

On Tue, 21 Apr 2026 at 08:33, Sumit Garg <sumit.garg@kernel.org> wrote:
>
> Adding Michael
>
> On Fri, Apr 10, 2026 at 02:41:47PM +0530, Varadarajan Narayanan wrote:
> > Add details about the SPL & U-Boot proper build steps, converting to
> > flashable images, source URLs for the needed binaries and scripts.
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > ---
> >  doc/board/qualcomm/rdp.rst | 69 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >
> > diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> > index 99cf8eba57c..d09dba52044 100644
> > --- a/doc/board/qualcomm/rdp.rst
> > +++ b/doc/board/qualcomm/rdp.rst
> > @@ -42,6 +42,67 @@ on your device with::
> >
> >  U-Boot should be running after a reboot (``reset``).
> >
> > +Build steps for IPQ5210 based Qualcomm Dragonwing F8 & N8 Platforms:
> > +====================================================================
>
> Rather than just the build steps, please describe the overall boot flow.
> And since you have created a common SPL file for all the Qcom platforms,
> can you ellaborate on how the boot flow is going to be reused across
> Qcom platforms. Maybe we just need a dedicated spl.rst document here.
>
> Also, how does this series align with one for SPL support on SDM845 here
> [1]? Are there things that both SPL ports can reuse from each other?
>
> [1] https://lore.kernel.org/all/20260411-qcom_spl-v2-0-9609557cf562@seznam.cz/
>
> -Sumit
>
> > +
> > +Please refer to the following URLs for more details about the platforms.
> > +
> > +     F8: https://www.qualcomm.com/networking-infrastructure/products/f-series/f8-platform
> > +
> > +     N8: https://www.qualcomm.com/networking-infrastructure/products/n-series/n8-platform
> > +
> > +1. Since U-Boot SPL is enabled on these platforms, the build command generates
> > +   both the U-Boot SPL and U-Boot proper images. Assuming ${uboot_dir} is the
> > +   top of the U-Boot sources and ${out_dir} as the output directory,
> > +
> > +     $ cd ${uboot_dir}
> > +     $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> > +     $ make -j8 O=${out_dir} qcom_ipq5210_mmc_defconfig
> > +     $ make -j8 O=${out_dir}
> > +
> > +   U-Boot SPL image: ${out_dir}/spl/u-boot-spl.wrap-elf
> > +   U-Boot image:     ${out_dir}/u-boot.elf
> > +
> > +2. Convert the SPL image to multi ELF
> > +
> > +     $ cd ${out_dir}/spl
> > +     $ python elftombn.py -f u-boot-spl.wrap-elf -o u-boot-spl.mbn -v7
> > +     $ python create_multielf.py -f u-boot-spl.mbn,tmel-ipq52xx-patch.elf \
> > +                                     -o u-boot-spl.melf
> > +
> > +   This u-boot-spl.melf should be flashed into 0:SPL partition.
> > +   Please see below for the location of ``tmel-ipq52xx-patch.elf``
> > +
> > +3. Convert the U-Boot image to bootloader image
> > +
> > +     $ cd ${out_dir}
> > +     $ python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
> > +
> > +   The u-boot.mbn has to be combined with qc_config.elf, QCLib.elf, TFA and
> > +   OPTEE. Please see below for the location for these ELFs. TFA and OPTEE can be
> > +   built from the sources using the following commands
> > +
> > +   TFA:
> > +     $ make PLAT=ipq52xx QTISECLIB_PATH=path/to/libqtisec_dbg.a SPD=opteed
> > +
> > +   OPTEE:
> > +     $ make PLATFORM=qcom-ipq52xx -j16
> > +
> > +   These binaries can be combined into a flashable image using ``gen_its.py``.
> > +
> > +     $ python gen_its.py --arch ipq5210              \
> > +             --qclib_path QCLib.elf                  \
> > +             --qcconfig_path qc_config.elf           \
> > +             --tfa_bl31_path bl31.mbn                \
> > +             --uboot_path u-boot.mbn                 \
> > +             --optee_path tee-raw.mbn                \
> > +             -p qcconfig qclib                       \
> > +             -P tfa_bl31 uboot optee                 \
> > +             -o output/hm_503_test_uboot.img         \
> > +             --template template.its
> > +
> > +   This should be flashed into 0:BOOTLDR partition.
> > +
> >  .. WARNING
> >       Boards with newer software versions would automatically go the emergency
> >       download (EDL) mode if U-Boot is not functioning as expected. If its a
> > @@ -56,3 +117,11 @@ U-Boot should be running after a reboot (``reset``).
> >
> >  .. _elftombn.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/NHSS.QSDK.13.0.5.r2/scripts?ref_type=heads
> >  .. _edl: https://github.com/bkerler/edl
> > +.. _create_multielf.py: https://raw.githubusercontent.com/coreboot/coreboot/refs/heads/main/util/qualcomm/create_multielf.py
> > +.. _tmel-ipq52xx-patch.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/TMEL.WNS.2.4/tmel-ipq52xx-patch.elf
> > +.. _libqtisec_dbg.a: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/WIN.TFA.1.0.R4/apss_proc/out/proprietary/qtiseclib/output/ipq52xx/release/libqtisec_dbg.a
> > +.. _qc_config.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/qc_config.elf
> > +.. _QCLib.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/QCLib.elf
> > +.. _gen_its.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
> > +.. _TFA: https://git.codelinaro.org/clo/trusted-firmware/tf-a/trusted-firmware-a/-/tree/win.tfa.1.0.r4?ref_type=heads
> > +.. _OPTEE: https://git.codelinaro.org/clo/trusted-firmware/optee_os/optee_os/-/tree/win.optee.1.0?ref_type=heads
> > --
> > 2.34.1
> >

I really think this should use binman to produce the image. If needed
I can help write a new entry type, etc. But these sorts of steps and
complexity can be made a lot easier with Binman.

Regards,
Simon
