Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3793DCA0EEB
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 20:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A42480422;
	Thu, 21 Aug 2025 22:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tp8VDx0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2367A80548; Thu, 21 Aug 2025 22:22:49 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E38E8006D
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 22:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c7F9w4xfsz9tLj;
 Thu, 21 Aug 2025 22:22:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755807764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmlqWnkbE1ilxfgSM35OkfLrDeGULQHI9JK0DKfQF3Q=;
 b=tp8VDx0j+IwCEKSmrCX+VEKsd2H4YCCcXoPGQ56KPwGxhW9WeZqtaNkY7iXVbMZPnQ6fRP
 00Ki9a+AHnPUR4nwdwJftzS8VBX3V3adytAuBBMzMWMQmcPhqTEtmGDFgpl/sLpeDkkfPG
 2v/7BMcOCcCwOikxNq8zZ5A3GAx6aTSJ6mKhXjJgh49S2q2OgQnifFD4zTe6AhdD7+wURG
 1ZU0t2znm1P3y10OUgHdVLOWO+DWWkO82+kus5hSBSjr/xjeA/zprpnPRB6c78ZpMpbdRD
 mk1mV2SHXDxZpvzyCIV+rKoyu0r7/E+wN/h7O5qYO/I6RNE30QH27B02PGCm5Q==
Message-ID: <2ff9412a-795c-422b-9be4-576e64a7f395@mailbox.org>
Date: Thu, 21 Aug 2025 22:22:43 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: cdns3: Do not access memory after free
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 u-boot@lists.denx.de
References: <20250813-usb_cdns3-v1-1-3779912fe660@linaro.org>
 <b83f79a7-66e9-43b9-859e-ebb69e4d536b@nabladev.com>
 <0a4f4611-8858-4a38-be70-bf0947d689c1@linaro.org>
 <84535d73-7496-4fd3-8ecb-ac6830974d51@mailbox.org>
 <e2257066-ee97-44ff-9338-cec69f8c7f03@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <e2257066-ee97-44ff-9338-cec69f8c7f03@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: p65gr9fk6nnbu6xfih7m7ng9ehct9xra
X-MBO-RS-ID: 04c0d5877ec93ee9d6e
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

On 8/21/25 8:16 AM, Siddharth Vadapalli wrote:

Hi,

>>>>> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
>>>>> index a30c40ef80e..9eaf7e40ab6 100644
>>>>> --- a/drivers/usb/cdns3/gadget.c
>>>>> +++ b/drivers/usb/cdns3/gadget.c
>>>>> @@ -557,10 +557,10 @@ static void
>>>>> cdns3_wa2_remove_old_request(struct cdns3_endpoint *priv_ep)
>>>>>            trace_cdns3_wa2(priv_ep, "removes eldest request");
>>>>> +        list_del_init(&priv_req->list);
>>>>>            kfree(priv_req->request.buf);
>>>>>            cdns3_gadget_ep_free_request(&priv_ep->endpoint,
>>>>>                             &priv_req->request);
>>>>> -        list_del_init(&priv_req->list);
>>>>
>>>> Shouldn't the kfree() be moved here instead ?
>>>> cdns3_gadget_ep_free_request() also accesses priv_req->request .
>>>
>>> No, I do not think so. The kfree frees priv_req->request.buf not
>>> priv_req->request so must happen before the call to
>>> cdns3_gadget_ep_free_request.
>> Thank you for clarifying. Please add this into the commit message, ideally
>> wait for TI to test this and provide RB, then send V2 so this can go in.
> 
> I was planning to test this patch but the change being made is only
> applicable to Controller Versions:
> 	#define DEV_VER_NXP_V1		0x00024502
> 	#define DEV_VER_TI_V1		0x00024509
> and not to:
> 	#define DEV_VER_V2		0x0002450C
> 	#define DEV_VER_V3		0x0002450d
> 
> Since I don't have an SoC and a Board with DEV_VER_TI_V1, I cannot test
> it. However, the change looks correct to me.
> 
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
The change does indeed look correct.

Do you know who might still have that board and could test ? (and which 
board/soc is that) ?
