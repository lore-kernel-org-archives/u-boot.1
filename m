Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EC2D6C2AF
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 23:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CFF9892C6;
	Wed, 20 Nov 2024 00:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CYhF3vmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A70895D9; Wed, 20 Nov 2024 00:02:38 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE161891EF
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 00:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732057348; x=1732662148; i=xypron.glpk@gmx.de;
 bh=LWXLnc3h5MDASJKKfL7JrqOlqYK9A0k4BQedqA9dKMo=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CYhF3vmFNQ5U9YHQRBAzrs8PYDdHW+ZxG5rJMlCrpxfqB18VnAb4jjBIkiF+5I7D
 qHXLNllc1uBmuUwWAKT1vmv7Af+eGVYznUIxfGNypE4PIx9pUZXNt68ZS+b3fkl97
 60lJTRUiXd+ZC+stwElFxsTu5uItQVfR70T/Skfg9hAbyaa0X9FX5D/F5tNrr27Ly
 l108LadJ6TiHbhVYAgmkDQiwP7AIr9ayWd7MNuJA4XQ3DcjZ4MgMiK+OIX0SEFSYy
 YExPK0WQhrpfl4Y8S7F21agv8QcsavOT7naOGbXjNzxcZ9o0sU3uNvv2ZkRa5DxhP
 js2g/Gdy2dtTNCtcxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89Gt-1t9OVc2scN-00660t; Wed, 20
 Nov 2024 00:02:27 +0100
Date: Wed, 20 Nov 2024 00:02:24 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Lothar Rubusch <l.rubusch@gmail.com>, sjg@chromium.org, trini@konsulko.com,
 alpernebiyasak@gmail.com, ada@thorsis.com
CC: mkorpershoek@baylibre.com, dario.binacchi@amarulasolutions.com,
 pbrobinson@gmail.com, n-francis@ti.com, afd@ti.com, al.kochet@gmail.com,
 u-boot@lists.denx.de, l.rubusch@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_3/3=5D_doc=3A_develop=3A_Fix_t?=
 =?US-ASCII?Q?ypos_and_wording_in_binman/entries=2Erst?=
User-Agent: Thunderbird for Android
In-Reply-To: <20241119222837.27550-4-l.rubusch@gmail.com>
References: <20241119222837.27550-1-l.rubusch@gmail.com>
 <20241119222837.27550-4-l.rubusch@gmail.com>
Message-ID: <2FEF61FF-5C03-40E0-B962-34E972C2B9B5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aCnagmGpJ/eZwREV9YFD380gNF2IWUFbNRjTxy1PUJKV4JqY0u/
 GRgIfV7MCmDLBjv01Emfiv6+6zaHFUZlLUW+cke46Nj516UtKR6Ozw2ofpFY1VSg3YVjPj0
 mpYJSd94mgOtmg81CZcYeRC5etV6GlHAYUgrpVvsEIo4CjdatMIDTPyPbXw7tO1QMokoAhA
 fjgaEQr8H0qxB+eV9u87g==
UI-OutboundReport: notjunk:1;M01:P0:9MoDYu7JoFA=;GM6PlCjp0q17rvIBoRw4wSYHkXl
 jYONSN0AWsSLFhVTWS41SYEqQihptnj8OBlYB/argE7PvB8HhkxAd31FJ3GVuFqmShQR6zvpI
 Yoq15MJ6ZzE+z2hwShlAfP2L+RIhrX16kva8hOHZ2DGeMENYI+E3iDMrxrOPmeK8lcfhkBVst
 dCHNt7+hTrNvglzbI4W8Vx2efYjIXYlmnTk/cQZGgXD1ymIgllDGo3B0jC9MFdA2pV5yAEoOi
 uPEJ3Qkov1iGpU3iYAYMF6Dy8cgcgcbLhgV2S1cUwi2t6QNqJHDRicblaFmH+C40jtnkeQj0C
 Ee3OPysMSOR3n7ItQsBdN4OGtrPZJmYqz/OeDCNgO/F/HQ2kzSUgZGV9RO5Wl3By7DGpwnMv5
 C5wPahp+mBXYjUWgjPTypVRJSgrptuu1Q+QTQ04o0CTdfrWHPlR2UvBerWEPE2iOvE4D6Puqp
 IIxV943cx+emqr+rQi9S+uy+US2Ejbti3ZKpGyyJYAhTN7RfDx/x8UIzQaNbCxeJS1fRzwV9E
 H/KE2TaY8t2cO5hoS1157rNqVfpAMKpg5S6uiNS2gOLCcPF+IxrJ40CK+gF2nMqGl7Oa+vOHR
 urwRadn0zqbu0Bu9cwWlek7oMGK2DY7O/ME9VULtfTGJO5CMWLmtJBmrtl/3TWpfvDkJl2pkg
 tOF3NEynnIOdMw/LKflZP1InLHNgarDXbGNavu75yAo7RppfdHfO3+VlD0B7+bpPIScbJeLlq
 XQbmhkvuQAf4x9BgbdrOLAlHg36pCpP/67lD+jRd8LahbDhc1knfcBghJkxch3B832uy89Zny
 Wya0AUFgc9V/7ImeU1C/l5C9KCWfAf3vTfLJH+gJOEnHvLKEitybPbWWneRtKvFWGhe53RH9Q
 jkZmgziTVUaOp0Yat1HIkFrD+jQZw/GOMWhyje6F8XDQ6+cJw4jJjofaR
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

Am 19=2E November 2024 23:28:37 MEZ schrieb Lothar Rubusch <l=2Erubusch@gma=
il=2Ecom>:
>Fix some typos and wording in binman/entries=2Erst=2E
>
>Signed-off-by: Lothar Rubusch <l=2Erubusch@gmail=2Ecom>
>---
> tools/binman/entries=2Erst | 104 +++++++++++++++++++--------------------
> 1 file changed, 52 insertions(+), 52 deletions(-)
>
>diff --git a/tools/binman/entries=2Erst b/tools/binman/entries=2Erst
>index e918162fb4=2E=2Eabec03bb3c 100644
>--- a/tools/binman/entries=2Erst
>+++ b/tools/binman/entries=2Erst
>@@ -7,18 +7,18 @@ fairly easy to create new entry types=2E Just add a new=
 file to the 'etype'
> directory=2E You can use the existing entries as examples=2E
>=20
> Note that some entries are subclasses of others, using and extending the=
ir
>-features to produce new behaviours=2E
>+features to produce new behaviors=2E
>=20

The project once used to prefer British English=2E

>=20
>=20
> =2E=2E _etype_alternates_fdt:
>=20
>-Entry: alternates-fdt: Entry that generates alternative sections for eac=
h devicetree provided
>+Entry: alternates-fdt: Entry that generates alternative sections for eac=
h device-tree provided

'Devicetree' is a frequently used spelling variant, cf=2E https://www=2Ede=
vicetree=2Eorg/ =2E

> ------------------------------------------------------------------------=
---------------------
>=20
> When creating an image designed to boot on multiple models, each model
>-requires its own devicetree=2E This entry deals with selecting the corre=
ct
>-devicetree from a directory containing them=2E Each one is read in turn,=
 then
>+requires its own device-tree=2E This entry deals with selecting the corr=
ect
>+device-tree from a directory containing them=2E Each one is read in turn=
, then
> used to produce section contents which are written to a file=2E This res=
ults
> in a number of images, one for each model=2E
>=20
>@@ -48,8 +48,8 @@ of each of the alternates is the same as the 'default' =
one, so they can in
> principle be 'slotted in' to the appropriate place in the main image=2E
>=20
> The optional `fdt-phase` property indicates the phase to build=2E In thi=
s
>-case, it etype runs fdtgrep to obtain the devicetree subset for that pha=
se,
>-respecting the `bootph-xxx` tags in the devicetree=2E
>+case, it etype runs fdtgrep to obtain the device-tree subset for that ph=
ase,
>+respecting the `bootph-xxx` tags in the device-tree=2E
>=20
>=20
>=20
>@@ -214,7 +214,7 @@ icons, for example=2E For verified boot it could be u=
sed for each part of the
> image (e=2Eg=2E separate FIPs for A and B) but cannot describe the whole
> firmware image=2E As with FMAP there is no hierarchy defined, although F=
MAP
> works around this by having 'section' areas which encompass others=2E A
>-similar workaround would be possible with FIP but is not currently defin=
ed=2E
>+similar workaround would be possible with FIP but it is not currently de=
fined=2E

Both versions seem to be correct English=2E

Best regards

Heinrich

>=20
> It is recommended to always add an fdtmap to every image, as well as any
> FIPs so that binman and other tools can access the entire image correctl=
y=2E
>@@ -240,7 +240,7 @@ Properties / Entry arguments:
>         lz4: Use lz4 compression (via 'lz4' command-line utility)
>=20
> This entry reads data from a file and places it in the entry=2E The
>-default filename is often specified specified by the subclass=2E See for
>+default filename is often specified by the subclass=2E See for
> example the 'u-boot' entry which provides the filename 'u-boot=2Ebin'=2E
>=20
> If compression is enabled, an extra 'uncomp-size' property is written to
>@@ -283,10 +283,10 @@ See 'blob' for Properties / Entry arguments=2E
> Entry: blob-ext-list: List of externally built binary blobs
> -----------------------------------------------------------
>=20
>-This is like blob-ext except that a number of blobs can be provided,
>-typically with some sort of relationship, e=2Eg=2E all are DDC parameter=
s=2E
>+This is like blob-ext except that a few blobs can be provided,
>+typically, with some sort of relationship, e=2Eg=2E all are DDC paramete=
rs=2E
>=20
>-If any of the external files needed by this llist is missing, binman can
>+If any of the external files needed by this list is missing, binman can
> optionally ignore it and produce a broken image with a warning=2E
>=20
> Args:
>@@ -335,7 +335,7 @@ structure and allows the position of individual files=
 to be set, since it is
> designed to support execute-in-place in an x86 SPI-flash device=2E Where=
 XIP
> is not used, it supports compression and storing ELF files=2E
>=20
>-CBFS is used by coreboot as its way of orgnanising SPI-flash contents=2E
>+CBFS is used by coreboot as its way of organizing SPI-flash contents=2E
>=20
> The contents of the CBFS are defined by subnodes of the cbfs entry, e=2E=
g=2E::
>=20
>@@ -351,8 +351,8 @@ The contents of the CBFS are defined by subnodes of t=
he cbfs entry, e=2Eg=2E::
>=20
> This creates a CBFS 1MB in size two files in it: u-boot=2Ebin and u-boot=
=2Edtb=2E
> Note that the size is required since binman does not support calculating=
 it=2E
>-The contents of each entry is just what binman would normally provide if=
 it
>-were not a CBFS node=2E A blob type can be used to import arbitrary file=
s as
>+The contents of each entry are just what binman would normally provide i=
f it
>+was not a CBFS node=2E A blob type can be used to import arbitrary files=
 as
> with the second subnode below::
>=20
>     cbfs {
>@@ -431,7 +431,7 @@ cbfs-offset:
>     specify where the file should be placed in cases where a fixed posit=
ion
>     is needed=2E Typical uses are for code which is not relocatable and =
must
>     execute in-place from a particular address=2E This works because SPI=
 flash
>-    is generally mapped into memory on x86 devices=2E The file header is
>+    is mapped into memory on x86 devices=2E The file header is
>     placed before this offset so that the data start lines up exactly wi=
th
>     the chosen offset=2E If this property is not provided, then the file=
 is
>     placed in the next available spot=2E
>@@ -439,9 +439,9 @@ cbfs-offset:
> The current implementation supports only a subset of CBFS features=2E It=
 does
> not support other file types (e=2Eg=2E payload), adding multiple files (=
like the
> 'files' entry with a pattern supported by binman), putting files at a
>-particular offset in the CBFS and a few other things=2E
>+offset in the CBFS and a few other things=2E
>=20
>-Of course binman can create images containing multiple CBFSs, simply by
>+Of course, binman can create images containing multiple CBFSs, simply by
> defining these in the binman config::
>=20
>=20
>@@ -475,7 +475,7 @@ defining these in the binman config::
>     };
>=20
> This creates an 8MB image with two CBFSs, one at offset 1MB, one at 7MB,
>-both of size 1MB=2E
>+both sizes 1MB=2E
>=20
>=20
>=20
>@@ -745,11 +745,11 @@ Example output for a simple image with U-Boot and a=
n FDT map::
>         };
>     };
>=20
>-If allow-repack is used then 'orig-offset' and 'orig-size' properties ar=
e
>+If allow-repack is used, then 'orig-offset' and 'orig-size' properties a=
re
> added as necessary=2E See the binman README=2E
>=20
> When extracting files, an alternative 'fdt' format is available for fdtm=
aps=2E
>-Use `binman extract -F fdt =2E=2E=2E` to use this=2E It will export a de=
vicetree,
>+Use `binman extract -F fdt =2E=2E=2E` to use this=2E It will export a de=
vice-tree,
> without the fdtmap header, so it can be viewed with `fdtdump`=2E
>=20
>=20
>@@ -766,8 +766,8 @@ Properties / Entry arguments:
>         lz4: Use lz4 compression (via 'lz4' command-line utility)
>     - files-align: Align each file to the given alignment
>=20
>-This entry reads a number of files and places each in a separate sub-ent=
ry
>-within this entry=2E To access these you need to enable device-tree upda=
tes
>+The entry reads a few files and places each in a separate sub-entry
>+within this entry=2E To access it you need to enable device-tree updates
> at run-time so you can obtain the file positions=2E
>=20
>=20
>@@ -883,7 +883,7 @@ NAME
>     Name of the dtb as provided (i=2Ee=2E without adding '=2Edtb')
>=20
> The `default` property, if present, will be automatically set to the nam=
e
>-if of configuration whose devicetree matches the `default-dt` entry
>+if of configuration whose device-tree matches the `default-dt` entry
> argument, e=2Eg=2E with `-a default-dt=3Dsun50i-a64-pine64-lts`=2E
>=20
> Available substitutions for property values in these nodes are:
>@@ -919,7 +919,7 @@ U-Boot supports creating fdt and config nodes automat=
ically=2E To do this,
> pass an `of-list` property (e=2Eg=2E `-a of-list=3Dfile1 file2`)=2E This=
 tells
> binman that you want to generates nodes for two files: `file1=2Edtb` and
> `file2=2Edtb`=2E The `fit,fdt-list` property (see above) indicates that
>-`of-list` should be used=2E If the property is missing you will get an e=
rror=2E
>+`of-list` should be used=2E If the property is missing, you get an error=
=2E
>=20
> Then add a 'generator node', a node with a name starting with '@'::
>=20
>@@ -953,20 +953,20 @@ You can create config nodes in a similar way::
> This tells binman to create nodes `config-1` and `config-2`, i=2Ee=2E a =
config
> for each of your two files=2E
>=20
>-Note that if no devicetree files are provided (with '-a of-list' as abov=
e)
>+Note that if no device-tree files are provided (with '-a of-list' as abo=
ve)
> then no nodes will be generated=2E
>=20
> The 'fit,compatible' property (if present) is replaced with the compatib=
le
>-string from the root node of the devicetree, so that things work correct=
ly
>-with FIT's configuration-matching algortihm=2E
>+string from the root node of the device-tree, so that things work correc=
tly
>+with FIT's configuration-matching algorithm=2E
>=20
> Dealing with phases
> ~~~~~~~~~~~~~~~~~~~
>=20
> FIT can be used to load firmware=2E In this case it may be necessary to =
run
>-the devicetree for each model through fdtgrep to remove unwanted propert=
ies=2E
>+the device-tree for each model through fdtgrep to remove unwanted proper=
ties=2E
> The 'fit,fdt-phase' property can be provided to indicate the phase for w=
hich
>-the devicetree is intended=2E
>+the device-tree is intended=2E
>=20
> For example this indicates that the FDT should be processed for VPL::
>=20
>@@ -1164,7 +1164,7 @@ Properties / Entry arguments:
>=20
> FMAP is a simple format used by flashrom, an open-source utility for
> reading and writing the SPI flash, typically on x86 CPUs=2E The format
>-provides flashrom with a list of areas, so it knows what it in the flash=
=2E
>+provides flashrom with a list of areas, that it knows what is in the fla=
sh=2E
> It can then read or write just a single area, instead of the whole flash=
=2E
>=20
> The format is defined by the flashrom project, in the file lib/fmap=2Eh =
-
>@@ -1214,7 +1214,7 @@ Entry: image-header: An entry which contains a poin=
ter to the FDT map
>=20
> Properties / Entry arguments:
>     location: Location of header ("start" or "end" of image)=2E This is
>-        optional=2E If omitted then the entry must have an offset proper=
ty=2E
>+        optional=2E If omitted, then the entry must have an offset prope=
rty=2E
>=20
> This adds an 8-byte entry to the start or end of the image, pointing to =
the
> location of the FDT map=2E The format is a magic number followed by an o=
ffset
>@@ -1223,7 +1223,7 @@ from the start or end of the image, in twos-complim=
ent format=2E
> This entry must be in the top-level part of the image=2E
>=20
> NOTE: If the location is at the start/end, you will probably need to spe=
cify
>-sort-by-offset for the image, unless you actually put the image header
>+sort-by-offset for the image, unless you put the image header
> first/last in the entry list=2E
>=20
>=20
>@@ -1338,7 +1338,7 @@ Properties / Entry arguments:
> This file contains a binary blob which is used on some devices to set up
> the silicon=2E U-Boot executes this code in U-Boot proper after SDRAM is
> running, so that it can make full use of memory=2E Documentation is typi=
cally
>-not available in sufficient detail to allow U-Boot do this this itself=
=2E
>+not available in sufficient detail to allow U-Boot do this itself=2E
>=20
> An example filename is 'fsp_s=2Ebin'
>=20
>@@ -1411,7 +1411,7 @@ Properties / Entry arguments:
> This file contains code used by the SoC that is required to make it work=
=2E
> The Management Engine is like a background task that runs things that ar=
e
> not clearly documented, but may include keyboard, display and network
>-access=2E For platform that use ME it is not possible to disable it=2E U=
-Boot
>+access=2E For platforms using ME, it is not possible to disable it=2E U-=
Boot
> does not directly execute code in the ME binary=2E
>=20
> A typical filename is 'me=2Ebin'=2E
>@@ -1664,7 +1664,7 @@ placed at offset 'RESET_VECTOR_ADDRESS - 0xffc'=2E
>=20
> =2E=2E _etype_pre_load:
>=20
>-Entry: pre-load: Pre load image header
>+Entry: pre-load: Pre-load image header
> --------------------------------------
>=20
> Properties / Entry arguments:
>@@ -2216,14 +2216,14 @@ Properties / Entry arguments:
> Entry: u-boot-expanded: U-Boot flat binary broken out into its component=
 parts
> ------------------------------------------------------------------------=
------
>=20
>-This is a section containing the U-Boot binary and a devicetree=2E Using=
 this
>+This is a section containing the U-Boot binary and a device-tree=2E Usin=
g this
> entry type automatically creates this section, with the following entrie=
s
> in it:
>=20
>    u-boot-nodtb
>    u-boot-dtb
>=20
>-Having the devicetree separate allows binman to update it in the final
>+Having the device-tree separate allows binman to update it in the final
> image, so that the entries positions are provided to the running U-Boot=
=2E
>=20
>=20
>@@ -2303,8 +2303,8 @@ to avoid the data overlapping with U-Boot variables=
=2E This entry is useful in
> that case=2E It automatically pads out the entry size to cover both the =
code,
> data and BSS=2E
>=20
>-The contents of this entry will a certain number of zero bytes, determin=
ed
>-by __bss_size
>+The contents of this entry will be filled up with a number of zero bytes=
,
>+determined by __bss_size
>=20
> The ELF file 'spl/u-boot-spl' must also be available for this to work, s=
ince
> binman uses that to look up the BSS address=2E
>@@ -2348,14 +2348,14 @@ Properties / Entry arguments:
>         select)
>=20
> This is a section containing the U-Boot binary, BSS padding if needed an=
d a
>-devicetree=2E Using this entry type automatically creates this section, =
with
>+device-tree=2E Using this entry type automatically creates this section,=
 with
> the following entries in it:
>=20
>    u-boot-spl-nodtb
>    u-boot-spl-bss-pad
>    u-boot-dtb
>=20
>-Having the devicetree separate allows binman to update it in the final
>+Having the device-tree separate allows binman to update it in the final
> image, so that the entries positions are provided to the running U-Boot=
=2E
>=20
> This entry is selected based on the value of the 'spl-dtb' entryarg=2E I=
f
>@@ -2479,8 +2479,8 @@ to avoid the data overlapping with U-Boot variables=
=2E This entry is useful in
> that case=2E It automatically pads out the entry size to cover both the =
code,
> data and BSS=2E
>=20
>-The contents of this entry will a certain number of zero bytes, determin=
ed
>-by __bss_size
>+The contents of this entry will be filled up with a number of zero bytes=
,
>+determined by __bss_size
>=20
> The ELF file 'tpl/u-boot-tpl' must also be available for this to work, s=
ince
> binman uses that to look up the BSS address=2E
>@@ -2536,14 +2536,14 @@ Properties / Entry arguments:
>         select)
>=20
> This is a section containing the U-Boot binary, BSS padding if needed an=
d a
>-devicetree=2E Using this entry type automatically creates this section, =
with
>+device-tree=2E Using this entry type automatically creates this section,=
 with
> the following entries in it:
>=20
>    u-boot-tpl-nodtb
>    u-boot-tpl-bss-pad
>    u-boot-dtb
>=20
>-Having the devicetree separate allows binman to update it in the final
>+Having the device-tree separate allows binman to update it in the final
> image, so that the entries positions are provided to the running U-Boot=
=2E
>=20
> This entry is selected based on the value of the 'tpl-dtb' entryarg=2E I=
f
>@@ -2678,8 +2678,8 @@ to avoid the data overlapping with U-Boot variables=
=2E This entry is useful in
> that case=2E It automatically pads out the entry size to cover both the =
code,
> data and BSS=2E
>=20
>-The contents of this entry will a certain number of zero bytes, determin=
ed
>-by __bss_size
>+The contents of this entry will be filled up with a number of zero bytes=
,
>+determined by __bss_size
>=20
> The ELF file 'vpl/u-boot-vpl' must also be available for this to work, s=
ince
> binman uses that to look up the BSS address=2E
>@@ -2723,14 +2723,14 @@ Properties / Entry arguments:
>         select)
>=20
> This is a section containing the U-Boot binary, BSS padding if needed an=
d a
>-devicetree=2E Using this entry type automatically creates this section, =
with
>+device-tree=2E Using this entry type automatically creates this section,=
 with
> the following entries in it:
>=20
>    u-boot-vpl-nodtb
>    u-boot-vpl-bss-pad
>    u-boot-dtb
>=20
>-Having the devicetree separate allows binman to update it in the final
>+Having the device-tree separate allows binman to update it in the final
> image, so that the entries positions are provided to the running U-Boot=
=2E
>=20
> This entry is selected based on the value of the 'vpl-dtb' entryarg=2E I=
f
>@@ -2774,7 +2774,7 @@ Properties / Entry arguments:
> See Entry_u_boot_ucode for full details of the three entries involved in
> this process=2E This entry updates U-Boot with the offset and size of th=
e
> microcode, to allow early x86 boot code to find it without doing anythin=
g
>-complicated=2E Otherwise it is the same as the u-boot entry=2E
>+complicated=2E Otherwise, it is the same as the u-boot entry=2E
>=20
>=20
>=20
>@@ -2947,8 +2947,8 @@ Properties / Entry arguments:
>     - keysrc-enc: (Optional) Key source when using decryption engine
>     - pmufw-filename: Filename of PMU firmware=2E Default: pmu-firmware=
=2Eelf
>     - psk-key-name-hint: Name of primary secret key to use for signing t=
he
>-                         secondardy public key=2E Format: =2Epem file
>-    - ssk-key-name-hint: Name of secondardy secret key to use for signin=
g
>+                         secondary public key=2E Format: =2Epem file
>+    - ssk-key-name-hint: Name of secondary secret key to use for signing
>                          the boot image=2E Format: =2Epem file
>=20
> The etype is used to create a boot image for Xilinx ZynqMP

