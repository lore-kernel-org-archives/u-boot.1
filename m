Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA06D32D92
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 11:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF7E1893B6;
	Tue, 12 Nov 2024 12:18:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="tVfoG3lW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B0389422; Tue, 12 Nov 2024 12:18:20 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E2AB891B0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 12:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1731410296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NicNYnFHDEtqjrr4LKzgBDn33dP7tIAD9AzCxWSFIg0=;
 b=tVfoG3lWv3pQVynBS13gDX69Bac/eSa1tFOGe7FiDcQlE9A4s2un88iA4abfv6gCHVy+zg
 MYRonGt472h7WMUFWmM742dQog5wEPTNx5cr2vzUW/bn9Vd8hsp+S4ij26JjnHM/ktr8a7
 YtHbttmTOD0lfoBZ3QKhDKKXL6pcdA5HMvDCRUOl/bAmd3ct/FG//CJwH45Kf4kzq7l1lY
 6RnDl4eOWSfiAnl5ErggkBc04BtQjMe5zSGF9FiWqC2gXF0m0/ptYgHVjbbwgxQSxMLXjV
 csrVq2RLqOT2ZrgFfnq6OqYS8bJdyGdkiMQAfHFYHJvrJqMfu3IDt2UM3h3d+A==
Date: Tue, 12 Nov 2024 12:18:15 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Paul Kocialkowski <paulk@sys-base.io>, Quentin Schulz
 <quentin.schulz@cherry.de>, Quentin Schulz <foss+uboot@0leil.net>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Klaus Goger <klaus.goger@cherry.de>,
 u-boot@lists.denx.de, Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH next v2 4/4] rockchip: rk3399: move sysreset-gpio logic to
 TPL
In-Reply-To: <33edc0c5-29ea-4857-ac60-569c39102f57@rock-chips.com>
References: <20241106-rk3399-sysreset-gpio-tpl-v2-0-22aa82189eb6@cherry.de>
 <20241106-rk3399-sysreset-gpio-tpl-v2-4-22aa82189eb6@cherry.de>
 <149361d4-4cbb-4007-b00f-6b4efbd7978f@rock-chips.com>
 <5cfa0fbe-5003-4da1-9933-7664da07cd4d@cherry.de> <ZyyyNttkdcdQmmCw@collins>
 <33edc0c5-29ea-4857-ac60-569c39102f57@rock-chips.com>
Message-ID: <7264b5a4139620711c68ca36b1b12fc0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Kever,

On 2024-11-08 01:50, Kever Yang wrote:
> On 2024/11/7 20:27, Paul Kocialkowski wrote:
>> Le Thu 07 Nov 24, 12:04, Quentin Schulz a écrit :
>>> On 11/7/24 8:14 AM, Kever Yang wrote:
>>>> Yes, this movement is reasonable and needed for this workaround,
>>>> although still not
>>>> 
>>>> understand why puma board need this.
>>> Me neither, this predates me joining the company, c.f.:
>>> https://source.denx.de/u-boot/u-boot/-/commit/ae0d33a7291a164a11ae034bcf4f71226b2bef48
>>> https://source.denx.de/u-boot/u-boot/-/commit/5f104178bf713615dc404fdfcf0fb53d89c66a07
>>> https://source.denx.de/u-boot/u-boot/-/commit/07586ee4322abca01db52624b925e5218538f259
>>> 
>>> What I can tell you is that it seems this is required as Paul (in Cc) 
>>> is
>>> trying to add support for it for the Firefly ROC-RK3399-PC[1] and the
>>> ROCKPro64[2], so it seems it's useful for **some** purpose.
>> The initial issue I was seeing was that one of the MMC controllers 
>> showed some
>> errors and failed to read data after reboot, while it always worked on 
>> cold
>> boot. With this feature enabled, it worked reliably after reboot.
>> 
>> I didn't investigate exactly which component (maybe clocks, maybe 
>> regulators)
>> caused the problem, but it clearly wasn't correctly reset.
> 
> Are you able to check, how is the 'reboot' happen, does it use the
> system_reset API from the ATF?
> 
> Because there are some operations for clock and PD before trigger the
> global reset in ATF driver and the code is very stable and used for
> millions of devices.

The Linux kernel performs resets using PSCI_0_2_FN_SYSTEM_RESET
made available by TF-A, which ends up using GLB_SRST_FST_CFG_VAL,
also known as the RK3390's global software reset 1, which I'll
describe a bit further later in my response.

In this particular case and to the best of my knowledge, it isn't
up to the way the SoC reset is initiated and performed, but up to
the way RK3399 (mis)performs the global software reset 1.

Here's a quotation from arch/arm/mach-rockchip/rk3399/rk3399.c
that explains this issue a bit further:

   /*
    * The RK3399 resets only 'almost all logic' (see also in the
    * TRM "3.9.4 Global software reset"), when issuing a software
    * reset. This may cause issues during boot-up for some
    * configurations of the application software stack.
    *
    * To work around this, we test whether the last reset reason
    * was a power-on reset and (if not) issue an overtemp-reset to
    * reset the entire module.
    *
    * While this was previously fixed by modifying the various
    * places that could generate a software reset (e.g. U-Boot's
    * sysreset driver, the ATF or Linux), we now have it here to
    * ensure that we no longer have to track this through the
    * various components.
    */

The logic associated with this comment, currently residing in
arch/arm/mach-rockchip/rk3399/rk3399.c, was actually introduced
in the commit ae0d33a7291a (rockchip: rk3399-puma: add code to
allow forcing a power-on reset, 2017-11-28).

As described in section 3.4 of the RK3399 TRM, part 1 of the
version 1.1, the RK3399 provides two global software reset types,
out of which TF-A, as already described, properly performs the
global software reset 1.  Alas, section 3.9.4 of the RK3399 TRM
specifies that "almost all logic" gets reset, which is the source
of all troubles, resulting in the need to perform hardware resets
using (or better said, abusing a bit) the PMIC's overtemperature
protection (OTP) interface/pin.

I hope all this makes sense.

>>> [1] 
>>> https://lore.kernel.org/u-boot/20240926183111.1324284-1-paulk@sys-base.io/
>>> [2] 
>>> https://lore.kernel.org/u-boot/20240926183111.1324284-2-paulk@sys-base.io/
>>> 
>>>>> - faster boot time as we don't need to reach SPL to be able to 
>>>>> reset the
>>>>>     system on a condition we know is already met in TPL,
>>>>> - have less code to be impacted by the issue this system reset 
>>>>> works
>>>>>     around (that is, "unclean" SoC registers after a reboot),
>>>>> - less confusion around the reason for restarting. Indeed when done 
>>>>> from
>>>>>     SPL, the following log can be observed:
>>>>> 
>>>>> """
>>>>> U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 
>>>>> 15:31:45)
>>>>> Channel 0: DDR3, 666MHz
>>>>> BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
>>>>> Channel 1: DDR3, 666MHz
>>>>> BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
>>>>> 256B stride
>>>>> Trying to boot from BOOTROM
>>>>> Returning to boot ROM...
>>>>> 
>>>>> U-Boot SPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 -
>>>>> 15:31:45 +0100)
>>>>> Trying to boot from MMC2
>>>>> 
>>>>> U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 
>>>>> 15:31:45)
>>>>> """
>>>> So with this patch set, we can see the TPL banner twice ?
>>>> 
>>>> 
>>>> PS: We are able to merge to master instead of next before next 
>>>> branch is
>>>> open, because we still have
>>>> 
>>>> enough time to debug before next release.
>>>> 
>>> My understanding is that once -rc1 is out, we should only do bug 
>>> fixing in
>>> master. BUT at the same time, next branch isn't actually open until 
>>> -rc2.
>>> 
>>> Up to you! It's not really urgent, Puma was migrated to TPL only in 
>>> v2023.01
>>> and we've lived without sysreset-gpio in TPL since then :)
