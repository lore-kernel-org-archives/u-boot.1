Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A06CCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 04:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFE45807C0;
	Thu, 23 Oct 2025 06:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KJttVtga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A8F982E34; Thu, 23 Oct 2025 06:55:10 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF2C180422
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 06:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59N4t51O1590200;
 Wed, 22 Oct 2025 23:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761195306;
 bh=HBU0C+0kdh+PjIzJXvvfOzfA+DknHmm86oodjkuZFFc=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=KJttVtga/Ld/Z1jxaDkrYDL/6LiXmHoQm2pJlMpmCanaaoYB+MDDXqDNdUotOX9WM
 9mGKzwIh8R7x15Ox2aRt1YlWP6UKT193SDCKGRVi5bG1gswHnCmuVBs40py78aNJa4
 YmayyblomuCCObhonk4hr8DjA0xAt7RoTEM0xvcU=
Received: from DFLE212.ent.ti.com (dfle212.ent.ti.com [10.64.6.70])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59N4t5Ps2546962
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Oct 2025 23:55:05 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 23:55:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 23:55:05 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59N4t4uv2297287;
 Wed, 22 Oct 2025 23:55:05 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Oct 2025 10:25:04 +0530
Message-ID: <DDPFMP7DMLK7.1ZMBBASW8NI7R@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, "Beleswar Padhi"
 <b-padhi@ti.com>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 6/8] configs: add defconfigs for am6254atl
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251022-62sip_support-v1-0-eed08d15e76d@ti.com>
 <20251022-62sip_support-v1-6-eed08d15e76d@ti.com>
 <20251022121632.vsjulhgztd7m4s4l@bryanbrattlof.com>
In-Reply-To: <20251022121632.vsjulhgztd7m4s4l@bryanbrattlof.com>
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

On Wed Oct 22, 2025 at 5:46 PM IST, Bryan Brattlof wrote:
> On October 22, 2025 thus sayeth Anshul Dalal:
>> OP-TEE for current K3 devices resides from 0x9e800000 to 0xa0000000
>> which needs to be moved to 0x80080000 to free up space at end of DDR in
>> systems with 512MiB of memory. This is required to allow U-Boot to
>> relocate to end of DDR before booting to the kernel.
>>=20
>> Therefore defconfigs for AM6254atl include the respective existing AM62x
>> configs with updated dt for r5 and modified memory map for a53 SPL to
>> account for the new OP-TEE address.
>>=20
>> Also make Bryan Brattlof and Tom Rini the maintainers for AM6254atl SIP.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  board/ti/am62x/MAINTAINERS          |  2 ++
>>  configs/am6254atl_evm_a53_defconfig | 15 +++++++++++++++
>>  configs/am6254atl_evm_r5_defconfig  |  9 +++++++++
>>  3 files changed, 26 insertions(+)
>>=20
>> diff --git a/board/ti/am62x/MAINTAINERS b/board/ti/am62x/MAINTAINERS
>> index d7dfefffe751b5f3a1292ef8cc9e2926f09c77ae..ca269fae880357eb9f62232a=
3a32bbafa8b3d29d 100644
>> --- a/board/ti/am62x/MAINTAINERS
>> +++ b/board/ti/am62x/MAINTAINERS
>> @@ -10,3 +10,5 @@ F:	configs/am62x_evm_r5_ethboot_defconfig
>>  F:	configs/am62x_evm_a53_ethboot_defconfig
>>  F:	configs/am62x_lpsk_r5_defconfig
>>  F:	configs/am62x_lpsk_a53_defconfig
>> +F:	configs/am6254atl_evm_r5_defconfig
>> +F:	configs/am6254atl_evm_a53_defconfig
>> diff --git a/configs/am6254atl_evm_a53_defconfig b/configs/am6254atl_evm=
_a53_defconfig
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..fdf6be7068e7b2fe4e48f1f3=
22703f6838729497
>> --- /dev/null
>> +++ b/configs/am6254atl_evm_a53_defconfig
>> @@ -0,0 +1,15 @@
>> +#include <configs/am62x_evm_a53_defconfig>
>> +
>> +CONFIG_ARM=3Dy
>> +CONFIG_ARCH_K3=3Dy
>> +CONFIG_SOC_K3_AM625=3Dy
>> +CONFIG_TARGET_AM625_A53_EVM=3Dy
>> +CONFIG_TEXT_BASE=3D0x82f80000
>> +CONFIG_BLOBLIST_ADDR=3D0x82c80000
>
> I think this may have been leftover from some experimentation.
> Do we still need the bloblist stuff?
>

I was under the impression that 0x80d00000 is the default BLOBLIST_ADDR
for AM62 SoCs as per the documentation[1] and needed to be modified for
62 SiP.

While in fact we don't make use of bloblists in upstream U-Boot anyways,
should we drop the mention of BLOBS from the docs as well?

Regards,
Anshul

[1]: https://docs.u-boot.org/en/stable/board/ti/am62x_sk.html#a53-spl-ddr-m=
emory-layout
