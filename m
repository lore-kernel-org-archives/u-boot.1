Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2209E71083
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 14:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F9686ADC;
	Thu, 21 Sep 2023 16:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="DJBtm2q1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC3086ACF; Thu, 21 Sep 2023 16:47:22 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2096585C98
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 16:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.125] (unknown [82.76.24.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 387736607318;
 Thu, 21 Sep 2023 15:47:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1695307638;
 bh=XSsrV/JWyw48LfOPVfFPvQtfVJp5/pIaWNooK5NzmH8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DJBtm2q1msa5m+gIN5cDOv1ml2/xqx6b8QzyUkCawFESkh5hHUGgMlGAgkY36ttWR
 k++WvnvkVnOaq3e9PnsnrT+19lnIrOlhdG1PRW7JIwtg4ktf2q1+agJimysQvNO5/D
 VQXwis85h1jNC3UCuJ4MIJC0TsoyeewrNtNgDumM1Xot7tD8GPxy2pIZgwNHclnl9r
 EuowGQ3o1ECXKbAA9m5vRFiY4XRcot5hnHFV4B7idw5wgR3ckzx07DR7B+AFo1Basg
 TWRQoLNXOfEZxwjXpa4Vz6g30I9WWnaFUqaXl3yyB3metMoj6q83liCKGZVKLrDlHu
 GinppeA5BsfEw==
Message-ID: <1800682c-9c1b-c242-b15e-4cc9126e4619@collabora.com>
Date: Thu, 21 Sep 2023 17:47:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 00/10] rockchip: rk3588: add support for DFU in SPL
Content-Language: en-US
To: kever.yang@rock-chips.com, u-boot@lists.denx.de
Cc: marex@denx.de, jonas@kwiboo.se, jagan@edgeble.ai, kernel@collabora.com
References: <20230801072811.10354-1-eugen.hristev@collabora.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230801072811.10354-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/1/23 10:28, Eugen Hristev wrote:
> This series adds support for DFU in SPL for rockchip rk3588 on rock5b
> board.
> 
> Namely, when SPL is loaded via rockusb (thus via USB), having the
> `same-as-spl` boot order item, after having detected that it was loaded
> from USB, it will lookup the gadget USB node in DT and boot via DFU.
> 
> Some changes were required namely:
> - DFU needs environment, hence adding environment variables into DFU
> - added bootph-all to nodes such that they are available in SPL
> - insert gadget into boot order
> 
> I had to port one patch for DWC3 from Linux, and include in this series
> the patches that are floating from Venkatesh that fixup the DWC3
> (https://marc.info/?l=u-boot&m=168351919807081&w=2 )
> 
> I know that Marek NAKed them and I am fine with it, I am not trying to
> sneak in any patches, they are not to be merged, also this patch
> `usb: dwc3: Increase DWC3 controller halt timeout` is in the same bucket
> so Marek you can NAK this one as well, no problem, I am just sending out
> all the series so maybe the rockchip part for the gadget can be picked up
> and if people want to use the DFU SPL gadget can also manually pick the
> DWC3 patches. The branch with all the patches is available here :
> 
> https://gitlab.collabora.com/hardware-enablement/rockchip-3588/u-boot
> 
> Thanks!
> 
> Changes in v2:
> - rebased on latest upstream which caused a change in the config patch.
> 
> 
> Eugen Hristev (7):
>    rockchip: allow env defines for SPL build
>    usb: dwc3: Increase DWC3 controller halt timeout
>    ARM: dts: rockchip: rk3588-rock-5b-u-boot: add bootph-all to gadget
>      nodes
>    ARM: mach-rockchip: spl-boot-order: add possibility to DFU
>    ARM: mach-rockchip: rk3588: add gadget device to the boot order
>    rockchip: rk3588: prepare env for DFU
>    configs: rockchip: rock5b-rk3588: enable DFU and related configs
> 
> Venkatesh Yadav Abbarapu (3):
>    usb: dwc3: core: improve reset sequence
>    usb: dwc3: gadget: Don't send unintended link state change
>    usb: dwc3: core: Only handle soft-reset in DCTL
> 
>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi |  6 +++++
>   arch/arm/mach-rockchip/rk3588/rk3588.c  |  1 +
>   arch/arm/mach-rockchip/spl-boot-order.c |  3 +++
>   configs/rock5b-rk3588_defconfig         | 18 +++++++++++---
>   drivers/usb/dwc3/core.c                 | 32 +++++++++++++++----------
>   drivers/usb/dwc3/gadget.c               | 20 +++++++---------
>   drivers/usb/dwc3/gadget.h               | 14 +++++++++++
>   include/configs/rk3588_common.h         |  9 ++++++-
>   include/configs/rockchip-common.h       |  4 ----
>   9 files changed, 76 insertions(+), 31 deletions(-)
> 


Hello Kever,

I see in patchwork this series is marked as 'Changes requested'.
Do you wish to tell me which are the changes you requested, as I did not 
see anything in your replies.
I am interested to see the patches related to rockchip (not the DWC3), 
if it's fine for you to merge them.

Thanks,
Eugen
