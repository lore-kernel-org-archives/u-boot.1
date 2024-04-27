Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C954CC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 10:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC822882B1;
	Sat, 27 Apr 2024 12:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714213332;
	bh=CkSc1MzmASfau50N0U5gnsonC6XrVL4Nyy3JTWHmP8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vMDHNtAZVUf5Wj3SufqmYVb9B/BUfBG1OlJ3+Iv9FBNdxWL5tu30ir01VcRukmtV8
	 OTqMVRJ/cbea++ataUhG6QYIi2GN2sBNIeawhPpjMNt6TGOJ5l1hPdEO2u4nV18Fy8
	 fOdOUyiDr3h4JsnL2jMcHJFX9UMs/bItCC3cdIl1nNmsfaRyfupO8Vy+nQwJpq32R+
	 /79NCeWdXeR+n3hc3si5IHs9iW+LBNqdSWKHJvK94V1GqhUvzJO58/vD4EnbKQ4EvJ
	 qGx5C5L/7BQTapLLEMmvMP4Tfcu5+BGJf0ViN7J0WgWpNKFCvXA/sTN6HW43VHSFma
	 wvaEvrrEA6qYw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7C93788297;
 Sat, 27 Apr 2024 12:22:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714213330;
 bh=CkSc1MzmASfau50N0U5gnsonC6XrVL4Nyy3JTWHmP8o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=U3fzJ4qBsTLX8VICJQxsH1qMeMkn7GC0MKg/N7yNYvMO6lwdQJNbOPIVFiCtZgWX0
 iaw75aUr211Iu37LMx8amaFCvdHNaf6gz5rrCxEnOs3n9QgkgHIyoqZhnUz904YxwV
 oIroXNL6KMz53qR4LxR3pyUX/J5Zio3/uaDEgt+EIER/oRkjSH4IUVB9iiiASKEkc9
 YG+7eyPwfVn5+ZZTc7H+ipVZd/YnXZ8BAhAzb/MfJ9M7FC35738FQ2ZDwe7oTntzR5
 v8qAON4XyhL1D6HuwlEh7IzNctL7ai3iG70eNz0k7y/PIQA+SMwXY2+6Dsrvr7bRVX
 eke6wK1Fr+snQ==
Message-ID: <d8a77dd7-39bf-4ccd-979a-97eedb054b36@denx.de>
Date: Sat, 27 Apr 2024 12:22:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: allow use of hardware partition names for mmc
 partconf
To: E Shattow <lucent@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 Dragan Simic <dsimic@manjaro.org>
References: <20240427001157.1460302-1-tharvey@gateworks.com>
 <52d7d87e-19b0-4474-bf75-33dbbc150c31@denx.de>
 <CANV2PTOQknpnfKsZQC9Tr0AhZgMQOOTTND0T+WMp8pwv-5TNdQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CANV2PTOQknpnfKsZQC9Tr0AhZgMQOOTTND0T+WMp8pwv-5TNdQ@mail.gmail.com>
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

On 4/27/24 3:29 AM, E Shattow wrote:
> Hi Marek,
> 
> On Fri, Apr 26, 2024 at 5:49 PM Marek Vasut <marex@denx.de> wrote:
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
>>> +     EMMC_HWPART_BOOT0 = 1,
>>> +     EMMC_HWPART_BOOT1 = 2,
>>> +     EMMC_HWPART_GP1 = 3,
>>> +     EMMC_HWPART_GP2 = 4,
>>> +     EMMC_HWPART_GP3 = 5,
>>> +     EMMC_HWPART_GP4 = 6,
>>> +     EMMC_HWPART_USER = 7,
>>> +};
>>> +
>>> +/* emmc hardware partition names */
>>> +extern const char *emmc_hwpart_names[];
>>
>> Maybe the array should have fixed size here, i.e. 8 ?
> 
> Is there an ABI reason to do so? Can you explain further why it would
> be needed to do that?

It has nothing to do with ABI, it is only to let the compiler validate 
that nobody would index the array with index > 7 by accident.
