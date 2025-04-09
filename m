Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3ED0C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 21:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6BCD83951;
	Wed,  9 Apr 2025 23:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wpHbT691";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD3583956; Wed,  9 Apr 2025 23:37:22 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B2E8394F
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 23:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 539Lb01c1589823
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Apr 2025 16:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744234620;
 bh=L2pvqzfYU88jfOkmFECcIbaDFj9KtgdVukGlKcaY80w=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=wpHbT691VNQerVefUReGealfAoK7JoKpTEyjlL9+9G0gWY3o/AeL24+O4K9O4Tpz7
 iB0j8P8ixQQlWOajHL7ZRYqjwzDn/CvVLKrhptwZ8B5u+2JqC6gWStdAWDofENoOvC
 jsfj6/v6ITq3TnukuOkgBSLLp6Nt34+ZGF52velI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 539LaxuX047091
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 9 Apr 2025 16:36:59 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Apr 2025 16:36:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Apr 2025 16:36:59 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 539LaxrQ055320;
 Wed, 9 Apr 2025 16:36:59 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: Michal Simek <monstr@monstr.eu>
CC: Raymond Mao <raymond.mao@linaro.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Adriano Cordova <adrianox@gmail.com>, "Michal
 Simek" <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>, Simon Glass
 <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>, Hari Nagalla
 <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K
 <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>, Neil Armstrong <neil.armstrong@linaro.org>, "Aashvij
 Shenai" <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Tom Rini
 <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>, "Nishanth
 Menon" <nm@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, "Mattijs
 Korpershoek" <mkorpershoek@baylibre.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, <s-vadapalli@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 0/3] EFI Capsule update explicitly sets dfu_alt_info
In-Reply-To: <CAHTX3dJ2cCVZC1ph6PMbrTNOSTg9RFabn4+y_g3RxuZo=YSgew@mail.gmail.com>
References: <20250226223547.393611-1-j-humphreys@ti.com>
 <CAHTX3dJ2cCVZC1ph6PMbrTNOSTg9RFabn4+y_g3RxuZo=YSgew@mail.gmail.com>
Date: Wed, 9 Apr 2025 16:36:58 -0500
Message-ID: <86tt6xkoed.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Michal Simek <monstr@monstr.eu> writes:

> Hi,
>
> st 26. 2. 2025 v 23:36 odes=C3=ADlatel Jonathan Humphreys
> <j-humphreys@ti.com> napsal:
>>
>> For capsule update, explicitly set the dfu_alt_info environment variable
>> before the DFU operation, and then restore it to the original value.
>> Previously, the dfu_alt_info environment variable was set with the
>> set_dfu_alt_info() function.
>>
>> The problem with setting the capsule update's dfu_alt_info setting in
>> set_dfu_alt_info() is that set_dfu_alt_info() lacks the context of what =
DFU
>> operation is being performed (eg, capsule update, DFU boot, listing the
>> alt_info, etc) so the capsule update setting was overwriting the setting
>> for other DFU operations.
>>
>> Changes from v1:
>> - use log_err() instead of pr_err()
>> - create a local copy of the original dfu_alt_info environment variable =
to
>>   be used to later restore it, rather than just a pointer to the stored
>>   value, because changing its value to the EFI capsule update setting wi=
ll
>>   cause the original string location to be freed.
>> - even in the case of a DFU operation error, restore the dfu_alt_info
>>   environment variable to its original value.
>> - return EFI_EXIT based error codes if setting environment variables fai=
ls
>> Link to v1: https://lore.kernel.org/r/20250203215351.2840144-1-j-humphre=
ys@ti.com
>>
>> Changes from v2:
>> - add patch for xilinx boards to set the dfu_string member with the crea=
ted
>>   dfu_alt_info string for capsule updates
>> Link to v2: https://lore.kernel.org/r/20250206154719.3032322-1-j-humphre=
ys@ti.com
>>
>> Changes from v3:
>> - in case that the dfu_alt_info env variable is set and we save a copy
>>   using strdup(), check that strdup() doesn't fail
>> - separate the reporting of an error due to the DFU operation from failu=
re
>>   to restore the dfu_alt_info environment variable. In the latter case,
>>   just emit a warning and return success for the DFU operation.
>> Link to v3: https://lore.kernel.org/r/20250213195351.3518305-1-j-humphre=
ys@ti.com
>>
>> Tested-by: Michal Simek <michal.simek@amd.com>
>>
>> Jonathan Humphreys (2):
>>   efi_firmware: set EFI capsule dfu_alt_info env explicitly
>>   board: remove capsule update support in set_dfu_alt_info()
>>
>> Michal Simek (1):
>>   xilinx: dfu: Fill directly update_info.dfu_string
>>
>>  board/beagle/beagleboneai64/beagleboneai64.c  |  8 ---
>>  board/beagle/beagleplay/beagleplay.c          |  8 ---
>>  .../aml-a311d-cc/aml-a311d-cc.c               |  2 -
>>  .../aml-s805x-ac/aml-s805x-ac.c               |  2 -
>>  .../aml-s905d3-cc/aml-s905d3-cc.c             |  2 -
>>  board/phytec/common/k3/board.c                |  8 ---
>>  board/ti/am62px/evm.c                         |  8 ---
>>  board/ti/am62x/evm.c                          |  8 ---
>>  board/ti/am64x/evm.c                          |  8 ---
>>  board/ti/j721e/evm.c                          |  8 ---
>>  board/ti/j784s4/evm.c                         |  8 ---
>>  board/xilinx/common/board.h                   |  3 +
>>  board/xilinx/versal/board.c                   | 16 +++---
>>  board/xilinx/zynq/board.c                     | 16 +++---
>>  board/xilinx/zynqmp/zynqmp.c                  | 16 +++---
>>  lib/efi_loader/Kconfig                        |  2 -
>>  lib/efi_loader/efi_firmware.c                 | 56 ++++++++++++++++---
>>  17 files changed, 72 insertions(+), 107 deletions(-)
>>
>> --
>> 2.34.1
>>
>
> Is anybody going to take this series?
>
> Thanks,
> Michal
>
> --=20
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

I believe it is Heinrich Schuchardt's queue.

Heinrich, is there anything else to be closed?

Thanks
Jon
