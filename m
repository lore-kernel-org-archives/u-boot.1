Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76BFC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 10:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF9C801BE;
	Tue, 11 Mar 2025 11:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jt3jwf7b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A7208083E; Tue, 11 Mar 2025 11:50:23 +0100 (CET)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5409980017
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:50:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-86715793b1fso2241547241.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741690209; x=1742295009; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=81ReePSeCUxBBE1azxtHAqKz42Ftip22mki37mYfIww=;
 b=Jt3jwf7bCGEXqnIyXftKxlzrY3XHV4rdR2sdyfhvS9r4z6lXXicecK1Ar7cZ+DxeM4
 8wnoA8/YqpK5E//vYgY2Fw8KJ1f1TQIj2F8WQaMyqhtX5FOVZWV+SD/Re9OUx5NooVxh
 hZb1hruOPFjnxr3sEJWx/3kRTv9x8nbQT/Hsq9DvL0ny5yPXgix53kCLKAXTyV/50jTJ
 pbkzenUrDd5VqFTQg89KndhzStzi1SZYM4eZaD2ZFllvfBPN7cl5epP4WpbkZRPjDaiL
 kjfMJmG8TTrtth/BILq9jy4MhiySHgrzOxjPAwqptgEznK2A9MFXFfXtiuKx0tgwdFFG
 /MUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741690209; x=1742295009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=81ReePSeCUxBBE1azxtHAqKz42Ftip22mki37mYfIww=;
 b=SgjzuoTdowwPNgMbUbe8L4Nc7U4Ov45Kbsu5jugJr7nnxVmlAqjBi30m1RiS9zbn2X
 HFfVYLEzj7ngz2vlfMUC92SeTL0SpTkiu1ZZBtvIBOrFSSDGAnMNTAAAUCXoZvx+1C0Y
 5H+m/sBLzKdo11g5PxE9ONsk3TJqtHHSKMgr4oEUu4pK2PzI7i+LC47NeIh5b1ZzSUYH
 kORmqKzwBmyZ6MLklqvUykCFCJH5EqYBI9Tpf9oHcVhHgNfNXPFb6eKtEvTmLZj6Zeue
 Wwzc5yoab0A2UQ0PavogJ8ynZJu/0dn0jRasgi6HV5NGIIJpcZ1CQG6dXyAM+eFFlXY7
 N4PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpMAdk3AOdMJWMpskxCj7YNfdCKsCz/Xr+1FU3fwEqhii5wSXpNM5ZSe0YVjj2iijTvwB/NwM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+IKHb+BVo/A1wYEIoDmtXNd2XNXutp83l7qR0ZkZV15M7+nVc
 ALaynnyAivPEMT3QGo38Qro2chZT+DDhFry1YC+sgEIfLJY8rLeQLrQWikZoZEaBxwnDuEj/hwT
 VxfHRxGE7fqj7IdUROKSSAMEW9Rdxzj8QnNUbSw==
X-Gm-Gg: ASbGncuJ1NjYVkP8tJfl1rvdgl/UcaODnxvvYnnar3NioP3W4maygWvvFF+r9FgZtos
 7o/QYNy2UZYobn3AU8Ec/nJLXPk+ZD1sfczFN1azUKU4cFETgQQKwQVWwFsjuZiKQW8SGVe3SRi
 B7ayHapSu+jjaMl4jTekZvZ/LnTOX+
X-Google-Smtp-Source: AGHT+IFzCRzupeLbt7v7+ddtJTwj1qVTPPElyqi9QobIL9y3lMhNMArQ7LZSs5IDPII+r0Vx3fDP654bpbypcUATk0M=
X-Received: by 2002:a05:6102:2b96:b0:4c1:7d0d:a48c with SMTP id
 ada2fe7eead31-4c30a730fa8mr11168772137.22.1741690209362; Tue, 11 Mar 2025
 03:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 11 Mar 2025 16:19:58 +0530
X-Gm-Features: AQ5f1JpGTxYsZryrSwGG4TfyM0KvDQDQp9gjWzPGI47hVMFuXwySonNuECjl330
Message-ID: <CAFA6WYMBHo4O-e-SeG8mZ9ec2RJsBc4F86mCi5un=mxOWfXasQ@mail.gmail.com>
Subject: Re: [PATCH 00/19] am62: IO+DDR resume support
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>,
 Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>,
 Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Judith Mendez <jm@ti.com>, Andrew Davis <afd@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Markus,

On Tue, 11 Mar 2025 at 16:02, Markus Schneider-Pargmann
<msp@baylibre.com> wrote:
>
> Hi,
>
> this series introduces support to resume from IO+DDR. IO+DDR is a low
> power mode of am62a and am62p in which nearly everything is powered off
> except DDR which is in self-refresh and a few pins which detect
> activity and can wakeup the system again.
>
> On resume uboot SPL is loaded and checks if this is a IO+DDR resume. If
> it is, the DDR initialization sequence in k3-ddrss differs slightly as
> it has to get the DDR out of the self-refresh.
>
> Afterwards a specific address determined from DT is used to get the
> metadata that stores relevant context addresses. The context is restored
> using the tisci message TI_SCI_MSG_MIN_CONTEXT_RESTORE. At the end all
> further initializations are skipped and uboot SPL directly jumps into
> the DM resume address which takes care of the rest.
>
> The devicetree R5F related patches were picked up from the mailinglist
> and are required to find the correct address of the metadata.
>
> k3-ddrss is using absolute register accesses at the moment. I am trying
> to submit syscon DT patches upstream to access these through syscon,
> unfortunately there is ongoing discussion regarding syscon.
>
> I tested this on am62a.
>
> Best,
> Markus
>
> To: Tom Rini <trini@konsulko.com>
> To: Vignesh Raghavendra <vigneshr@ti.com>
> To: Bryan Brattlof <bb@ti.com>
> To: Sumit Garg <sumit.garg@linaro.org>
> Cc: u-boot@lists.denx.de
>
> Cc: Vishal Mahaveer <vishalm@ti.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Sebin Francis <sebin.francis@ti.com>
> Cc: Kendall Willis <k-willis@ti.com>
> Cc: Akashdeep Kaur <a-kaur@ti.com>
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> Devarsh Thakkar (3):
>       arm64: dts: ti: k3-am62a-wakeup: Add R5F device node
>       arm64: dts: ti: k3-am62a7-sk: Enable IPC with remote processors
>       arm64: dts: ti: k3-am62p5-sk: Enable IPC with remote processors
>
> Hari Nagalla (2):
>       arm64: dts: ti: k3-am62a-mcu: Add R5F remote proc node
>       arm64: dts: ti: k3-am62x-sk-common: Enable IPC with remote processors
>
> Jai Luthra (1):
>       arm64: dts: ti: k3-am62a-main: Add C7xv device node
>
> Markus Schneider-Pargmann (13):
>       arm: mach-k3: Remove CANUART IO isolation
>       arm: mach-k3: Kconfig: Add symbols for IO+DDR Low Power Mode
>       ram: k3-ddrss: Add support for DDR in self-refresh
>       firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
>       arm: mach-k3: common: Add CANUART wakeup check helpers
>       arm: mach-k3: common: Add lpm_resume_from_ddr
>       arm: mach-k3: common: Helper for LPM meta data address from DT
>       arm: mach-k3: am62a7_init: Resume on LPM exit
>       arm: mach-k3: am62p5_init: Resume on LPM exit
>       arm: dts: k3-am62a: Add r5 device nodes
>       arm: dts: k3-am62p: Add r5 device nodes
>       configs: am62ax_evm_r5: Enable IODDR resume support
>       configs: am62p_evm_r5_defconfig: Enable IODDR resume support
>
>  arch/arm/dts/k3-am62a7-sk-u-boot.dtsi             |  16 +++
>  arch/arm/dts/k3-am62p5-sk-u-boot.dtsi             |  20 +++
>  arch/arm/mach-k3/Kconfig                          |   9 ++
>  arch/arm/mach-k3/am62ax/am62a7_init.c             |  11 ++
>  arch/arm/mach-k3/am62px/am62p5_init.c             |  12 ++
>  arch/arm/mach-k3/am62x/am625_init.c               |   2 +
>  arch/arm/mach-k3/common.c                         | 162 +++++++++++++++++++++
>  arch/arm/mach-k3/common.h                         |   4 +
>  arch/arm/mach-k3/include/mach/hardware.h          |  32 +++++
>  configs/am62ax_evm_r5_defconfig                   |   1 +
>  configs/am62px_evm_r5_defconfig                   |   1 +
>  drivers/firmware/ti_sci.c                         |  38 +++++
>  drivers/firmware/ti_sci.h                         |  14 ++
>  drivers/ram/k3-ddrss/k3-ddrss.c                   | 165 ++++++++++++++++++++++

>  dts/upstream/src/arm64/ti/k3-am62a-main.dtsi      |  12 ++
>  dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi       |  25 ++++
>  dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi    |  25 ++++
>  dts/upstream/src/arm64/ti/k3-am62a7-sk.dts        |  96 ++++++++++++-
>  dts/upstream/src/arm64/ti/k3-am62p5-sk.dts        |  50 ++++++-
>  dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi |  35 ++++-

The dts/upstream is a git subtree and is rather a snapshot of upstream
devicetree-rebasing repo. It's not allowed to directly patch it but
rather we need to resync or cherry-pick patches from upstream [1].

So rather than picking patches from ML, you should wait for them to
land in the Linux kernel for a cherry-pick to work. Or otherwise you
can choose to rely on *-u-boot.dtsi for the time being.

[1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing

-Sumit

>  include/linux/soc/ti/ti_sci_protocol.h            |   9 ++
>  21 files changed, 721 insertions(+), 18 deletions(-)
> ---
> base-commit: a517796cfa5d8f4ca2f0c11c78c24a08a102c047
> change-id: 20250306-topic-am62-ioddr-v2025-04-rc1-0b3a0ffe92b1
>
> Best regards,
> --
> Markus Schneider-Pargmann <msp@baylibre.com>
>
