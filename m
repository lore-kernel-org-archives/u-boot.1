Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA648CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 20:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A071E86EF6;
	Tue, 17 Oct 2023 22:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iotf2nQm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 246C386F36; Tue, 17 Oct 2023 22:26:56 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D7A886BB4
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 22:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=165c=GA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1697574394;
 bh=36eI+SM91cTdZ5OfReU++iyvA6efjnxoIUI3S9vikHM=;
 b=iotf2nQmpzOCH4v3hZwKFnZrL20W5fuwEv+RKcgwBurjpGQf2XoOmO+ZC4HBYorVgymSKUr6a
 sy5sHRjuzbwg+FtxsD645k6wM60dPLIuRqiPjnrqKrap8VDUPE9ZZQea10iUU5oUbpQzh8YfrQp
 2PxH+86iXiyymzQiP8fIcH0zUQVugPx7Sj6mqPIpvVUPa0etCKHyU89X2+5nQ0U/V3g+fCpQ5Tv
 0Ygr+Us70R8JQbJva08meov1XkxZrj438H1+rEA5o028g0S+tG8w3xvz7W8oRcOORZUIO7N9paL
 UkCXg3NdKWtLcM2T+9rQsm0qj00jwY388YlCg7Cs0+EA==
Message-ID: <db5ccffe-fd4d-a402-8d2a-a4e77f8fa587@kwiboo.se>
Date: Tue, 17 Oct 2023 22:26:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/1] board: rockchip: add FriendlyElec NanoPC-T6 rk3588
 board
To: John Clark <inindev@gmail.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: Chris Morgan <macromorgan@hotmail.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Jagan Teki <jagan@edgeble.ai>, Johan Jonker
 <jbx6244@gmail.com>, Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20231013012025.11694-1-inindev@gmail.com>
 <20231013012025.11694-2-inindev@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20231013012025.11694-2-inindev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 652eedf9c9fb5c43838aba79
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

On 2023-10-13 03:19, John Clark wrote:
> The NanoPC-T6 is a Rockchip RK3588 based SBC by FriendlyElec.
> 
> There are four variants depending on the DRAM size: 4G/32GB eMMC,
> 8G/64GB eMMC, 16G/16MB SPI NOR, and 16G/256GB eMMC/16MB SPI NOR
> 
> Specifications:
>     CPU: Rockchip RK3588, 4x Cortex-A76 (up to 2.4GHz)
>                         + 4x Cortex-A55 (up to 1.8GHz)
>     GPU: Mali-G610 MP4
>     VPU: 8K@60fps H.265 and VP9 decoder, 8K@30fps H.264 decoder,
>          4K@60fps AV1 decoder, 8K@30fps H.264 and H.265 encoder
>     NPU: 6TOPs, supports INT4/INT8/INT16/FP16
>     RAM: 64-bit 4GB/8GB/16GB LPDDR4X at 2133MHz
>     eMMC: 0GB/32GB/64GB/256GB HS400
>     MicroSD Slot: MicroSD SDR104
>     PCIe 3.0: M.2 M-Key x1, PCIe 3.0 x4 for NVMe SSDs up to 2,500 MB/s
>     Ethernet: PCIe 2.5G 2x Ethernet (RTL8125BG)
>     PCIe 2.1: M.2 E-Key x1, PCIe 2.1 x1 and USB2.0 Host,
>               supports M.2 WiFi and Bluetooth
>     4G Module: MiniPCIe x1, MicroSIM Card Slot x1
>     Audio Out: 3.5mm jack for stereo headphone output
>     Audio In: 2.0mm PH-2A connector for analog microphone input
>     Video Input: standard HDMI input port, up to 4Kp60
>     2x 4-lane MIPI-CSI, compatible with MIPI V1.2
>     Video Output: 2x standard HDMI output ports compatible with HDMI2.1,
>                   HDMI2.0, and HDMI1.4
>     2x 4-lane MIPI-DSI, compatible with MIPI DPHY 2.0 or CPHY 1.1
>     USB-A: USB 3.0, Type A
>     USB-C: Full function USB Type‑C port, DP display up to 4Kp60, USB 3.0
>     40-pin 2.54mm header connector: up to 2x SPIs, 6x UARTs, 1x I2Cs,
>                                     8x PWMs, 2x I2Ss, 28x GPIOs
>     Debug UART: 3 Pin 2.54mm header, 3V level, 1500000bps
>     Onboard IR receiver: 38KHz carrier frequency
>     RTC Battery: 2 Pin 1.27/1.25mm RTC battery connector for low power
>                  RTC IC HYM8563TS
>     5V Fan connector
>     Working Temperature: 0C to 70C
>     Power: 5.5*2.1mm DC Jack, 12VDC input
>     Dimensions: 110x80x1.6mm (without case) / 86x114.5x30mm (with case)
> 
> Kernel commits:
> 893c17716d0c ("arm64: dts: rockchip: Add NanoPC T6")
> a721e28dfad2 ("arm64: dts: rockchip: Add NanoPC T6 PCIe Ethernet support")
> ac76b786cc37 ("arm64: dts: rockchip: Add NanoPC T6 PCIe e-key support")
> 
> Signed-off-by: John Clark <inindev@gmail.com>

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas
