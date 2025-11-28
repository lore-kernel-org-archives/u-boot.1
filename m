Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91406D116F5
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C87C84558;
	Fri, 28 Nov 2025 12:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="t7yrXVAK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E027584559; Fri, 28 Nov 2025 12:58:40 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1D4584552
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dHsJX5hmPz9tJZ;
 Fri, 28 Nov 2025 12:58:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764331116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKeIjh1bBzR+hNX0cEdZOYgJKSTm59UJ/F32RvK2tvQ=;
 b=t7yrXVAKsR0urQ6aaFTJxgV7MQ+2mU2oF7vFEIPFUhlf7htUuCV2AinAAD5C655sR9MhMp
 06r6Jtz3iMBiq5Gj6GPfgkjp+Kj/cJLehNpV+jvDC9AEzzzrVob5RVdMcMpU7ZMtWzl8l0
 RRCTIOXrxJ80C0slzz3H3J4m9r4O5O5llbf3UzUW43t13k3zr8MpdJkbvv/HLwe+KGPjkU
 o+86B+iHIPraiigDRXEd4KYShd7t9vCLpDY17/k73hLE9RaBPRrdtEoKCFtXvIFSZkvMta
 RqQlWUYq6BJLJdDkcz7dCQ0Uer+MjHB7unIfGmyl4YP+U5UZj1TLDkCsnx5sKw==
Message-ID: <34e3984c-f39c-4955-b6ae-045ce6cf38f2@mailbox.org>
Date: Fri, 28 Nov 2025 12:58:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] imx: container: Eliminate IMX_PQC_SUPPORT
To: Ye Li <ye.li@oss.nxp.com>, u-boot@lists.denx.de
Cc: fedor.ross@ifm.com, =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
References: <20251127192633.79935-1-marek.vasut@mailbox.org>
 <3da2565f-523d-47df-8202-0624bf0a445c@oss.nxp.com>
 <b44cb7cd-1c07-477c-8233-03d029266b7e@mailbox.org>
 <541c6616-224f-4b92-a980-a43ca159804d@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <541c6616-224f-4b92-a980-a43ca159804d@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 19548708f1052970b40
X-MBO-RS-META: 8ursmjfq5cu1qcmaw46w31769mgehojf
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

On 11/28/25 6:31 AM, Ye Li wrote:
> 
> 
> On 11/28/2025 1:09 PM, Marek Vasut wrote:
>> On 11/28/25 4:26 AM, Ye Li wrote:
>>
>> Hello everyone,
>>
>>>> +static inline int container_hdr_alignment(void)
>>>> +{
>>>> +    if (is_imx94())
>>>> +        return 0x4000;    /* PQC */
>>>> +
>>>> +    if (is_imx95() && (soc_rev() >= CHIP_REV_2_0))
>>>> +        return 0x4000;    /* PQC on i.MX95 B0 and newer */
>>>> +
>>>> +    return 0x400;    /* Non-PQC on i.MX95 A1 and older */
>>>
>>>
>>> I understand you want to use single uboot and spl image for A0 and 
>>> B0. But A0 is not production. Only early customers get few A0 
>>> samples. NXP marketing has notified these customers to replace A0 to 
>>> B0. Are you still using A0 board? Is it necessary to do such change 
>>> as we want to remove A0 to simplify the codes?
>>
>> I have both A0 and B0 device.
>>
>> I do not see why we need to have a Kconfig option for something we can 
>> trivially auto-detect, hence this patch.
> 
> Yes, it can auto-detect. The history is we dropped A0 when upstreaming 
> B0 support. But someone from community complained A0 broken and 
> requested to add back A0. Using static Kconfig is easy for removing A0 
> in future.

Adding another Kconfig symbol and ifdeffery seems easy, but it also had 
additional implications -- more code paths because of the ifdeffery, 
more Kconfig symbols which the user has to understand, and another 
machine config has to be built in the CI to cover this configuration.

The auto-detection avoids all these problems.

>>> Eliminate IMX_PQC_SUPPORT config is not a good way. When adding new 
>>> SOC, developer has to update the container_hdr_alignment, then it 
>>> will be a long list in this function. Actually only iMX95 is the 
>>> exception. If you insist keeping A0, I prefer change like below and 
>>> retain IMX_PQC_SUPPORT.
>>>
>>> #if IS_ENABLED(CONFIG_IMX95)
>>> static inline u32 container_hdr_alignment(void)
>>> {
>>>      if (is_imx95() && (soc_rev() >= CHIP_REV_2_0))
>>>          return 0x4000;
>>>      else
>>>          return 0x400;
>>> }
>>> #else
>>> static inline u32 container_hdr_alignment(void)
>>> {
>>> #if IS_ENABLED(CONFIG_IMX_PQC_SUPPORT)
>>>      return 0x4000;
>>> #else
>>>      return 0x400;
>>> #endif
>>> }
>>> #endif
>> This adds even more ifdeffery and makes the code even worse, so no.
>>
>> But if you are sure that every new SoC will have the PQC alignment, 
>> then the condition in this patch can be inverted this way:
>>
>> static inline int container_hdr_alignment(void)
>> {
>>      if (is_imx95() && (soc_rev() < CHIP_REV_2_0))
>>          return 0x400;    /* PQC on i.MX95 A1 and older */
>>
>>      return 0x4000;    /* PQC is the default */
>> }
>>
>> Are you sure every new SoC (at least in the foreseeable future) will 
>> be like that ?
> No, it can't be guaranteed. And we have legacy SOC like 
> 8QM/8QXP/8ULP/93/91 using this container without PQC support, above new 
> change will break them. Please consider keeping the IMX_PQC_SUPPORT, so 
> every soc can select it to work.
See above why adding more and more Kconfig options is not a good solution.

I believe the original implementation in this patch does not break the 
legacy SoCs ?

If you are concerned about growing list of SoCs in this function, then 
this function can list the five legacy SoCs + imx95a0 SoC with non-PQC 
alignment and by default return PQC alignment ?
