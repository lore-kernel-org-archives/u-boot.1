Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517DB606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 04:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YksXn3hN;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=RQxDeK6o
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AED1381215;
	Fri, 27 Nov 2026 04:46:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EYrtPw1qC3hb; Fri, 27 Nov 2026 04:46:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3651181209
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795754817;
	b=XM2bnxKNIPm1dnBy8aYL8IJyB7DwEBfczqLNKRvidY00HIPMuj7C3oU5lzCjxF54qb/0
	 PKB0BpnVYaG45Ii1QEv9Vr5WDFCJ6/LtoWya6BK5i/iMl6yB2DqdMll5iuFnIBwI3avBq
	 o8lcMaCoWWzXujB9cmPucVc6Rku8xLzG2MbDmzVkNEXh3nyppixENfM6CUXfNu7wu8ZJP
	 Yjkg5NNGRoTVSTsdrkhf2inpGmw+8ke/R7ZjR3UjlGLuw9KB/c9qcMRjULkGqLLNqQIMi
	 Gc8zDsmnkqqgIyiS4RZUamBBKRobA6urucIm6y5xQwsLvRZXsGUVnxcK12s8pD4X2Og==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795754817;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GZ7WH8KKcnGld4GW/HbC5GYeoai69kxi65YmfmyAR4c=;
	b=SXk9Pe4K7Gq9GVZ0IkNOEgmb6LCJpxmfdvZgLNwomKOr9LDYrpiIDsomvpGfcRETLjpJ
	 LvJXiaGw/JUWLNTHLVez2ygMmJJr7fTbgM85G7Rgy3p544szLshzNA6pOkVeX114F5jiC
	 H4fKsy69TsQ9BezdH9D2+6avbIQ6VxBtYnIhVRWUF9PIsNubLxqu1HL+OaBH5bVGum1NG
	 kQSPITNPSqr4xmMxQ8RHzvuaRMO2u21E2BpR7oGRMqroz7Zb05ktnVj325sgkAT14yRcf
	 JOSy1Ecn6Ut6KQEmem6OOa9WYmxljRjESaN3LfPbmC0mN8vie6fcyDR+IgJXy16XaMQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795754817;
	bh=GZ7WH8KKcnGld4GW/HbC5GYeoai69kxi65YmfmyAR4c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YksXn3hNhH7zzAvysnzpddphPExrpnKKR1/I7qolfBYqokmgvU4VQGNmOQAzZMsZz
	 ATv0USXZ3iCr5xZpa4sleTG7pwxM4C+otsqlmHOUYHtrjbqbIwdV1t9fTT+bW5uMl9
	 Tl+xfUo5DTy3EyO8EY2uYttsKmfyDsNPUDuJTrhMEbyjLXGN56XreWDFLILFiZj55c
	 xE2gXS6AuUBVTCJfbevpMd8VcMawvK+RQCbYB3UtSvH/YVlboo07TVq8onOtmAWh+U
	 3ziFCl2jrZ/iGr27HzZsg+c3HNVChgydlGcZLju92IZ6VP2fq0bo9uRSVY3Z9q5a0f
	 MFwEkiNwtD4BQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3651181209;
	Fri, 27 Nov 2026 04:46:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 307D43D9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 04:46:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16AB060A51
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 04:46:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RAFQwYyClQMt for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 04:46:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 838EF60A4E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=RQxDeK6o
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 838EF60A4E
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 04:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795754777;
 bh=GZ7WH8KKcnGld4GW/HbC5GYeoai69kxi65YmfmyAR4c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RQxDeK6oDhM/i54i6Gy+oNXhHWX1S0c6ni5tbvICl8rbScJSBoWma4ecnaADgsrzF
 x5eXYiWDMWfwIo4k/a7gCGAk1GaH6lqSOzoFuOL2H48Yiy9EjfCgJIVx6TrzKD3HuF
 J6hsz9YuA58wTgIxlJQyOkS/NmpM4x3qwThSdOEiaaWhHhTUvo4BRPRjJimtL3FrMm
 SCBA3oSrwKBviwpuuMuw14BdoDWRqX0bJHBByrL2jJIbuFCD4omer9lB6sX4KVDXZK
 7EpV+iHMDH30jkoxnE3ga8QAjAEMtgRiIUu/4kHjM+3crP6/73NjhVRjruS+9ooAZm
 6WBguflqkxBiQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 3AF97B220221;
 Fri, 27 Nov 2026 05:46:15 +0100 (CET)
Message-ID: <c9981f92-c8b9-4fef-9944-61ca4de8c7f9@freeshell.de>
Date: Thu, 26 Nov 2026 20:46:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] riscv: spacemit: k3: Add SPL LPDDR5 initialization
To: Junhui Liu <junhui.liu@pigmoral.tech>, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>, u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@kernel.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>
References: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Junhui,

On 11/5/26 08:40, Junhui Liu wrote:
> Add initial SPL support for LPDDR5 initialization on the SpacemiT K3
> SoC.
> 
> The DDR driver follows the vendor initialization sequence, selects a
> memory profile using the DDR part number read from the board's EEPROM,
> and configures both DDR controllers and PHYs to perform LPDDR5 training.
> 
> Loading the next boot stage is not implemented yet. SPL currently
> returns BOOT_DEVICE_NONE and stops with "Unsupported Boot Device!"
> after successful DRAM initialization. No LPDDR4X boards are currently
> available for testing, so LPDDR4X support will be added in a separate
> series in the future.
> 
> Tested on 8 GiB and 16 GiB Pico-ITX boards and an 8 GiB COM260 board by
> entering BootROM USB download mode and running:
> 
> fastboot stage spl/u-boot-spl-mkimage.bin && fastboot continue
> 
> ---
> Junhui Liu (5):
>       ram: spacemit: Add DDR driver for K3 SoC
>       riscv: spacemit: k3: Add SPL initialization support
>       riscv: dts: spacemit: k3: Add SPL device and image descriptions
>       configs: spacemit: k3: Enable SPL support
>       doc: spacemit: k3: Add SPL build instructions
> 
>  arch/riscv/cpu/k3/Kconfig                      |    6 +-
>  arch/riscv/cpu/k3/Makefile                     |    1 +
>  arch/riscv/cpu/k3/spl.c                        |   52 +
>  arch/riscv/dts/spacemit-k3-binman.dtsi         |   24 +
>  arch/riscv/dts/spacemit-k3-u-boot.dtsi         |   54 +
>  arch/riscv/include/asm/arch-k3/csr.h           |   20 +
>  arch/riscv/include/asm/arch-k3/spl.h           |   11 +
>  board/spacemit/k3/Makefile                     |    5 +
>  board/spacemit/k3/spl.c                        |  127 ++
>  configs/spacemit_k3_defconfig                  |   22 +
>  doc/board/spacemit/spacemit-pico-itx.rst       |   12 +-
>  drivers/ram/Kconfig                            |    1 +
>  drivers/ram/Makefile                           |    1 +
>  drivers/ram/spacemit/Kconfig                   |    6 +
>  drivers/ram/spacemit/Makefile                  |    3 +
>  drivers/ram/spacemit/k3/Makefile               |    9 +
>  drivers/ram/spacemit/k3/k3_ddr.c               |  134 ++
>  drivers/ram/spacemit/k3/k3_ddr.h               |  169 +++
>  drivers/ram/spacemit/k3/k3_ddr_ctrl.c          |   73 ++
>  drivers/ram/spacemit/k3/k3_ddr_lpddr5.c        |  538 ++++++++
>  drivers/ram/spacemit/k3/k3_ddr_lpddr5_tables.c | 1668 ++++++++++++++++++++++++
>  drivers/ram/spacemit/k3/k3_ddr_phy.c           |  149 +++
>  drivers/ram/spacemit/k3/k3_ddr_profile.c       |   54 +
>  include/configs/spacemit-k3.h                  |    3 +
>  include/soc/spacemit/k3-ddr.h                  |   13 +
>  25 files changed, 3150 insertions(+), 5 deletions(-)
> ---
> base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
> change-id: 20261104-k3-ddr-85685cac0f02
> 
> Best regards,
> --  
> Junhui Liu <junhui.liu@pigmoral.tech>
> 

Can we enable default YMODEM load of u-boot.itb in this series? I
propose in your series:

1. SPL with DDR init and boot U-Boot main app via UART YMODEM (this series)

... and then other series applied after this:

2. Add support in SPL to check for boot signal state. Replace
unconditional YMODEM loading with depending on boot flag for BootROM
UART mode, and keep default to YMODEM loading. Effectively no change in
behavior and prepared for adding support of other boot methods.

3. Add SPI NOR boot support in SPL (Yixun)

4. Add SPL fastboot.

5. Add eMMC/SD boot (Yixun? I think mentioned this)

-E
