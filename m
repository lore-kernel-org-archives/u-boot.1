Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667F9E9413E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 02:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDE0786587;
	Sat,  7 Oct 2023 04:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Od+jEstF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D98B4865A5; Sat,  7 Oct 2023 04:37:08 +0200 (CEST)
Received: from ec2-44-216-146-129.compute-1.amazonaws.com
 (ec2-44-216-146-129.compute-1.amazonaws.com [44.216.146.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516508642E
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 04:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Od+jEstF1yzrBLMPqdLL86Hq6raPWvgPYdSRt07rZKO7Ozj0c7L11gLWpOnX7g2cmmDyTUU7L/TqABgJqCOms3djIH1raVOff7k9JV5k9yjgJu02htMlb/cb5O2RkHahTEdMimrOuotPnE0C1MFQZAiCvHHljitNJkmhBdx8MF8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=ToTEE4/HQRhukIz6i42C+3jUTbhD/jQI2yIUIoi1Lm0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id B120D4001B6;
 Sat,  7 Oct 2023 10:36:48 +0800 (CST)
Message-ID: <6cdc5762-bf26-fb0b-6234-ba53b125a2c8@rock-chips.com>
Date: Sat, 7 Oct 2023 10:36:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] board: rockchip: add Pine64 QuartzPro64 RK3588 board
Content-Language: en-US
To: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
References: <20231001141858.164019-1-tom@tom-fitzhenry.me.uk>
 <87o7hfaf9j.fsf@tom-fitzhenry.me.uk>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <87o7hfaf9j.fsf@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR9NSFZLTUoaTExIHhgdH0xVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b07fe9d9a2eb3kusnb120d4001b6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAw6PTo*KTw3PhkILBMVMAsU
 QjZPCzpVSlVKTUJNTU9NSUtCSExOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS01LNwY+
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

Hi Tom,

     Please add the info about where is the dts from in you v2, eg. a 
tag in mainline kernel.


Thanks,

- Kever

On 2023/10/3 23:34, Tom Fitzhenry wrote:
> Tom Fitzhenry <tom@tom-fitzhenry.me.uk> writes:
>
>> QuartzPro64 is a Rockchip RK3588 based SBC by Pine64.
>>
>> UART and booting over SD card are tested to work.
> I've found a few issues with this patch, incl. confusion over the
> relationship between rk3588-quartzpro64.dts and
> rk3588-quartzpro64-u-boot.dtsi .
>
> I will rework this patch as a v2, and include eMMC support too.
