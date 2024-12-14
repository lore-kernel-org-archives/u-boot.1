Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6E3E7716A
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 21:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FAFC80073;
	Sat, 14 Dec 2024 22:32:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="t347rmZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EB868007A; Sat, 14 Dec 2024 22:32:24 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3BE48006D
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 22:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734211910; x=1734816710; i=xypron.glpk@gmx.de;
 bh=P68xQtnoLLxsIhU9llwSW8tLDJOZnitoPbK6EW+zxKk=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=t347rmZS6LmWvd+EgruAheh4iIp5Avwe3u48HSgbEyNy/goxVmjy3dCSSByhT/nX
 6vdUKES0qJCn1Z3kdzqCpihGJrnClYpvedZtMrW8mnnzsE9tfybTPUXhRNabVlnut
 Vg/nCTbwL1J3XE4llIPgAf0WPvAoGvMxND+EEBMu52It3F3obTJITNhJB/K4XLST+
 MG8CEmTorlrxDNtidwPAnaSTqwETccPK6mEEYUNSrlyn+j0lWKW6NFt4Cic5ueyLV
 k/3zLCBz15oOiULiJqSAaM+4UMOKN2Gmkhajn1/IY8h5SjxkqKEKzWjF8MlCvFuTJ
 0K/CIGAhMJMA2DFdZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.106.118]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRMi-1tAMv410MW-00IaVU; Sat, 14
 Dec 2024 22:31:50 +0100
Date: Sat, 14 Dec 2024 22:31:40 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Huan Zhou <pericycle.cc@gmail.com>, u-boot@lists.denx.de
CC: Ben Dooks <ben.dooks@codethink.co.uk>,
 Marcel Ziswiler <marcel@ziswiler.com>, 
 Bin Meng <bmeng@tinylab.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Yixun Lan <dlan@gentoo.org>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 =?ISO-8859-1?Q?Jonas_Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Randolph <randolph@andestech.com>, 
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Yu Chien Peter Lin <peterlin@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Padmarao Begari <padmarao.begari@amd.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_2/2=5D_doc=3A_spacemit=3A_ban?=
 =?US-ASCII?Q?anapi=5Ff3=3A_document_Banana_Pi_F3_board?=
User-Agent: Thunderbird for Android
In-Reply-To: <20241214-pickup-bpif3-v7-2-d0cd91146f7b@gmail.com>
References: <20241214-pickup-bpif3-v7-0-d0cd91146f7b@gmail.com>
 <20241214-pickup-bpif3-v7-2-d0cd91146f7b@gmail.com>
Message-ID: <1D6B2290-5522-4456-BB2A-BE5392E28452@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9H2StIL2fQ42cNYVMiOK34LznfMJqa/TkF0eAbUVaPrd6ApOaoJ
 0zDbz17cXI8RryTcHt68tTkAp8gfUFKpbFZ02EGtHV/ekmanekM/sy43HOp5ZVZ7Q9vAwaR
 NV99BiYeEymLT84sAQVILvRpWexdubXwbQ7uSjQPIMqEl+DugGnkB1tfwn7L1E4oy6YUJyu
 k1EvTdkLWjOVyh6CEulYA==
UI-OutboundReport: notjunk:1;M01:P0:YM13z+cIues=;42J6Tir9FNfou2OHTVQCvUQ/t3c
 66pzm43nSrh/jRpFNjJr/Ru9N+SOcmxr9FBWtXm4fqyx9g57ZdhQx8kp9OJNxk2MlUY2Jzi90
 5zKQ0OTtlCg3xXa/a09YYRRG/M01SzxRfT8NyvFTTRH4mR6OzIrEWJ0qKJ3/2ZBua+ctC7AP4
 ZIOLArbKRec2gnh7tJpnjIRWgb7o6SIQxUZ1Yb0gfWonVaVrN7YAD/5Po1G7r3c+3wMMxeY+G
 EBgviDhz9JK8KekkLvuzyQsFH/+vhjFQqQlGeQprcfjG/5bKbbVV9vCuec+0GTLkd/HF7wQOC
 r8tcYiKm7AsUMv0ZBEwJqSsaeA9i54voea0rhXbRLOlFGorzISgaDJua5bzaRTQK6lz21U20j
 kp1dUpzrVZ2VJcLLde3XZS8tBqRRvir/+MY/4zVs8sbULyDzerL/0coq1ngEhqEt60XAZ2r66
 NlVp32Tf6h9u7ZTtWJXgtlTD9wcLP5D5nXisO5S5yMKcAaXBnKn12h3mWhjhxx7IfBTnqNdBN
 zqRl9GZvknQIZZBnGsVwRZ/5LjZQRnPQuLyOYCwV6fFob1DEDiQ4bcTev88Os/eImizQgujaJ
 pKtEcfjSrKLtcND3Tn6dteNux2HMGOQ+PsbA3zaAjULTBaGe8lKZGPbNZnlJCWgUMcpSWkjGv
 yWe2FhoHUYGxQP7JEsshU5qKsk0fbzgqg8ZwYb3bK84fLTqDbWFlGgDMNoIfYnpoPZVWYfS28
 d8Sr8hQI6V5sPRHc8aOJsndJuYLKN4PxyLyTLekvDaSZkbJeT5hlrAS0TV9xPMwMJdLnU3mEH
 QNO5qO/QtEqv0XKDjKnIxd6g81j7iidolml9EXpmBGFx4q6HEQDSE33Lc3unt7s1oUaMVRoaS
 M+lmOcW745OgJRPppq/OxBQLuQTtTiicbwx0Ll3hhNxCaYbArEl09C7D1EFbTjEmVKSWYHOc8
 xiTxi2gDgeJjgBTc0xac4lxO2VjUICk+a5PWw+3E6ekBstuyzP5LV05zMZDgqH/GoHbhUASRq
 3UDqsdMCaza12UTzZNMN/rWKHeFZze7c52XK1pkM46Q4qK/p0ej3MKUOnO+SwJn/onaALX3G/
 uqaYJ/xSQbQug/8hxCPw0V57fxg4hHQuTEXqCHlXDzgMEopinSutJb8S64/WoJ/mu1+x4IV+s
 =
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

Am 14=2E Dezember 2024 08:30:22 MEZ schrieb Huan Zhou <pericycle=2Ecc@gmail=
=2Ecom>:
>From: Kongyang Liu <seashell11234455@gmail=2Ecom>
>
>Add document for Banana Pi F3 board which based on SpacemiT's K1 SoC=2E
>
>Signed-off-by: Kongyang Liu <seashell11234455@gmail=2Ecom>
>Signed-off-by: Huan Zhou <pericycle=2Ecc@gmail=2Ecom>
>Tested-by: Marcel Ziswiler <marcel@ziswiler=2Ecom>
>Reviewed-by: Yixun Lan <dlan@gentoo=2Eorg>
>---
> doc/board/index=2Erst                |   1 +
> doc/board/spacemit/bananapi-f3=2Erst | 106 +++++++++++++++++++++++++++++=
++++++++
> doc/board/spacemit/index=2Erst       |   9 ++++
> 3 files changed, 116 insertions(+)
>
>diff --git a/doc/board/index=2Erst b/doc/board/index=2Erst
>index b54c1748d57ece029f0f3ab829956dc893e7f5d7=2E=2Eb1c470eb2cbb1c07f907e=
b2282039520c219c72a 100644
>--- a/doc/board/index=2Erst
>+++ b/doc/board/index=2Erst
>@@ -55,6 +55,7 @@ Board-specific doc
>    sipeed/index
>    socionext/index
>    sophgo/index
>+   spacemit/index
>    st/index
>    starfive/index
>    ste/index
>diff --git a/doc/board/spacemit/bananapi-f3=2Erst b/doc/board/spacemit/ba=
nanapi-f3=2Erst
>new file mode 100644
>index 0000000000000000000000000000000000000000=2E=2E54b412775e458ee7a8cd4=
36d7a1f1c6ac70744f6
>--- /dev/null
>+++ b/doc/board/spacemit/bananapi-f3=2Erst
>@@ -0,0 +1,106 @@
>+=2E=2E SPDX-License-Identifier: GPL-2=2E0-or-later
>+
>+Banana Pi BPI-F3
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+Building
>+~~~~~~~~
>+1=2E Install the spacemit riscv cross compile toolchain_, or skip it if =
riscv toolchain is installed=2E

Thanks a lot for providing the documentation=2E Just some nits:

%/spacemit/SpacemiT/

>+
>+=2E=2E _toolchain: https://archive=2Espacemit=2Ecom/toolchain/
>+
>+2=2E Setup cross compilation environment variable:
>+
>+=2E=2E code-block:: console
>+
>+   export CROSS_COMPILE=3D<riscv64 toolchain prefix, e=2Eg /opt/spacemit=
/bin/riscv64-unknown-linux-gnu->
>+
>+3=2E Before building U-Boot, OpenSBI should be built first=2E OpenSBI ca=
n be
>+built for SpacemiT K1 SoC as below:
>+
>+=2E=2E code-block:: console
>+
>+   git clone https://github=2Ecom/cyyself/opensbi -b k1-opensbi
>+   cd opensbi
>+   make PLATFORM=3Dgeneric
>+
>+4=2E Then build U-Boot as following:
>+
>+=2E=2E code-block:: console
>+
>+   cd <U-Boot-dir>
>+   make bananapi-f3_defconfig
>+   make OPENSBI=3D<OpenSBI-dir>/build/platform/generic/firmware/fw_dynam=
ic=2Ebin
>+
>+This will generate u-boot=2Eitb
>+
>+Burning
>+~~~~~~~~
>+Actually, we can replace the uboot part

%s/part/partition/

 from bianbu linux which is the bsp_ to

%s/from bianbu linux/of Bianbu Linux/

Bianbu Linux may be a part of the board support package but it is not the =
complete BSP=2E So how about:

which is provided as part of the BSP

 validate  patch,
>+use `balena etcher` to burn the bianbu-minimal=2Eimg to the sd card,
>+and replace the /dev/sdx4 where places the uboot_ with the `u-boot=2Eitb=
` generated from this patch=2E
>+Or use fastboot:
>+Collect FSBL=2Ebin, u-boot=2Eitb, partition_2M=2Ejson, bootinfo_spinor=
=2Ebin
>+u-boot-env-default=2Ebin, fw_dynamic=2Eitb from vendor sdk

%s/sdk/SDK/

Best regards

Heinrich

>+
>+=2E=2E code-block:: console
>+
>+   fastboot stage FSBL=2Ebin
>+   fastboot continue
>+   fastboot stage u-boot=2Eitb-vendor # the itb from vendor uboot
>+   fastboot continue
>+
>+   fastboot flash mtd partition_2M=2Ejson
>+   fastboot flash bootinfo bootinfo_spinor=2Ebin
>+   fastboot flash fsbl FSBL=2Ebin
>+   fastboot flash env u-boot-env-default=2Ebin
>+   fastboot flash opensbi fw_dynamic=2Eitb
>+
>+   fastboot flash uboot u-boot=2Eitb-mainline # the itb from mainline ub=
oot
>+
>+=2E=2E _bsp: https://archive=2Espacemit=2Ecom/image/k1/version/bianbu/v2=
=2E0/
>+=2E=2E _uboot: https://bianbu-linux=2Espacemit=2Ecom/en/device/boot#21-f=
irmware-layout
>+
>+Booting
>+~~~~~~~
>+Sample boot log from Banana Pi BPI-F3 board
>+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>+=2E=2E code-block:: none
>+
>+   try sd=2E=2E=2E
>+   bm:3
>+   j=2E=2E=2E
>+
>+   U-Boot SPL 2022=2E10spacemit-dirty (Oct 21 2024 - 09:01:13 +0000)
>+   [   0=2E279] DDR type LPDDR4X
>+   [   0=2E292] lpddr4_silicon_init consume 13ms
>+   [   0=2E293] Change DDR data rate to 2400MT/s
>+   [   0=2E430] ## Checking hash(es) for config conf-1 =2E=2E=2E OK
>+   [   0=2E432] ## Checking hash(es) for Image opensbi =2E=2E=2E OK
>+   [   0=2E437] ## Checking hash(es) for Image uboot =2E=2E=2E OK
>+   [   0=2E443] ## Checking hash(es) for Image fdt-1 =2E=2E=2E OK
>+   [   0=2E488] ## Checking hash(es) for config config_1 =2E=2E=2E OK
>+   [   0=2E490] ## Checking hash(es) for Image opensbi =2E=2E=2E crc32+ =
OK
>+
>+
>+   U-Boot 2024=2E10-rc4-00462-g5b138cfcc587-dirty (Nov 28 2024 - 14:56:4=
9 +0800)
>+
>+   DRAM:  4 GiB
>+   Core:  19 devices, 8 uclasses, devicetree: separate
>+   Loading Environment from nowhere=2E=2E=2E OK
>+   In:    serial@d4017000
>+   Out:   serial@d4017000
>+   Err:   serial@d4017000
>+   Net:   No ethernet found=2E
>+   =3D> cpu list
>+   0: cpu@0      spacemit,x60
>+   1: cpu@1      spacemit,x60
>+   2: cpu@2      spacemit,x60
>+   3: cpu@3      spacemit,x60
>+   4: cpu@4      spacemit,x60
>+   5: cpu@5      spacemit,x60
>+   6: cpu@6      spacemit,x60
>+   7: cpu@7      spacemit,x60
>+   =3D> test
>+   =3D>
>+
>diff --git a/doc/board/spacemit/index=2Erst b/doc/board/spacemit/index=2E=
rst
>new file mode 100644
>index 0000000000000000000000000000000000000000=2E=2Ee7d3d94e4599fbeb8da16=
c8a837e777a0be06227
>--- /dev/null
>+++ b/doc/board/spacemit/index=2Erst
>@@ -0,0 +1,9 @@
>+=2E=2E SPDX-License-Identifier: GPL-2=2E0-or-later
>+
>+SpacemiT
>+=3D=3D=3D=3D=3D=3D=3D=3D
>+=2E=2E toctree::
>+   :maxdepth: 1
>+
>+   bananapi-f3
>+
>

