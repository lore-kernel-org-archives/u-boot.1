Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A63AC83F34
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 04:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4492B836D1;
	Sat, 19 Jul 2025 06:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1752898824;
	bh=AlutBhhNu2H0IVCEkO0oWzLsOLb9LSfIjEHhf9S6A6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ctjaXifkux0guI1etjWV/8TbazS1gzPQWr4uDwEyPoo0LTA5DQQpVBcxgSUgi5nWJ
	 wY34TlRPxXVg2/hBcOKtdINE1hG3VDivM/anh9rUCfhjcbvGNiIIAbWazWGtJTNV5g
	 sEnaH+HtpgcJnDFBj8fAmPP29K9nxpWPu6RlRHrc6sXUPm82yJkic05v/5R/5v948d
	 bjs5MLSVLLr+2AJcUd4PrTiZnZx5gh34R/E6i2YgPvgapUaR96WAt8nFC43SUWyDFY
	 /U7/INY5P0sCHdsEUAt8pKHJ6+mMFmjsFyYXlldvA58cYo2oq224ovDpdAWuFubaPn
	 mMERILxfRETHw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5314836D5; Sat, 19 Jul 2025 06:20:22 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 083F4836C3
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 06:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="cJYJgtkG"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 093651026E991; 
 Sat, 19 Jul 2025 06:20:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1752898817;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=AlutBhhNu2H0IVCEkO0oWzLsOLb9LSfIjEHhf9S6A6M=;
 b=cJYJgtkG1mcmkMHABdHjXG+DUAdE71ysEmmYDShXu6B3FgtaAKYA8ZYerZipGLtwPuRtc5
 cw1ab/lJf+8KhFIB+Z97JPJpdrekP0QeO3bBS0YOSByXxW0A5CNN/qzyqHcqdZdh2QeWVs
 AyCiMu6QoVl++a+m+SiJd+jojlw2Z5wANEdVwEUHDdc3znQapsMbYoiC0hT2n75A3l+4dM
 My2CgeerWBLZ5iLzxh6Kt7Gkyv9J4KwcxIvwDOyiQyNDR/KA7VeWKGFpuWoyJOcmAuP2DV
 kBAE4n3OxmAz2Zg4+rK8DiogzHqViddh1F7V5v3OnsQ0zm4nsZkrcGQPl1laCg==
Message-ID: <3ef949d6-9c42-0876-d5a7-a055340d52df@denx.de>
Date: Sat, 19 Jul 2025 06:20:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Please pull u-boot-i2c master
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Frank Wunderlich <linux@fw-web.de>, Padmarao Begari
 <padmarao.begari@amd.com>, dinesh.maniyam@altera.com,
 Holger Brunck <holger.brunck@hitachi-powergrids.com>
References: <06c2b16e-1e3d-7632-70be-d6df4232ff71@denx.de>
 <20250718150113.GU193579@bill-the-cat>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250718150113.GU193579@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

On 18.07.25 17:01, Tom Rini wrote:
> On Thu, Jul 17, 2025 at 08:10:17AM +0200, Heiko Schocher wrote:
> 
>> Hello Tom,
>>
>> The following changes since commit 53bd87651e45b32efa398dd5e433d8b93d781445:
>>
>>    block: sandbox: Add support for SYS_64BIT_LBA (2025-07-11 11:33:25 -0600)
>>
>> are available in the Git repository at:
>>
>>    https://source.denx.de/u-boot/custodians/u-boot-i2c.git i2c-for-2025.10
>>
>> for you to fetch changes up to 5e80c6757378d09950235083533e7a7c3aeae3be:
>>
>>    configs: agilex5_defconfig: Enable i3c configs for agilex5 (2025-07-16 09:33:54 +0200)
>>
>> ----------------------------------------------------------------
>> i2c updates for v2025.10
>>
>> - i2c Kconfig updates from Tom
>>    - add some driver dependencies
>>    - added missing include delay.h in iproc_i2c.c
>>
>> - i2c: muxes: Add PCA9541 i2c arbitrator driver
>>    from Padmarao Begari
>>
>> - pca954x: add pca9545 support
>>    from Frank Wunderlich
>>
>> - cmd: i2c: fix build when CFG_SYS_I2C_NOPROBES defined with DM_I2C
>>    From Holger Brunck
>>
>> - added i3c support to U-Boot and enable it for agilex5
>>    board from Dinesh Maniyam
> 
> Unfortunately the i3c support leads to this in coreboot:
> https://source.denx.de/u-boot/u-boot/-/jobs/1202949/raw
> 
> Which looks like coreboot just gets stuck in a loop? And in turn, that
> lead me to do this locally:
> commit 03e9d5f4c61cba5d8e1db81d759fefd622b3ad49
> Author: Tom Rini <trini@konsulko.com>
> Date:   Thu Jul 17 15:22:08 2025 -0600
> 
>      hack drop generic changes
>      
>      Signed-off-by: Tom Rini <trini@konsulko.com>
> 
> diff --git a/include/dm/device.h b/include/dm/device.h
> index c5cfa18d09d6..678cd83c2716 100644
> --- a/include/dm/device.h
> +++ b/include/dm/device.h
> @@ -169,7 +169,6 @@ enum {
>    * @dma_offset: Offset between the physical address space (CPU's) and the
>    *		device's bus address space
>    * @iommu: IOMMU device associated with this device
> - * @of_node: Associated device tree node
>    */
>   struct udevice {
>   	const struct driver *driver;
> @@ -202,7 +201,6 @@ struct udevice {
>   #if CONFIG_IS_ENABLED(IOMMU)
>   	struct udevice *iommu;
>   #endif
> -	struct device_node	*of_node;
>   };
>   
>   static inline int dm_udevice_size(void)

Uff.. yep, overseen this change...

> Which leads me (a) being concerned about what our coreboot support is up
> to and (b) why i3c needs this generic change? And I don't just want to
> see CONFIG_IS_ENABLED()'ing it, why do we have to handle the device tree
> that way and is there no standard mechanism we can use?
> 

@dinesh: why do you need this?

It should be possible in the master driver to get the of pointer with


ofnode node = dev_ofnode(dev);

and if you really need it in drivers/i3c/master.c pass it to the
functions you call... ah, no, as you already save the udevice
in i3c_master_controller, you can simply use

dev_ofnode(dev)

in it!

You can simply drop of_node from generic file, and use dev_ofnode(dev)
in your driver/i3c code ... may you save the udevice in private data
or in your i3c_dev_boardinfo struct instead if really needed, so please
rework that part.

@Tom: I will drop i3c support from my pull request and send a new one

And yes, the question a) remains ...

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
