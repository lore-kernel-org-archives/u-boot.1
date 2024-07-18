Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A20C3DA60
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 08:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57A8C88A3A;
	Thu, 18 Jul 2024 10:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JVOXt5Hx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F100F88B08; Thu, 18 Jul 2024 10:33:36 +0200 (CEST)
Received: from mail-m121149.qiye.163.com (mail-m121149.qiye.163.com
 [115.236.121.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C3A087C68
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=JVOXt5HxcI522V+8nO6U3yTkRTOOz+4MSRMwYKbZbPSM0KjrXmQzri6LjvS1l0sBRl56xg+Fa39g+nas9Nd94w6dJAZynuvBC0lSmsO5dspmMF3U8s4Qc9muoZSz0Sr1Xg9AJc0+vzfUmrjbip6ISu8IuaPG10pHo9j+fvEfg1U=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=cgZPf4tycjdE83xTdHTY062oB5FiVmvLdkIbT+Y4b5g=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A86249005D2;
 Thu, 18 Jul 2024 16:33:27 +0800 (CST)
Message-ID: <d5d9a5de-4258-4f21-80d1-e819f0ed4b3a@rock-chips.com>
Date: Thu, 18 Jul 2024 16:33:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request: u-boot-rockchip-20240614
To: Quentin Schulz <quentin.schulz@cherry.de>, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20240718035200.394004-1-kever.yang@rock-chips.com>
 <fd320bf7-1296-490b-9441-83ac4ccb8182@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <fd320bf7-1296-490b-9441-83ac4ccb8182@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktCQ1YeSB9ITR1CGE9PHxhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90c4f98f2003a9kunma86249005d2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PyI6Ihw6CTI5GBVWAz4jEREp
 LDQaCQFVSlVKTElKSUJKTUtDSUlNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTUpONwY+
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

Hi Quentin,


On 2024/7/18 16:03, Quentin Schulz wrote:
> Hi Kever,
>
> On 7/18/24 5:52 AM, Kever Yang wrote:
>> Hi Tom,
>>
>> Please pull the fixex for rockchip platform:
>> - pmic fix for rk8xx;
>> - pinctrl fix for rk3188/rv1126/rk3588;
>> - mkimage fix for rockcihp "-l" option;
>>
>
> I think this is a mistake? All commits are already merged. I assume 
> you picked the wrong tag when opening the MR?

Yes, I send the wrong file.


Thanks,

- Kever

>
> Cheers,
> Quentin
