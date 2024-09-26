Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDEACEBF60
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 23:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD10688F89;
	Fri, 27 Sep 2024 01:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727392769;
	bh=UKdWl1LdIP1kRyYLp9E3zhZy6Eu2vOMnf7zhgcv8YRw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=osW8r7VwSXP6dzXmyR4AzmJuHiY2va0Mhm72gmRYEhkYKzdx2qYSoInzwlSs2zaIX
	 DPz+pMI+owvhJi5bvOpmOXMKi9tFJH+rgEpJPqOOdEboyrhw8KyvHZN3gXE++ZhZpc
	 d7XMMxdu51fDfSLwIs6+jrhVcJvilbpCm+SXrXCyFyCHeFtOh1JrGINpDpxX8ZIJRU
	 SRO/xbKFc+dY5XLly/PCzr3rCdLqEnDkTr3zmXgFIv+ChqX+dBGvffd+bNNnl6t5rK
	 IZdxJOSBDGBeov3Uqgbb28f19DsDnmFQImYQNs97GOrAgHRh9tfuibe//ogWMKwNnr
	 i5YFRrYBCx55Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id ECCB188F68;
 Fri, 27 Sep 2024 01:19:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727392768;
 bh=UKdWl1LdIP1kRyYLp9E3zhZy6Eu2vOMnf7zhgcv8YRw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XAUk3FwBsqqzaQctDjIqr4+wkmhCqBD/zdqmatWTsylpUsQMz8THU0H6Er9wdtxmY
 6Pb5Bw8wnsbIc7b84ivIcIMJDVwELZS4+tP8JytSafK1eRtfGihr6SwJSqjqP+bTo+
 10nB35JxDzExNE4i6lgCeklj8lX7Gr2ZJjvlM4OaMrCbC6UDAis1NtJ8WExNga95IW
 98ZRw6DfA/NyIvG/+No80zAho663WV5jpTfdNmGp1PXMfe91pGMEQR20Rcnba+Lgsq
 B8yfYfFbw+bwAlIO+1dqA/Rqqj3YffgPz2QsloWX7W5ZuQwOjfSk5zh7Ja6X7qmV3G
 QFyzCRGDwbbSA==
Message-ID: <57a00da7-ec38-4c3a-8e5a-b44929358337@denx.de>
Date: Fri, 27 Sep 2024 01:13:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] ARM: dts: socfpga: add Enclustra Intel AA1
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-3-l.rubusch@gmail.com>
 <bf99c2bd-f43c-4041-907f-f60b42163cce@denx.de>
 <CAFXKEHbOpv4g5LZ4dkUpwo1OBrRQ7YKZf10=S-2HqMtSK_OE9g@mail.gmail.com>
 <e294ce74-9b77-4de0-b7fc-0d8db9f1226f@denx.de>
 <CAFXKEHZVJiLO_qsy8wtRS9BAs4SG8crTXjoJxwgN45a8GP+JKg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFXKEHZVJiLO_qsy8wtRS9BAs4SG8crTXjoJxwgN45a8GP+JKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/27/24 12:53 AM, Lothar Rubusch wrote:
> On Thu, Sep 26, 2024 at 3:36 AM Marek Vasut <marex@denx.de> wrote:
>>
>> On 9/26/24 12:49 AM, Lothar Rubusch wrote:
>>
>> Hi,
> [...]
>>> Shall I add the files to my DTS patches and ask for upstreaming of the
>>> handoff files into the kernel?
>>
>> Are the handoff files really used by Linux for anything , or do they
>> contain various clock/pinmux/DRAM settings only used by U-Boot ? If the
>> later, place them into U-Boot and include them from -u-boot.dtsi file.
> 
> Similar to the other socfpga targets, the handoff files are just
> relevant to u-boot. So, I'll keep them in arch/arm/dts.

Right

> My particular situation then is as follows. The .dts file just
> includes several .dtsi files. I place this .dts file into
> arch/arm/dts. The first includes contain the "handoff setup". Then I
> include adjustments (.dtsi fragments) to the selected base-board and
> boot-mode. Both  can vary that's why I really would prefer to allow
> for a Kconfig option on that, in contrary to provide a set of .dts
> files for all possible combinations.
> 
> Example:
> $ cat ./arch/arm/dts/socfpga_arria10_mercury_aa1_pe1_sdmmc-u-boot.dts

Upstream DT named this way into Linux:

socfpga_arria10_mercury_aa1_pe1_sdmmc.dts

And then in U-Boot, implement the extras which include whatever you 
need, name the file:

socfpga_arria10_mercury_aa1_pe1_sdmmc-u-boot.dtsi

The U-Boot build system will combine the two DTs, the build system 
should automatically append matching -u-boot.dtsi content to any .dts file.

I am not sure if this also works if the .dts file is in dts/upstream/* 
while the -u-boot.dtsi is in arch/*/dts/ , but there is now definitely a 
use case for such a setup, it is probably a matter of tweaking the 
Makefiles .

> /dts-v1/;
> /* will be taken from /arch/arm/dts */
> #include "socfpga_arria10_mercury_aa1_handoff.h"
> #include "socfpga_arria10-handoff.dtsi"
> #include "socfpga_arria10_handoff_u-boot.dtsi"
> 
> /* will be taken from /dts/upstream */
> #include "../../../dts/upstream/src/arm/intel/socfpga/socfpga_arria10_mercury_aa1.dtsi"
> #include "../../../dts/upstream/src/arm/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
> #include "../../../dts/upstream/src/arm/intel/socfpga/socfpga_enclustra_mercury_pe1.dtsi"
> 
> Ideally, now I like to have the first part as default device tree.
> DEFAULT_DEVICE_TREE=socfpga_arria10_mercury_aa1_pe1_sdmmc-u-boot.dts
> When doing so, I noticed I cannot enable CONFIG_OF_UPSTREAM anymore,
> the files in arch/arm/dts won't be found anymore.
> Then I have the issue how to access the generic .dtsi files used for
> boot-mode or base board. These files are identical to the kernel DT
> why I would prefer to use them from dts/upstream. Including them like
> ../../../../../... works, but... I think there must be a better way.

Look at how the -u-boot.dtsi are automatically added on top of .dts 
files, that might be a start.

> Ideally I like to setup some Kconfig choice for base board selection
> and one for boot-mode.

> 1.) In the documentation control.rst I read that the u-boot.dts is
> combined of several elements. Is there a way to take this base .dts,
> then add a base board .dtsi by Kconfig option, and similar a
> boot-mode?

The -u-boot.dtsi is preprocessed by C preprocessor, just like all the 
other DTs, so you can have a -u-boot.dtsi file which contains C 
preprocessor conditional statements in it to conditionally include other 
.dtsi files:

#if IS_ENABLED(...)
#include ...
#else ...
...
#endif

> 2.) Is there a way to enable CONFIG_OF_UPSTREAM and use explicit DTS
> from arch/arm/dts for the u-boot?

This I do not know.

> 3.) What would be the best possibility to have a u-boot.dts with
> handoff setup in arch/arm/dts and append .dtsi files from the general
> dts/upstream - in case are there other boards are doing something
> similar?

See above, maybe some of it helps.
