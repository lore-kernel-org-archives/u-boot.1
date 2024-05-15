Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F134EC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 19:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24272882DF;
	Wed, 15 May 2024 21:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715802743;
	bh=UOSet8MyKY5OOkN5Eu76NlNd4nhgHCtsVXS2BTC0xEA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jHqI+nSsJVhqBJNPmWa5fSXk3ZTA9sHzvfoER1sJCy3Yq0JJMbqZPUA9t+SAEr6kh
	 aXZwIYewTjOSkF18YCTNIRcneN5MaeNfuJO44NMsamB66Fxdxm6Tz8+NUYuKaEwefY
	 WZsIRjqBiVxl67SyubnN0t5N1/0kl8ltrG56t7eEv+bty7gI4cicrDPac8tlQjOEEN
	 1+MzgtWy6pLUsqAOGlf7YI7EtPFz5F+WrUZ9/T5aXDFAw0N0OShWqGb4MQvMCaUfKg
	 r/kSmYubJBpsqRmFVq78Bc+iDo1EY/XUNr6DRXJ7CUdllCFbU/lthCYw0mY8/PzOc3
	 Jr7om2BgoIkxg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E7FFB880F1;
 Wed, 15 May 2024 21:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715802742;
 bh=UOSet8MyKY5OOkN5Eu76NlNd4nhgHCtsVXS2BTC0xEA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GCEl7GJD+uXRmWVhLplplx3/4xj9ow61/g+cjjfD5Yh+bLql/+4zBv7h1JL9k9lnO
 u0LwHLBO10HHcjTRxkaUroXO7vgpeW7WmmLp9RvbTCn46suvngv8+MDYqYNiEMVv3H
 yhJzArBqBDYFx+xazNP+CnD87hPwMHp+uTTe2XNxXpk+v/JnYnvsgPyrGl0L0rPzed
 Z2piZEVvyy2EaoAhMktccq4axO3UZ6oLUstnUbfGyKz0wCmAhg3znO0d/Y0r6dPsmY
 /+aipJXdN2lcOipzQ+5hsDDrIy9Zn9sqK7faw3sacLavJ5Fj4SHM3btIAjeZ5Nb4pQ
 SWUWPvnSVtqag==
Message-ID: <91a62c19-d565-4cd8-a20d-75d682acf95f@denx.de>
Date: Wed, 15 May 2024 20:35:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fdt: add kaslr-seed if DM_RNG is enabled
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20240515002248.2920155-1-tharvey@gateworks.com>
 <039c0adc-3014-4ae7-99b3-0df9e5366b79@denx.de>
 <CAJ+vNU0nSV-xKkrrXtod9zYfsSe2vUQsCVEgq9PntTxCnqV0dA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU0nSV-xKkrrXtod9zYfsSe2vUQsCVEgq9PntTxCnqV0dA@mail.gmail.com>
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

On 5/15/24 6:29 PM, Tim Harvey wrote:
> On Tue, May 14, 2024 at 5:50 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 5/15/24 2:22 AM, Tim Harvey wrote:
>>> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
>>> randomize the virtual address at which the kernel image is loaded, it
>>> expects entropy to be provided by the bootloader by populating
>>> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
>>
>> Thanks for working on this one, this is really nice.
>>
>>> If we have DM_RNG enabled poulate this value automatically when
>>> fdt_chosen is called.
> 
> Hi Marek,
> 
> Just noticed a typo in the commit log - I'll s/poulate/populate/ in v2
> 
>>>
>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>> ---
>>>    boot/fdt_support.c | 23 +++++++++++++++++++++++
>>>    1 file changed, 23 insertions(+)
>>>
>>> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
>>> index 874ca4d6f5af..cd3069baf450 100644
>>> --- a/boot/fdt_support.c
>>> +++ b/boot/fdt_support.c
>>> @@ -7,10 +7,12 @@
>>>     */
>>>
>>>    #include <abuf.h>
>>> +#include <dm.h>
>>>    #include <env.h>
>>>    #include <log.h>
>>>    #include <mapmem.h>
>>>    #include <net.h>
>>> +#include <rng.h>
>>>    #include <stdio_dev.h>
>>>    #include <dm/ofnode.h>
>>>    #include <linux/ctype.h>
>>> @@ -300,6 +302,27 @@ int fdt_chosen(void *fdt)
>>>        if (nodeoffset < 0)
>>>                return nodeoffset;
>>>
>>> +     if (IS_ENABLED(CONFIG_DM_RNG)) {
>>> +             struct udevice *dev;
>>> +             size_t len = 0x8;
>>> +             u64 *data;
>>> +
>>> +             data = malloc(len);
>>
>> Can you allocate this 8 byte array on stack , i.e. u64 data[2]; ?
>>
> 
> Sure... that makes sense - u64 data (just 1 64bit value)

Oh, right. Thanks for fixing it all up and keeping an eye on all the bugs !
