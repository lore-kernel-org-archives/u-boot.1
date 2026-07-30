Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2225EC55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0371608A3;
	Thu, 30 Jul 2026 13:05:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ox9XklnCI7RD; Thu, 30 Jul 2026 13:05:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 788E860896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785416725;
	bh=TCFXrFhBBrxWjGn0E9buYbWywBGbV8zMmKe1VoWvjSI=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hPJc6G+yGPg/fZrKZyBRVxwaj7fXCT2aOjvP9aTJ1WgToSfYu96qNGrcbTyCipShG
	 RiKhmDU8+Dz3Vn31EtWhdNPBn7yQdkNwakH82AjKSf/6hEMWaRy9QTKfmamOha8+8k
	 hMeikvvjlr0cprDWRjRcjlQ/sRq3pDO258vNaxZIJ0cCkIZr99SeQRPEyapF+LGyzN
	 XTk1unic0Xa5dgtFRHr8M586nXEIldrqqk8kTsel5WfzyMpxqQHQ5mvRYoM4JFKaSq
	 O8eAsHzTber4/zbxfkownbBDE1xgcXpdgtukDqXe/ias3sPCXYMzsmWgFcN5RpaHyp
	 xXx1fC0ICDjSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 788E860896;
	Thu, 30 Jul 2026 13:05:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8672F26C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6FFDA401A3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:05:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CLEJ3MuIWmvR for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:05:22 +0000 (UTC)
X-Greylist: delayed 553 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 30 Jul 2026 13:05:21 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CA7274008C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA7274008C
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:b8b8::190b; helo=smtp-190b.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::190b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA7274008C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:05:21 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h9q2F4lCWzyBr;
 Thu, 30 Jul 2026 14:56:05 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4h9q2C68Hkz5kR; Thu, 30 Jul 2026 14:56:03 +0200 (CEST)
Message-ID: <08f496c4-1593-4575-a55b-fc6985960456@0leil.net>
Date: Thu, 30 Jul 2026 14:56:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] clk: rockchip: pll: fix rounding of negative k in
 RK3588 frac PLL
To: Alexey Charkov <alchark@flipper.net>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Finley Xiao <finley.xiao@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
 <20260723-rk3588-fracpll-v2-2-382d113f3a80@flipper.net>
 <b258fdf7-16e2-49ae-b016-a54e710c4ae1@kwiboo.se>
 <CAKTNdwEHeTHU1RPQrKVu4JEvxv0pnsa04m+kxT=5BOAEMZ3j7g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKTNdwEHeTHU1RPQrKVu4JEvxv0pnsa04m+kxT=5BOAEMZ3j7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1785416165;
 bh=TCFXrFhBBrxWjGn0E9buYbWywBGbV8zMmKe1VoWvjSI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=l/36zxZazrehVNgaxJlk/J8k3aK6FqBZz0OiPnSiAnPUTKckbZSYNZerHrrEvDm5x
 IHSzqwC78BUY40GAnVUqRCuoU8RGPlgQDs/pdtuZMHWEUf56G16p/5f58bnr3LD7Q9
 rc7XzYQN9re/NO+uZg1e6extYuhiBj4c66grEkua0Rlp3SgvTl+7p3y/1k1DMNbswU
 drixly0s5mhaLMzyZfwq+4BXbp6mCiCXM7mhE952gA6PjGCxD/Hdv61cQyJxoHCnvC
 QRHfhNHrwrAuc7RxQoa2SGN/Fc1tArHFpUahLdIOahB9N7iD+WMDgdQATsFd2wH6iE
 2lyXTcp2r6YPg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=l/36zxZa
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 7/30/26 2:25 PM, Alexey Charkov wrote:
> Hi Jonas,
> 
> On Thu, Jul 30, 2026 at 4:16 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Alexey,
>>
>> On 7/23/2026 5:04 PM, Alexey Charkov wrote:
>>> Current code uses magical constants when rounding up the magnitude of
>>> negative fractional PLL component k. This leads to overshooting the
>>> requested rate when the calculated fractional part has less than 0.3 in
>>> its decimal part due to failure to round up the fractional part.
>>>
>>> Use a proper rounding up function to avoid overshooting the requested
>>> rate and make the calculation more readable.
>>>
>>> Fixes: 6bfb37e70209 ("clk: rockchip: rk3588: fix up the frac pll calculation")
>>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>> ---
>>>   drivers/clk/rockchip/clk_pll.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
>>> index d0df3b8fb49d..69d2d182dcb5 100644
>>> --- a/drivers/clk/rockchip/clk_pll.c
>>> +++ b/drivers/clk/rockchip/clk_pll.c
>>> @@ -11,6 +11,7 @@
>>>   #include <asm/arch-rockchip/hardware.h>
>>>   #include <div64.h>
>>>   #include <linux/delay.h>
>>> +#include <linux/math64.h>
>>>
>>>   static struct rockchip_pll_rate_table rockchip_auto_table;
>>>
>>> @@ -177,7 +178,10 @@ rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
>>>        k = ffrac * 65536 / fref;
>>>        if (k > 32767) {
>>>                ffrac = ((m + 1) * fref) - fvco;
>>> -             k = ((ffrac * 65536 * 10 / fref) + 7) / 10;
>>> +             /*
>>> +              * Round up to avoid overshooting requested rate for negative k
>>> +              */
>>> +             k = DIV64_U64_ROUND_UP(ffrac * 65536, fref);
>>
>> Use of DIV64_U64_ROUND_UP() seem to cause build errors for Rockchip 32-bit
>> tagets, see CI job at [1].
>>
>> [1] https://eur02.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.u-boot-project.org%2Fu-boot%2Fcontributors%2Fkwiboo%2Fu-boot%2F-%2Fjobs%2F54629%23L4016&data=05%7C02%7Cquentin.schulz%40cherry.de%7C74dcb2010c7c473b440708deee35b6c5%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639210111643377177%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=inNBaFIDx51MBU4%2Fefh2jPAQ49esWECfkahMG%2FWC1HI%3D&reserved=0
> 
> Weirdly, the macro is only defined for 64bit [2], even though the
> function it wraps around also exists for other word sizes.
> This calls for a separate fix to take the macro definition to the
> bottom of the header, like Linux does [3].
> 
> [2] https://eur02.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Fu-boot%2Fv2026.07%2Fsource%2Finclude%2Flinux%2Fmath64.h%23L51-L53&data=05%7C02%7Cquentin.schulz%40cherry.de%7C74dcb2010c7c473b440708deee35b6c5%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639210111643413367%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=J4lUntNUU4AFPi%2Bd%2BnoP0QKyBHTsEqYj9wQeMluOpxA%3D&reserved=0
> [3] https://eur02.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv7.2-rc3%2Fsource%2Finclude%2Flinux%2Fmath64.h%23L344-L355&data=05%7C02%7Cquentin.schulz%40cherry.de%7C74dcb2010c7c473b440708deee35b6c5%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639210111643448158%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=HJuazQjmgof5qWRnTLjY%2Fy2XSkImAm11%2BFb3HPCL8i8%3D&reserved=0
> 
> Thanks for spotting this!
> 

If possible, please simply synchronize with Linux. I'm guessing we need 
include/linux/math.h and include/linux/math64.h? Ideally, use a release 
tag (not -rc, and *definitely* not a random sha :) ).

Cheers,
Quentin
