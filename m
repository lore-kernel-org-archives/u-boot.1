Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A33EC282EC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 02:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F188193A;
	Wed, 19 Mar 2025 03:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="x+Z8OzQ+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mUShdq33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 122D881B52; Wed, 19 Mar 2025 03:35:35 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1860C8197F
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 03:35:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZHXr45ySxz9sxL;
 Wed, 19 Mar 2025 03:35:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742351732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFQVdA88+QqRQEKFdmKHQ+2y09VuC3Zkn92DJ77XswM=;
 b=x+Z8OzQ+GT54KXHGKnXWM1pp9B+lbBNSd1HpU0osaYMvWyI+5au0XaoiMZGXnX4TzQbkeO
 OsYgyYZngx10rQrMkT01cQYHAbuf63PJoW1imEXJxgZklcRP30KWGS+DnCKz6gAzySFdT7
 oDY5fiml6AA1ZhubT770NgFKa1HgLbL1UMylbWwzBnn7Pnz6X3xxHwAl8yhr1gs5hng8SO
 ejZnV2HuM/R8PwoBD0KsQ41U+1zOqcR0YHFbC2yyPAuUyxVQ0+XQnq5Ikto4wA7dCgJVPN
 daIHD/PKgGtEAZ1RWIr++qzVxFNlLFEYzAV0M7gpOnFnmWeKu0OMlbFvm/CYZg==
Message-ID: <7f02496d-e2e4-4629-a32a-5059d07c94a9@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742351730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFQVdA88+QqRQEKFdmKHQ+2y09VuC3Zkn92DJ77XswM=;
 b=mUShdq33Iep4Hg3ZnqbfI0vklThG7q6rQNiCtRJycGveiKXwy7zNR3JAhYXYzuztwRfhHI
 rQgcevep5DmmV68ZBDiGQ2+OIq+bXFbM64LdThDJ/OR/1IgnKdGxTHat61X7zXCs6hPMuI
 Yr9J8tapPOlaYZDq2sFxz6xsFwjTuRltYcxGIr56Xx5DN2CWpl+m0K3WFlAkfF2nxGC2I8
 zUwBpcmCpexhQ4bsVHzpI2kRPQzeWlmETjWhUrFeHlqdmRqrsZlZvWRtDJqt6mofW3ehBs
 CQFOzsJI6XEC5EIgwjoxRmOklkP2PIj3ZgfL+QIfW0AnSlZKFHdsJcPZ+m619g==
Date: Wed, 19 Mar 2025 03:34:54 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] net: ravb: Fix error handling in ravb_probe
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <08f9ee8d-53e5-4d79-98d0-2afe53c01612@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2aaef06b5c1ca56536c
X-MBO-RS-META: usmqwomi34esdae61w8p7sqzsmqsxq8m
X-Rspamd-Queue-Id: 4ZHXr45ySxz9sxL
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

On 3/5/25 9:39 PM, Paul Barker wrote:
> Hi Marek,

Hi,

> On 05/03/2025 19:55, Marek Vasut wrote:
>> On 3/4/25 9:07 PM, Paul Barker wrote:
>>> In ravb_probe(), we were missing a couple of things in the error
>>> handling path:
>>>
>>>     * We must unregister the MDIO bus before freeing the corresponding
>>>       struct mii_dev instance to avoid the potential for use-after-free
>>>       bugs.
>>>
>>>     * We must free the resources acquired by clk_get_bulk() even if the
>>>       clocks have not yet been enabled.
>>>
>>> Fixes: 8ae51b6f324e ("net: ravb: Add Renesas Ethernet RAVB driver")
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> ---
>>>    drivers/net/ravb.c | 14 ++++++++------
>>>    1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
>>> index 6bd94cf6bb1b..83cf6e0d19f4 100644
>>> --- a/drivers/net/ravb.c
>>> +++ b/drivers/net/ravb.c
>>> @@ -591,7 +591,7 @@ static int ravb_probe(struct udevice *dev)
>>>    
>>>    	ret = clk_get_bulk(dev, &eth->clks);
>>>    	if (ret < 0)
>>> -		goto err_mdio_alloc;
>>> +		goto err_clk_get;
>>>    
>>>    	mdiodev = mdio_alloc();
>>>    	if (!mdiodev) {
>>> @@ -613,23 +613,25 @@ static int ravb_probe(struct udevice *dev)
>>>    	/* Bring up PHY */
>>>    	ret = clk_enable_bulk(&eth->clks);
>>>    	if (ret)
>>> -		goto err_mdio_register;
>>> +		goto err_clk_enable;
>>>    
>>>    	ret = ravb_reset(dev);
>>>    	if (ret)
>>> -		goto err_mdio_reset;
>>> +		goto err_clk_enable;
>>
>> Shouldn't this also assure clk_disable_bulk() is called ?
> 
> Looking at include/clk.h, the comment for clk_release_bulk() says:
> 
>      For each clock contained in the clock bulk struct, this function will check
>      if clock has been previously requested and then will disable and free it.
> 
> So we shouldn't need to separately call clk_disable_bulk().
Understood. Thank you for checking.
