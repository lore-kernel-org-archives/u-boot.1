Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA47CE7D241
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27BB686D84;
	Tue, 26 Sep 2023 09:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="t/FZRAVl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EB9B86D85; Tue, 26 Sep 2023 09:03:57 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E3A386BCE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E95BA3F67E
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1695711834;
 bh=z0jyshB52iXWUR1S4h6K5cqXt21fsDxBhvLE/ilTZrM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=t/FZRAVltZM/ya7Od7FJ2FjNW/uWG1BX8IphyBTjuJ4hpNQ1f5iYlMQXDdiZL9/Je
 rnR2SW4T3KzWCmlFGaCYc1ph3vVL+FY6QQOarEPlsbkzZDkb+SDw5+fVJvDAPVFoD+
 BlYbwXB+ZjajErjvrGgv9y3EmloM7VlzoK9RXr97ln0GiO4Sv3DaWquLKVcV29I5ph
 DdmNEARBdsSaSIbVsKexIYWx3Imk1Tk8S5WZzJd6Q5YaCardW3XRXRP5DH5eS+3Y/M
 s5vVN3G+DcKKRDYIiEvBCdUM/nex+Y6YrNnmfkAJ5Gsk+JIGrjaXYGrET5H8Za5vYV
 Jz4xRvico+XVA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fd0fa4d08cso67572935e9.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 00:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711834; x=1696316634;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z0jyshB52iXWUR1S4h6K5cqXt21fsDxBhvLE/ilTZrM=;
 b=vCIaRDMzweTe0NHFLXl/+XZhQxHOZ0w7wll/G93ynNlhqn2kYszxkraCqPTTx7pmK7
 7d/qHN2UDAeQDhkpc3gbLxKyX16f16KdkVwTThNCwuiLqB2S0u3cpuc2/zBSLr8f77eO
 GOL5SfvpHOF7wR+NwR1exMS8MeG7WI+m1PwmIzCT9m5xV+UMo6UisYoXGB710u0h6jnr
 8ESrvGoMB8oSwbIQglhd0le+jjpYY+EKog05uEtySoosKw0IdnwOPchSmmnMdoDR8Upu
 WU24hRI0/++TjejhOFU/PD4UUrytPkfLvtzuOxb6FfDecPUfpfrey+m+qR7LMYA2dxGj
 4Psw==
X-Gm-Message-State: AOJu0YxTXM9x1o16qyNtIXHvhZjxtJB+iiFKY5lkHktcze1FWFm9h/kO
 51Z1ohW9vSTyDTzhA1V4dcl72kHL8u2tN+iX4TCu21pXFzm4NS0mxgrdmckdX8Suxb1Cuxs/v7r
 ACSfriDp175LaASle3G4AsBnQHaWW/uQ=
X-Received: by 2002:a7b:c3cb:0:b0:402:bbe3:827c with SMTP id
 t11-20020a7bc3cb000000b00402bbe3827cmr7172724wmj.31.1695711834475; 
 Tue, 26 Sep 2023 00:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4xRA0zNgmm1qcHwnfCkJnisX5sQjuz0I1hX3XoW5WWILBRNQO6SGaQLvp0WSOe4DN+8ITag==
X-Received: by 2002:a7b:c3cb:0:b0:402:bbe3:827c with SMTP id
 t11-20020a7bc3cb000000b00402bbe3827cmr7172648wmj.31.1695711834079; 
 Tue, 26 Sep 2023 00:03:54 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 p20-20020a05600c205400b00403b63e87f2sm1421569wmg.32.2023.09.26.00.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 00:03:53 -0700 (PDT)
Message-ID: <545fe813-cb1e-469c-a131-0025c77aeaa2@canonical.com>
Date: Tue, 26 Sep 2023 09:04:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: enable multi-range memory layout
To: Anup Patel <apatel@ventanamicro.com>
Cc: "Wu, Fei" <fei2.wu@intel.com>, rick@andestech.com, ycliang@andestech.com, 
 bmeng.cn@gmail.com, sjg@chromium.org, u-boot@lists.denx.de, pali@kernel.org,
 andrei.warkentin@intel.com, sunilvl@ventanamicro.com
References: <20230914053055.745507-1-fei2.wu@intel.com>
 <5D4FDDF5-5DEB-4A02-A423-C54662CCBFF0@gmx.de>
 <c23a28ff-475d-0921-502f-f475b0e51ebd@intel.com>
 <967f8765-67ac-48ff-970b-da8e431b5009@gmx.de>
 <CAK9=C2WzoyTr15PrR+TZ+KAq+RGVxJk7yrbUX9nR+kUWq0qGug@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAK9=C2WzoyTr15PrR+TZ+KAq+RGVxJk7yrbUX9nR+kUWq0qGug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/26/23 07:07, Anup Patel wrote:
> On Thu, Sep 14, 2023 at 12:49 PM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>>
>> On 9/14/23 08:48, Wu, Fei wrote:
>>> On 9/14/2023 2:05 PM, Heinrich Schuchardt wrote:
>>>>
>>>>
>>>> Am 14. September 2023 07:30:55 MESZ schrieb Fei Wu <fei2.wu@intel.com>:
>>>>> In order to enable PCIe passthrough on qemu riscv, the physical memory
>>>>> range between 3GB and 4GB is reserved. Therefore if guest has 4GB ram,
>>>>> two ranges are created as [2G, 3G) and [4G, 7G), currently u-boot sets
>>>>> ram_top to 4G - 1 if the gd->ram_top is above 4G in
>>>>
>>>> This should move to 7GiB - 1 in your example on riscv64.
>>>>
>>> I'm describing the current implementation of board_get_usable_ram_top()
>>> in ./arch/riscv/cpu/generic/dram.c. Do you mean this function should be
>>> changed? Is the comment about 32bit DMA device still valid?
>>>
>>> phys_size_t board_get_usable_ram_top(phys_size_t total_size)
>>> {
>>>           /*
>>>            * Ensure that we run from first 4GB so that all
>>>            * addresses used by U-Boot are 32bit addresses.
>>>            *
>>>            * This in-turn ensures that 32bit DMA capable
>>>            * devices work fine because DMA mapping APIs will
>>>            * provide 32bit DMA addresses only.
>>>            */
>>>           if (gd->ram_top >= SZ_4G)
>>>                   return SZ_4G - 1;
>>>
>>>           return gd->ram_top;
>>> }
>>
>> The comment above says 32bit DMA is board specific and not architecture
>> specific. So it is wrong to have this board_get_usable_ram_top()
>> function on architecture level. It makes usage of devices with all
>> memory above 4 GiB impossible.
>>
>> It tried to pass through a SATA controller but received an error:
>>
>> # modprobe vfio-pci
>> # echo 0000:06:00.0 > /sys/bus/pci/drivers/ahci/unbind
>> # echo 1022 7091 > /sys/bus/pci/drivers/vfio-pci/new_id
>> # qemu-system-riscv64 -kernel u-boot.bin -nographic -M virt -m 4G
>> -device vfio-pci,host=0000:06:00.0
>> qemu-system-riscv64: -device vfio-pci,host=0000:06:00.0: VFIO_MAP_DMA
>> failed: Invalid argument
>> qemu-system-riscv64: -device vfio-pci,host=0000:06:00.0: vfio
>> 0000:06:00.0: failed to setup container for group 5: memory listener
>> initialization failed: Region riscv_virt_board.ram:
>> vfio_dma_map(0x55adbde66f70, 0x80000000, 0x100000000, 0x7fcd6fe00000) =
>> -22 (Invalid argument)
>>
>> With which version of QEMU were you able to use PCI pass through?
> 
> The original S-mode SiFive unleashed board support was using the
> generic CPU under arch/riscv. We have Cadance MACB ethernet
> device on this board which is a 32-bit device and can't access memory
> beyond 4GB.
> 
> For more details, refer "git show 26f4fd1cb4f2"
> 
> I think we can wrap the board_get_usable_ram_top() implementation
> in generic RISC-V CPU with a #ifdef Kconfig option which allows
> certain boards (such as QEMU-virt) to implement their own
> board_get_usable_ram_top().
> 
> Regards,
> Anup

Thanks Anup for clarification.

As of today sifive_unleashed_defconfig builds 
arch/riscv/cpu/fu540/dram.c which contains the cpu specific 
implementation of board_get_usable_ram_top().

We already have a weak implementation

common/board_f.c:327:
__weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)

So we don't need a Kconfig option. We just can drop the implementation 
in arch/riscv/cpu/generic/dram.c.

QEMU should not need an implementation of the function but provide the 
implemented RAM banks via its device-tree.

Best regards

Heinrich
