Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9F6C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 08:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 195D98815D;
	Mon, 15 Apr 2024 10:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="vJVuW/KZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 875BB881FD; Mon, 15 Apr 2024 10:36:14 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41A2D88152
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 10:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713170171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXYIpbN7+vS4hsTpqf67bZsS6t3Y7lDKJIHM0da9QTs=;
 b=vJVuW/KZHSZtPdIoUT7Oc4FpfvleeXpkAV48YctNjkMWh5UfupXWZvsfKNJIjMbRAFp05o
 Xu4kIGeZkLbOyLdEuru1aRovE7MQ7yYpQY5tisvXU48zCkW/6orAFMkiWI678WCwLNBhOu
 EL+oLQx+x8m/+sSit9lPkNwrMtjQFypXT4Ujc9/CEBErl1x89294uoX4f2jDMA+f4yU66E
 LH57ArxEy4uZHYaoNMr45W4Nace3y/S6374z5KQH2zYGX7wGS8PduwlNOdk9Pr3C3GcwkL
 YZdSsIHGqu2Ig68zKzoADpLrpHsQwdZ4JKc6RM2CCPk8M86v2c9z4ajRdXCyZQ==
Date: Mon, 15 Apr 2024 10:36:10 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Jagan Teki <jagan@edgeble.ai>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, John Clark <inindev@gmail.com>, Tom Fitzhenry
 <tom@tom-fitzhenry.me.uk>, Elon Zhang <zhangzj@rock-chips.com>, Quentin
 Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 23/23] rockchip: rk3588: Enable use of eMMC HS200 mode
 on a few missed boards
In-Reply-To: <05c12e28-c24e-495a-9cdb-d97752cbe6d9@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-24-jonas@kwiboo.se>
 <0bfe98a361956a2e1464d5327756ccab@manjaro.org>
 <05c12e28-c24e-495a-9cdb-d97752cbe6d9@kwiboo.se>
Message-ID: <a9d04ab75010f358b759eac00acbdef0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-04-15 10:23, Jonas Karlman wrote:
> On 2024-04-15 09:00, Dragan Simic wrote:
>> Please see my comments below.
>> 
>> On 2024-04-13 20:13, Jonas Karlman wrote:
>>> A few RK3588 boards are missing a mmc-hs200 prop to signal that HS200
>>> mode is supported in addition to HS400, this lead to bad performance
>>> reading FIT in SPL and broken MMC write.
>>> 
>>> Add cap-mmc-highspeed and mmc-hs200-1_8v to affected boards to enable
>>> use of eMMC HS200 mode.
>>> 
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> 
>> Shouldn't it be better to follow the Linux kernel's logic in
>> the MMC driver, and enable the HS200 mode when the DT indicates
>> that the HS400 mode is suported?  In other words, exactly what
>> you already submitted to the mailing list. [1]
> 
> Yes, this is somewhat what I tried to make aware of with the note and
> link under "v2: New patch" :-)

Wow, I totally missed that paragraph. :)  Though, that also means
that we're on the same page. :)

>> That would allow a significant cleanup of the U-Boot dtsi files
>> to be performed.
>> 
>> Until that's resolved, the patch is looking good to me.
> 
> Fully agree, this will fix the bad performance in SPL and fix MMC write
> for existing boards making them work same as other RK3588 boards until
> the MMC maintainer can weigh in on the linked patch.

That will be nice.

>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> 
> Thanks!

Thank you for all these nice cleanup patches!

>> [1] 
>> https://lore.kernel.org/u-boot/20240408210619.3749231-1-jonas@kwiboo.se/
>> 
>>> ---
>>> v2: New patch
>>> 
>>> All these mmc-hs200 prop overrides may not be needed if the patch 
>>> "mmc:
>>> Imply HS200 cap with mmc-hs400 prop to match linux" [1] gets applied,
>>> until such time this matches what has been done for all other RK35xx
>>> boards.
>>> 
>>> [1] https://patchwork.ozlabs.org/patch/1921039/
>>> ---
>>>  arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi | 5 +++++
>>>  arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi | 5 +++++
>>>  arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi         | 5 +++++
>>>  arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi        | 5 +++++
>>>  arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi      | 5 +++++
>>>  arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi      | 5 +++++
>>>  6 files changed, 30 insertions(+)
>>> 
>>> diff --git a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
>>> b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
>>> index dd0058262b7f..fc4b13628b30 100644
>>> --- a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
>>> @@ -15,6 +15,11 @@
>>>  	};
>>>  };
>>> 
>>> +&sdhci {
>>> +	cap-mmc-highspeed;
>>> +	mmc-hs200-1_8v;
>>> +};
>>> +
>>>  &sdmmc {
>>>  	bus-width = <4>;
>>>  	status = "okay";
>>> diff --git a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
>>> b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
>>> index a45b3f5e86ad..a0c62072c34e 100644
>>> --- a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
>>> @@ -14,3 +14,8 @@
>>>  		u-boot,spl-boot-order = &sdmmc;
>>>  	};
>>>  };
>>> +
>>> +&sdhci {
>>> +	cap-mmc-highspeed;
>>> +	mmc-hs200-1_8v;
>>> +};
>>> diff --git a/arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
>>> b/arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
>>> index e8566785e965..354e4a8d39e3 100644
>>> --- a/arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
>>> @@ -10,3 +10,8 @@
>>>  		u-boot,spl-boot-order = "same-as-spl", &sdhci;
>>>  	};
>>>  };
>>> +
>>> +&sdhci {
>>> +	cap-mmc-highspeed;
>>> +	mmc-hs200-1_8v;
>>> +};
>>> diff --git a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
>>> b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
>>> index 968385622fa5..7948464ac85f 100644
>>> --- a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
>>> @@ -11,6 +11,11 @@
>>>  	bootph-some-ram;
>>>  };
>>> 
>>> +&sdhci {
>>> +	cap-mmc-highspeed;
>>> +	mmc-hs200-1_8v;
>>> +};
>>> +
>>>  &sfc {
>>>  	pinctrl-names = "default";
>>>  	pinctrl-0 = <&fspim1_pins>;
>>> diff --git a/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
>>> b/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
>>> index 7b937943a53c..d764135ab661 100644
>>> --- a/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
>>> @@ -4,3 +4,8 @@
>>>   */
>>> 
>>>  #include "rk3588-u-boot.dtsi"
>>> +
>>> +&sdhci {
>>> +	cap-mmc-highspeed;
>>> +	mmc-hs200-1_8v;
>>> +};
>>> diff --git a/arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
>>> b/arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
>>> index 1aeb5410e43e..c5c94b421d1e 100644
>>> --- a/arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
>>> @@ -10,3 +10,8 @@
>>>  		u-boot,spl-boot-order = "same-as-spl", &sdhci;
>>>  	};
>>>  };
>>> +
>>> +&sdhci {
>>> +	cap-mmc-highspeed;
>>> +	mmc-hs200-1_8v;
>>> +};
