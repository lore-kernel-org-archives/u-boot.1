Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0884E63F33
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 07:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12D968063E;
	Mon, 16 Feb 2026 08:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="hUP2d7EL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 681F080B98; Mon, 16 Feb 2026 08:49:20 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68F4D80325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 08:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4292610FF42; Mon, 16 Feb 2026 08:49:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771228156;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=S6HtIx5Nl4JVy4vcy8q7ZDT+pNsOAV1OwXQOmcQ8Rtg=;
 b=hUP2d7EL5M9i5s7QUWgZtJIvw5WCbgMSLUSjIf3KGynRiZzPb94nLPMLJYfx6HOY0CiPN0
 emTvIQ+c5vMMlyUlaT3ex3jKcmucUBqf1QF05q8XcFbvviMfQ9eQYbIjomFDr4+NMOPOqJ
 GGgrWOtu3gJR9InTT4qwk1I5LtE8OlO8lg8FiuKVVIG6mxsrf+dt2VoyDlVJca8SR9S9AR
 P+NkVRHoQOWNpu9QVMHb1OSL7VcznYZzqSZunMW+7cBQpTgsrWBBlHK98/RLQ2gd7iC06t
 5SPvD7IA/7+JBjSu913r/dSO8AAN0SuQEN26E0iZrjNrBYi69Lrj5daHL4KfiQ==
Message-ID: <13dfc63c-74bf-01c7-7050-f8f8a0079b2f@nabladev.com>
Date: Mon, 16 Feb 2026 08:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 00/11] imx8qxp: siemens: small board updates
Content-Language: en-US
To: Max Merchel <max.merchel@ew.tq-group.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Tomas Peterka <atheiste@seznam.cz>,
 Walter Schweizer <walter.schweizer@siemens.com>
References: <20260214045703.28051-1-hs@nabladev.com>
 <d91ba34a-0b64-47ee-89d6-458c7c3958e3@ew.tq-group.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <d91ba34a-0b64-47ee-89d6-458c7c3958e3@ew.tq-group.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Max,

On 16.02.26 08:33, Max Merchel wrote:
> Hi Heiko,
> 
> Am 14.02.26 um 05:56 schrieb Heiko Schocher:
>>
>> - small DTS fixes
>> - add wget and bootcounter command
>> - Environment changes
>>    - introduce protected Environment
>>    - a lot of fixes and tries to simplify environment
>>      as it has grown over the years.
>>
>> Some patches has changes in environment text file with
>> long lines, ignored the checkpatch warning for these
>> added commit note in the individual patches.
> 
> Why don't you fix the warnings in a separate commit first?
> 
> Line breaks in environment files are easy to add and significantly improve readability.
> 
> If you need an example, you can take a look at the following environment variables file:
> /board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20-a1.env

I will check and fix them, thanks for the hint!

bye,
Heiko
> 
>>
>> Changes in v2:
>> - rebased to mainline
>>    b99da05e153 - (tag: v2026.04-rc2, origin/master, origin/HEAD) Prepare v2026.04-rc2
>> - respell the commit message as Peng suggested
>> Added Reviewed-by from Peng
>> Added Reviewed-by from Peng
>> Added Reviewed-by from Peng
>> Added Reviewed-by from Peng
>> Added Reviewed-by from Peng
>> enhanced commit message
>> Added Reviewed-by from Peng
>> fixed typos in commit message and board code
>> Added Reviewed-by from Peng
>> Added Reviewed-by from Peng
>> Added Acked-by from Peng, fixed typo in commit message
>> Added small fixes in Environment from Adrian: It fixes a serious bug which
>> Adrian detect. It occurs when a broken firmware is applied as a downgrade.
>> The old bootloader ended up in an endless reboot boot loop. With this fix
>> also the old bootloader is able to reject the update and recover. Also
>> slightly reworked bootcmd.
>> Added Reviewed-by from Peng
>> Reworked writeable variable list, as we dropped patch
>> "env: add w flags for net config in explicit write mode"
>>
>> Adrian Freihofer (3):
>>    siemens: capricorn: set max-frequency for usdhc1
>>    siemens: capricorn: rework bootcmd environment variables
>>    siemens: capricorn: protect environment
>>
>> Heiko Schocher (3):
>>    capricorn: config: add bootcounter command
>>    siemens: capricorn: add logic to U-Boot to avoid zig-zag boot
>>    siemens: capricorn: always detect emmc device
>>
>> Lukas Stockmann (3):
>>    arm: dts: capricorn: pinctrl_usdhc1 cleanup
>>    arm: dts: capricorn: remove pinctrl_usdhc2
>>    arm: dts: capricorn: move fec2 config
>>
>> Walter Schweizer (2):
>>    imx8qxp_capricorn config: add wget command
>>    siemens: capricorn: fix fallback bootm call for fitImage
>>
>>   arch/arm/dts/imx8-capricorn-cxg3.dts          | 44 ++++++++++++++
>>   arch/arm/dts/imx8-capricorn.dtsi              | 60 +------------------
>>   board/siemens/capricorn/Kconfig               |  2 +
>>   board/siemens/capricorn/board.c               | 56 ++++++++++-------
>>   board/siemens/capricorn/capricorn_default.env | 17 +++---
>>   configs/imx8qxp_capricorn.config              |  3 +
>>   include/configs/capricorn-common.h            | 13 ++++
>>   7 files changed, 106 insertions(+), 89 deletions(-)
>>
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
