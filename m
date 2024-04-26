Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D6FC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 17:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 834CA8858D;
	Fri, 26 Apr 2024 19:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714153323;
	bh=6gICVIjfTFYhNSwIegT0vE8G3BPWNZ/LaRM8MgD4xTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KyYYfhBDyrkqHdxmogzYNi5IOuj4Sum/s+0rLSMo7WufiAK3ZmymL+KafdKM5m4kA
	 wS0Jt1odG+jcuRaALMu2+X2FYa4bhHSCAyfuZjtXxQIWTxqgZ2t9k1kFcRdotbdoWe
	 svzMK7857bi0wd9R0Uh0XPoyhMUSoZR6+mFqy0ybDlyLXDoRJFzKX65ngTRVPvjKIx
	 f4ZR7lHzLr/5NiNTSNIUiOmaNzp2ObJk23jIzGE5VVQr535yZwv/XpwXh6IfzUj+sc
	 V32nyih0pkVy3pGkvH7Tz4309AjNUORlztHT105r0uzmh5MjugSGrCeN8Y8X671KJN
	 T2sxRPxVYAGGA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DD5CC88354;
 Fri, 26 Apr 2024 19:42:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714153321;
 bh=6gICVIjfTFYhNSwIegT0vE8G3BPWNZ/LaRM8MgD4xTk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rZAQltHFeyaLXQtHGFV6t3PDjEgbt5y4jXE0NOoeGWAUmQusumRa6jlQ3BCavOXFD
 PAJp5XHauhpnuet/Yya97QkIp97mzqZYoL6GAUJxchVj+3JbQlQ7xCBQx0dIJmYIMo
 wH+E+2KfRjEKyoo3WT5L/Qhpw4PnuD1x4IKaKb21dLaUgzD5GgSjSwA4u3QBvKxYjf
 KUnarU+yREyWqsjiWlSzhhI7BjalVMV2fYtcMBQledAzUbhTU33PlRQnr/Ba1tKEqd
 QDCZXlLn9Wj7BR2XmhBAd482Rkn3G7tCBA2Oze+o1Rbv0tS2x5uYaGsXw6cfYQC8zw
 v2tY0h4TDx02Q==
Message-ID: <a1e9206f-0cbf-44b2-a5e7-351f77c0d2b5@denx.de>
Date: Fri, 26 Apr 2024 19:42:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cmd: mmc: allow use of hardware partition names for
 mmc partconf
To: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
References: <20240426171205.1382212-1-tharvey@gateworks.com>
 <9f5dc653-8252-4da7-81bc-a76280cf4c68@denx.de>
 <CAJ+vNU3U4P0wLcJ=_Bev++bsRF+=2inGEcs3pMuRb4f7ObSjBQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU3U4P0wLcJ=_Bev++bsRF+=2inGEcs3pMuRb4f7ObSjBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 4/26/24 7:36 PM, Tim Harvey wrote:
> On Fri, Apr 26, 2024 at 10:25 AM Marek Vasut <marex@denx.de> wrote:
>>
>> On 4/26/24 7:12 PM, Tim Harvey wrote:
>>> eMMC devices have hardware partitions such as user, boot0, and boot1.
>>> Allow these names to be displayed when reading the mmc PARTITION_CONFIG
>>> field via 'mmc partconf'. Additionally allow a name to be specified when
>>> setting the PARTITION_CONFIG.
>>>
>>> Before:
>>> u-boot=> mmc partconf 2 1 1 0 && mmc partconf 2
>>> EXT_CSD[179], PARTITION_CONFIG:
>>> BOOT_ACK: 0x1
>>> BOOT_PARTITION_ENABLE: 0x2
>>> PARTITION_ACCESS: 0x0
>>>
>>> After:
>>> u-boot=> mmc partconf 2 1 1 0 && mmc partconf 2
>>> EXT_CSD[179], PARTITION_CONFIG:
>>> BOOT_ACK: 0x1
>>> BOOT_PARTITION_ENABLE: 0x1 (boot0)
>>> PARTITION_ACCESS: 0x0
>>> u-boot=> mmc partconf 2 1 boot1 0 && mmc partconf 2
>>> EXT_CSD[179], PARTITION_CONFIG:
>>> BOOT_ACK: 0x1
>>> BOOT_PARTITION_ENABLE: 0x2 (boot1)
>>> PARTITION_ACCESS: 0x0
>>>
>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>> ---
>>> v2:
>>>    - fix typo in subject
>>>    - add names for gp1..gp4
>>> ---
>>>    cmd/mmc.c | 25 ++++++++++++++++++++++---
>>>    1 file changed, 22 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/cmd/mmc.c b/cmd/mmc.c
>>> index 2d5430a53079..af9a66cc6df4 100644
>>> --- a/cmd/mmc.c
>>> +++ b/cmd/mmc.c
>>> @@ -14,6 +14,18 @@
>>>    #include <part.h>
>>>    #include <sparse_format.h>
>>>    #include <image-sparse.h>
>>> +#include <linux/ctype.h>
>>> +
>>> +static const char *mmc_partnames[] = {
>>> +     "user",
>>> +     "boot0",
>>> +     "boot1",
>>> +     "gp1",
>>> +     "gp2",
>>> +     "gp3",
>>> +     "gp4",
>>
>> Uh, maybe gp%d are indexed from zero too ?
>>
>> (sorry for the confusion)
> 
> but 'mmc hwpartition' does not list them 0 based:
> u-boot=> mmc hwpartition
> switch to partitions #0, OK
> mmc2(part 0) is current device
> Partition configuration:
>          No enhanced user data area
>          No GP1 partition
>          No GP2 partition
>          No GP3 partition
>          No GP4 partition
> 
> I'm ok with either, I'm just not sure what is more understandable and standard.

Then 1-based counting is OK, thanks for checking !
