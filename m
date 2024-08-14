Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8025C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 04:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8991C88155;
	Wed, 14 Aug 2024 06:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723608535;
	bh=T4hlF9enbEmkSFjLag021d3fNEEEG9GobLNy8wASe5o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=I/KDtjBkxXM+OwP8s0czn9V9znziwyKY5mRq+P/LgPkzM1rfAgMq4UofbBAmsY8tz
	 Tjpagxz8kUWwoG3gpjuI6xRGymIDhu9jqI3tvlUo5jZAbYmGGCKLRmWEwILUC7X4+G
	 RfOCNkWaGOE45a1hRwAjrONknznYl4+Ugz02bdHX/IKmA2OPuBjiBSz8alx4BDAATv
	 j8JbDJlwSyAU4DoN2bN4X4JszekjzAWHHwOqCQqgwsLgCm0JEK6tGQ7spEogd06Vxg
	 4g1XAHJQy8wnkyBJVXLsCifZtLKeLzKQDbXnPHjaGS8OHVLMH9wGP8dGWfoCSkc82Z
	 v2Q7byJ/ozIhQ==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8B55E880A5;
 Wed, 14 Aug 2024 06:08:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723608534;
 bh=T4hlF9enbEmkSFjLag021d3fNEEEG9GobLNy8wASe5o=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=WKAVKKSBnDEG8IWPVbdyAlNfOsaosa1V00KUZ5y3rojI3Gh5b8Zdw31B7DaQ/bRsT
 RClF5b1ZLKjsJ/A5CijYVsVPK3nLYF/CelxCLjjunHcJ8ZkCsA+F2K3y4FtUG///Yc
 KyD8WdScfQ/q9Ct3wd6suPnmeIPDd6Atyz3Wo7rfVck8ulFILl6NU6muhQcwQCu863
 kUnhs5MXLyN0G0RVCekCcxkhJVyXQjtGHwld4ZHjpwN1IxCVdPiryOP7hWwIlhd8Uo
 X7As1hXUqd2N9wRIxrNdKmpujlncwjT9gaT943WpRxBqDArB+edgxg6//M1vCu7vTi
 eJicm5grsIbDA==
Message-ID: <5d18242e-93bf-f881-68a7-64f6be8e3931@denx.de>
Date: Wed, 14 Aug 2024 06:07:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] driver: pwm: pwm-imx: fix probing on imx6
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
References: <20240807155343.122377-1-hs@denx.de>
 <CAOMZO5A23hR6CbLbvUR-ck111iowq=BKrMz_4PHwL4hQsmyxDQ@mail.gmail.com>
 <36b5a4e3-0848-7275-134b-a0929a1fea27@denx.de>
 <20240813161607.GJ1626301@bill-the-cat>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240813161607.GJ1626301@bill-the-cat>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

On 13.08.24 18:16, Tom Rini wrote:
> On Tue, Aug 13, 2024 at 03:57:08PM +0200, Heiko Schocher wrote:
>> Hello Fabio, Tom,
>>
>> On 13.08.24 14:27, Fabio Estevam wrote:
>>> Hi Heiko,
>>>
>>> On Wed, Aug 7, 2024 at 12:53 PM Heiko Schocher <hs@denx.de> wrote:
>>>>
>>>> U-Boot 2024.07 drops on aristainetos2 board the following
>>>> warning:
>>>>
>>>>           Failed to enable per_clk
>>>>
>>>> and bootlogo is not seen on LVDS display.
>>>>
>>>> This patch uses old behaviour for systems without clock framework
>>>> if CONFIG_CLK is not enabled.
>>>>
>>>> Fixes: bfc778cb93a3 ("driver: pwm: pwm-imx: get and enable per/ipg clock using dm")
>>>>
>>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> use CONFIG_IS_ENABLED instead of IS_ENABLED
>>>> as Anatolij suggested.
>>>
>>> This causes build failures:
>>>
>>> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/887503
>>>
>>> Please fix and resend.
>>
>> Hmm... yes ... I work/worked on aristainetos2 board update for 2024.07
>> (or later)  ... and saw this
>>
>>    Failed to enable per_clk
>>
>> warning when 2024.07 boots ... and bootlogo did not work anymore, as
>> backlight is pwm driven on this hardware...
>>
>> I bet, for all the boards which fail in the azure run with this patch,
>> PWM do not work anymore... because CONFIG_CLK is not enabled for them!
>>
>> I am really unhappy, that I have no automated U-Boot runtime tests anymore
>> running on real hardware... setup with tbot was very easy, but had no
>> time for looking at the bugs poping up...
>>
>> Hmm... looking in git history, there comes this commit in my eyes:
>>
>> commit 4eea76574062e9079b6a267229962d6ec0be910a
>> Author: Tom Rini <trini@konsulko.com>
>> Date:   Sat Nov 19 18:45:18 2022 -0500
>>
>>      pwm: imx: Remove unused references to CONFIG_IMX6_PWM_PER_CLK
>>
>>      On platforms that use DM_PWM, we do not need to define this value
>>      anymore, so remove it from config files.
>>
>>      Signed-off-by: Tom Rini <trini@konsulko.com>
>>
>> which exactly removes for all breaking boards this define...
>>
>> Should we revert this patch?
>>
>> I just can say for the aristianetos2 board, that I readded exactly this
>> define in my work for the port to currentmainline ... and with my patch,
>> pwm and so bootlogo works again ...
> 
> We can't do a strict revert, no, the symbol is now CFG_IMX6_PWM_PER_CLK.
> But also, isn't this board using DM_PWM? And if so, that value isn't
> used?

Yes, of course, simple revert does not work.

Yes, the failing boards are converted to DM_PWM, but they do not work
anymore as bfc778cb93a3 intrdocued clk framework functions, and the
failing boards have no clk framwork enabled. So my patch simply
readded the define for DM_PWM case.

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
