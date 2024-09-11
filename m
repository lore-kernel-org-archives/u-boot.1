Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CB0EE4992
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 11:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FB758926B;
	Wed, 11 Sep 2024 13:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726052495;
	bh=Al3jtDPhLxOvdIYKZNxcpagroFBcDaxM8JV+V4iFiD8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wANp9bPbiD5MvmBn2VuadD0Hvrgfn17gx8EFPPq5U+ybMgHIg0tyYRsWb8zjQT3kR
	 qNYbUSqc/Gr6Kl87V8CFwbqMbdIihEhHKI/XR+rDfLHBb9a/knZVNT0Mr/K7S0ugdU
	 prMXfkMOMqVet1bf7CJ1qO1rluAbJtPnYSCSliEJTdafHfZ6daFftYdtvfJHyUMsSk
	 mSGg6yvz2PAzkQvwNLWF8G8RjaccoeP2KGneM8ukUWb2xT1dydB0fBe4d3jPLB95Wx
	 c+1G7533ktvIjOlFrE8tk9BLOrc1dvTajEYrYE06QHH1F2U8STeCW77AqluVd9yQzi
	 nkB3Fc6WZ4RQA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 333B489228;
 Wed, 11 Sep 2024 13:01:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726052493;
 bh=Al3jtDPhLxOvdIYKZNxcpagroFBcDaxM8JV+V4iFiD8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SG7nrscnfbfhj4Rvja0Kc+Jp54Y1xypEQ+qYYoRSKLTrDL/CX4dWRilD8xoUlvR48
 Z+moGOUP000/K1d2QGz0VpME0+BF3x194aYqLUtvdIDeAXcap9uAiv2zMByo5+CnCQ
 8AT/0AZN6K5v5v/HQthS4qKyvTuEbAilUNlKh158CmNwonEuFiae7JPAQqpeZciM8U
 USVM7ih3kmYOeBhp7WX+Lr1NcPC1mw5NRn6r8zy3s48bOKumsHXrLhwWO64z5A1M7y
 HfUcEk48sNgrVKz3uWJmu/h19QHqfNY37NiIqkof8SS6LNmb6Hqdn+hXWmNlcRED7x
 3OXg2LnA4/5Uw==
Message-ID: <cfc1a158-6c35-4288-aed0-fcc78a8db832@denx.de>
Date: Wed, 11 Sep 2024 12:46:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, uboot-stm32@st-md-mailman.stormreply.com
References: <20240626235717.272219-1-marex@denx.de>
 <a73dffe5-87e3-4e96-965f-9d029f2af8ed@denx.de>
 <CAPVz0n0C6TPdBRUEvJmgAUGAKoetuzr1j=0cMXweP2EqMTwn=g@mail.gmail.com>
 <0910419d-e8ab-4bf9-a083-dc2783afaca1@denx.de>
 <4D07A6E5-F156-44C3-A26D-0F2D913CE92D@gmail.com>
 <18d84528-d2e5-41d6-ae1d-109ee30853b2@denx.de>
 <CAPVz0n2Jzfih0Z85TSQbnz-8OrX4D6UN=anKGTJ=hckRt8f3xA@mail.gmail.com>
 <a95f0d60-2883-4c3d-8a53-ee3ef414cc32@denx.de>
 <CAPVz0n3Ji1sKQK+Lnq8rP3ZqwX3o-kXe2btj93UuVBa3T5C=qw@mail.gmail.com>
 <eced1020-2157-44a4-98a9-845e218529d9@denx.de>
 <45c74c58-98cf-43df-b837-c48b0341c551@denx.de>
 <CAPVz0n2-DCKDcVrAi00kF6yDcE2bN1mtUhzBcw7JDiZoXgzu0w@mail.gmail.com>
 <e5837ce4-0a14-4822-960d-6ab667a9f4b1@denx.de>
 <CAPVz0n323ktF6kb3WHR9JcE+xOzQr9-aWOR47+ZvwQr=ib18rg@mail.gmail.com>
 <f778366b-bdaf-415d-a94e-c995f62e8c71@denx.de>
 <CAPVz0n0ru1rPb9SNw515mkwfs4=nNSOPjZY74JVkqnGbEouSLQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAPVz0n0ru1rPb9SNw515mkwfs4=nNSOPjZY74JVkqnGbEouSLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/11/24 7:57 AM, Svyatoslav Ryhel wrote:

[...]

>>>> You did mention something regarding I2C/PMIC driver probe timing, but it
>>>> seems the I2C driver and PMIC drivers probe roughly around the same time
>>>> in both pass and fail cases ?
>>>
>>> Yes, here I agree that they both probe and probe passes, but I assume
>>> timing of i2c call is critical and there may be some dependency which
>>> is not ready.
>>
>> My guess would be pinmux or clock, maybe the i2c controller is marked as
>> bootph-* in DT and its pinmux/clock is not? Maybe the i2c on tegra works
>> by sheer coincidence right now? Can you have a look?
> 
> Power i2c line (one that hosts PMIC) is configured extremely early in
> SPL since it is needed for cpu and core voltage setup so even if, as
> you say, tegra works by sheer coincidence, specifically this i2c line
> should work non the less, since it has all its pre-requisites (clock
> and pinmux) configured on early stage.

Is it possible that this configuration is somehow reset or reconfigured 
from DT early on in U-Boot proper ?

Do you have serial console output in board_f.c time in U-Boot proper , 
possibly using DEUBG_UART , to check if there might be some prior 
failing I2C transfer at that board_f.c time ?

> As I have told, I was not able to determine exact reason why this
> happens, it should not and yet it does. This is why I have abandoned
> my attempt to implement same changes you are currently proposing.

If tegra has a problem, it should be fixed on tegra side and not block 
core plumbing. I am not seeing the problem on stm32 or imx systems, so I 
am banking toward tegra-specific issue.

Are you able to debug this ?
