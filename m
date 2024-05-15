Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B91DC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 22:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75B5888315;
	Thu, 16 May 2024 00:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="kgFq9snW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B450888315; Thu, 16 May 2024 00:31:45 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E23F488286
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 00:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52327368e59so107732e87.1
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 15:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1715812302; x=1716417102; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+nLIYNWyhMyr2CprzGdqjwju3CJ6ewHQMoRGQiqe4E=;
 b=kgFq9snWmqUdIIHTJ0iPD4CK0NUnp+tXM2vywTs+XXmurPy9uVlx3PJhvABJ44AV1r
 qbECwgdmxqYeDjr8Dk9YFTS0IJCh3Kl9IE98GhMKeD3+SPmYTb3tP8sCXFH4gQ6OcI7k
 /jzPLNvkH3Hc2WwCxbjYKA3eZP7YkJqqzHzMJwaUOxSFHV1J7IKhHD9KMevLMZbnVlKM
 aV3703hLVhE5WZj4nYLBMJ+yEtgKXb3ZBqcpbxhGTD8ir/33bxhHX8m0rAvelrHlL/AD
 YBDo6gjHRXM7IXJM+eFgn+k5Ju7/X9gD71dFSNuwDF2hvtMShUeKHTEKHQqKocC/UJqb
 JAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715812302; x=1716417102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+nLIYNWyhMyr2CprzGdqjwju3CJ6ewHQMoRGQiqe4E=;
 b=cl+gddQZZ/FtSXZTJyoimKrlgHCQ4ktcKDJw2Aqc9yNIld4cwPtvFN0oTy1YmqKxOQ
 aaroLyrYOsTplxCpJSWDYouuy7FxHqQ6oXBHlTEVPmZjMaQ7AHNYcHHKWe0a0Gzm1YTa
 Ek+uwBLOD+PJqY1xrBxDAIMBU2HcCCwk3ruJMIcJ4T+9yMGqtmA2UpAjX6ImUfH243/Q
 hwv6aBG0g2VpS/0I+rXjwjdqmNucaxwpFgsve0b6yqKSHmjBxEQCb43lg8GzO4vLCEH4
 LkF8UghJe2gUhhDjJDayJNqtplhoupsEt9P0mliHU/gi7atnd599lzy43EpjnNbe/3bb
 Nvcw==
X-Gm-Message-State: AOJu0YxcELhi/zYtxtBVw9YuhUkeo8Tdsg41T44mvOHsbWL4bQopcoXT
 tsoyxiQ+34NmDLtzrCydSG2VECv53ytlQdmvl86Q3x2jR+r7+BO02NuHgvmD9Vaipd/bD3wC26G
 3eOh4EfG3fHiRA8gUlJTlO5whK2Obai5tPP6vNA==
X-Google-Smtp-Source: AGHT+IE/qDzcxeAAAftZCAYhVmG7Z3ctXOWxpnFsb/yWPCuhW/7hVR0dU+BV9IhKjOm+LqS3miDsZkkGGRpn4iTjebA=
X-Received: by 2002:a05:6512:3ca4:b0:51d:67a0:2433 with SMTP id
 2adb3069b0e04-52210074979mr13656129e87.46.1715812302068; Wed, 15 May 2024
 15:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240503010518.263458-1-marex@denx.de>
 <20240503010518.263458-4-marex@denx.de>
 <CAJ+vNU2=k911jK8rYuaCx7qUN9GyCF6GLjuhLi0y82+yq1hYng@mail.gmail.com>
 <1bb31e71-6fe3-44ce-90dc-6bc7a7fc4d94@denx.de>
In-Reply-To: <1bb31e71-6fe3-44ce-90dc-6bc7a7fc4d94@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 15 May 2024 15:31:30 -0700
Message-ID: <CAJ+vNU0F1Xa4Tm5P=eC5DgidLSGD8sKfjZ=y9J7Fx4kW01qoFQ@mail.gmail.com>
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

On Tue, May 14, 2024 at 1:58=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 5/14/24 8:34 PM, Tim Harvey wrote:
>
> Hi,
>
> >> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/h=
abv4/guides/mx8m_spl_secure_boot.txt
> >> index e16e5410bd9..ce1de659d8c 100644
> >> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> >> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> >> @@ -121,6 +121,9 @@ build configuration:
> >>   - Defconfig:
> >>
> >>     CONFIG_IMX_HAB=3Dy
> >> +  CONFIG_FSL_CAAM=3Dy
> >> +  CONFIG_ARCH_MISC_INIT=3Dy
> >> +  CONFIG_SPL_CRYPTO=3Dy
> >>
> >
> > Hi Marek,
> >
> > Thanks for wrapping the dts bits with a config item.
> >
> > Is there any other reason to build with CONFIG_IMX_HAB than to use a
> > signed image? I see that there are several ARCH_MX6 and ARCH_MX7
> > configs that have this enabled (not ARCH_IMX8M so this certainly
> > doesn't break anything) and I'm not sure what the value of that is.
>
> I think those few either enabled in preemptively in anticipation of
> possibly using HAB, or are wrong. I suspect it should be disabled for
> those, as it only adds to the board boot time and I am not even sure if
> those machines would boot correctly.
>
> Francesco, maybe you do have MX7 Colibri ?
>
> > I notice that FSL_CAAM is selected when you select IMX_HAB... is there
> > any reason why ARCH_MISC_INIT and SPL_CRYPTO should not be selected by
> > IMX_HAB as well (future patch perhaps)?
>
> ARCH_MISC_INIT should be selected by SoC Kconfig on MX7 and maybe CAAM
> on MX8M I think . As for SPL_CRYPTO, that should be selected by
> SPL_FSL_CAAM I think.
>
> >>   - Kconfig:
> >>
> >
> > We definitely need to describe the additional requirements here. Maybe
> > something like:
> >
> > - Tools:
> > cst - NXP code-signing-tool (eg apt install imx-code-signing-tool)
> >
> > - Files: (created with NXP IMX_CST_TOOL)
> > SRK_1_2_3_4_table.bin (specified by nxp,srk-table node): fuse table
> > CSF1_1_sha256_4096_65537_v3_usr_crt.pem (specified by nxp,csf-crt node)=
: CSF_KEY
> > IMG1_1_sha256_4096_65537_v3_usr_crt.pem (specified by nxp,img-crt node)=
: IMG_KEY
> >
> > The following works fine for me on v2024.01
> > export CST_DIR=3D/usr/src/nxp/cst-3.3.2/
> > export CSF_KEY=3D$CST_DIR/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> > export IMG_KEY=3D$CST_DIR/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> > export SRK_TABLE=3D$CST_DIR/crts/SRK_1_2_3_4_table.bin
> > export PATH=3D$CST_DIR/linux64/bin:$PATH
> > make && /bin/sh doc/imx/habv4/csf_examples/mx8m/csf.sh
> >
> > But with the above defines and your series this fails:
> > ln -sf $SRK_TABLE SRK_1_2_3_4_table.bin
> > ln -sf $CSF_KEY CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> > ln -sf $IMG_KEY IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> > make
> >    BINMAN  .binman_stamp
> > Wrote map file './image.map' to show errors
> > binman: Error 1 running 'cst -i
> > ./nxp.csf-config-txt.section.nxp-imx8mcst@0 -o
> > ./nxp.csf-output-blob.section.nxp-imx8mcst@0': Error:
> > Cannot open key file IMG1_1_sha256_4096_65537_v3_usr_key.pem
> > 0:error:02001002:system library:fopen:No such file or
> > directory:crypto/bio/bss_file.c:288:fopen('IMG1_1_sha256_4096_65537_v3_=
usr_key.
> > pem','r')
> > 0:error:20074002:BIO routines:file_ctrl:system lib:crypto/bio/bss_file.=
c:290:
> >
> > make: *** [Makefile:1126: .binman_stamp] Error 1
> >
> > So how is it that the default for nxp,img-crt
> > IMG1_1_sha256_4096_65537_v3_usr_crt.pem is now looking for
> > IMG1_1_sha256_4096_65537_v3_usr_key? It fails also if I cp the files
> > vs ln them.
> >
> > So what am I missing here?
>
> I think CST is using both the certificate and the key files. Try and run
> strace on the CST to test that:
>
> $ strace cst -i ./nxp.csf-config-txt.section.nxp-imx8mcst@0 -o
> ./nxp.csf-output-blob.section.nxp-imx8mcst@0

Hi Marek,

(this is a resend... apologies if its a duplicate. I got some strange
bounce that mime types were included so I'm resending with the otuput
of strace cliped out)

strace was a good idea and showed me what was going on.

The previous documentation stated to pass your keys via env vars that
were full paths to key certificates. Using strace shows me that it
will use the directory the KEY certificate is in and try to open up
../keys/*_usr_key.pem if the key path is specified. So apparently the
'File' in the CST config file is used indirectly. Pointing to the
usr_key.pem isn't enough either by the way, it seems to need both of
these:

so if I hack the path to my certs in like this it works:diff --git
a/tools/binman/etype/nxp_imx8mcst.py
b/tools/binman/etype/nxp_imx8mcst.py
index 132127ad4827..b432200960df 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -67,10 +67,11 @@ class Entry_nxp_imx8mcst(Entry_mkimage):

     def ReadNode(self):
         super().ReadNode()
+        self.certpath =3D3D '/usr/src/nxp/cst-3.3.2/crts/';
         self.loader_address =3D3D fdt_util.GetInt(self._node, 'nxp,loader-=
ad=3D
dress')
         self.srk_table =3D3D fdt_util.GetString(self._node,
'nxp,srk-table', 'SRK_1_2_3_4_table.bin')
-        self.csf_crt =3D3D fdt_util.GetString(self._node, 'nxp,csf-crt',
'CSF1_1_sha256_4096_65537_v3_usr_crt.pem')
-        self.img_crt =3D3D fdt_util.GetString(self._node, 'nxp,img-crt',
'IMG1_1_sha256_4096_65537_v3_usr_crt.pem')
+        self.csf_crt =3D3D fdt_util.GetString(self._node, 'nxp,csf-crt',
self.certpath + '/CSF1_1_sha256_4096_65537_v3_usr_crt.pem')
+        self.img_crt =3D3D fdt_util.GetString(self._node, 'nxp,img-crt',
self.certpath + '/IMG1_1_sha256_4096_65537_v3_usr_crt.pem')
         self.unlock =3D3D fdt_util.GetBool(self._node, 'nxp,unlock')
         self.ReadEntries()

$ make -j8
  BINMAN  .binman_stamp
  OFCHK   .config

Strace indicatest the following with the above patch:
openat(AT_FDCWD,
"/usr/src/nxp/cst-3.3.2/crts//IMG1_1_sha256_4096_65537_v3_usr_crt.pem",
O_RDONLY)
...
openat(AT_FDCWD,
"/usr/src/nxp/cst-3.3.2/keys//IMG1_1_sha256_4096_65537_v3_usr_key.pem",
O_RDONLY)
^^^ look how it sneakily changes the PATH!

And without the above patch using a key file without a path:
openat(AT_FDCWD, "IMG1_1_sha256_4096_65537_v3_usr_crt.pem", O_RDONLY)
...
openat(AT_FDCWD, "IMG1_1_sha256_4096_65537_v3_usr_key.pem", O_RDONLY)
ENOENT (No such file or directory)
^^^ fails

Simply copying both usr_crt.pem and usr_key.pem to the build directory
still fails:
binman: Error 1 running 'cst -i
./nxp.csf-config-txt.section.nxp-imx8mcst@0 -o
./nxp.csf-output-blob.section.nxp-imx8mcst@0': Error:
Cannot open key file IMG1_1_sha256_4096_65537_v3_usr_key.pem
0:error:06065064:digital envelope routines:EVP_DecryptFinal_ex:bad
decrypt:crypto/evp/evp_enc.c:612:
0:error:23077074:PKCS12 routines:PKCS12_pbe_crypt:pkcs12 cipherfinal
error:crypto/pkcs12/p12_decr.c:62:
0:error:2306A075:PKCS12 routines:PKCS12_item_decrypt_d2i:pkcs12 pbe
crypt error:crypto/pkcs12/p12_decr.c:93:
0:error:0907B00D:PEM routines:PEM_read_bio_PrivateKey:ASN1
lib:crypto/pem/pem_pkey.c:88:

Do you not run into this and if not is it because you have put full
paths in the dtsi overriding the defaults I'm using? Maybe this has
something to do with how my keys were generated or the version of cst
I'm using or maybe we just need to also add a directory which can be
symlinked to or something.

Another thing that I'm seeing is that this leaves a bunch of turd files aro=
und:
        cfg-out.section.nxp-imx8mcst@0.nxp-imx8mimage
        cfg-out.section.nxp-imx8mimage
        input.section.nxp-imx8mcst@0
        input.section.nxp-imx8mcst@0.nxp-imx8mimage
        input.section.nxp-imx8mimage
        nxp.csf-config-txt.section.nxp-imx8mcst@0
        nxp.cst-input-data.section.nxp-imx8mcst@0
        nxp.imx8mimage.cfg.section.nxp-imx8mcst@0.nxp-imx8mimage
        nxp.imx8mimage.cfg.section.nxp-imx8mimage

These intermediate files should be cleaned up after signing is complete.

Best Regards,

Tim
