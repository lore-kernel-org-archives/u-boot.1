Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5020F606A31D
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iIuaLiNQ;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=ZDRziRB0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2818340641;
	Sat, 31 Oct 2026 14:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PlXju9wvb5i6; Sat, 31 Oct 2026 14:46:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6B2474064C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793457978;
	b=HXy1tfZ3PNQgJlP+q3VyfK7w6a1hVrDDpmYOqY2f6yBqJcJoPNenfCXJEeSACFAg9XKM
	 dnhNPPnEFPe/N6bRN1auRvctuBUY0kbD4oLn12srTT2yU/PxM47YVmlDjNYl8DeAO3efb
	 bAsocaNMfvjLBNq4tgg4u1hq5y8s+kfZpjaWjKXphHieYbxamtPoq25cbmue0ya42o4vN
	 rI6X76/hgOYQld4ukV9Zh9WLh5y+RevoQ77m0EGrx9Xd3wMr0na559RQXT7dy+zkGAAqy
	 JDw4jd4svFvZNLKvD3Bci1UrzaPzKxrNQjwKdZG7d7dw7gFPgzxTy27DhB6cjMAEzTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793457978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WWqRsxjbKkAq7G64QxKc8xfh2YmRI9+e8K496IxICgc=;
	b=lJ1MOF3oMcnYC+02nqE5gjI0/FdoMbJW7QEuAiORKbh+ASVOn6pxfFLuJUtIda52FIun
	 DQdpKCpHKUMFCj6vO3+mZxb27PzNdEKTLRLkgA1zxKSD1eY2mVgeXEdP03/S0NMgwn5AB
	 NY++j5iLDIbZx/ZLK9jd9a0drZaUHKGj8L1LmOA+dQCrafshm1o3eP/gtlWotHEx+wP9s
	 rfmxUdWnP8Vi2qK6XzoKUS1J04SVbdwGva32zEFq2PFQTgHcoqihEjS4MWh4RJkRVxJ6U
	 bpLiuDd9Km+/8XvQ27Z8Fp366T7SPdY33suAdYSLmD2TOR9NkC+lVkVBF8rLdSdgnpA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793457978;
	bh=WWqRsxjbKkAq7G64QxKc8xfh2YmRI9+e8K496IxICgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iIuaLiNQrcfP4+Uc02tXThuddGMtIA/KGEq3PxKwWWGLtQS4WRqdG1UQDGTyDO6ku
	 4F54opprAtyO5CyHUIrtqQBSwftVIXVZC480kD9qMs1a86qpLseHVk4HekN9yDYfEt
	 5gnn4h7slqj19zEkkDVqcwBSKYelEt3jW5oHgbpmp2GFJuB5toLaD/5fuuKjhI/rgq
	 8ns2qxMhka9Q8kUmr2+e7DYLLOWBDU0kvPtyUQioYlg9sIiNJuCwI3BQUWXf/sCKWF
	 HWLW3Xf2Z8Y5zBEqDWn9N6k+QvHRaOw24gswKJ1G329hMX6T3MkcjRvvu9d7gVRN5o
	 mshFQ4ldK41+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B2474064C;
	Sat, 31 Oct 2026 14:46:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A4FD156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3789A60617
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:46:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c1vBGuI_8-bu for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:46:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4C891605E9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793457976;
 b=Fz6qRRMwXlDRx0u+X/20vnOdxeR5TITc3hov5gFjCixuwMN95t5rkV9IPL8ztGyyzNUQ
 LeUaX0qbcxlrzagcs9STH4kNx6wHMFWXETTSODDBrymZ2WO7tY0xusLKEUU1bWHmriR8a
 mKGlt8Zc3jGroqLExvXQwGNyVljHNcTAR+vYG+G+xFERZZWu3LED2xYa/7gpVLgyppsAm
 UyhcCDbhLcbtr4LrEAS1se4B/3I+JRYSVJQjH3u7Wmfov3v4ucVbKWe3iq6tqpPhQp3LM
 PHeetGJ42MhEOtYwljnqtvLCHioX+vRMcUPMd3HH3INrd4erWNKZS3HRMBFK9A2Vf9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793457976;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=WWqRsxjbKkAq7G64QxKc8xfh2YmRI9+e8K496IxICgc=;
 b=jexAewNsvvN6TXnY0BxyDFSIx9X0eIpTpIZK/XJR8aCfjD/W7pt0wPxj0pSgO3S1BjGe
 Jm4y4XfsssNTDgzQgOUoP4ORs/pqp3SXCvk9qWDt3vCfpNhnUYQFNwbdLnjWHkWg63vPd
 mz6xl7FKRFwagpdEeb4GWC7B1ELsWOur2A7xi0M7LDKJ9rMGKHVEmxZOOrbfVk1rillaW
 IAtTww3esUODmtJck1JqgCOyGXEL2iQjkTyZrslTEbKdFIf5cmjnnjPxmQcZnc9cHnDT/
 x1XLMQ+flXERHmKpCj+anmvFO7MCV4XncPFgU1rozaU4KiE2rcLzfMC3S4Di3hm/yXw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ZDRziRB0; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ZDRziRB0
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C891605E9
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:46:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9B03810C1F1; Sat, 31 Oct 2026 15:46:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793457969;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=WWqRsxjbKkAq7G64QxKc8xfh2YmRI9+e8K496IxICgc=;
 b=ZDRziRB0XPQjpsghQSRbA8EXpia//TtL5bNPYhxmyqYwfv0bQn5tWDKfiMiGzhjvNWP7ei
 GVnHMhqwuxtCSE8lc89vwtjmGsF93l1Hm0iAo+BHaramJYaJB7va4prU9u51DO7ByJcat/
 eMltQJlfJ1UqHEU7u0sLWm/xFYJ4S/Obqipm+Uu33P+jgzCTdngr+OA9K53fEg8cMW+VqD
 XWB5YPqamvwOgaVT6cnoT9phlYTuh9U72NqX07+dXGKqx3h99DCu5invaYkWkoEfKgYHtq
 Q6bduZsl6TSW+tsUH8TZc5kQLpH1Pxcs12zg7pXboyK2vBGAqoqs2s5PTckz8w==
Message-ID: <5aab9a5e-dbb6-4ab9-a740-c2fb62e3094b@nabladev.com>
Date: Sat, 31 Oct 2026 15:46:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
To: Tom Rini <trini@konsulko.com>
Cc: khaliforce <kforce@gmail.com>, Romain Beauxis <romain.beauxis@gmail.com>, 
 u-boot@lists.u-boot-project.org, Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
 <20261006161015.GB1356209@bill-the-cat>
 <e4661500-74e4-4bed-b09a-a54d24eb6062@nabladev.com>
 <20261011220316.GJ769217@bill-the-cat>
 <489e6811-cb25-4085-8077-427100154182@nabladev.com>
 <20261011223137.GK769217@bill-the-cat>
 <c532672f-8ff7-4e80-8f78-0140bdcbd434@nabladev.com>
 <20261016000442.GG259661@bill-the-cat>
 <adb76f1c-cac1-4cee-9428-563e67c50d5c@nabladev.com>
 <20261031141832.GO3309461@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261031141832.GO3309461@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/31/26 3:18 PM, Tom Rini wrote:
> On Sat, Oct 31, 2026 at 07:38:46AM +0100, Marek Vasut wrote:
>> On 10/16/26 2:04 AM, Tom Rini wrote:
>>> On Thu, Oct 15, 2026 at 11:17:28PM +0200, Marek Vasut wrote:
>>>> On 10/12/26 12:31 AM, Tom Rini wrote:
>>>>
>>>> [...]
>>>>
>>>>>>> I believe the answer there is that we have flags to handle this problem
>>>>>>> generically rather than hard-coding a call in every arch's
>>>>>>> boot_prep_linux or similar like we had to with the old USB gadget stack.
>>>>>> This is shutting down host, not gadget. And I believe usb_stop() is
>>>>>> necessary to correctly shut down the devices on the USB bus, while the
>>>>>> DM_FLAG_ACTIVE_DMA flag is necessary to shut down the controller, so both
>>>>>> are needed.
>>>>>
>>>>> Host or gadget isn't the point here, it's that we used to hard-code the
>>>>> stop function call for the non-DM driver and now we have driver model
>>>>> and flags. Everything should be able to properly unwind with flags being
>>>>> set.
>>>> So what needs to be tested is whether the flags are enough to properly stop
>>>> devices downstream of the controller, or whether we need something more,
>>>> possibly equivalent of "usb stop" in the USB uclass pre_remove callback or
>>>> some such thing.
>>>
>>> What more testing do we need at this point to see what
>>> DM-related-unwinding that usb_stop does that isn't also covered by
>>> adding this flag to the controllers that are missing it?
>> Plug two or more hubs into each other and then into the controller, then
>> connect at least one USB stick into each hub, start booting and see if those
>> devices get removed in the correct order (stick furthest from the controller
>> first, nearest stick one before last, controller last). This is my concern
>> here.
> 
> Thanks for elaborating.
Sure. Sorry for the delay.
