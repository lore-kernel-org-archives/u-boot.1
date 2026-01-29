Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03710D61033
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 17:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AAA784082;
	Thu, 29 Jan 2026 18:25:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vOiJQZ08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F5884088; Thu, 29 Jan 2026 18:25:20 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 465A183D1A
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 18:25:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f25cq2T3Mz9tyL;
 Thu, 29 Jan 2026 18:25:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769707515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LkBN2qggbNngmE9DMyjtubZf4Z9KNP7gV4xEVLKMtcY=;
 b=vOiJQZ08amkcbIKyx03kSjfx+F2u7897lN8Ub+BMFRttv81xoBZXB0AyhYjIqhDbn8YtT8
 2loRLhR/w4Oo0QFl4AlYT1FsvkdFcpacoz8B0wPO2ZaI0CyFQSqKi/5jd2HR4gG1qyV4Uz
 56GlQ2fDot9co1xm9AleDsuPOfOUY7YmsweiQISlAasW1NScg+pem5BPu0jVOvUeADzORb
 cdLCbCmYRLQ4G5WRkahjTzqpHEuF8JwT3YFjBbu6AtgExJ+fCQJbInGZwjeiPK4C4uD5zJ
 b6Lwx1JasLGKmPaAUXhO1Vc8BQqj6mQfBh2upfFynwS/7r+t+EzZwK7CPRbL+A==
Message-ID: <f3c106e8-4239-4d35-b97b-778a98501c78@mailbox.org>
Date: Thu, 29 Jan 2026 18:25:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] gunzip: Add ability to disable progress indicator
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
References: <20260127235914.1503663-1-marek.vasut+renesas@mailbox.org>
 <87wm10mm0g.fsf@kernel.org>
 <0af7fd1f-7f8b-4ef4-b8ba-9df260fb8f81@mailbox.org>
 <20260129165341.GC2044980@bill-the-cat>
 <a2760c72-787d-4bb8-a6e4-8a6b118967f1@mailbox.org>
 <20260129171616.GD2044980@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260129171616.GD2044980@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0cf26056102cb2375c8
X-MBO-RS-META: xmbt6rpzqnmqpt3wuf9x68a5uu6rexum
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

On 1/29/26 6:16 PM, Tom Rini wrote:
> On Thu, Jan 29, 2026 at 05:57:47PM +0100, Marek Vasut wrote:
>> On 1/29/26 5:53 PM, Tom Rini wrote:
>>> On Thu, Jan 29, 2026 at 05:33:45PM +0100, Marek Vasut wrote:
>>>> On 1/29/26 5:17 PM, Mattijs Korpershoek wrote:
>>>>
>>>> Hi,
>>>>
>>>>> +++ b/lib/gunzip.c
>>>>> @@ -8,6 +8,7 @@
>>>>>     #include <command.h>
>>>>>     #include <console.h>
>>>>>     #include <div64.h>
>>>>> +#include <env.h>
>>>>>     #include <gzip.h>
>>>>>     #include <image.h>
>>>>>     #include <malloc.h>
>>>>
>>>> This is part of
>>>>
>>>> gunzip: Implement chunked decompression
>>>>
>>>> so clearly I should move that part here already.
>>>>
>>>>> Maybe this should be included conditionally depending on the command
>>>>> being enabled or not?
>>>> Why conditionally ?
>>>
>>> A good general question I had is, what's the overall size impact of
>>> these features?
>> A more general question is, can we do without this patch. I think yes, but I
>> didn't find a way to make the test pass without inhibiting this odd
>> self-rewriting progress line. Is there a way to ignore output until specific
>> line shows up or something along those lines ?
> 
> I believe so, but I don't recall off-hand.
Nevermind, I found a way, it is ugly looking but works, I'll send V2 
without this patch.
