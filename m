Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3827CC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 15:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F4F88826E;
	Thu, 16 May 2024 17:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="G/jG7pJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7EC988263; Thu, 16 May 2024 17:31:39 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE36488258
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 17:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57230faeb81so2437800a12.0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1715873494; x=1716478294; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qlKxZF1dWSN5Oaw7jSA988wVD30QzxDE4eJQNjDWss=;
 b=G/jG7pJWhxuqTse5b23uAPcm/wQAjzDb+MWZ8PrI3va8XcU0QZbT91akJrkb7IMRGF
 kZQCf+joggjbZzid8mJAu4I9F5p3z6/NmcM5Q2q+ScSkfhdNLOyx6srBv4kvDTQ51Bd+
 6571/vPsX4ST0Y8S+WJwZhAFx+hq5AA49UDR9bGmquB/kOjyCUEg+rpDoyuJpXKhsST/
 CWBNFsMQD8Tn0qklaimffaO+1J6dAynmr3CGJtnLGQTlrxtCjtY2N4LHF2s8IzroTt/v
 eRN0VzRrKW5DA/13rntuj7/ouyOaDU5DQhmSWaLY+G4yTtaSeWadzQ6ICFEMUWy0B3Hq
 Clpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715873494; x=1716478294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8qlKxZF1dWSN5Oaw7jSA988wVD30QzxDE4eJQNjDWss=;
 b=quU5Bd5bvfU/xEgmKAc14Acc+E1CLFAUZGSnbdsYe3pXyotTCQUqM9viX+ZWcX5Cr/
 JgIwaVbSAWNIB9TQsOkxOOrOVzGj6vYX5hLlcqAxZ6WlQK8rfVPQ7jkg6j01PYHvUIRY
 eHeo0Rs9XqXatNlIw41aRCTpJWR2J3Wg+Gs3OoR7SOR4dh/3ZSea1x+kAiSDStAvgyLm
 ynh7trgUZ6A6tYQu2qVe4d5WWzPjaV7k0UiBaW/qQfwlftg8RNrAfTNyKinXY2ynM7aM
 qcyT7xoF0cfLAkltSqtEtOdsf2/8GCyONLEeopGw/KoCk/NpQY05jR9huvd2CvjZnmiq
 ZMQQ==
X-Gm-Message-State: AOJu0Yxx4XJcTw13NydGTq3PvvxvI5sfy1/fs2g6WB/BtyZCk6Iy1S8a
 UkEwSapXNg9uZ46LAjAe7wdJDM8ClLEgsi4K4WivUaVfHwC478I9fyx9WeeHF+x6+wKOWLsKFTa
 Sl5u4wjtEDxfKMbLr6+s9ak7tcPHNeleGdbvYCw==
X-Google-Smtp-Source: AGHT+IGcX+oiNBt1nvT642Oj3SegGLlslZNXALBT5XcQciYOT+nBR+xX6ulXV+NOF2b3ksujkCRpzwAprmtyZOvK8Qw=
X-Received: by 2002:a50:9e44:0:b0:572:cfa4:3cc6 with SMTP id
 4fb4d7f45d1cf-5734d597d84mr17025858a12.8.1715873494087; Thu, 16 May 2024
 08:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240503010518.263458-1-marex@denx.de>
 <20240503010518.263458-4-marex@denx.de>
 <CAJ+vNU2=k911jK8rYuaCx7qUN9GyCF6GLjuhLi0y82+yq1hYng@mail.gmail.com>
 <1bb31e71-6fe3-44ce-90dc-6bc7a7fc4d94@denx.de>
 <CAJ+vNU0F1Xa4Tm5P=eC5DgidLSGD8sKfjZ=y9J7Fx4kW01qoFQ@mail.gmail.com>
 <272ca2c6-9a33-4252-8d8f-45d1cccf3f33@denx.de>
In-Reply-To: <272ca2c6-9a33-4252-8d8f-45d1cccf3f33@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 16 May 2024 08:31:22 -0700
Message-ID: <CAJ+vNU1yE-WUywtz9cYV523Uq_-Fjf3WZn5EW4vuX86AGXc0Pg@mail.gmail.com>
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

On Wed, May 15, 2024 at 6:53=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 5/16/24 12:31 AM, Tim Harvey wrote:
>
> Hi,
>
> > (this is a resend... apologies if its a duplicate. I got some strange
> > bounce that mime types were included so I'm resending with the otuput
> > of strace cliped out)
> >
> > strace was a good idea and showed me what was going on.
> >
> > The previous documentation stated to pass your keys via env vars that
> > were full paths to key certificates. Using strace shows me that it
> > will use the directory the KEY certificate is in and try to open up
> > ../keys/*_usr_key.pem if the key path is specified. So apparently the
> > 'File' in the CST config file is used indirectly. Pointing to the
> > usr_key.pem isn't enough either by the way, it seems to need both of
> > these:
> >
> > so if I hack the path to my certs in like this it works:diff --git
> > a/tools/binman/etype/nxp_imx8mcst.py
> > b/tools/binman/etype/nxp_imx8mcst.py
> > index 132127ad4827..b432200960df 100644
> > --- a/tools/binman/etype/nxp_imx8mcst.py
> > +++ b/tools/binman/etype/nxp_imx8mcst.py
> > @@ -67,10 +67,11 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> >
> >       def ReadNode(self):
> >           super().ReadNode()
> > +        self.certpath =3D3D '/usr/src/nxp/cst-3.3.2/crts/';
>
> =3D3D , seems like your email is acting funny today indeed.
>
> >           self.loader_address =3D3D fdt_util.GetInt(self._node, 'nxp,lo=
ader-ad=3D
> > dress')
> >           self.srk_table =3D3D fdt_util.GetString(self._node,
> > 'nxp,srk-table', 'SRK_1_2_3_4_table.bin')
> > -        self.csf_crt =3D3D fdt_util.GetString(self._node, 'nxp,csf-crt=
',
> > 'CSF1_1_sha256_4096_65537_v3_usr_crt.pem')
> > -        self.img_crt =3D3D fdt_util.GetString(self._node, 'nxp,img-crt=
',
> > 'IMG1_1_sha256_4096_65537_v3_usr_crt.pem')
> > +        self.csf_crt =3D3D fdt_util.GetString(self._node, 'nxp,csf-crt=
',
> > self.certpath + '/CSF1_1_sha256_4096_65537_v3_usr_crt.pem')
> > +        self.img_crt =3D3D fdt_util.GetString(self._node, 'nxp,img-crt=
',
> > self.certpath + '/IMG1_1_sha256_4096_65537_v3_usr_crt.pem')
>
> What about this:
>
> diff --git a/tools/binman/etype/nxp_imx8mcst.py
> b/tools/binman/etype/nxp_imx8mcst.py
> index 132127ad482..9ead7488a2d 100644
> --- a/tools/binman/etype/nxp_imx8mcst.py
> +++ b/tools/binman/etype/nxp_imx8mcst.py
> @@ -68,9 +68,9 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>       def ReadNode(self):
>           super().ReadNode()
>           self.loader_address =3D fdt_util.GetInt(self._node,
> 'nxp,loader-address')
> -        self.srk_table =3D fdt_util.GetString(self._node,
> 'nxp,srk-table', 'SRK_1_2_3_4_table.bin')
> -        self.csf_crt =3D fdt_util.GetString(self._node, 'nxp,csf-crt',
> 'CSF1_1_sha256_4096_65537_v3_usr_crt.pem')
> -        self.img_crt =3D fdt_util.GetString(self._node, 'nxp,img-crt',
> 'IMG1_1_sha256_4096_65537_v3_usr_crt.pem')
> +        self.srk_table =3D os.getenv('SRK_TABLE',
> fdt_util.GetString(self._node, 'nxp,srk-table', 'SRK_1_2_3_4_table.bin'))
> +        self.csf_crt =3D os.getenv('CSF_KEY',
> fdt_util.GetString(self._node, 'nxp,csf-crt',
> 'CSF1_1_sha256_4096_65537_v3_usr_crt.pem'))
> +        self.img_crt =3D os.getenv('IMG_KEY',
> fdt_util.GetString(self._node, 'nxp,img-crt',
> 'IMG1_1_sha256_4096_65537_v3_usr_crt.pem'))
>           self.unlock =3D fdt_util.GetBool(self._node, 'nxp,unlock')
>           self.ReadEntries()
>
> Then you can also use the old behavior with keys supplied via env vars.
>
> This might in fact be useful for build systems too.
>

yes, I like that (with an added 'import os')

> >           self.unlock =3D3D fdt_util.GetBool(self._node, 'nxp,unlock')
> >           self.ReadEntries()
> >
> > $ make -j8
> >    BINMAN  .binman_stamp
> >    OFCHK   .config
> >
> > Strace indicatest the following with the above patch:
> > openat(AT_FDCWD,
> > "/usr/src/nxp/cst-3.3.2/crts//IMG1_1_sha256_4096_65537_v3_usr_crt.pem",
> > O_RDONLY)
> > ...
> > openat(AT_FDCWD,
> > "/usr/src/nxp/cst-3.3.2/keys//IMG1_1_sha256_4096_65537_v3_usr_key.pem",
> > O_RDONLY)
> > ^^^ look how it sneakily changes the PATH!
> >
> > And without the above patch using a key file without a path:
> > openat(AT_FDCWD, "IMG1_1_sha256_4096_65537_v3_usr_crt.pem", O_RDONLY)
> > ...
> > openat(AT_FDCWD, "IMG1_1_sha256_4096_65537_v3_usr_key.pem", O_RDONLY)
> > ENOENT (No such file or directory)
> > ^^^ fails
> >
> > Simply copying both usr_crt.pem and usr_key.pem to the build directory
> > still fails:
> > binman: Error 1 running 'cst -i
> > ./nxp.csf-config-txt.section.nxp-imx8mcst@0 -o
> > ./nxp.csf-output-blob.section.nxp-imx8mcst@0': Error:
> > Cannot open key file IMG1_1_sha256_4096_65537_v3_usr_key.pem
> > 0:error:06065064:digital envelope routines:EVP_DecryptFinal_ex:bad
> > decrypt:crypto/evp/evp_enc.c:612:
> > 0:error:23077074:PKCS12 routines:PKCS12_pbe_crypt:pkcs12 cipherfinal
> > error:crypto/pkcs12/p12_decr.c:62:
> > 0:error:2306A075:PKCS12 routines:PKCS12_item_decrypt_d2i:pkcs12 pbe
> > crypt error:crypto/pkcs12/p12_decr.c:93:
> > 0:error:0907B00D:PEM routines:PEM_read_bio_PrivateKey:ASN1
> > lib:crypto/pem/pem_pkey.c:88:
> >
> > Do you not run into this and if not is it because you have put full
> > paths in the dtsi overriding the defaults I'm using?
>
> I just do '$ cp -Lv /CST/{keys,crts}/* .' to copy the keys and certs
> into the build directory for testing.
>
> > Maybe this has
> > something to do with how my keys were generated or the version of cst
> > I'm using or maybe we just need to also add a directory which can be
> > symlinked to or something.
>
> I use the imx-code-signing-tool 3.4.0+dfsg-2+b1 from debian .
>
> > Another thing that I'm seeing is that this leaves a bunch of turd files=
 around:
> >          cfg-out.section.nxp-imx8mcst@0.nxp-imx8mimage
> >          cfg-out.section.nxp-imx8mimage
> >          input.section.nxp-imx8mcst@0
> >          input.section.nxp-imx8mcst@0.nxp-imx8mimage
> >          input.section.nxp-imx8mimage
> >          nxp.csf-config-txt.section.nxp-imx8mcst@0
> >          nxp.cst-input-data.section.nxp-imx8mcst@0
> >          nxp.imx8mimage.cfg.section.nxp-imx8mcst@0.nxp-imx8mimage
> >          nxp.imx8mimage.cfg.section.nxp-imx8mimage
> >
> > These intermediate files should be cleaned up after signing is complete=
.
>
> Those are intermediate build artifacts, sort of like .o files or such,
> so they should be OK to keep around, right ?

then they should be added to .gitignore and removed with a 'make
clean'. Right now they clutter up 'git status'. Maybe they can be put
in the build dir which is in .gitignore (but strangely not cleaned).

With these two things and an update to the documentation showing the
methods of specifying the keys I think everything else in the series
looks good.

Best Regards,

Tim
