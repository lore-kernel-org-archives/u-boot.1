Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79671EDE988
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 07:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6E5186AEC;
	Thu, 14 Sep 2023 09:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AuCyoL06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 372DE86C87; Thu, 14 Sep 2023 09:19:39 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4197D86A82
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694675962; x=1695280762; i=xypron.glpk@gmx.de;
 bh=KVIK9IQmOJjeaivB1AfCYP6ZpsVuGzWEM1HMlJqR85Q=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
 b=AuCyoL06ze/g3ehybmyaQoQiwoZVbI78w4O1ChyDoyTO/j0w/EJlIKW6IdZTWZVyhtGsLWXu1d4
 4I2jxInzIVXuWg9tIKjQubVfNSsWEfikWnPYzIXnXBi6jD5EigbD7cvxG+wGOAv2XnY3yWAY5ScCi
 3SnN7bjVr3qZCmwn2bZPJKt/1MmSDabGqZDv+7qP6pqqThe808ZOpWCOcs+naIFbAN2alfT4aaL84
 zB3xjTjzwsXtJVm0Zd4bxNOqxWuaORkqEUYP21tYWf8bcO6p/mNivGMu8oJNe7PC6j92NnT9ac1T6
 iEwy/QuM/cUhSFE24zok8LPWTpkngxzRiDVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1r2jik2yUi-00M1Jv; Thu, 14
 Sep 2023 09:19:22 +0200
Message-ID: <967f8765-67ac-48ff-970b-da8e431b5009@gmx.de>
Date: Thu, 14 Sep 2023 09:20:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: enable multi-range memory layout
Content-Language: en-US, de-DE
To: "Wu, Fei" <fei2.wu@intel.com>
References: <20230914053055.745507-1-fei2.wu@intel.com>
 <5D4FDDF5-5DEB-4A02-A423-C54662CCBFF0@gmx.de>
 <c23a28ff-475d-0921-502f-f475b0e51ebd@intel.com>
Cc: rick@andestech.com, ycliang@andestech.com, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de, pali@kernel.org,
 andrei.warkentin@intel.com, sunilvl@ventanamicro.com
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <c23a28ff-475d-0921-502f-f475b0e51ebd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LgwKtr6+tp58/Hooh3gq9NIvU9eVs+XLDugaqu5dcnm3xlZrUVI
 y+3bccXxcpsX0B1KwCW1P070NhIJva6ShAMQ3+wHQ88/4UDUNJDq8fzHzPzhEYace7B/KVC
 wdGsQa2Cmjz8pExaNRFcRqLs9gfqHLyW/fIdSCmZQ2p5HxB/QUFRmunGRaQDL6z3Lw5UlZX
 o5y/lUk/fVLHze91xQIyA==
UI-OutboundReport: notjunk:1;M01:P0:jLv3njRpGS8=;rXJMkuK3A9AMbs/4mS0mEBtbmS+
 l4IGNbUT0ejxS+Pcre+pW2FnppkrwcIfgZWbsA4wccQtI4j7QrdfgSPsIcmxeWqEF3oD9NbPy
 RL4NJY/sRWNJa0zxU5w5L4gaU/SqpsRagPhBNwszWb5BLnJbS1+JaPDANguqqryTQBZBQVRFO
 8rGrQMlVjPvbL0cFmQjjFd9QRxhz1Ub5wSkXsbkv54ZC1vMAo9fCD7PMWsjFwrT5deJxKe78I
 7np4F8k+bP3xXlYw0FE+HaVN7uZr1BB0fIzA+W+LoYxjh3xHHmXqzT1ciUu/tviQ5tXnkz1+P
 9x6zSFYwbMcTLbapz+jIeTlmg6tPQ4CrRViwOGxwu8Fr2qMKEx7NaRwconq9H+4I7tIT0CtPU
 bJIPDGkz2q8vXHR7vYwG58usiTTxmA320Mp+FIW7K1Z73pe+2uJAwCrt6JSDTOmBabm+pC4sQ
 gKzIdk96IRI2rg0WVDf7C2A19NplURc2h+gzXrEcXXQ73iVxp7Z1QvfN5MT0Pplj0eD3AWYHr
 xNmVFcIWDU67PIJJDFeuErSpvx5KTLrcsSwTdR5aChazYepQTZFOlJF/4waIrBNfmj6JkU0T+
 T4qIQ7w7qKzznDTdgNw9aqDyp0c2M2eVffN6V/0rTS8UthlwMwLx8Kn8k+8FI/4OKj6443lpq
 Cfj7d0Gyy07/mmeAnlBpQLGc2hFdZr69dvjT7JnYCltTwqlAThjq/EGR5xv9KFvTSCOxXsbm1
 6X7ak+2L5uNBfk0rLdsX3EsTsT1sLTe2m9BHFbaJzg6RkzziEi2adVAp2PWeET93e0DMm4Zwc
 FY+vlMXA81c/A3MBnM4E1GjL4aFLEeDxnG5F2jmBTOMOh/IsA2O0vE0qgyzk6A73SE+ViVdH8
 st1Oi2Nr6NzdHgeoLMFXqIWUWU98SXXb/kf3AA2i6hi0nMWKwXANArO3p6VxFJ/Yr35VIscEO
 Tgn4C5SSkdbX9nzHgvo3qNMOsRQ=
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

On 9/14/23 08:48, Wu, Fei wrote:
> On 9/14/2023 2:05 PM, Heinrich Schuchardt wrote:
>>
>>
>> Am 14. September 2023 07:30:55 MESZ schrieb Fei Wu <fei2.wu@intel.com>:
>>> In order to enable PCIe passthrough on qemu riscv, the physical memory
>>> range between 3GB and 4GB is reserved. Therefore if guest has 4GB ram,
>>> two ranges are created as [2G, 3G) and [4G, 7G), currently u-boot sets
>>> ram_top to 4G - 1 if the gd->ram_top is above 4G in
>>
>> This should move to 7GiB - 1 in your example on riscv64.
>>
> I'm describing the current implementation of board_get_usable_ram_top()
> in ./arch/riscv/cpu/generic/dram.c. Do you mean this function should be
> changed? Is the comment about 32bit DMA device still valid?
>
> phys_size_t board_get_usable_ram_top(phys_size_t total_size)
> {
>          /*
>           * Ensure that we run from first 4GB so that all
>           * addresses used by U-Boot are 32bit addresses.
>           *
>           * This in-turn ensures that 32bit DMA capable
>           * devices work fine because DMA mapping APIs will
>           * provide 32bit DMA addresses only.
>           */
>          if (gd->ram_top >=3D SZ_4G)
>                  return SZ_4G - 1;
>
>          return gd->ram_top;
> }

The comment above says 32bit DMA is board specific and not architecture
specific. So it is wrong to have this board_get_usable_ram_top()
function on architecture level. It makes usage of devices with all
memory above 4 GiB impossible.

It tried to pass through a SATA controller but received an error:

# modprobe vfio-pci
# echo 0000:06:00.0 > /sys/bus/pci/drivers/ahci/unbind
# echo 1022 7091 > /sys/bus/pci/drivers/vfio-pci/new_id
# qemu-system-riscv64 -kernel u-boot.bin -nographic -M virt -m 4G
-device vfio-pci,host=3D0000:06:00.0
qemu-system-riscv64: -device vfio-pci,host=3D0000:06:00.0: VFIO_MAP_DMA
failed: Invalid argument
qemu-system-riscv64: -device vfio-pci,host=3D0000:06:00.0: vfio
0000:06:00.0: failed to setup container for group 5: memory listener
initialization failed: Region riscv_virt_board.ram:
vfio_dma_map(0x55adbde66f70, 0x80000000, 0x100000000, 0x7fcd6fe00000) =3D
-22 (Invalid argument)

With which version of QEMU were you able to use PCI pass through?

Best regards

Heinrich

>
>>> board_get_usable_ram_top(), but that address is not backed by ram. Thi=
s
>>> patch selects the lowest range instead.
>>>
>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>> ---
>>> arch/riscv/cpu/generic/dram.c        | 2 +-
>>> configs/qemu-riscv64_defconfig       | 2 +-
>>> configs/qemu-riscv64_smode_defconfig | 2 +-
>>> configs/qemu-riscv64_spl_defconfig   | 2 +-
>>> 4 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/dr=
am.c
>>> index 44e11bd56c..fb53a57b4e 100644
>>> --- a/arch/riscv/cpu/generic/dram.c
>>> +++ b/arch/riscv/cpu/generic/dram.c
>>> @@ -13,7 +13,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>>
>>> int dram_init(void)
>>> {
>>> -	return fdtdec_setup_mem_size_base();
>>> +	return fdtdec_setup_mem_size_base_lowest();
>>
>> Linaro is working on allowing to download a distro image via https and =
installing from a RAM disk.
>>
>> We should not artificially reduce the RAM size available for U-Boot by =
restricting ourselfs to 1 GiB.
>>
>> We must ensure that ram top is in the upper range.
>>
> How do they handle the case of >4GB? board_get_usable_ram_top() attached
> above always returns <4GB. And it seems like
> fdtdec_setup_mem_size_base() cannot ensure the upper one is picked, it
> just picks up one, but which one is selected depending on fdt.
>
> Thanks,
> Fei.
>
>> Best regards
>>
>> Heinrich
>>
>>> }
>>>
>>> int dram_init_banksize(void)
>>> diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_def=
config
>>> index 9a8bbef192..aa55317d26 100644
>>> --- a/configs/qemu-riscv64_defconfig
>>> +++ b/configs/qemu-riscv64_defconfig
>>> @@ -1,6 +1,6 @@
>>> CONFIG_RISCV=3Dy
>>> CONFIG_SYS_MALLOC_LEN=3D0x800000
>>> -CONFIG_NR_DRAM_BANKS=3D1
>>> +CONFIG_NR_DRAM_BANKS=3D2
>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
>>> CONFIG_ENV_SIZE=3D0x20000
>>> diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv=
64_smode_defconfig
>>> index 1d0f021ade..de08a49dab 100644
>>> --- a/configs/qemu-riscv64_smode_defconfig
>>> +++ b/configs/qemu-riscv64_smode_defconfig
>>> @@ -1,6 +1,6 @@
>>> CONFIG_RISCV=3Dy
>>> CONFIG_SYS_MALLOC_LEN=3D0x800000
>>> -CONFIG_NR_DRAM_BANKS=3D1
>>> +CONFIG_NR_DRAM_BANKS=3D2
>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
>>> CONFIG_ENV_SIZE=3D0x20000
>>> diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64=
_spl_defconfig
>>> index bb10145e6e..66dc2a1dd9 100644
>>> --- a/configs/qemu-riscv64_spl_defconfig
>>> +++ b/configs/qemu-riscv64_spl_defconfig
>>> @@ -1,6 +1,6 @@
>>> CONFIG_RISCV=3Dy
>>> CONFIG_SYS_MALLOC_LEN=3D0x800000
>>> -CONFIG_NR_DRAM_BANKS=3D1
>>> +CONFIG_NR_DRAM_BANKS=3D2
>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
>>> CONFIG_ENV_SIZE=3D0x20000
>

