Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3356ACF259D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 04:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0BC188E21;
	Mon, 14 Oct 2024 06:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NpI8m9O3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C269688C9C; Mon, 14 Oct 2024 06:40:57 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5DFD88E58
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49E4ekbA045193;
 Sun, 13 Oct 2024 23:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728880847;
 bh=ubMS4xGbPcUSX0ew2zFMfKxs+eBDGAnXmNSSeihbly4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=NpI8m9O3MR/gIzLQQIzZsTukpuoUQtvvqq1x97a/kEEs4ZfkEzF6vekNWN9ZsXsHG
 ZAfnel/8O8qQpjxH/xDR45EC2WUGsZ7LpXvggZmXwC9dR59inRkkOKPzzWxy4QH0ym
 QmA71BquVm5IWl2vKLXhfaPKtNCGzGUUAXrmIVr0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49E4ekCC105490
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 13 Oct 2024 23:40:46 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 13
 Oct 2024 23:40:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 13 Oct 2024 23:40:46 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E4ehuV112492;
 Sun, 13 Oct 2024 23:40:44 -0500
Message-ID: <31aeb96d-55b1-4587-b212-2632ae4cc124@ti.com>
Date: Mon, 14 Oct 2024 10:10:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boardf: Modify DRAM message
To: Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>
CC: <trini@konsulko.com>, <devarsht@ti.com>, <jonas@kwiboo.se>,
 <richard@nod.at>, <raymond.mao@linaro.org>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
References: <20241010070909.288313-1-n-francis@ti.com>
 <CAFLszTjJ1GJNd5Fn8U2O5WSnKMn99XW_pGLmejkYy_PBfxSEGg@mail.gmail.com>
 <f194f14a-c7c3-4aed-b4b8-f093f64c7b69@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <f194f14a-c7c3-4aed-b4b8-f093f64c7b69@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Andrew

On 11/10/24 01:59, Andrew Davis wrote:
> On 10/10/24 1:50 PM, Simon Glass wrote:
>> Hi Neha,
>>
>> On Thu, 10 Oct 2024 at 01:09, Neha Malcom Francis <n-francis@ti.com> wrote:
>>>
>>> The message "DRAM:  2 GiB (effective 32 GiB)" can be a little confusing,
>>> modify the message to show exactly what is meant:
>>>
>>> "DRAM:  2 GiB (available for U-Boot out of total 32 GiB)"
>>>
>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>> ---
>>>   common/board_f.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/common/board_f.c b/common/board_f.c
>>> index 154675d0e40..b7add8f7d3d 100644
>>> --- a/common/board_f.c
>>> +++ b/common/board_f.c
>>> @@ -254,7 +254,7 @@ static int show_dram_config(void)
>>>
>>>          print_size(gd->ram_size, "");
>>>          if (!sizes_near(gd->ram_size, size)) {
>>> -               printf(" (effective ");
>>> +               printf(" (available for U-Boot out of total ");
>>>                  print_size(size, ")");
>>>          }
>>>          board_add_ram_info(0);
>>> -- 
>>> 2.34.1
>>>
>>
>> I've forgotten why the first number can be so much lower than the
>> second. What is causing that?
>>
>> This is quite a long string...could we say "(total 32 GiB)" ? Then
>> perhaps add something to doc/ to talk about the banner that U-Boot
>> prints?
>>
> 
> Why not just only print the total number? The amount available to
> U-Boot seems like an internal detail, I'd guess most folks just what
> to see at a glance how much DDR was detected on their system.
> 

Looking at the git history of this line, seems like we were printing U-Boot 
available size first and then modified it to show the entire DRAM available as 
"effective size"... quite possibly directly showing the total is a better idea.

Unless anyone has any reason to have this detail?

> Andrew
> 
>> Regards,
>> Simon

-- 
Thanking You
Neha Malcom Francis
