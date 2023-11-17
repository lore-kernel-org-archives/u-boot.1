Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67286C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 23:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD09B874E4;
	Sat, 18 Nov 2023 00:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="HUPh09rR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D75687507; Sat, 18 Nov 2023 00:30:29 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8DEB874BA
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 00:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9f74=G7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1700263819;
 bh=VzI/dyw1Dwc3kSlA8vZosVclxW9TfK+J8cP7yHRliOw=;
 b=HUPh09rRRIrZ/y6j2zuC98ivPJIz+cK0bLZCWEmzVFihnWd7F61cgnXhUnIF/oQJSCHu6urjt
 WqmVpq6KXp7WTu34y4nE8jq8qwb9jpAbhLNv46Y3UdCNwPZlWeDC6WIHVqv/9NBmcQXsWYuxkB7
 MWhMySJ2dFOWbHBBCk1ZjDYKxf04hPSHGDn+AI1VvP2AHBO8S4ytaYI8FiHCSHPziPaQFFut0DB
 W6FjHtiUcDaFWovDW8qwKRW2TIA1qCLQNf4vhQSdLylcYnVvqcKN71nDc4bhatmASie1cjUsVJd
 NdVaQym3jDnic0vOgZw49HJABF3rhKMBLLXPoJ2g+MoA==
Message-ID: <242c3d30-81ab-4132-b002-045df675ed2a@kwiboo.se>
Date: Sat, 18 Nov 2023 00:30:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3-generic: Use combined glue and ctrl node for
 RK3588
Content-Language: en-US
To: Marek Vasut <marex@denx.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20231112152527.1306793-1-jonas@kwiboo.se>
 <141ed34c-93e7-4ded-8697-3fa5501d4ee7@denx.de>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <141ed34c-93e7-4ded-8697-3fa5501d4ee7@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6557f78b9b02fe711135f19a
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

Hi Marek,

On 2023-11-13 04:11, Marek Vasut wrote:
> On 11/12/23 16:25, Jonas Karlman wrote:
>> Like Rockchip RK3328 and RK3568, the RK3588 also have a single node to
>> represent the glue and ctrl for USB 3.0.
>>
>> Use rk_ops as driver data to select correct ctrl node for RK3588 DWC3.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> 
> Reviewed-by: Marek Vasut <marex@denx.de>
> 
> Do you still want this in 2024.01 ? The MW closed just a few days ago, 
> but this seems OKish to put in still .

It should not matter if this goes to master or next. Next linux DT sync
when this may be needed will probably not be until around v6.8-rc1.

Regards,
Jonas
