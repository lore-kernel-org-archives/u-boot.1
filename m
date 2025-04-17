Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74633C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 15:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8F6A81DE3;
	Thu, 17 Apr 2025 17:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744903933;
	bh=TEzp1YKjsxrJY3xIb0clVG5FRXNRYZO6TauJCRd68vA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=IZUnpHstOM9uR7WW28VqVM9mS9RNhCLl7pCfhCKr2n20n6wy8YTh0LMh5jUS8wIGA
	 4CTIvkMiBVEqfvcjc4ccvuSYXswG0jScPi2Cl5OTgV35Y/LM/G2um1HnFpuPX4xF1a
	 d/+u1/tT8sRUjt40zyQzE1XSBTttpl4l9l+AjMp7He72KqhJIZg9Z+Ml+UlP16i/hk
	 zQuplX61UZQ/iFlYBab7veyDlhEbIK+bZjmA9y+PjOPeCpv0BD3xKb7szVIkY46Ae/
	 CjYr64tnESPHNPzISIyrVymRhv/q+/GfULA9dSLHkdGB58HF3ImGsJI+kZTaqO2aKu
	 kHSBk6pEL/4+A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B37E381E14; Thu, 17 Apr 2025 17:32:12 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90DE5817C4
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 17:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="HADZ84Wh"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CD8451039EF33; 
 Thu, 17 Apr 2025 17:32:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744903929;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=TEzp1YKjsxrJY3xIb0clVG5FRXNRYZO6TauJCRd68vA=;
 b=HADZ84Wh1zfVEvEFc19uu9OvEOKvSMibgrXh33NixqLh7PvOK9nJJ8i3Jar267DKghC8Um
 /8xBJB0SM3YkcGmNnllFWleZjxMvy9sLTk7htEzIN9VrsAgJjl+E2TG8k1MhGlKJIUogui
 J3yUu01JkvbPLI4EFejRrUDfZFA10wik8aTOgxdfJmZL9BQ1cjkofjkzpnGEGTk0iVP8Ot
 MENZyp+S5Fd1Yj4f3rItvZGwSYe5Gnk6zoLVfix+rHNZ0ch3+bJIBA/uYGnd6Ax44Ric0y
 OAkv3XeSKmc4jJsFpZX80FhtDv5xb5z2AYmU1Tlen91UoXW/778Wkhp7qpMU0w==
Message-ID: <7caa4ed5-e419-bdfc-9e30-2dff3fd11092@denx.de>
Date: Thu, 17 Apr 2025 17:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: imx8mp: pci enumeration fails with current HEAD
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Fabio Estevam <festevam@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <c533393a-ca65-49a4-55a5-77bcb3cf589d@denx.de>
 <475e2654-715a-0139-7cc5-734a3457db9b@denx.de> <874iymq0g6.fsf@bootlin.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <874iymq0g6.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Miquel,

On 17.04.25 17:20, Miquel Raynal wrote:
> On 17/04/2025 at 16:46:13 +02, Heiko Schocher <hs@denx.de> wrote:
> 
>> Hello Miquel,
>>
>> On 17.04.25 16:37, Heiko Schocher wrote:
>>> Hi Miquel,
>>> I have here an imx8mp based board for which I just prepare mainlining.
>>> pci enumeration works fine with U-Boot 2025.04
>>> u-boot=> pci enum
>>> PCIE-0: Link up (Gen1-x1, Bus0)
>>> u-boot=>
>>> and tftp through the ethernet interface works fine.
>>> Using current HEAD
>>> * 5b4ae0f3f04 - (origin/master, origin/HEAD) mailmap: update my name
>>> and email (vor 2 Tagen) <Casey Connolly>
>>> It breaks with:
>>> u-boot=> pci enum
>>> nxp_imx8_pcie_phy pcie-phy@32f00000: PHY: Failed to power on pcie-phy@32f00000: -110.
>>> pcie_dw_imx pcie@33800000: failed to power on PHY
>>> u-boot=>
>>> git bisect dropped your patch:
>>> 197376fbf300e92afa0a1583815d9c9eb52d613a is the first bad commit
>>> commit 197376fbf300e92afa0a1583815d9c9eb52d613a
>>> Author: Miquel Raynal <miquel.raynal@bootlin.com>
>>> Date:   Thu Apr 3 09:39:05 2025 +0200
>>>       power-domain: Add refcounting
>>>       It is very surprising that such an uclass, specifically designed
>>> to
>>>       handle resources that may be shared by different devices, is not keeping
>>>       the count of the number of times a power domain has been
>>>       enabled/disabled to avoid shutting it down unexpectedly or disabling it
>>>       several times.
>>>       Doing this causes troubles on eg. i.MX8MP because disabling power
>>>       domains can be done in recursive loops were the same power domain
>>>       disabled up to 4 times in a row. PGCs seem to have tight FSM internal
>>>       timings to respect and it is easy to produce a race condition that puts
>>>       the power domains in an unstable state, leading to ADB400 errors and
>>>       later crashes in Linux.
>>>       CI tests using power domains are slightly updated to make sure
>>> the count
>>>       of on/off calls is even and the results match what we *now* expect.
>>>       As we do not want to break existing users while stile getting
>>>       interesting error codes, the implementation is split between:
>>>       - a low-level helper reporting error codes if the requested transition
>>>         could not be operated,
>>>       - a higher-level helper ignoring the "non error" codes, like EALREADY and
>>>         EBUSY.
>>>       Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>> reverting this patch, and it works again fine for me!
>>> Do you have a imx8mp based hardware with pci?
>>> Can you (or anyone else with an imx8mp based hardware with pci)
>>> approve
>>> this on a similiar HW?
>>> I try to dig into it, but may you have a fast idea!
>>> Okay, thought about it ... it tries to power on "blk-ctrl@32f10000"
>>> driver:/drivers/power/domain/imx8mp-hsiomix.c
>>> imx8mp.dtsi:
>>>                           hsio_blk_ctrl: blk-ctrl@32f10000 {
>>>                                   compatible = "fsl,imx8mp-hsio-blk-ctrl", "syscon";
>>> which has several different power domains ... and your patch prevents
>>> to
>>> enable more than one of them ... adding some debugs shows:
>>> u-boot=> pci enum
>>> [...]
>>> power_domain_on_lowlevel(power_domain=00000000fe5942f8) blk-ctrl@32f10000 priv->on_count: 0
>>> power_domain_on_lowlevel(power_domain=00000000fe5942f8) blk-ctrl@32f10000 power_domain->id: 4
>>> Here pwoer domain id
>>> #define IMX8MP_HSIOBLK_PD_PCIE_PHY                      4
>>> gets enabled and on_count increases...
>>> imx8mp_hsiomix_set: ------------ power_domain->id: 4
>>> IMX8MP_HSIOBLK_PD_PCIE: 3 4
>>> power_domain_on_lowlevel(power_domain=00000000fe5d2408) power-domain@17 priv->on_count: 0
>>> power_domain_on_lowlevel(power_domain=00000000fe5d2408) power-domain@17 power_domain->id: 0
>>> power_domain_on_lowlevel: ret: 0
>>> power_domain_on_lowlevel(power_domain=00000000fe5d2480) power-domain@1 priv->on_count: 0
>>> power_domain_on_lowlevel(power_domain=00000000fe5d2480) power-domain@1 power_domain->id: 0
>>> power_domain_on_lowlevel: ret: 0
>>> imx8mp_hsiomix_set: ------------ power_domain->id: 4 IMX8MP_HSIOBLK_PD_PCIE: 3 4 END OKAY
>>> power_domain_on_lowlevel: ret: 0
>>> power_domain_get_by_index(dev=00000000fe5b2410, power_domain=00000000fe594458)
>>> power_domain_on_lowlevel(power_domain=00000000fe594458) blk-ctrl@32f10000 priv->on_count: 1
>>> power_domain_on_lowlevel(power_domain=00000000fe594458) blk-ctrl@32f10000 power_domain->id: 3
>>
>> okay, the "power_domain=00000000fe594458" for the IMX8MP_HSIOBLK_PD_PCIE case
>> is different as the one for the IMX8MP_HSIOBLK_PD_PCIE_PHY case ... so priv pointer
>> should also be different...
> 
> That's part of the problem. The API is unusual, you probably allocate a
> structure (either on the stack or dynamically) and pass its pointer to
> be filled by the uclass.
> 
> In general the approach is that you ask the uclass to give you a pointer
> towards a unique version of a structure that defines an opaque object
> you want to manipulate.
> 
> So I do not think the printing is relevant, what is more relevant is the
> node the udev targets. In both cases it is blk-ctrl@32f10000, so the
> second time on_count is already set.

Yep...

>> so that should be fine ... I do not see any debug output
>> where this "power_domain=00000000fe594458" gets enabled (or disabled before) ... I
>> have to debug deeper into it... sorry. But may you have an idea...
> 
> Let me know if you think my theory does not stand.

I am unsure here, and not to deep in this part of the code ... I
thought that both have a different priv pointer ... so it should be
fine.. but thats also just theory... I have to debug... sorry,
that I could not help more here currently.

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
