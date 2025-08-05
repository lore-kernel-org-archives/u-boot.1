Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19FBC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 11:57:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46D988350A;
	Tue,  5 Aug 2025 13:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754395036;
	bh=E+MXiXt9tzf+18R7zcBvmaisKem7KfOOrMmDqln6aVE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=l0zOz4HhVkRllEGWVrdQRNAWJUVTENXIEOqK7WBqoCann5F2weBEBgDMbBEWjwqxq
	 dPYYrlbET6xSodaizy56Q5LRM2vD3aGsxPBenZJ2F365sXe9fBWbSmZzsuEcmmCDtB
	 g2HOddgtIIayVBTJ6G0TMOhxEDe9Psy+otk9WUIlJBdRNxdlLFg8gs9mBqzicnAOYr
	 /g6xcDHf0gLPeDOJyYUvs12KHoasMVj8yVSXQSZs1v/oTuulQx8/7+9tK1MS2IMBzi
	 LGlhueocJPjhHaLTfLw1hzmBRrQfLtjySIYsERb56yM5HU8aebv0sIfGGQayB5pHMQ
	 7KP22yYtK1RdA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB71983526; Tue,  5 Aug 2025 13:57:14 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D90DA82BCD
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="R9pdYbrX"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 543291038C126; 
 Tue,  5 Aug 2025 13:57:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754395026;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=E+MXiXt9tzf+18R7zcBvmaisKem7KfOOrMmDqln6aVE=;
 b=R9pdYbrXwErZEt/ZS7aeO2E7+fc36wS7xHjxc+F1sKRoJfwWd3pPt99Kl8X0xyGd3HMZZ5
 2a/w0rWdtr2EQgb56vp02BZhGHGozSzSYomF6HjY8Syckesvadi5kPLXTCKwPSuzny2ktp
 r4wMFMoPR3kH0KFMCClg5swRaXhaOquVeUV11JLHN91uNyoXQRod74h2abrZNIe6iVPVDw
 JpnFb+9LAcpUiqhxsQRl39Nho8C2L384iG2ZjpB6FOidIiOJx6NkIaLnwXDOdthyTUM7zd
 YJdVIb3JS25P1B0QyzFcBQuzaq9x4LKLp1V5165ZYQ1aw51TchxnHKKDo70WDQ==
Message-ID: <f86a86ec-2440-60c8-2378-e6bd4f8a0ade@denx.de>
Date: Tue, 5 Aug 2025 13:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 00/12] Add Synopsys MIPI I3C Driver support
Content-Language: en-US
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, Jonas Karlman
 <jonas@kwiboo.se>, Sebastian Reichel <sebastian.reichel@collabora.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "Lim, Jit Loon" <jit.loon.lim@altera.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
 <PH7PR03MB69423C4746FB6E025F699C89F75AA@PH7PR03MB6942.namprd03.prod.outlook.com>
 <PH7PR03MB694215367A1A2EC1A66A755FF723A@PH7PR03MB6942.namprd03.prod.outlook.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <PH7PR03MB694215367A1A2EC1A66A755FF723A@PH7PR03MB6942.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Dinesh,

On 04.08.25 06:20, Maniyam, Dinesh wrote:
> Hi @Heiko Schocher
> 
>> -----Original Message-----
>> From: Maniyam, Dinesh
>> Sent: Monday, 28 July 2025 3:01 pm
>> To: u-boot@lists.denx.de; Heiko Schocher <hs@denx.de>
>> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
>> Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Dario
>> Binacchi <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
>> <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
>> Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
>> <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
>> Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
>> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
>> Reichel <sebastian.reichel@collabora.com>; Chee, Tien Fong; Hea, Kok Kiang; Ng,
>> Boon Khai; Yuslaimi, Alif Zakuan; Lim, Jit Loon; Maniyam, Dinesh
>> <dinesh.maniyam@intel.com>
>> Subject: RE: [PATCH v7 00/12] Add Synopsys MIPI I3C Driver support
>>
>> Hi @Heiko Schocher
>>
>>> -----Original Message-----
>>> From: Maniyam, Dinesh <dinesh.maniyam@altera.com>
>>> Sent: Monday, 28 July 2025 2:56 pm
>>> To: u-boot@lists.denx.de
>>> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
>>> Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Heiko
>>> Schocher <hs@denx.de>; Dario Binacchi
>>> <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
>>> <ilias.apalodimas@linaro.org>; Heinrich Schuchardt
>>> <xypron.glpk@gmx.de>; Jerome Forissier <jerome.forissier@linaro.org>;
>>> Mattijs Korpershoek <mkorpershoek@baylibre.com>; Ibai Erkiaga
>>> <ibai.erkiaga-elorza@amd.com>; Michal Simek <michal.simek@amd.com>;
>>> Dmitry Rokosov <ddrokosov@salutedevices.com>; Jonas Karlman
>>> <jonas@kwiboo.se>; Sebastian Reichel
>>> <sebastian.reichel@collabora.com>; Chee, Tien Fong
>>> <tien.fong.chee@altera.com>; Hea, Kok Kiang
>>> <kok.kiang.hea@altera.com>; Maniyam, Dinesh
>>> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
>>> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Lim, Jit Loon
>>> <jit.loon.lim@altera.com>; Dinesh Maniyam <dinesh.maniyam@intel.com>
>>> Subject: [PATCH v7 00/12] Add Synopsys MIPI I3C Driver support
>>>
>>> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>>>
>>> This patchset add Synopsys MIPI I3C Driver support for Intel Agilex5 devices.
>>>
>>> The i3c driver is leveraged from the master/dw-i3c-master.c,
>>> i3c/device.c and i3c/master.c Linux version 6.6.37 LTS And few header
>>> files included to be part of the migration; i3c/internals.h,
>>> include/linux/i3c/ccc.h, include/linux/i3c/device.h and
>> include/linux/i3c/master.h.
>>> Additional i3c uclass driver and command files added to support i3c
>>> read and write in U-Boot.
>>>
>>> Patch status:
>>>
>>> Detail changelog can find in commit message.
>>>
>>> v7->v6:
>>> --------
>>> - Remove extra variable in struct udevice
>>> - reuse the existing dev_ofnode to get the node in  master.c
>>>
>>> v6->v5:
>>> --------
>>> - Resolved documentation warning in include/i3c.h
>>> - Move declarations to the top in cmd/i3c.c functions
>>>
>>> v5->v4:
>>> --------
>>> - Add header file to doc/api/i3c
>>> - Rephrase function description for i3c.h
>>> - Separated subcommand as a function for cmd/i3c.c
>>> - Used memory address to transfer msgs from i3c
>>> - Rephrase description in cmd/i3c.rst file
>>> - Replaced int with unsigned for positive variables.
>>>
>>> v4->v3:
>>> --------
>>> Resolve ci test:
>>> - Add i3c node in index.rst
>>> - Formating error in i3c.rst
>>> - Resolve cpu_relax undefined for sandbox
>>>
>>> v3->v2:
>>> --------
>>> - Squash commit 10 to commit 9
>>> - Resolve index for new files to pass the checkpatch
>>>
>>> Commit: sandbox_defconfig: Enable configs for sandbox i3c
>>> Commit: agilex5_defconfig: Enable i3c configs for agilex5
>>> - use savedefconfig
>>>
>>> drivers: Enabled Kconfig and Makefile for i3c support
>>> - Add maintainer for i3c
>>>
>>> drivers: i3c: Enabled Kconfig and Makefile for DWI3C
>>> - Add empty lines for if/endif
>>>
>>> drivers: i3c: Add i3c sandbox simple test.
>>> - Removed DECLARE_GLOBAL_DATA_PTR
>>>
>>> v1->v2:
>>> --------
>>> Reorder commits.
>>>
>>> Added commits:
>>> - drivers: i3c: Add i3c sandbox simple test.
>>> - test: cmd: Add simple test for i3c
>>> - configs: sandbox_defconfig: Enable configs for sandbox i3c
>>> - configs: agilex5_defconfig: Enable i3c configs for agilex5
>>>
>>> History:
>>> --------
>>> [v1]:
>>> https://patchwork.ozlabs.org/project/uboot/cover/20250218025705.50051-
>>> 1-
>>> dinesh.maniyam@intel.com/
>>> [v2]:
>>> https://patchwork.ozlabs.org/project/uboot/cover/20250314040902.43621-
>>> 1-
>>> dinesh.maniyam@altera.com/
>>> [v3]:
>>> https://patchwork.ozlabs.org/project/uboot/cover/20250324083704.26259-
>>> 1-
>>> dinesh.maniyam@altera.com/
>>> [v4]:
>>> https://patchwork.ozlabs.org/project/uboot/cover/20250417021840.6212-
>>> 1-dinesh.maniyam@altera.com/
>>> [v5]:
>>> https://patchwork.ozlabs.org/project/uboot/cover/20250513101913.30880-
>>> 1-
>>> dinesh.maniyam@altera.com/
>>> [v6]:
>>> https://patchwork.ozlabs.org/project/uboot/cover/20250513101913.30880-
>>> 1-
>>> dinesh.maniyam@altera.com/
>>>
>>> Dinesh Maniyam (12):
>>>    drivers: i3c: Add new i3c uclass id
>>>    drivers: i3c: Add driver for MIPI DWI3C
>>>    drivers: i3c: Add i3c uclass driver.
>>>    drivers: Enabled Kconfig and Makefile for i3c support
>>>    drivers: i3c: Enabled Kconfig and Makefile for DWI3C
>>>    drivers: i3c: Add i3c sandbox simple test.
>>>    drivers: i3c: master: Enable probe i3c without slave device
>>>    i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
>>>    cmd: Add i3c command support.
>>>    test: cmd: Add simple test for i3c
>>>    configs: sandbox_defconfig: Enable configs for sandbox i3c
>>>    configs: agilex5_defconfig: Enable i3c configs for agilex5
>>>
>>>   MAINTAINERS                        |    7 +
>>>   arch/sandbox/dts/test.dts          |    8 +
>>>   cmd/Kconfig                        |    6 +
>>>   cmd/Makefile                       |    1 +
>>>   cmd/i3c.c                          |  271 ++++
>>>   configs/sandbox_defconfig          |    4 +
>>>   configs/socfpga_agilex5_defconfig  |    3 +
>>>   doc/api/i3c.rst                    |    8 +
>>>   doc/api/index.rst                  |    1 +
>>>   doc/usage/cmd/i3c.rst              |  146 ++
>>>   doc/usage/index.rst                |    1 +
>>>   drivers/Kconfig                    |    2 +
>>>   drivers/Makefile                   |    1 +
>>>   drivers/i3c/Kconfig                |   27 +
>>>   drivers/i3c/Makefile               |    5 +
>>>   drivers/i3c/device.c               |  262 ++++
>>>   drivers/i3c/i3c-uclass.c           |   38 +
>>>   drivers/i3c/internals.h            |   26 +
>>>   drivers/i3c/master.c               | 2066 ++++++++++++++++++++++++++++
>>>   drivers/i3c/master/Kconfig         |   11 +
>>>   drivers/i3c/master/Makefile        |    3 +
>>>   drivers/i3c/master/dw-i3c-master.c | 1062 ++++++++++++++
>>>   drivers/i3c/sandbox_i3c.c          |   56 +
>>>   include/dm/uclass-id.h             |    1 +
>>>   include/dw-i3c.h                   |  252 ++++
>>>   include/i3c.h                      |   93 ++
>>>   include/linux/i3c/ccc.h            |  385 ++++++
>>>   include/linux/i3c/device.h         |  286 ++++
>>>   include/linux/i3c/master.h         |  698 ++++++++++
>>>   test/cmd/Makefile                  |    1 +
>>>   test/cmd/i3c.c                     |   50 +
>>>   test/dm/Makefile                   |    1 +
>>>   test/dm/i3c.c                      |   34 +
>>>   33 files changed, 5816 insertions(+)
>>>   create mode 100644 cmd/i3c.c
>>>   create mode 100644 doc/api/i3c.rst
>>>   create mode 100644 doc/usage/cmd/i3c.rst  create mode 100644
>>> drivers/i3c/Kconfig  create mode 100644 drivers/i3c/Makefile  create
>>> mode
>>> 100644 drivers/i3c/device.c  create mode 100644
>>> drivers/i3c/i3c-uclass.c  create mode 100644 drivers/i3c/internals.h
>>> create mode 100644 drivers/i3c/master.c create mode 100644
>>> drivers/i3c/master/Kconfig  create mode 100644
>>> drivers/i3c/master/Makefile  create mode 100644
>>> drivers/i3c/master/dw-i3c- master.c  create mode 100644
>>> drivers/i3c/sandbox_i3c.c  create mode 100644 include/dw-i3c.h  create
>>> mode 100644 include/i3c.h  create mode 100644 include/linux/i3c/ccc.h
>>> create mode 100644 include/linux/i3c/device.h  create mode 100644
>>> include/linux/i3c/master.h  create mode 100644 test/cmd/i3c.c create
>>> mode 100644 test/dm/i3c.c
>>>
>>> --
>>> 2.35.3
>>
>> As discussed earlier, I have made changes to pass the ci.
>> CI is passing now for me.
>>
>> https://github.com/u-boot/u-boot/pull/802/checks?check_run_id=46661813275
>>
>> Thanks
>> Dinesh
> 
> Did you manage to pull in my patchseries, please let me know the status

Please fix some small nitpicks from me and askar... than I think, it
can go in from my side

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
