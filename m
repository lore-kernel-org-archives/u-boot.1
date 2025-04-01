Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D4EC36008
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 05:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77AC98171B;
	Tue,  1 Apr 2025 07:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jItV0p79";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09BFA8171B; Tue,  1 Apr 2025 05:00:52 +0200 (CEST)
Received: from mail-m15592.qiye.163.com (mail-m15592.qiye.163.com
 [101.71.155.92])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 474FE80584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 05:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1041180c1;
 Tue, 1 Apr 2025 11:00:39 +0800 (GMT+08:00)
Message-ID: <97223c88-8f32-4cfd-8465-dd034f85f3a5@rock-chips.com>
Date: Tue, 1 Apr 2025 11:00:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: io-domain: Enable by default for all supported
 SoCs
To: Anand Moon <linux.amoon@gmail.com>, Chen-Yu Tsai <wens@kernel.org>
Cc: u-boot@lists.denx.de, Chen-Yu Tsai <wens@csie.org>,
 Akash Gajjar <gajjar04akash@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Deepak Das <deepakdas.linux@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Heiko Stuebner <heiko@sntech.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Klaus Goger <klaus.goger@cherry.de>, Levin Du <djw@t-chip.com.cn>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Nick Xie <nick@khadas.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Peter Robinson
 <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Shantur Rathore <i@shantur.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Xiaobo Tian <peterwillcn@gmail.com>
References: <20250204172319.3361870-1-wens@kernel.org>
 <CANAwSgQTMBLW2Y5YHpoAYDtXHyAbD9-s8KpWU1zBTRAB=rsJow@mail.gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <CANAwSgQTMBLW2Y5YHpoAYDtXHyAbD9-s8KpWU1zBTRAB=rsJow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0wYVksaTR9OSklPSxpPSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a95ef4b3b7203afkunm1041180c1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kwg6TAw6FTJIAxQ1ASE6UTM1
 OBMwCj5VSlVKTE9IT0xNT09IT0NDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlNSkw3Bg++
DKIM-Signature: a=rsa-sha256;
 b=jItV0p799xso9v+VFmif6HgdIUAlf8GkHvQvlooMohRa4d83trmGKLa6e90S7FpYt/2RBr3K/vrovFeghnpvqxV47G/P6bHvRdyl/IQKMqoJxE67eiWmN20inflqzU73MPjVI2lOEej1Rb3VT9s4asBZy9svdRrwoXcMGxWjICM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=6EXxIjqNwgDuPOLpx3IkfrvjyO5+BYRI8mcPMiTp1bU=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Tue, 01 Apr 2025 07:33:17 +0200
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

Hi Anand,

On 2025/3/30 21:33, Anand Moon wrote:
> Hi Chen-Yu
>
> On Wed, 5 Feb 2025 at 07:39, Chen-Yu Tsai <wens@kernel.org> wrote:
>> From: Chen-Yu Tsai <wens@csie.org>
>>
>> The IO domain driver controls the I/O voltage for various pins,
>> MMC included.
>>
>> Enable it by default for all supported Rockchip SoCs.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Reviewed-by: Anand Moon <linux.amoon@gmail.com>
>
> Can we enable following config default for all the boards
>
> CONFIG_MMC_DW=y
> CONFIG_MMC_DW_ROCKCHIP=y
> CONFIG_MMC_SDHCI=y
These two driver, SD card and eMMC, are board specific, not all the 
board has enable all these two interface.

Thanks,
- Kever
>
> Thanks
> -Anand
>
