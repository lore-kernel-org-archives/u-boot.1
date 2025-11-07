Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8B7CCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 07:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B92283C6D;
	Fri,  7 Nov 2025 08:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A4F83C91; Fri,  7 Nov 2025 08:03:42 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DABFF83C63
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 08:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: zesmtpip3t1762498967tc564a83c
X-QQ-Originating-IP: eAmgWtYx27lVSVMvTZVTN900C+37ppTnbKi+HxlzUv0=
Received: from [IPV6:240f:10b:7440:1:d7b:b10a: ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 07 Nov 2025 15:02:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18085024290775696883
Message-ID: <6AD487D9BD89300F+23693be4-b27f-4f46-a9de-066d0810cb13@radxa.com>
Date: Fri, 7 Nov 2025 16:02:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] rockchip: Add support for ROCK 5B+
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, u-boot@lists.denx.de
References: <20250801170933.2530191-1-jonas@kwiboo.se>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20250801170933.2530191-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MPI5HzS7e4/KX8wHaCPpEO7otw/+xcwGruCEyKXCxropA1sey8J2LSf4
 Z8TPNtqmf6j8E698mdpnhLYTgrn6Oe69o+vbqgspH5Puz89jook6LRSwkt7BejtqvHwlbeU
 sw48qyGerKpAO4nqVXFjYfjcNZOHnHqPS+dcBb1elsVlHUgsPrtfVEj0u9N9kW1a7JOyb7o
 bfpwhaMKBO0fOR0nvJCieszyFnH4DQYQydlPh89X02ceOcmdEgFlhfiMdpa5xPNraswkk7l
 ucBYH7oDSBxLnxjbvT1AAUYYi96C5pD17UN7zbQtbxDcfBUbsDWhYNCDGR4/cldkc/vhfCT
 vSa2G6yCsA4ud/9LdoB/1gOKJz3jY+LMcj1zQKt0YBhQwXt6c43VWcCRpyot1vrmlzmoYmV
 qTrxlXZY/Vs1UT6P41bnytBfq0OHRidpvMd3ua4wOUrWg6OBeLsUTVuvLIqgoNX3Pje7FwM
 zAm9RrNhr4P6GO6ggdyQ8A0DILq+oLDPGOUHyJuHgH3Tf2hmoTJgw3MoCvipKKcO67Cl15S
 U6riu7oGNtD7ctA8mwdDxoMVyYemXUtaIJhTCKRxfLNJUC0+0AcG2WQFUK4EzzyONSjbLIf
 lRsUQFgFyvYMNGtFRSjVQJBrwyNemhc0nuoSitp9Rp892iODdm1oB7CHbtwZaALJiBOlfwJ
 OW9xe2JD5G6dvOfb777oFvX8Wj4GasHCqwVRDsx9ejoZfnPKsDRI9eIpt+dPqPeaLw+ixcE
 Z9XW1L5smqUqGxOaKXbGcDXuy/ucyqJwDOCJVKI0vWFST2BSs/A7BMiFP4l+P0B0VFiW/WY
 co5y1sNpZXJJank4BLtmYHjiqZ+LDLeyOaw+cLb9SfPX1gLz2hX0dwnYstYx4JMLqruepEd
 gCICq5fTXtjAkdRwt1AcUiDF65Df2mKcs+OHKb4g6sX2pMECJA+YxhQOt6mRJlfN0JpTbHS
 FPZc=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

Hi Jonas,

On 8/2/25 02:09, Jonas Karlman wrote:
> This series add support for the ROCK 5B+ variant to the existing
> rock5b-rk3588 defconfig taget.
> 
> The ROCK 5B+ variant is detected based on DRAM type (LPDDR5) and SARADC
> channel 5, the read out value is expected to be close to 4095 (1.8v) on
> 5B+ variants.
> 
> Features tested on a ROCK 5B+ v1.2:
> - SD-card boot
> - eMMC boot
> - SPI flash boot
> - PCIe/NVMe
> - Ethernet
> - USB/TCPM

I also confirmed that the following things are working:
- uSD card (boot/mmc info)
- SPI flash (sf probe)
- PCIe (pci enum)
- NVMe (nvme scan)
- Ethernet (ping)
- USB (usb start)

Tested-by: FUKAUMI Naoki <naoki@radxa.com>

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Changes in v2:
> - Add a DRAM type check to detected ROCK 5B+ variant
> - Drop device tree patches merged with the v6.16-dts sync
> 
> Jonas Karlman (2):
>    rockchip: sdram: Add rockchip_sdram_type() helper
>    rockchip: rock5b-rk3588: Add support for ROCK 5B+
> 
>   arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi |  3 +
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      |  5 ++
>   arch/arm/include/asm/arch-rockchip/sdram.h   |  3 +
>   arch/arm/mach-rockchip/sdram.c               | 15 +++++
>   board/radxa/rock5b-rk3588/Kconfig            |  5 ++
>   board/radxa/rock5b-rk3588/MAINTAINERS        |  3 +-
>   board/radxa/rock5b-rk3588/rock5b-rk3588.c    | 63 ++++++++++++++++++++
>   configs/rock5b-rk3588_defconfig              |  1 +
>   doc/board/rockchip/rockchip.rst              |  2 +-
>   9 files changed, 97 insertions(+), 3 deletions(-)
>   create mode 100644 arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
> Tested-by: Bryan Hinton <bryan@bryanhinton.com>

