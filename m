Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF61CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76C2086B73;
	Mon, 16 Oct 2023 16:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697467263;
	bh=aHKXli/0NtHsH9CfnEaYaUazRFlJnSgaMLLZLlaKF3w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zYBQt6VzcTs+rZ7jKqY2FjRtgtTYmU8aiFuEVoroQ/QOpeAZRahhEsHY/G/jKSePO
	 fb0LOBb/bL0dxYOxFeq9PFWpIFlLxoE8cqQD+OG230/W53swb74PvF7SXXpkjjWM6e
	 M7wc4vcXlAKX2oB7uWhEyLHy0K9Q5sVAdIVNUNJaRtiJI9+We4wXWtSylrZDeQqsNx
	 PCWPLKkxEX1lthYYHfjgSE5imGNVx/VvhhjF/EbIenTVVVaX4NF32AH2RyRBdFaESg
	 viiFUV6xaT/hNh68NdeOW1KoFm00APy4hW3PSXoDxy3s1cIVdAMjNZdwjhbYi44GBT
	 bcHAUP5L9tUaA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B87186B71; Mon, 16 Oct 2023 16:41:00 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9851186BA6
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4S8KY45g6hz9sb7;
 Mon, 16 Oct 2023 16:40:56 +0200 (CEST)
Message-ID: <4a205fa7-e0b3-4e49-b248-d84f1a865b6e@denx.de>
Date: Mon, 16 Oct 2023 16:40:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] kirkwood: dns325: Enable 2nd harddrive
Content-Language: en-US
To: Tony Dinh <mibodhi@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20230811080204.48659-1-sr@denx.de>
 <CAJaLiFwa2xy-MVDqLo_kp_gYdRqtkjDnr1hupKDE_uus7-qNUQ@mail.gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <CAJaLiFwa2xy-MVDqLo_kp_gYdRqtkjDnr1hupKDE_uus7-qNUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/12/23 05:54, Tony Dinh wrote:
> On Fri, Aug 11, 2023 at 3:02 PM Stefan Roese <sr@denx.de> wrote:
>>
>> The 2nd HD is not enabled in U-Boot on the D-Link DNS325. This patch
>> sets the responsible GPIO to high, enabling the drive.
>>
>> Suggested-by: Peter Granilla
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Cc: Tom Rini <trini@konsulko.com>

Applied to u-boot-marvell/master

Thanks,
Stefan

>> ---
>>   board/d-link/dns325/dns325.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/board/d-link/dns325/dns325.c b/board/d-link/dns325/dns325.c
>> index 055783f63ada..8ebfe4c60189 100644
>> --- a/board/d-link/dns325/dns325.c
>> +++ b/board/d-link/dns325/dns325.c
>> @@ -89,6 +89,7 @@ int board_early_init_f(void)
>>          kw_gpio_set_blink(DNS325_GPIO_LED_POWER , 1);
>>
>>          kw_gpio_set_value(DNS325_GPIO_SATA0_EN , 1);
>> +       kw_gpio_set_value(DNS325_GPIO_SATA1_EN , 1);
>>          return 0;
>>   }
>>
>> --
>> 2.41.0
>>
> 
> Reviewed-by: Tony Dinh <mibodhi@gmail.com>
> 
> All the best,
> Tony

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
