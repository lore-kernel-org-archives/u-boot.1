Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B263AC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 21:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D4D883AD;
	Thu, 16 May 2024 23:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Q0YHyyMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D92488307; Thu, 16 May 2024 23:40:20 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FA3E883AD
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 23:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a59a352bbd9so525689466b.1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 14:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1715895617; x=1716500417; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBp3YIZLC8bCJ5uDC2j1YmaZ//Z7+WkJZV0sPB8EUHI=;
 b=Q0YHyyMqOoI5By590dgS2cM3w/bTne+OjgCDYwUdGMz522HDfJlBijm8fOWi6Tjiny
 54mMgw+Yp/XrMzGCSBKqUmzGHzUVtxJb+DLLacbhovPTr1jPnixMsVg5r72u60EiTTf9
 8IKgacHllXAsIYqTdpwwZeVjWb4TwD5/Wrc9fxhRL7ei+xedHq4zNmdyZLjRx81rf0zp
 TE38NrZ/rkvNyIHXWIpEQabgiS27AEPeOG1yvjklgf/hlHXel4hSjhHVSZdgCFjxAm4V
 R08N4wvTHIyox1B6XqrvJVPujLo30jXaqwogR4jnEZwkJbqtJqNpKmVnnFhutla44pEk
 K7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715895617; x=1716500417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBp3YIZLC8bCJ5uDC2j1YmaZ//Z7+WkJZV0sPB8EUHI=;
 b=JKhO83VOrx4mq3SsYbHGYaOROF+iJUg4yUfQC+5PdAi7vFpPaJHlvsGFQnKszTi95+
 g8zt2y2RXJc4VY2P7IOBUp1rVwmfFfjd6f+sQnSzyKlhfx1iM3mgMiID3pxL2LFRNiEo
 SrGqQre0vWIQXrQ8NxDnGFEnv2lejmSGfKJYlJyRKi1oYR5aZfyUL/hHVMjzZY63X336
 ZBWyPc1BK0FVFsG8Y9Y2x5A/eEMZ6qouQaDP3gEI6Qc822GS9tbsjlw8tEC8b10LS31Y
 3dul5DPEdtML48ncIkB3jsweiUbbXXY2p7FkdblKipEGSJv8OXSb7cKWJVoEl7UBC0ES
 osTg==
X-Gm-Message-State: AOJu0YxqASYg2KIYZepgk8CFmp5V8aGj+V7j4P8LU8Fs6sQp59IDBkXn
 nknjNXHTf6r2Mj94bJ2k9aiPEGzwlWUeKdSkhV3RACbQVA/mpq26Brq42NlbBmFubLPGmtx58nG
 GXnEknIuotUSV4HE8Sg1jtPSKn7f7R5w1nbM9Xw==
X-Google-Smtp-Source: AGHT+IGbqeOgYYApEYIv0RQwt6xgsSkps7griKaabVN1nSUPNFU7op3vAQYQmmZorVZPBSWEb1Xaz+VpTrrWukmbRtU=
X-Received: by 2002:a17:906:6a22:b0:a5a:5bc8:9fcf with SMTP id
 a640c23a62f3a-a5a5bc8a0c9mr1419564366b.36.1715895616920; Thu, 16 May 2024
 14:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240516213036.89016-1-marex@denx.de>
 <20240516213036.89016-4-marex@denx.de>
In-Reply-To: <20240516213036.89016-4-marex@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 16 May 2024 14:40:05 -0700
Message-ID: <CAJ+vNU1Sb60gX4RoHwO=o2kf0c9bW85W2i1VwJg3Oa1hFmxADw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] imx: hab: Use nxp_imx8mcst etype for i.MX8M
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

On Thu, May 16, 2024 at 2:31=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
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
> V3: Document configuration of imx8mcst
> ---
>  doc/imx/habv4/csf_examples/mx8m/csf.sh        |  92 --------------
>  doc/imx/habv4/csf_examples/mx8m/csf_fit.txt   |  30 -----
>  doc/imx/habv4/csf_examples/mx8m/csf_spl.txt   |  33 -----
>  doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 116 +++++-------------
>  4 files changed, 30 insertions(+), 241 deletions(-)
>  delete mode 100644 doc/imx/habv4/csf_examples/mx8m/csf.sh
>  delete mode 100644 doc/imx/habv4/csf_examples/mx8m/csf_fit.txt
>  delete mode 100644 doc/imx/habv4/csf_examples/mx8m/csf_spl.txt
>
> diff --git a/doc/imx/habv4/csf_examples/mx8m/csf.sh b/doc/imx/habv4/csf_e=
xamples/mx8m/csf.sh
> deleted file mode 100644
> index cd3b2614a2f..00000000000
> --- a/doc/imx/habv4/csf_examples/mx8m/csf.sh
> +++ /dev/null
> @@ -1,92 +0,0 @@
> -#!/bin/sh
> -
> -# 0) Generate keys
> -#
> -# WARNING: ECDSA keys are only supported by HAB 4.5 and newer (i.e. i.MX=
8M Plus)
> -#
> -# cd /path/to/cst-3.3.1/keys/
> -#    ./hab4_pki_tree.sh -existing-ca n -use-ecc n -kl 4096 -duration 10 =
-num-srk 4 -srk-ca y
> -# cd /path/to/cst-3.3.1/crts/
> -#   ../linux64/bin/srktool -h 4 -t SRK_1_2_3_4_table.bin -e SRK_1_2_3_4_=
fuse.bin -d sha256 -c ./SRK1_sha256_4096_65537_v3_ca_crt.pem,./SRK2_sha256_=
4096_65537_v3_ca_crt.pem,./SRK3_sha256_4096_65537_v3_ca_crt.pem,./SRK4_sha2=
56_4096_65537_v3_ca_crt.pem -f 1
> -
> -# 1) Build U-Boot (e.g. for i.MX8MM)
> -#
> -# cp -Lv /path/to/arm-trusted-firmware/build/imx8mm/release/bl31.bin .
> -# cp -Lv /path/to/firmware-imx-8.14/firmware/ddr/synopsys/ddr3* .
> -# make -j imx8mm_board_defconfig
> -# make -j`nproc` flash.bin
> -
> -# 2) Sign SPL and DRAM blobs
> -
> -cp doc/imx/habv4/csf_examples/mx8m/csf_spl.txt csf_spl.tmp
> -cp doc/imx/habv4/csf_examples/mx8m/csf_fit.txt csf_fit.tmp
> -
> -# update File Paths from env vars
> -if ! [ -r $CSF_KEY ]; then
> -       echo "Error: \$CSF_KEY not found"
> -       exit 1
> -fi
> -if ! [ -r $IMG_KEY ]; then
> -       echo "Error: \$IMG_KEY not found"
> -       exit 1
> -fi
> -if ! [ -r $SRK_TABLE ]; then
> -       echo "Error: \$SRK_TABLE not found"
> -       exit 1
> -fi
> -sed -i "s:\$CSF_KEY:$CSF_KEY:" csf_spl.tmp
> -sed -i "s:\$IMG_KEY:$IMG_KEY:" csf_spl.tmp
> -sed -i "s:\$SRK_TABLE:$SRK_TABLE:" csf_spl.tmp
> -sed -i "s:\$CSF_KEY:$CSF_KEY:" csf_fit.tmp
> -sed -i "s:\$IMG_KEY:$IMG_KEY:" csf_fit.tmp
> -sed -i "s:\$SRK_TABLE:$SRK_TABLE:" csf_fit.tmp
> -
> -# update SPL Blocks
> -spl_block_base=3D$(printf "0x%x" $(( $(sed -n "/CONFIG_SPL_TEXT_BASE=3D/=
 s@.*=3D@@p" .config) - 0x40)) )
> -spl_block_size=3D$(printf "0x%x" $(stat -tc %s u-boot-spl-ddr.bin))
> -sed -i "/Blocks =3D / s@.*@  Blocks =3D $spl_block_base 0x0 $spl_block_s=
ize \"flash.bin\"@" csf_spl.tmp
> -
> -# Generate CSF blob
> -cst -i csf_spl.tmp -o csf_spl.bin
> -
> -# Patch CSF blob into flash.bin
> -spl_csf_offset=3D$(xxd -s 24 -l 4 -e flash.bin | cut -d " " -f 2 | sed "=
s@^@0x@")
> -spl_bin_offset=3D$(xxd -s 4 -l 4 -e flash.bin | cut -d " " -f 2 | sed "s=
@^@0x@")
> -spl_dd_offset=3D$((${spl_csf_offset} - ${spl_bin_offset} + 0x40))
> -dd if=3Dcsf_spl.bin of=3Dflash.bin bs=3D1 seek=3D${spl_dd_offset} conv=
=3Dnotrunc
> -
> -# 3) Sign u-boot.itb
> -
> -# fitImage
> -fit_block_base=3D$(printf "0x%x" $(sed -n "/CONFIG_SPL_LOAD_FIT_ADDRESS=
=3D/ s@.*=3D@@p" .config) )
> -fit_block_offset=3D$(printf "0x%s" $(fdtget -t x u-boot.dtb /binman/imx-=
boot/uboot offset))
> -fit_block_size=3D$(printf "0x%x" $(( ( ( $(stat -tc %s u-boot.itb) + 0x1=
000 - 0x1 ) & ~(0x1000 - 0x1)) + 0x20 )) )
> -sed -i "/Blocks =3D / s@.*@  Blocks =3D $fit_block_base $fit_block_offse=
t $fit_block_size \"flash.bin\"@" csf_fit.tmp
> -
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
> -
> -# Generate CSF blob
> -cst -i csf_fit.tmp -o csf_fit.bin
> -
> -# When loading flash.bin via USB, we must ensure that the file being
> -# served is as large as the target expects (see
> -# board_spl_fit_size_align()), otherwise the target will hang in
> -# rom_api_download_image() waiting for the remaining bytes.
> -#
> -# Note that in order for dd to actually extend the file, one must not
> -# pass conv=3Dnotrunc here. With a non-zero seek=3D argument, dd is
> -# documented to preserve the contents of the file seeked past; in
> -# particular, dd does not open the file with O_TRUNC.
> -CSF_SIZE=3D$(sed -n "/CONFIG_CSF_SIZE=3D/ s@.*=3D@@p" .config)
> -dd if=3D/dev/null of=3Dcsf_fit.bin bs=3D1 seek=3D$((CSF_SIZE - 0x20)) co=
unt=3D0
> -
> -# Patch CSF blob into flash.bin
> -dd if=3Dcsf_fit.bin of=3Dflash.bin bs=3D1 seek=3D${csf_block_offset} con=
v=3Dnotrunc
> diff --git a/doc/imx/habv4/csf_examples/mx8m/csf_fit.txt b/doc/imx/habv4/=
csf_examples/mx8m/csf_fit.txt
> deleted file mode 100644
> index 97f3eea573b..00000000000
> --- a/doc/imx/habv4/csf_examples/mx8m/csf_fit.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -[Header]
> -  Version =3D 4.3
> -  Hash Algorithm =3D sha256
> -  Engine =3D CAAM
> -  Engine Configuration =3D 0
> -  Certificate Format =3D X509
> -  Signature Format =3D CMS
> -
> -[Install SRK]
> -  # SRK_TABLE is full path to SRK_1_2_3_4_table.bin
> -  File =3D "$SRK_TABLE"
> -  Source index =3D 0
> -
> -[Install CSFK]
> -  # CSF_KEY is full path to CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> -  File =3D "$CSF_KEY"
> -
> -[Authenticate CSF]
> -
> -[Install Key]
> -  Verification index =3D 0
> -  Target Index =3D 2
> -  # IMG_KEY is full path to IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> -  File =3D "$IMG_KEY"
> -
> -[Authenticate Data]
> -  Verification index =3D 2
> -  # FIXME:
> -  # Line 1 -- fitImage
> -  Blocks =3D CONFIG_SPL_LOAD_FIT_ADDRESS 0x57c00 0xffff "flash.bin"
> diff --git a/doc/imx/habv4/csf_examples/mx8m/csf_spl.txt b/doc/imx/habv4/=
csf_examples/mx8m/csf_spl.txt
> deleted file mode 100644
> index 88fa420a5fa..00000000000
> --- a/doc/imx/habv4/csf_examples/mx8m/csf_spl.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -[Header]
> -  Version =3D 4.3
> -  Hash Algorithm =3D sha256
> -  Engine =3D CAAM
> -  Engine Configuration =3D 0
> -  Certificate Format =3D X509
> -  Signature Format =3D CMS
> -
> -[Install SRK]
> -  # SRK_TABLE is full path to SRK_1_2_3_4_table.bin
> -  File =3D "$SRK_TABLE"
> -  Source index =3D 0
> -
> -[Install CSFK]
> -  # CSF_KEY is full path to CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> -  File =3D "$CSF_KEY"
> -
> -[Authenticate CSF]
> -
> -[Unlock]
> -  Engine =3D CAAM
> -  Features =3D MID
> -
> -[Install Key]
> -  Verification index =3D 0
> -  Target Index =3D 2
> -  # IMG_KEY is full path to IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> -  File =3D "$IMG_KEY"
> -
> -[Authenticate Data]
> -  Verification index =3D 2
> -  # FIXME: Adjust start (first column) and size (third column) here
> -  Blocks =3D 0x7e0fc0 0x0 0x306f0 "flash.bin"
> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/habv=
4/guides/mx8m_spl_secure_boot.txt
> index e16e5410bd9..1eb1fb0aa61 100644
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
>  - Kconfig:
>
> @@ -131,92 +134,33 @@ build configuration:
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

Hi Marek,

I thought you were going to leave the above env setting examples in
the documentation.

I suggest showing how to specify using env (by just leaving the above
in) as well as by copying them directly to the build directory if
wanted.. otherwise the documentation is lacking.

Best Regards,

Tim

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
> +The nxp-imx8mcst etype is configurable using either DT properties or env=
ironment
> +variables. The following DT properties and environment variables are sup=
ported.
> +Note that environment variables override DT properties.
> +
> ++--------------------+-----------+--------------------------------------=
----------------------------+
> +| DT property        | Variable  | Description                          =
                            |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
+
> +| nxp,loader-address |           | SPL base address                     =
                            |
> ++--------------------+-----------+--------------------------------------=
----------------------------+
> +| nxp,srk-table      | SRK_TABLE | full path to SRK_1_2_3_4_table.bin   =
                            |
> ++--------------------+-----------+--------------------------------------=
----------------------------+
> +| nxp,csf-crt        | CSF_KEY   | full path to the CSF Key CSF1_1_sha25=
6_4096_65537_v3_usr_crt.pem |
> ++--------------------+-----------+--------------------------------------=
----------------------------+
> +| nxp,img-crt        | IMG_KEY   | full path to the IMG Key IMG1_1_sha25=
6_4096_65537_v3_usr_crt.pem |
> ++--------------------+-----------+--------------------------------------=
----------------------------+
> +
> +Build of flash.bin target then produces a signed flash.bin automatically=
.
>
>  1.4 Closing the device
>  -----------------------
> --
> 2.43.0
>
