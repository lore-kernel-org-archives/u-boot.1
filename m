Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37912E7719A
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 00:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8688A800C2;
	Fri, 10 Jan 2025 01:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="CKlmhDr5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF4D80196; Fri, 10 Jan 2025 01:54:31 +0100 (CET)
Received: from mail-m60192.netease.com (mail-m60192.netease.com
 [210.79.60.192])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43EAB8001F
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 01:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 844cd4d2;
 Fri, 10 Jan 2025 08:54:24 +0800 (GMT+08:00)
Message-ID: <a1b48fbd-6870-42e0-a9c9-9617a0ee2d01@rock-chips.com>
Date: Fri, 10 Jan 2025 08:54:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/20] rockchip: mkimage: Add rk3576 support
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org, philipp.tomsich@vrull.eu
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com, Xuhui Lin <xuhui.lin@rock-chips.com>
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-10-heiko@sntech.de>
 <421a8aa9-4f7b-4d63-8f5e-34eae97b8b06@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <421a8aa9-4f7b-4d63-8f5e-34eae97b8b06@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUweGlZMQkJJSklJTklKTk5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
 JVSktLVUpCS0tZBg++
X-HM-Tid: 0a944db486e503afkunm844cd4d2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ogw6EQw4MjIPSAlPMTM9Dy48
 AThPCilVSlVKTEhNT0xLT01OTk1MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKQ0lINwY+
DKIM-Signature: a=rsa-sha256;
 b=CKlmhDr5RfBRlZxGNDOyJOnLjlINCrhozuiNg1ZSMAhNEMt4WKpf1B5iph7dggfWZ4ynhpHPxWASHL63AigDJdjb++w9nUQwcfgLHvuOztf5d6Fegloc3HycDtmutbJFEvkW3G+SWFk8beiUy89/B9cu5s50iYJMUKnUSygrSrY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=HD3f/UIiTbv9+wklKnmvEIDD1ApwmKTv9NrtovJst9A=;
 h=date:mime-version:subject:message-id:from;
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

On 2024/11/27 00:53, Quentin Schulz wrote:
> Hi Heiko,
>
> On 11/21/24 3:27 PM, Heiko Stuebner wrote:
>> From: Xuhui Lin <xuhui.lin@rock-chips.com>
>>
>> Add support for rk3576 package header in mkimage tool.
>>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>   tools/rkcommon.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
>> index 3e52236b15a..d89c7d3afea 100644
>> --- a/tools/rkcommon.c
>> +++ b/tools/rkcommon.c
>> @@ -135,6 +135,7 @@ static struct spl_info spl_infos[] = {
>>       { "rv1108", "RK11", 0x1800, false, RK_HEADER_V1 },
>>       { "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
>>       { "rk3568", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
>> +    { "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2 },
>
> I don't understand why we remove 0x1000 here from the size of the SRAM.
>
> If I go back in git history, I found 
> 915e09814a83128fee8b87b2ee2e5f4a17e04a01 which states it's total SRAM 
> - size used by BootROM.
>
> Can anyone provide feedback on how one is supposed to find this out? I 
> think it's not the first time I'm confused by this and I'm not sure 
> anyone's answered me before, but in any case, documenting this would 
> be much welcome :)
If you look this change at vendor U-Boot, you can find below commit msg:
"Sram total size is 512KB and 4KB is used as bootrom stack."
This size limit is for the first blob binary which is TPL/DDR init, and 
after running the DDR init,
we need to back to bootROM, so we should not touch the bootRom stack to 
keep the bootRom
available.

Thanks,
- Kever
>
> The RK3576 does have 512KiB of SRAM so the base value before 
> subtracting is fine :)
>
> Cheers,
> Quentin
>
