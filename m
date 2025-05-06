Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646BAC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 11:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A3982163;
	Tue,  6 May 2025 13:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rZ9Z8isW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0F118219D; Tue,  6 May 2025 13:08:28 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E44EE81F66
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 13:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546B8KLg1036472
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 06:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746529700;
 bh=b5tvpBW+hhksLzIg1GWXY0lVThVIkGU+G0e3Xg3hxFk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=rZ9Z8isWF9fxtk9llz0iBuQ+gDFHGElFYfV6Qzbx41ttA4RCwRYuq82lfcBritjTq
 kRQe09SG42P2u/Yq8Ft5A72xMCk2Y/u2XYBvZuTeL49XT+ihB13gOpNvZl7WtxyP7e
 03x17RTWK08B5WONk/YyLLTbsXT3FGwVarEML9UY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546B8K0n056883
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 May 2025 06:08:20 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 06:08:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 06:08:19 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546B8IbL130115;
 Tue, 6 May 2025 06:08:18 -0500
Message-ID: <41a042ec-d2ec-48ee-be15-a6f88895e977@ti.com>
Date: Tue, 6 May 2025 06:08:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Add support to boot TI K3 HSM M4 core
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <sjg@chromium.org>, <xypron.glpk@gmx.de>, <cfsworks@gmail.com>,
 <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>, <bb@ti.com>,
 <j-humphreys@ti.com>, <s-k6@ti.com>, <j-choudhary@ti.com>,
 <d-gole@ti.com>, <u-boot@lists.denx.de>
References: <20250506104202.16741-1-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250506104202.16741-1-b-padhi@ti.com>
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

On 5/6/25 5:41 AM, Beleswar Padhi wrote:
> Some TI K3 SoCs like J721S2, and J784S4 have a HSM (High Security
> Module) M4F core in the Wakeup Voltage Domain which could be used to
> run secure services like Authentication. Boot flow for HSM M4 core is
> different than the general purpose M4F cores, and is as below:
> 

The below flow looks exactly like the general purpose M4F cores..
Why is the HSM core treated differently and this loader not made into
a normal remote proc driver?

Andrew

> 1. Request control of HSM M4F remote processor.
> 2. Assert Reset on the HSM M4F remote processor.
> 3. Request Secure Entity to Authenticate and Load HSM firmware into
>     core's internal SRAM memory region. For GP device, load the firmware
>     manually into core's SRAM region.
> 4. Deassert Reset on the HSM M4F remote processor.
> 5. Release control of HSM M4F remote processor.
> 
> This series adds support to boot HSM M4 core from R5 SPL stage. The HSM
> firmware is packed inside the tispl.bin fit image. The firmware is
> unpacked into a temporary DDR address which is then used to load HSM
> core. The configs to boot HSM M4 core are disabled by default.
> 
> v2: Changelog:
> [Andrew]:
>   1. Added support in SPL to load FIT images with no 'load' property.
>   2. Removed 'default = n' in CONFIG option.
>   3. Used __maybe_unused to decrease preprocessing.
>   4. Better error messages with error code.
> [Udit]:
>   1. Added 'HSM' entries in enum at the last.
>   2. Added error condition in if-elseif-else ladder.
>   3. Hang System boot when HSM failed to boot properly.
> 
> Link to v1:
> https://lore.kernel.org/all/20250422095430.363792-1-b-padhi@ti.com/
> 
> Test logs after enabling HSM boot configs:
> https://gist.github.com/3V3RYONE/ad33683652c8c49e4fedab49f0493e79
> 
> Beleswar Padhi (7):
>    arm: mach-k3: Add config option for booting HSM core
>    spl: Use FIT data address as fallback when 'load' property is absent
>    arm: dts: k3-binman: Add template for packing HSM firmware
>    arm: dts: k3-{j721s2/j784s4}-binman: Pack HSM firmware inside
>      tispl.bin
>    arm: mach-k3: Use FIT image data addr as fallback if 'load' prop is
>      missing
>    arm: mach-k3: Explicitly identify TIFSSTUB images when discarding
>      buffers
>    arm: mach-k3: r5: common: Add support to boot HSM M4 core
> 
>   arch/arm/dts/k3-binman.dtsi        |   9 +++
>   arch/arm/dts/k3-j721s2-binman.dtsi |  12 ++++
>   arch/arm/dts/k3-j784s4-binman.dtsi |  14 ++++
>   arch/arm/mach-k3/Kconfig           |   7 ++
>   arch/arm/mach-k3/r5/common.c       | 111 +++++++++++++++++++++++++++--
>   common/spl/spl_fit.c               |  16 ++++-
>   6 files changed, 164 insertions(+), 5 deletions(-)
> 
