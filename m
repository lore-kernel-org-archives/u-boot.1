Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD070E7B616
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 13:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF72187559;
	Wed,  4 Oct 2023 15:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HsgJ2pny";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE2787557; Wed,  4 Oct 2023 15:39:40 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D6DC87559
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 15:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S0wlb54rDz9t2g;
 Wed,  4 Oct 2023 15:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696426763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CynMQCCLu0ksQ/eO6WDp9j/6Qs+AcJKeRdLFgq3sLT0=;
 b=HsgJ2pny/JJ47esGqCvsfV3wNdCbELuZVDSTXqxO9BXY1ky+UDN/9cqaHudHkYzVLTLMLF
 z2NAIpx09ypCrdjikgWCNuDtR4e2IhLFRRyiQiqe0U1jDffl8/hAEAvaDuq9F2x2YPoHn7
 9mp7WzinPfn0HlivjDiretl3YuZif+i+VIcfhnF4yxTZxAk2awaHwyVpxqZNooGJ6leOLU
 HSr3tGtbMsUTc1QDHHYljYfzmXAb16NVrC1CLaY1X152g2jLqHz6LfRsO9CU63atxVhc4Y
 b7lmNA0Cf+eFvayJdTK1UdZW5AyE1xCrHVsCWNE/K2f2xTRTzfpZMfSM33nCsQ==
Message-ID: <600f80c7-90ce-4acf-a6c1-63ad73936a4d@mailbox.org>
Date: Wed, 4 Oct 2023 15:39:22 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 06/16] arm: rmobile: Add basic R9A07G044L SoC support
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-7-paul.barker.ct@bp.renesas.com>
 <f39461fe-cbfb-2bef-b012-0ca5c546520f@mailbox.org>
 <8d68fc58-6af4-8fa1-5683-f456a9ddf393@bp.renesas.com>
 <b8a2e546-e14d-4c08-b841-87e06a53104e@mailbox.org>
 <20231004132646.qj72ofp2fdt3cbrc@GBR-5CG2373LKG.adwin.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231004132646.qj72ofp2fdt3cbrc@GBR-5CG2373LKG.adwin.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: fe065f67dc54bb73236
X-MBO-RS-META: o7z7etbe3h3kdb9kg8y9c8ihag5hooat
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

On 10/4/23 15:26, Paul Barker wrote:
> On Wed, Oct 04, 2023 at 02:15:24PM +0200, Marek Vasut wrote:
>> On 10/4/23 09:59, Paul Barker wrote:
>>> On 03/10/2023 13:46, Marek Vasut wrote:
>>>> On 9/20/23 14:42, Paul Barker wrote:
>>>>> Add a config option for the R9A07G044L SoC used in the RZ/G2L so that we
>>>>> can make use of this in the subsequent driver patches.
>>>>>
>>>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>>>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>>>>> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>>> ---
>>>>>     arch/arm/mach-rmobile/Kconfig.rzg2l | 5 +++++
>>>>>     1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/mach-rmobile/Kconfig.rzg2l b/arch/arm/mach-rmobile/Kconfig.rzg2l
>>>>> index 37ff6cd34160..266f82c18085 100644
>>>>> --- a/arch/arm/mach-rmobile/Kconfig.rzg2l
>>>>> +++ b/arch/arm/mach-rmobile/Kconfig.rzg2l
>>>>> @@ -3,6 +3,11 @@
>>>>>     if RZG2L
>>>>> +config R9A07G044L
>>>>> +	bool "Renesas R9A07G044L SoC"
>>>>> +	help
>>>>> +	  Enable support for the R9A07G044L SoC used in the RZ/G2L.
>>>>
>>>> I was under the impression that RZ/G2L is a SoC family, so the
>>>> R9A07G044L is part of that SoC family ? Maybe just reword this paragraph
>>>> and the commit message a bit to make it less confusing.
>>>
>>> The confusion is hard to avoid (see my reply re patch 5 of this series),
>>> but I'll see if I can improve this a bit in v2.
>>
>> So uh ... RZ/G2L is both the name of R9A07G044L SoC (what's the R9... model
>> number of e.g. RZ/G2LC?) and a family name ?
> 
> Yes. Definitely easy to confuse!
> 
> We have (with differences from the RZ/G2L model numbers highlighted):
>   * RZ/G2L  (R9A07G044L1 or R9A07G044L2)
>   * RZ/G2LC (R9A07G044*C*1 or R9A07G044*C*2)
>   * RZ/G2UL (R9A07G04*3U1*)
>   * RZ/V2L  (R9A07G0*5*4L1 or R9A07G0*5*4L2)
>   * RZ/Five (R9A07G04*3F0*)
> 
> The last digit indicates the number of cores (1 or 2), except for on the
> RZ/Five which has one core but the model number ends in a zero.

OK, got it, thanks !
