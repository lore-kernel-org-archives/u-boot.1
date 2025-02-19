Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A2AC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 05:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 543ED80A46;
	Wed, 19 Feb 2025 06:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PcfaUmE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 658A080C8F; Wed, 19 Feb 2025 06:03:36 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B4C809A4
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 06:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51J53UGs166529
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Feb 2025 23:03:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739941411;
 bh=Nk/xDmDdZzTwdzTJsSqDHliysIZVx6A1cGSvgedf3dg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=PcfaUmE/PZ66zAuSIbsgvt4tzD4yNsjjGN+hLw2e4eMsrTB7DA8Z4zZ7CwjsS0WUC
 N+51mIwSltl9Ld4JnI2d22xwquzqAfwWXaZn/9IVXhy+C2TMMh4T40XdHk+jHEwIfK
 XN7lMuypkzOeUIZUE8VATX+rQtfW/SFTk8F2fIec=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51J53Uvf008027
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Feb 2025 23:03:30 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Feb 2025 23:03:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Feb 2025 23:03:30 -0600
Received: from [172.24.25.83] (lt5cd2489kgj.dhcp.ti.com [172.24.25.83])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51J53RjX025257;
 Tue, 18 Feb 2025 23:03:27 -0600
Message-ID: <14701984-073f-4976-b0c2-e2c42dadadd8@ti.com>
Date: Wed, 19 Feb 2025 10:33:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Remove "saveenv" functionality from am57xx evms
To: Tom Rini <trini@konsulko.com>
CC: Anurag Dutta <a-dutta@ti.com>, <afd@ti.com>, <u-boot@lists.denx.de>,
 <a-chavda@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>
References: <20250208043938.52832-1-a-dutta@ti.com>
 <20250209172049.GP1233568@bill-the-cat>
 <79dd46c0-c084-48e4-8b7f-79892389ea6e@ti.com>
 <20250210144311.GE1233568@bill-the-cat>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250210144311.GE1233568@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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


On 2/10/2025 8:13 PM, Tom Rini wrote:
> On Mon, Feb 10, 2025 at 09:55:22AM +0530, Kumar, Udit wrote:
>> Hi Tom
>>
>> On 2/9/2025 10:50 PM, Tom Rini wrote:
>>> On Sat, Feb 08, 2025 at 10:09:36AM +0530, Anurag Dutta wrote:
>>>
>>>> Previously saved environment introduce discrepancies and may lead to
>>>> incompatibilities without default settings. This series removes the saved
>>>> environment functionality on am57xx evms so that the default configuration
>>>> is always loaded
>>>>
>>>> Test result: https://gist.github.com/anuragdutta731/b253ddb0a5538ab6588a3535d7bbecf7
>>>>
>>>> Anurag Dutta (2):
>>>>     configs: am57xx_hs: Remove saved environments
>>>>     configs: am57xx: Remove saved environments
>>>>
>>>>    configs/am57xx_evm_defconfig    | 4 +---
>>>>    configs/am57xx_hs_evm_defconfig | 4 +---
>>>>    2 files changed, 2 insertions(+), 6 deletions(-)
>>> I'm not sure what this is intended to solve. A persistent environment
>>> can be reset to the defaults with "env default -f -a" and telling users
>>> to do this when needed when upgrading is a long standing practice.
>> There are few inconsistencies in development flow with saved env.
>>
>> There we revert already for k3 platforms.  Please see
>>
>> https://github.com/u-boot/u-boot/commit/a5e8678e0a32f85ad012aea7641e9534ada5c0fe
> I did miss that one at the time, yeah. I do think this is the wrong
> direction because custom designs tend to copy the ref platform and
> making each of them pick the right long term likely to not be
> overwritten location seems like more work than reminding developers to
> run "env default -f -a" when modifying the environment, or even just
> locally switching to ENV_IS_NOWHERE. I'm not nak'ing it but I would
> encourage everyone to re-think all of the use cases here and make sure
> that yes, really, this is the best option.

Likewise, I don't have strong opinion for either.

But I am slightly inclined towards ENV_IS_NOWHERE

How i see two environments development and production.


In development environment, boot should work out of box,

There are few non u-boot developer, using u-boot in their work flows,

they should know to run "env default -f -a" command when they do u-boot 
update.

In production environment, u-boot is customized most of times, so env 
option could be enabled at part of customization

PF, I see around 48 configs are on ENV_IS_NOWHERE

Thanks


>
