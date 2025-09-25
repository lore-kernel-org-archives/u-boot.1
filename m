Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F5ACAC5B1
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 14:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D276809A5;
	Thu, 25 Sep 2025 16:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dEYZzyEw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC88582A9E; Thu, 25 Sep 2025 16:13:04 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38E7080107
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 16:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cXbK729SZz9t29;
 Thu, 25 Sep 2025 16:12:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758809579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L4WhqgjpEHTVNi5FoLl2/A2AW2c3q1YLysy7nK6y4ZM=;
 b=dEYZzyEwhBfp2sI+oJ1VMTzRFVa1weKUkfE6F7ZL9h9wX3SZVGJfy3zALUgBYKOMDKqcIX
 BlwwAbgSkWyILqovhQ6nWXpKveNPnJf85tSnOJ84M0x7HPYWAk346c0j0JbMLibaMZKZJn
 FL2jFZ4wzK3K7Fb7NDVAx9qIGj+5tkaBbq+wnIsEsRrh7KHvp58e6hefS3iLUed/Ok0qj9
 xCSn0vde82gtSfkirTHvq5PKWZaxHPBUTHLp8tAUzASSAhV2Ot5ff5fYxxZq2f/WjmnyuA
 t95KHHXGCcOZXK8GlNWEGSfRu59g1OKWqSCiWcdRHCaCUHMWsvleh/hA9QbhJw==
Message-ID: <59d4ef95-e030-4508-8e1e-ae37a0df6c29@mailbox.org>
Date: Thu, 25 Sep 2025 16:12:58 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: dwc3: Remove redundant test
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250925-dwc3_ep0-v1-1-7af60ed1e28c@linaro.org>
 <b6d1f1df-eed5-4cbe-8add-31c1e77e3a16@mailbox.org>
 <02ef127e-f789-4cc6-9592-eb4b75f1b0ea@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <02ef127e-f789-4cc6-9592-eb4b75f1b0ea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: oqq15bhqaznt3u6wc9s334mjgxhdcf3b
X-MBO-RS-ID: 2057db640fece63e08d
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

On 9/25/25 4:07 PM, Andrew Goodbody wrote:
> On 25/09/2025 14:56, Marek Vasut wrote:
>> On 9/25/25 3:20 PM, Andrew Goodbody wrote:
>>> In dwc3_ep0_complete_data there is a test for 'r' being null and the
>>> code will return at that point if so. After that point 'r' is guaranteed
>>> to not be null and testing for that is redundant. Remove the test for
>>> 'r' being non-null.
>>>
>>> This issue was found by Smatch.
>>>
>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>> ---
>>>   drivers/usb/dwc3/ep0.c | 5 +----
>>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>>> index c656cbe25ce..680756532f0 100644
>>> --- a/drivers/usb/dwc3/ep0.c
>>> +++ b/drivers/usb/dwc3/ep0.c
>>> @@ -799,10 +799,7 @@ static void dwc3_ep0_complete_data(struct dwc3 
>>> *dwc,
>>>       status = DWC3_TRB_SIZE_TRBSTS(trb->size);
>>>       if (status == DWC3_TRBSTS_SETUP_PENDING) {
>>>           dev_dbg(dwc->dev, "Setup Pending received");
>>> -
>>> -        if (r)
>>> -            dwc3_gadget_giveback(ep0, r, -ECONNRESET);
>>> -
>>> +        dwc3_gadget_giveback(ep0, r, -ECONNRESET);
>>>           return;
>>>       }
>> Please use ./scripts/get_maintainer.pl to get full CC list and CC all 
>> relevant parties.
> 
> Hi Marek,
> 
> I use 'b4 prep --auto-to-cc' which calls get_maintainer.pl to populate 
> the email addresses used.
It seems to be missing these people:

Mattijs Korpershoek <mkorpershoek@kernel.org>
Neil Armstrong <neil.armstrong@linaro.org>
Anshul Dalal <anshuld@ti.com>

