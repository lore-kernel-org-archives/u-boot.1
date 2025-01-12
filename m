Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29395E77188
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 22:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C792805C5;
	Sun, 12 Jan 2025 23:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736719588;
	bh=POAPxQsa4kGtVfZntZVcYy/Ktppje3dFvnBSmymIvz8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z9Knna+/Cn+BbkZVkB03PieOHAOUH5fApqIgzd6K6TMsE+IPjXlqOyZmduiV0cTiD
	 kp3xxOs8RV+dHH102E0w0QIbUp86lbImFpHdGi6VwdHOJExEbGtEJ12fHKmQCHQDJA
	 8+HRdeJ2wQ1ohUgtcMw3+FRP2Ko2uNzM0qxtWU+Td8MtLBiJ732XhGU1x/aQVrck51
	 p4WZ7C/YI1PVomeXyewNdXtF8dMMnRtnyElw5ifCikfF4atX0mbFFiONipTfs8UuPk
	 wR1G7Hl0lf0Qsk7cFIMyeEgYm/aqrxGaXATIuul9EKFNiJUb0AihX4fuO+A3PW596J
	 9iYRwvquLZRng==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 938678058A; Sun, 12 Jan 2025 23:06:27 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E49D80027
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 23:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="gnAsGrma"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4740D101D23A4; Sun, 12 Jan 2025 23:06:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736719584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=POAPxQsa4kGtVfZntZVcYy/Ktppje3dFvnBSmymIvz8=;
 b=gnAsGrmaZt/sRNWvvHH0huGHIryJu/TQxy+PNOJGHWTPmKvVhHnDCgUAWZ2MVCJvejVkat
 8Q2W5t93a3eeGSRB7GMPhNFQyAknYaq6K7tjqDkPmzveEA6yW18fbd0Wtj7RHTRR8/4ETM
 Um+4GyUWeJMd52mD0HyqLgQtrARP2QYpZI7WDE55cz36IQu7VVYj3bKuiNdoRHGLbAi6oF
 +QekIhTKAMnUOdM+g82fwMqt2uMXI28WFwCzEjJGLNf4l6H9Kb1j13Yx9weCIXtlOtbVRX
 Mw4RgdhhdbnhPMXOSBOtP6NK5oNpW8rLZiWnjuP0tEUU86XRsMV0eHrMFG7n4g==
Message-ID: <9c3f1a04-5d3e-4076-9497-55dbf3546060@denx.de>
Date: Sun, 12 Jan 2025 22:50:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/17] imx9: scmi: soc: Override h_spl_load_read with
 trampoline buffer
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 u-boot@lists.denx.de, tharvey@gateworks.com, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-11-6744df5dc020@oss.nxp.com>
 <e7f2e938-e6a1-4927-91d7-682ca9d683f9@denx.de>
 <20250110094941.GA23168@localhost.localdomain>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250110094941.GA23168@localhost.localdomain>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/10/25 10:49 AM, Peng Fan wrote:
> On Sun, Jan 05, 2025 at 10:56:29PM +0100, Marek Vasut wrote:
>> On 1/3/25 7:45 AM, Alice Guo wrote:
>>> From: Ye Li <ye.li@nxp.com>
>>>
>>> When SPL loading image to secure region, for example, ATF and tee to
>>> DDR secure region. Because the USDHC controller is non-secure master,
>>> it can't access this region and will cause loading issue.
>>>
>>> So override h_spl_load_read to use a trampoline buffer in nonsecure
>>> region, then use CPU to copy the image from trampoline buffer to
>>> destination secure region.
>>>
>>> Signed-off-by: Ye Li <ye.li@nxp.com>
>>> Signed-off-by: Alice Guo <alice.guo@nxp.com>
>>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>    arch/arm/mach-imx/imx9/scmi/soc.c | 40 +++++++++++++++++++++++++++++++++++++++
>>>    common/spl/spl_mmc.c              |  2 +-
>>>    2 files changed, 41 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
>>> index fefb1a6f4ca58722a5d93c39e4f6a7aaf85aa177..8a7df24afecc1d6d77b7162be639b56af95fd975 100644
>>> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
>>> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
>>> @@ -41,6 +41,8 @@
>>>    #include <scmi_agent.h>
>>>    #include <scmi_protocols.h>
>>>    #endif
>>> +#include <spl.h>
>>> +#include <mmc.h>
>>>    DECLARE_GLOBAL_DATA_PTR;
>>> @@ -830,3 +832,41 @@ enum boot_device get_boot_device(void)
>>>    	return boot_dev;
>>>    }
>>>    #endif
>>> +
>>> +ulong h_spl_load_read(struct spl_load_info *load, ulong off,
>>> +		      ulong size, void *buf)
>>
>> Can you simply define spl_get_load_buffer() instead to make sure SPL loads
>> your stuff into the correct location ?
> 
> spl_get_load_buffer does not help here, unless do a big change to spl_mmc.c
> h_spl_load_read is set to info->read, info->read is not just for reading
> headers, it also needs to read container image data.
> 
>>
>> This hack in generic code is a NAK.
> 
> This is set it as __weak, and overwrite in soc code, there are many
> similar code
The more I am looking at this, the more this simply does not work. 
Consider these use cases for example where this fails:

- Board boots from SPI NOR
- Board boots from filesystem on SD/eMMC

So what about taking a different approach. First, use the SPL loader 
as-is to load whatever blobs you need to memory locations into which you 
can load. Second, implement board or arch specific spl_perform_fixups(), 
which is already empty weak function, and make it move the blobs into 
the correct location. Would that work ?
