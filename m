Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7FDC04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 18:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2223B877AF;
	Tue, 14 May 2024 20:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Ehach83i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 870A188013; Tue, 14 May 2024 20:35:07 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBB3B87C75
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 20:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51fdc9af005so9677814e87.3
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 11:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1715711704; x=1716316504; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVhe8bTFguWv0HRXZZr1dCzS9a3fy32y6T7xbtQJtYw=;
 b=Ehach83iHu2iW9Mt04ud9FSjURjvxsc9kJ9xo3JoQwDUaCthPAJYt6rvBGdyS4UQ+d
 pK9jKjR8vdBvMsWOEHnaNVVEoLxLamp+87EDJl8LTd2OaUGFCWK55JyFtj6+bj95+vjC
 UvWYSAAZMjsvEjI837ep24XUR4tgg6t6QV4Xx9WllEsfT3/v3jxuQjE9kCJKqsxpZlCh
 V29sP34tpM5lmSABUtAkB6ojtcZBsluGrKfFBcc5WTpOHdQY9vJoi0LgrdA7vqdJr7B5
 WRWz30nAPF4i6Fdh1RSrhPwUOTXxl1FTiaFkbjBC/5Jj2FpEbkzm5H3mWL7Bl8yaSlSw
 7SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715711704; x=1716316504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVhe8bTFguWv0HRXZZr1dCzS9a3fy32y6T7xbtQJtYw=;
 b=mNSYw7xftLalCrJ9wnXB5qoQf77wDcIJDfPQfayMJs0PpCaIRJUYSVUz7CobFAsl5D
 sWglTRdiFYHJ/ay/OsMSn1YZISfo1rsuoRrfHgXvIXyMXRPIezPWw7AY5pkoZs5C7+Ja
 z8QQ76tAgYdzJ1tkwOR9gaWnZ1JhwIOYoQTKBqJ6CdW7+ez1t2Q9GAIhNjhOQKFaJyBL
 EFm/WEP7EzoC30Ep03wFVoQ8gWGx8Ei8RkBt5YPau0jqEmUBaURyLS5/cAmhwTayI3tl
 C+MAtPWMGyVPEjY7jZpd3Iji3q3H2O5ssSDpnHyqy5RrPkEsoEktNWW46u69R0h+CzNY
 +sjQ==
X-Gm-Message-State: AOJu0YyB37OublwazD/ReLZhCTkJTgS9vhEoasdOHc0buTGZ7W+j3b3U
 hKRlttR9LD/wYz4+I0vaS6/p27ub62dB54ljtjgZAvG/NIAt5TcWpadtRR1olVIAxtRFIduERej
 /i/vyq4cMWbnSGnlVsKTnrGRIs8yUAhon7o7uSA==
X-Google-Smtp-Source: AGHT+IHnALnHJESBObnndyBnnHtasGSGIzT0hcll5qyELOl3R6vcqEjUb1JNS+CjiTJbBWFVMDcIewSo52vSmoRM06A=
X-Received: by 2002:a05:6512:1087:b0:523:78de:11a3 with SMTP id
 2adb3069b0e04-52378de12bbmr2407114e87.2.1715711703676; Tue, 14 May 2024
 11:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240503010518.263458-1-marex@denx.de>
 <20240503010518.263458-4-marex@denx.de>
In-Reply-To: <20240503010518.263458-4-marex@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 14 May 2024 11:34:51 -0700
Message-ID: <CAJ+vNU2=k911jK8rYuaCx7qUN9GyCF6GLjuhLi0y82+yq1hYng@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] imx: hab: Use nxp_imx8mcst etype for i.MX8M
 flash.bin signing
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, anton.gres@ifm.com, ch@denx.de, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>, kernel@puri.sm, 
 u-boot@dh-electronics.com
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

On Thu, May 2, 2024 at 6:05=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Update documentation and use nxp_imx8mcst binman etype for signing
> of flash.bin instead of previous horrible shell scripting.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> Cc: Angus Ainslie <angus@akkea.ca>
> Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: kernel@puri.sm
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> ---
> V2: Document the automatic signing in case CONFIG_IMX_HAB is enabled
> ---
>  doc/imx/habv4/csf_examples/mx8m/csf.sh        |  92 ----------------
>  doc/imx/habv4/csf_examples/mx8m/csf_fit.txt   |  30 ------
>  doc/imx/habv4/csf_examples/mx8m/csf_spl.txt   |  33 ------
>  doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 100 +++---------------
>  4 files changed, 14 insertions(+), 241 deletions(-)
>  delete mode 100644 doc/imx/habv4/csf_examples/mx8m/csf.sh
>  delete mode 100644 doc/imx/habv4/csf_examples/mx8m/csf_fit.txt
>  delete mode 100644 doc/imx/habv4/csf_examples/mx8m/csf_spl.txt
>
<snip>
> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/habv=
4/guides/mx8m_spl_secure_boot.txt
> index e16e5410bd9..ce1de659d8c 100644
> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> @@ -121,6 +121,9 @@ build configuration:
>  - Defconfig:
>
>    CONFIG_IMX_HAB=3Dy
> +  CONFIG_FSL_CAAM=3Dy
> +  CONFIG_ARCH_MISC_INIT=3Dy
> +  CONFIG_SPL_CRYPTO=3Dy
>

Hi Marek,

Thanks for wrapping the dts bits with a config item.

Is there any other reason to build with CONFIG_IMX_HAB than to use a
signed image? I see that there are several ARCH_MX6 and ARCH_MX7
configs that have this enabled (not ARCH_IMX8M so this certainly
doesn't break anything) and I'm not sure what the value of that is.

I notice that FSL_CAAM is selected when you select IMX_HAB... is there
any reason why ARCH_MISC_INIT and SPL_CRYPTO should not be selected by
IMX_HAB as well (future patch perhaps)?

>  - Kconfig:
>

We definitely need to describe the additional requirements here. Maybe
something like:

- Tools:
cst - NXP code-signing-tool (eg apt install imx-code-signing-tool)

- Files: (created with NXP IMX_CST_TOOL)
SRK_1_2_3_4_table.bin (specified by nxp,srk-table node): fuse table
CSF1_1_sha256_4096_65537_v3_usr_crt.pem (specified by nxp,csf-crt node): CS=
F_KEY
IMG1_1_sha256_4096_65537_v3_usr_crt.pem (specified by nxp,img-crt node): IM=
G_KEY

The following works fine for me on v2024.01
export CST_DIR=3D/usr/src/nxp/cst-3.3.2/
export CSF_KEY=3D$CST_DIR/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
export IMG_KEY=3D$CST_DIR/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
export SRK_TABLE=3D$CST_DIR/crts/SRK_1_2_3_4_table.bin
export PATH=3D$CST_DIR/linux64/bin:$PATH
make && /bin/sh doc/imx/habv4/csf_examples/mx8m/csf.sh

But with the above defines and your series this fails:
ln -sf $SRK_TABLE SRK_1_2_3_4_table.bin
ln -sf $CSF_KEY CSF1_1_sha256_4096_65537_v3_usr_crt.pem
ln -sf $IMG_KEY IMG1_1_sha256_4096_65537_v3_usr_crt.pem
make
  BINMAN  .binman_stamp
Wrote map file './image.map' to show errors
binman: Error 1 running 'cst -i
./nxp.csf-config-txt.section.nxp-imx8mcst@0 -o
./nxp.csf-output-blob.section.nxp-imx8mcst@0': Error:
Cannot open key file IMG1_1_sha256_4096_65537_v3_usr_key.pem
0:error:02001002:system library:fopen:No such file or
directory:crypto/bio/bss_file.c:288:fopen('IMG1_1_sha256_4096_65537_v3_usr_=
key.
pem','r')
0:error:20074002:BIO routines:file_ctrl:system lib:crypto/bio/bss_file.c:29=
0:

make: *** [Makefile:1126: .binman_stamp] Error 1

So how is it that the default for nxp,img-crt
IMG1_1_sha256_4096_65537_v3_usr_crt.pem is now looking for
IMG1_1_sha256_4096_65537_v3_usr_key? It fails also if I cp the files
vs ln them.

So what am I missing here?

Best Regards,

Tim

> @@ -131,92 +134,17 @@ build configuration:
>
>  The CSF contains all the commands that the HAB executes during the secur=
e
>  boot. These commands instruct the HAB code on which memory areas of the =
image
> -to authenticate, which keys to install, use and etc.
> -
> -CSF examples are available under doc/imx/habv4/csf_examples/ directory.
> -
> -CSF "Blocks" line for csf_spl.txt can be generated as follows:
> -
> -```
> -spl_block_base=3D$(printf "0x%x" $(( $(sed -n "/CONFIG_SPL_TEXT_BASE=3D/=
 s@.*=3D@@p" .config) - 0x40)) )
> -spl_block_size=3D$(printf "0x%x" $(stat -tc %s u-boot-spl-ddr.bin))
> -sed -i "/Blocks =3D / s@.*@  Blocks =3D $spl_block_base 0x0 $spl_block_s=
ize \"flash.bin\"@" csf_spl.txt
> -```
> -
> -The resulting line looks as follows:
> -```
> -  Blocks =3D 0x7e0fc0 0x0 0x306f0 "flash.bin"
> -```
> -
> -The columns mean:
> -  - CONFIG_SPL_TEXT_BASE - 0x40 -- Start address of signed data, in DRAM
> -  - 0x0 -- Start address of signed data, in "flash.bin"
> -  - 0x306f0 -- Length of signed data, in "flash.bin"
> -  - Filename -- "flash.bin"
> -
> -To generate signature for the SPL part of flash.bin container, use CST:
> -```
> -cst -i csf_spl.tmp -o csf_spl.bin
> -```
> -
> -The newly generated CST blob has to be patched into existing flash.bin
> -container. Conveniently, flash.bin IVT contains physical address of the
> -CSF blob. Remember, the SPL part of flash.bin container is loaded by the
> -BootROM at CONFIG_SPL_TEXT_BASE - 0x40 , so the offset of CSF blob in
> -the fitImage can be calculated and inserted into the flash.bin in the
> -correct location as follows:
> -```
> -# offset =3D IVT_HEADER[6 =3D CSF address] - CONFIG_SPL_TEXT_BASE - 0x40
> -spl_csf_offset=3D$(xxd -s 24 -l 4 -e flash.bin | cut -d " " -f 2 | sed "=
s@^@0x@")
> -spl_bin_offset=3D$(xxd -s 4 -l 4 -e flash.bin | cut -d " " -f 2 | sed "s=
@^@0x@")
> -spl_dd_offset=3D$((${spl_csf_offset} - ${spl_bin_offset} + 0x40))
> -dd if=3Dcsf_spl.bin of=3Dflash.bin bs=3D1 seek=3D${spl_dd_offset} conv=
=3Dnotrunc
> -```
> -
> -CSF "Blocks" line for csf_fit.txt can be generated as follows:
> -```
> -# fitImage
> -fit_block_base=3D$(printf "0x%x" $(sed -n "/CONFIG_SPL_LOAD_FIT_ADDRESS=
=3D/ s@.*=3D@@p" .config) )
> -fit_block_offset=3D$(printf "0x%s" $(fdtget -t x u-boot.dtb /binman/imx-=
boot/uboot offset))
> -fit_block_size=3D$(printf "0x%x" $(( ( ( $(stat -tc %s u-boot.itb) + 0x1=
000 - 0x1 ) & ~(0x1000 - 0x1)) + 0x20 )) )
> -sed -i "/Blocks =3D / s@.*@  Blocks =3D $fit_block_base $fit_block_offse=
t $fit_block_size \"flash.bin\"@" csf_fit.tmp
> -```
> -
> -The fitImage part of flash.bin requires separate IVT. Generate the IVT a=
nd
> -patch it into the correct aligned location of flash.bin as follows:
> -```
> -# IVT
> -ivt_ptr_base=3D$(printf "%08x" ${fit_block_base} | sed "s@\(..\)\(..\)\(=
..\)\(..\)@0x\4\3\2\1@")
> -ivt_block_base=3D$(printf "%08x" $(( ${fit_block_base} + ${fit_block_siz=
e} - 0x20 )) | sed "s@\(..\)\(..\)\(..\)\(..\)@0x\4\3\2\1@")
> -csf_block_base=3D$(printf "%08x" $(( ${fit_block_base} + ${fit_block_siz=
e} )) | sed "s@\(..\)\(..\)\(..\)\(..\)@0x\4\3\2\1@")
> -ivt_block_offset=3D$((${fit_block_offset} + ${fit_block_size} - 0x20))
> -csf_block_offset=3D$((${ivt_block_offset} + 0x20))
> -
> -echo "0xd1002041 ${ivt_block_base} 0x00000000 0x00000000 0x00000000 ${iv=
t_block_base} ${csf_block_base} 0x00000000" | xxd -r -p > ivt.bin
> -dd if=3Divt.bin of=3Dflash.bin bs=3D1 seek=3D${ivt_block_offset} conv=3D=
notrunc
> -```
> -
> -To generate CSF signature for the fitImage part of flash.bin container, =
use CST:
> -```
> -cst -i csf_fit.tmp -o csf_fit.bin
> -```
> -
> -Finally, patch the CSF signature into the fitImage right past the IVT:
> -```
> -dd if=3Dcsf_fit.bin of=3Dflash.bin bs=3D1 seek=3D${csf_block_offset} con=
v=3Dnotrunc
> -```
> -
> -The entire script is available in doc/imx/habv4/csf_examples/mx8m/csf.sh
> -and can be used as follows to modify flash.bin to be signed
> -(adjust paths as needed):
> -```
> -export CST_DIR=3D/usr/src/cst-3.3.1/
> -export CSF_KEY=3D$CST_DIR/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> -export IMG_KEY=3D$CST_DIR/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> -export SRK_TABLE=3D$CST_DIR/crts/SRK_1_2_3_4_table.bin
> -export PATH=3D$CST_DIR/linux64/bin:$PATH
> -/bin/sh doc/imx/habv4/csf_examples/mx8m/csf.sh
> -```
> +to authenticate, which keys to install, use and etc. The CSF is generate=
d
> +using the CST Code Signing Tool based on input configuration file. This =
tool
> +input configuration file is generated using binman, and the tool is invo=
ked
> +from binman as well.
> +
> +The SPL and fitImage sections of the generated image are signed separate=
ly.
> +The signing is activated by wrapping SPL and fitImage sections into nxp-=
imx8mcst
> +etype, which is done automatically in arch/arm/dts/imx8m{m,n,p,q}-u-boot=
.dtsi
> +in case CONFIG_IMX_HAB Kconfig symbol is enabled.
> +
> +Build of flash.bin target then produces a signed flash.bin automatically=
.
>
>  1.4 Closing the device
>  -----------------------
> --
> 2.43.0
>


>  - Kconfig:
>
> @@ -131,92 +134,17 @@ build configuration:
>
>  The CSF contains all the commands that the HAB executes during the secur=
e
>  boot. These commands instruct the HAB code on which memory areas of the =
image
> -to authenticate, which keys to install, use and etc.
> -
> -CSF examples are available under doc/imx/habv4/csf_examples/ directory.
> -
> -CSF "Blocks" line for csf_spl.txt can be generated as follows:
> -
> -```
> -spl_block_base=3D$(printf "0x%x" $(( $(sed -n "/CONFIG_SPL_TEXT_BASE=3D/=
 s@.*=3D@@p" .config) - 0x40)) )
> -spl_block_size=3D$(printf "0x%x" $(stat -tc %s u-boot-spl-ddr.bin))
> -sed -i "/Blocks =3D / s@.*@  Blocks =3D $spl_block_base 0x0 $spl_block_s=
ize \"flash.bin\"@" csf_spl.txt
> -```
> -
> -The resulting line looks as follows:
> -```
> -  Blocks =3D 0x7e0fc0 0x0 0x306f0 "flash.bin"
> -```
> -
> -The columns mean:
> -  - CONFIG_SPL_TEXT_BASE - 0x40 -- Start address of signed data, in DRAM
> -  - 0x0 -- Start address of signed data, in "flash.bin"
> -  - 0x306f0 -- Length of signed data, in "flash.bin"
> -  - Filename -- "flash.bin"
> -
> -To generate signature for the SPL part of flash.bin container, use CST:
> -```
> -cst -i csf_spl.tmp -o csf_spl.bin
> -```
> -
> -The newly generated CST blob has to be patched into existing flash.bin
> -container. Conveniently, flash.bin IVT contains physical address of the
> -CSF blob. Remember, the SPL part of flash.bin container is loaded by the
> -BootROM at CONFIG_SPL_TEXT_BASE - 0x40 , so the offset of CSF blob in
> -the fitImage can be calculated and inserted into the flash.bin in the
> -correct location as follows:
> -```
> -# offset =3D IVT_HEADER[6 =3D CSF address] - CONFIG_SPL_TEXT_BASE - 0x40
> -spl_csf_offset=3D$(xxd -s 24 -l 4 -e flash.bin | cut -d " " -f 2 | sed "=
s@^@0x@")
> -spl_bin_offset=3D$(xxd -s 4 -l 4 -e flash.bin | cut -d " " -f 2 | sed "s=
@^@0x@")
> -spl_dd_offset=3D$((${spl_csf_offset} - ${spl_bin_offset} + 0x40))
> -dd if=3Dcsf_spl.bin of=3Dflash.bin bs=3D1 seek=3D${spl_dd_offset} conv=
=3Dnotrunc
> -```
> -
> -CSF "Blocks" line for csf_fit.txt can be generated as follows:
> -```
> -# fitImage
> -fit_block_base=3D$(printf "0x%x" $(sed -n "/CONFIG_SPL_LOAD_FIT_ADDRESS=
=3D/ s@.*=3D@@p" .config) )
> -fit_block_offset=3D$(printf "0x%s" $(fdtget -t x u-boot.dtb /binman/imx-=
boot/uboot offset))
> -fit_block_size=3D$(printf "0x%x" $(( ( ( $(stat -tc %s u-boot.itb) + 0x1=
000 - 0x1 ) & ~(0x1000 - 0x1)) + 0x20 )) )
> -sed -i "/Blocks =3D / s@.*@  Blocks =3D $fit_block_base $fit_block_offse=
t $fit_block_size \"flash.bin\"@" csf_fit.tmp
> -```
> -
> -The fitImage part of flash.bin requires separate IVT. Generate the IVT a=
nd
> -patch it into the correct aligned location of flash.bin as follows:
> -```
> -# IVT
> -ivt_ptr_base=3D$(printf "%08x" ${fit_block_base} | sed "s@\(..\)\(..\)\(=
..\)\(..\)@0x\4\3\2\1@")
> -ivt_block_base=3D$(printf "%08x" $(( ${fit_block_base} + ${fit_block_siz=
e} - 0x20 )) | sed "s@\(..\)\(..\)\(..\)\(..\)@0x\4\3\2\1@")
> -csf_block_base=3D$(printf "%08x" $(( ${fit_block_base} + ${fit_block_siz=
e} )) | sed "s@\(..\)\(..\)\(..\)\(..\)@0x\4\3\2\1@")
> -ivt_block_offset=3D$((${fit_block_offset} + ${fit_block_size} - 0x20))
> -csf_block_offset=3D$((${ivt_block_offset} + 0x20))
> -
> -echo "0xd1002041 ${ivt_block_base} 0x00000000 0x00000000 0x00000000 ${iv=
t_block_base} ${csf_block_base} 0x00000000" | xxd -r -p > ivt.bin
> -dd if=3Divt.bin of=3Dflash.bin bs=3D1 seek=3D${ivt_block_offset} conv=3D=
notrunc
> -```
> -
> -To generate CSF signature for the fitImage part of flash.bin container, =
use CST:
> -```
> -cst -i csf_fit.tmp -o csf_fit.bin
> -```
> -
> -Finally, patch the CSF signature into the fitImage right past the IVT:
> -```
> -dd if=3Dcsf_fit.bin of=3Dflash.bin bs=3D1 seek=3D${csf_block_offset} con=
v=3Dnotrunc
> -```
> -
> -The entire script is available in doc/imx/habv4/csf_examples/mx8m/csf.sh
> -and can be used as follows to modify flash.bin to be signed
> -(adjust paths as needed):
> -```
> -export CST_DIR=3D/usr/src/cst-3.3.1/
> -export CSF_KEY=3D$CST_DIR/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> -export IMG_KEY=3D$CST_DIR/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> -export SRK_TABLE=3D$CST_DIR/crts/SRK_1_2_3_4_table.bin
> -export PATH=3D$CST_DIR/linux64/bin:$PATH
> -/bin/sh doc/imx/habv4/csf_examples/mx8m/csf.sh
> -```
> +to authenticate, which keys to install, use and etc. The CSF is generate=
d
> +using the CST Code Signing Tool based on input configuration file. This =
tool
> +input configuration file is generated using binman, and the tool is invo=
ked
> +from binman as well.
> +
> +The SPL and fitImage sections of the generated image are signed separate=
ly.
> +The signing is activated by wrapping SPL and fitImage sections into nxp-=
imx8mcst
> +etype, which is done automatically in arch/arm/dts/imx8m{m,n,p,q}-u-boot=
.dtsi
> +in case CONFIG_IMX_HAB Kconfig symbol is enabled.
> +
> +Build of flash.bin target then produces a signed flash.bin automatically=
.
>
>  1.4 Closing the device
>  -----------------------
> --
> 2.43.0
>
