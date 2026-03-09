Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D998F417F1
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 14:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BF2B83F14;
	Mon,  9 Mar 2026 15:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yI6im1QQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0F8183F6E; Mon,  9 Mar 2026 15:55:00 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE8C83A8C
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 15:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1773068097;
 bh=TxxXxhOGK9XkVx5kR3WAA68INJzp+bhrdrYfbdEiEeg=;
 b=yI6im1QQ7hQquYkCXs+4kGwZHQfMJOfAOO+nJFpiAzEFdib+nTJt8khkiNLkujRdR3q3cJytp
 OvdHISss/n93ByDdF90xK3sZbYluelOFufQAGQc6Bm2uxmcZ+rQwtybdgpxLlglW1IjfY/bfKcg
 c1pylumonHX/SINVMloAfKMtZlgRz9pGgJImfYeA0R7jlat4jCP1BDHwrQWB6OUSvH/X2MlTXPC
 htuzjsm9n2BnOuc1iUcyfQA7Plv7PXKe3CDE0UkuTH0NehL+aWV/7IpMSNeflgrt7BfWu83P4BD
 +ICX7jwuPivOPiubmwzcOLgepOpwAduPpeDdXL5+Le/Q==
X-Forward-Email-ID: 69aedf3b160ae4b062452571
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.48
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <71e54f48-2827-4b16-9f16-cbfe97b6ec0d@kwiboo.se>
Date: Mon, 9 Mar 2026 15:54:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] arch: arm: rockchip: Add initial support for
 RK3506
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de
References: <20260131233843.3419737-1-jonas@kwiboo.se>
 <20260131233843.3419737-13-jonas@kwiboo.se>
 <9c1373b7-d577-4568-802c-95bf24974b94@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <9c1373b7-d577-4568-802c-95bf24974b94@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Kever,

On 3/9/2026 3:40 PM, Kever Yang wrote:
> 
> On 2026/2/1 07:38, Jonas Karlman wrote:
>> Rockchip RK3506 is a ARM-based SoC with tri-core Cortex-A7.
>>
>> Add initial arch support for the RK3506 SoC.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Acked-by: Mattijs Korpershoek <mkorpershoek@kernel.org> # drivers/usb/gadget
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks, I have made some minor changes to this series in my local tree,
I will refresh and send a v3 of this series later today.

Regards,
Jonas

> Thanks,
> - Kever
>> ---
>> Changes in v2:
>> - Enable SPL_ARMV7_SET_CORTEX_SMPEN
>> - Drop read_brom_bootsource_id() now that default impl support 0x81
>> - Fix mac1 and otg1 access to ddr memory
>> - Collect a-b tag

[snip]
