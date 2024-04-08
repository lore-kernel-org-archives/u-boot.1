Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74AACD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 19:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52774880F1;
	Mon,  8 Apr 2024 21:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RPrWLGd2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6244C880F4; Mon,  8 Apr 2024 21:31:43 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61880880E5
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 21:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d79=LO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1712604694;
 bh=jCwIX1d6atp8VGpURF5T12Q2Nf6DM+UxxzuF9Z3P7X0=;
 b=RPrWLGd2E33GJwQ9NvB0b/hXH7g7KxSV598f9cKGWwwLjqxeW7YLjKqaRC3/oSvI3aJB7ZQof
 5zaubmASD8EZMRWSpk7WTUy8j15+G9yAQSfX2wW8bea3Kec8OaClbSRvRl4c+cEGm2uD/ozYuG3
 iWYM2QrggYoJrSfGkXVeGRYNN8wa7fm7+vOTrbcaqfki8g2WZDz+NaUlux2tIQoRoH/Afm9uMhG
 u06VTPEqfm4FS3ninXK6KT5ZU+ApCv+fu+H0OGCrK8/nd114POw5r0VDSDsS5/WNJ+XnUIOcd9Z
 b/ouilDsEv98St2PYZTEQuxy4Y7wO2QElKN0KV60/ysA==
Message-ID: <7db1cc51-3a9c-44c3-ac16-369566f2ef20@kwiboo.se>
Date: Mon, 8 Apr 2024 21:31:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can't get U-Boot working on Geniatech XPI-3566-ZERO
To: "=?UTF-8?Q?Mizsei_Zolt=C3=A1n?=" <zmizsei@extrowerk.com>
References: <cf475658-6c25-474b-934b-15da1363a39f@app.fastmail.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <cf475658-6c25-474b-934b-15da1363a39f@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661446159ad98c55d9e4da58
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

Hi Z,

On 2024-04-08 09:40, Mizsei Zoltán wrote:
> Hi,
> 
> I'm trying to get a mainline U-Boot running on the Geniatech XPI-3566-ZERO RK3566 based SBC [1], but all my attempts have failed so far.
> 
> The SBC doesn't have any SD-Card slot, please keep this in mind!
> 
> I can build U-Boot, but when I write the resulting binary to the eMMC using rkdeveloptool, the boot stops and I see no output on the UART pins using 1500000 baud transfer rate.
> 
> My steps were the following:
> 
> - git clone https://github.com/u-boot/u-boot
> - cd u-boot
> - CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make rk3568_defconfig

There is no rk3568_defconfig target but generic-rk3568_defconfig may work better.

> - ROCKCHIP_TPL='rkbin/bin/rk35/rk3566_ddr_1056MHz_v1.21.bin'  BL31='rkbin/bin/rk35/rk3568_bl31_v1.44.elf' CROSS_COMPILE=aarch64-linux-gnu- make
> - rkdeveloptool db MiniLoaderAll.bin
> - rkdeveloptool wl 64 u-boot-rockchip.bin
> 
> After that I can no longer communicate with the board via UART and it no longer boots.

After looking at the specification for this board it looks like GPIO pin 8 and 10 is connected to uart1 and not uart2 that is typically used for debug uart on rockchip devices.

> 
> I've built uboot countless times, I've followed all sorts of guides, I've tried modifying FDT and transplanting the DTS from the official SDK, I have tried vanilla defconfigs and tried to modify them aswell, I think I've tried everything, but no matter what I do I just can't get it working.
> The vendored U-Boot works ok, but I plant to run OpenBSD, for which an upstream U-Boot would be better situated (according to the OBSD mailing list).
> 
> Please give me some hints because I'm running out of ideas. I've spent countless hours trying to get this to work but haven't succeeded.

You can try changing stdout-path to "serial1:1500000n8" and enable the uart1 node in generic-rk3568.dts.
Also change to CONFIG_DEBUG_UART_BASE=0xFE650000, and also use rkbin tools/ddrbin_tool and change to use uart1 on ddr bin.

After that you should probably start seeing something on uart and that may help you get a little bit further.

Regards,
Jonas

> 
> Thank You very much!
> 
> Best Regards,
> 
> --Z--
> 
> [1] https://www.geniatech.com/product/xpi-3566-zero/

