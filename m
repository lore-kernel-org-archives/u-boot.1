Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3755C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 08:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45ADE82E52;
	Fri, 27 Jun 2025 10:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BHwSbGNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE6E582E9A; Fri, 27 Jun 2025 10:50:40 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0831582E27
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 10:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef14=ZK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1751014237;
 bh=leIRhAsC/npuDnHAOHK7MEIBVK686HiVws0MlVzs58s=;
 b=BHwSbGNK2iMngqHZ+z7XYXHtJr4kRN7lfB0GlxiETRw9e+9uDJNvUKPcUwYxZSJk+PZaMRxtm
 iqit400ievk/WP4GhnxQ6m/7E54RgENe/eEgSzwGQMACUcBLLHr4adoVcbUMp/e+KmwDj4qUivv
 M9SWu+eoREOsQ9iNGCqxczZTfeUGLLOzqgLJc/c0D7OWmmZwRW9hdKMEvayukBV9j3FEtadxbXN
 CKdNGjxeaFx2WHLRnKcU6IY9qXMu6GC7Y3xlAxvHKFy2kIXnMGY15JX9yaKwrVtP5FinopRpnpc
 9nKfAYTENclMtY0JDTiC9yuhzRtK9Yd6r6jgO4z+5JxQ==
X-Forward-Email-ID: 685e5b547cdf8336a349163b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <76ea07a0-dcc0-45ad-b9db-57368f022bdf@kwiboo.se>
Date: Fri, 27 Jun 2025 10:50:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: add ArmSoM Sige5 RK3576 board
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: Oliver.Gaskell@analog.com, heiko@sntech.de, igor.opaniuk@gmail.com,
 ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 kever.yang@rock-chips.com, malysagreg@gmail.com, mkorpershoek@kernel.org,
 nathan.morrison@timesys.com, pbrobinson@gmail.com,
 philipp.tomsich@theobroma-systems.com, philipp.tomsich@vrull.eu,
 quentin.schulz@cherry.de, robert.marko@sartura.hr, seb-dev@mail.de,
 sebastian.reichel@collabora.com, sjg@chromium.org, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, xuhui.lin@rock-chips.com
References: <07e80d9e-c91b-4b33-ab12-bcc5aa0bf3c7@kwiboo.se>
 <20250627072607.964020-1-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250627072607.964020-1-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Jianfeng,

On 2025-06-27 09:26, Jianfeng Liu wrote:
> Hi Jonas,
> 
> On Fri, 27 Jun 2025 08:09:13 +0200, Jonas Karlman wrote:
>> Please review my series that already adds the Sige5 board, see [1].
>>
>> [1] https://lore.kernel.org/all/20250422211216.3727559-1-jonas@kwiboo.se/
> 
> I did not notice this series. I will test it. FYI now mainline u-boot can
> not boot with sd card if you have a blank emmc. RK3576 need a new
> boot_merger to generate idbloader.img.

It is a known issue and I have a preparation series that needs a v2 [2]
and a work-in-progress patch that add the needed
writel(0x3ffff800, 0x3ff803b0) to make sd-card boot work, see [3].

[2] http://lore.kernel.org/r/20250129223641.1888833-1-jonas@kwiboo.se/
[3] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3576

Regards,
Jonas

> 
> Best regards,
> Jianfeng

