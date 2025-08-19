Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B494CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 14:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0419809A5;
	Tue, 19 Aug 2025 16:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wUWa38IH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79DAF80FA1; Tue, 19 Aug 2025 16:51:32 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70687802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 16:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4c5swc20H4z9tJh;
 Tue, 19 Aug 2025 16:51:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755615088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HaFdQcVNI8XL/2WHAuVEjIsbps1wZYUnh6S7mrcn7MI=;
 b=wUWa38IHENaFAMUQjoCor2YLCT50nbp1789tzZrCjkmLSSOrfDnP7bsXztCxI2o5kmGQTF
 ghmgQskbN/rCtmI5C9FFdM2Vkss5BA9uE7H1rC5vVojAEqWaPjxqLG+oWsyFtjbaKJybMP
 traeIKxRFjmj3hmV8mHC6jZRrHcy/oaHP+iTCwt712KEJITbNy91+1z6ULePkJunElsw3R
 ZVY8zgdg1whMPCefxEi7xtyaH71Sv1tk6STx30p/0yVY8WOuN+V5b6yyOGsyPO3aSUgXAU
 b6d7O5CikD8vZfZ5GhgVNKKRUZPbCvgx/TEDWK2i6wToSo3+QBqyhN7DZy80yQ==
Message-ID: <84535d73-7496-4fd3-8ecb-ac6830974d51@mailbox.org>
Date: Tue, 19 Aug 2025 16:51:25 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: cdns3: Do not access memory after free
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de
References: <20250813-usb_cdns3-v1-1-3779912fe660@linaro.org>
 <b83f79a7-66e9-43b9-859e-ebb69e4d536b@nabladev.com>
 <0a4f4611-8858-4a38-be70-bf0947d689c1@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <0a4f4611-8858-4a38-be70-bf0947d689c1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 334e9faedb5d69db3e1
X-MBO-RS-META: awwh1rs9sz1t6ht5auyqx1pjgb18wjpd
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

On 8/14/25 12:45 PM, Andrew Goodbody wrote:
> On 14/08/2025 04:21, Marek Vasut wrote:
>> On 8/13/25 6:30 PM, Andrew Goodbody wrote:
>>> The call to cdns3_gadget_ep_free_request will free priv_req so do the
>>> call to list_del_init which accesses the memory pointed to by priv_req
>>> before the free.
>>>
>>> This issue was found by Smatch.
>>>
>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>> ---
>>>   drivers/usb/cdns3/gadget.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>>> index a30c40ef80e..9eaf7e40ab6 100644
>>> --- a/drivers/usb/cdns3/gadget.c
>>> +++ b/drivers/usb/cdns3/gadget.c
>>> @@ -557,10 +557,10 @@ static void cdns3_wa2_remove_old_request(struct 
>>> cdns3_endpoint *priv_ep)
>>>           trace_cdns3_wa2(priv_ep, "removes eldest request");
>>> +        list_del_init(&priv_req->list);
>>>           kfree(priv_req->request.buf);
>>>           cdns3_gadget_ep_free_request(&priv_ep->endpoint,
>>>                            &priv_req->request);
>>> -        list_del_init(&priv_req->list);
>>
>> Shouldn't the kfree() be moved here instead ? 
>> cdns3_gadget_ep_free_request() also accesses priv_req->request .
> 
> No, I do not think so. The kfree frees priv_req->request.buf not 
> priv_req->request so must happen before the call to 
> cdns3_gadget_ep_free_request.
Thank you for clarifying. Please add this into the commit message, 
ideally wait for TI to test this and provide RB, then send V2 so this 
can go in.
