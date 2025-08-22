Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B142ACA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 14:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0D4780548;
	Fri, 22 Aug 2025 16:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PVUkn2Eu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0AD082103; Fri, 22 Aug 2025 16:55:55 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 402818006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 16:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c7jtH279qz9tKX;
 Fri, 22 Aug 2025 16:55:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755874551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=664hSFvXokI7GefU8ylGPtSg+ktCBGOSP+Tb2DO6dJg=;
 b=PVUkn2Eu/v0i0yv+SKukLyxHNbIzZrBgy1DPUpL4aLmNuYVyt7EUoB4AvZ8ioSMQ3NuN6e
 uQsWOprAmWscMK+AUxpAXxUZmJSQGancpyDgJgVn8QUrF5S3+DOySzQzKZYZmmhnL8AiT4
 HC2V+ctanvOYLSOla5gcZ8n/mrEmQgI524zhVSsX0h61CSArbryPd5y3ltQLa3F+DwZuU5
 oE4OSDlzxFhI6gqUa5BxDWZ94fy0vM7E9xOt7951AICqhLmwlWs3RjhzLMLaTP9dPUlvmv
 D3Uu5I4leY9Hc/CZlDN97j7FJjo+4RiDxggfDzl1qd4z3KWZw+wafqBC7QXEPg==
Message-ID: <bf35a459-29dc-48f8-a353-7f75493e959c@mailbox.org>
Date: Fri, 22 Aug 2025 16:55:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: cdns3: Do not access memory after free
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 u-boot@lists.denx.de
References: <20250813-usb_cdns3-v1-1-3779912fe660@linaro.org>
 <b83f79a7-66e9-43b9-859e-ebb69e4d536b@nabladev.com>
 <0a4f4611-8858-4a38-be70-bf0947d689c1@linaro.org>
 <84535d73-7496-4fd3-8ecb-ac6830974d51@mailbox.org>
 <e2257066-ee97-44ff-9338-cec69f8c7f03@ti.com>
 <2ff9412a-795c-422b-9be4-576e64a7f395@mailbox.org>
 <63d6759a-a8be-41d6-8870-72bdc3856c05@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <63d6759a-a8be-41d6-8870-72bdc3856c05@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: f98ek8wqwz9dfr8ukdz8r7emixmi7rya
X-MBO-RS-ID: e204d4a9565b1da6526
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

On 8/22/25 4:14 PM, Siddharth Vadapalli wrote:
> On Thu, Aug 21, 2025 at 10:22:43PM +0200, Marek Vasut wrote:
>> On 8/21/25 8:16 AM, Siddharth Vadapalli wrote:
>>
>> Hi,
>>
>>>>>>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>>>>>>> index a30c40ef80e..9eaf7e40ab6 100644
>>>>>>> --- a/drivers/usb/cdns3/gadget.c
>>>>>>> +++ b/drivers/usb/cdns3/gadget.c
>>>>>>> @@ -557,10 +557,10 @@ static void
>>>>>>> cdns3_wa2_remove_old_request(struct cdns3_endpoint *priv_ep)
>>>>>>>             trace_cdns3_wa2(priv_ep, "removes eldest request");
>>>>>>> +        list_del_init(&priv_req->list);
>>>>>>>             kfree(priv_req->request.buf);
>>>>>>>             cdns3_gadget_ep_free_request(&priv_ep->endpoint,
>>>>>>>                              &priv_req->request);
>>>>>>> -        list_del_init(&priv_req->list);
>>>>>>
>>>>>> Shouldn't the kfree() be moved here instead ?
>>>>>> cdns3_gadget_ep_free_request() also accesses priv_req->request .
>>>>>
>>>>> No, I do not think so. The kfree frees priv_req->request.buf not
>>>>> priv_req->request so must happen before the call to
>>>>> cdns3_gadget_ep_free_request.
>>>> Thank you for clarifying. Please add this into the commit message, ideally
>>>> wait for TI to test this and provide RB, then send V2 so this can go in.
>>>
>>> I was planning to test this patch but the change being made is only
>>> applicable to Controller Versions:
>>> 	#define DEV_VER_NXP_V1		0x00024502
>>> 	#define DEV_VER_TI_V1		0x00024509
>>> and not to:
>>> 	#define DEV_VER_V2		0x0002450C
>>> 	#define DEV_VER_V3		0x0002450d
>>>
>>> Since I don't have an SoC and a Board with DEV_VER_TI_V1, I cannot test
>>> it. However, the change looks correct to me.
>>>
>>> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> The change does indeed look correct.
>>
>> Do you know who might still have that board and could test ? (and which
>> board/soc is that) ?
> 
> None of the boards that I have worked with have a DEV_VER_TI_V1 version
> of the controller. I also tried to use the Linux device-tree to check if
> I could identify the SoC/board but I was unable to do so.
Do you know which SoC is V2 and V3 ?

Also +CC Nishanth .
