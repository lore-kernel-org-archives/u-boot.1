Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59046C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 10:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 904A188440;
	Wed,  8 May 2024 12:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FTBDmHBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A9B58844B; Wed,  8 May 2024 12:01:03 +0200 (CEST)
Received: from mail-m127103.qiye.163.com (mail-m127103.qiye.163.com
 [115.236.127.103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C53F88436
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 12:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=FTBDmHBMLsE2x6enot+wBkCN/O8IrdjLrjygml3C/irOYZpiuE+NtYqfAv7rMMbxx/2LSiJnfzLhXNCu1iVx2uIp/O6TosB2nOYqshwN208Ihe9IFlp85IIOTeaxTwMKtuAm7sf2P0sx7lPXdDyZ0nBXfJgnUSkXTY1KUFuuK+k=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=ji3xueZZ/jkp5jWcYImuH6rVEEIVLkfDdMba4XhyAyE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id C8DFC900396;
 Wed,  8 May 2024 18:00:43 +0800 (CST)
Message-ID: <60ddc200-c3bb-41db-8d94-51761893cfde@rock-chips.com>
Date: Wed, 8 May 2024 18:00:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: add support for Theobroma Systems
 SOM-RK3588-Q7 Tiger module
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de
References: <20240423-tiger-v2-1-4a3fa0a01b5e@theobroma-systems.com>
 <0c9b591b-71a6-4a76-89b1-46a48f0183cf@rock-chips.com>
 <59c3ee19-f1c5-425d-912d-d418c7a2990b@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <59c3ee19-f1c5-425d-912d-d418c7a2990b@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQksaHlYZGEsdQ05LTEtDSENVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f57a5f1c103a9kunmc8dfc900396
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P1E6NCo*VjNDHA8eHgFCN0Ip
 ORcaCS9VSlVKTEpOSk1JT09PTkJIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQkJLNwY+
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

On 2024/5/8 16:34, Quentin Schulz wrote:
> Hi Kever,
>
> On 5/8/24 4:42 AM, Kever Yang wrote:
>> Hi Quentin,
>>
>>      Could you please update this patch with OF_UPSTREAM support?
>>
>
> No, I cannot yet :/
>
> Tiger is only available in Linux kernel v6.9-rcX and dts/ in U-Boot is 
> currently at v6.8.

I see, then we may need to support the board without OF_UPSTREAM during 
the dts is available

in kernel tree but not available in U-Boot dts/upstream.

>
> What are we supposed to do for this then?
>
> Would bumping dts/ to an -rc tag be ok for U-Boot? 

Hi Tom,

     What's policy of the dts/upstream suppose to update? This is the 
typical issue there is gap

between the dts merge in mainline kernel and available in next release.


Thanks,
- Kever
> After all, those are rc and not "stable" branches. Do we need to wait 
> for the actual kernel release before bumping dts/ (so wait for up to 2 
> months before supporting a board in U-Boot)? Should we have an 
> intermediate solution where we use the "old" model (NOT OF_UPSTREAM) 
> until we bump dts/ to the latest kernel release and the DTS is 
> available through OF_UPSTREAM?
>
> Cheers,
> Quentin
