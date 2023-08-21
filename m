Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B1DEE49A6
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 12:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA976869CB;
	Mon, 21 Aug 2023 14:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UsnBptFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AB6D8691A; Mon, 21 Aug 2023 14:16:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C6ED86F0A
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 14:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8C1E663375;
 Mon, 21 Aug 2023 12:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C89C433C7;
 Mon, 21 Aug 2023 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692620176;
 bh=bXB1b2Ig+1fM0gAwXbNRhMrUQKcLPVVx2+2syDo9J+M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UsnBptFhInlpY6k6zHYu1MImu7qw8GrhbQunAEtuNILYJNWApjGkdbwChNcEneAzV
 /3rbS5poqVnitUa+/gxb6iTp4PanIFZeJkM1MVpWNpunhhfqQ7yej/P4S2lyfSDIZu
 9jR10IeRB4tQfAJXwHsYJm7YVYuBFeu56Nbo5nXwfsoQcEEJ3CVFmpVaX7XG+Z+U/P
 lEuItEA8DTrUCJxY2ktLhASGEUAjtg/DL1r6/3Dm8v9Yw7tdV+gVmi6QhUfMZxGoyL
 OoDkcFwwjrPZMpscEG3dH2TZ57iSL+RLtzmvzMKoSZSGc9ZYBUyQPvNj2phvbvrXL9
 mJLEemXv3z4YA==
Message-ID: <927fff06-3474-080a-5d9e-3624e6f39d43@kernel.org>
Date: Mon, 21 Aug 2023 15:16:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 1/2] musb-new: ti-musb: Handle usb dual-role feature as
 peripheral
Content-Language: en-US
To: Julien Panis <jpanis@baylibre.com>, Tom Rini <trini@konsulko.com>,
 "Bin Liu [EP]" <b-liu@ti.com>, stephan@gerhold.net
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, tony@atomide.com,
 vigneshr@ti.com, nm@ti.com
References: <20230621-fix_usb_ether_init-v4-0-5f4977bb7678@baylibre.com>
 <20230621-fix_usb_ether_init-v4-1-5f4977bb7678@baylibre.com>
 <20230814171801.GC3630934@bill-the-cat>
 <500449e0-0d65-44b4-aa0b-3596292f79e3@baylibre.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <500449e0-0d65-44b4-aa0b-3596292f79e3@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Julien,

On 21/08/2023 11:28, Julien Panis wrote:
> On 8/14/23 19:18, Tom Rini wrote:
>> On Thu, Jul 06, 2023 at 12:40:22PM +0200, Julien Panis wrote:
>>
>>> This prevents from getting some 'No USB device found' error,
>>> in usb_ether_init() function for instance.
>>>
>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>>> Reviewed-by: Tony Lindgren <tony@atomide.com>
>>> Reviewed-by: Nishanth Menon <nm@ti.com>
>>> ---
>>>   drivers/usb/musb-new/ti-musb.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
>>> index 3be3f93dd85d..44697dc31387 100644
>>> --- a/drivers/usb/musb-new/ti-musb.c
>>> +++ b/drivers/usb/musb-new/ti-musb.c
>>> @@ -302,6 +302,7 @@ static int ti_musb_wrapper_bind(struct udevice *parent)
>>>           dr_mode = usb_get_dr_mode(node);
>>>           switch (dr_mode) {
>>>           case USB_DR_MODE_PERIPHERAL:
>>> +        case USB_DR_MODE_OTG:
>>>               /* Bind MUSB device */
>>>               ret = device_bind_driver_to_node(parent,
>>>                                "ti-musb-peripheral",
>> Julien, why don't we support OTG mode here instead?
>>
> 
> Roger, can this be achieved with this controller ?

The Controller supports OTG mode but I'm not sure of the u-boot driver.

Bin / Stephan might know.

-- 
cheers,
-roger
