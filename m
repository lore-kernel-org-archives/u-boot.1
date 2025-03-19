Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D877EC282EC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 02:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 774588129F;
	Wed, 19 Mar 2025 03:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RE4TIoNb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WYwl/k8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A608815D1; Wed, 19 Mar 2025 03:37:14 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B97581101
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 03:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZHXsz5jxFz9t1c;
 Wed, 19 Mar 2025 03:37:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742351831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5LFO6baxIZm15TOslVhj1F5rVA/Jhf3oqujNzXiJEk=;
 b=RE4TIoNbMPy1JpZNicjYlmkfp6xVFuwPIImehilUUY0OY7etKNH6eoxZe55vCxfYp19DjS
 Ho+HXqrAHksnFVqgVD9Pp93MqFsvyAERoTUhZW3B5eRvQ4nXrRmMd8ZCP4eoRv0FXLLMuC
 lnVdjyijyeTE8ZGFrB87wuhphg/vBF8uaZBRpHmqdbXE9HjIWeR/+8JYJRx3/CnKNpi1uz
 7fAgcZEIe/Mq9tHavBSDAmzGaPnsdEsdGLxCRcqfDxBiSzKjKjSKCcKP3g4Hvcy1akLVaC
 8b8OsoHUucu+e0aZn9WLHqnlfKyUixtZc+U3FOZIYhTCsB0HgM1G3fbOO/KWYg==
Message-ID: <8e8b157c-54e4-4830-aa23-ff7e57ca140e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742351829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5LFO6baxIZm15TOslVhj1F5rVA/Jhf3oqujNzXiJEk=;
 b=WYwl/k8nEMs2KqWusy7aQbuWMeq5Yhmm3fKEg703V1Rw77eyTly2Dk7vOqrS5h3jhaXdcQ
 TWRuWo4IesZACPE3hHskKYrNyDx81Hs6t8gUI16EUwkLmBvpY+hOpS4/PenMbk8scnphR3
 k8HjZU2s1d9vaGcVMTX8TxCBwBRGPD8RRjjyhlPpim92E6nOc7pNg6KIgEzznuiiJf8wjW
 nCrGxtNou4kc4fEx5w+hvl8cdk+JIpFgbWmp7NhWyxq4xsCKDVQt0dDyEonRxZ1ZLMmHZX
 +tuBG1bnCy/gsVqJrNXHrfsk3N1x1j94dddvb4MTnUOce6lngm3opUhYjmx8Xg==
Date: Wed, 19 Mar 2025 03:37:08 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] net: ravb: Fix error handling in ravb_probe
From: Marek Vasut <marek.vasut@mailbox.org>
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20250304200712.92514-1-paul.barker.ct@bp.renesas.com>
 <20250304200712.92514-4-paul.barker.ct@bp.renesas.com>
 <6e0ede59-6923-463e-bfbc-23cba4c73ced@mailbox.org>
 <08f9ee8d-53e5-4d79-98d0-2afe53c01612@bp.renesas.com>
 <7f02496d-e2e4-4629-a32a-5059d07c94a9@mailbox.org>
Content-Language: en-US
In-Reply-To: <7f02496d-e2e4-4629-a32a-5059d07c94a9@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3c5aaoehq995an59zd8f34i1o7o51tg8
X-MBO-RS-ID: d0f5b20d4b5601038d9
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

On 3/19/25 3:34 AM, Marek Vasut wrote:
> On 3/5/25 9:39 PM, Paul Barker wrote:
>> Hi Marek,
> 
> Hi,
> 
>> On 05/03/2025 19:55, Marek Vasut wrote:
>>> On 3/4/25 9:07 PM, Paul Barker wrote:
>>>> In ravb_probe(), we were missing a couple of things in the error
>>>> handling path:
>>>>
>>>>     * We must unregister the MDIO bus before freeing the corresponding
>>>>       struct mii_dev instance to avoid the potential for use-after-free
>>>>       bugs.
>>>>
>>>>     * We must free the resources acquired by clk_get_bulk() even if the
>>>>       clocks have not yet been enabled.
>>>>
>>>> Fixes: 8ae51b6f324e ("net: ravb: Add Renesas Ethernet RAVB driver")
>>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>>> ---
>>>>    drivers/net/ravb.c | 14 ++++++++------
>>>>    1 file changed, 8 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
>>>> index 6bd94cf6bb1b..83cf6e0d19f4 100644
>>>> --- a/drivers/net/ravb.c
>>>> +++ b/drivers/net/ravb.c
>>>> @@ -591,7 +591,7 @@ static int ravb_probe(struct udevice *dev)
>>>>        ret = clk_get_bulk(dev, &eth->clks);
>>>>        if (ret < 0)
>>>> -        goto err_mdio_alloc;
>>>> +        goto err_clk_get;
>>>>        mdiodev = mdio_alloc();
>>>>        if (!mdiodev) {
>>>> @@ -613,23 +613,25 @@ static int ravb_probe(struct udevice *dev)
>>>>        /* Bring up PHY */
>>>>        ret = clk_enable_bulk(&eth->clks);
>>>>        if (ret)
>>>> -        goto err_mdio_register;
>>>> +        goto err_clk_enable;
>>>>        ret = ravb_reset(dev);
>>>>        if (ret)
>>>> -        goto err_mdio_reset;
>>>> +        goto err_clk_enable;
>>>
>>> Shouldn't this also assure clk_disable_bulk() is called ?
>>
>> Looking at include/clk.h, the comment for clk_release_bulk() says:
>>
>>      For each clock contained in the clock bulk struct, this function 
>> will check
>>      if clock has been previously requested and then will disable and 
>> free it.
>>
>> So we shouldn't need to separately call clk_disable_bulk().
> Understood. Thank you for checking.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
