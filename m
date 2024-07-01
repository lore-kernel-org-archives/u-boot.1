Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BDFC30653
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 22:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52B97886C1;
	Tue,  2 Jul 2024 00:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="e3c9Sb5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43EAE886B9; Tue,  2 Jul 2024 00:26:14 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 236A388297
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 00:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719872765; x=1720477565; i=xypron.glpk@gmx.de;
 bh=hsNhM/3BkTGGghq4ZXKduJxWtATI6f57z4qemuD66iY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=e3c9Sb5rwPxliskq1c+/7RnhU0KCL8lUIjKrKo+zLoquqEu3cUnHsmRbG0LKL/jN
 n72EGEoCjd8/EV5FVAeKPoz6s9FQAFDNMl2af5Z+ygAL8QMLJQg/s2RF5NQTgd3k3
 dnIP60wyQOaHYkATTitOp8QAPiXrSQoKZI5Nv751u+xjzTAbE43DgSfu+Un2pawqp
 7PaUvitqpGUCxwXhLLjKqeoKgBzzKner4tsDUxYkJx+GKyjc9EFyqHLa1ni53TJdZ
 ySvOF7jzjWFpbUsC/2wOGLUUwxFn9wo0GXrDE4olDuYFCb8v3mT05YwpLr9wPeo3Q
 Uqoe/MTEvxTaR/lvsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.41.25]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wPb-1sUCE21dpj-004dGo; Tue, 02
 Jul 2024 00:26:05 +0200
Date: Tue, 02 Jul 2024 00:26:02 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Sam Povilus <sam.povilus@amd.com>
CC: git@amd.com, trini@konsulko.com, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [RFC 1/1] doc: Remove FIT documentation that is elsewhere
User-Agent: K-9 Mail for Android
In-Reply-To: <92415d1b-d644-4224-ba2c-1b4d23f1f385@amd.com>
References: <20240617202041.3740154-1-sam.povilus@amd.com>
 <20240617202041.3740154-2-sam.povilus@amd.com>
 <b882aacb-e4bd-4749-b228-3fefedff7364@gmx.de>
 <92415d1b-d644-4224-ba2c-1b4d23f1f385@amd.com>
Message-ID: <AE90DDDF-0AC1-4674-A7EF-A6A274DE02D7@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QP6KuRbExfzVvmulqsy7zi4dWJzmF4fk9RaALpYhEgCWQLsd/9e
 6SJnyXO2/pNt9dtgPhnSIbu69/7197eoNi91HxSXFf6bBe8Rdn1shc6Hkt7A7OMeC7MhoMp
 BxjoCQtDlUjl5udH1Q8IjgMvQPZCOoT7jRuPCe0WfuhIALTKSPpnjOu8B08mHYDIorn5ezg
 GPN9CmkRWdFG7EVHvhzVA==
UI-OutboundReport: notjunk:1;M01:P0:E71VYy9JqMc=;Zz03IZkD12b3+3Jpb5MhmD/RlTE
 Xz87sTs1aCoB4K8lAyjvjZ7ldblDyJnPCGZ5t4SxN7kz8A2mKvtEMHJu6HhNHwesB7A7F0vth
 52kg4/Ye1v9rlFGepADx07fdxZtAr2LLeS0XsRJUGZlKSNywv87zT4+VhU+MDvHmypj4qDnpo
 slI1LHWR7jSEn/gG5WQfbizLEwBF0fbA7bB/Z6mr9dobzeL66m4TDjDlytGobjVBT2jwHd+je
 c2dmFKFBkO/JeL2wS8kPil89VmDgeQMlZErahSQQ+0frl5ybbwKLKQ7dLDg7EJQ6WXooL8xG/
 9RH3KW6o1O2I77zEmUfpEisql7sNc4khAehShCOhvIwIqOglCtnrNS16y0oXE1m6Q6BKNNvNz
 IA7L4wJTRNXPZ4x58sqDvAuVOZbbYjNA7uRvTuN2JRoA4cvdNPiUGV9mX2n4WJHg+JylFG+GI
 OwzBkOxrKidTdoR0WRfg+W98LJ64dMs3/QPQVW5D8zvP1MtRRVwcRUrHx3jEqIZSsHyuoc6nL
 4fdxn9+EHVMjfLpP5bG/2W4D8dQDp2PA5piTfqNwhbCECkp/kANMnvmIVUhK9GVUJYYzfUvSP
 +Qt04xY58tF3D/T2ubEbxPq1uANChQN0yt11ae1d4dKPlIDqSERfh7VxxJ2rT/tAVdGloQMBh
 9sWNAWg9DTlepdjfaKW+Vy6U6TQxw61fjrJ5Bq39NliA1N+zOFpK1dJKEOxMhr/QTKGQ2xa4E
 Q7rtnxtBQom7KU3CafC5zTMzy0i24+J+n5cEKe+YBQft4MBrWigBhtN8jeJDAUMB4LsVJWpbv
 2DBxK20c+rMkBnNOpe8DPTGz4z3NaDYGRBg4Zoi3PU8GQ=
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



Am 1=2E Juli 2024 21:52:12 MESZ schrieb Sam Povilus <sam=2Epovilus@amd=2Ec=
om>:
>
>
>On 6/18/2024 12:03 AM, Heinrich Schuchardt wrote:
>> Caution: This message originated from an External Source=2E Use proper =
caution when opening attachments, clicking links, or responding=2E
>>=20
>>=20
>> On 6/17/24 22:20, Sam Povilus wrote:
>>> FIT documentation is now a separate project, instead of having a
>>> duplicate, we should point at the other project=2E
>>>=20
>>> Signed-off-by: Sam Povilus <sam=2Epovilus@amd=2Ecom>
>>> ---
>>> =C2=A0 doc/usage/fit/index=2Erst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +-
>>> =C2=A0 doc/usage/fit/source_file_format=2Erst | 682 +-----------------=
---------
>>> =C2=A0 2 files changed, 5 insertions(+), 691 deletions(-)
>>>=20
>>> diff --git a/doc/usage/fit/index=2Erst b/doc/usage/fit/index=2Erst
>>> index bd25bd30b2=2E=2E12a8c6fb16 100644
>>> --- a/doc/usage/fit/index=2Erst
>>> +++ b/doc/usage/fit/index=2Erst
>>> @@ -4,16 +4,6 @@ Flat Image Tree (FIT)
>>> =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>=20
>>> =C2=A0 U-Boot uses Flat Image Tree (FIT) as a standard file format for=
 packaging
>>> -images that it it reads and boots=2E Documentation about FIT is avail=
able at
>>> -doc/uImage=2EFIT
>>> +images that it it reads and boots=2E Documentation about FIT is avail=
able in
>>> +`the Flattened Image Tree project <https://fitspec=2Eosfw=2Efoundatio=
n/>`_=2E
>>>=20
>>> -=2E=2E toctree::
>>> -=C2=A0=C2=A0=C2=A0 :maxdepth: 1
>>> -
>>> -=C2=A0=C2=A0=C2=A0 source_file_format
>>=20
>> This is the only entry to be replaced by the external link=2E
>>=20
>>> -=C2=A0=C2=A0=C2=A0 howto
>>> -=C2=A0=C2=A0=C2=A0 x86-fit-boot
>>> -=C2=A0=C2=A0=C2=A0 signature
>>> -=C2=A0=C2=A0=C2=A0 verified-boot
>>> -=C2=A0=C2=A0=C2=A0 beaglebone_vboot
>>> -=C2=A0=C2=A0=C2=A0 overlay-fdt-boot
>>=20
>> All of these files are staying around and must be kept linked=2E
>
>I would argue that if this list is not being maintained, it is better to =
remove it than to try to keep it up to date=2E Maybe that should be a separ=
ate patch though?

Users will not be able to find the documents in the html documentation if =
you remove the links=2E Please, do not remove links for existing documents=
=2E

Best regards

Heinrich
>
>>=20
>> Many links are missing here=2E The complete list should be:
>>=20
>>  =C2=A0=C2=A0=C2=A0 beaglebone_vboot
>>  =C2=A0=C2=A0=C2=A0 howto
>>  =C2=A0=C2=A0=C2=A0 kernel_fdt
>>  =C2=A0=C2=A0=C2=A0 kernel_fdts_compressed
>>  =C2=A0=C2=A0=C2=A0 kernel
>>  =C2=A0=C2=A0=C2=A0 multi
>>  =C2=A0=C2=A0=C2=A0 multi_spl
>>  =C2=A0=C2=A0=C2=A0 multi-with-fpga
>>  =C2=A0=C2=A0=C2=A0 multi-with-loadables
>>  =C2=A0=C2=A0=C2=A0 overlay-fdt-boot
>>  =C2=A0=C2=A0=C2=A0 sec_firmware_ppa
>>  =C2=A0=C2=A0=C2=A0 signature
>>  =C2=A0=C2=A0=C2=A0 sign-configs
>>  =C2=A0=C2=A0=C2=A0 sign-images
>>  =C2=A0=C2=A0=C2=A0 uefi
>>  =C2=A0=C2=A0=C2=A0 update3
>>  =C2=A0=C2=A0=C2=A0 update_uboot
>>  =C2=A0=C2=A0=C2=A0 verified-boot
>>  =C2=A0=C2=A0=C2=A0 x86-fit-boot
>>=20
>> These other documents should be carefully redacted=2E E=2Eg=2E howto=2E=
rst
>> refers to the FIT file format as "the new uImage format"=2E
>
>I agree that it would be nice to take a pass through all this documentati=
on and clean it up, but I think there is value in doing small cleanups as o=
ne has time=2E
>
>>=20
>> Best regards
>>=20
>> Heinrich
>>=20
>>> diff --git a/doc/usage/fit/source_file_format=2Erst b/doc/usage/fit/so=
urce_file_format=2Erst
>>> index b2b1e42bd7=2E=2E0c44329a82 100644
>>> --- a/doc/usage/fit/source_file_format=2Erst
>>> +++ b/doc/usage/fit/source_file_format=2Erst
>>> @@ -3,682 +3,6 @@
>>> =C2=A0 Flattened Image Tree (FIT) Format
>>> =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>=20
>>> -Introduction
>>> -------------
>>> -
>>> -The number of elements playing a role in the kernel booting process h=
as
>>> -increased over time and now typically includes the devicetree, kernel=
 image and
>>> -possibly a ramdisk image=2E Generally, all must be placed in the syst=
em memory and
>>> -booted together=2E
>>> -
>>> -For firmware images a similar process has taken place, with various b=
inaries
>>> -loaded at different addresses, such as ARM's ATF, OpenSBI, FPGA and U=
-Boot
>>> -itself=2E
>>> -
>>> -FIT provides a flexible and extensible format to deal with this compl=
exity=2E It
>>> -provides support for multiple components=2E It also supports multiple
>>> -configurations, so that the same FIT can be used to boot multiple boa=
rds, with
>>> -some components in common (e=2Eg=2E kernel) and some specific to that=
 board (e=2Eg=2E
>>> -devicetree)=2E
>>> -
>>> -Terminology
>>> -~~~~~~~~~~~
>>> -
>>> -This document defines FIT by providing FDT (Flat Device Tree) binding=
s=2E These
>>> -describe the final form of the FIT at the moment when it is used=2E T=
he user
>>> -perspective may be simpler, as some of the properties (like timestamp=
s and
>>> -hashes) are filled in automatically by the U-Boot mkimage tool=2E
>>> -
>>> -To avoid confusion with the kernel FDT the following naming conventio=
n is used:
>>> -
>>> -FIT
>>> -=C2=A0=C2=A0=C2=A0 Flattened Image Tree
>>> -
>>> -FIT is formally a flattened devicetree (in the libfdt meaning), which=
 conforms
>>> -to bindings defined in this document=2E
>>> -
>>> -=2Eits
>>> -=C2=A0=C2=A0=C2=A0 image tree source
>>> -
>>> -=2Eitb
>>> -=C2=A0=C2=A0=C2=A0 flattened image tree blob
>>> -
>>> -Image-building procedure
>>> -~~~~~~~~~~~~~~~~~~~~~~~~
>>> -
>>> -The following picture shows how the FIT is prepared=2E Input consists=
 of
>>> -image source file (=2Eits) and a set of data files=2E Image is create=
d with the
>>> -help of standard U-Boot mkimage tool which in turn uses dtc (device t=
ree
>>> -compiler) to produce image tree blob (=2Eitb)=2E The resulting =2Eitb=
 file is the
>>> -actual binary of a new FIT::
>>> -
>>> -=C2=A0=C2=A0=C2=A0 tqm5200=2Eits
>>> -=C2=A0=C2=A0=C2=A0 +
>>> -=C2=A0=C2=A0=C2=A0 vmlinux=2Ebin=2Egz=C2=A0=C2=A0=C2=A0=C2=A0 mkimage=
 + dtc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 xfer to target
>>> -=C2=A0=C2=A0=C2=A0 eldk-4=2E2-ramdisk=C2=A0 --------------> tqm5200=
=2Eitb --------------> boot
>>> -=C2=A0=C2=A0=C2=A0 tqm5200=2Edtb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /|\
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'n=
ew FIT'
>>> -
>>> -Steps:
>>> -
>>> -#=2E Create =2Eits file, automatically filled-in properties are omitt=
ed
>>> -
>>> -#=2E Call mkimage tool on a =2Eits file
>>> -
>>> -#=2E mkimage calls dtc to create =2Eitb image and assures that
>>> -=C2=A0=C2=A0 missing properties are added
>>> -
>>> -#=2E =2Eitb (new FIT) is uploaded onto the target and used therein
>>> -
>>> -
>>> -Unique identifiers
>>> -~~~~~~~~~~~~~~~~~~
>>> -
>>> -To identify FIT sub-nodes representing images, hashes, configurations=
 (which
>>> -are defined in the following sections), the "unit name" of the given =
sub-node
>>> -is used as it's identifier as it assures uniqueness without additiona=
l
>>> -checking required=2E
>>> -
>>> -
>>> -External data
>>> -~~~~~~~~~~~~~
>>> -
>>> -FIT is normally built initially with image data in the 'data' propert=
y of each
>>> -image node=2E It is also possible for this data to reside outside the=
 FIT itself=2E
>>> -This allows the 'FDT' part of the FIT to be quite small, so that it c=
an be
>>> -loaded and scanned without loading a large amount of data=2E Then whe=
n an image is
>>> -needed it can be loaded from an external source=2E
>>> -
>>> -External FITs use 'data-offset' or 'data-position' instead of 'data'=
=2E
>>> -
>>> -The mkimage tool can convert a FIT to use external data using the `-E=
` argument,
>>> -optionally using `-p` to specific a fixed position=2E
>>> -
>>> -It is often desirable to align each image to a block size or cache-li=
ne size
>>> -(e=2Eg=2E 512 bytes), so that there is no need to copy it to an align=
ed address when
>>> -reading the image data=2E The mkimage tool provides a `-B` argument t=
o support
>>> -this=2E
>>> -
>>> -Root-node properties
>>> ---------------------
>>> -
>>> -The root node of the FIT should have the following layout::
>>> -
>>> -=C2=A0=C2=A0=C2=A0 / o image-tree
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- description =3D "image =
description"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- timestamp =3D <12399321=
>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- #address-cells =3D <1>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o images
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | |
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | o image-1 {=2E=2E=2E}
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | o image-2 {=2E=2E=2E}
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =2E=2E=2E
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o configurations
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- default =3D=
 "conf-1"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o conf-1 {=2E=
=2E=2E}
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o conf-2 {=2E=
=2E=2E}
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2E=2E=2E
>>> -
>>> -Optional property
>>> -~~~~~~~~~~~~~~~~~
>>> -
>>> -description
>>> -=C2=A0=C2=A0=C2=A0 Textual description of the FIT
>>> -
>>> -Mandatory property
>>> -~~~~~~~~~~~~~~~~~~
>>> -
>>> -timestamp
>>> -=C2=A0=C2=A0=C2=A0 Last image modification time being counted in seco=
nds since
>>> -=C2=A0=C2=A0=C2=A0 1970-01-01 00:00:00 - to be automatically calculat=
ed by mkimage tool=2E
>>> -
>>> -Conditionally mandatory property
>>> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> -
>>> -#address-cells
>>> -=C2=A0=C2=A0=C2=A0 Number of 32bit cells required to represent entry =
and
>>> -=C2=A0=C2=A0=C2=A0 load addresses supplied within sub-image nodes=2E =
May be omitted when no
>>> -=C2=A0=C2=A0=C2=A0 entry or load addresses are used=2E
>>> -
>>> -Mandatory nodes
>>> -~~~~~~~~~~~~~~~
>>> -
>>> -images
>>> -=C2=A0=C2=A0=C2=A0 This node contains a set of sub-nodes, each of the=
m representing
>>> -=C2=A0=C2=A0=C2=A0 single component sub-image (like kernel, ramdisk, =
etc=2E)=2E At least one
>>> -=C2=A0=C2=A0=C2=A0 sub-image is required=2E
>>> -
>>> -configurations
>>> -=C2=A0=C2=A0=C2=A0 Contains a set of available configuration nodes an=
d
>>> -=C2=A0=C2=A0=C2=A0 defines a default configuration=2E
>>> -
>>> -
>>> -'/images' node
>>> ---------------
>>> -
>>> -This node is a container node for component sub-image nodes=2E Each s=
ub-node of
>>> -the '/images' node should have the following layout::
>>> -
>>> -=C2=A0=C2=A0=C2=A0 o image-1
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- description =3D "compon=
ent sub-image description"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- data =3D /incbin/("path=
/to/data/file=2Ebin")
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- type =3D "sub-image typ=
e name"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- arch =3D "ARCH name"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- os =3D "OS name"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- compression =3D "compre=
ssion name"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- load =3D <00000000>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- entry =3D <00000000>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o hash-1 {=2E=2E=2E}
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o hash-2 {=2E=2E=2E}
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2E=2E=2E
>>> -
>>> -Mandatory properties
>>> -~~~~~~~~~~~~~~~~~~~~
>>> -
>>> -description
>>> -=C2=A0=C2=A0=C2=A0 Textual description of the component sub-image
>>> -
>>> -type
>>> -=C2=A0=C2=A0=C2=A0 Name of component sub-image type=2E Supported type=
s are:
>>> -
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -=C2=A0=C2=A0=C2=A0 Sub-image type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Meaning
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -=C2=A0=C2=A0=C2=A0 invalid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Invalid Image
>>> -=C2=A0=C2=A0=C2=A0 aisimage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Davinci AIS image
>>> -=C2=A0=C2=A0=C2=A0 atmelimage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ATMEL ROM-Boot Image
>>> -=C2=A0=C2=A0=C2=A0 copro=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Coprocessor Image}
>>> -=C2=A0=C2=A0=C2=A0 fdt_legacy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 legacy Image with Flat Device Tree
>>> -=C2=A0=C2=A0=C2=A0 filesystem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Filesystem Image
>>> -=C2=A0=C2=A0=C2=A0 firmware=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Firmware
>>> -=C2=A0=C2=A0=C2=A0 firmware_ivt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Firmware with HABv4 IVT }
>>> -=C2=A0=C2=A0=C2=A0 flat_dt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flat Device Tree
>>> -=C2=A0=C2=A0=C2=A0 fpga=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FPGA Image }
>>> -=C2=A0=C2=A0=C2=A0 gpimage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TI Keystone SPL Image
>>> -=C2=A0=C2=A0=C2=A0 imx8image=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NXP i=2EMX8 Boot Image
>>> -=C2=A0=C2=A0=C2=A0 imx8mimage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 NXP i=2EMX8M Boot Image
>>> -=C2=A0=C2=A0=C2=A0 imximage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Freescale i=2EMX Boot Image
>>> -=C2=A0=C2=A0=C2=A0 kernel=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel Image
>>> -=C2=A0=C2=A0=C2=A0 kernel_noload=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Kernel Image (no loading done)
>>> -=C2=A0=C2=A0=C2=A0 kwbimage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kirkwood Boot Image
>>> -=C2=A0=C2=A0=C2=A0 lpc32xximage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LPC32XX Boot Image
>>> -=C2=A0=C2=A0=C2=A0 mtk_image=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MediaTek BootROM loadable Image }
>>> -=C2=A0=C2=A0=C2=A0 multi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Multi-File Image
>>> -=C2=A0=C2=A0=C2=A0 mxsimage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Freescale MXS Boot Image
>>> -=C2=A0=C2=A0=C2=A0 omapimage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TI OMAP SPL With GP CH
>>> -=C2=A0=C2=A0=C2=A0 pblimage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Freescale PBL Boot Image
>>> -=C2=A0=C2=A0=C2=A0 pmmc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TI Power Manageme=
nt Micro-Controller Firmware
>>> -=C2=A0=C2=A0=C2=A0 ramdisk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RAMDisk Image
>>> -=C2=A0=C2=A0=C2=A0 rkimage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Rockchip Boot Image }
>>> -=C2=A0=C2=A0=C2=A0 rksd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Rockchip SD Boot =
Image }
>>> -=C2=A0=C2=A0=C2=A0 rkspi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Rockchip SPI Boot Image=
 }
>>> -=C2=A0=C2=A0=C2=A0 script=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Script
>>> -=C2=A0=C2=A0=C2=A0 socfpgaimage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Altera SoCFPGA CV/AV preloader
>>> -=C2=A0=C2=A0=C2=A0 socfpgaimage_v1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Altera SoCFPGA A10 preloader
>>> -=C2=A0=C2=A0=C2=A0 spkgimage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Renesas SPKG Image }
>>> -=C2=A0=C2=A0=C2=A0 standalone=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Standalone Program
>>> -=C2=A0=C2=A0=C2=A0 stm32image=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 STMicroelectronics STM32 Image }
>>> -=C2=A0=C2=A0=C2=A0 sunxi_egon=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Allwinner eGON Boot Image }
>>> -=C2=A0=C2=A0=C2=A0 sunxi_toc0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Allwinner TOC0 Boot Image }
>>> -=C2=A0=C2=A0=C2=A0 tee=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Trusted Exe=
cution Environment Image
>>> -=C2=A0=C2=A0=C2=A0 ublimage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Davinci UBL image
>>> -=C2=A0=C2=A0=C2=A0 vybridimage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Vybrid Boot Image
>>> -=C2=A0=C2=A0=C2=A0 x86_setup=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86 setup=2Ebin
>>> -=C2=A0=C2=A0=C2=A0 zynqimage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Xilinx Zynq Boot Image }
>>> -=C2=A0=C2=A0=C2=A0 zynqmpbif=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Xilinx ZynqMP Boot Image (bif) }
>>> -=C2=A0=C2=A0=C2=A0 zynqmpimage=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Xilinx ZynqMP Boot Image }
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -
>>> -compression
>>> -=C2=A0=C2=A0=C2=A0 Compression used by included data=2E If no compres=
sion is used, the
>>> -=C2=A0=C2=A0=C2=A0 compression property should be set to "none"=2E If=
 the data is compressed but
>>> -=C2=A0=C2=A0=C2=A0 it should not be uncompressed by the loader (e=2Eg=
=2E compressed ramdisk), this
>>> -=C2=A0=C2=A0=C2=A0 should also be set to "none"=2E
>>> -
>>> -=C2=A0=C2=A0=C2=A0 Supported compression types are:
>>> -
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -=C2=A0=C2=A0=C2=A0 Compression type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Mea=
ning
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -=C2=A0=C2=A0=C2=A0 none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uncompressed
>>> -=C2=A0=C2=A0=C2=A0 bzip2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bzip2 compressed
>>> -=C2=A0=C2=A0=C2=A0 gzip=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gzip compressed
>>> -=C2=A0=C2=A0=C2=A0 lz4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lz4 compres=
sed
>>> -=C2=A0=C2=A0=C2=A0 lzma=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lzma compressed
>>> -=C2=A0=C2=A0=C2=A0 lzo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lzo compres=
sed
>>> -=C2=A0=C2=A0=C2=A0 zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd compressed
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -
>>> -data-size
>>> -=C2=A0=C2=A0=C2=A0 size of the data in bytes
>>> -
>>> -
>>> -Conditionally mandatory property
>>> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> -
>>> -data
>>> -=C2=A0=C2=A0=C2=A0 Path to the external file which contains this node=
's binary data=2E Within
>>> -=C2=A0=C2=A0=C2=A0 the FIT this is the contents of the file=2E This i=
s mandatory unless
>>> -=C2=A0=C2=A0=C2=A0 external data is used=2E
>>> -
>>> -data-offset
>>> -=C2=A0=C2=A0=C2=A0 Offset of the data in a separate image store=2E Th=
e image store is placed
>>> -=C2=A0=C2=A0=C2=A0 immediately after the last byte of the device tree=
 binary, aligned to a
>>> -=C2=A0=C2=A0=C2=A0 4-byte boundary=2E This is mandatory if external d=
ata is used, with an offset=2E
>>> -
>>> -data-position
>>> -=C2=A0=C2=A0=C2=A0 Machine address at which the data is to be found=
=2E This is a fixed address
>>> -=C2=A0=C2=A0=C2=A0 not relative to the loading of the FIT=2E This is =
mandatory if external data
>>> -=C2=A0=C2=A0=C2=A0 used with a fixed address=2E
>>> -
>>> -os
>>> -=C2=A0=C2=A0=C2=A0 OS name, mandatory for types "kernel"=2E Valid OS =
names are:
>>> -
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -=C2=A0=C2=A0=C2=A0 OS name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Meaning
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -=C2=A0=C2=A0=C2=A0 invalid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Invalid OS
>>> -=C2=A0=C2=A0=C2=A0 4_4bsd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4_4BSD
>>> -=C2=A0=C2=A0=C2=A0 arm-trusted-firmware=C2=A0 ARM Trusted Firmware
>>> -=C2=A0=C2=A0=C2=A0 dell=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Dell
>>> -=C2=A0=C2=A0=C2=A0 efi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EFI Firmwar=
e
>>> -=C2=A0=C2=A0=C2=A0 esix=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Esix
>>> -=C2=A0=C2=A0=C2=A0 freebsd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FreeBSD
>>> -=C2=A0=C2=A0=C2=A0 integrity=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INTEGRITY
>>> -=C2=A0=C2=A0=C2=A0 irix=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Irix
>>> -=C2=A0=C2=A0=C2=A0 linux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Linux
>>> -=C2=A0=C2=A0=C2=A0 ncr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NCR
>>> -=C2=A0=C2=A0=C2=A0 netbsd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NetBSD
>>> -=C2=A0=C2=A0=C2=A0 openbsd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OpenBSD
>>> -=C2=A0=C2=A0=C2=A0 openrtos=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OpenRTOS
>>> -=C2=A0=C2=A0=C2=A0 opensbi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RISC-V OpenSBI
>>> -=C2=A0=C2=A0=C2=A0 ose=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enea OSE
>>> -=C2=A0=C2=A0=C2=A0 plan9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Plan 9
>>> -=C2=A0=C2=A0=C2=A0 psos=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pSOS
>>> -=C2=A0=C2=A0=C2=A0 qnx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QNX
>>> -=C2=A0=C2=A0=C2=A0 rtems=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RTEMS
>>> -=C2=A0=C2=A0=C2=A0 sco=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SCO
>>> -=C2=A0=C2=A0=C2=A0 solaris=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Solaris
>>> -=C2=A0=C2=A0=C2=A0 svr4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SVR4
>>> -=C2=A0=C2=A0=C2=A0 tee=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Trusted Exe=
cution Environment
>>> -=C2=A0=C2=A0=C2=A0 u-boot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 U-Boot
>>> -=C2=A0=C2=A0=C2=A0 vxworks=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VxWorks
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -
>>> -arch
>>> -=C2=A0=C2=A0=C2=A0 Architecture name, mandatory for types: "standalon=
e", "kernel",
>>> -=C2=A0=C2=A0=C2=A0 "firmware", "ramdisk" and "fdt"=2E Valid architect=
ure names are:
>>> -
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -=C2=A0=C2=A0=C2=A0 Architecture type=C2=A0=C2=A0=C2=A0=C2=A0 Meaning
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -=C2=A0=C2=A0=C2=A0 invalid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Invalid ARCH
>>> -=C2=A0=C2=A0=C2=A0 alpha=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Alpha
>>> -=C2=A0=C2=A0=C2=A0 arc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARC
>>> -=C2=A0=C2=A0=C2=A0 arm64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AArch64
>>> -=C2=A0=C2=A0=C2=A0 arm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM
>>> -=C2=A0=C2=A0=C2=A0 avr32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AVR32
>>> -=C2=A0=C2=A0=C2=A0 blackfin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Blackfin
>>> -=C2=A0=C2=A0=C2=A0 ia64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IA64
>>> -=C2=A0=C2=A0=C2=A0 m68k=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M68K
>>> -=C2=A0=C2=A0=C2=A0 microblaze=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 MicroBlaze
>>> -=C2=A0=C2=A0=C2=A0 mips64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIPS 64 Bit
>>> -=C2=A0=C2=A0=C2=A0 mips=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIPS
>>> -=C2=A0=C2=A0=C2=A0 nds32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NDS32
>>> -=C2=A0=C2=A0=C2=A0 nios2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NIOS II
>>> -=C2=A0=C2=A0=C2=A0 or1k=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OpenRISC 1000
>>> -=C2=A0=C2=A0=C2=A0 powerpc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PowerPC
>>> -=C2=A0=C2=A0=C2=A0 ppc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PowerPC
>>> -=C2=A0=C2=A0=C2=A0 riscv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RISC-V
>>> -=C2=A0=C2=A0=C2=A0 s390=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IBM S390
>>> -=C2=A0=C2=A0=C2=A0 sandbox=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Sandbox
>>> -=C2=A0=C2=A0=C2=A0 sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SuperH
>>> -=C2=A0=C2=A0=C2=A0 sparc64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPARC 64 Bit
>>> -=C2=A0=C2=A0=C2=A0 sparc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPARC
>>> -=C2=A0=C2=A0=C2=A0 x86_64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AMD x86_64
>>> -=C2=A0=C2=A0=C2=A0 x86=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Intel x86
>>> -=C2=A0=C2=A0=C2=A0 xtensa=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Xtensa
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> -
>>> -entry
>>> -=C2=A0=C2=A0=C2=A0 entry point address, address size is determined by
>>> -=C2=A0=C2=A0=C2=A0 '#address-cells' property of the root node=2E
>>> -=C2=A0=C2=A0=C2=A0 Mandatory for types: "firmware", and "kernel"=2E
>>> -
>>> -load
>>> -=C2=A0=C2=A0=C2=A0 load address, address size is determined by '#addr=
ess-cells'
>>> -=C2=A0=C2=A0=C2=A0 property of the root node=2E
>>> -=C2=A0=C2=A0=C2=A0 Mandatory for types: "firmware", and "kernel"=2E
>>> -
>>> -compatible
>>> -=C2=A0=C2=A0=C2=A0 compatible method for loading image=2E
>>> -=C2=A0=C2=A0=C2=A0 Mandatory for types: "fpga", and images that do no=
t specify a load address=2E
>>> -=C2=A0=C2=A0=C2=A0 Supported compatible methods:
>>> -
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>>> -=C2=A0=C2=A0=C2=A0 Compatible string=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Meaning
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>>> -=C2=A0=C2=A0=C2=A0 u-boot,fpga-legacy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Generic fpga loading routine=2E
>>> -=C2=A0=C2=A0=C2=A0 u-boot,zynqmp-fpga-ddrauth=C2=A0 Signed non-encryp=
ted FPGA bitstream for
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Xilinx Zynq UltraScale+ (ZymqMP)=
 device=2E
>>> -=C2=A0=C2=A0=C2=A0 u-boot,zynqmp-fpga-enc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Encrypted FPGA bitstream for Xilinx Zynq
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UltraScale+ (ZynqMP) device=2E
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>>> -
>>> -phase
>>> -=C2=A0=C2=A0=C2=A0 U-Boot phase for which the image is intended=2E
>>> -
>>> -=C2=A0=C2=A0=C2=A0 "spl"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image is an SPL image
>>> -
>>> -=C2=A0=C2=A0=C2=A0 "u-boot"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image is a U-Boot image
>>> -
>>> -Optional nodes:
>>> -
>>> -hash-1
>>> -=C2=A0=C2=A0=C2=A0 Each hash sub-node represents separate hash or che=
cksum
>>> -=C2=A0=C2=A0=C2=A0 calculated for node's data according to specified =
algorithm=2E
>>> -
>>> -signature-1
>>> -=C2=A0=C2=A0=C2=A0 Each signature sub-node represents separate signat=
ure
>>> -=C2=A0=C2=A0=C2=A0 calculated for node's data according to specified =
algorithm=2E
>>> -
>>> -
>>> -Hash nodes
>>> -----------
>>> -
>>> -::
>>> -
>>> -=C2=A0=C2=A0=C2=A0 o hash-1
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- algo =3D "hash or check=
sum algorithm name"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- value =3D [hash or chec=
ksum value]
>>> -
>>> -Mandatory properties
>>> -~~~~~~~~~~~~~~~~~~~~
>>> -
>>> -algo
>>> -=C2=A0=C2=A0=C2=A0 Algorithm name=2E Supported algoriths and their va=
lue sizes are:
>>> -
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>> -=C2=A0=C2=A0=C2=A0 Sub-image type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Size (bytes) Meaning
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>> -=C2=A0=C2=A0=C2=A0 crc16-ccitt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Cyclic Redundancy Check 16-bit
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (Consultative Committee for International
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Telegraphy and Telephony)
>>> -=C2=A0=C2=A0=C2=A0 crc32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Cyclic Redundancy Check 32-bit
>>> -=C2=A0=C2=A0=C2=A0 md5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Message Digest 5 (MD5)
>>> -=C2=A0=C2=A0=C2=A0 sha1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Secure Hash Algorithm 1 (SHA1)
>>> -=C2=A0=C2=A0=C2=A0 sha256=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Secure Hash Algorithm 2 (SHA256)
>>> -=C2=A0=C2=A0=C2=A0 sha384=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 48=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Secure Hash Algorithm 2 (SHA384)
>>> -=C2=A0=C2=A0=C2=A0 sha512=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Secure Hash Algorithm 2 (SHA512)
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>> -
>>> -value
>>> -=C2=A0=C2=A0=C2=A0 Actual checksum or hash value=2E
>>> -
>>> -Image-signature nodes
>>> ----------------------
>>> -
>>> -::
>>> -
>>> -=C2=A0=C2=A0=C2=A0 o signature-1
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- algo =3D "algorithm nam=
e"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- key-name-hint =3D "key =
name"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- value =3D [hash or chec=
ksum value]
>>> -
>>> -
>>> -Mandatory properties
>>> -~~~~~~~~~~~~~~~~~~~~
>>> -
>>> -_`FIT Algorithm`:
>>> -
>>> -algo
>>> -=C2=A0=C2=A0=C2=A0 Algorithm name=2E Supported algoriths and their va=
lue sizes are shown below=2E
>>> -=C2=A0=C2=A0=C2=A0 Note that the hash is specified separately from th=
e signing algorithm, so
>>> -=C2=A0=C2=A0=C2=A0 it is possible to mix and match any SHA algorithm =
with any signing
>>> -=C2=A0=C2=A0=C2=A0 algorithm=2E The size of the signature relates to =
the signing algorithm, not
>>> -=C2=A0=C2=A0=C2=A0 the hash, since it is the hash that is signed=2E
>>> -
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>> -=C2=A0=C2=A0=C2=A0 Sub-image type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Size (bytes) Meaning
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>> -=C2=A0=C2=A0=C2=A0 sha1,rsa2048=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 256=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SHA1=
 hash signed with 2048-bit
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Rivest=E2=80=93Shamir=E2=80=93Adleman algorithm
>>> -=C2=A0=C2=A0=C2=A0 sha1,rsa3072=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 384=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SHA1=
 hash signed with 2048-bit RSA
>>> -=C2=A0=C2=A0=C2=A0 sha1,rsa4096=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 512=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SHA1=
 hash signed with 2048-bit RSA
>>> -=C2=A0=C2=A0=C2=A0 sha1,ecdsa256=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SHA1 =
hash signed with 256-bit  Elliptic
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Curve Digital Signature Algorithm
>>> -=C2=A0=C2=A0=C2=A0 sha256,=2E=2E=2E
>>> -=C2=A0=C2=A0=C2=A0 sha384,=2E=2E=2E
>>> -=C2=A0=C2=A0=C2=A0 sha512,=2E=2E=2E
>>> -=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>> -
>>> -key-name-hint
>>> -=C2=A0=C2=A0=C2=A0 Name of key to use for signing=2E The keys will no=
rmally be in
>>> -=C2=A0=C2=A0=C2=A0 a single directory (parameter -k to mkimage)=2E Fo=
r a given key <name>, its
>>> -=C2=A0=C2=A0=C2=A0 private key is stored in <name>=2Ekey and the cert=
ificate is stored in
>>> -=C2=A0=C2=A0=C2=A0 <name>=2Ecrt=2E
>>> -
>>> -sign-images
>>> -=C2=A0=C2=A0=C2=A0 A list of images to sign, each being a property of=
 the conf
>>> -=C2=A0=C2=A0=C2=A0 node that contains then=2E The default is "kernel,=
fdt" which means that these
>>> -=C2=A0=C2=A0=C2=A0 two images will be looked up in the config and sig=
ned if present=2E This is
>>> -=C2=A0=C2=A0=C2=A0 used by mkimage to determine which images to sign=
=2E
>>> -
>>> -The following properies are added as part of signing, and are mandato=
ry:
>>> -
>>> -value
>>> -=C2=A0=C2=A0=C2=A0 Actual signature value=2E This is added by mkimage=
=2E
>>> -
>>> -hashed-nodes
>>> -=C2=A0=C2=A0=C2=A0 A list of nodes which were hashed by the signer=2E=
 Each is
>>> -=C2=A0=C2=A0=C2=A0 a string - the full path to node=2E A typical valu=
e might be::
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 hashed-nodes =3D "/", "/configurations/conf-=
1", "/images/kernel",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "/images/kernel/hash=
-1", "/images/fdt-1",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "/images/fdt-1/hash-=
1";
>>> -
>>> -hashed-strings
>>> -=C2=A0=C2=A0=C2=A0 The start and size of the string region of the FIT=
 that was hashed=2E The
>>> -=C2=A0=C2=A0=C2=A0 start is normally 0, indicating the first byte of =
the string table=2E The size
>>> -=C2=A0=C2=A0=C2=A0 indicates the number of bytes hashed as part of si=
gning=2E
>>> -
>>> -The following properies are added as part of signing, and are optiona=
l:
>>> -
>>> -timestamp
>>> -=C2=A0=C2=A0=C2=A0 Time when image was signed (standard Unix time_t f=
ormat)
>>> -
>>> -signer-name
>>> -=C2=A0=C2=A0=C2=A0 Name of the signer (e=2Eg=2E "mkimage")
>>> -
>>> -signer-version
>>> -=C2=A0=C2=A0=C2=A0 Version string of the signer (e=2Eg=2E "2013=2E01"=
)
>>> -
>>> -comment
>>> -=C2=A0=C2=A0=C2=A0 Additional information about the signer or image
>>> -
>>> -padding
>>> -=C2=A0=C2=A0=C2=A0 The padding algorithm, it may be pkcs-1=2E5 or pss=
,
>>> -=C2=A0=C2=A0=C2=A0 if no value is provided we assume pkcs-1=2E5
>>> -
>>> -
>>> -'/configurations' node
>>> -----------------------
>>> -
>>> -The 'configurations' node creates convenient, labeled boot configurat=
ions,
>>> -which combine together kernel images with their ramdisks and fdt blob=
s=2E
>>> -
>>> -The 'configurations' node has the following structure::
>>> -
>>> -=C2=A0=C2=A0=C2=A0 o configurations
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- default =3D "default co=
nfiguration sub-node unit name"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o config-1 {=2E=2E=2E}
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o config-2 {=2E=2E=2E}
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2E=2E=2E
>>> -
>>> -
>>> -Optional property
>>> -~~~~~~~~~~~~~~~~~
>>> -
>>> -default
>>> -=C2=A0=C2=A0=C2=A0 Selects one of the configuration sub-nodes as a de=
fault configuration=2E
>>> -
>>> -Mandatory nodes
>>> -~~~~~~~~~~~~~~~
>>> -
>>> -configuration-sub-node-unit-name
>>> -=C2=A0=C2=A0=C2=A0 At least one of the configuration sub-nodes is req=
uired=2E
>>> -
>>> -Optional nodes
>>> -~~~~~~~~~~~~~~
>>> -
>>> -signature-1
>>> -=C2=A0=C2=A0=C2=A0 Each signature sub-node represents separate signat=
ure
>>> -=C2=A0=C2=A0=C2=A0 calculated for the configuration according to spec=
ified algorithm=2E
>>> -
>>> -
>>> -Configuration nodes
>>> --------------------
>>> -
>>> -Each configuration has the following structure::
>>> -
>>> -=C2=A0=C2=A0=C2=A0 o config-1
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- description =3D "config=
uration description"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- kernel =3D "kernel sub-=
node unit name"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- fdt =3D "fdt sub-node u=
nit-name" [, "fdt overlay sub-node unit-name", =2E=2E=2E]
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- loadables =3D "loadable=
s sub-node unit-name"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- script =3D "
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- compatible =3D "vendor,=
board-style device tree compatible string"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o signature-1 {=2E=2E=2E}
>>> -
>>> -Mandatory properties
>>> -~~~~~~~~~~~~~~~~~~~~
>>> -
>>> -description
>>> -=C2=A0=C2=A0=C2=A0 Textual configuration description=2E
>>> -
>>> -kernel or firmware
>>> -=C2=A0=C2=A0=C2=A0 Unit name of the corresponding kernel or firmware
>>> -=C2=A0=C2=A0=C2=A0 (u-boot, op-tee, etc) image=2E If both "kernel" an=
d "firmware" are specified,
>>> -=C2=A0=C2=A0=C2=A0 control is passed to the firmware image=2E
>>> -
>>> -Optional properties
>>> -~~~~~~~~~~~~~~~~~~~
>>> -
>>> -fdt
>>> -=C2=A0=C2=A0=C2=A0 Unit name of the corresponding fdt blob (component=
 image node of a
>>> -=C2=A0=C2=A0=C2=A0 "fdt type")=2E Additional fdt overlay nodes can be=
 supplied which signify
>>> -=C2=A0=C2=A0=C2=A0 that the resulting device tree blob is generated b=
y the first base fdt
>>> -=C2=A0=C2=A0=C2=A0 blob with all subsequent overlays applied=2E
>>> -
>>> -fpga
>>> -=C2=A0=C2=A0=C2=A0 Unit name of the corresponding fpga bitstream blob
>>> -=C2=A0=C2=A0=C2=A0 (component image node of a "fpga type")=2E
>>> -
>>> -loadables
>>> -=C2=A0=C2=A0=C2=A0 Unit name containing a list of additional binaries=
 to be
>>> -=C2=A0=C2=A0=C2=A0 loaded at their given locations=2E=C2=A0 "loadable=
s" is a comma-separated list
>>> -=C2=A0=C2=A0=C2=A0 of strings=2E U-Boot will load each binary at its =
given start-address and
>>> -=C2=A0=C2=A0=C2=A0 may optionally invoke additional post-processing s=
teps on this binary based
>>> -=C2=A0=C2=A0=C2=A0 on its component image node type=2E
>>> -
>>> -script
>>> -=C2=A0=C2=A0=C2=A0 The image to use when loading a U-Boot script (for=
 use with the
>>> -=C2=A0=C2=A0=C2=A0 source command)=2E
>>> -
>>> -compatible
>>> -=C2=A0=C2=A0=C2=A0 The root compatible string of the U-Boot device tr=
ee that
>>> -=C2=A0=C2=A0=C2=A0 this configuration shall automatically match when =
CONFIG_FIT_BEST_MATCH is
>>> -=C2=A0=C2=A0=C2=A0 enabled=2E If this property is not provided, the c=
ompatible string will be
>>> -=C2=A0=C2=A0=C2=A0 extracted from the fdt blob instead=2E This is onl=
y possible if the fdt is
>>> -=C2=A0=C2=A0=C2=A0 not compressed, so images with compressed fdts tha=
t want to use compatible
>>> -=C2=A0=C2=A0=C2=A0 string matching must always provide this property=
=2E
>>> -
>>> -The FDT blob is required to properly boot FDT based kernel, so the mi=
nimal
>>> -configuration for 2=2E6 FDT kernel is (kernel, fdt) pair=2E
>>> -
>>> -Older, 2=2E4 kernel and 2=2E6 non-FDT kernel do not use FDT blob, in =
such cases
>>> -'struct bd_info' must be passed instead of FDT blob, thus fdt propert=
y *must
>>> -not* be specified in a configuration node=2E
>>> -
>>> -Configuration-signature nodes
>>> ------------------------------
>>> -
>>> -::
>>> -
>>> -=C2=A0=C2=A0=C2=A0 o signature-1
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- algo =3D "algorithm nam=
e"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- key-name-hint =3D "key =
name"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- sign-images =3D "path1"=
, "path2";
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- value =3D [hash or chec=
ksum value]
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |- hashed-strings =3D <0 l=
en>
>>> -
>>> -
>>> -Mandatory properties
>>> -~~~~~~~~~~~~~~~~~~~~
>>> -
>>> -algo
>>> -=C2=A0=C2=A0=C2=A0 See `FIT Algorithm`_=2E
>>> -
>>> -key-name-hint
>>> -=C2=A0=C2=A0=C2=A0 Name of key to use for signing=2E The keys will no=
rmally be in
>>> -=C2=A0=C2=A0=C2=A0 a single directory (parameter -k to mkimage)=2E Fo=
r a given key <name>, its
>>> -=C2=A0=C2=A0=C2=A0 private key is stored in <name>=2Ekey and the cert=
ificate is stored in
>>> -=C2=A0=C2=A0=C2=A0 <name>=2Ecrt=2E
>>> -
>>> -The following properies are added as part of signing, and are mandato=
ry:
>>> -
>>> -value
>>> -=C2=A0=C2=A0=C2=A0 Actual signature value=2E This is added by mkimage=
=2E
>>> -
>>> -The following properies are added as part of signing, and are optiona=
l:
>>> -
>>> -timestamp
>>> -=C2=A0=C2=A0=C2=A0 Time when image was signed (standard Unix time_t f=
ormat)
>>> -
>>> -signer-name
>>> -=C2=A0=C2=A0=C2=A0 Name of the signer (e=2Eg=2E "mkimage")
>>> -
>>> -signer-version
>>> -=C2=A0=C2=A0=C2=A0 Version string of the signer (e=2Eg=2E "2013=2E01"=
)
>>> -
>>> -comment
>>> -=C2=A0=C2=A0=C2=A0 Additional information about the signer or image
>>> -
>>> -padding
>>> -=C2=A0=C2=A0=C2=A0 The padding algorithm, it may be pkcs-1=2E5 or pss=
,
>>> -=C2=A0=C2=A0=C2=A0 if no value is provided we assume pkcs-1=2E5
>>> -
>>> -
>>> -
>>> -Examples
>>> ---------
>>> -
>>> -Some example files are available here, showing various scenarios
>>> -
>>> -=2E=2E toctree::
>>> -=C2=A0=C2=A0=C2=A0 :maxdepth: 1
>>> -
>>> -=C2=A0=C2=A0=C2=A0 kernel
>>> -=C2=A0=C2=A0=C2=A0 kernel_fdt
>>> -=C2=A0=C2=A0=C2=A0 kernel_fdts_compressed
>>> -=C2=A0=C2=A0=C2=A0 multi
>>> -=C2=A0=C2=A0=C2=A0 multi_spl
>>> -=C2=A0=C2=A0=C2=A0 multi-with-fpga
>>> -=C2=A0=C2=A0=C2=A0 multi-with-loadables
>>> -=C2=A0=C2=A0=C2=A0 sec_firmware_ppa
>>> -=C2=A0=C2=A0=C2=A0 sign-configs
>>> -=C2=A0=C2=A0=C2=A0 sign-images
>>> -=C2=A0=C2=A0=C2=A0 uefi
>>> -=C2=A0=C2=A0=C2=A0 update3
>>> -=C2=A0=C2=A0=C2=A0 update_uboot
>>> -
>>> -=2E=2E sectionauthor:: Marian Balakowicz <m8@semihalf=2Ecom>
>>> -=2E=2E sectionauthor:: External data additions, 25/1/16 Simon Glass <=
sjg@chromium=2Eorg>
>>> +FIT format documentation has been moved to
>>> +`a separate project <https://fitspec=2Eosfw=2Efoundation/>`_=2E Updat=
es to the
>>> +format/specification should be submitted there=2E
>>> \ No newline at end of file
>>=20
