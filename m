Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF084C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56AE68887B;
	Wed, 22 May 2024 16:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="jCbAkM1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F270488047; Wed, 22 May 2024 10:46:33 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 214E1880CC
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 10:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716367591; x=1718959591;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dlxgOYQ6/DQ+44j0fQXD/okPFxMn/DcrgoCZxQ+yxkI=;
 b=jCbAkM1D1IRqWs6rDcLNy+ARGRUYXubLWN23ioa5LKMn1+FO5CfH669UZ7E+qD9Y
 G4wgljdqRkOujTqaBtm3bxNqVOkLvihPFhGmMnJopMbl2efiuUNVLJRMqUY4w21k
 3MpwbnC/dQysaDZBPGETi52V5+e6Ac0gmOllQ/NnleQ=;
X-AuditID: ac14000a-03e52700000021bc-13-664db0e7eb05
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 4C.61.08636.7E0BD466;
 Wed, 22 May 2024 10:46:31 +0200 (CEST)
Received: from [10.0.0.19] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 10:46:29 +0200
Message-ID: <f7ff1fdc-17cf-4129-bc08-7af909150622@phytec.de>
Date: Wed, 22 May 2024 10:46:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 6/6] configs: phycore_am62x_a53_defconfig:
 Enable CONFIG_ENV_OVERWRITE
To: Wadim Egorov <w.egorov@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
References: <20240522061827.601699-1-d.schultz@phytec.de>
 <20240522061827.601699-7-d.schultz@phytec.de>
 <dee06e33-5d87-491b-8570-f3bfeca81c01@phytec.de>
Content-Language: de-DE, en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <dee06e33-5d87-491b-8570-f3bfeca81c01@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWyRpKBR/f5Bt80g9XzLS3e7u1kt+h+p+7A
 5HH2zg5Gj/7uFtYApigum5TUnMyy1CJ9uwSujEenm9gKLnNUXJ5S0sC4lL2LkZNDQsBEomXW
 ZaYuRi4OIYElTBJ7P75nh3BuMUqcO/SZCaSKV8BG4v2qGWA2i4CqxMy1z6HighInZz5hAbFF
 BeQl7t+aATZVWCBdYsW32cwgtohAtMTd931QG+YwSiy/cJQNJMEsICfx500TWBGbgJbEnS1z
 wWxOAVuJw/cvMELUWEgsfnOQHcKWl2jeCjFUSEBBYva2yYwQL8hLTDv3mhnCDpU4smk10wRG
 oVlI7puFZN0sJGNnIRm7gJFlFaNQbmZydmpRZrZeQUZlSWqyXkrqJkZQYIswcO1g7JvjcYiR
 iYPxEKMEB7OSCG/0St80Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryrO4JThQTSE0tSs1NTC1KL
 YLJMHJxSDYyiL7w1Bf2MPCaYyQberfgfO09NXOPV2hq54ztMirojv0/jMjx0syy0v4VNdr7u
 NGmbM/EMvw7O+Huk9aT/dbFlSy+Lz9p9qmHa+z7eB0EHq5euuaD+6mFLrWtLseuH2k+32Hsm
 Cz10redkslsjv8TzI7/f+89TZX87tjVNqmvlzzSODph/wFCJpTgj0VCLuag4EQB+EOlUWgIA
 AA==
X-Mailman-Approved-At: Wed, 22 May 2024 16:50:43 +0200
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

Hi,

On 22.05.24 10:30, Wadim Egorov wrote:
> Hi Daniel,
>
> Am 22.05.24 um 08:18 schrieb Daniel Schultz:
>> Enable CONFIG_ENV_OVERWRITE to overwrite ethaddr in the environment.
>> This is required because our environment is not located in the
>> boot partition.
>>
>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>> ---
>>   configs/phycore_am62x_a53_defconfig | 1 +
> What about the change for the phycore_am64x?

Will enable phyCORE-AM64x later with additional changes to enable SOM 
detection.

Regards,
Daniel

>
>
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/phycore_am62x_a53_defconfig 
>> b/configs/phycore_am62x_a53_defconfig
>> index fd36edc29dd..286cd89c5a6 100644
>> --- a/configs/phycore_am62x_a53_defconfig
>> +++ b/configs/phycore_am62x_a53_defconfig
>> @@ -59,6 +59,7 @@ CONFIG_SPL_OF_CONTROL=y
>>   CONFIG_MULTI_DTB_FIT=y
>>   CONFIG_SPL_MULTI_DTB_FIT=y
>>   CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
>> +CONFIG_ENV_OVERWRITE=y
>>   CONFIG_ENV_IS_IN_MMC=y
>>   CONFIG_SYS_MMC_ENV_DEV=1
>>   CONFIG_NET_RANDOM_ETHADDR=y
