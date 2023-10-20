Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D116CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 06:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CBEA87185;
	Fri, 20 Oct 2023 08:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697784415;
	bh=6wmcZL7dz4dfEnHi3ZLJvtE8B9l60SvagVXiQNeiID8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=naRB4Sd8wV1eAmqlrG+UJrYovYY2IHsp2Lfb76hVRjkJQ+tUu7pQ/tKx1zlWnoVDr
	 b0gKAVDbYGjXhkMcOqqfaSbmgNEffi5ikAIRy0V4AfcogevKYieyGbld9Myu0iI/Gs
	 /xXTz7w4mthKFBu1YBnHst+OqxHgodqEf5M0zvt406886v//dFmZyRaY1/ilps1/PU
	 2YMksEtYQooHBSCcjDqJqp7uTAG97TKBv0JS19+RPE5AKskpuo57cxwO4THOBfEjV3
	 lTCxrQx8kPuZtgZ3Xn31B/pk+PkV0ETp8JorvtQJ6vQbzWup/QE9eWsl8uBpR71B+4
	 XZDDwhzls7AOw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69978871C0; Fri, 20 Oct 2023 08:46:54 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DD24870B4
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 08:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4SBZrB5X15z9sX0;
 Fri, 20 Oct 2023 08:46:50 +0200 (CEST)
Message-ID: <dee2aa61-662f-4116-8981-1094337e0f9f@denx.de>
Date: Fri, 20 Oct 2023 08:46:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] arm: mvebu: Espressobin: move network setup into a
 separate function
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
To: Robert Marko <robert.marko@sartura.hr>, u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr
References: <20230914101642.1603383-1-robert.marko@sartura.hr>
 <20230914101642.1603383-2-robert.marko@sartura.hr>
 <9194bb32-1f06-6b6d-acd0-c5baefb4ae2a@denx.de>
In-Reply-To: <9194bb32-1f06-6b6d-acd0-c5baefb4ae2a@denx.de>
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

Hi Robert,

On 9/18/23 08:47, Stefan Roese wrote:
> On 9/14/23 12:16, Robert Marko wrote:
>> Currently, Esspresobin switch is being setup directly in 
>> last_stage_init()
>> which makes it hard to add support for any other board to be setup.
>>
>> So, lets just move the switch setup code to a separate function and 
>> call it
>> if compatible matches, there should be no functional change.
>>
>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> 
> Reviewed-by: Stefan Roese <sr@denx.de>

This patch and the next one do not apply on latest master. Could you
please re-spin the patch series?

Thanks,
Stefan

> Thanks,
> Stefan
> 
>> ---
>>   board/Marvell/mvebu_armada-37xx/board.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/board/Marvell/mvebu_armada-37xx/board.c 
>> b/board/Marvell/mvebu_armada-37xx/board.c
>> index da325e8c75..6527155c6e 100644
>> --- a/board/Marvell/mvebu_armada-37xx/board.c
>> +++ b/board/Marvell/mvebu_armada-37xx/board.c
>> @@ -300,15 +300,11 @@ static int mii_multi_chip_mode_write(struct 
>> udevice *bus, int dev_smi_addr,
>>       return 0;
>>   }
>> -/* Bring-up board-specific network stuff */
>> -int last_stage_init(void)
>> +static int espressobin_last_stage_init(void)
>>   {
>>       struct udevice *bus;
>>       ofnode node;
>> -    if (!of_machine_is_compatible("globalscale,espressobin"))
>> -        return 0;
>> -
>>       node = ofnode_by_compatible(ofnode_null(), "marvell,orion-mdio");
>>       if (!ofnode_valid(node) ||
>>           uclass_get_device_by_ofnode(UCLASS_MDIO, node, &bus) ||
>> @@ -356,6 +352,16 @@ int last_stage_init(void)
>>       return 0;
>>   }
>> +
>> +/* Bring-up board-specific network stuff */
>> +int last_stage_init(void)
>> +{
>> +
>> +    if (of_machine_is_compatible("globalscale,espressobin"))
>> +        return espressobin_last_stage_init();
>> +
>> +    return 0;
>> +}
>>   #endif
>>   #ifdef CONFIG_OF_BOARD_SETUP
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
