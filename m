Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1502EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 09:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A65D86D8B;
	Mon, 11 Sep 2023 11:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56B0E86886; Mon, 11 Sep 2023 11:54:12 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA58386D8D
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 11:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtp62t1694426003tp0k9xoj
Received: from [192.168.159.131] ( [106.150.157.243])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 Sep 2023 17:53:21 +0800 (CST)
X-QQ-SSF: 01100000000000C0G000000A0000000
X-QQ-FEAT: NV69rQnjVY7DvePthMWY3sE1iHndKIMdPcIC65LWaTGPV7IcLOnFbivUpV/hx
 2nH9r+TZl8xToISvpKAbNUqV7Lje9HKbO4dORR3zGmmecIkLlJEGetMTiT6mA26sQh/Z8Au
 /PqN6+4QOtLdkMTqp1V6qDqb+Up6qe986YFK40yAHMEg9teCBiUzpxvwzemADHAPI5RnTKw
 YhZpABUFGoT5W3oFzgsmk50CBvd6hjA8LGMAFBZYaFmIwnEehIPIDtgidySdfxpOmUxqQHS
 vc0iyJIo375jQcPhBe0XTB8P0Uwsm2Y1H8UVpbqxBmvtACHy8mGlUoKUjRiIWPYKqN97R/b
 aIBnxNpQwzM0EAwFbChYdwTqb2mrUAB5OgO6Dq6gMKnRW9GTkf1Idaacpv5Gg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8328589677513716447
Message-ID: <7D6688A4D45E2D52+ef65bae4-810a-68ae-1270-c84684eed6d3@radxa.com>
Date: Mon, 11 Sep 2023 18:53:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] rockchip: Kconfig: Enable external TPL binary for
 rk3308
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@edgeble.ai>, Johan Jonker <jbx6244@gmail.com>
References: <20230909093324.11954-1-massimo.pegorer+oss@gmail.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20230909093324.11954-1-massimo.pegorer+oss@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:radxa.com:qybglogicsvrgz:qybglogicsvrgz6a-0
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

hi,

On 9/9/23 18:33, Massimo Pegorer wrote:
> There is no support to initialize DRAM on rk3308 SoC using U-Boot
> TPL or SPL, and therefore an external TPL binary must be used to
> package a bootable u-boot-rockchip.bin image.
> 
> Default ROCKCHIP_EXTERNAL_TPL to yes if ROCKCHIP_RK3308.
> Remove useless TPL_SERIAL.
> 
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>   arch/arm/mach-rockchip/Kconfig | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: FUKAUMI Naoki <naoki@radxa.com>

thank you very much for your work!

> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index a279582f4f..3b044269bd 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -166,7 +166,6 @@ config ROCKCHIP_RK3308
>   	imply SPL_SYSCON
>   	imply SPL_RAM
>   	imply SPL_SERIAL
> -	imply TPL_SERIAL
>   	imply SPL_SEPARATE_BSS
>   	help
>   	  The Rockchip RK3308 is a ARM-based Soc which embedded with quad
> @@ -436,7 +435,7 @@ config TPL_ROCKCHIP_COMMON_BOARD
>   
>   config ROCKCHIP_EXTERNAL_TPL
>   	bool "Use external TPL binary"
> -	default y if ROCKCHIP_RK3568 || ROCKCHIP_RK3588
> +	default y if ROCKCHIP_RK3308 || ROCKCHIP_RK3568 || ROCKCHIP_RK3588
>   	help
>   	  Some Rockchip SoCs require an external TPL to initialize DRAM.
>   	  Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin to
