Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE49EC47422
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 00:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5973877E0;
	Mon, 22 Jan 2024 01:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ogyURRqe";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PMJeEf7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9109D8783B; Mon, 22 Jan 2024 01:28:56 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D97887727
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 01:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TJB0j6tqWz9ssr;
 Mon, 22 Jan 2024 01:28:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705883334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uGIiOvUh/vBpM45zDLlGaqktNvgXAhNYjTXJHTCbXGQ=;
 b=ogyURRqeOlMSfzDamPj5fG/0TshXX6D7XtMgypw8K2JJ+rEIIdXnBMR60bD6W1pkildYqe
 UxiT96mOZZ1+nd7+IjiROXvnODjeAH0kPH16eHJNsWWSChWLipwOcaw7fYTNkA0vc45EAQ
 GwPWRTcGIUJQNebHCB1X/rwTwQ8rHeHHq3lFewM0QEIRJLvR39QCWcDrw44UNDmagrjJ1H
 FDLvQlPnlobDr3UqzjPTTTgyU7ZDUgtzL0dkuNLAWK7rrMf+EcwNWK+0vK8Wi2xSYspbt7
 OZ4hB8N+pXy0UX9hcYQjmGChvnA323hM55b8Ibu1nLl1PVb5o7hSiQehodubkA==
Message-ID: <42959462-2250-4189-a92b-07a02c140ca0@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705883332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uGIiOvUh/vBpM45zDLlGaqktNvgXAhNYjTXJHTCbXGQ=;
 b=PMJeEf7atvs52Y8QccNWzGkjomI7IsCUeTEsa/ccxlbDsfVsnQ740B6LZ7FVCyKnk22rnv
 Ry6b07v096FfSfYpfE7Y2GrTDMNgGormuDdN0k08/nYbqMREXsGB55FRd1yvZZjYn5lg97
 PibAPBdOsFzVQ+XU11JG2UAEoJisa/sdDkVPnkbq0t0GMAPLVZ2hPERlOuRp9ed3UAqc8f
 lD1izfsuInx9KxVVGN6E5QRaKj0Ul/tGysrNALsne9SvwTTiFM6uTKBJbjCfT9rey1OZN7
 4+TP6x7l4WXu9ECpLetIYbpejE+52+bJ+Pi/3UBlANw0giZaROk66X5ucRT69g==
Date: Mon, 22 Jan 2024 01:28:50 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] net: ravb: Use PHY MDIO address from DT if available
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
References: <20240121173006.273629-1-marek.vasut+renesas@mailbox.org>
 <20240121173006.273629-3-marek.vasut+renesas@mailbox.org>
 <3b289fbb-ad24-45d5-b7b9-d9af00baaf2f@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <3b289fbb-ad24-45d5-b7b9-d9af00baaf2f@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: h7tzagfq3wcurweums446uwsrh4mgffi
X-MBO-RS-ID: 0f399461bae8f12ff33
X-Rspamd-Queue-Id: 4TJB0j6tqWz9ssr
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

On 1/21/24 22:37, Paul Barker wrote:
> On 21/01/2024 17:29, Marek Vasut wrote:
>> In case the PHY is fully described in DT, use PHY MDIO address
>> from DT directly instead of always using auto-detection. This
>> also fixes the behavior of 'mdio list' in such DT setup, which
>> now prints the PHY connected to the MAC correctly.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Cc: Ramon Fried <rfried.dev@gmail.com>
>> ---
>>   drivers/net/sh_eth.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> I think the commit summaries are mixed up here - this patch says 'ravb'
> but changes 'sh_eth.c' and vice-versa with the other patch.

Sigh ... too much git commit --fixup/rebase --autosquash .

>> diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
>> index 7b1f59dc498..5e2e3054ecf 100644
>> --- a/drivers/net/sh_eth.c
>> +++ b/drivers/net/sh_eth.c
>> @@ -12,6 +12,7 @@
>>   #include <common.h>
>>   #include <cpu_func.h>
>>   #include <env.h>
>> +#include <eth_phy.h>
>>   #include <log.h>
>>   #include <malloc.h>
>>   #include <net.h>
>> @@ -597,11 +598,16 @@ static int sh_eth_phy_config(struct udevice *dev)
>>   	struct sh_ether_priv *priv = dev_get_priv(dev);
>>   	struct eth_pdata *pdata = dev_get_plat(dev);
>>   	struct sh_eth_dev *eth = &priv->shdev;
>> -	int ret = 0;
>>   	struct sh_eth_info *port_info = &eth->port_info[eth->port];
>>   	struct phy_device *phydev;
>> +	int phy_addr;
>> +	int ret = 0;
>> +
>> +	phy_addr = eth_phy_get_addr(dev);
>> +	if (phy_addr < 0)
>> +		phy_addr = -1;
>>   
>> -	phydev = phy_connect(priv->bus, -1, dev, pdata->phy_interface);
>> +	phydev = phy_connect(priv->bus, phy_addr, dev, pdata->phy_interface);
>>   	if (!phydev)
>>   		return -ENODEV;
>>   
> 
> I have a local patch to handle (phy_addr < 0) in phy_connect_phy_id()
> and lookup the address there. I think that's the better place to handle
> this as it's a universal fix for all users of CONFIG_PHY_ETHERNET_ID.
> Unfortunately I've been distracted by some higher priority work but I'm
> hoping to get back to this soon.
> 
> I can do some quick testing with that patch and send it this week if
> that's helpful.

Please do send it, yes.
