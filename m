Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C14D7237B
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 12:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C49E83B85;
	Fri, 23 Jan 2026 13:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="eBGD8JPS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54FAC83B0B; Fri, 23 Jan 2026 11:48:10 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A6083AC5
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 11:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1769165204; x=1769770004; i=xypron.glpk@gmx.de;
 bh=vuxwfmpiqdFvnMw3BwEqnjDuQ1YuZAtR8H9/MZ8D5nI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=eBGD8JPS95yfMpaYK1zMYX2t5e8wPtFFYAdFq2hALGgoAxjGR6z0LVJjSmk9V5Dx
 JCj0KA1tEQs0aVDT1DbvG1r1S0NazwGWlDtD4Kp1KqhQGiszmapBs61yFlnMpRi98
 bziO5/8ZyMWq2VcKwZd9r0qlX+m8wnbYF9iBoR6HupfqyNABQf7z+6xZtRWwsc2f4
 +r4R9j2ai7xoHOXV6JLJpizVzG8xF7a9Ycs1x5HvgQasN5kt0kmF3eIIq5x5KkWhr
 ad7C5cScc0PSaq8NY5S4ca/EvdrHFMBgJP1mq9ztNorr4W3V6lAN/KxuA5ti2Rz9i
 ctzojYfP3pAWcsjrNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.127] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHMZ-1wBjp43VHd-00iYNf; Fri, 23
 Jan 2026 11:46:44 +0100
Message-ID: <1c4a839d-c26d-42e9-9940-a43c296a6e5a@gmx.de>
Date: Fri, 23 Jan 2026 11:46:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] spacemit: k1: support multi-board infrastructure
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Yixun Lan <dlan@gentoo.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Aniket Limaye <a-limaye@ti.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Samuel Holland <samuel@sholland.org>, Rui Miguel Silva
 <rui.silva@linaro.org>, Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Elaine Zhang <zhangqing@rock-chips.com>, u-boot@lists.denx.de
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <20260117190231.977686-2-raymondmaoca@gmail.com>
 <e5869a76-6c18-4146-9fd4-f1c367b96beb@gmx.de>
Content-Language: en-US
In-Reply-To: <e5869a76-6c18-4146-9fd4-f1c367b96beb@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i2110I25logqRYp8Qzwqaom4ObAYQvk31exM2SpAjlYB/rkvxcq
 A15KQsCzNpt5sZtos1Z7aYHZXK3JJoauHUeJRSUk+sdODNR1Orv3cuYWOIGlXViFVUl5uWt
 2X6alaYwqRR2LrT+ZCVIMveHiqi+dy9WAR4odJTX2iH/Fs+2ks5TflYFzWVNvLnPoOnyHWu
 ysMVubTznIhaJ/ZMz7i6Q==
UI-OutboundReport: notjunk:1;M01:P0:xSyNdn2Xe3g=;+fYh8H6rgHfXwJWT09MiffLAZh/
 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
X-Mailman-Approved-At: Fri, 23 Jan 2026 13:47:39 +0100
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

On 1/23/26 11:27, Heinrich Schuchardt wrote:
> On 1/17/26 20:01, Raymond Mao wrote:
>> From: Raymond Mao <raymond.mao@riscstar.com>
>>
>> Restructure K1 SoC support to handle multiple boards through a single
>> configuration:
>>
>> 1. Rename bananapi-f3_defconfig to k1_defconfig.
>> 2. Move all K1 board files to k1 directory.
>>
>> Eliminates the need for board-specific defconfigs while maintaining
>> hardware compatibility.
>>
>> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
>> ---
>> =C2=A0 arch/riscv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++----
>> =C2=A0 arch/riscv/cpu/k1/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
>> =C2=A0 board/spacemit/{bananapi-f3 =3D> k1}/Kconfig=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 11 ++++++++---
>> =C2=A0 board/spacemit/{bananapi-f3 =3D> k1}/MAINTAINERS=C2=A0 |=C2=A0 4=
 ++--
>> =C2=A0 board/spacemit/{bananapi-f3 =3D> k1}/Makefile=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 0
>> =C2=A0 board/spacemit/{bananapi-f3 =3D> k1}/board.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 0
>> =C2=A0 configs/{bananapi-f3_defconfig =3D> k1_defconfig} |=C2=A0 3 ++-

I would suggest add the vendor name and call this spacemit_k1_defconfig=20
to avoid ambiguity.

Best regards

Heinrich

>> =C2=A0 include/configs/{bananapi-f3.h =3D> k1.h}=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 0
>> =C2=A0 8 files changed, 22 insertions(+), 10 deletions(-)
>> =C2=A0 rename board/spacemit/{bananapi-f3 =3D> k1}/Kconfig (63%)
>> =C2=A0 rename board/spacemit/{bananapi-f3 =3D> k1}/MAINTAINERS (61%)
>> =C2=A0 rename board/spacemit/{bananapi-f3 =3D> k1}/Makefile (100%)
>> =C2=A0 rename board/spacemit/{bananapi-f3 =3D> k1}/board.c (100%)
>> =C2=A0 rename configs/{bananapi-f3_defconfig =3D> k1_defconfig} (97%)
>> =C2=A0 rename include/configs/{bananapi-f3.h =3D> k1.h} (100%)
>=20
> This changes in this patch look ok.
>=20
> But please, update doc/board/spacemit/bananapi-f3.rst to point to the=20
> new defconfig.
>=20
> Best regards
>=20
> Heinrich
>=20
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 79867656b15..ac50c1d7234 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -8,15 +8,17 @@ choice
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prompt "Target select"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 optional
>> +config ARCH_K1
>> +=C2=A0=C2=A0=C2=A0 bool "Spacemit K1 Architecture"
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This enables support for Spacemit K1 So=
C family.
>> +
>> =C2=A0 config TARGET_ANDES_AE350
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Support Andes ae350"
>> =C2=A0 config TARGET_ANDES_VOYAGER
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Support Andes Voyager Board"
>> -config TARGET_BANANAPI_F3
>> -=C2=A0=C2=A0=C2=A0 bool "Support BananaPi F3 Board"
>> -
>> =C2=A0 config TARGET_K230_CANMV
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Support K230 CanMV Board"
>> @@ -115,7 +117,7 @@ source "board/sifive/unmatched/Kconfig"
>> =C2=A0 source "board/sipeed/maix/Kconfig"
>> =C2=A0 source "board/sophgo/milkv_duo/Kconfig"
>> =C2=A0 source "board/sophgo/licheerv_nano/Kconfig"
>> -source "board/spacemit/bananapi-f3/Kconfig"
>> +source "board/spacemit/k1/Kconfig"
>> =C2=A0 source "board/starfive/visionfive2/Kconfig"
>> =C2=A0 source "board/thead/th1520_lpi4a/Kconfig"
>> =C2=A0 source "board/xilinx/mbv/Kconfig"
>> diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
>> index 14201df80f2..4b621158334 100644
>> --- a/arch/riscv/cpu/k1/Kconfig
>> +++ b/arch/riscv/cpu/k1/Kconfig
>> @@ -2,6 +2,8 @@
>> =C2=A0 #
>> =C2=A0 # Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
>> +if ARCH_K1
>> +
>> =C2=A0 config SPACEMIT_K1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select BINMAN
>> @@ -17,3 +19,5 @@ config SPACEMIT_K1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply SPL_CPU
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply SPL_OPENSBI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imply SPL_LOAD_FIT
>> +
>> +endif
>> diff --git a/board/spacemit/bananapi-f3/Kconfig b/board/spacemit/k1/=20
>> Kconfig
>> similarity index 63%
>> rename from board/spacemit/bananapi-f3/Kconfig
>> rename to board/spacemit/k1/Kconfig
>> index f89fa9af2c7..9f9c806d00d 100644
>> --- a/board/spacemit/bananapi-f3/Kconfig
>> +++ b/board/spacemit/k1/Kconfig
>> @@ -1,7 +1,7 @@
>> -if TARGET_BANANAPI_F3
>> +if ARCH_K1
>> =C2=A0 config SYS_BOARD
>> -=C2=A0=C2=A0=C2=A0 default "bananapi-f3"
>> +=C2=A0=C2=A0=C2=A0 default "k1"
>> =C2=A0 config SYS_VENDOR
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default "spacemit"
>> @@ -10,7 +10,7 @@ config SYS_CPU
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default "k1"
>> =C2=A0 config SYS_CONFIG_NAME
>> -=C2=A0=C2=A0=C2=A0 default "bananapi-f3"
>> +=C2=A0=C2=A0=C2=A0 default "k1"
>> =C2=A0 config TEXT_BASE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default 0x00200000
>> @@ -22,4 +22,9 @@ config BOARD_SPECIFIC_OPTIONS
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def_bool y
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SPACEMIT_K1
>> +config TARGET_BANANAPI_F3
>> +=C2=A0=C2=A0=C2=A0 bool "Support BananaPi F3 Board"
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BananaPi F3 board contains Spacemit K1 =
SoC.
>> +
>> =C2=A0 endif
>> diff --git a/board/spacemit/bananapi-f3/MAINTAINERS b/board/spacemit/=
=20
>> k1/MAINTAINERS
>> similarity index 61%
>> rename from board/spacemit/bananapi-f3/MAINTAINERS
>> rename to board/spacemit/k1/MAINTAINERS
>> index 131bad03181..bd476c32719 100644
>> --- a/board/spacemit/bananapi-f3/MAINTAINERS
>> +++ b/board/spacemit/k1/MAINTAINERS
>> @@ -1,6 +1,6 @@
>> =C2=A0 BananaPi F3
>> =C2=A0 M:=C2=A0=C2=A0=C2=A0 Huan Zhou <pericycle.cc@@gmail.com>
>> =C2=A0 S:=C2=A0=C2=A0=C2=A0 Maintained
>> -F:=C2=A0=C2=A0=C2=A0 board/spacemit/bananapi-f3/
>> -F:=C2=A0=C2=A0=C2=A0 configs/bananapi-f3_defconfig
>> +F:=C2=A0=C2=A0=C2=A0 board/spacemit/k1/
>> +F:=C2=A0=C2=A0=C2=A0 configs/k1_defconfig
>> =C2=A0 F:=C2=A0=C2=A0=C2=A0 doc/board/spacemit/bananapi-f3.rst
>> diff --git a/board/spacemit/bananapi-f3/Makefile b/board/spacemit/k1/=
=20
>> Makefile
>> similarity index 100%
>> rename from board/spacemit/bananapi-f3/Makefile
>> rename to board/spacemit/k1/Makefile
>> diff --git a/board/spacemit/bananapi-f3/board.c b/board/spacemit/k1/=20
>> board.c
>> similarity index 100%
>> rename from board/spacemit/bananapi-f3/board.c
>> rename to board/spacemit/k1/board.c
>> diff --git a/configs/bananapi-f3_defconfig b/configs/k1_defconfig
>> similarity index 97%
>> rename from configs/bananapi-f3_defconfig
>> rename to configs/k1_defconfig
>> index a726ce84775..0bdc3c800f0 100644
>> --- a/configs/bananapi-f3_defconfig
>> +++ b/configs/k1_defconfig
>> @@ -6,9 +6,10 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x1000000
>> =C2=A0 CONFIG_DEFAULT_DEVICE_TREE=3D"k1-bananapi-f3"
>> =C2=A0 CONFIG_SYS_BOOTM_LEN=3D0xa000000
>> =C2=A0 CONFIG_SYS_LOAD_ADDR=3D0x200000
>> -CONFIG_TARGET_BANANAPI_F3=3Dy
>> =C2=A0 CONFIG_ARCH_RV64I=3Dy
>> =C2=A0 CONFIG_RISCV_SMODE=3Dy
>> +CONFIG_ARCH_K1=3Dy
>> +CONFIG_TARGET_BANANAPI_F3=3Dy
>> =C2=A0 CONFIG_FIT=3Dy
>> =C2=A0 CONFIG_SUPPORT_RAW_INITRD=3Dy
>> =C2=A0 CONFIG_OF_BOARD_SETUP=3Dy
>> diff --git a/include/configs/bananapi-f3.h b/include/configs/k1.h
>> similarity index 100%
>> rename from include/configs/bananapi-f3.h
>> rename to include/configs/k1.h
>=20

