Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8FBEE3F20
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 20:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0649C86D90;
	Tue, 12 Sep 2023 22:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UYABg3jR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E993086E1C; Tue, 12 Sep 2023 22:01:39 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 654D886583
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 22:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694548879; x=1695153679; i=xypron.glpk@gmx.de;
 bh=cbe+X3+vGt81+tA7Afc0l6t4U0AdfjpqAyTKWbvaiBU=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
 b=UYABg3jRXq34N3nEo3V6O5miriK5RQ2qEFaUWfZc8UQZdId0lXkksCyYF/kC701ysqT7XBC
 tDceX9p1pIHbXUtIzjmQss8K7ZNbYw8OtUlVuuj2KsVNifEV93oEgwD6EFjoH+QLJS+3lH6CJ
 s2JOCYRZ8nlrnv/4IyJyxYdxw4gOSyuPzQv5IAlYfTD6PApgfWLM4TypqpVyjfYw5TKvzbEnD
 qIOhQVH5C06n6/1qepuHDbZFPz2fRLgv+AgIycxubQVA1Tz4k7rkf+Q/3mWW54ujcPFntwigD
 knPOE08+t207WLnZW++ymeQxtqGIfAYSEQAfgh4mSSPpHBGGRnSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([89.15.239.144]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9X9-1qpGG52zDN-0099qp; Tue, 12
 Sep 2023 22:01:19 +0200
Date: Tue, 12 Sep 2023 22:01:11 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "ralph.siemsen@linaro.org" <ralph.siemsen@linaro.org>,
 "nm@ti.com" <nm@ti.com>, "j-kacines@ti.com" <j-kacines@ti.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "n-francis@ti.com" <n-francis@ti.com>, "kamlesh@ti.com" <kamlesh@ti.com>,
 "afd@ti.com" <afd@ti.com>, "a-nandan@ti.com" <a-nandan@ti.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>, "lukma@denx.de" <lukma@denx.de>,
 "hnagalla@ti.com" <hnagalla@ti.com>, "a-bhatia1@ti.com" <a-bhatia1@ti.com>,
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "j-choudhary@ti.com" <j-choudhary@ti.com>,
 "yanhong.wang@starfivetech.com" <yanhong.wang@starfivetech.com>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "sabiya.d@ti.com" <sabiya.d@ti.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "bb@ti.com" <bb@ti.com>, "rogerq@kernel.org" <rogerq@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_16/16=5D_doc=3A_board=3A_ti=3A_k3=3A?=
 =?US-ASCII?Q?_Add_J784S4_EVM_and_AM69_SK_documentation?=
User-Agent: K-9 Mail for Android
In-Reply-To: <85368ccfa5520241ba7575222e1cf080c1dff986.camel@toradex.com>
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-17-a-nandan@ti.com>
 <85368ccfa5520241ba7575222e1cf080c1dff986.camel@toradex.com>
Message-ID: <3D25A508-4268-4C81-BAD3-B933C1D762A7@gmx.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:7IVM+nTWPMbSbUpKdHftlrAS0VTaWeXCsQzipGezAmZK5kqittN
 D+RCOcZWFcfr1wNryV3doGYLVZt+m6ufewl0XIuoAxaNoGqAbhTQgQNMNZ6dDDIm7rBApw5
 EVkCEhTuArxcdp0M6asUL4xm7XPvsvYL846kjGECgxdhrHnR4rgjkLmLkkWmdafHamO3GBL
 YfDTJ5FGjEk3skTICz5jA==
UI-OutboundReport: notjunk:1;M01:P0:FaLH0EiPWSw=;9dIpFZVtJJA3qfLSR6QbkVWT8uO
 YrM/cJasj/N+mMKANwlfzbSlonyz64Jm7DHCPWQqT3G3G0KDG3ENMO6dSEeoxvNU+aTL29UdL
 NZyAylCr1Dx9GV1gQ93K3pB9+31YRhckvdwkjQf57hdJCae1uH6Fj5U0t381MStT6s3DuDDR4
 Aby2xucfXEGbRhFkVuwIVJ5a7j+eYcTvD7Ul8K2jEBIO9Ad1AYSRv+xaez0GCn2arcn/3SG71
 yKHuzt8XJ2sfF46tKkmQIg31hZ4xwImCaj63K7+dvddGPCs5nQrocypaeUp+KBixQu/31hSTT
 YekXWS9yQNR6YolJ/rrQPDlDaBCFnYpcIBxObzoah2NqCB+GqrcN3O3iTAFqWbuIN9ecV1xRO
 66jpx11J1JRt67czQWyvLEXMejwGRyHSbvljlFuFMRIQhcfGnnuHukCc9svMdACkNSBP4vSYX
 jJaIBCszVhqv45VC48cfTdsOPteRKYJNyOwLOYxcIlHUeZTa55B/hU2OuUFYfywmc1DCErw2R
 G7H4pZ/6Ejkn10uAOsx6bhGhsEXTIQ+/t0M5BNtDWRhAsap9WE2FEfGiVK0kXuoMcs/n73m3b
 45m1FuZiCZJqHWkBvsNjxaIBL4s3UFnd0ui/uVube3gPJ/xRdI+gY26mtf8fRGEXXgu9XfUBS
 hdbamHV+Zu+OhjwoCh9RAIS/h71zm5ezGomNNTvMOeWrcv03qTxQ8YeNcSz806jTYiJcKWuWJ
 re+uQBg6q35HUUb/mcnvdo6GSpNUMF+UFH1bZOEQIOyWKCe1i5GkmK3kg95yjVFV94yDvfoLj
 jyMSUGkZi0cIFA3OP1mmSJdBPTBz2BI+1mMAgIwbDjzOy3Gim9ZJIvbVr5uzdKUr6Ufb5R/gL
 y7sbT9MyHsgFb0YYeb8M7sRKqg3L/HP2aIpu/PeSNpHYwBWuF5raY42GDCfrqPKqS7ax8q8I6
 zpSOwRy6rRvv4qGiGTlClKhG23o=
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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



Am 12=2E September 2023 14:50:35 MESZ schrieb Marcel Ziswiler <marcel=2Ezi=
swiler@toradex=2Ecom>:
>On Fri, 2023-09-08 at 16:35 +0530, Apurva Nandan wrote:
>> TI K3 J784S4 and AM69 SK are new additions to the K3 SoC family=2E
>> Add documentation about the J784S4 EVM and AM69 SK=2E
>>=20
>> Signed-off-by: Dasnavis Sabiya <sabiya=2Ed@ti=2Ecom>
>> Signed-off-by: Apurva Nandan <a-nandan@ti=2Ecom>
>> ---
>> =C2=A0board/ti/j784s4/MAINTAINERS |=C2=A0=C2=A0 1 +
>> =C2=A0doc/board/ti/j784s4_evm=2Erst | 339 +++++++++++++++++++++++++++++=
+++++++
>> =C2=A0doc/board/ti/k3=2Erst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A03 files changed, 341 insertions(+)
>> =C2=A0create mode 100644 doc/board/ti/j784s4_evm=2Erst
>>=20
>> diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
>> index 7d3549dd31=2E=2Ebe2f9a04b7 100644
>> --- a/board/ti/j784s4/MAINTAINERS
>> +++ b/board/ti/j784s4/MAINTAINERS
>> @@ -18,3 +18,4 @@ F:=C2=A0=C2=A0=C2=A0=C2=A0arch/arm/dts/k3-j784s4-ddr-=
evm-lp4-4266=2Edtsi
>> =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch/arm/dts/k3-am69-sk=2Edts
>> =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch/arm/dts/k3-am69-sk-u-boot=2E=
dtsi
>> =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch/arm/dts/k3-am69-r5-sk=2Edts
>> +F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0doc/board/ti/j784s4_evm=2Erst
>> diff --git a/doc/board/ti/j784s4_evm=2Erst b/doc/board/ti/j784s4_evm=2E=
rst
>> new file mode 100644
>> index 0000000000=2E=2E1e2b7f3820
>> --- /dev/null
>> +++ b/doc/board/ti/j784s4_evm=2Erst
>> @@ -0,0 +1,339 @@
>> +=2E=2E SPDX-License-Identifier: GPL-2=2E0+ OR BSD-3-Clause
>
>Should be:
>
>GPL-2=2E0-or-later OR BSD-3-Clause
>
>> +=2E=2E sectionauthor:: Apurva Nandan <a-nandan@ti=2Ecom>
>> +
>> +J784S4 and AM69 Platforms
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> +
>> +Introduction:
>> +-------------
>> +The J784S4 SoC belongs to the K3 Multicore SoC architecture
>> +platform, providing advanced system integration in automotive,
>> +ADAS and industrial applications requiring AI at the network edge=2E
>> +This SoC extends the K3 Jacinto 7 family of SoCs with focus on
>> +raising performance and integration while providing interfaces,
>> +memory architecture and compute performance for multi-sensor, high
>> +concurrency applications=2E
>> +
>> +The device is partitioned into three functional domains, each containi=
ng
>> +specific processing cores and peripherals:
>> +
>> +1=2E Wake-up (WKUP) domain:
>> +=C2=A0=C2=A0=C2=A0 * ARM Cortex-M4F processor, runs TI Foundational Se=
curity (TIFS)
>> +
>> +2=2E Microcontroller (MCU) domain:
>> +=C2=A0=C2=A0=C2=A0 * Dual core ARM Cortex-R5F processor, runs device m=
anagement
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and SoC early boot
>> +
>> +3=2E MAIN domain:
>> +=C2=A0=C2=A0=C2=A0 * Dual core 64-bit ARM Cortex-A72, runs HLOS
>> +
>> +More info can be found in TRM: http://www=2Eti=2Ecom/lit/zip/spruj52
>> +
>> +Platform information:
>> +
>> +* https://www=2Eti=2Ecom/tool/J784S4XEVM
>> +* https://www=2Eti=2Ecom/tool/SK-AM69
>> +
>> +Boot Flow:
>> +----------
>> +Below is the pictorial representation of boot flow:
>> +
>> +=2E=2E image:: img/boot_diagram_k3_current=2Esvg
>> +
>> +- On this platform, "TI Foundational Security (TIFS)" functions as the
>> +=C2=A0 security enclave master=2E While "Device Manager (DM)", also kn=
own as the
>> +=C2=A0 "TISCI server" in TI terminology, offers all the essential serv=
ices=2E
>> +
>> +- As illustrated in the diagram above, R5 SPL manages power and clock
>> +=C2=A0 services independently before handing over control to DM=2E The=
 A72 or
>> +=C2=A0 the C7x (Aux core) software components request TIFS/DM to handl=
e
>> +=C2=A0 security or device management services=2E
>> +
>> +Sources:
>> +--------

Thanks for providing this documentation=2E

Just nits below=2E

Colons ':' are not needed for headings

>> +
>> +=2E=2E include::=C2=A0 k3=2Erst
>> +=C2=A0=C2=A0=C2=A0 :start-after: =2E=2E k3_rst_include_start_boot_sour=
ces
>> +=C2=A0=C2=A0=C2=A0 :end-before: =2E=2E k3_rst_include_end_boot_sources
>> +
>> +Build procedure:
>> +----------------
>> +0=2E Setup the environment variables:
>> +
>> +=2E=2E include::=C2=A0 k3=2Erst
>> +=C2=A0=C2=A0=C2=A0 :start-after: =2E=2E k3_rst_include_start_common_en=
v_vars_desc
>> +=C2=A0=C2=A0=C2=A0 :end-before: =2E=2E k3_rst_include_end_common_env_v=
ars_desc
>> +
>> +=2E=2E include::=C2=A0 k3=2Erst
>> +=C2=A0=C2=A0=C2=A0 :start-after: =2E=2E k3_rst_include_start_board_env=
_vars_desc
>> +=C2=A0=C2=A0=C2=A0 :end-before: =2E=2E k3_rst_include_end_board_env_va=
rs_desc
>> +
>> +Set the variables corresponding to this platform:
>> +
>> +=2E=2E include::=C2=A0 k3=2Erst
>> +=C2=A0=C2=A0=C2=A0 :start-after: =2E=2E k3_rst_include_start_common_en=
v_vars_defn
>> +=C2=A0=C2=A0=C2=A0 :end-before: =2E=2E k3_rst_include_end_common_env_v=
ars_defn
>> +=2E=2E code-block:: bash
>> +
>> + $ export UBOOT_CFG_CORTEXR=3Dj784s4_evm_r5_defconfig
>> + $ export UBOOT_CFG_CORTEXA=3Dj784s4_evm_a72_defconfig
>> + $ export TFA_BOARD=3Dgeneric
>> + $ export TFA_EXTRA_ARGS=3D"K3_USART=3D0x8"
>> + $ export OPTEE_PLATFORM=3Dk3-j784s4
>> + $ export OPTEE_EXTRA_ARGS=3D"CFG_CONSOLE_UART=3D0x8"
>> +
>> +=2E=2E j784s4_evm_rst_include_start_build_steps
>> +
>> +1=2E Trusted Firmware-A:
>> +
>> +=2E=2E include::=C2=A0 k3=2Erst
>> +=C2=A0=C2=A0=C2=A0 :start-after: =2E=2E k3_rst_include_start_build_ste=
ps_tfa
>> +=C2=A0=C2=A0=C2=A0 :end-before: =2E=2E k3_rst_include_end_build_steps_=
tfa
>> +
>> +
>> +2=2E OP-TEE:
>> +
>> +=2E=2E include::=C2=A0 k3=2Erst
>> +=C2=A0=C2=A0=C2=A0 :start-after: =2E=2E k3_rst_include_start_build_ste=
ps_optee
>> +=C2=A0=C2=A0=C2=A0 :end-before: =2E=2E k3_rst_include_end_build_steps_=
optee
>> +
>> +3=2E U-Boot:
>> +
>> +=2E=2E _j784s4_evm_rst_u_boot_r5:
>> +
>> +* 3=2E1 R5:
>> +
>> +=2E=2E include::=C2=A0 k3=2Erst
>> +=C2=A0=C2=A0=C2=A0 :start-after: =2E=2E k3_rst_include_start_build_ste=
ps_spl_r5
>> +=C2=A0=C2=A0=C2=A0 :end-before: =2E=2E k3_rst_include_end_build_steps_=
spl_r5
>> +
>> +=2E=2E _j784s4_evm_rst_u_boot_a72:
>> +
>> +* 3=2E2 A72:
>> +
>> +=2E=2E include::=C2=A0 k3=2Erst
>> +=C2=A0=C2=A0=C2=A0 :start-after: =2E=2E k3_rst_include_start_build_ste=
ps_uboot
>> +=C2=A0=C2=A0=C2=A0 :end-before: =2E=2E k3_rst_include_end_build_steps_=
uboot
>> +=2E=2E j784s4_evm_rst_include_end_build_steps
>> +
>> +Target Images
>> +--------------

The length of the underline should match the heading to avoid build warnin=
gs=2E

Best regards

Heinrich


>> +In order to boot we need tiboot3=2Ebin, tispl=2Ebin and u-boot=2Eimg=
=2E Each SoC
>> +variant (GP, HS-FS, HS-SE) requires a different source for these files=
=2E
>> +
>> + - GP
>> +
>> +=C2=A0=C2=A0=C2=A0 * tiboot3-j784s4-gp-evm=2Ebin from :ref:`step 3=2E1=
 <j784s4_evm_rst_u_boot_r5>`
>> +=C2=A0=C2=A0=C2=A0 * tispl=2Ebin_unsigned, u-boot=2Eimg_unsigned from =
:ref:`step 3=2E2 <j784s4_evm_rst_u_boot_a72>`
>> +
>> + - HS-FS
>> +
>> +=C2=A0=C2=A0=C2=A0 * tiboot3-j784s4-hs-fs-evm=2Ebin from :ref:`step 3=
=2E1 <j784s4_evm_rst_u_boot_r5>`
>> +=C2=A0=C2=A0=C2=A0 * tispl=2Ebin, u-boot=2Eimg from :ref:`step 3=2E2 <=
j784s4_evm_rst_u_boot_a72>`
>> +
>> + - HS-SE
>> +
>> +=C2=A0=C2=A0=C2=A0 * tiboot3-j784s4-hs-evm=2Ebin from :ref:`step 3=2E1=
 <j784s4_evm_rst_u_boot_r5>`
>> +=C2=A0=C2=A0=C2=A0 * tispl=2Ebin, u-boot=2Eimg from :ref:`step 3=2E2 <=
j784s4_evm_rst_u_boot_a72>`
>> +
>> +Image formats:
>> +--------------
>> +
>> +- tiboot3=2Ebin
>> +
>> +=2E=2E image:: img/multi_cert_tiboot3=2Ebin=2Esvg
>> +
>> +- tispl=2Ebin
>> +
>> +=2E=2E image:: img/dm_tispl=2Ebin=2Esvg
>> +
>> +R5 Memory Map:
>> +--------------
>> +
>> +=2E=2E list-table::
>> +=C2=A0=C2=A0 :widths: 16 16 16
>> +=C2=A0=C2=A0 :header-rows: 1
>> +
>> +=C2=A0=C2=A0 * - Region
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - Start Address
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - End Address
>> +
>> +=C2=A0=C2=A0 * - SPL
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41c00000
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41c40000
>> +
>> +=C2=A0=C2=A0 * - EMPTY
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41c40000
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41c61f20
>> +
>> +=C2=A0=C2=A0 * - STACK
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41c65f20
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41c61f20
>> +
>> +=C2=A0=C2=A0 * - Global data
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41c65f20
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41c66000
>> +
>> +=C2=A0=C2=A0 * - Heap
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41c66000
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41c76000
>> +
>> +=C2=A0=C2=A0 * - BSS
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41c76000
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41c80000
>> +
>> +=C2=A0=C2=A0 * - DM DATA
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41c80000
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41c84130
>> +
>> +=C2=A0=C2=A0 * - EMPTY
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41c84130
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41cff9fc
>> +
>> +=C2=A0=C2=A0 * - MCU Scratchpad
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41cff9fc
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41cffbfc
>> +
>> +=C2=A0=C2=A0 * - ROM DATA
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41cffbfc
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0x41cfffff
>> +
>> +Switch Setting for Boot Mode
>> +----------------------------
>> +
>> +Boot Mode pins provide means to select the boot mode and options befor=
e the
>> +device is powered up=2E After every POR, they are the main source to p=
opulate
>> +the Boot Parameter Tables=2E
>> +
>> +Boot Mode Pins for J784S4-EVM
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +The following tables shows
>
>show
>
>>  some common boot modes used on J784S4 SoC platform=2E
>> +More details can be found in the Technical Reference Manual:
>> +http://www=2Eti=2Ecom/lit/zip/spruj52=C2=A0under the `Boot Mode Pins` =
section=2E
>> +
>> +=2E=2E list-table:: J784S4 EVM Boot Modes
>> +=C2=A0=C2=A0 :widths: 16 16 16
>> +=C2=A0=C2=A0 :header-rows: 1
>> +
>> +=C2=A0=C2=A0 * - Switch Label
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - SW9: 12345678
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - SW8: 12345678
>> +
>> +=C2=A0=C2=A0 * - SD
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 00000000
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 10000010
>> +
>> +=C2=A0=C2=A0 * - EMMC
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 01000000
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 10000000
>> +
>> +=C2=A0=C2=A0 * - OSPI
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 01000000
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 00000110
>> +
>> +=C2=A0=C2=A0 * - UART
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 01110000
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 00000000
>> +
>> +=C2=A0=C2=A0 * - USB DFU
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 00100000
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 10000000
>> +
>> +For SW8 and SW9, the switch state in the "ON" position =3D 1=2E
>> +
>> +Boot Mode Pins for AM69-SK
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +The following table shows some common boot modes used on AM69-SK platf=
orm=2E
>> +More details can be found in the User Guide for AM69-SK:
>> +https://www=2Eti=2Ecom/lit/ug/spruj70/spruj70=2Epdf=C2=A0under the `Bo=
otmode Settings`
>> +section=2E
>> +
>> +=2E=2E list-table:: AM69 SK Boot Modes
>> +=C2=A0=C2=A0 :widths: 16 16
>> +=C2=A0=C2=A0 :header-rows: 1
>> +
>> +=C2=A0=C2=A0 * - Switch Label
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - SW2: 1234
>> +
>> +=C2=A0=C2=A0 * - SD
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0000
>> +
>> +=C2=A0=C2=A0 * - EMMC
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 0110
>> +
>> +=C2=A0=C2=A0 * - OSPI
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 1110
>> +
>> +=C2=A0=C2=A0 * - UART
>> +=C2=A0=C2=A0=C2=A0=C2=A0 - 1010
>> +
>> +For SW2, the switch state in the "ON" position =3D 1=2E
>> +
>> +Debugging U-Boot
>> +----------------
>> +
>> +See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>=
`: for
>> +detailed setup information=2E
>> +
>> +=2E=2E warning::
>> +
>> +=C2=A0 **OpenOCD support since**: v0=2E12=2E0
>> +
>> +=C2=A0 If the default package version of OpenOCD in your development
>> +=C2=A0 environment's distribution needs to be updated, it might be nec=
essary to
>> +=C2=A0 build OpenOCD from the source=2E
>> +
>> +Debugging U-Boot on J784S4-EVM
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +=2E=2E include::=C2=A0 k3=2Erst
>> +=C2=A0=C2=A0=C2=A0 :start-after: =2E=2E k3_rst_include_start_openocd_c=
onnect_XDS110
>> +=C2=A0=C2=A0=C2=A0 :end-before: =2E=2E k3_rst_include_end_openocd_conn=
ect_XDS110
>> +
>> +To start OpenOCD and connect to the board
>> +
>> +=2E=2E code-block:: bash
>> +
>> +=C2=A0 openocd -f board/ti_j784s4evm=2Ecfg
>> +
>> +Debugging U-Boot on SK-AM69
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +=2E=2E include::=C2=A0 k3=2Erst
>> +=C2=A0=C2=A0=C2=A0 :start-after: =2E=2E k3_rst_include_start_openocd_c=
onnect_cti20
>> +=C2=A0=C2=A0=C2=A0 :end-before: =2E=2E k3_rst_include_end_openocd_conn=
ect_cti20
>> +
>> +=2E=2E include::=C2=A0 k3=2Erst
>> +=C2=A0=C2=A0=C2=A0 :start-after: =2E=2E k3_rst_include_start_openocd_c=
fg_external_intro
>> +=C2=A0=C2=A0=C2=A0 :end-before: =2E=2E k3_rst_include_end_openocd_cfg_=
external_intro
>> +
>> +For SK-AM69, the openocd_connect=2Ecfg is as follows:
>> +
>> +=2E=2E code-block:: tcl
>> +
>> +=C2=A0 # TUMPA example:
>> +=C2=A0 # http://www=2Etiaowiki=2Ecom/w/TIAO_USB_Multi_Protocol_Adapter=
_User's_Manual
>> +=C2=A0 source [find interface/ftdi/tumpa=2Ecfg]
>> +
>> +=C2=A0 transport select jtag
>> +
>> +=C2=A0 # default JTAG configuration has only SRST and no TRST
>> +=C2=A0 reset_config srst_only srst_push_pull
>> +
>> +=C2=A0 # delay after SRST goes inactive
>> +=C2=A0 adapter srst delay 20
>> +
>> +=C2=A0 if { ![info exists SOC] } {
>> +=C2=A0=C2=A0=C2=A0 # Set the SoC of interest
>> +=C2=A0=C2=A0=C2=A0 set SOC j784s4
>> +=C2=A0 }
>> +
>> +=C2=A0 source [find target/ti_k3=2Ecfg]
>> +
>> +=C2=A0 ftdi tdo_sample_edge falling
>> +
>> +=C2=A0 # Speeds for FT2232H are in multiples of 2, and 32MHz is tops
>> +=C2=A0 # max speed we seem to achieve is ~20MHz=2E=2E so we pick 16MHz
>> +=C2=A0 adapter speed 16000
>> diff --git a/doc/board/ti/k3=2Erst b/doc/board/ti/k3=2Erst
>> index 95cdb36625=2E=2E314975e9ba 100644
>> --- a/doc/board/ti/k3=2Erst
>> +++ b/doc/board/ti/k3=2Erst
>> @@ -36,6 +36,7 @@ K3 Based SoCs
>> =C2=A0=C2=A0=C2=A0 am65x_evm
>> =C2=A0=C2=A0=C2=A0 j7200_evm
>> =C2=A0=C2=A0=C2=A0 j721e_evm
>> +=C2=A0=C2=A0 j784s4_evm
>> =C2=A0
>> =C2=A0Boot Flow Overview
>> =C2=A0------------------
