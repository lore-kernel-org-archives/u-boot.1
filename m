Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D952EDE99C
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 10:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C51986A82;
	Thu, 14 Sep 2023 12:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="H1IYT0+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADCDE86A8F; Thu, 14 Sep 2023 12:21:34 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A3D86907
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 12:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694686883; x=1695291683; i=xypron.glpk@gmx.de;
 bh=/YOxKxAimxEHAsTA0ssHDgAe/3uTb+zFaiUTlEz1HbM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=H1IYT0+oJaw+pbeV8YY2Ki9PxHuoXngIbUOrQrZP9YOlVuRqE77AF2v+jvzL1QsPS42rb4UG7+J
 YkkM0ZwjRaramHKMzY/PhrV40WphEkY1BOkMrfux0ykKtFHLBdfHwExqDuj7H9C7bSzTlk/WkVqjB
 Tisv08t5TlHIFMciCHo8tXYy43AOkkkZRewut/hddiTlutO2Etp1kcWhq57xVhRJUUouPufL17Giz
 jOz5fseLj+IehZ86epA3vM9ExLfS21yxROvm/YW4OAX23epQDTvFBO7iXEwup2ueByGW6MkHhJNgC
 gp4e484wgxGoWnRryvsDJJgjLfTPSCQR4L7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTqW-1rC1Sv2aSk-00WVLO; Thu, 14
 Sep 2023 12:21:23 +0200
Message-ID: <fbac1b44-f2fe-42c1-af62-7a882e4737be@gmx.de>
Date: Thu, 14 Sep 2023 12:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: enable multi-range memory layout
To: "Wu, Fei" <fei2.wu@intel.com>, Anup Patel <apatel@ventanamicro.com>
Cc: rick@andestech.com, ycliang@andestech.com, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de, pali@kernel.org,
 andrei.warkentin@intel.com, sunilvl@ventanamicro.com
References: <20230914053055.745507-1-fei2.wu@intel.com>
 <5D4FDDF5-5DEB-4A02-A423-C54662CCBFF0@gmx.de>
 <c23a28ff-475d-0921-502f-f475b0e51ebd@intel.com>
 <967f8765-67ac-48ff-970b-da8e431b5009@gmx.de>
 <60f816cc-8372-0628-fb1a-0073dfd87361@intel.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <60f816cc-8372-0628-fb1a-0073dfd87361@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fUVoAoSmWh8Ns5Y4Z7N/1P+jPg7BqunLy7qaPkADn/HYxtZ+nG3
 mwJTsHmdm8rzpPcTOct01XuMeR4ok/JJt+8FouDYtm3JfYORNiOYUaHYjfSIeLtKOKSQke0
 F6PS+TC0faUwuVzDvSGokVuZj3yi7dKbKHoWKbzQGBbPUbnEBt1y/+cxxGuCqinmFNhT0q8
 TrN4TeAYA7TsqJiHVZ6QQ==
UI-OutboundReport: notjunk:1;M01:P0:JfU7aAsZU8c=;6mJ12JJM5FPkGguOk87r0kvLhf8
 x78SWs9jIZ9iNkcETnJ5/yR+I1rDuJvOLYJtG0lxTDoAE0+HbhCYBme3tf1HFz/B7OYeu34kA
 fbmV63Ydgb+WustgyDJwm/pgcnJSlM+kjL83ivssW38z24ua2HlKpn3qNpT3S13tpSG/DUfa+
 mvkxtVsFSQ9zpXY5zq8aKSwLp+VxoC8076ktMXJ0JJ5Oel/x1IjP21h+FBZNh9C+2l6HkHl6N
 6j2Ge46vMOLhmSoDYfq6uKHqkq6DfVQEEyiT8BNCVyQHLXylmtD457MVurPlTp1/S4vlfYLiv
 ECWjUl5ZNcgOymDjHq6sSkH0B7T+kT04qPYGgjzmsNjS6jwLzgkLU3ZZPsSsFT1tyU8udbPIx
 fwOfHKKL75Ca0xKvYXvTl9zokuYg2VzdBn1YpLKO5mJEf9BHJPiVZ62ywyJkR8ZWiapxi5f8D
 30A4kLS9VZp5LASX+xsmhvOI9ZJETbXrRvPpp+x5WrNxi2n9mLYlS+a2XHLI1S2AMw/wPHs1z
 dMrU7h0Wqb+gJ5FOVytQ4EaKQSsPrn3hctpehbN+nzxRHzZiXl4Y9sG5hdvxUacLIvWvjK5QK
 Mmt4DR3qgK2pUZWMXhn55flVW8RR53rMHHyADTlw7WAASxYZ8+57mnXqKx8z33Lk7LvQ9cxud
 9B52rs9l9423+NbAS1u3vq45uoYXuWbAjxEVcKzgfMPcv41wnQxC0dhcPTTo8Tn1P9UwtWnrz
 wu3Zq2KXuVgr02fM1dqMThfogW5aU1hrQPS4Pw5VRvWX/q7zF82N9n4hVsM9LvML9Q+mgn2rB
 bhgSbbh7IlL9erbswjdt6OBvGdn++hPP9ieJO3fNzoI8hs/yeRGifoBO/AW8BwYiykMvezMzF
 uPrgy1/rYts4csPdhjvCspFEQtkKn0JU0WKJDV9yCCb+/nodHjOcLsfll4I5j4gBRPEvncs4V
 P5HE1gpbRLGo4Q9vdDgxzqdIxTk=
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

On 9/14/23 09:42, Wu, Fei wrote:
> On 9/14/2023 3:20 PM, Heinrich Schuchardt wrote:
>> On 9/14/23 08:48, Wu, Fei wrote:
>>> On 9/14/2023 2:05 PM, Heinrich Schuchardt wrote:
>>>>
>>>>
>>>> Am 14. September 2023 07:30:55 MESZ schrieb Fei Wu <fei2.wu@intel.com=
>:
>>>>> In order to enable PCIe passthrough on qemu riscv, the physical memo=
ry
>>>>> range between 3GB and 4GB is reserved. Therefore if guest has 4GB ra=
m,
>>>>> two ranges are created as [2G, 3G) and [4G, 7G), currently u-boot se=
ts
>>>>> ram_top to 4G - 1 if the gd->ram_top is above 4G in
>>>>
>>>> This should move to 7GiB - 1 in your example on riscv64.
>>>>
>>> I'm describing the current implementation of board_get_usable_ram_top(=
)
>>> in ./arch/riscv/cpu/generic/dram.c. Do you mean this function should b=
e
>>> changed? Is the comment about 32bit DMA device still valid?
>>>
>>> phys_size_t board_get_usable_ram_top(phys_size_t total_size)
>>> {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure that =
we run from first 4GB so that all
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * addresses us=
ed by U-Boot are 32bit addresses.
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This in-turn=
 ensures that 32bit DMA capablehe
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devices work=
 fine because DMA mapping APIs will
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * provide 32bi=
t DMA addresses only.
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gd->ram_top >=3D=
 SZ_4G)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return SZ_4G - 1;
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gd->ram_top;
>>> }
>>
>> The comment above says 32bit DMA is board specific and not architecture
>> specific. So it is wrong to have this board_get_usable_ram_top()
>> function on architecture level. It makes usage of devices with all
>> memory above 4 GiB impossible.

@Anup:

The generic code was introduced by your patch 26f4fd1cb4f6 ("riscv:
generic: Ensure that U-Boot runs within 4GB for 64bit systems").

Which devices have that 32bit DMA issue?

fu540, fu740, jh7110 already have a cpu specific implementation and
don't need the generic one.

>>
>> It tried to pass through a SATA controller but received an error:
>>
>> # modprobe vfio-pci
>> # echo 0000:06:00.0 > /sys/bus/pci/drivers/ahci/unbind
>> # echo 1022 7091 > /sys/bus/pci/drivers/vfio-pci/new_id
>> # qemu-system-riscv64 -kernel u-boot.bin -nographic -M virt -m 4G
>> -device vfio-pci,host=3D0000:06:00.0
>> qemu-system-riscv64: -device vfio-pci,host=3D0000:06:00.0: VFIO_MAP_DMA
>> failed: Invalid argument
>> qemu-system-riscv64: -device vfio-pci,host=3D0000:06:00.0: vfio
>> 0000:06:00.0: failed to setup container for group 5: memory listener
>> initialization failed: Region riscv_virt_board.ram:
>> vfio_dma_map(0x55adbde66f70, 0x80000000, 0x100000000, 0x7fcd6fe00000) =
=3D
>> -22 (Invalid argument)
>>
>> With which version of QEMU were you able to use PCI pass through?
>>
> Please try this:
>
> base: ccb86f079a9e
> patch:
> https://lore.kernel.org/all/CAKmqyKMtAzt5saCUMd4vXYfgAQibpzQJAhtTSuSb+ye=
KhcYpfw@mail.gmail.com/T/

@Fei

With that patch I see the two memory banks in QEMU but when I attach a
vfio-pci device my whole system crashes and becomes unresponsive but
that is not a U-Boot issue.

Best regards

Heinrich

>
> Thanks,
> Fei.
>
>> Best regards
>>
>> Heinrich
>>
>>>
>>>>> board_get_usable_ram_top(), but that address is not backed by ram. T=
his
>>>>> patch selects the lowest range instead.
>>>>>
>>>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>>>> ---
>>>>> arch/riscv/cpu/generic/dram.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 2 +-
>>>>> configs/qemu-riscv64_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 2 +-
>>>>> configs/qemu-riscv64_smode_defconfig | 2 +-
>>>>> configs/qemu-riscv64_spl_defconfig=C2=A0=C2=A0 | 2 +-
>>>>> 4 files changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/cpu/generic/dram.c
>>>>> b/arch/riscv/cpu/generic/dram.c
>>>>> index 44e11bd56c..fb53a57b4e 100644
>>>>> --- a/arch/riscv/cpu/generic/dram.c
>>>>> +++ b/arch/riscv/cpu/generic/dram.c
>>>>> @@ -13,7 +13,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>>>>
>>>>> int dram_init(void)
>>>>> {
>>>>> -=C2=A0=C2=A0=C2=A0 return fdtdec_setup_mem_size_base();
>>>>> +=C2=A0=C2=A0=C2=A0 return fdtdec_setup_mem_size_base_lowest();
>>>>
>>>> Linaro is working on allowing to download a distro image via https
>>>> and installing from a RAM disk.
>>>>
>>>> We should not artificially reduce the RAM size available for U-Boot
>>>> by restricting ourselfs to 1 GiB.
>>>>
>>>> We must ensure that ram top is in the upper range.
>>>>
>>> How do they handle the case of >4GB? board_get_usable_ram_top() attach=
ed
>>> above always returns <4GB. And it seems like
>>> fdtdec_setup_mem_size_base() cannot ensure the upper one is picked, it
>>> just picks up one, but which one is selected depending on fdt.
>>>
>>> Thanks,
>>> Fei.
>>>
>>>> Best regards
>>>>
>>>> Heinrich
>>>>
>>>>> }
>>>>>
>>>>> int dram_init_banksize(void)
>>>>> diff --git a/configs/qemu-riscv64_defconfig
>>>>> b/configs/qemu-riscv64_defconfig
>>>>> index 9a8bbef192..aa55317d26 100644
>>>>> --- a/configs/qemu-riscv64_defconfig
>>>>> +++ b/configs/qemu-riscv64_defconfig
>>>>> @@ -1,6 +1,6 @@
>>>>> CONFIG_RISCV=3Dy
>>>>> CONFIG_SYS_MALLOC_LEN=3D0x800000
>>>>> -CONFIG_NR_DRAM_BANKS=3D1
>>>>> +CONFIG_NR_DRAM_BANKS=3D2
>>>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>>>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
>>>>> CONFIG_ENV_SIZE=3D0x20000
>>>>> diff --git a/configs/qemu-riscv64_smode_defconfig
>>>>> b/configs/qemu-riscv64_smode_defconfig
>>>>> index 1d0f021ade..de08a49dab 100644
>>>>> --- a/configs/qemu-riscv64_smode_defconfig
>>>>> +++ b/configs/qemu-riscv64_smode_defconfig
>>>>> @@ -1,6 +1,6 @@
>>>>> CONFIG_RISCV=3Dy
>>>>> CONFIG_SYS_MALLOC_LEN=3D0x800000
>>>>> -CONFIG_NR_DRAM_BANKS=3D1
>>>>> +CONFIG_NR_DRAM_BANKS=3D2
>>>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>>>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
>>>>> CONFIG_ENV_SIZE=3D0x20000
>>>>> diff --git a/configs/qemu-riscv64_spl_defconfig
>>>>> b/configs/qemu-riscv64_spl_defconfig
>>>>> index bb10145e6e..66dc2a1dd9 100644
>>>>> --- a/configs/qemu-riscv64_spl_defconfig
>>>>> +++ b/configs/qemu-riscv64_spl_defconfig
>>>>> @@ -1,6 +1,6 @@
>>>>> CONFIG_RISCV=3Dy
>>>>> CONFIG_SYS_MALLOC_LEN=3D0x800000
>>>>> -CONFIG_NR_DRAM_BANKS=3D1
>>>>> +CONFIG_NR_DRAM_BANKS=3D2
>>>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>>>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
>>>>> CONFIG_ENV_SIZE=3D0x20000
>>>
>>
>

