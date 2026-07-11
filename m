Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4167EC43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 02:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12D2C84A0B;
	Sun, 12 Jul 2026 04:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yf6DX2g/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6CBC84A4B; Sun, 12 Jul 2026 04:15:19 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF6F848A1
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 04:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gyTg85HVhzKn78;
 Sun, 12 Jul 2026 04:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783822516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CUNg3QAkq+YYZSylZLGbv1QtjHY9goBOaR1yJ+FnlPY=;
 b=yf6DX2g/QCg108tgnby5D5JiwI4/dEKGSvXDNCUf1XtxO2oPKSRj2S7upOVEdI+882uTQ+
 ax4e4WCw1m+cEUWRrXQJQe2eoa2LzJAoDHgOXSIbWlBezppPV9sRX/wAJTA7MQw3cxBSut
 tbxduD5N4aSOa89eI92aJWDU7Hv2wqVIhyTQzW80q70OPoUAHBDhOUxU5vUUQTTWvoUQ2H
 sg8KcfpeCwMXkyvr5IpBee0lxbVJz1hUKaqYpW7rTWIUxw/e0EBZaHjX2uoTczdjszTbh9
 ZsxKOKRXn0RabgTU8GxxxpTAIOz8Q6oL6LnnDE1Jnlvtx5rlmlRhw7ynIQVlbw==
Message-ID: <a6a9f87a-5009-4307-a761-352be017e930@mailbox.org>
Date: Sat, 11 Jul 2026 22:44:23 +0200
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH v2 00/10] usb: Add TCPCI driver and DWC3 OTG dual-role
 support
To: Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Fabio Estevam <festevam@gmail.com>, Wang Jie <dave.wang@rock-chips.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Alice Guo <alice.guo@nxp.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
 <akMgh8AbN6BX9UlS@shlinux89>
 <a6dec76b-ed70-49a0-b7bf-affe1aa2f6e7@nabladev.com>
 <MRWPR04MB123305BC4FB40B7B6D083AED788F72@MRWPR04MB12330.eurprd04.prod.outlook.com>
 <alJXAqtEOFb9ia3m@nxa18884-linux-1.ap.freescale.net>
Content-Language: en-US
In-Reply-To: <alJXAqtEOFb9ia3m@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 87a0a940b857257fe8f
X-MBO-RS-META: jbo34opi6hexnznjbb9bo7g4sgfqfby3
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

On 7/11/26 4:45 PM, Peng Fan wrote:

Hello Peng,

>>>> Do you have time to give a look at this series?
>>>
>>> No, sorry, I am recently entirely overwhelmed by emails and my
>>> backlog only grows. Did Sebastian/Jonas provide any feedback on the
>>> TCPM part?
>>
>> Not yet. I have other parts depending on this patch set, so hope there
>> are any feedbacks and we could move forward.
> 
> Since merge window is open, and there haven't been any review comments
> for some time, would it be possible to merge this series? If any issues
> are found later, I will address them promptly through follow-up fixes.
> 
> Do you have any concerns with merging this series?

I am hoping to get review on the TypeC parts from Sebastian (I also CCed 
their other email address). I at least commented on the DWC3 parts.

Sorry for the slow response, I am buried in emails.
