Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA71C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 22:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CDA88832B;
	Thu, 16 May 2024 00:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="GQpk+Zbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B1E28833A; Thu, 16 May 2024 00:47:05 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A99B588329
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 00:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51f72a29f13so125930e87.3
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 15:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1715813222; x=1716418022; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ioxOLAUZoFP2hacQhwyqwvNv7xC4i4JIrPo4EX3CBuI=;
 b=GQpk+ZbxkSzbFwNXAudvYBo+WlNOadA41pOtVBBZ/8aXFPokouegKUsn6N4H3ZeGAs
 TdCusOaZ/t7TBtYmdIdrmMisTLIw4PEyekfgECxop3GbQLZ0LY2E13hAxAKKp43GV0O3
 4Gr5aCAbOeDkNby9SuU5ae9aXkXDbZe0t0j3U0xc9wNCFeG6xs4GWsVcQXEPGxF6nEhE
 HmP3CMqsd5vjvHiF6F9ugyVmQDZJmGfee1jd9wl2/OMfgYRLB7awS9/+uSV/uyxFkPwz
 /e3e9zXi/t5ThZvjCvFMWn0jZe1CgE6HY6fi4lAfVd/Vxhc3AIao6X+1VvPpVS5T6kon
 iOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715813222; x=1716418022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ioxOLAUZoFP2hacQhwyqwvNv7xC4i4JIrPo4EX3CBuI=;
 b=o6q4OuZG04fapffs2oBFjWF+uda+GbQBNXI26d3d+pTLQeGfsqVdXiQNRxSAuWOWMN
 ZGCvdmLX4lsxomTHk+5j7eDCxwJIysJ5woVdeU40wjf/Zt5xQfVc07NB0nBa0nznIey+
 Ba1kfxiItcrKGiQmbRMmDBMSpPkzt/Kpp1fRPDJcZIGpA9nKbv+NSNh6Znp0LoAE8jki
 gbt6P6iNmf+B8gmQR50vTvixj6NOW/KfpPJcmqqP3aW4v5XZgwj2oPEwd+i06P5pJljQ
 nUzl7QIhWLXq5CKvFRXnTKxdL1Q+ui9i4666MrTRwyTEpNFL3aG+sl2HGSlf/bPRukLv
 E7+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKbdPM2s3FmnFDn6nGtRuVZc6PdHESB98GYiUGJtD64gz0qLU/aVoazJU11CMVFoXDGS1giEEzEyacGJuOhNauVQIVKw==
X-Gm-Message-State: AOJu0YyV08Kut9S4t3NFiNxR0HFfLaCbJT/dlb3/j+vBxhbxlzanJv9D
 aAqUjNA1aD2iiFRHuVnqzrsjR2ul8sXti1JCtIfFP9RWCZcPprWFUhnphNjWIFZw1wA5LXQs+3P
 rZdDntksJcr7LV+Ovc5/BkEPdECuTW5lKzb1Oaw==
X-Google-Smtp-Source: AGHT+IFuDdfuE++NroOzuJy7nzGyY2+1ysg5dG6MNdxRcXBTNmkTsomQm/xjksYIwPbSl7tR0PMPXHC/YUUY8ZHshvE=
X-Received: by 2002:ac2:5dc1:0:b0:522:33cd:64bd with SMTP id
 2adb3069b0e04-52233cd6563mr10372496e87.27.1715813221852; Wed, 15 May 2024
 15:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240503010518.263458-1-marex@denx.de>
 <20240507130650.713801-1-ch@denx.de>
 <28173ffa-209b-498f-a2c3-99ec2f898e7c@denx.de>
 <e98dc839-f58f-4463-9358-4d3ba267d558@denx.de>
 <7d834245-9ac2-45cf-b5bb-045560863bcb@denx.de>
 <CAJ+vNU2MCQNDO1hehq3CvWAFUqaSR=0eW6xRrE8Dzcna79-doA@mail.gmail.com>
In-Reply-To: <CAJ+vNU2MCQNDO1hehq3CvWAFUqaSR=0eW6xRrE8Dzcna79-doA@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 15 May 2024 15:46:50 -0700
Message-ID: <CAJ+vNU1NJOXELwyUJ_QW4m-QTdJZwSA9R8v3-1wzJK9K8PxEZw@mail.gmail.com>
Subject: Re: [PATCH] imx: hab: add documentation about the required keys/certs
To: Marek Vasut <marex@denx.de>, Claudius Heine <ch@denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@denx.de>,
 open list <u-boot@lists.denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
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

On Tue, May 14, 2024 at 11:50=E2=80=AFAM Tim Harvey <tharvey@gateworks.com>=
 wrote:
>
> On Sun, May 12, 2024 at 10:08=E2=80=AFPM Marek Vasut <marex@denx.de> wrot=
e:
> >
> > On 5/8/24 9:23 AM, Claudius Heine wrote:
> > > Hi Marek,
> >
> > Hi,
> >
> > > On 2024-05-07 3:28 pm, Marek Vasut wrote:
> > >> On 5/7/24 3:06 PM, Claudius Heine wrote:
> > >>> For CST to find the certificates and keys for signing, some keys an=
d
> > >>> certs need to be copied into the u-boot build directory.
> > >>
> > >> Make sure to CC "NXP i.MX U-Boot Team" , else NXP is not informed. U=
se
> > >> scripts/get_maintainer to get the full list or just reuse the CC lis=
t
> > >> from patches in this thread.
> > >
> > > I send the patch with `--to-cmd scripts/get_maintainer.pl`, maybe I
> > > should have used `--cc-cmd`, but that would not change the list of
> > > recipients.
> >
> > Should now be fixed in
> > [PATCH] ARM: imx: Add doc/imx/ to i.MX MAINTAINERS entry
> >
> > >>> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> > >>> b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> > >>> index ce1de659d8..42214df21a 100644
> > >>> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> > >>> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> > >>> @@ -144,6 +144,22 @@ The signing is activated by wrapping SPL and
> > >>> fitImage sections into nxp-imx8mcst
> > >>>   etype, which is done automatically in
> > >>> arch/arm/dts/imx8m{m,n,p,q}-u-boot.dtsi
> > >>>   in case CONFIG_IMX_HAB Kconfig symbol is enabled.
> > >>> +Per default the HAB keys and certificates need to be located in th=
e
> > >>> build
> > >>> +directory, this means copying the following files from the HAB key=
s
> > >>> directory
> > >>> +flat (e.g. removing the `keys` and `cert` subdirectory) into the
> > >>> u-boot build
> > >>> +directory for the CST Code Signing Tool to locate them:
> > >>
> > >> Do symlink(s) work too ?
> > >
> > > I have not tested it, but I don't see any reason why it would not. I
> > > also don't see a reason for mentioning it. I want to keep it simple, =
if
> > > the dev whats to do things differently, they are free to do so.
> >
> > "
> > Per default the HAB keys and certificates need to be located in the
> > build directory, this means {+creating a symbolic link or +}copying the
> > following...
> > "
> >
> > Please test it and add it in V2 if it works, I think symlink is better
> > than bluntly copying files around, esp. for crypto material.
>
> Hi Marek and Claudius,
>
> Yes, this documentation is needed as well but I'm still unclear why
> the old method before this series did not require the usr_key.pem
> files, why I don't have the *usr_key.pem files in my crts dir created
> (long ago) with cst-3.3.1 and cst-3.3.2, and what I need to do to
> generate them now that they are apparently needed.
>
> Best Regards,
>
> Tim
>
> >
> > >>> +- `crts/SRK_1_2_3_4_table.bin`
> > >>> +- `crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem`
> > >>> +- `keys/CSF1_1_sha256_4096_65537_v3_usr_key.pem`
> > >>> +- `crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem`
> > >>> +- `keys/IMG1_1_sha256_4096_65537_v3_usr_key.pem`
> > >>> +- `keys/key_pass.txt`
> > >>> +
> > >>> +The paths to the SRK table and the certificates can be modified vi=
a
> > >>> changes to
> > >>> +the nxp_imx8mcst device tree node
> > >>
> > >> "nodes", plural, there are two, one for SPL and one for fitImage.
> > >
> > > Well, I was thinking here more generally about the node type and was
> > > assuming that the person reading this knows how many they have of tha=
t
> > > type. But I can add a `s` in v2.
> >
> > Use "node(s)" which covers both options.
> >
> > >> It would be good to mention the DT properties which govern the crypt=
o
> > >> material paths -- nxp,srk-table, nxp,csf-crt, nxp,img-crt -- somewhe=
re
> > >> around this sentence.
> > >
> > > This is something that should be documented with the changes where th=
at
> > > code was added, IMO. I only documented here what I found out and have
> > > used myself, I haven't used those.
> > >
> > > I would be interested in reading how to best overwrite those paths an=
d
> > > the image structured from board u-boot.dtsi files myself.
> > >
> > > If you want to can pickup my patch and integrate it into your series =
and
> > > extend it.
> >
> > I'll keep it in mind for V3.

Hi Marek,

The documentation patch here by Claudius does resolve my issues
discussed in the other thread and I can confirm symlinks work fine so
I think something like the following should be added:

CST_DIR=3D/usr/src/cst-3.3.2/
ln -s $CST_DIR/crts .
ln -s $CST_DIR/keys .

then with the following change to nxp_imx8mcst.py you can build a
signed image without code modification:
diff --git a/tools/binman/etype/nxp_imx8mcst.py
b/tools/binman/etype/nxp_imx8mcst.py
index 132127ad4827..7d8abc78fc89 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -68,9 +68,9 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
     def ReadNode(self):
         super().ReadNode()
         self.loader_address =3D fdt_util.GetInt(self._node, 'nxp,loader-ad=
dress')
-        self.srk_table =3D fdt_util.GetString(self._node,
'nxp,srk-table', 'SRK_1_2_3_4_table.bin')
-        self.csf_crt =3D fdt_util.GetString(self._node, 'nxp,csf-crt',
'CSF1_1_sha256_4096_65537_v3_usr_crt.pem')
-        self.img_crt =3D fdt_util.GetString(self._node, 'nxp,img-crt',
'IMG1_1_sha256_4096_65537_v3_usr_crt.pem')
+        self.srk_table =3D fdt_util.GetString(self._node,
'nxp,srk-table', 'crts/SRK_1_2_3_4_table.bin')
+        self.csf_crt =3D fdt_util.GetString(self._node, 'nxp,csf-crt',
'crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem')
+        self.img_crt =3D fdt_util.GetString(self._node, 'nxp,img-crt',
'crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem')
         self.unlock =3D fdt_util.GetBool(self._node, 'nxp,unlock')
         self.ReadEntries()

If copying or symlinking the keys/certs directory is not desired are
env vars exposed to binman's python classes? If so you can just
require CST_DIR to be specified and use that for the paths?

Best Regards,

Tim
