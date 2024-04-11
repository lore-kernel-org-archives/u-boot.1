Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D86BCD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 07:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA24A86D38;
	Thu, 11 Apr 2024 09:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=flokli.de header.i=@flokli.de header.b="VG9WdmvL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAB1B85B66; Thu, 11 Apr 2024 09:29:53 +0200 (CEST)
Received: from mail.flokli.de (mail.flokli.de [IPv6:2a01:4f8:1c1e:e12f::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4D9586EB5
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 09:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=flokli@flokli.de
Date: Thu, 11 Apr 2024 10:29:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flokli.de; s=mail;
 t=1712820590; bh=sDe0CPFMl5x2C/s8SmDMLzyqAalhLF8BK/ByyDJ3Ceo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VG9WdmvLLBdue1RlgLzcOOSF7btYc5Jv3XdTubP/0FIec8HRMlAt7XUtzrvL/jmSN
 5DBzvvCm4/fTan4fI/yPezhqXxse8HFmy+4T52ZxUbEWP+awNyOV4mdL3mmS/7mRqe
 p/x7XcLZDlUYPYXv9EKH9e+DRphEKio+Vm8/uLfU=
From: Florian Klink <flokli@flokli.de>
To: Joshua Riek <jjriek@verizon.net>
Cc: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Sam Edwards <CFSworks@gmail.com>, Jagan Teki <jagan@edgeble.ai>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] board: rockchip: Add the Turing RK1 SoM
Message-ID: <4lspwhoesvjvbaxlsx4fl6fbsnfte2qbpq2tmfupdpw5jh6vqp@oculnryb7ue6>
References: <20231214234647.296129-1-jjriek.ref@verizon.net>
 <20231214234647.296129-1-jjriek@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231214234647.296129-1-jjriek@verizon.net>
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

On 23-12-14 18:46:47, Joshua Riek wrote:
>The Turing RK1 is a Rockchip RK3588 based SoM from Turing Machines.
>
>Specifications:
>
>    Rockchip RK3588 SoC
>    4x ARM Cortex-A76, 4x ARM Cortex-A55
>    8/16/32GB memory LPDDR4x
>    Mali G610MC4 GPU
>    32GB eMMC HS400
>    2x USB 2.0, 2x USB 3.0
>    2x MIPI CSI 4x lanes
>    1x MIPI-DSI DPHY 2x lanes
>    PCIe 2.0 x1, PCIe 3.0 x4
>    1x HDMI 2.1 output, 1x DP 1.4 output
>    Gigabit Ethernet
>    Size: 69.6mm x 45mm (260-pin SO-DIMM connector)
>
>Kernel commit:
>2806a69f3fef ("arm64: dts: rockchip: Add Turing RK1 SoM support")

[…]

>diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
>new file mode 100644
>index 0000000000..289f2da775
>--- /dev/null
>+++ b/configs/turing-rk1-rk3588_defconfig
>@@ -0,0 +1,133 @@
>+CONFIG_ARM=y
>+CONFIG_SKIP_LOWLEVEL_INIT=y
>+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>+CONFIG_COUNTER_FREQUENCY=24000000
>+CONFIG_ARCH_ROCKCHIP=y
>+CONFIG_TEXT_BASE=0x00a00000
>+CONFIG_SPL_LIBCOMMON_SUPPORT=y
>+CONFIG_SPL_LIBGENERIC_SUPPORT=y
>+CONFIG_NR_DRAM_BANKS=2
>+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>+CONFIG_SF_DEFAULT_SPEED=24000000
>+CONFIG_SF_DEFAULT_MODE=0x2000
>+CONFIG_DEFAULT_DEVICE_TREE="rk3588-turing-rk1"
>+CONFIG_ROCKCHIP_RK3588=y
>+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>+CONFIG_ROCKCHIP_SPI_IMAGE=y

Does the RK1 have an SPI chip attached, and is is possible to flash
u-boot into SPI and boot from it?

This has sparked some confusion on whether "u-boot-rockchip-spi.bin"
should be provided in a downstream build or not.

[…]

Thanks,
Florian
