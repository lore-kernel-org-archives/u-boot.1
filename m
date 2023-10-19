Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D4ECDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 20:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E66F870A2;
	Thu, 19 Oct 2023 22:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GE8UfnPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50083871E8; Thu, 19 Oct 2023 22:40:16 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6698686F78
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 22:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b70c=GC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1697747989;
 bh=/MRhB5Bn9oLQ7vrUJg3PfbT/SSk+9ljqioGIlvwuxho=;
 b=GE8UfnPPndKEbaG7Z//oqmIZ7KqRPQ7IKyBp2DFgdUDVq0OoG2e7pZPjo1MKqmcD38rXmA8Y0
 PGQxXGynm6YFFXdhRbFl0t7rbxwNzIHj+sdXrOB8nyWRZWA5pb6yUDKQOm8gxiTDHJuTC+kxg5G
 TJWmslMnZOssRMp7uJzLohJTNtXhm8NI1zLTscqifuGD5xSs7eHQKPzc3QdCyqZokJOVeeElUHo
 6dzRx+1RnwmQlnVzif9FveXXJYy0gMvc6m7KcIKqYDNZmBY/hFD8zg1E59hvG9Y0rVjgzLB8eBh
 Ksb0whDvwTxsI+4sJCHh0Vm7KOlCTh0hzQc+Pl54fCmg==
Message-ID: <a755aeb3-90e8-cabc-c941-6700805017ec@kwiboo.se>
Date: Thu, 19 Oct 2023 22:39:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] configs: rockchip: Use dwc3-generic driver on RK3328
 and RK3399
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Nick Xie <nick@khadas.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Deepak Das <deepakdas.linux@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>, Xiaobo Tian <peterwillcn@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: u-boot@lists.denx.de
References: <20231018223058.2081052-1-jonas@kwiboo.se>
 <20231018223058.2081052-2-jonas@kwiboo.se>
 <0799d3c2-7997-4e78-aefb-fe571ebc53a4@denx.de>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <0799d3c2-7997-4e78-aefb-fe571ebc53a4@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65319414656a2ed50002a2b5
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

On 2023-10-19 01:44, Marek Vasut wrote:
> On 10/19/23 00:30, Jonas Karlman wrote:
> 
> [..]
> 
>> +++ b/configs/rock960-rk3399_defconfig
>> @@ -50,6 +50,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>   CONFIG_SYS_MMC_ENV_DEV=1
>>   CONFIG_ROCKCHIP_GPIO=y
>>   CONFIG_SYS_I2C_ROCKCHIP=y
>> +CONFIG_MISC=y
>>   CONFIG_MMC_DW=y
>>   CONFIG_MMC_DW_ROCKCHIP=y
>>   CONFIG_MMC_SDHCI=y
>> @@ -70,12 +71,12 @@ CONFIG_SYS_NS16550_MEM32=y
>>   CONFIG_SYSRESET=y
>>   CONFIG_USB=y
>>   CONFIG_USB_XHCI_HCD=y
>> -CONFIG_USB_XHCI_DWC3=y
>>   CONFIG_USB_EHCI_HCD=y
>>   CONFIG_USB_EHCI_GENERIC=y
>>   CONFIG_USB_OHCI_HCD=y
>>   CONFIG_USB_OHCI_GENERIC=y
>>   CONFIG_USB_DWC3=y
>> +CONFIG_USB_DWC3_GENERIC=y
> 
> Why not add 'default y if ROCKCHIP' into the Kconfig instead ? This will 
> have the same effect, without requiring such massive modification of 
> config files.

Not fully sure what you mean by this and how that would reduce number of
affected defconfig-files. The USB_XHCI_DWC3 should still be removed from
these defconfig-files or wrong driver could be used by these boards.

Touching the defconfig-files help notify board maintainers that changes
are happening to their boards.

There will also be a separate patch that remove the rockchip,rk3399-dwc3
compatible from the dwc3-of-simple driver to finalize this transition to
use dwc3-generic driver for affected rockchip boards.

Regards,
Jonas

> 
> (seems some of the CC domains are not even working, so CC list clipped)

