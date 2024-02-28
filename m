Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BCCC54E41
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 08:18:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB0387FDC;
	Wed, 28 Feb 2024 09:18:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="pfj3xqN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 783BF8800C; Wed, 28 Feb 2024 09:18:25 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB6AA87D6A
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 09:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1709108302; x=1711700302;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sqGSUAitQ4Dqiw4UrLGK2HkN8OVqAn+OWvq3wW+PU/k=;
 b=pfj3xqN5ze1TL/u7wA9sImWEXPaTEX3Mj0fMRMb7z3/mBV7z4HtzHBko0p6E8Vpz
 Eq5wnVpRxgkEdgh4KYVQHXnnQ0fxfNMEqL17m9w1f0k1qxSQhg868txJhhM7h+P5
 Ok5e0SYfJylLJigODf+NqvjL7sTH9MXrWiSewEVeOY8=;
X-AuditID: ac14000a-fbefe7000000290d-30-65deec4ece5c
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9E.83.10509.E4CEED56;
 Wed, 28 Feb 2024 09:18:22 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 28 Feb
 2024 09:18:21 +0100
Message-ID: <046cd560-41cf-4a5d-8be3-f04903e67c95@phytec.de>
Date: Wed, 28 Feb 2024 09:18:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] doc: board: phytec: Add phyCORE-AM64x
Content-Language: en-US
To: Dhruva Gole <d-gole@ti.com>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <trini@konsulko.com>,
 <upstream@lists.phytec.de>
References: <20240226122341.3638748-1-w.egorov@phytec.de>
 <20240226122341.3638748-3-w.egorov@phytec.de>
 <20240228054546.42zbsojdpmwbeyky@dhruva>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240228054546.42zbsojdpmwbeyky@dhruva>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWyRpKBR9fvzb1Ug69r5Cxa1npYvPlxlsli
 6qTN7BZv93ayW3S/U3dg9Xh1YBW7x9k7Oxg9+rtbWD2O39jOFMASxWWTkpqTWZZapG+XwJXx
 5u0SxoL1ahV9L00bGJvluxg5OCQETCSuTrLrYuTiEBJYzCSxuWsDG4Rzl1Fi48IV7F2MnBy8
 AjYS/dtnMoHYLAKqEh+v/2eEiAtKnJz5hAXEFhWQl7h/awY7yFBhAUeJ9sUlIGFmAXGJW0/m
 g7WKAJX8WbWUBSIeLXFx7X4miF1TGCVWzfkJVsQmoC5xZ8M3VhCbU8BUYtrVt0wQDRYSi98c
 ZIew5SW2v53DDGILAdkvLi0HGyoBZE8795oZwg6V2PplO9MERuFZSE6dheSmWUjGzkIydgEj
 yypGodzM5OzUosxsvYKMypLUZL2U1E2MoOgQYeDawdg3x+MQIxMH4yFGCQ5mJRFeGcG7qUK8
 KYmVValF+fFFpTmpxYcYpTlYlMR5V3cEpwoJpCeWpGanphakFsFkmTg4pRoYw/tvnCk48b6J
 79OxNb3MjfvXn8ufzHQvvvP4OenlmZ8LmaPzg5OFjmyN+afAWvHGNE214em+Mh6jZ6pP9CJr
 L9i+kFf99vzrIuMpSk8Cam7cfhm/NPsjq+7SCbxrrebWqctErHqnemnTxulN2XYaqxcelrzu
 mSF2ZlJ1s+lOveiF0wzehrlOU2Ipzkg01GIuKk4EAEAg27p8AgAA
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


Am 28.02.24 um 06:45 schrieb Dhruva Gole:
> Hi,
>
> On Feb 26, 2024 at 13:23:41 +0100, Wadim Egorov wrote:
>> Add documentation for PHYTEC phyCORE-AM64x SoM.
>>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>> ---
>>   doc/board/phytec/index.rst         |   1 +
>>   doc/board/phytec/phycore-am64x.rst | 159 +++++++++++++++++++++++++++++
>>   2 files changed, 160 insertions(+)
>>   create mode 100644 doc/board/phytec/phycore-am64x.rst
>>
>> diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
>> index fea0b07620..99848a9e95 100644
>> --- a/doc/board/phytec/index.rst
>> +++ b/doc/board/phytec/index.rst
>> @@ -9,5 +9,6 @@ PHYTEC
>>      imx8mm-phygate-tauri-l
>>      imx93-phyboard-segin
>>      phycore-am62x
>> +   phycore-am64x
>>      phycore-imx8mm
>>      phycore-imx8mp
>> diff --git a/doc/board/phytec/phycore-am64x.rst b/doc/board/phytec/phycore-am64x.rst
>> new file mode 100644
>> index 0000000000..202b756dc4
>> --- /dev/null
>> +++ b/doc/board/phytec/phycore-am64x.rst
>> @@ -0,0 +1,159 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +.. sectionauthor:: Wadim Egorov <w.egorov@phytec.de>
>> +
>> +phyCORE-AM64x
>> +=============
>> +
>> +The `phyCORE-AM64x <https://www.phytec.com/product/phycore-am64x>`_ is a
>> +SoM (System on Module) featuring TI's AM64x SoC. It can be used in combination
>> +with different carrier boards. This module can come with different sizes and
>> +models for DDR, eMMC, SPI NOR Flash and various SoCs from the AM64x family.
>> +
>> +A development Kit, called `phyBOARD-Lyra <https://www.phytec.com/product/phyboard-am64x>`_
>> +is used as a carrier board reference design around the AM64x SoM.
>> +
>> +Quickstart
>> +----------
>> +
>> +* Download sources and TI firmware blobs
>> +* Build Trusted Firmware-A
>> +* Build OP-TEE
>> +* Build U-Boot for the R5
>> +* Build U-Boot for the A53
>> +* Create bootable uSD Card
>> +* Boot
>> +
>> +Sources
>> +-------
>> +
>> +.. include::  ../ti/k3.rst
>> +    :start-after: .. k3_rst_include_start_boot_sources
>> +    :end-before: .. k3_rst_include_end_boot_sources
>> +
>> +Build procedure
>> +---------------
>> +
>> +Setup the environment variables:
>> +
>> +.. include::  ../ti/k3.rst
>> +    :start-after: .. k3_rst_include_start_common_env_vars_desc
>> +    :end-before: .. k3_rst_include_end_common_env_vars_desc
>> +
>> +.. include::  ../ti/k3.rst
>> +    :start-after: .. k3_rst_include_start_board_env_vars_desc
>> +    :end-before: .. k3_rst_include_end_board_env_vars_desc
>> +
>> +Set the variables corresponding to this platform:
>> +
>> +.. include::  ../ti/k3.rst
>> +    :start-after: .. k3_rst_include_start_common_env_vars_defn
>> +    :end-before: .. k3_rst_include_end_common_env_vars_defn
>> +.. code-block:: bash
>> +
>> + $ export UBOOT_CFG_CORTEXR=phycore_am64x_r5_defconfig
>> + $ export UBOOT_CFG_CORTEXA=phycore_am64x_a53_defconfig
>> + $ export TFA_BOARD=lite
>> + $ # we don't use any extra TFA parameters
>> + $ unset TFA_EXTRA_ARGS
>> + $ export OPTEE_PLATFORM=k3-am64x
>> + # we don't use any extra OPTEE parameters
>> + unset OPTEE_EXTRA_ARGS
>> +
>> +.. include::  ../ti/am62x_sk.rst
>> +    :start-after: .. am62x_evm_rst_include_start_build_steps
>> +    :end-before: .. am62x_evm_rst_include_end_build_steps
>> +
>> +uSD Card creation
>> +-----------------
>> +
>> +Use fdisk to partition the uSD card. The layout should look similar to:
>> +
>> +.. code-block:: bash
>> +
>> + $ sudo fdisk -l /dev/mmcblk0
>> + Disk /dev/mmcblk0: 7.56 GiB, 8120172544 bytes, 15859712 sectors
>> + Units: sectors of 1 * 512 = 512 bytes
>> + Sector size (logical/physical): 512 bytes / 512 bytes
>> + I/O size (minimum/optimal): 512 bytes / 512 bytes
>> + Disklabel type: dos
>> + Disk identifier: 0x6583d9a3
>> +
>> + Device         Boot  Start     End Sectors   Size Id Type
>> + /dev/mmcblk0p1 *      2048  264191  262144   128M  c W95 FAT32 (LBA)
>> + /dev/mmcblk0p2      264192 1934953 1670762 815.8M 83 Linux
>> +
>> +
>> +Once partitioned, the boot partition has to be formatted with a FAT filesystem.
>> +Assuming the uSD card is `/dev/mmcblk0`:
>> +
>> +.. code-block:: bash
>> +
>> + $ mkfs.vfat /dev/mmcblk0p1
>> +
>> +To boot from a micro SD card on a HSFS device simply copy the following
>> +artifacts to the FAT partition:
>> +
>> +* tiboot3.bin from R5 build as tiboot3.bin
>> +* tispl.bin_unsigned from Cortex-A build as tispl.bin
>> +* u-boot.img_unsigned from Cortex-A build as u-boot.img
> Is the _unsigned really required? I guess the regular tispl and
> u-boot.img should also work right? It will just skip auth I guess.

No, it is not required. Copy&pasted it from phycore-am62x.rst.
Thanks, I will update both doc files.


>
> [...]
>
> Mostly looks good, thanks!
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>
