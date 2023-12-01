Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F2AC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 14:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EEDF870FC;
	Fri,  1 Dec 2023 15:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="jj3wA1Zt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B53E87158; Fri,  1 Dec 2023 15:00:40 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD8C887075
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 15:00:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1701439236; x=1704031236;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=75TZMJ2RBNXbAknaECa82yCPkzZxW1QsR4ruABY0Tio=;
 b=jj3wA1ZtnTWOE+FvY1svb3FruGTFk7oWBXXReVKoCpiHL80h9v/WaZzfQk+Xfc9R
 3JN7U/ySjZ4R/OQ5WOTKQHw3T+2ZGflJV6X3oY8h20yhU2uzo0Z7KhV1ppK9VXfK
 Z0qiAUi06i+X11HX7+e5VDBeS4alcMiOxKBFdTJKbm4=;
X-AuditID: ac14000a-fbefe7000000290d-d3-6569e7042613
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C3.72.10509.407E9656;
 Fri,  1 Dec 2023 15:00:36 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Florix.phytec.de (172.25.0.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 1 Dec 2023
 15:00:34 +0100
Message-ID: <6c5aa707-4124-4689-bfc0-1a26788b258a@phytec.de>
Date: Fri, 1 Dec 2023 15:00:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] doc: board: phytec: Add phyCORE-AM62x
Content-Language: en-US
To: Dhruva Gole <d-gole@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
References: <20231130115607.2150349-1-w.egorov@phytec.de>
 <20231130115607.2150349-3-w.egorov@phytec.de>
 <20231201101020.uguepgy754fkzntk@dhruva>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20231201101020.uguepgy754fkzntk@dhruva>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Florix.phytec.de
 (172.25.0.13)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWyRpKBV5fleWaqQf8KCYuWtR4Wb36cZbKY
 Omkzu8XbvZ3sFt3v1B1YPV4dWMXucfbODkaP/u4WVo/jN7YzBbBEcdmkpOZklqUW6dslcGUc
 m/KKqWCDecW2F42sDYxzdboYOTkkBEwkbk38wNbFyMUhJLCYSeL6oqMsEM4dRomF+74ydTFy
 cPAK2EicvVUA0sAioCJx6etsJhCbV0BQ4uTMJywgtqiAvMT9WzPYQWxhAUeJp41fGEFsZgFx
 iVtP5oPViwDV/Fm1lAUiniKxduJ8ZohdUxgl1m05yAaSYBNQl7iz4RsriM0pYCpx78oKqAYL
 icVvDrJD2PIS29/OYQaxhYDsF5eWs0B8Iy8x7dxrZgg7VGL+mu/sExiFZyG5dRaSm2YhGTsL
 ydgFjCyrGIVyM5OzU4sys/UKMipLUpP1UlI3MYIiRISBawdj3xyPQ4xMHIyHGCU4mJVEeK8/
 TU8V4k1JrKxKLcqPLyrNSS0+xCjNwaIkzru6IzhVSCA9sSQ1OzW1ILUIJsvEwSnVwNiyOlCr
 LKHjtA/rzSbNsJt7dhvbCxUxTLl65WGx47Lf+7W3t86IOnvk+IdlnodmFYYZe5uKCkf3eO9t
 rXg9kddm+Zqjpju5/n2YwHQxy6OgfH1R1ZzUGQKapkH7ZOJj4rJ3P2Y6JFK+9svje5vWC1TX
 bZVnOJa2OFFq5vMvn35+fjk/K6jnwXYlluKMREMt5qLiRAADrMrhfgIAAA==
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

Hi Dhruva,

Am 01.12.23 um 11:10 schrieb Dhruva Gole:
> Hi,
>
> On Nov 30, 2023 at 12:56:07 +0100, Wadim Egorov wrote:
>> Add documentation for PHYTEC phyCORE-AM62x SoM.
>>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>> ---
>> v2: Rebased on top of -next
>>
> Please CC Tom Rini <trini@konsulko.com> on the series.
>
>> ---
>>   doc/board/phytec/index.rst         |   1 +
>>   doc/board/phytec/phycore-am62x.rst | 125 +++++++++++++++++++++++++++++
>>   doc/board/ti/k3.rst                |   1 +
>>   3 files changed, 127 insertions(+)
>>   create mode 100644 doc/board/phytec/phycore-am62x.rst
>>
>> diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
>> index a5b442045e..b914cc3fbd 100644
>> --- a/doc/board/phytec/index.rst
>> +++ b/doc/board/phytec/index.rst
>> @@ -6,5 +6,6 @@ PHYTEC
>>   .. toctree::
>>      :maxdepth: 2
>>   
>> +   phycore-am62x
>>      phycore-imx8mm
>>      phycore-imx8mp
>> diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
>> new file mode 100644
>> index 0000000000..46312a73bc
>> --- /dev/null
>> +++ b/doc/board/phytec/phycore-am62x.rst
>> @@ -0,0 +1,125 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +.. sectionauthor:: Wadim Egorov <w.egorov@phytec.de>
>> +
>> +phyCORE-AM62x
>> +=============
>> +
>> +The `phyCORE-AM62x <https://www.phytec.com/product/phycore-am62x>`_ is a
>> +SoM (System on Module) featuring TI's AM62x SoC. It can be used in combination
>> +with different carrier boards. This module can come with different sizes and
>> +models for DDR, eMMC, SPI NOR Flash and various SoCs from the AM62x family.
>> +
>> +A development Kit, called `phyBOARD-Lyra <https://www.phytec.com/product/phyboard-am62x>`_
>> +is used as a carrier board reference design around the AM62x SoM.
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
>> + $ export UBOOT_CFG_CORTEXR=phycore_am62x_r5_defconfig
>> + $ export UBOOT_CFG_CORTEXA=phycore_am62x_a53_defconfig
>> + $ export TFA_BOARD=lite
>> + $ # we don't use any extra TFA parameters
>> + $ unset TFA_EXTRA_ARGS
>> + $ export OPTEE_PLATFORM=k3-am62x
>> + $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
> Does this need to be the case? If it's just copied from AM62x then I
> think I need to fix that documentation, not sure if we necessarily need
> SW_RNG and thus disable HW_RNG upstream.
>
> The context here was we were enabling SW_RNG a while back due to a crash
> after suspend resume on AM62x, however that issue no longer seems to
> cause any lock ups/ crash.

Yep, copy&paste. I'll remove it.


>
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
>> +To boot from an uSD on a GP device simply copy the following artifacts to the
> nit: "a" micro SD card not an
>
>
> Are most of the SoM's GP devices? Otherwise thinking if we should make
> the documentation for HSFS as a default and GP as an exception?
>
> Or else just say copy tiboot3.bin as is on the SD card for HSFS devices
> and for GP.... (as you have done below)

Currently, most devices around are GPs. But this will change. So making 
HSFS as default makes sense.


>
>> +FAT partition:
>> +
>> +* tiboot3-am62x-gp-phycore-som.bin from R5 build as tiboot3.bin
>> +* tispl.bin_unsigned from Cortex-A build as tispl.bin
>> +* u-boot.img_unsigned from Cortex-A build as u-boot.img
>> +
>> +Boot
>> +----
>> +
>> +Put the uSD card in the slot on the board and apply power. Check the serial
>> +console for output.
>> +
>> +Flash to SPI NOR
>> +----------------
>> +
>> +Below commands can be used to flash the SPI NOR flash; assuming
>> +tiboot3.bin, tispl.bin and u-boot.img are stored on the uSD card.
>> +
>> +.. code-block:: bash
>> +
>> +  sf probe
>> +  fatload mmc 1 ${loadaddr} tiboot3.bin
>> +  sf update $loadaddr 0x0 $filesize
>> +  fatload mmc 1 ${loadaddr} tispl.bin
>> +  sf update $loadaddr 0x80000 $filesize
>> +  fatload mmc 1 ${loadaddr} u-boot.img
>> +  sf update $loadaddr 0x280000 $filesize
>> +
> Want to add some documentation on Boot Modes? Something like [0]?

Good idea.


>
>
>> +Further Information
>> +-------------------
>> +
>> +Please see :doc:`../ti/am62x_sk` chapter for further AM62 SoC related documentation
>> +and https://docs.phytec.com/phycore-am62x for vendor documentation.
>> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
>> index a127215ce5..435c72a428 100644
>> --- a/doc/board/ti/k3.rst
>> +++ b/doc/board/ti/k3.rst
>> @@ -33,6 +33,7 @@ K3 Based SoCs
>>      am62ax_sk
>>      am62x_sk
>>      ../beagle/am62x_beagleplay
>> +   ../phytec/phycore-am62x
>>      ../toradex/verdin-am62
>>      am64x_evm
> Rest looks good, so with the above suggestions,
>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>


For both patches or only for the docs part?

Regards,
Wadim

>
> [0] https://docs.u-boot.org/en/v2023.07.02/board/ti/am62x_sk.html
>
