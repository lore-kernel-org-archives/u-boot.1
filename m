Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CDACDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D356787220;
	Thu, 19 Oct 2023 12:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697711664;
	bh=BnBnifS6NIQc6ZuY66mr65KTeSzVcxGb12RCcSK3/fg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DDObDldO4ei1hSK00ChQYcs/1PmWxNS/ZJvaVLnBGlcDrHq6eAGcxALjARsxLIJq/
	 +ZNEyD8eQqI5Nh5Irc/mYNMKQL+vrsN9i26F3sK3LrCZMR/VOjeq18Bek6WL3J8/6i
	 7d6zS7r2lGTS9uiUIuTxZqdoWiz9XXbDTjXJlXLrf/tVqHcaXgQf0Ux1EzFOdYWv0T
	 Nrt+rLOsa6I2myyBapM6KDPinvFCG5z1QLKpReLTtoouCiwpCH9UPhAD+ritVT+wAj
	 +l4xB4FzXmJ13bg9UEXARa5PEGy7TJrDqtI/ka2YTTtn/X2Ean61HDuTw4Q/1IdeME
	 KbdehgmAUFx7A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDBA587225; Thu, 19 Oct 2023 12:34:23 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7DC786F8B
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4SB3x76mzWz9sS5;
 Thu, 19 Oct 2023 12:34:19 +0200 (CEST)
Message-ID: <770f2d99-dd65-48d1-a47d-1d07f7c404ef@denx.de>
Date: Thu, 19 Oct 2023 12:34:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] wdt: nuvoton: Fix reset/expire function error
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
To: Jim Liu <jim.t90615@gmail.com>, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 JJLIU0@nuvoton.com
Cc: u-boot@lists.denx.de
References: <20231018020900.189021-1-JJLIU0@nuvoton.com>
 <b28fd885-476a-45a0-8448-e8363be92fab@denx.de>
In-Reply-To: <b28fd885-476a-45a0-8448-e8363be92fab@denx.de>
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

On 10/19/23 07:53, Stefan Roese wrote:
> On 10/18/23 04:09, Jim Liu wrote:
>> Fix npcm845 watchdog halt for reset function and expire function.
>> Reset function is restart wdt.
>>
>> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
>>
>> Changes for v3:
>>     - Modify start sentences
>>     - Remove empty line
>> Changes for v2:
>>     - Add commit message
>>     - Fix no empty line problem
>>     - Remove dts
>> ---
> 
> The revision history should be placed below the "---" line. This way
> it will not be included in the commit text when committing. No need to
> change this though, I'll fix it up.
> 
> Reviewed-by: Stefan Roese <sr@denx.de>

Applied to u-boot-watchdog/master

Thanks,
Stefan

> Thanks,
> Stefan
> 
>>   drivers/watchdog/npcm_wdt.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
>> index e56aa0ebe1..57b61215a2 100644
>> --- a/drivers/watchdog/npcm_wdt.c
>> +++ b/drivers/watchdog/npcm_wdt.c
>> @@ -69,15 +69,21 @@ static int npcm_wdt_stop(struct udevice *dev)
>>   static int npcm_wdt_reset(struct udevice *dev)
>>   {
>>       struct npcm_wdt_priv *priv = dev_get_priv(dev);
>> +    u32 val;
>> -    writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, priv->regs);
>> +    val = readl(priv->regs);
>> +    writel(val | NPCM_WTR, priv->regs);
>>       return 0;
>>   }
>>   static int npcm_wdt_expire_now(struct udevice *dev, ulong flags)
>>   {
>> -    return npcm_wdt_reset(dev);
>> +    struct npcm_wdt_priv *priv = dev_get_priv(dev);
>> +
>> +    writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, priv->regs);
>> +
>> +    return 0;
>>   }
>>   static int npcm_wdt_of_to_plat(struct udevice *dev)
> 
> Viele Grüße,
> Stefan Roese
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
