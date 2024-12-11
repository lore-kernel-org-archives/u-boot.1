Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE05E7717F
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 03:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2063801FE;
	Wed, 11 Dec 2024 04:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF55B80209; Wed, 11 Dec 2024 04:37:11 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0ED38018E
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 04:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip4t1733888200tc2o1ca
X-QQ-Originating-IP: SgK/f9NhrUwzic/0jHo7Nivx9zU+m9CwtUHrFPw5cb8=
Received: from [IPV6:240f:10b:7440:1:b238:648b ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Dec 2024 11:36:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17145452107234610293
Message-ID: <0733F92D93201A8B+d4443b29-d808-45e7-bbe8-3ea9b4af2129@radxa.com>
Date: Wed, 11 Dec 2024 12:36:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] rockchip: Add support for Radxa ROCK 5C
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 sumit.garg@linaro.org, jonas@kwiboo.se
References: <20241211032619.5610-1-naoki@radxa.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20241211032619.5610-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MVQzChYQWf+34k+k4ffXqZj+LfeRZcd7pFkgIsBqCPbxs2JLewE9YHYH
 4JeB0ahqybVFlypOYxPi+vqRMwhQb2TEGYp5TQw70rut8tOWyWh5IBODW4D5Rq/7t1Flm/u
 MqKloeKmLluyN/Yb/6HU4N8LGwalazLVCUoaMNQ+zE+FwskB6hkSZVKHM9T5pLp8j8DZwXj
 lhbsBX5KUoAL+ZDY8yryX3W0bjzFDqr/I5ZczagQcupZszDi3GUNor9p6NlJ2jwOMfG0Kbj
 pqkoPSn66BYL9umRNapWL1qqKgcRj7yJzxmXONtq8zWbNm5MB6FDdVd8SoN7MErPF10K+Ai
 hvdSni2baWaIQNGCsOBSzEVbHnHWweNnLdSN3btYjD0OSOHbAzruhsq2Tpq6CC1YBdO04Xk
 E58VN9q+/R94szjCot+1efRaMVzltW1VUQaxGv3h+ByyNCdYNEHWEuyIzpVjmDiFZL2UjNF
 IdQIPXJ26eeTdVl+bwgLzrwHFS93MzE8+oIYq9GsJP6eidhkMAMRy9L43VVhmrhuWePZoAB
 BzqOMlr2tUuKhBSGLFYmpkXYx1+gj1yXt12Vn1YwBddtH6DtSUlFGkCRWUUV8egsnNwRdZt
 8UyEwTn0sARcRlpuakibLEQN7+poXBTLYmexlYys+a+6yKDuhL4ws8sAeDqkC5DUwxyH7Ul
 zJicGhbnFF8srybamVU8+At4QyxcJspPvwhafmHy9RA1rdT0kKIjxrxeCrpAX8sVgBmE1sL
 uSmhvST19o6G8QO9Y6gRRTmusOd575ZfPLtuKYp8EBxytzdLLwAKTcsno/rljABeDGkkcZi
 nwaRwnBMR/wOxelGBiO7snxehp9IyFlN+rKqMpiSdeyNi+zPnvG38GHVX0efCWWhXKwPycO
 pRpqboNYgXxXncRnthiBAyMni4+vFHLO
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
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

I'm sorry, both v1 and v2 patch series cannot be compiled.
I'll submit v3 soon (I confirmed it can be compiled)

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 12/11/24 12:26, FUKAUMI Naoki wrote:
> Radxa ROCK 5C is a Rockchip RK3588S2 based single board computer.
> 
> Cristian Ciocaltea (1):
>    arm64: dts: rockchip: Add HDMI0 node to rk3588
> 
> FUKAUMI Naoki (3):
>    arm64: dts: rockchip: enable PCIe on M.2 E key for Radxa ROCK 5A
>    arm64: dts: rockchip: add Radxa ROCK 5C
>    rockchip: Add support for Radxa ROCK 5C
> 
> Sam Edwards (1):
>    arm64: dts: rockchip: Split up RK3588's PCIe pinctrls
> 
>   arch/arm/dts/rk3588s-rock-5-u-boot.dtsi       |  16 +
>   arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi      |   6 +
>   arch/arm/mach-rockchip/rk3588/Kconfig         |   7 +
>   board/radxa/rock-5-rk3588s/Kconfig            |  12 +
>   board/radxa/rock-5-rk3588s/MAINTAINERS        |   8 +
>   board/radxa/rock-5-rk3588s/Makefile           |   3 +
>   board/radxa/rock-5-rk3588s/rock-5-rk3588s.c   |  77 ++
>   configs/rock-5-rk3588s_defconfig              |  95 ++
>   doc/board/rockchip/rockchip.rst               |   1 +
>   .../arm64/rockchip/rk3588-base-pinctrl.dtsi   | 271 +++++-
>   .../src/arm64/rockchip/rk3588-base.dtsi       |  41 +
>   .../src/arm64/rockchip/rk3588s-rock-5a.dts    |  34 +
>   .../src/arm64/rockchip/rk3588s-rock-5c.dts    | 920 ++++++++++++++++++
>   include/configs/rock-5-rk3588s.h              |  15 +
>   14 files changed, 1458 insertions(+), 48 deletions(-)
>   create mode 100644 arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>   create mode 100644 board/radxa/rock-5-rk3588s/Kconfig
>   create mode 100644 board/radxa/rock-5-rk3588s/MAINTAINERS
>   create mode 100644 board/radxa/rock-5-rk3588s/Makefile
>   create mode 100644 board/radxa/rock-5-rk3588s/rock-5-rk3588s.c
>   create mode 100644 configs/rock-5-rk3588s_defconfig
>   create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-rock-5c.dts
>   create mode 100644 include/configs/rock-5-rk3588s.h


