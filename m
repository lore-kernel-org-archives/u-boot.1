Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BE1FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 17:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C23EF849D8;
	Tue,  5 May 2026 19:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="MHW3ng22";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F8C84882; Tue,  5 May 2026 19:21:34 +0200 (CEST)
Received: from mxd-1-a0f.seznam.cz (mxd-1-a0f.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:a0f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29E9E8467E
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 19:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5f4d8d5f6f-lmwqj
 (smtpc-mxd-5f4d8d5f6f-lmwqj [2a02:598:128:8a00::1000:a0f])
 id 681daa313313fe5869b4666f; Tue, 05 May 2026 19:20:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778001645; bh=g99FYT7hPlS7/W3ZBKs0pTb0fGObq9szexHWXsUU9/s=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=MHW3ng22AQbILHW8oXTZ0kikceEIeRrf0bDW4+ZzAR0CUVeUu3r6Yy9OyBcN3O141
 BMaTHAedgu9eDUEy0IGBRbqefafuCW3kRKJcsm+9N7efcL7AxrTXuxxIIo8QN7ZdP6
 Lk9hSqPf7JtOy4DWNvcWQhFJ//2rrvboNEPeSGq9vb4mTNYCYeVvs4o+fBc79gALOf
 O81XMsJORNS9NF8WdZX26o5I3TAyeZdyQUK84xYhnuOGzH2HmjL1eNBMQT6Q9y7mLJ
 U/8G5loRFMQyogXSCfoabZaHpNj9z1KdXftm/3/aRxzs+w1uc41UrIkLsW6tzhnfU7
 qEepTRz/aBVqQ==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-6597cc8696-jnjgp (szn-email-smtpd/2.0.72) with ESMTPA
 id 72142980-6b2a-4b6d-8ac2-cbf9d76aa7d8;
 Tue, 05 May 2026 19:20:00 +0200
Message-ID: <51026c36-deae-4f80-9247-fab9c6fff518@seznam.cz>
Date: Tue, 5 May 2026 19:19:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/11] mach-snapdragon: Kconfig: changes / additions to
 support SPL
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
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
References: <20260505-qcom_spl-v5-0-11817415d664@seznam.cz>
 <20260505-qcom_spl-v5-7-11817415d664@seznam.cz>
 <CAFLszTjUniOCbnGdR9_d8HmQrt8SFV_u8dDonPvOEyCeOUZCTA@mail.gmail.com>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <CAFLszTjUniOCbnGdR9_d8HmQrt8SFV_u8dDonPvOEyCeOUZCTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 05 May 2026 19:58:20 +0200
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

On 5/5/26 16:02, Simon Glass wrote:
> Hi Michael,
>
> On 2026-05-05T00:47:48, Michael Srba <michael.srba@seznam.cz> wrote:
>> mach-snapdragon: Kconfig: changes / additions to support SPL
>>
>> Select SUPPORT_SPL so SPL build can be enabled, disable SYSRESET_PSCI in SPL.
>> (SPL runs in EL3, so if SPL itself doesn't provide PSCI, nothing else will.)
>>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>>
>> arch/arm/Kconfig                 | 34 +++++++++++++++++++++++++++++++++-
>>   arch/arm/mach-snapdragon/Kconfig | 10 ++++++++++
>>   2 files changed, 43 insertions(+), 1 deletion(-)
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> @@ -1149,9 +1150,40 @@ config ARCH_SNAPDRAGON
>>        select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
>>        select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
>>        select SYSRESET
>> -     select SYSRESET_PSCI
>> +     select SYSRESET_PSCI if !SPL
>>        select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>>        select MMU_PGPROT
>> +     select SUPPORT_SPL
>> +
>> +     select OF_LIVE if USB_DWC3_GENERIC
>> +     select SPL_OF_LIVE if SPL_USB_DWC3_GENERIC
>> +     select ARMV8_SPL_EXCEPTION_VECTORS if SPL
> The commit message only mentions SUPPORT_SPL and SYSRESET_PSCI, but
> this hunk adds ~30 selects plus default overrides in
> mach-snapdragon/Kconfig. Please expand the message to cover the rest -
> in particular the OF_LIVE/SPL_OF_LIVE and DM_EVENT/SPL_EVENT
> selections gated on (SPL_)USB_DWC3_GENERIC are not obvious; readers
> will want to know what breaks without them.
>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> @@ -1135,6 +1135,7 @@ config ARCH_SNAPDRAGON
>>        bool "Qualcomm Snapdragon SoCs"
>>        select ARM64
>>        select DM
>> +     select DM_EVENT if USB_DWC3_GENERIC
> Just to check - does u-boot proper genuinely need DM_EVENT/OF_LIVE
> pulled in by USB_DWC3_GENERIC, or is this only required for SPL? DWC3
> has worked on Snapdragon without these so far. If it's only an SPL
> requirement, the proper-side selects should drop.
The dt fixup for usb needs it, it registers a callback on an event and
proceeds to patch the dt. I'm not sure if it's needed on absolutely every
SoC, but the code does get compiled on every SoC so it might as well work.
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> @@ -1149,9 +1150,40 @@ config ARCH_SNAPDRAGON
>> +     select SPL_OF_REAL if SPL
>> +     select SPL_OF_CONTROL if SPL
> SPL_OF_REAL is already selected by SPL_OF_CONTROL (when
> SPL_OF_PLATDATA is not set) in dts/Kconfig, so this line is redundant.
> Also swap the order so SPL_OF_CONTROL comes first, since that's the
> option doing the work.
uhm, so do you prefer removing SPL_OF_REAL or swapping the lines around?
"this is redundant" and "it should be swapped" are mixed signals...
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Regards,
> Simon

