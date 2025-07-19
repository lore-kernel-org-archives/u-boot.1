Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491CAC83F1A
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 03:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A39B8343F;
	Sat, 19 Jul 2025 05:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E281D834EC; Sat, 19 Jul 2025 05:04:21 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98277833AD
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 05:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.27.216])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 955F3B4D1B05;
 Sat, 19 Jul 2025 05:04:17 +0200 (CEST)
Message-ID: <1252adcb-e248-484c-9ca8-a335933d55b6@freeshell.de>
Date: Fri, 18 Jul 2025 20:04:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: dns depend on enabled protocol config instead
 of command
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de
References: <20250712050121.88951-1-e@freeshell.de>
 <60f316be-a61e-4a8e-8f5a-964fd3e1b912@freeshell.de>
 <d0c203c4-3981-40d2-986b-93daf8737379@linaro.org>
 <6c32d0f6-7df5-4f2b-8ed2-2eb97a818869@cherry.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <6c32d0f6-7df5-4f2b-8ed2-2eb97a818869@cherry.de>
Content-Type: text/plain; charset=UTF-8
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

Hi Quentin, Jerome,

On 7/18/25 06:25, Quentin Schulz wrote:
> Hi Jerome, E,
> 
> On 7/18/25 12:29 PM, Jerome Forissier wrote:
>> Hi E,
>>
>> On 7/14/25 03:52, E Shattow wrote:
>>>
>>>
>>> On 7/11/25 22:01, E Shattow wrote:
>>>> Allow dns when enabled CONFIG_PROT_DNS_LWIP=y CONFIG_CMD_DNS=n
>>>>
>>>> Fixes: a383869d6b58 ("net: lwip: move dns init to common function")
>>>> Signed-off-by: E Shattow <e@freeshell.de>
>>>> ---
>>>>   net/lwip/net-lwip.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
>>>> index 3918d57d7e5..5d247c3721b 100644
>>>> --- a/net/lwip/net-lwip.c
>>>> +++ b/net/lwip/net-lwip.c
>>>> @@ -147,7 +147,7 @@ static int get_udev_ipv4_info(struct udevice
>>>> *dev, ip4_addr_t *ip,
>>>>    */
>>>>   int net_lwip_dns_init(void)
>>>>   {
>>>> -#if CONFIG_IS_ENABLED(CMD_DNS)
>>>> +#if CONFIG_IS_ENABLED(PROT_DNS_LWIP)
>>>>       bool has_server = false;
>>>>       ip_addr_t ns;
>>>>       char *nsenv;
>>>>
>>>> base-commit: 6bb0679377abb01a82db1ce69b5bf1d40aa02ace
>>
>> I think the proper way is to introduce a new "DNS" Kconfig symbol to
>> differentiate between DNS support and the DNS command itself.
>> PROT_DNS_LWIP
>> should remain an internal symbol not exposed to the user and selected
>> automatically when DNS is enabled. DNS would apply to both NET and
>> NET_LWIP.
>>
>> We already have a similar mechanism in place for WGET and CMD_WGET.
>>
>>>
>>> Postscript: There was recently a U-Boot release and the above patch only
>>> applies to origin/master (is apparently not needed or applicable to
>>> origin/next). However on origin/next there are similar troubles where
>>> DNS is disabled unless the dns command is enabled in several network
>>> commands, which is something I can test for but am not the expert to
>>> make a patch or suggestion for.
>>
>> IIUC origin/next is not the proper reference at this point in the release
>> cycle, so I would say it doesn't matter.
>>
> 
> next is pushed only after -rc2. We are currently in the merge window, so
> master is the target for patches, c.f. https://docs.u-boot.org/en/
> latest/develop/release_cycle.html#release-cycle
> 
> Cheers,
> Quentin

Acknowledged. Disregard my patch here. Thanks! -E
