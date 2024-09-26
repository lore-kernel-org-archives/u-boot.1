Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6ACCDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 628BF88F41;
	Fri, 27 Sep 2024 00:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727389236;
	bh=hwlKn6w62HRl+tUD6nn63TnFGrZ23krRcHwgx4T3ClU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bLKDLQbUt7XvHpfAIiAp6u8aRekQQDLHNAd+hlaWqoPqP/vJm0RP3694JI4EpyxlA
	 JwLLKBjZR0WdX2npZN16hH9ChgsB/c+rugC7+8UTRYv18N5xuuXgLd1dSdlz25T4vO
	 5TfJBFZ77OpOhmSoFe4DJm4/8eKIwANUbVtZpvCOE6GZ6oAawQuCbtaBvjLuP2dqbr
	 L3ithobUOq62P82Hgm4JjfzzDUHy0VC2NiA55juTs1lR+vE9B3oypdbfGFhNWvROtz
	 vW8C7gnp3RFaoCeITun6186P8lLW4FnyWiG51fd09CLmxNtxjL3wUwqXCOXOyMoMgo
	 1tBG+AVjApaUg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2FA2488F20;
 Fri, 27 Sep 2024 00:20:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727389234;
 bh=hwlKn6w62HRl+tUD6nn63TnFGrZ23krRcHwgx4T3ClU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=h3K4pjCKWuNbWQ1wgDW/vhAUgcQSAakIdQKZ2HyDnZweP9nyjjO13VYCHO9MxDraJ
 cFj5eFRzGGUBrBzmV1nBxMLbEk8YSJMC/fNLap1whSaZRxHZE1J5lbxyxQdvBIFbyd
 lGEClWZYAaTMT8erR5oNoQrx0GqQo7/jSTaZ15PI2ljUJPp98Z3lQlgKE4HMMgBKMY
 2PL6ORvTawAzcIPLGPm/k+mjK2FUi+psKul1OFpoLjvzD99OAbV+Y87tcCUPtqGmX0
 sKN1aIe1jeMCA7PikGUXgUF6/JocXyGAfIH/F2Rr7Q0RF7T4DjLQJXclG5Vvo/3pnn
 NLZ5eUspyWiow==
Message-ID: <0ccbc497-e631-4239-b1fd-b7767e428d35@denx.de>
Date: Fri, 27 Sep 2024 00:19:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/27] mx23_olinuxino: Drop status-LED code
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20240926204455.963584-1-sjg@chromium.org>
 <20240926204455.963584-20-sjg@chromium.org>
 <68dfb206-92c8-4016-ade6-007ad8830667@denx.de>
 <CAFLszTjcF4CvSeqLn2Ng-VhpmKqHBdO7BOmHGHUY6KOW7-CGtA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTjcF4CvSeqLn2Ng-VhpmKqHBdO7BOmHGHUY6KOW7-CGtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/27/24 12:10 AM, Simon Glass wrote:
> Hi Marek,

Hello Simon,

> On Thu, 26 Sept 2024 at 23:40, Marek Vasut <marex@denx.de> wrote:
>>
>> On 9/26/24 10:44 PM, Simon Glass wrote:
>>> This is not used anymore, so drop it.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>>    board/olimex/mx23_olinuxino/mx23_olinuxino.c | 7 -------
>>>    1 file changed, 7 deletions(-)
>>>
>>> diff --git a/board/olimex/mx23_olinuxino/mx23_olinuxino.c b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
>>> index b2bb6678c23..78136c1620a 100644
>>> --- a/board/olimex/mx23_olinuxino/mx23_olinuxino.c
>>> +++ b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
>>> @@ -13,9 +13,6 @@
>>>    #include <asm/arch/imx-regs.h>
>>>    #include <asm/arch/clock.h>
>>>    #include <asm/arch/sys_proto.h>
>>> -#ifdef CONFIG_LED_STATUS
>>> -#include <status_led.h>
>>> -#endif
>>>    #include <linux/delay.h>
>>>
>>>    DECLARE_GLOBAL_DATA_PTR;
>>> @@ -61,9 +58,5 @@ int board_init(void)
>>>        /* Adress of boot parameters */
>>>        gd->bd->bi_boot_params = PHYS_SDRAM_1 + 0x100;
>>>
>>> -#if defined(CONFIG_LED_STATUS) && defined(CONFIG_LED_STATUS_BOOT_ENABLE)
>>> -     status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_STATE);
>>> -#endif
>> Why not define the GPIO LED in DT, it might even already be defined there.
> 
> Yes I see it in the DT for quite a few boards, so that's what we should use.
Since LED uclass already uses well established DM_FLAG_PROBE_AFTER_BIND 
flag, the update here should be only a matter of enabling DM LED and 
GPIO LED driver.
