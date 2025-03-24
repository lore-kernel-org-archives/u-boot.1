Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7877FC3600B
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 23:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCFCC80F70;
	Tue, 25 Mar 2025 00:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742859753;
	bh=WfDF/w89xvsdWCOZZ3xxevlrG9JcfUjKRsKVZJVQFRE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rgTEG03cT+xvgZUowywmnq01C9Iy+tucfCi2XXsZVxO53DgnFTsTsQGG62MuV77wi
	 M/uC6dD1rdGLevXiv+Hrdmj6GkMoUgGahfA2dpNGrSPuHhS5zLf+OKJA0zWlrlO4eF
	 McpzYGX6IBw/hnEHg9G0uvj/bPutqw1BRbmhfwBI+lYzUXgRXWBbmcgIwMYO0FxwtV
	 7ZhF/z/buZmFC/W4kHvslKyZBsPanfuPV65jBawLwgxCVWdleHNtSFr/a+38N5fCpR
	 KbAvZtcWcXC2+YUKDlDOgX3M6G8K3+O9O1LzFJRv7wPYJZk4P+jcys0RECfEHMHV3c
	 PPoijjxKw22Lw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA01481026; Tue, 25 Mar 2025 00:42:31 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79EE6808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 00:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="SV2wm1gW"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 285D5102901F7; Tue, 25 Mar 2025 00:42:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742859748; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=WfDF/w89xvsdWCOZZ3xxevlrG9JcfUjKRsKVZJVQFRE=;
 b=SV2wm1gWCo6oQ0kd/IdB9vaK/U9p/KrmGVz8iMYsF4EY5lf6xQgdb8uvmqbFIDVtAUQXMk
 dtrOracRmI8IYUxGUb8bcdoSKj8216rBc4ZjjiMd9+qxMBJEUU/KDgPXf0zRLrNiZVuCKM
 WV5CX+X/zokGhT8hUDmZVRE3pBzUjX+slU58Qa2BYlBXCa6EyAhQ8BlpD8nJBaD4VjNtXh
 wjCQXC83eRDIhs+R42KsmsCByr81V44JFLp8g7iN2BxozrA2CyGc1X0aWsEZYEha1GcGWu
 85JRqwPnGrwFc+cNKn079CWsMqj8RpedwXvAlC8nrsJjG6exLER9aOUzJC615w==
Message-ID: <d1b75ab8-f2df-491d-94b9-d23f95baf777@denx.de>
Date: Tue, 25 Mar 2025 00:41:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/24] clk: Add clk_resolve_parent_clk() and fix up iMX
 clock drivers
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan
 <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
References: <20250323160107.145749-1-marex@denx.de>
 <CAHCN7xK=hmHKSDZ3A4TU0-9PC5=s52eR3vvEduOqYNjjMzfGVw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAHCN7xK=hmHKSDZ3A4TU0-9PC5=s52eR3vvEduOqYNjjMzfGVw@mail.gmail.com>
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

On 3/25/25 12:33 AM, Adam Ford wrote:
> On Sun, Mar 23, 2025 at 11:01 AM Marek Vasut <marex@denx.de> wrote:
>>
>> Add clk_resolve_parent_clk() to resolve parent clock udevice name
>> based on clock-names DT property. This is used in SoC clock drivers
>> to look up the clock name in clock tables, which matches a clock
>> name in DT clock-names property, and convert it into udevice name
>> which is used by U-Boot clock framework to look up parent clock in
>> e.g. clk_register() using uclass_get_device_by_name(UCLASS_CLK,
>> parent_name, &parent);
>>
>> Pass struct udevice pointer through the various iMX clock drivers.
>>
>> Marek Vasut (24):
>>    clk: Add clk_resolve_parent_clk()
>>    clk: clk-mux: Fold clk_register_mux()
>>    clk: clk-mux: Use struct udevice instead of struct device
>>    clk: clk-mux: Resolve parent clock by name
>>    clk: imx: Pass struct udevice into imx_clk_mux*()
>>    clk: imx: Pass struct udevice to clk_register_mux()
>>    clk: clk-gate: Use struct udevice instead of struct device
>>    clk: clk-gate: Resolve parent clock by name
>>    clk: imx: gate2: Use struct udevice instead of struct device
>>    clk: imx: gate2: Resolve parent clock by name
>>    clk: imx: Pass struct udevice into imx_clk_gate*()
>>    clk: imx: Pass struct udevice to clk_register_gate*()
>>    clk: clk-composite: Use struct udevice instead of struct device
>>    clk: clk-composite: Resolve parent clock by name
>>    clk: imx: Pass struct udevice into imx_clk_composite*()
>>    clk: imx: Convert clock-osc-* back to osc_*
>>    clk: imx: Pass struct udevice into imx_clk_pllv3*()
>>    clk: imx: pllv3: Resolve parent clock by name
>>    clk: clk-divider: Use struct udevice instead of struct device
>>    clk: imx: Pass struct udevice into imx_clk_divider*()
>>    clk: clk-divider: Resolve parent clock by name
>>    clk: clk-fixed-factor: Use struct udevice instead of struct device
>>    clk: clk-fixed-factor: Resolve parent clock by name
>>    clk: imx: Pass struct udevice into imx_clk_fixed_factor*()
>>
>>   drivers/clk/clk-composite.c        |   4 +-
>>   drivers/clk/clk-divider.c          |   7 +-
>>   drivers/clk/clk-fixed-factor.c     |   6 +-
>>   drivers/clk/clk-gate.c             |   5 +-
>>   drivers/clk/clk-mux.c              |  47 +---
>>   drivers/clk/clk-uclass.c           |  18 ++
>>   drivers/clk/imx/clk-composite-8m.c |   4 +-
>>   drivers/clk/imx/clk-gate2.c        |   5 +-
>>   drivers/clk/imx/clk-imx6q.c        |  80 +++----
>>   drivers/clk/imx/clk-imx8mm.c       | 254 +++++++++++----------
>>   drivers/clk/imx/clk-imx8mn.c       | 246 ++++++++++----------
>>   drivers/clk/imx/clk-imx8mp.c       | 348 ++++++++++++++---------------
>>   drivers/clk/imx/clk-imx8mq.c       | 226 +++++++++----------
>>   drivers/clk/imx/clk-imx93.c        |   8 +-
>>   drivers/clk/imx/clk-imxrt1020.c    |  42 ++--
>>   drivers/clk/imx/clk-imxrt1050.c    |  78 +++----
>>   drivers/clk/imx/clk-imxrt1170.c    |  30 +--
>>   drivers/clk/imx/clk-pllv3.c        |   9 +-
>>   drivers/clk/imx/clk.h              | 116 +++++-----
>>   include/clk.h                      |   9 +
>>   include/linux/clk-provider.h       |  10 +-
>>   21 files changed, 783 insertions(+), 769 deletions(-)
> 
> 
> For the series:
> 
> Tested-by:  Adam Ford <aford173@gmail.com>  #imx8[mnp] beacon-kit
Thank you !
