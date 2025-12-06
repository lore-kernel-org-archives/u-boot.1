Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DB4D3B7D1
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 12:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA289835C6;
	Sat,  6 Dec 2025 13:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="bBmGK7wL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D26283642; Sat,  6 Dec 2025 13:27:45 +0100 (CET)
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B00A18334F
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 13:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc
 :To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=c0mDUDyqbRg1QQilBPn+GVlhRe2r+6fxybDrN4c4j5E=; b=bBmGK7wL6gbwHbGqqo/Z+eLopU
 eDphs8KIWGJkimlKw2LNMLND0T+aSAhp/GIH/UxA66P7Fhj7gmsDQL84R+kSimB+gkyw+yc2PYATm
 RRbcIbtpp70AtF7oa3GeCbKLm3i7iRQYFwpgqHXLrdBeXiV0kGNpOldJlYZF0okAa9WCipar+fjau
 /azDjMMRu//37YTwcC2w/RNOD7BqgG2o8PMmFBMfe+Dw1Hscu5I0NDwUFCvIXgvWSuC0X9meFMeio
 KpiBB3u4ftxdh5qsDZjwIj8RbTHmzdtt9aAVvECPlLAFNoAlKm3z5vFsMEnlhm/a+LIdKTBbziLeI
 IPJNSw7A==;
Received: from 86-58-106-10.dynamic.telemach.net ([86.58.106.10]:45482
 helo=[192.168.0.129])
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98.2) (envelope-from <primoz.fiser@norik.com>)
 id 1vRrO6-00000004rtH-28n8; Sat, 06 Dec 2025 13:27:41 +0100
Message-ID: <da69ba4a-b23b-4a64-85b2-afeed14ce38b@norik.com>
Date: Sat, 6 Dec 2025 13:27:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Primoz Fiser <primoz.fiser@norik.com>
Subject: Re: [Upstream] [PATCH v2 2/3] board: phytec: phycore-imx93: Set
 boot_targets dynamically
To: Wadim Egorov <w.egorov@phytec.de>, Mathieu Othacehe
 <m.othacehe@gmail.com>, Christoph Stoidner <c.stoidner@phytec.de>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>,
 Benjamin Hahn <B.Hahn@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20251205111044.3195322-1-primoz.fiser@norik.com>
 <20251205111044.3195322-2-primoz.fiser@norik.com>
 <26dfb03f-ce98-447e-a931-ba9a34b2f8be@phytec.de>
Content-Language: en-US
In-Reply-To: <26dfb03f-ce98-447e-a931-ba9a34b2f8be@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Hi Wadim,

On 5. 12. 25 16:40, Wadim Egorov wrote:
> 
> 
> On 12/5/25 1:10 PM, Primoz Fiser wrote:
>> Set boot_targets environment variable dynamically, so that when booting
>> from SD-card, boot binaries are also preferably fetched from the SD-card
>> by default. If the user decides to set their own boot_targets, we should
>> not overwrite them.
>>
>> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
>> ---
>> Changes in v2:
>> - no changes
>> Link to v1: https://lore.kernel.org/all/20251204080744.3868067-2- 
>> primoz.fiser@norik.com/
>>
>>   board/phytec/phycore_imx93/phycore-imx93.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/board/phytec/phycore_imx93/phycore-imx93.c b/board/ 
>> phytec/phycore_imx93/phycore-imx93.c
>> index c6a4e923b074..cfc6d91f20f2 100644
>> --- a/board/phytec/phycore_imx93/phycore-imx93.c
>> +++ b/board/phytec/phycore_imx93/phycore-imx93.c
>> @@ -38,6 +38,8 @@ int board_late_init(void)
>>       switch (get_boot_device()) {
>>       case SD2_BOOT:
>>           env_set_ulong("mmcdev", 1);
>> +        if (!env_get("boot_targets"))
>> +            env_set("boot_targets", "mmc1 mmc0 ethernet");
> 
> I guess you don't define boot_targets in your env so you don't need to 
> check for default env here?

This check ensures that if the user manually defines boot_targets in the
environment, we don’t overwrite it, as described in the commit message.

So the intent is to only set boot_targets when it is not already present
in the env. This mirrors the behavior Benjamin implemented on the PHYTEC 
  i.MX8M boards.

BR,
Primoz

> 
> If so,
> 
> Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
> 
>>           break;
>>       case MMC1_BOOT:
>>           env_set_ulong("mmcdev", 0);
> 

