Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039FBC2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 11:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0752F885BF;
	Tue,  9 Jul 2024 13:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720525248;
	bh=JPsr1SLRQiuvA6O3IVHobJwTtfF26gsCOrHgj0WtvDU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UOpzNnDmKDLF28HhFroEtSQQ/pRdKYxogiV69hvjU0dFbUmYcf8L50RcjYXwAYh/E
	 R3+F+825iZHCqNHn8vTMJnN7zITJfmsfIUYHVVMZEk4L2tu3mEfcpcmaJt6uhlrpBS
	 vzvk5intpZp4xThgff7z+8YMz44kva67bD1C3DEQxc377dlKQsIUrr5BJ/8j7d54mM
	 7e3QshfyxM7bt3bnGkq0nVsXuA5XJLwyTzyS8YrvUMVSq3iNXhf94dT9WyLTQXlQjr
	 vOHiufeqgUtMoeD0QrDrETA6oH8GBDRCzglUsRIoNaIpe6fo3ej/t9iDBlJw5Le43F
	 OYckvlLKsD/VA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7334F88498;
 Tue,  9 Jul 2024 13:40:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720525246;
 bh=JPsr1SLRQiuvA6O3IVHobJwTtfF26gsCOrHgj0WtvDU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VqloDHURfNYNIedJv6Z2OjRXhmq+GQsrACyAFJgSvZxNsWKFr2fCFSLI93RfyeWE9
 MrY6Z0fhE+xhuXHBXcLQ7SbeZrwvHcj+dGFjg4d4BcVRf+XFMDPOunTlhJKQSe/yb7
 pprXHaQEIqnQCoaLkBANoR284KMDWClUO4gBJJEvFYDNILb7U8umXf4gsJ42qKHo+o
 RVqdEUEbAZQrPr/39qBmojGRI8BVPYsNMgCtz6HwoS6WWDDXS6Xn6tBOk6KOTHLCiT
 lJkP4SqtlxfK3UA322RQ3KLfXx1RbRtPevdrHZb4J62tdJ0gCkQnRUWPtxTAMjOnx/
 X3XjXOasRYDFg==
Message-ID: <d8943137-1748-4f57-8a85-0561d2af05d4@denx.de>
Date: Tue, 9 Jul 2024 13:13:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eth: asix88179: reset during probe
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240618145759.3296876-2-caleb.connolly@linaro.org>
 <87v81fhsbp.fsf@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <87v81fhsbp.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/9/24 10:39 AM, Mattijs Korpershoek wrote:
> Hi Caleb,

Hi,

> Thank you for the patch.
> 
> On mar., juin 18, 2024 at 16:57, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> 
>> In some cases (consistently in my case with an embedded board) the
>> ethernet controller will time out on the first init but always succeed
>> after reset.
>>
>> Let's reset the controller during probe so we always start with it in a
>> known state, and don't have wait for the first asix_wait_link() to
>> time out.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
>> ---
>> I see this behaviour consistently across three Qualcomm platforms that use this
>> controller.
>> ---
>>   drivers/usb/eth/asix88179.c | 6 ++++++
>>   1 file changed, 6 insertions(+)

Do you want to pick it via usb-gadget tree or shall I pick it via usb tree ?
