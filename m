Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98857FF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 19:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2E3184877;
	Wed, 29 Apr 2026 21:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iMhIPM5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CEBC848C2; Wed, 29 Apr 2026 21:52:34 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E5280086
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 21:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777492328; x=1778097128; i=xypron.glpk@gmx.de;
 bh=ddPRW7AShqNViUyFLNNoE4TCqS+padceUMUZLredg68=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=iMhIPM5eFi5oRavJQhznLSSDGjA8DS/tiVmwQ+ZGdpl1Wl32Dx3YHhZFtwXS+V4a
 OGA4hKELMONOhjbjc7Jp5mFo1euIcYrKb6aavrO7sAz7dHce5vDZcxENaTYgs7GE0
 4EU9JzC4Bnyp7ck51yi6CHHTwq6F8qot/P2SDozitFhu7Buo8Tf+/DKEwPvk3Gvc0
 xILf5dYkW8HVny1L9q3mQyervKvrxaVfFjgW97rhaY4+5wjrfjUc/uYC6WkvPTe+r
 edEfugfhyt4bGa1XuTi24k6fGKYewvQ/EAKDcxQLLxGXenI+ihNbtD2oaFXlM2Y4t
 19+RNPDtuGGj/Q9rXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oBx-1vORZS3hgL-013RlT; Wed, 29
 Apr 2026 21:52:08 +0200
Date: Wed, 29 Apr 2026 21:51:59 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Conor Dooley <conor@kernel.org>, Raymond Mao <raymondmaoca@gmail.com>
CC: u-boot@lists.denx.de, uboot@riscstar.com, u-boot-spacemit@groups.io,
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com,
 trini@konsulko.com, lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_16/16=5D_spacemit=3A_k1=3A_rename?=
 =?US-ASCII?Q?_device_tree_prefix_from_=22k1-=22_to_=22k1=5F=22?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260429-doorbell-envision-46acf9988b40@spud>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
 <20260422143112.1329478-17-raymondmaoca@gmail.com>
 <20260429-doorbell-envision-46acf9988b40@spud>
Message-ID: <D8727260-DAD0-43DB-89FB-8923B3034C03@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QXWaM8qHLZnu46hqcyKjzsP+BaUZK+pxPri+06j07rvdmgf6H+B
 NFhRO4Th1y0TL6e6oeiAD6c4KkS73GvC+ZY6pfNu1sV22ITUtBwpkboyZHPwlBJTlxHHDd6
 /dl2MOTL6DIg3jHE0h6j1gHfsx7EURYpGHqmlPJm+aMn2+2TOUzpIK5/+pMT34sQRImbHQw
 7KE/NMweSHc7xw4l7+law==
UI-OutboundReport: notjunk:1;M01:P0:m8DAeFxkjYI=;SWoiMB9/w4xZV8ea1JyhcPkLKQ9
 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
 uebYIQP8Af3ojUZ9/Xa+gubicTdWoIUN/dcw=
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

Am 29=2E April 2026 21:42:04 MESZ schrieb Conor Dooley <conor@kernel=2Eorg>=
:
>On Wed, Apr 22, 2026 at 10:31:12AM -0400, Raymond Mao wrote:
>> From: Raymond Mao <raymond=2Emao@riscstar=2Ecom>
>>=20
>> This change replaces the hyphen ("-") in the DTS prefix with an
>> underscore ("_") for consistency with other prefixes in the
>> Spacemit K1 SoC platform=2E
>
>Doesn't this inconsistency only exist because you added files that made
>it inconsistent? Using hyphens is the norm anyway, right?

The kernel uses hyphens=2E We should not deviate from Linux=2E In the long=
 term we want to use the upstream Linux device-trees in U-Boot=2E

Renaming in Linux should also be avoided=2E

Best regards

Heinrich

>
>>=20
>> Signed-off-by: Raymond Mao <raymond=2Emao@riscstar=2Ecom>
>> ---
>>  arch/riscv/dts/Makefile                                   | 2 +-
>>  arch/riscv/dts/{k1-bananapi-f3=2Edts =3D> k1_bananapi-f3=2Edts} | 2 +-
>>  arch/riscv/dts/{k1-muse-pi-pro=2Edts =3D> k1_muse-pi-pro=2Edts} | 0
>>  arch/riscv/dts/{k1-pinctrl=2Edtsi =3D> k1_pinctrl=2Edtsi}       | 0
>>  arch/riscv/dts/{k1-spl=2Edts =3D> k1_spl=2Edts}                 | 0
>>  board/spacemit/k1/spl=2Ec                                   | 2 +-
>>  configs/spacemit_k1_defconfig                             | 4 ++--
>>  7 files changed, 5 insertions(+), 5 deletions(-)
>>  rename arch/riscv/dts/{k1-bananapi-f3=2Edts =3D> k1_bananapi-f3=2Edts}=
 (99%)
>>  rename arch/riscv/dts/{k1-muse-pi-pro=2Edts =3D> k1_muse-pi-pro=2Edts}=
 (100%)
>>  rename arch/riscv/dts/{k1-pinctrl=2Edtsi =3D> k1_pinctrl=2Edtsi} (100%=
)
>>  rename arch/riscv/dts/{k1-spl=2Edts =3D> k1_spl=2Edts} (100%)
>>=20
>> diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
>> index 22b62e25d4d=2E=2E3827ff72215 100644
>> --- a/arch/riscv/dts/Makefile
>> +++ b/arch/riscv/dts/Makefile
>> @@ -9,7 +9,7 @@ dtb-$(CONFIG_TARGET_LICHEERV_NANO) +=3D sg2002-licheerv=
-nano-b=2Edtb
>>  dtb-$(CONFIG_TARGET_QEMU_VIRT) +=3D qemu-virt32=2Edtb qemu-virt64=2Edt=
b
>>  dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) +=3D openpiton-riscv64=2Edtb
>>  dtb-$(CONFIG_TARGET_SIPEED_MAIX) +=3D k210-maix-bit=2Edtb
>> -dtb-$(CONFIG_TARGET_SPACEMIT_K1) +=3D k1-bananapi-f3=2Edtb k1-muse-pi-=
pro=2Edtb k1-spl=2Edtb
>> +dtb-$(CONFIG_TARGET_SPACEMIT_K1) +=3D k1_bananapi-f3=2Edtb k1_muse-pi-=
pro=2Edtb k1_spl=2Edtb
>>  dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv32=2Edtb
>>  dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv64=2Edtb
>>  dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-binman=2Edtb
>> diff --git a/arch/riscv/dts/k1-bananapi-f3=2Edts b/arch/riscv/dts/k1_ba=
nanapi-f3=2Edts
>> similarity index 99%
>> rename from arch/riscv/dts/k1-bananapi-f3=2Edts
>> rename to arch/riscv/dts/k1_bananapi-f3=2Edts
>> index ea11029c182=2E=2Ebcb5be5f1bc 100644
>> --- a/arch/riscv/dts/k1-bananapi-f3=2Edts
>> +++ b/arch/riscv/dts/k1_bananapi-f3=2Edts
>> @@ -5,7 +5,7 @@
>> =20
>>  #include "k1=2Edtsi"
>>  #include "binman=2Edtsi"
>> -#include "k1-pinctrl=2Edtsi"
>> +#include "k1_pinctrl=2Edtsi"
>> =20
>>  / {
>>  	model =3D "Banana Pi BPI-F3";
>> diff --git a/arch/riscv/dts/k1-muse-pi-pro=2Edts b/arch/riscv/dts/k1_mu=
se-pi-pro=2Edts
>> similarity index 100%
>> rename from arch/riscv/dts/k1-muse-pi-pro=2Edts
>> rename to arch/riscv/dts/k1_muse-pi-pro=2Edts
>> diff --git a/arch/riscv/dts/k1-pinctrl=2Edtsi b/arch/riscv/dts/k1_pinct=
rl=2Edtsi
>> similarity index 100%
>> rename from arch/riscv/dts/k1-pinctrl=2Edtsi
>> rename to arch/riscv/dts/k1_pinctrl=2Edtsi
>> diff --git a/arch/riscv/dts/k1-spl=2Edts b/arch/riscv/dts/k1_spl=2Edts
>> similarity index 100%
>> rename from arch/riscv/dts/k1-spl=2Edts
>> rename to arch/riscv/dts/k1_spl=2Edts
>> diff --git a/board/spacemit/k1/spl=2Ec b/board/spacemit/k1/spl=2Ec
>> index 2556dfe047a=2E=2Eb8e1327dc57 100644
>> --- a/board/spacemit/k1/spl=2Ec
>> +++ b/board/spacemit/k1/spl=2Ec
>> @@ -374,7 +374,7 @@ int board_fit_config_name_match(const char *name)
>> =20
>>  	memset(fdt_name, 0, I2C_BUF_SIZE);
>>  	if (!strncmp(product_name, "k1-x_", 5)) {
>> -		snprintf(fdt_name, I2C_BUF_SIZE, "%s-%s", "k1",
>> +		snprintf(fdt_name, I2C_BUF_SIZE, "%s_%s", "k1",
>>  			 &product_name[5]);
>>  	}
>>  	for (i =3D 0; i < I2C_BUF_SIZE; i++) {
>> diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defcon=
fig
>> index 13f055cdf53=2E=2Eddd0c959c12 100644
>> --- a/configs/spacemit_k1_defconfig
>> +++ b/configs/spacemit_k1_defconfig
>> @@ -3,8 +3,8 @@ CONFIG_SYS_MALLOC_LEN=3D0x1000000
>>  CONFIG_NR_DRAM_BANKS=3D2
>>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x1000000
>> -CONFIG_DEFAULT_DEVICE_TREE=3D"k1-spl"
>> -CONFIG_OF_LIST=3D"k1-bananapi-f3 k1-muse-pi-pro"
>> +CONFIG_DEFAULT_DEVICE_TREE=3D"k1_spl"
>> +CONFIG_OF_LIST=3D"k1_bananapi-f3 k1_muse-pi-pro"
>>  CONFIG_SPL=3Dy
>>  CONFIG_SPL_TEXT_BASE=3D0xc0801000
>>  CONFIG_SPL_MAX_SIZE=3D0x33000
>> --=20
>> 2=2E25=2E1
>>=20

