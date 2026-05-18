Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8374CCD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 21:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22CFF846AC;
	Mon, 18 May 2026 23:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="v5Tu4H6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 496A284694; Mon, 18 May 2026 23:05:26 +0200 (CEST)
Received: from mxd-2-a08.seznam.cz (mxd-2-a08.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a08])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A610984119
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 23:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-f659df87d-k746b
 (smtpc-mxd-f659df87d-k746b [2a02:598:64:8a00::1000:a08])
 id 415c28f31a527c9a40f5e4ad; Mon, 18 May 2026 23:04:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1779138276; bh=kaiPsoY6sgDvPp66Mp47A2wVCT8aYOAusfXMOmZCIcE=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=v5Tu4H6OeYsGQlJGCzIlCjr5qHgD/fh/bOdNO7F4q2hveuip1pLlXuXUZCMmanWdR
 MDkAbmvH9JRo5MgQiKSGVLLgTybV1PUVVO80tCvOOFk+c9m5Z6jXzZ0+NNU+Xkr91K
 LYjJTcdSTFmw3kiAdSkIisbwI2gSwCyK7fRg6Qhq1vQf/xQYzvHDoNv6EQluZnGTaw
 7qhN9ycMuANxm+r2LR6HVPGZMUs4wcLrWAGN9zhV8wUg5h52rMF3s0IMlBjqgvCumv
 mEapEmHr+HR/aTSOksQaUvDEa1eKFUMC69UwfnTkhMcu+LPs1crY5E+sumhaL5dtfg
 4mvd7x033qy7g==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-745c4d9bbb-7zrbc (szn-email-smtpd/2.0.73) with ESMTPA
 id 2d08cebd-7962-499f-ab5d-886a3877a8d7;
 Mon, 18 May 2026 23:03:44 +0200
Message-ID: <90c8e27c-880e-4d27-a8e1-762a31cc4a0a@seznam.cz>
Date: Mon, 18 May 2026 23:03:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/12] mach-snapdragon: Kconfig: changes / additions to
 support SPL
To: Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
 <20260516-qcom_spl-v8-7-69b55c9abffe@seznam.cz>
 <1f639a99-7d32-4f3b-bd0b-8936cb56ea0d@linaro.org>
 <48832d44-dc85-4b23-980c-87ef686669e2@seznam.cz>
 <20260518205853.GV1858239@bill-the-cat>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <20260518205853.GV1858239@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 18 May 2026 23:35:05 +0200
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

On 5/18/26 22:58, Tom Rini wrote:
> On Mon, May 18, 2026 at 10:25:05PM +0200, Michael Srba wrote:
>> Hi,
>>
>> On 5/18/26 10:40, Casey Connolly wrote:
>>> Hi Michael,
>>>
>>> On 16/05/2026 20:19, michael.srba@seznam.cz wrote:
>>>> From: Michael Srba <Michael.Srba@seznam.cz>
>>>>
>>>> Select SUPPORT_SPL so SPL build can be enabled, disable SYSRESET_PSCI in SPL.
>>>> (SPL runs in EL3, so if SPL itself doesn't provide PSCI, nothing else will.)
>>>>
>>>> Also select (SPL_)OF_LIVE and DM_EVENT/SPL_EVENT, which are needed to fix up
>>>> upstream dt to make usb work.
>>>>
>>>> Mirror u-boot proper selections like GPIO and pinctrl to ensure consistent
>>>> behavior, and select SPL_SPRINTF, SPL_LIBCOMMON_SUPPORT etc for similar
>>>> reasons.
>>>>
>>>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>> ---
>>>>    arch/arm/Kconfig                 | 33 ++++++++++++++++++++++++++++++++-
>>>>    arch/arm/mach-snapdragon/Kconfig | 10 ++++++++++
>>>>    2 files changed, 42 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>> index 850768282ce..255d2035cdc 100644
>>>> --- a/arch/arm/Kconfig
>>>> +++ b/arch/arm/Kconfig
>>>> @@ -1136,6 +1136,7 @@ config ARCH_SNAPDRAGON
>>>>    	bool "Qualcomm Snapdragon SoCs"
>>>>    	select ARM64
>>>>    	select DM
>>>> +	select DM_EVENT if USB_DWC3_GENERIC
>>> Is there any reason not to make this uncoditional?
>> Well, my understanding is that it's only relevant if something registers
>> to receive an event. Maybe some stuff just has a slower path but would
>> benefit from this? I don't know, all I know is that the fixup has a hard
>> dependency on it.
> This seems like a USB_DWC3_GENERIC bug (missing select DM_EVENT), but
> not something you need to tackle as this is just following the existing
> way.
>
>
I added it because of the fixup that mach-snapdragon code does, which only
needs to actually work if dwc3 is enabled (because otherwise clearly usb
support is not a concern), I'm not sure if USB_DWC3_GENERIC itself needs it.
