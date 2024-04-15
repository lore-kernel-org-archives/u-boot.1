Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EB1C00A94
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 14:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1373A8814A;
	Mon, 15 Apr 2024 16:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="xiWcSbiF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EA278814A; Mon, 15 Apr 2024 16:17:54 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8E64881E7
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 16:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=123a=LV=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1713190659;
 bh=18IDLS29RwL7eM3M8KnAJGWqKqfWcmuZS4u5LHb5k14=;
 b=xiWcSbiFcIcOXrD1FJKaIvK8wQvoyRuBub+pJB1/kGolAFzc7oMHYIZYLohW9maSnQPKSCn0C
 hBuNby2YB5LzUL8rZDq490LOhpspE484f5OepSU9YgtWuP+zBskfNwlYt8gwuxSUNL+bzN8W0rx
 8B7BE/oET4o7ndHCeTgVoObtuww6cVtFbn7FG84xnni8XL6JA8jhmj2nusrqFYMxP2wnUK47vl9
 xIGkRyr1gR8MSrcZzD7ECfyK/CQZka1MTq5txlsygs6lADfSzGoW89u7NrRSA6weeIdURn3vRJQ
 vwAHoOd2Nnk8dYFnZPmuKFu+W2qsp3ZbVPpeX6kHxwLg==
Message-ID: <c1eb154e-3f18-420c-b4bf-2e5b85ac9f91@kwiboo.se>
Date: Mon, 15 Apr 2024 16:17:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/23] rockchip: rk3588-toybrick: Add missing Kconfig
 options
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elon Zhang <zhangzj@rock-chips.com>,
 Weizhao Ouyang <weizhao.ouyang@arm.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-16-jonas@kwiboo.se>
 <ab33123f-05a5-4edd-b720-a5b8792d5443@theobroma-systems.com>
 <6a057b12fe264f752f641f3eccd7ff23@manjaro.org>
 <cda686e0-a5e7-4e42-b696-d66563eb8866@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <cda686e0-a5e7-4e42-b696-d66563eb8866@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661d370391f33105f12c284e
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

Hi Quentin and Dragan,

On 2024-04-15 11:10, Quentin Schulz wrote:
> Hi Dragan,
> 
> On 4/15/24 11:04, Dragan Simic wrote:
>> On 2024-04-15 10:58, Quentin Schulz wrote:
>>> On 4/13/24 20:13, Jonas Karlman wrote:
>>>> Add .dtb-file entry to Makefile and enable Kconfig options required to
>>>> configure pinctrl in SPL. Also add missing PHY_ROCKCHIP_NANENG_COMBOPHY.
>>>
>>> Separate commits please.
>>
>> Perhaps the Makefile changes from a couple of different patches
>> could be put together into another, separate patch.  Those are all
>> related changes, and it would result in one less patch in the v3
>> of this series.
>>
> 
> That would be fine with me.
> 
> But always better have too many patches than too few, it's easier to 
> later squash than separate them :)

Sure, I will split these patches into smaller single purpose patches in v3.

Regards,
Jonas

> 
> Cheers,
> Quentin

