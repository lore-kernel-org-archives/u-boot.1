Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76486CA1002
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 11:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E845B839DE;
	Mon,  1 Sep 2025 13:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36F2F839E2; Mon,  1 Sep 2025 13:33:14 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08113839A1
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 13:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.243])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 3ECD7B2202B3;
 Mon,  1 Sep 2025 13:33:08 +0200 (CEST)
Message-ID: <d7bae62a-2e53-458e-9b7e-76087379c064@freeshell.de>
Date: Mon, 1 Sep 2025 04:33:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: introduce CONFIG_DNS
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>
References: <20250718104852.724720-1-jerome.forissier@linaro.org>
 <20250827145550.GA644866@bill-the-cat>
 <1d6f9df7-e89f-4ede-acd4-bb87b5ee1360@linaro.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <1d6f9df7-e89f-4ede-acd4-bb87b5ee1360@linaro.org>
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



On 9/1/25 00:32, Jerome Forissier wrote:
> Hi Tom,
> 
> On 8/27/25 16:55, Tom Rini wrote:
>> On Fri, Jul 18, 2025 at 12:48:48PM +0200, Jerome Forissier wrote:
>>
>>> Introduce the DNS Kconfig symbol so that various network commands may
>>> use host names without the dns command (CMD_DNS) being selected.
>>>
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>> CC: E Shattow <e@freeshell.de>
>>
>> After talking with E Shattow on IRC, lets take this now for master to
>> fix the regression
> 
> That patch was in my pull request net-20250818 [1] which you merged
> into master the same day.
> 
> [1] https://lists.denx.de/pipermail/u-boot/2025-August/596830.html
> 
>> and in the next branch move forward with more
>> aggressive renaming / correcting of Kconfig symbol names (and introduce
>> as needed new splits between library functionality and cmd
>> functionality, which in turn might also mean needing to move some
>> argument validation out of cmd and in to library code). Thanks!
> 
> Sounds good.
> 
> Thanks,

Acknowledged. I failed to notice this was merged, sorry for the noise.

I have sent a patch to enable this new symbol in the board config I am
concerned with. [1]

1: https://lore.kernel.org/u-boot/20250901112748.676541-1-e@freeshell.de

-E
