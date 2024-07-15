Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357DCC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F5E887FA;
	Mon, 15 Jul 2024 12:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YX7OaHMA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1935488804; Mon, 15 Jul 2024 12:20:10 +0200 (CEST)
Received: from mail-m25495.xmail.ntesmail.com (mail-m25495.xmail.ntesmail.com
 [103.129.254.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEEC8887F3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=YX7OaHMARRip3RryzYAx5MQqTvBb+PSleLUTKHqvouD98rhCOrplPb7oWxhBj/X5pl8B8WpAeViAdgI0J1Sx1HZBEthtCwKiTBIap7p7MkwUjJRaQUKpbQroFYji+RLQFZCvSzPLOTWiQ10JPV4er6Le4qsGR2cLl8fy37+Bp30=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=0O6mU55xCqel5ql/t+0XzMgv3Qhe0UFwdJmhm+IVfK8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 610AE900716;
 Mon, 15 Jul 2024 18:19:55 +0800 (CST)
Message-ID: <6a71b872-50b0-44ef-b7c9-dcf7f366cb56@rock-chips.com>
Date: Mon, 15 Jul 2024 18:19:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 22/23] sysreset: rockchip: use fst reset for ARM64
 SOC
To: Jonas Karlman <jonas@kwiboo.se>, Anand Moon <linux.amoon@gmail.com>
Cc: Anand Moon <anand@edgeble.ai>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@edgeble.ai>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20240531141837.13189-1-linux.amoon@gmail.com>
 <20240531141837.13189-23-linux.amoon@gmail.com>
 <99479aa4-6bdf-4265-b30f-ab571ec3adca@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <99479aa4-6bdf-4265-b30f-ab571ec3adca@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx5CSFYdGR0YGkgdQkJCQx1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b5e7f41303a9kunm610ae900716
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBg6GTo5TTI*LhoICBANOApD
 ISlPCz9VSlVKTElKS0hDTEJNSkhMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITU9MNwY+
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


On 2024/6/1 00:44, Jonas Karlman wrote:
> Hi Anand and Kever,
>
> On 2024-05-31 16:18, Anand Moon wrote:
>> From: Kever Yang <kever.yang@rock-chips.com>
>>
>> Rockchip ARM64 SOC will change cpu entry, only fst reset can reset it.
> What is this trying to fix? And what SoCs is affected?

Both fst and snd softreset are available for SoCs, but the fst reset 
more thing.

This commit msg is about: in some case the CPU entry may change after 
system boot,

eg. the wakeup code for deep sleep mode(which may power off) is locate 
at a different address;

with fst reset, the CPU entry is reset to the one bootRom used but the 
snd reset can not.

All the mass produced product with ARM64 SoCs are using the first global 
reset for warn reset now.


Thanks,
- Kever
> My arm64 RK SoCs seem to reset using warm reset (second global reset).
>
>> Cc: Jagan Teki <jagan@edgeble.ai>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>   drivers/sysreset/sysreset_rockchip.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
>> index f353f9b4c7..17aa191349 100644
>> --- a/drivers/sysreset/sysreset_rockchip.c
>> +++ b/drivers/sysreset/sysreset_rockchip.c
>> @@ -22,7 +22,12 @@ int rockchip_sysreset_request(struct udevice *dev, enum sysreset_t type)
>>   
>>   	switch (type) {
>>   	case SYSRESET_WARM:
>> +#ifdef CONFIG_ARM64
>> +		/* Rockchip 64bit SOC need fst reset for cpu reset entry */
>> +		writel(0xfdb9, cru_base + offset->glb_srst_fst_value);
>> +#else
>>   		writel(0xeca8, cru_base + offset->glb_srst_snd_value);
>> +#endif
> If this is needed maybe use something like this and let it fall through
> to SYSRESET_COLD?
>
>    if (!IS_ENABLED(CONFIG_ARM64)) {
> 	writel(0xeca8, cru_base + offset->glb_srst_snd_value);
> 	break;
>    }
>
> Regards,
> Jonas
>
>>   		break;
>>   	case SYSRESET_COLD:
>>   		writel(0xfdb9, cru_base + offset->glb_srst_fst_value);
