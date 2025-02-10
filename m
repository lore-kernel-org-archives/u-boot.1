Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A605BC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 04:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B208080548;
	Mon, 10 Feb 2025 05:25:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fyYeeFWL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEBDE80548; Mon, 10 Feb 2025 05:25:31 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FB15803B5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 05:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51A4PQ1A4164713
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 9 Feb 2025 22:25:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739161526;
 bh=cJk3GwdkNNrO+oPd0ysHKFSkUZIf+IoNlRPXx4iRj/g=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=fyYeeFWLoaWmKduM2nCkMceKQvdwjLyuZEWNZlWSfxLwg+9LJN+i8BfQ3JhwzFxk4
 CVecCSjsXnUWWsjOjvARjI4v0360QD6OMH+wBgcgEsuTixlOVMeqsUe7c8g6jclE6f
 krhkPKywry7pk9wFhlBsS50OTjJgEBbLpNVs/XaE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51A4PQcv120806;
 Sun, 9 Feb 2025 22:25:26 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 9
 Feb 2025 22:25:25 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 9 Feb 2025 22:25:25 -0600
Received: from [172.24.20.205] (lt5cd2489kgj.dhcp.ti.com [172.24.20.205])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51A4PN5L091515;
 Sun, 9 Feb 2025 22:25:23 -0600
Message-ID: <79dd46c0-c084-48e4-8b7f-79892389ea6e@ti.com>
Date: Mon, 10 Feb 2025 09:55:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Remove "saveenv" functionality from am57xx evms
To: Tom Rini <trini@konsulko.com>, Anurag Dutta <a-dutta@ti.com>
CC: <afd@ti.com>, <u-boot@lists.denx.de>, <a-chavda@ti.com>, <nm@ti.com>,
 <u-kumar1@ti.com>
References: <20250208043938.52832-1-a-dutta@ti.com>
 <20250209172049.GP1233568@bill-the-cat>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250209172049.GP1233568@bill-the-cat>
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

Hi Tom

On 2/9/2025 10:50 PM, Tom Rini wrote:
> On Sat, Feb 08, 2025 at 10:09:36AM +0530, Anurag Dutta wrote:
>
>> Previously saved environment introduce discrepancies and may lead to
>> incompatibilities without default settings. This series removes the saved
>> environment functionality on am57xx evms so that the default configuration
>> is always loaded
>>
>> Test result: https://gist.github.com/anuragdutta731/b253ddb0a5538ab6588a3535d7bbecf7
>>
>> Anurag Dutta (2):
>>    configs: am57xx_hs: Remove saved environments
>>    configs: am57xx: Remove saved environments
>>
>>   configs/am57xx_evm_defconfig    | 4 +---
>>   configs/am57xx_hs_evm_defconfig | 4 +---
>>   2 files changed, 2 insertions(+), 6 deletions(-)
> I'm not sure what this is intended to solve. A persistent environment
> can be reset to the defaults with "env default -f -a" and telling users
> to do this when needed when upgrading is a long standing practice.

There are few inconsistencies in development flow with saved env.

There we revert already for k3 platforms.  Please see

https://github.com/u-boot/u-boot/commit/a5e8678e0a32f85ad012aea7641e9534ada5c0fe 


