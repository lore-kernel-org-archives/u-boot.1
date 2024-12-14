Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7A6E7716A
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 06:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 394E8800B2;
	Sat, 14 Dec 2024 07:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="muiRkqeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99A6A800B3; Sat, 14 Dec 2024 07:52:41 +0100 (CET)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01ABC800B1
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 07:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2166360285dso22391955ad.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 22:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734159156; x=1734763956; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a7TZoXQUBb4ggGbZhR95vqcyKSS7oT4rsRtUFnlkUh8=;
 b=muiRkqeQuMPqP5krCXPF7XpcYFb0AKzxYHIqymZAfyqkCGm6w3SYQvVqyUh3NXEZUw
 wOeslWAyPtKVCKDlInMroHGTnqpUE0xq7vgiFo5wUtR7EibeRUxKgnbFTqwlmWesh/Dq
 e+bFmVDRUA6rpAII2QbXGXepeAUnw6ni54jUoGLc4U3y1vy6QHI7R/v5z1JSvyxG6ZtV
 S4/vwGLiVGB7zTw3BW2Q1vEBO0Oo3YIDM/fd2Iehd9lcNJ6ovtx6FJcTwqP0ydd0u6Xe
 /N3K5qcYRILMe7UaFB49/ISHnKDfMDFLkKR8F/K0RqxFbJX+VALEGrOPIbet7A/ZVLgG
 Jw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734159156; x=1734763956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7TZoXQUBb4ggGbZhR95vqcyKSS7oT4rsRtUFnlkUh8=;
 b=n4bR7jzSKpWSsauVztK0+2oVsN0eGd/3gowWoGSA0tuOccLcDYaZK3m73qhT+e/XbL
 2Aq1Tl+u7kIMYlPk6MjgjvPU9heeAlvzkTKhbjbrsWQfhyOaNsw0w1Dmowk9hO2q8QKB
 oQnu+S9OV1T4cEWFOow4YfumRBgGwWRdNe9zken7LUF1qr6TQbVwBV8SCCXBhcJt+H+n
 T18rRlgq+pUe84jFVh77O0c5HvxrY8wvzNY1/d4EdBJ7G4a5IkQbaWZTo2C4+TmGhVMd
 5HVLi4dbhis5UAhpfj5DP50rmJt1f6/Dp6M0T4Ek8PfYNnW8czEmdHcIyPEU99gxp8oy
 hwOw==
X-Gm-Message-State: AOJu0Yw73GM8NxmtAYD/1938nHzxjnCLduU2/evIzDWyJ6YcPC9znl3t
 rTjQ893LoY/r4qtSnkya20zwbhvE/qNTKjYGysYmUfB0bCZI7rH38aC56mC+LLMKV9O/
X-Gm-Gg: ASbGncvUGRdvyQVC0zDOVNU4SQeB2y49zkSI4rM5n/HKlG2wDCMPMGVyxkoVDIwp7nl
 60lAb7dnEpUTyGEmBoT9efNcFstsKhputcmLiYA8dE8TA7w8Cd1ganHpIRQLpNmSiac3tEJqTlT
 x2yYamHmY4SToHmZhGWSW0VrcFFKBSTus3gLG5GBp3W5vkWC0DowyoIunwGQVB7LyYKxgqob/6e
 GFoiuPog1gEA6CpyzhUQeRVLD/qS6+LFyp0zD24FCCf59McIjMUpJgmqb+Lk94nK+O1tTA3AZkZ
 89zcKQ4PmGuMlBrHcSwQ1BAl8Q==
X-Google-Smtp-Source: AGHT+IEY7ZNPHqeSz/ZpBGWecSWpuxegz6mczlSipz8SNzD2lZ0xdiM+8aj0xKNO3rm2zyKhUcnsoQ==
X-Received: by 2002:a17:902:e88e:b0:215:7dbf:f3de with SMTP id
 d9443c01a7336-218929ff6cbmr79330665ad.28.1734159156426; 
 Fri, 13 Dec 2024 22:52:36 -0800 (PST)
Received: from per1cycle.per1cycle (n220246100016.netvigator.com.
 [220.246.100.16]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e501dbsm7197985ad.153.2024.12.13.22.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 22:52:35 -0800 (PST)
Date: Sat, 14 Dec 2024 14:52:27 +0800
From: Huan Zhou <pericycle.cc@gmail.com>
To: u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Yixun Lan <dlan@gentoo.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas =?utf-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Padmarao Begari <padmarao.begari@amd.com>
Subject: Re: [PATCH v6 0/2] riscv: spacemit: add support for bananapi-f3
Message-ID: <20241214065227.ebzq66trwo7tonjm@per1cycle.per1cycle>
References: <20241214-pickup-bpif3-v6-0-306355826455@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214-pickup-bpif3-v6-0-306355826455@gmail.com>
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

This version of patch does need addition review or test, only small comment change and 
another doc update.

On Sat, Dec 14, 2024 at 02:44:59PM +0800, Huan Zhou wrote:
> Banana Pi F3 board is a industrial grade RISC-V development board, it
> design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
> computing power. 4G DDR and 16G eMMC onboard. 2x GbE Ethernet port, 4x USB
> 3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.
> 
> This patch introduces fundamental support for the Banana Pi F3 board,
> encompassing UART, CPU, and PLIC support. This ensures that U-Boot can
> operate in serial console mode.
> 
> Changes in v6:
> - Rebase the patch to the latest branch.
> - Add small comment in bananapi-f3.h
> - Add tag in previous patch(e.g reviewed by or tested by)
> - Add fastboot burn procedure in doc.
> - Link to v5: https://lore.kernel.org/r/20241209-pickup-bpif3-v5-0-92f801b7c6c1@gmail.com
> 
> Changes in v5:
> - Formal the name from Bananapif3 -> Banana Pi BPI-F3
> - Trailing whitespace
> - New blank line at EOF in spacemit/index.rst
> - Link to v4: https://lore.kernel.org/r/20241129-pickup-bpif3-v4-0-e99fabf66e33@gmail.com
> 
> Changes in v4:
> - Change uart compatible in k1.dtsi in v3, cause related driver in not implemented in u-boot.
> - Update doc, show how to validate the patch.
> - Update maintainer, remove kongyang cause he lefted.
> - Link to v3: https://lore.kernel.org/r/20241114-pickup-bpif3-v3-0-98a45802ab79@gmail.com
> 
> Changes in v3:
> - Add base commit
> - Clear redifinition warning while building in UART_IIR_ID
> - Change underscore to dash in bananapi*f3
> - Update maintainer
> - link to v2 https://lore.kernel.org/u-boot/20240718043329.1500-1-seashell11234455@gmail.com/
> 
> Changes in v2:
> - Change license to GPL-2.0-or-later
> - Add memory node for dts
> - Add ft_board_setup function for kernel memory init
> - Use default prompt
> - links to v1 https://lore.kernel.org/u-boot/20240714150828.736-1-seashell11234455@gmail.com/
> 
> Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
> ---
> Kongyang Liu (2):
>       riscv: spacemit: bananapi_f3: initial support added
>       doc: spacemit: bananapi_f3: document Banana Pi F3 board
> 
>  arch/riscv/Kconfig                     |   5 +
>  arch/riscv/cpu/k1/Kconfig              |  18 ++
>  arch/riscv/cpu/k1/Makefile             |   6 +
>  arch/riscv/cpu/k1/cpu.c                |   9 +
>  arch/riscv/cpu/k1/dram.c               |  54 ++++
>  arch/riscv/dts/Makefile                |   2 +
>  arch/riscv/dts/k1-bananapi-f3.dts      |  25 ++
>  arch/riscv/dts/k1.dtsi                 | 459 +++++++++++++++++++++++++++++++++
>  board/spacemit/bananapi-f3/Kconfig     |  25 ++
>  board/spacemit/bananapi-f3/MAINTAINERS |   6 +
>  board/spacemit/bananapi-f3/Makefile    |   5 +
>  board/spacemit/bananapi-f3/board.c     |   9 +
>  configs/bananapi-f3_defconfig          |  20 ++
>  doc/board/index.rst                    |   1 +
>  doc/board/spacemit/bananapi-f3.rst     | 106 ++++++++
>  doc/board/spacemit/index.rst           |   9 +
>  include/configs/bananapi-f3.h          |  13 +
>  17 files changed, 772 insertions(+)
> ---
> base-commit: b0b6d0c87082813aada4c052a8b4e20c257dbbda
> change-id: 20241112-pickup-bpif3-245ab208b9a4
> 
> Best regards,
> -- 
> Huan Zhou <pericycle.cc@gmail.com>
> 
