Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267A3CAC586
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 11:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EB9182DA1;
	Mon,  8 Sep 2025 13:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="e3KelpOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD0C383045; Mon,  8 Sep 2025 13:47:12 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB61682C84
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 13:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cL4th5chnz9t4g;
 Mon,  8 Sep 2025 13:47:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757332028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1k9aFv/pQybkS9VHksu8btjjVue/GzHvvZf10JHi3PA=;
 b=e3KelpOtD6WZyMTVg9+Fa1lub2Z6iVM6qBl7Y23CjvkJToHB2vCIBDW0ZmIRrWMD5b7qej
 mB1epYyWHpOm9ed6TIOkxrkVkH5WTdGTS1X+jBXdVQaAkwo3DB5Q7cE9Da55qfGE9hqr+P
 Wd1QCH39iC4A7L2BfTwQaS8NZwG8gGXz8yRECk+WALUjQy5qUW9+bSUUacLYcerbp5R4Kq
 s8YrzZyMOlIQyyDf7IPivvqliC+eaWR6S1bjQmFPbpEQ566xLAIy4PbNSlSERkjiabm0wr
 PhcwEOgiGcesr7orRiaLuUdjGcSkn8WRYn2PZnYLTyJpEkqYCJ02y2zkHBuZRg==
Message-ID: <18d735b9-d2c6-46e0-b27c-9c17f94b284d@mailbox.org>
Date: Mon, 8 Sep 2025 13:47:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] usb: host: ehci-msm: Clean up and fix crashes
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Jianfeng Zhu <JianfengA.Zhu@sony.com>, Jacky Cao <Jacky.Cao@sony.com>,
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Casey Connolly <casey.connolly@linaro.org>
References: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
 <aL7AgBHg6th2w1a5@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aL7AgBHg6th2w1a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 647e08f8fb576ff2da4
X-MBO-RS-META: 3p8z7uh95jbarkj51kk93nki9snkdx36
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

On 9/8/25 1:39 PM, Stephan Gerhold wrote:

Hello Stephan,

> On Mon, Apr 07, 2025 at 11:54:20AM +0200, Stephan Gerhold wrote:
>> The ehci-msm driver has several subtle issues and stale code. Most of them
>> are minor and do not cause issues during normal usage. The last patch is
>> the most critical, it fixes a reported crash when stopping/re-configuring
>> USB, which has been around for a few months now.
>>
>> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
>> ---
>> Stephan Gerhold (6):
>>        usb: host: ehci-msm: Fix pointer check
>>        usb: host: echi-msm: Drop ulpi definitions
>>        usb: host: ehci-msm: Disable clocks after all register accesses
>>        usb: host: ehci-msm: Use clk bulk helpers
>>        usb: host: ehci-msm: Drop redundant EHCI register writes
>>        usb: host: ehci-msm: Register ULPI PHY through NOP wrapper
>>
>>   drivers/usb/host/ehci-msm.c | 146 ++++++++++++++++++++------------------------
>>   1 file changed, 67 insertions(+), 79 deletions(-)
> 
> Could you apply these patches and send them to Tom? These are important
> fixes to make USB work properly on the dragonboard410c board and they
> have been on the list for a few months now. There is already an ack from
> Casey as well.
> 
> Or would it be easier for you if Casey applies them? I'm sure that would
> work too. :)
I'm fine with that, since they are isolated to msm.

Thank you for the reminder.
