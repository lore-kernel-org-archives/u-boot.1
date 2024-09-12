Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDC4EEB561
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 08:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B89288D1B;
	Thu, 12 Sep 2024 10:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726129637;
	bh=hUWAUdTVdvvGcefmU3M4OCcNLcN/Gsf0pLwA6nNmSpw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RfqDqnqA7u53velFrpAK6TZNq8Nf9SXmA1ak9Y5UuELX+j99flYx26eWcKYgMa5X6
	 4490eVlzzEKG9wn14zEJU3cHBT1pUUniSwkcHYjKLx9KA0s85dy+3IK8fdq6q+apu2
	 aEW64nVIUox3SqJJHrD1EnRuctGfXE6W0JQqU1SEKw2mfkdZXTR/Z5+ldzSZh0VzK1
	 V7LbbLDnZHG8XP+xVpdRwdAa5aTjuDPOlAZKR7Cq6hnjJQK3/FHARtMEv4N+lllyc4
	 vte2KIg61shulWV3nwKZOZInkAUiBM30Hrt9Y4bkUtMIPchHGshLFpXkHm3ExQoDws
	 NI6kc0oEi7a1g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 36D4588936;
 Thu, 12 Sep 2024 10:27:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726129636;
 bh=hUWAUdTVdvvGcefmU3M4OCcNLcN/Gsf0pLwA6nNmSpw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qRnlVwY+4G3nLGkG1TLrrY+oGGcdjZw6k/VZzVZAQg3vIrEtRc/6xbIUYbbwNz5Bb
 YpOeXUC9Zmy+hQDvhqOBbSjyqIXzyid69EuIeROLcnKn9Z2Us21js+HCykCyCkxB0S
 IXlfAnR7X/74palpUP8nsAQsoGvCwnATjp6+6PVAruz9+UKBXlWUSb1uz6kJKuVCTZ
 KqWXaDqdLDP6ZgOMScVEuDUY/6i5T9ePjibKxIVENlWidPVnlwwOYJGA6F3X7zW4Ed
 +Wu+diAyWoxlLs4CgIQ7k7726QzbzURaO0UbPXxc72RnfDebtmXMGFyLW1slDXxMWc
 A89tfVAkjW5YA==
Message-ID: <72981923-1e46-4863-9277-3f094feec89c@denx.de>
Date: Thu, 12 Sep 2024 10:05:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sumit Garg
 <sumit.garg@linaro.org>, uboot-stm32@st-md-mailman.stormreply.com
References: <CAPVz0n3Ji1sKQK+Lnq8rP3ZqwX3o-kXe2btj93UuVBa3T5C=qw@mail.gmail.com>
 <eced1020-2157-44a4-98a9-845e218529d9@denx.de>
 <45c74c58-98cf-43df-b837-c48b0341c551@denx.de>
 <CAPVz0n2-DCKDcVrAi00kF6yDcE2bN1mtUhzBcw7JDiZoXgzu0w@mail.gmail.com>
 <e5837ce4-0a14-4822-960d-6ab667a9f4b1@denx.de>
 <CAPVz0n323ktF6kb3WHR9JcE+xOzQr9-aWOR47+ZvwQr=ib18rg@mail.gmail.com>
 <f778366b-bdaf-415d-a94e-c995f62e8c71@denx.de>
 <CAPVz0n0ru1rPb9SNw515mkwfs4=nNSOPjZY74JVkqnGbEouSLQ@mail.gmail.com>
 <cfc1a158-6c35-4288-aed0-fcc78a8db832@denx.de>
 <CAPVz0n1Vh7Vgnt8_Lx6U8p42QvtVnHB9yvb=RmjYrS=w1G3u1A@mail.gmail.com>
 <20240911162503.GQ4252@bill-the-cat>
 <CAFLszTjsJFmdsTUEOC-uFKUMyQDJkLhzvcyrSTSFhLF4L=Cp6w@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTjsJFmdsTUEOC-uFKUMyQDJkLhzvcyrSTSFhLF4L=Cp6w@mail.gmail.com>
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

On 9/12/24 2:59 AM, Simon Glass wrote:
> Hi Tom,

Hello Simon,

>> How do you propose we resolve this then, Svyatoslav? I threw this patch
>> at some TI platforms as well and they're all fine. Are you unable to get
>> some early debuging information out like Marek was asking? Thanks.
> 
> At this point I would like to have an optional Kconfig to enable the
> always-on regulators in the init sequence, perhaps as part of
> initf_dm().

That would only move the current regulators_enable_boot_on() elsewhere 
without fixing the real issue which this series does address -- that the 
regulators which are marked as always-on/boot-on should always be 
enabled on boot, unconditionally. If there are regulators which should 
not be enabled on boot, they should not be marked always-on/boot-on in 
DT in the first place.

The regulators_enable_boot_on() is missing or forgotten in multiple 
board files, which makes boards randomly misbehave due to disabled 
always-on regulators. Adding a Kconfig option would convert this problem 
to "new Kconfig option is missing in multiple configs" problem, which is 
effectively identical problem, only moved elsewhere. It should be the 
core code that handles this the same way for all boards and configs.

The core has the tools for it too, the DM_FLAG_PROBE_AFTER_BIND flag 
which is already used for the same purpose for LEDs, pinctrl, PMICs, 
etc., which makes regulators_enable_boot_on() unnecessary.

The DM_FLAG_PROBE_AFTER_BIND should be used more instead of ad-hoc 
callbacks in random places of the init sequence, those do not scale.

> It should not be in DM core, sorry.
This is in regulator uclass, not in DM core ?

This discussion thread is about debugging tegra i2c, how is your comment 
related to the discussion here ?
