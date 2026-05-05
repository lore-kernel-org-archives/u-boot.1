Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E03CCD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 17:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 869DA849CB;
	Tue,  5 May 2026 19:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="ySD8OrOO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66881849A4; Tue,  5 May 2026 19:02:01 +0200 (CEST)
Received: from mxd-3-701.seznam.cz (mxd-3-701.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60AC18497A
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 19:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5f4d8d5f6f-gj4cr
 (smtpc-mxd-5f4d8d5f6f-gj4cr [2a02:598:96:8a00::1200:701])
 id 131e4cd2481018bb12b7808c; Tue, 05 May 2026 19:01:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778000476; bh=493gGefwJW/7TZHSw7gpLU4l/s8e0CxGaoamnvS4mm0=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=ySD8OrOO/z8zZ6SmMg7QhVPv3U+yFts9JT67yeckKmU/cXpdwczKWwIRf8FL2p4xV
 Beutw66JjLE3AGb0pN1odLPRAYDdAZymNhtW/wu24EC2srrTgN4Nedcv4LxDFQOWGl
 UGqAGqff0jdV1aTp0SMc8kHJ3gclDkUR6rr6YOOGoxtabVmRENE0NMtmhdKFQA5zHn
 +wRc+I3wRnl9pcnG/rd6XNAx/vR1Ylj5SIHx+p7K0iTlkEAr61sxlnpkclsv4APSmG
 7WqJDlTmlMxeQe0WpFgK/YYaC3aYyIky7jZJbcFpOwtjMx5XH5E1F4kh7gg8sDE/g6
 dNX6nbls48Tdw==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-7c7c659656-4rdhd (szn-email-smtpd/2.0.72) with ESMTPA
 id 3a1c1cd2-2b8c-4304-8309-80d3bfffea88;
 Tue, 05 May 2026 19:01:03 +0200
Message-ID: <be758491-53be-438b-beaa-fb67ed2f2728@seznam.cz>
Date: Tue, 5 May 2026 19:01:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/11] mach-snapdragon: boot0.h: split out
 msm8916_boot0.h
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
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
 Michael Trimarchi <michael@amarulasolutions.com>, Andrew Davis <afd@ti.com>
References: <20260505-qcom_spl-v5-0-11817415d664@seznam.cz>
 <20260505-qcom_spl-v5-4-11817415d664@seznam.cz>
 <CAFLszThNdiVOs5+q=tVZLxfr14_vxrjYA6rZ-=4J=9T6MAQfGg@mail.gmail.com>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <CAFLszThNdiVOs5+q=tVZLxfr14_vxrjYA6rZ-=4J=9T6MAQfGg@mail.gmail.com>
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

On 5/5/26 16:00, Simon Glass wrote:
> Hi Michael,
>
> On 2026-05-05T00:47:48, Michael Srba <michael.srba@seznam.cz> wrote:
>> mach-snapdragon: boot0.h: split out msm8916_boot0.h
>>
>> Prepare for supporting alternative boot0.h per-SoC by splitting out
>> the existing msm8916-specific code.
>>
>> There is now a selection mechanism to choose a specific boot0.h
>> in the Kconfig. BOOT0_MSM8916_PSCI_WORKAROUND is the only option
>> right now, but more can be added. The toplevel boot0.h additionally
>> enables conditionally performing the include only in u-boot proper,
>> or only in SPL.
>>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>>
>> arch/arm/mach-snapdragon/Kconfig                   | 16 ++++++
>>   arch/arm/mach-snapdragon/include/mach/boot0.h      | 58 +++-------------------
>>   .../mach-snapdragon/include/mach/msm8916_boot0.h   | 54 ++++++++++++++++++++
>>   configs/dragonboard410c_defconfig                  |  1 +
>>   4 files changed, 77 insertions(+), 52 deletions(-)
>> diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
>> @@ -1,54 +1,8 @@
>>   /* SPDX-License-Identifier: GPL-2.0+ */
>> +#if defined(CONFIG_SPL_BUILD)
>>        b       reset
>> +#else
>> +#if defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
>> +#include 'msm8916_boot0.h'
>> +#endif
>> +#endif
> When neither CONFIG_SPL_BUILD nor BOOT0_MSM8916_PSCI_WORKAROUND is
> set, this expands to nothing, so start.S falls through into _TEXT_BASE
> etc. Is that intended?
hm, no, it should definitely be `b reset`... my bad, will fix it
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Regards,
> Simon

