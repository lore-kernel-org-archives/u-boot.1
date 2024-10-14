Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7749D18128
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2849F889CA;
	Mon, 14 Oct 2024 17:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qbNB1TfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58DE288BB2; Mon, 14 Oct 2024 17:29:51 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 630F688966
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49EFThOf004360;
 Mon, 14 Oct 2024 10:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728919783;
 bh=bXQZGO3AXcTNccKC1a+fQVzyEfYqhfk09PeBjFZ96UA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=qbNB1TfEHLUoCjjw8Agnvn+5hdnwoj4/LP9bQYQXeU4hX8+DZLME5gkPlye9WeKK5
 6LW3UxDQCx6XvnsmPCmllvo2iGI/vy1Nt1f9A4gpOY319Ou9uI9MMPj4V/KH+ccWpp
 VSJuHQt92F+7Nub0WPws/wwfgKNh52WJkTEDOm6M=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49EFThXI118764
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Oct 2024 10:29:43 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 10:29:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 10:29:43 -0500
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be
 forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49EFTdD3055884;
 Mon, 14 Oct 2024 10:29:40 -0500
Message-ID: <eef0f5e5-1a54-015b-259c-c8eea4a54d6a@ti.com>
Date: Mon, 14 Oct 2024 20:59:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] boardf: Modify DRAM message
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>
CC: Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>,
 <jonas@kwiboo.se>, <richard@nod.at>, <raymond.mao@linaro.org>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20241010070909.288313-1-n-francis@ti.com>
 <CAFLszTjJ1GJNd5Fn8U2O5WSnKMn99XW_pGLmejkYy_PBfxSEGg@mail.gmail.com>
 <f194f14a-c7c3-4aed-b4b8-f093f64c7b69@ti.com>
 <31aeb96d-55b1-4587-b212-2632ae4cc124@ti.com>
 <20241014142717.GJ53053@bill-the-cat>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20241014142717.GJ53053@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On 14/10/24 19:57, Tom Rini wrote:
> On Mon, Oct 14, 2024 at 10:10:43AM +0530, Neha Malcom Francis wrote:
>> Hi Andrew
>>
>> On 11/10/24 01:59, Andrew Davis wrote:
>>> On 10/10/24 1:50 PM, Simon Glass wrote:
>>>> Hi Neha,
>>>>
>>>> On Thu, 10 Oct 2024 at 01:09, Neha Malcom Francis <n-francis@ti.com> wrote:
>>>>>
>>>>> The message "DRAM:  2 GiB (effective 32 GiB)" can be a little confusing,
>>>>> modify the message to show exactly what is meant:
>>>>>
>>>>> "DRAM:  2 GiB (available for U-Boot out of total 32 GiB)"
>>>>>
>>>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>>>> ---
>>>>>   common/board_f.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/common/board_f.c b/common/board_f.c
>>>>> index 154675d0e40..b7add8f7d3d 100644
>>>>> --- a/common/board_f.c
>>>>> +++ b/common/board_f.c
>>>>> @@ -254,7 +254,7 @@ static int show_dram_config(void)
>>>>>
>>>>>          print_size(gd->ram_size, "");
>>>>>          if (!sizes_near(gd->ram_size, size)) {
>>>>> -               printf(" (effective ");
>>>>> +               printf(" (available for U-Boot out of total ");
>>>>>                  print_size(size, ")");
>>>>>          }
>>>>>          board_add_ram_info(0);
>>>>> -- 
>>>>> 2.34.1
>>>>>
>>>>
>>>> I've forgotten why the first number can be so much lower than the
>>>> second. What is causing that?
>>>>
>>>> This is quite a long string...could we say "(total 32 GiB)" ? Then
>>>> perhaps add something to doc/ to talk about the banner that U-Boot
>>>> prints?
>>>>
>>>
>>> Why not just only print the total number? The amount available to
>>> U-Boot seems like an internal detail, I'd guess most folks just what
>>> to see at a glance how much DDR was detected on their system.
>>>
>>
Knowing how much u-boot is using might help someone who is working on some
memory map related stuff or if they want to stop at u-boot prompt and tweak
environment variables related to memory map (e.g. load address for kernel,
dtb, load bitmap to DDR etc). Overall I personally don't see much harm on
keeping both the information (DDR available to u-boot and total available
DDR). If the word effective is confusing than the print can be made more
verbose as being intended in this patch-set or by following the suggestions
given by Simon and Udit.

Regards
Devarsh
