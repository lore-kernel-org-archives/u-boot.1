Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3E7CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 09:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E1286B29;
	Fri, 13 Oct 2023 11:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697188374;
	bh=tXseO5POYeIbAFzDDe4/quTM6ZhC9tFnBnR5B6n0q2Q=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=oxI7ar/ey2vXdGJcNtOjYCZHhPav6C+R+wrJs2Nx7vUCWixjckRl2APeDrPEbcaQo
	 +erJYmS2EFvrOFOb6Rn6tXCqkWBAMVdeyyzjgrWt0GjTJB+mbjCmpl9XAZEkBhZVmp
	 mUYwvikJWWPMvMBJ3t2sb9zZlyKXfPgSP9OJ28moHW9LioEjEUiPDf+CPunXWnwilz
	 ZnDsYXx4vYeEkdV2XfJzlTHMtotcPqw2AhttsJhDW20IM2JS63hgpqIbL1Imj0ZxVo
	 /sHL7640pwCFYuMTkWlcQFsBL4W7LJCb0S5zIUozk7gWvL9j4EVAl4830VW6rxYE1d
	 ANDxwQRC+qanw==
Received: from [192.168.1.107] (91-82-26-209.pool.digikabel.hu [91.82.26.209])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 269EE86ED1;
 Fri, 13 Oct 2023 11:12:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697188368;
 bh=tXseO5POYeIbAFzDDe4/quTM6ZhC9tFnBnR5B6n0q2Q=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=tlbZSkV0BTCr6921G5sV8rQDbTv4gV7IxWOf++yklMR1rFwfNdSdMqN7zveifOGLE
 7w7JHWh5rFHoG8RY80DC1dydu0PSRt5xvsiyvdx62P3ZIw1T+wmMu2HiurqKq1sJ2w
 Rhvx4351l7c4sAIOBBkGB2HL9k+UCIQ5SgFWhN/U96/uiPrJ37uGnoS3IE0ti8rFAm
 PKupuxnURD2/NyCZLBvZLY4/5/UGpES66wrr7BiwVGUIG/VA47oz5QzmTKrGlUvblI
 EvGYr1vTF290iJCRl+SmRvtBz9Ddo3277ynNg4kx470StaBR5tNbeF7hWFXSDlDy9e
 syVqMy0i8OIgw==
Subject: Re: [PATCH 1/1] i2c: designware_i2c: adjust timing calculation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20231011044813.122941-1-heinrich.schuchardt@canonical.com>
 <d461a87f-14d6-2b22-f3c6-522a54b7d517@denx.de>
 <84240e10-80ca-45f9-b50c-4e8f6bbd90b6@canonical.com>
From: Heiko Schocher <hs@denx.de>
Message-ID: <9d3ade8a-2feb-115f-2458-d3525535380e@denx.de>
Date: Fri, 13 Oct 2023 11:12:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <84240e10-80ca-45f9-b50c-4e8f6bbd90b6@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Heinrich,

On 13.10.23 10:32, Heinrich Schuchardt wrote:
> On 10/13/23 06:37, Heiko Schocher wrote:
>> Hello Heinrich,
>>
>> On 11.10.23 06:48, Heinrich Schuchardt wrote:
>>> In SPL probing of the designware_i2c device on the StarFive VisionFive 2
>>> board fails with
>>>
>>>      dw_i2c: mode 0, ic_clk 1000000, speed 100000,
>>>      period 10 rise 1 fall 1 tlow 5 thigh 4 spk 0
>>>      dw_i2c: bad counts. hcnt = -4 lcnt = 4
>>>      device_probe: i2c@12050000 failed to probe -22
>>>
>>> When changing the offset for the high phase from 7 to 1 the device is
>>> probed correctly.
>>>
>>> Without this fix the memory size of the StarFive VisionFive 2 board cannot
>>> be read from EEPROM.
>>>
>>> Fixes: e71b6f6622d6 ("i2c: designware_i2c: Rewrite timing calculation")
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>>   drivers/i2c/designware_i2c.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
>>> index e54de42abc..55e582091c 100644
>>> --- a/drivers/i2c/designware_i2c.c
>>> +++ b/drivers/i2c/designware_i2c.c
>>> @@ -155,10 +155,10 @@ static int dw_i2c_calc_timing(struct dw_i2c *priv, enum i2c_speed_mode mode,
>>>         /*
>>>        * Back-solve for hcnt and lcnt according to the following equations:
>>> -     * SCL_High_time = [(HCNT + IC_*_SPKLEN + 7) * ic_clk] + SCL_Fall_time
>>> +     * SCL_High_time = [(HCNT + IC_*_SPKLEN + 1) * ic_clk] + SCL_Fall_time
>>>        * SCL_Low_time = [(LCNT + 1) * ic_clk] - SCL_Fall_time + SCL_Rise_time
>>>        */
>>> -    hcnt = min_thigh_cnt - fall_cnt - 7 - spk_cnt;
>>> +    hcnt = min_thigh_cnt - fall_cnt - 1 - spk_cnt;
>>>       lcnt = min_tlow_cnt - rise_cnt + fall_cnt - 1;
>>>         if (hcnt < 0 || lcnt < 0) {
>>> @@ -170,13 +170,13 @@ static int dw_i2c_calc_timing(struct dw_i2c *priv, enum i2c_speed_mode mode,
>>>        * Now add things back up to ensure the period is hit. If it is off,
>>>        * split the difference and bias to lcnt for remainder
>>>        */
>>> -    tot = hcnt + lcnt + 7 + spk_cnt + rise_cnt + 1;
>>> +    tot = hcnt + lcnt + 1 + spk_cnt + rise_cnt + 1;
>>>         if (tot < period_cnt) {
>>>           diff = (period_cnt - tot) / 2;
>>>           hcnt += diff;
>>>           lcnt += diff;
>>> -        tot = hcnt + lcnt + 7 + spk_cnt + rise_cnt + 1;
>>> +        tot = hcnt + lcnt + 1 + spk_cnt + rise_cnt + 1;
>>>           lcnt += period_cnt - tot;
>>>       }
>>
>> What are this magic constants? Are they somewhere documented in the RM?
> 
> I have no access to Designware reference manuals. Do you have?

No.

>> Hmm... and does this may break other boards? Should we have this in
>> someway configurable?
>>
>> Tried to look fast in the linux driver... and it seems to me, this
>> constants depend at least on i2c_speed_mode?
>>
>> bye,
>> Heiko
> 
> https://www.nxp.com/docs/en/user-guide/UM10204.pdf has I2C timing diagrams in Figure 38 and Figure 39.
> 
> Linux has a function i2c_dw_scl_hcnt() where depending on parameter cond either a value of 8 or 3 is
> used. All invocations of i2c_dw_scl_hcnt() have cond = 0, offset = 0. Linux' i2c_dw_scl_lcnt()
> always uses 1.
> 
> The Linux comments are:
> 
> cond==True
>     IC_[FS]S_SCL_HCNT + (1+4+3) >= IC_CLK * tHIGH
> 
> cond==False
>     IC_[FS]S_SCL_HCNT + 3 >= IC_CLK * (tHD;STA + tf)
> 
> The U-Boot comment has:
> 
>     SCL_High_time = [(HCNT + IC_*_SPKLEN + 7) * ic_clk] + SCL_Fall_time
> 
> This lets me assume that these are the matching pieces of code.

Yep, I looked at the exact same code, and you are correct, with

"All invocations of i2c_dw_scl_hcnt() have cond = 0, offset = 0."

> While my patch had %s/ 7 / 1 / we would need %s/ 7 / 3 / to match the Linux formula. This should be
> enough to avoid the observed "bad count" error on the VisionFive 2.

Can  you try this out? And if it works may I ask if you send a v2
with some explanation added in U-Boot code, that we sync here with
that what you found in kernel driver?

Many Thanks!

bye,
Heiko
> 
> Best regards
> 
> Heinrich

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
