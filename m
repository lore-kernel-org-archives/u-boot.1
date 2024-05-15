Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD734C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 09:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C7AA870AB;
	Wed, 15 May 2024 11:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715764797;
	bh=ilpcSz/GSNTaAuZ9pbLH4kB/0mPSpN823K04jZeOIFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bJ+eC3mt4QL83cR0ixr098w4N/TzhQKO9aTiMsmQ5Ip40cjY9o65t6CCgTlk99ukf
	 F3MbxyQnekTPSxyKTtrTM0LrsLaPDPfRzdQoF8odoonEcYxYGGyqAC2yqLAHtqWxaI
	 koAS7xcJhFJU1dBjqMzZCB8a//hh4EOWC8CXyPcF/VmZTRJpZuub6L6FVlGQmbAINy
	 L6ppGE1j8oQnS2ha+kw+ZmLlFFfqqIt8pbhFrckKMFkaNeQDqw4kiEfRi8xL2To4pv
	 ts+hKNNLjbvoT4xfX2rW0bjTYohq6thDIy90lFb5ak3DQrDH4VsICkgQxYZQXQmA6Y
	 3+m7bM6xK8Seg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703AE88247; Wed, 15 May 2024 11:19:56 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED2F986EB5
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 11:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4VfSNl3tf2z9t11;
 Wed, 15 May 2024 11:19:51 +0200 (CEST)
Message-ID: <c18ac7ea-7475-4b21-bb7a-e8e6ac882591@denx.de>
Date: Wed, 15 May 2024 11:19:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] drivers: misc: Add driver to access ZynqMP efuses
Content-Language: en-US
To: Lukas Funke <lukas.funke-oss@weidmueller.com>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Peng Fan
 <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Wan Yee Lau <wan.yee.lau@intel.com>
References: <20240514140416.156747-1-lukas.funke-oss@weidmueller.com>
 <20240514140416.156747-4-lukas.funke-oss@weidmueller.com>
 <aef8d0d5-15ff-4c6a-84bb-462675717b5a@denx.de>
 <b70f810e-7cf2-4236-b199-b88d8e4c4947@weidmueller.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <b70f810e-7cf2-4236-b199-b88d8e4c4947@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VfSNl3tf2z9t11
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

Hi Lukas,

On 5/15/24 08:33, Lukas Funke wrote:
> Hi Stefan,
> 
> On 15.05.2024 08:12, Stefan Roese wrote:
>> Hi Lukas,
>>
>> On 5/14/24 16:04, lukas.funke-oss@weidmueller.com wrote:
>>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>>
>>> Add driver to access ZynqMP efuses. This is a u-boot port of [1].
>>>
>>> [1] 
>>> https://lore.kernel.org/all/20240224114516.86365-8-srinivas.kandagatla@linaro.org/
>>>
>>> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
>>> ---
>>>
>>>   drivers/misc/Kconfig        |   8 ++
>>>   drivers/misc/Makefile       |   1 +
>>>   drivers/misc/zynqmp_efuse.c | 213 ++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 222 insertions(+)
>>>   create mode 100644 drivers/misc/zynqmp_efuse.c
>>>
>>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>>> index 6009d55f400..c07f50c9a76 100644
>>> --- a/drivers/misc/Kconfig
>>> +++ b/drivers/misc/Kconfig
>>> @@ -298,6 +298,14 @@ config FSL_SEC_MON
>>>         Security Monitor can be transitioned on any security failures,
>>>         like software violations or hardware security violations.
>>> +config ZYNQMP_EFUSE
>>> +    bool "Enable ZynqMP eFUSE Driver"
>>> +    depends on ZYNQMP_FIRMWARE
>>> +    help
>>> +      Enable access to Zynq UltraScale (ZynqMP) eFUSEs thought PMU 
>>> firmware
>>> +      interface. ZnyqMP has 256 eFUSEs where some of them are 
>>> security related
>>> +      and cannot be read back (i.e. AES key).
>>> +
>>>   choice
>>>       prompt "Security monitor interaction endianess"
>>>       depends on FSL_SEC_MON
>>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>>> index e53d52c47b3..68ba5648eab 100644
>>> --- a/drivers/misc/Makefile
>>> +++ b/drivers/misc/Makefile
>>> @@ -92,3 +92,4 @@ obj-$(CONFIG_ESM_K3) += k3_esm.o
>>>   obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
>>>   obj-$(CONFIG_SL28CPLD) += sl28cpld.o
>>>   obj-$(CONFIG_SPL_SOCFPGA_DT_REG) += socfpga_dtreg.o
>>> +obj-$(CONFIG_ZYNQMP_EFUSE) += zynqmp_efuse.o
>>> diff --git a/drivers/misc/zynqmp_efuse.c b/drivers/misc/zynqmp_efuse.c
>>> new file mode 100644
>>> index 00000000000..0cfc42a4f39
>>> --- /dev/null
>>> +++ b/drivers/misc/zynqmp_efuse.c
>>> @@ -0,0 +1,213 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * (C) Copyright 2014 - 2015 Xilinx, Inc.
>>> + * Michal Simek <michal.simek@amd.com>
>>> + *
>>> + * (C) Copyright 2024 Weidmueller Interface GmbH
>>> + * Lukas Funke <lukas.funke@weidmueller.com>
>>> + */
>>> +
>>> +#include <compiler.h>
>>> +#include <linux/types.h>
>>> +#include <linux/errno.h>
>>> +#include <zynqmp_firmware.h>
>>> +#include <asm/dma-mapping.h>
>>> +#include <dm.h>
>>> +#include <dm/device_compat.h>
>>> +#include <misc.h>
>>> +
>>> +#define SILICON_REVISION_MASK 0xF
>>> +#define P_USER_0_64_UPPER_MASK    0x5FFF0000
>>> +#define P_USER_127_LOWER_4_BIT_MASK 0xF
>>> +#define WORD_INBYTES        (4)
>>> +#define SOC_VER_SIZE        (0x4)
>>> +#define EFUSE_MEMORY_SIZE    (0x177)
>>> +#define UNUSED_SPACE        (0x8)
>>> +#define ZYNQMP_NVMEM_SIZE    (SOC_VER_SIZE + UNUSED_SPACE + \
>>> +                 EFUSE_MEMORY_SIZE)
>>> +#define SOC_VERSION_OFFSET    (0x0)
>>> +#define EFUSE_START_OFFSET    (0xC)
>>> +#define EFUSE_END_OFFSET    (0xFC)
>>> +#define EFUSE_PUF_START_OFFSET    (0x100)
>>> +#define EFUSE_PUF_MID_OFFSET    (0x140)
>>> +#define EFUSE_PUF_END_OFFSET    (0x17F)
>>> +#define EFUSE_NOT_ENABLED    (29)
>>> +#define EFUSE_READ        (0)
>>> +#define EFUSE_WRITE        (1)
>>> +
>>> +/**
>>> + * struct xilinx_efuse - the basic structure
>>> + * @src:    address of the buffer to store the data to be write/read
>>> + * @size:    no of words to be read/write
>>> + * @offset:    offset to be read/write`
>>> + * @flag:    0 - represents efuse read and 1- represents efuse write
>>> + * @pufuserfuse:0 - represents non-puf efuses, offset is used for 
>>> read/write
>>> + *        1 - represents puf user fuse row number.
>>> + *
>>> + * this structure stores all the required details to
>>> + * read/write efuse memory.
>>> + */
>>> +struct xilinx_efuse {
>>> +    u64 src;
>>> +    u32 size;
>>> +    u32 offset;
>>> +    u32 flag;
>>> +    u32 pufuserfuse;
>>> +};
>>> +
>>> +static int zynqmp_efuse_access(struct udevice *dev, unsigned int 
>>> offset,
>>> +                   void *val, size_t bytes, unsigned int flag,
>>> +                   unsigned int pufflag)
>>> +{
>>> +    size_t words = bytes / WORD_INBYTES;
>>> +    ulong dma_addr, dma_buf;
>>> +    struct xilinx_efuse *efuse;
>>> +    char *data;
>>> +    int ret, value;
>>> +
>>> +    if (bytes % WORD_INBYTES != 0) {
>>> +        dev_err(dev, "Bytes requested should be word aligned\n");
>>> +        return -EOPNOTSUPP;
>>> +    }
>>> +
>>> +    if (pufflag == 0 && offset % WORD_INBYTES) {
>>> +        dev_err(dev, "Offset requested should be word aligned\n");
>>> +        return -EOPNOTSUPP;
>>> +    }
>>> +
>>> +    if (pufflag == 1 && flag == EFUSE_WRITE) {
>>> +        memcpy(&value, val, bytes);
>>> +        if ((offset == EFUSE_PUF_START_OFFSET ||
>>> +             offset == EFUSE_PUF_MID_OFFSET) &&
>>> +            value & P_USER_0_64_UPPER_MASK) {
>>> +            dev_err(dev, "Only lower 4 bytes are allowed to be 
>>> programmed in P_USER_0 & P_USER_64\n");
>>> +            return -EOPNOTSUPP;
>>> +        }
>>> +
>>> +        if (offset == EFUSE_PUF_END_OFFSET &&
>>> +            (value & P_USER_127_LOWER_4_BIT_MASK)) {
>>> +            dev_err(dev, "Only MSB 28 bits are allowed to be 
>>> programmed for P_USER_127\n");
>>> +            return -EOPNOTSUPP;
>>> +        }
>>> +    }
>>> +
>>> +    efuse = dma_alloc_coherent(sizeof(struct xilinx_efuse), &dma_addr);
>>> +    if (!efuse)
>>> +        return -ENOMEM;
>>> +
>>> +    data = dma_alloc_coherent(bytes, &dma_buf);
>>> +    if (!data) {
>>> +        dma_free_coherent(efuse);
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    if (flag == EFUSE_WRITE) {
>>> +        memcpy(data, val, bytes);
>>> +        efuse->flag = EFUSE_WRITE;
>>> +    } else {
>>> +        efuse->flag = EFUSE_READ;
>>> +    }
>>> +
>>> +    efuse->src = dma_buf;
>>> +    efuse->size = words;
>>> +    efuse->offset = offset;
>>> +    efuse->pufuserfuse = pufflag;
>>> +
>>> +    flush_dcache_range((ulong)efuse, (ulong)efuse +
>>> +                   roundup(sizeof(struct xilinx_efuse), 
>>> ARCH_DMA_MINALIGN));
>>> +    flush_dcache_range((ulong)data, (ulong)data +
>>> +                   roundup(sizeof(struct xilinx_efuse), 
>>> ARCH_DMA_MINALIGN));
>>
>> efuse and data are allocated via dma_alloc_coherent(). It should not be
>> necessary to use flush the cache here IIUTC.
> 
> If I understand correctly dma_alloc_coherent() maps to an aligned 
> malloc() which in turn just returns some physical memory without any 
> caching attributes (is this correct?). We have to ensure that the data 
> written here is *not* cached but written back to memory because the PMU 
> is running on a co-processor and data is exchanged via DRAM.

Frankly, I did not look into the U-Boot implementation of
dma_alloc_coherent() - I've rarely seen it here before. But the
original implementation in Linux guarantees that "DMA safe" (uncached)
memory is allocated AFAIU.

> Also: this is the way it was implemented in the other PMU calls as well.

Agreed. I also would copy such stuff from already existing code. Even
though this could be wrong from the beginning.

I just stumbled over this and wondered, if this really is needed
this way.

Thanks,
Stefan

>>
>>> +
>>> +    zynqmp_pm_efuse_access(dma_addr, (u32 *)&ret);
>>> +    if (ret != 0) {
>>> +        if (ret == EFUSE_NOT_ENABLED) {
>>> +            dev_err(dev, "efuse access is not enabled\n");
>>> +            ret = -EOPNOTSUPP;
>>> +            goto END;
>>> +        }
>>> +        dev_err(dev, "Error in efuse read %x\n", ret);
>>> +        ret = -EPERM;
>>> +        goto END;
>>> +    }
>>> +
>>> +    if (flag == EFUSE_READ)
>>> +        memcpy(val, data, bytes);
>>> +END:
>>
>> Nitpicking: Upper case label ist pretty uncommon AFAIK.
> 
> Since this is a port of the actual Linux driver I wanted to change as 
> little as possible. If this is absolutly not acceptable I'm open to 
> change this.
> 
> BTW: thanks for your review!
> 
>>
>>> +
>>> +    dma_free_coherent(efuse);
>>> +    dma_free_coherent(data);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int zynqmp_nvmem_read(struct udevice *dev, int offset,
>>> +                 void *val, int bytes)
>>> +{
>>> +    int ret, pufflag = 0;
>>> +    int idcode, version;
>>> +
>>> +    if (offset >= EFUSE_PUF_START_OFFSET && offset <= 
>>> EFUSE_PUF_END_OFFSET)
>>> +        pufflag = 1;
>>> +
>>> +    dev_dbg(dev, "reading from offset=0x%x, bytes=%d\n", offset, 
>>> bytes);
>>> +
>>> +    switch (offset) {
>>> +    /* Soc version offset is zero */
>>> +    case SOC_VERSION_OFFSET:
>>> +        if (bytes != SOC_VER_SIZE)
>>> +            return -EOPNOTSUPP;
>>> +
>>> +        ret = zynqmp_pm_get_chipid((u32 *)&idcode, (u32 *)&version);
>>> +        if (ret < 0)
>>> +            return ret;
>>> +
>>> +        *(int *)val = version & SILICON_REVISION_MASK;
>>> +        break;
>>> +    /* Efuse offset starts from 0xc */
>>> +    case EFUSE_START_OFFSET ... EFUSE_END_OFFSET:
>>> +    case EFUSE_PUF_START_OFFSET ... EFUSE_PUF_END_OFFSET:
>>> +        ret = zynqmp_efuse_access(dev, offset, val,
>>> +                      bytes, EFUSE_READ, pufflag);
>>> +        break;
>>> +    default:
>>> +        *(u32 *)val = 0xDEADBEEF;
>>> +        ret = 0;
>>> +        break;
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int zynqmp_nvmem_write(struct udevice *dev, int offset, const 
>>> void *val,
>>> +                  int bytes)
>>> +{
>>> +    int pufflag = 0;
>>> +
>>> +    dev_dbg(dev, "writing to offset=0x%x, bytes=%d", offset, bytes);
>>> +
>>> +    if (offset < EFUSE_START_OFFSET || offset > EFUSE_PUF_END_OFFSET)
>>> +        return -EOPNOTSUPP;
>>> +
>>> +    if (offset >= EFUSE_PUF_START_OFFSET && offset <= 
>>> EFUSE_PUF_END_OFFSET)
>>> +        pufflag = 1;
>>> +
>>> +    return zynqmp_efuse_access(dev, offset,
>>> +                   (void *)val, bytes, EFUSE_WRITE, pufflag);
>>> +}
>>> +
>>> +static const struct udevice_id zynqmp_efuse_match[] = {
>>> +    { .compatible = "xlnx,zynqmp-nvmem-fw", },
>>> +    { /* sentinel */ },
>>> +};
>>> +
>>> +static const struct misc_ops zynqmp_efuse_ops = {
>>> +    .read = zynqmp_nvmem_read,
>>> +    .write = zynqmp_nvmem_write,
>>> +};
>>> +
>>> +U_BOOT_DRIVER(zynqmp_efuse) = {
>>> +    .name = "zynqmp_efuse",
>>> +    .id = UCLASS_MISC,
>>> +    .of_match = zynqmp_efuse_match,
>>> +    .ops = &zynqmp_efuse_ops,
>>> +};
>>
>> Viele Grüße,
>> Stefan Roese
>>
> 
> Best regards
>   - Lukas
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
