Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06603FF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 06:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36EC483FB5;
	Wed, 29 Apr 2026 08:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="OC8J6rxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F73E846DF; Wed, 29 Apr 2026 08:07:23 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D58F846D0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 08:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8EC8D111785; Wed, 29 Apr 2026 08:07:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1777442839;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=RBjv8JQZwu3Fi9kWwoPaEUE3xK5IyBWvWDrkUI6Try0=;
 b=OC8J6rxCqdjs79b2oKnhtuXpYV49XrRdKvmqQbWlNpob6Raca3Vj2F02dYzk63hmQFE8JL
 AnZFJLFhsLFpIYmCuV4vJ6gMEMUFq85f2o8kxYyl8xSywPXzVvZESisWBMls5EHrhJtqCv
 zSckjv5gRQ0OondkrDQB20+OGM9LDdyvc2vt1jx2ZPb/8Cjw/9G1Kc+xhdYvI6a+lTLUMz
 LImXtDoX8RN11GcMJiTknnbtvV6+mtjs5RSiLsnUQyxKU/3jZcULqSaIUZk/lP9IBEwubC
 6zyLBZ0B0Qe3mteIhJb/jANOGCu5Fr2Sbt5WagjG96pz3pRaSKK22ti4QX6V3A==
Message-ID: <bbe78ace-0f7c-3846-2561-275d368402ca@nabladev.com>
Date: Wed, 29 Apr 2026 08:06:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: imx_lpi2c: Fix MSR status check issue in STOP
Content-Language: en-US
To: Ye Li <ye.li@oss.nxp.com>, Ye Li <ye.li@nxp.com>, festevam@gmail.com,
 u-boot@lists.denx.de, peng.fan@nxp.com, Gao Pan <pandy.gao@nxp.com>
Cc: uboot-imx@nxp.com
References: <20260428085312.1808358-1-ye.li@nxp.com>
 <41960ee3-8645-4d79-0a01-e9642b674a6b@nabladev.com>
 <18ce19be-c35d-408d-9648-9b08d5433299@oss.nxp.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <18ce19be-c35d-408d-9648-9b08d5433299@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Ye li,

On 28.04.26 17:20, Ye Li wrote:
> Hi Heiko,
> 
> On 4/28/2026 5:55 PM, Heiko Schocher wrote:
>> Hello Ye Li,
>>
>> On 28.04.26 10:53, Ye Li wrote:
>>> In bus_i2c_stop, the MSR SDF is checked in a loop after stop command
>>> is sent. Meanwhile, some error status in MSR is also checked by
>>> imx_lpci2c_check_clear_error. But the imx_lpci2c_check_clear_error
>>> will clear the MSR.
>>>
>>> It causes problem in below situation:
>>> In current loop, SDF does not set, but error status is found by
>>> imx_lpci2c_check_clear_error (for example, NDF), then NDF will be cleared
>>> and result has NDF error. However, because SDF does not set in this loop,
>>> it goes not next loop. When SDF is set in next loop,
>>> imx_lpci2c_check_clear_error is re-executed, but as the MSR is cleared,
>>> the result is 0. Then the stop return 0. But it should return NDF error.
>>>
>>> Signed-off-by: Ye Li <ye.li@nxp.com>
>>> ---
>>>   drivers/i2c/imx_lpi2c.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
>>> index a309fd6f07c..e2b4fd334ec 100644
>>> --- a/drivers/i2c/imx_lpi2c.c
>>> +++ b/drivers/i2c/imx_lpi2c.c
>>> @@ -239,7 +239,6 @@ static int bus_i2c_stop(struct udevice *bus)
>>>       start_time = get_timer(0);
>>>       while (1) {
>>>           status = readl(&regs->msr);
>>> -        result = imx_lpci2c_check_clear_error(regs);
>>
>> Wouldn;t it be better to evaluate bits in result too, and return
>> if error bits found?
> 
> I find below commit in history, please take a look. If evaluate bits and return, it moves back to 
> previous clock issue.
> 
> commit a32effd2838a62a5d1dcc01f613508f1d90b5667
> Author: Gao Pan <pandy.gao@nxp.com>
> Date:   Sun Jul 8 11:46:41 2018 +0800
> 
>      imx: lpi2c: fix clock issue when NACK detected
> 
>      For LPI2C IP, NACK is detected by the rising edge of the ninth clock.
>      In current uboot driver, once NACK is detected, it will reset and then
>      disable LPI2C master. As a result, we can never see the falling edge
>      of the ninth clock.
> 
>      Signed-off-by: Gao Pan <pandy.gao@nxp.com>
>      Signed-off-by: Peng Fan <peng.fan@nxp.com>
>      Reviewed-by: Heiko Schocher <hs@denx.de>

Ah, okay. May Peng or Gao (added to this thread) can
than review your patch.

Thanks for the hint!

bye,
Heiko
> 
> 
> Best regards,
> Ye Li
> 
>>
>>>           /* stop detect flag */
>>>           if (status & LPI2C_MSR_SDF_MASK) {
>>>               /* clear stop flag */
>>> @@ -250,10 +249,13 @@ static int bus_i2c_stop(struct udevice *bus)
>>>           if (get_timer(start_time) > LPI2C_NACK_TOUT_MS) {
>>>               debug("stop timeout\n");
>>> +            result = imx_lpci2c_check_clear_error(regs);
>>>               return -ETIMEDOUT;
>>>           }
>>>       }
>>> +    result = imx_lpci2c_check_clear_error(regs);
>>> +
>>>       return result;
>>>   }
>>>
>>
>> bye,
>> Heiko
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
