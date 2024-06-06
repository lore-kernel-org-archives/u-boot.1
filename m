Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CEBC27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 07:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EA4E883F5;
	Thu,  6 Jun 2024 08:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NccNdzB/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75F838841F; Thu,  6 Jun 2024 08:59:53 +0200 (CEST)
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com
 [115.236.118.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDED1883F5
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 08:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=NccNdzB/djH3RP3zVr+851ppHj3wxNmFhMHcuz99STajTqN9b+CjOdv9ePsII/SYTS6ltbjHDIHtJYQsnakEU13Jut6Y9k93BHUrrX6yNkFEv3VwC+Xgd/pVHvS0ghSuz6mEphYUQ+f43XSKfNBNcl6aIgmNMvm1982Ey9DTMA0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=g3R8ZS1w9Pbm94G3pXf07dA2PSa8mAYXNoogm7In+r8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id DC11A900575;
 Thu,  6 Jun 2024 14:59:36 +0800 (CST)
Message-ID: <5a0c2d6c-2b99-4927-8039-3e571b5e53f7@rock-chips.com>
Date: Thu, 6 Jun 2024 14:59:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] arm64: dts: rockchip: add rk3588 pcie and php
 IOMMUs
To: Jianfeng Liu <liujianfeng1994@gmail.com>, u-boot@lists.denx.de
Cc: Niklas Cassel <cassel@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20240528170406.353616-1-liujianfeng1994@gmail.com>
 <20240528170406.353616-8-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240528170406.353616-8-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx0fTlYeSxhKSk9LTRgaSUlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8fec588f3203a9kunmdc11a900575
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nj46ORw6MTNCHjYpQy03QktR
 AUtPFBNVSlVKTEpMTU5MSkxDTk9MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSUJLNwY+
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


On 2024/5/29 01:04, Jianfeng Liu wrote:
> From: Niklas Cassel <cassel@kernel.org>
>
> The mmu600_pcie is connected with the five PCIe controllers.
> The mmu600_php is connected with the USB3 controller, the GMAC
> controllers, and the SATA controllers.
>
> See 8.2 Block Diagram, in rk3588 TRM (Technical Reference Manual).
>
> The IOMMUs are disabled by default, as further patches are needed to
> program the SID/SSIDs in to the IOMMUs.
>
> iommu: Default domain type: Translated
> iommu: DMA domain TLB invalidation policy: strict mode
> arm-smmu-v3 fc900000.iommu: ias 48-bit, oas 48-bit (features 0x001c1eaf)
> arm-smmu-v3 fc900000.iommu: allocated 65536 entries for cmdq
> arm-smmu-v3 fc900000.iommu: allocated 32768 entries for evtq
> arm-smmu-v3 fc900000.iommu: msi_domain absent - falling back to wired irqs
>
> Additionally, the IOMMU correctly triggers an IOMMU fault when
> a PCIe device performs a write (since the device hasn't been
> assigned a SID/SSID):
> arm-smmu-v3 fc900000.iommu: event 0x02 received:
> arm-smmu-v3 fc900000.iommu:      0x0000010000000002
> arm-smmu-v3 fc900000.iommu:      0x0000000000000000
> arm-smmu-v3 fc900000.iommu:      0x0000000000000000
> arm-smmu-v3 fc900000.iommu:      0x0000000000000000
>
> While this doesn't provide much value as is, having the devices as
> disabled in the device tree will allow developers to see that the rk3588
> actually has IOMMUs on the SoC.
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Link: https://lore.kernel.org/r/20240502140231.477049-2-cassel@kernel.org
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: cd81d3a0695cc54ad6ac0ef4bbb67a7c8f55d592 ]
>
> (cherry picked from commit ea9a34aa0d786cbf4b87f1ba528e69b07219738f)
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> (no changes since v1)
>
>   dts/upstream/src/arm64/rockchip/rk3588s.dtsi | 24 ++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> index b0a59ec5183..6ac5ac8b48a 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
> @@ -579,6 +579,30 @@
>   		status = "disabled";
>   	};
>   
> +	mmu600_pcie: iommu@fc900000 {
> +		compatible = "arm,smmu-v3";
> +		reg = <0x0 0xfc900000 0x0 0x200000>;
> +		interrupts = <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
> +		#iommu-cells = <1>;
> +		status = "disabled";
> +	};
> +
> +	mmu600_php: iommu@fcb00000 {
> +		compatible = "arm,smmu-v3";
> +		reg = <0x0 0xfcb00000 0x0 0x200000>;
> +		interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
> +		#iommu-cells = <1>;
> +		status = "disabled";
> +	};
> +
>   	pmu1grf: syscon@fd58a000 {
>   		compatible = "rockchip,rk3588-pmugrf", "syscon", "simple-mfd";
>   		reg = <0x0 0xfd58a000 0x0 0x10000>;
