Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBAACD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 03:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF34384A0D;
	Thu,  7 May 2026 05:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ufs5jC1V";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ODjjwbok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 220C9849BF; Thu,  7 May 2026 05:51:43 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C79384A0D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 05:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g9ywr52Gsz9vJh;
 Thu,  7 May 2026 05:51:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778125901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YknNeBaMLWvZvzlSunnQoZomvVOntMzeGi1FUsfy8C4=;
 b=ufs5jC1VXj4n3WvUrinMIQY+C4DCW65E0y4U16qsTr7XTjNyuOiMR9XzY+uotMG5HasggJ
 qvXiqzLa/b2Tah0wPWg/n+9rGhlN5yl9muwkx9l/OFRkL+jDvJv/lHy1sdVgJnRxt86YP+
 KdtioInlLiT4febD85DTAEWb6G2o70j9ejG+TcKXfYLBfkVCeeXBwGQ7vdD4BrcVt6XX4W
 YNcGOF97hMe7LZLAj7aKP/OrFiAVLCzr7EZTHpdlU5C/CyXwlLpTZTbTZt5QI1DDLBxH5x
 mTKkGBsUavN3tUSymtJEzc6gFWhsE8aw3WivfvTwrfI6FNOkKcMl9dTKPsqtzg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ODjjwbok;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <6320a41d-77ce-402a-935e-ea5b6566452c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778125899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YknNeBaMLWvZvzlSunnQoZomvVOntMzeGi1FUsfy8C4=;
 b=ODjjwbokGt6mlBxYYSnYm9Ur9FpAb82FMUUyrcupkMs5O2O+djCdCzd9z1dcnnu51YvIiJ
 5WkSqMRLwBSowqcdWUs1ovIcLWPAO9UFAs1nopZ2NnLSPMLpvA5x+oFWEU2D+DsnpKWLXU
 HaK30mHy+vgdyNENFvmfV2ObwOK1QlJrPXQakd/tQ66lOptlmNiHtBn8naf7wE2Y+/ONL4
 PF7/UImmiQEF5To32U+NQN0xso+YOq/Er5TKNHSiRGOTtz/cc74S+MheWVFF8S5RV60Yr0
 H2wNDv8V8Hn4xVYnZP9MCrzfO0iUmPsiH64rJw6YgcUq8s99LiOxXpcYFWj+wQ==
Date: Wed, 6 May 2026 17:28:39 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: dwc3: Fix crash on fastboot exit due to incorrect
 memory free
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20260506-usb-v1-1-e0f426bb1e42@oss.qualcomm.com>
 <a74a7a66-c1f1-4d6e-b85a-49ecc8e2e882@mailbox.org>
 <437a2860-fecf-4f45-bbe4-3fb9e8958b6a@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <437a2860-fecf-4f45-bbe4-3fb9e8958b6a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yt38n31s5ixan7tdp8gcgtn5k661h5ha
X-MBO-RS-ID: a737ab51929db9914c3
X-Rspamd-Queue-Id: 4g9ywr52Gsz9vJh
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

On 5/6/26 5:26 PM, Balaji Selvanathan wrote:
> 
> On 5/6/2026 4:55 PM, Marek Vasut wrote:
>> On 5/6/26 8:14 AM, Balaji Selvanathan wrote:
>>> The dwc3_free_one_event_buffer() function incorrectly called free()
>>> on event buffer structures allocated with devm_kzalloc(). This
>>> caused heap corruption and a synchronous abort when exiting
>>> fastboot mode via "fastboot continue".
>>>
>>> Device-managed memory is automatically freed when the device is
>>> removed, so manual deallocation causes the heap allocator to access
>>> corrupted metadata.
>>>
>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>> ---
>>>   drivers/usb/dwc3/core.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index 0dee14c8b59..be198041f08 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -208,7 +208,6 @@ static void dwc3_free_one_event_buffer(struct 
>>> dwc3 *dwc,
>>>           struct dwc3_event_buffer *evt)
>>>   {
>>>       dma_free_coherent(evt->buf);
>>> -    free(evt);
>>>   }
>>>     /**
>> Does this need:
>>
>> Fixes: 884b10e86a05 ("usb: dwc3: core: fix memory leaks in event 
>> buffer cleanup")
>>
>> ?
> 
> Hi Marek,
> 
> We remove only "free(evt)"; "free(dwc->ev_buffs);" from this patch 
> (884b10e86a05 "usb: dwc3: core: fix memory leaks in event buffer 
> cleanup") is needed.
The Fixes tag is only a reference for posterity, to trace which previous 
commit this change repairs. The change itself is fine. Thanks !
