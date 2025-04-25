Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EDAC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 17:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECA2382958;
	Fri, 25 Apr 2025 19:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m/EmtQ/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE948291D; Fri, 25 Apr 2025 19:36:16 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0232E82998
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 19:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PHa9642214665
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 12:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745602569;
 bh=M3Unc5OnoEv/Rl7g2ct1ycqFl6K0h4wsv/RovgS49gg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=m/EmtQ/QP4+z4uue1Asyc03tcXWWkJQx9a3tVdJL7V+n4kArRZTFsQKd3V3n39zoo
 q0CHpIaUuiG0WdnpeUngrW2eQfeOjHaaJD4MjWLNy8tFAART4rBkCDhaiWra/02Qqa
 BCcW+ekmTVGY/VOl9LAbOIlZv/hLjUOAk3nQGx+M=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PHa9Na126341
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 12:36:09 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 12:36:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 12:36:09 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PHa8ed115844;
 Fri, 25 Apr 2025 12:36:08 -0500
Message-ID: <574b65f8-f319-433a-844f-a3737394bb8a@ti.com>
Date: Fri, 25 Apr 2025 12:36:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] board: beagle: beagley-ai: Cleanups and stdboot
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Neha Malcom Francis <n-francis@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, <u-boot@lists.denx.de>
References: <20250425173120.141503-1-nm@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250425173120.141503-1-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 4/25/25 12:31 PM, Nishanth Menon wrote:
> Spin 3 of the series.
> Just happened to get a BeagleY-AI at desk and happened to test master
> branch (7dd49a9264a6 drivers: scsi: Add 'erase' support), noticed a few
> issues which were rather easy to solve.. so, here we go:
> 
> Current series is based off:
> master 9d3f1ebaf875 ("tools/make_pip: Use venv when invoking pip")
> 
> BootLog: https://gist.github.com/nmenon/d5d761371515ce0e9cc77021533c34d7
>    (nothing interesting changed, so same bootlog)
> 

For the series,

Reviewed-by: Andrew Davis <afd@ti.com>

> Changes since v2:
> - Dropped override of dfu_alt_info.
> 
> V2: https://lore.kernel.org/all/20250418193943.953952-1-nm@ti.com/
> V1: https://lore.kernel.org/all/20250411225717.3117370-1-nm@ti.com/
> 
> Nishanth Menon (9):
>    board: beagle: beagley-ai: Add pattern match for MAINTAINERS
>    arch: arm: dts: k3-am67a-beagley-ai-u-boot: Mark main_gpio1 as
>      bootph-all
>    beagle: beagley-ai: env: Set up the boot devices and boot methods
>    beagle: beagley-ai: env: Setup scripts for LED control
>    beagle: beagley-ai: env: Enable DFU env options
>    configs: am67a_beagley_ai*: Use saveddefconfig
>    configs:am67a_beagley_ai*: Drop un-necessary config options
>    configs: am67a_beagley_ai_a53: Enable additional features
>    doc: beagle: Add BeagleY-AI documentation
> 
>   arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi |   4 +
>   board/beagle/beagley-ai/MAINTAINERS          |   4 +-
>   board/beagle/beagley-ai/beagley-ai.env       |   6 +-
>   configs/am67a_beagley_ai_a53_defconfig       | 165 ++++++++++---
>   configs/am67a_beagley_ai_r5_defconfig        | 109 ++++++++-
>   doc/board/beagle/am67a_beagley_ai.rst        | 244 +++++++++++++++++++
>   doc/board/beagle/index.rst                   |   1 +
>   doc/board/ti/k3.rst                          |   1 +
>   8 files changed, 493 insertions(+), 41 deletions(-)
>   create mode 100644 doc/board/beagle/am67a_beagley_ai.rst
> 
