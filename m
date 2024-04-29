Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DEBC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 20:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF7C888966;
	Mon, 29 Apr 2024 22:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714423868;
	bh=SaVlu8godQlM3fkXL7wBxkWqc9kts9IFPrnFEoBBQTA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zHyhj/KTWLlKYdpKYf90udHzbtKsYORP59IrELLeNz0rmlOWgKVqTDCX9Hd5i+NRy
	 dl1qggmJi3ZDGS3wIJLiG95Eo9y1o0+TqfFzojUKZtvK9h1JrNjbZBzZI1gOaChfm3
	 nL0BvUyyeDhqQSieK2cIzlt6XceCKlsJMRJisGZXV2XVCTOXhtOeiT0EaW/vjigmBp
	 8q0wS26kE+z8yW++W/OYNz2Ms60dY5gqPO9Vpdv/frwhjGS5lN57jbeni2E/AJ3Fj5
	 p6imreHJ7CzLSWs+zl1OcazRuqTHi5s9CE1hEY/1bDC+JmPt/KwN818fM9VNAtt2dG
	 cjVPqsxJnFTjg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3282C88928;
 Mon, 29 Apr 2024 22:51:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714423865;
 bh=SaVlu8godQlM3fkXL7wBxkWqc9kts9IFPrnFEoBBQTA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=atHxbrzWp7rKqKYnqHJb8X7PLx86QY4QrHyIrjlQeW5+aGnPY9t3u2iEqaC/3xfRz
 BYUKQOGQwOM2YGRDa90t3KN7iNqnrdbtVbuV5gv3eCnE9d1FacJMCnMCIdyzMnDfF0
 n8zcZewwC3F6EqD4u39/22jTz8ERwNvODgcxT0eQEe4xE+LhEsgq2bcGmgxXB53UfF
 0CnMhQwQeda+5ABLPOsNbg8ysk+DXIIiuzBUQ6IdrWlVFysaqz/s0VUk8VuvMlWNSH
 SStPbzozo27u4ToHFUT+HhdINEWIvmpgQxPmzwb65FUqDweLaEfqslBIA3n0l0CL9G
 +6ZSTjFIcvDZw==
Message-ID: <ef623aca-ead7-42dc-bacf-6cb51bdfba41@denx.de>
Date: Mon, 29 Apr 2024 22:15:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: allow use of hardware partition names for mmc
 partconf
To: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>
References: <20240427001157.1460302-1-tharvey@gateworks.com>
 <495f60d6-6ff2-4c53-8b2c-867b5ca05993@denx.de>
 <CAJ+vNU0R5iTgS2_C_OV2VYh5fQnyPV-Lw003CTJAkp1Q6Qdedg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU0R5iTgS2_C_OV2VYh5fQnyPV-Lw003CTJAkp1Q6Qdedg@mail.gmail.com>
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

On 4/29/24 6:48 PM, Tim Harvey wrote:
> On Sat, Apr 27, 2024 at 4:20 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 4/27/24 2:11 AM, Tim Harvey wrote:
>>
>> [...]
>>
>>> diff --git a/include/mmc.h b/include/mmc.h
>>> index 4b8327f1f93b..7243bd761202 100644
>>> --- a/include/mmc.h
>>> +++ b/include/mmc.h
>>> @@ -381,6 +381,21 @@ enum mmc_voltage {
>>>    #define MMC_TIMING_MMC_HS200        9
>>>    #define MMC_TIMING_MMC_HS400        10
>>>
>>> +/* emmc hardware partition values */
>>> +enum emmc_hwpart {
>>> +     EMMC_HWPART_DEFAULT = 0,
>>
>> One more thing ... eMMC hardware partition 0 and 7 are both referring to
>> USER HW partition. Have a look at the git log, there have been patches
>> which handled this case in the MMC subsystem from about a year ago.
> 
> Hi Marek,
> 
> I can't find what you are referring to. I assume you are talking about
> calling the first name something other than 'user' as technically it's
> not (but it gets treated as user).
> 
> Can you find the commit or discussion you are thinking about?

It seems this whole thing is much older:

7dbe63bc950b ("SPL: Add CONFIG_SUPPORT_EMMC_BOOT support to 
CONFIG_SPL_FRAMEWORK")

+                * We need to check what the partition is configured to.
+                * 1 and 2 match up to boot0 / boot1 and 7 is user data
+                * which is the first physical partition (0).
+                */
+               int part = (mmc->part_config >> 3) & PART_ACCESS_MASK;
+
+               if (part == 7)
+                       part = 0;
