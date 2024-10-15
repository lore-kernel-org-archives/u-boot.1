Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCBBCFC264
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 03:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5019B88ECD;
	Tue, 15 Oct 2024 05:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rtuXtdsB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AEDD88EFE; Tue, 15 Oct 2024 05:40:06 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E43788E67
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 05:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49F3dmfb049954;
 Mon, 14 Oct 2024 22:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728963588;
 bh=Q5ussZ7hjkSSpfFaNtnTmaA8kDBiZKg8x4ZsCzN8gSY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=rtuXtdsBc7+VZVX/1JSSe5H+7veG89WRqZN5wDTUd5x5X82hZ5BYOR13v1EpSQycf
 tPuziEUkeSUe06OFqx4rtWaj+61NLwciZLNSpnB0STv0GqLiSlibVa3aGI/WEHG/+g
 oWJtrbtyeKUWR0mXmr+wjy8rUIr0t5GASD5zXVvA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49F3dmur092514
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Oct 2024 22:39:48 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 22:39:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 22:39:47 -0500
Received: from [10.249.139.5] ([10.249.139.5])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49F3dikg109527;
 Mon, 14 Oct 2024 22:39:45 -0500
Message-ID: <c4c821cf-f8d7-4332-b427-7a644b8d29e2@ti.com>
Date: Tue, 15 Oct 2024 09:09:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boardf: Modify DRAM message
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
CC: Devarsh Thakkar <devarsht@ti.com>, Andrew Davis <afd@ti.com>, Simon Glass
 <sjg@chromium.org>, <jonas@kwiboo.se>, <richard@nod.at>,
 <raymond.mao@linaro.org>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20241010070909.288313-1-n-francis@ti.com>
 <CAFLszTjJ1GJNd5Fn8U2O5WSnKMn99XW_pGLmejkYy_PBfxSEGg@mail.gmail.com>
 <f194f14a-c7c3-4aed-b4b8-f093f64c7b69@ti.com>
 <31aeb96d-55b1-4587-b212-2632ae4cc124@ti.com>
 <20241014142717.GJ53053@bill-the-cat>
 <eef0f5e5-1a54-015b-259c-c8eea4a54d6a@ti.com>
 <20241014153510.GN53053@bill-the-cat>
 <4e3c3044-2601-4093-a422-898b183a173a@cherry.de>
 <20241014182346.GT53053@bill-the-cat>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20241014182346.GT53053@bill-the-cat>
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

Hi Tom, Devarsh, Quentin

On 14-Oct-24 11:53 PM, Tom Rini wrote:
> On Mon, Oct 14, 2024 at 07:23:09PM +0200, Quentin Schulz wrote:
>> Hi all,
>>
>> On 10/14/24 5:35 PM, Tom Rini wrote:
>>> On Mon, Oct 14, 2024 at 08:59:39PM +0530, Devarsh Thakkar wrote:
>>>> Hi,
>>>>
>>>> On 14/10/24 19:57, Tom Rini wrote:
>>>>> On Mon, Oct 14, 2024 at 10:10:43AM +0530, Neha Malcom Francis wrote:
>>>>>> Hi Andrew
>>>>>>
>>>>>> On 11/10/24 01:59, Andrew Davis wrote:
>>>>>>> On 10/10/24 1:50 PM, Simon Glass wrote:
>>>>>>>> Hi Neha,
>>>>>>>>
>>>>>>>> On Thu, 10 Oct 2024 at 01:09, Neha Malcom Francis <n-francis@ti.com> wrote:
>>>>>>>>>
>>>>>>>>> The message "DRAM:  2 GiB (effective 32 GiB)" can be a little confusing,
>>>>>>>>> modify the message to show exactly what is meant:
>>>>>>>>>
>>>>>>>>> "DRAM:  2 GiB (available for U-Boot out of total 32 GiB)"
>>>>>>>>>
>>>>>>>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>>>>>>>> ---
>>>>>>>>>     common/board_f.c | 2 +-
>>>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/common/board_f.c b/common/board_f.c
>>>>>>>>> index 154675d0e40..b7add8f7d3d 100644
>>>>>>>>> --- a/common/board_f.c
>>>>>>>>> +++ b/common/board_f.c
>>>>>>>>> @@ -254,7 +254,7 @@ static int show_dram_config(void)
>>>>>>>>>
>>>>>>>>>            print_size(gd->ram_size, "");
>>>>>>>>>            if (!sizes_near(gd->ram_size, size)) {
>>>>>>>>> -               printf(" (effective ");
>>>>>>>>> +               printf(" (available for U-Boot out of total ");
>>>>>>>>>                    print_size(size, ")");
>>>>>>>>>            }
>>>>>>>>>            board_add_ram_info(0);
>>>>>>>>> -- 
>>>>>>>>> 2.34.1
>>>>>>>>>
>>>>>>>>
>>>>>>>> I've forgotten why the first number can be so much lower than the
>>>>>>>> second. What is causing that?
>>>>>>>>
>>>>>>>> This is quite a long string...could we say "(total 32 GiB)" ? Then
>>>>>>>> perhaps add something to doc/ to talk about the banner that U-Boot
>>>>>>>> prints?
>>>>>>>>
>>>>>>>
>>>>>>> Why not just only print the total number? The amount available to
>>>>>>> U-Boot seems like an internal detail, I'd guess most folks just what
>>>>>>> to see at a glance how much DDR was detected on their system.
>>>>>>>
>>>>>>
>>>> Knowing how much u-boot is using might help someone who is working on some
>>>> memory map related stuff or if they want to stop at u-boot prompt and tweak
>>>> environment variables related to memory map (e.g. load address for kernel,
>>>> dtb, load bitmap to DDR etc). Overall I personally don't see much harm on
>>>> keeping both the information (DDR available to u-boot and total available
>>>> DDR). If the word effective is confusing than the print can be made more
>>>> verbose as being intended in this patch-set or by following the suggestions
>>>> given by Simon and Udit.
>>>
>>> U-Boot isn't "using" 2GiB however. And in fact the command Simon is
>>> working on to dump the memory table and what's where, as far as U-Boot
>>> knows, would be helpful in that case.
>>>
>>
>> "Available" and "Total" would be matching the terms used by "free" in Linux
>> for example.
>>
>> I still think both are valuable pieces of information (what's populated and
>> what is usable by U-Boot AFAIR).
> 
> Yes, and that won't change the binary size much, thanks.
> 

Thank you for the inputs. I think we can go with s/effective/total and 
updating the documentation.

-- 
Thanking You
Neha Malcom Francis
