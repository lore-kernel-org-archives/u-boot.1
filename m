Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E353CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 22:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC9A846F2;
	Wed, 20 May 2026 00:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="fdp3uXrC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F3B784705; Wed, 20 May 2026 00:15:18 +0200 (CEST)
Received: from mxd-3-706.seznam.cz (mxd-3-706.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:706])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EA64846B4
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 00:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-85fb448c55-l247v
 (smtpc-mxd-85fb448c55-l247v [2a02:598:96:8a00::1200:706])
 id 0b3bc6fd503592940a920aa3; Wed, 20 May 2026 00:13:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1779228839; bh=ZZ1d1C6kQRAEDvsJV9oHZV0EdIR8walvsarbFJ39L+o=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=fdp3uXrCGlMF2hPDMKKJFBuOnCELsY7uBDFc3g8zTm1ZLRRiFxHtk9WK+t7ZK66j0
 FvVxJcn/HKRq8BEfV3uA05VQQFpTWHmNQ6aWv0/uWeHnbrPtD4nQ2NFa90WpABFzoo
 rKja9Xa4SaSwf66nf4yLrnyX2f6W31Y+6Jtc6l5otwkNQL7zTxSP4czZOhxIs6wB+m
 rcS/4SKxU4p14NPwn7NBijiLAMkmv1sUHrxNNu2CBBfiQuKilnTuyX7/C2Xfh+ydKl
 QuMlQhH/o8dn+0W+BQIpAwt42TRpYjJ/2aPBur9tvylZYDMU6inGtjYIdFAyNT26/I
 i77We+gi50fOg==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-745c4d9bbb-4gnxc (szn-email-smtpd/2.0.73) with ESMTPA
 id ef40646b-f943-410c-adfb-d8d155de76a6;
 Wed, 20 May 2026 00:13:07 +0200
Message-ID: <9988717e-7ce5-4a51-8424-f91cf2e16b55@seznam.cz>
Date: Wed, 20 May 2026 00:13:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/12] mach-snapdragon: Kconfig: changes / additions to
 support SPL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
 <20260516-qcom_spl-v8-7-69b55c9abffe@seznam.cz>
 <20260519172225.GD1858239@bill-the-cat>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <20260519172225.GD1858239@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 20 May 2026 00:29:14 +0200
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

Hi,

On 5/19/26 19:22, Tom Rini wrote:
> On Sat, May 16, 2026 at 08:19:56PM +0200, michael.srba@seznam.cz wrote:
>
>> From: Michael Srba <Michael.Srba@seznam.cz>
>>
>> Select SUPPORT_SPL so SPL build can be enabled, disable SYSRESET_PSCI in SPL.
>> (SPL runs in EL3, so if SPL itself doesn't provide PSCI, nothing else will.)
>>
>> Also select (SPL_)OF_LIVE and DM_EVENT/SPL_EVENT, which are needed to fix up
>> upstream dt to make usb work.
>>
>> Mirror u-boot proper selections like GPIO and pinctrl to ensure consistent
>> behavior, and select SPL_SPRINTF, SPL_LIBCOMMON_SUPPORT etc for similar
>> reasons.
>>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>>   arch/arm/Kconfig                 | 33 ++++++++++++++++++++++++++++++++-
>>   arch/arm/mach-snapdragon/Kconfig | 10 ++++++++++
>>   2 files changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 850768282ce..255d2035cdc 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1136,6 +1136,7 @@ config ARCH_SNAPDRAGON
>>   	bool "Qualcomm Snapdragon SoCs"
>>   	select ARM64
>>   	select DM
>> +	select DM_EVENT if USB_DWC3_GENERIC
>>   	select DM_GPIO
>>   	select DM_SERIAL
>>   	select DM_RESET
> After looking in to what's going on here more, this should be:
> 	select EVENT if OF_LIVE
>
> And is a standalone bug fix. The event in question here lives in
> arch/arm/mach-snapdragon/of_fixup.c and is for both USB things and
> OP-TEE things
That's probably new stuff since I looked at it
>   (so USB_DWC3_GENERIC is wrong), but desired even if U-Boot
> doesn't use USB as the linux kernel will consume this device tree, if I
> recall correctly.
I think the USB fixup is explicitly not supposed to be passed to Linux,
since it's just a workaround for the driver not falling back to usb 2.0
only operation (and some issue with usb3 operation, don't recall
the exact details). IIRC the code works on a copy or something
of the sort.
Not sure if the op-tee things are supposed to be passed to Linux
or not though.
>   But next, this only fires on EVT_OF_LIVE_BUILT and not
> one of EVT_DM_POST_INIT_[FR] which is what DM_EVENT gates.
>
> All of that said, what exactly is the failure to build you saw in your
> series, without the above? I do worry there's something else further
> going on here. Thanks!
>
Hm, EVT_OF_LIVE_BUILT definitely needed SPL_EVENT to work in SPL, maybe I accidentally added DM_EVENT when I was debugging that and then later I assumed I added it on purpose? I don't think it was a compilation failure, since even SPL_EVENT not existing didn't cause that, it just caused lack of working usb.
Maybe I intended to `select EVENT` instead... and DM_EVENT selects that transitively, so I may have originally selected that in menuconfig thinking "I'll do it properly later"... I really should remember why and what I did, but oh well, hope my educated guesses are of use. I hope you didn't waste much time on this since I really feel like it should've been `select EVENT`, especially in retrospect, and again I don't think it was a build failure, just the fixup callback didn't get executed (fwiw I only tested in SPL, and I assume it does get executed in u-boot proper at least in the cases where it was tested by others, but without `select EVENT` I'm not sure how)
