Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FBEE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 04:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E0D580141;
	Sun, 15 Dec 2024 05:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YFAOc3Gn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0224280092; Sun, 15 Dec 2024 05:55:17 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C13800B2
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 05:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-801c8164ef9so1245115a12.1
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 20:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734238509; x=1734843309; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5rZ4xlLIzc6DU/Bs00BKeQvKCLFPhbQhSqZ8inp2mEg=;
 b=YFAOc3Gn2q+G2WXXXCOGaszWPrsQ/MEvCFXYIhs0f64Fr+PEKXdMCi7rkE3pY7fcPe
 KnduwLgX1HywqlhRGxXy1C6SDstURlLXxzEMiosOaOWCmtGPQ8TA0Tz6y/9F2bho6RoH
 R1uEzeX1C6j3DIY2f7lTk0ZbnvcLEZ2aXJNWWKBtskiVqP87fUCEIxDWGW/wvNZmM6pu
 2emWryJZP2/+nSUd0mPL7npNezZbwun+XTYl4dCgsKvBVRyHz4kZQYvWKBUKOQDluVEb
 ZyCDrCSBVYpWfsUm1GCInmJKcPSO5zK/OrPrhGOH8xcW1lNuvsou6Wa6yRTGhI864HFR
 yYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734238509; x=1734843309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5rZ4xlLIzc6DU/Bs00BKeQvKCLFPhbQhSqZ8inp2mEg=;
 b=Agj83K1uxHYG3Qol2b9GRA8hyxoPC3V7llIa1O4hb4fjCJK91z7LBZjg83WFmCm8Kd
 JhdMZAEmaWZjv8Oz4jU/ZEM9FT/gOBEyX53+CRUcuDLx7vJw0UJisr1KUZpYBlKY3233
 YGMBr4W8nOJhIpDPS21SE/5KLlQsnm0Npdv+dcSlg4TUPqFfPUKs+gtIMiDPkCrq8p3W
 5ZJiJ8X3dLBuLqssKkIfl5t9qkrbgD/WYdMGtMM835Y7/sythRnujUOER+RLij5GwoI5
 5h2A0nXnua9euOHYBlU2c5xqAVHWonXH5lzs/KG/fVsac71DaQ/IqAlwwYft5tGGb4ex
 BjQQ==
X-Gm-Message-State: AOJu0YwrBoPafZUJgWRk1zu+/4Rn0OO6xesBxXET9qIG4VoagBjW9C5B
 cZm7YrFeeZdBwZBdw1kYksNvYNgOKH6jqSpv1lXE6ujw4gUetr2A
X-Gm-Gg: ASbGncthL0WdwxJUzN5eTMRYhmuT+7B/WAUx9XvGqpF5mOdtqTezxQkT0TTKYHj9Iwx
 Ku2nOWbKx+6NJVywD6WREgvP8DNb7JVe8rujElv66AlDtuflHxYhKcYiPlwfQuAHins2tzpQTKy
 5LqrOl99ssmTy2bant18E/yGaQOgpQyzk4tEFcnwqE1W/IkzdwWyF0VuObfXJOgx/Qf6s1dT2/m
 1XtlHH/lxMv5XDgepfxD452o3H4yTWctP0tLlxdv1GqD0uq6ui/uXuqXSuDslBdEVvSrHq7x8zs
 uu1im/w/zjmMDmSB8bnEAaSSrQ==
X-Google-Smtp-Source: AGHT+IFL35BGInAfh+ezi4b/Osu+KdZWqAh7jia6ahVVFco8nBukQc9PmIMoloYd/0sGQzn3BMuHDQ==
X-Received: by 2002:a17:90b:1b12:b0:2ea:61c4:a443 with SMTP id
 98e67ed59e1d1-2f13ab737edmr18873182a91.4.1734238509274; 
 Sat, 14 Dec 2024 20:55:09 -0800 (PST)
Received: from per1cycle.per1cycle (n220246100016.netvigator.com.
 [220.246.100.16]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6c110sm20617095ad.257.2024.12.14.20.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Dec 2024 20:55:08 -0800 (PST)
Date: Sun, 15 Dec 2024 12:54:57 +0800
From: Huan Zhou <pericycle.cc@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Ben Dooks <ben.dooks@codethink.co.uk>,
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Yixun Lan <dlan@gentoo.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
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
Subject: Re: [PATCH v7 2/2] doc: spacemit: bananapi_f3: document Banana Pi F3
 board
Message-ID: <20241215045435.xuvcqxwkt2ekkqsq@per1cycle.per1cycle>
References: <20241214-pickup-bpif3-v7-0-d0cd91146f7b@gmail.com>
 <20241214-pickup-bpif3-v7-2-d0cd91146f7b@gmail.com>
 <1D6B2290-5522-4456-BB2A-BE5392E28452@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1D6B2290-5522-4456-BB2A-BE5392E28452@gmx.de>
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

On Sat, Dec 14, 2024 at 10:31:40PM +0100, Heinrich Schuchardt wrote:
> Am 14. Dezember 2024 08:30:22 MEZ schrieb Huan Zhou <pericycle.cc@gmail.com>:
> >From: Kongyang Liu <seashell11234455@gmail.com>
> >
> >Add document for Banana Pi F3 board which based on SpacemiT's K1 SoC.
> >
> >Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> >Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> >Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
> >Reviewed-by: Yixun Lan <dlan@gentoo.org>
> >---
> > doc/board/index.rst                |   1 +
> > doc/board/spacemit/bananapi-f3.rst | 106 +++++++++++++++++++++++++++++++++++++
> > doc/board/spacemit/index.rst       |   9 ++++
> > 3 files changed, 116 insertions(+)
> >
> >diff --git a/doc/board/index.rst b/doc/board/index.rst
> >index b54c1748d57ece029f0f3ab829956dc893e7f5d7..b1c470eb2cbb1c07f907eb2282039520c219c72a 100644
> >--- a/doc/board/index.rst
> >+++ b/doc/board/index.rst
> >@@ -55,6 +55,7 @@ Board-specific doc
> >    sipeed/index
> >    socionext/index
> >    sophgo/index
> >+   spacemit/index
> >    st/index
> >    starfive/index
> >    ste/index
> >diff --git a/doc/board/spacemit/bananapi-f3.rst b/doc/board/spacemit/bananapi-f3.rst
> >new file mode 100644
> >index 0000000000000000000000000000000000000000..54b412775e458ee7a8cd436d7a1f1c6ac70744f6
> >--- /dev/null
> >+++ b/doc/board/spacemit/bananapi-f3.rst
> >@@ -0,0 +1,106 @@
> >+.. SPDX-License-Identifier: GPL-2.0-or-later
> >+
> >+Banana Pi BPI-F3
> >+============
> >+
> >+Building
> >+~~~~~~~~
> >+1. Install the spacemit riscv cross compile toolchain_, or skip it if riscv toolchain is installed.
> 
> Thanks a lot for providing the documentation. Just some nits:
> 
> %/spacemit/SpacemiT/
fix, thx:)
> 
> >+
> >+.. _toolchain: https://archive.spacemit.com/toolchain/
> >+
> >+2. Setup cross compilation environment variable:
> >+
> >+.. code-block:: console
> >+
> >+   export CROSS_COMPILE=<riscv64 toolchain prefix, e.g /opt/spacemit/bin/riscv64-unknown-linux-gnu->
> >+
> >+3. Before building U-Boot, OpenSBI should be built first. OpenSBI can be
> >+built for SpacemiT K1 SoC as below:
> >+
> >+.. code-block:: console
> >+
> >+   git clone https://github.com/cyyself/opensbi -b k1-opensbi
> >+   cd opensbi
> >+   make PLATFORM=generic
> >+
> >+4. Then build U-Boot as following:
> >+
> >+.. code-block:: console
> >+
> >+   cd <U-Boot-dir>
> >+   make bananapi-f3_defconfig
> >+   make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
> >+
> >+This will generate u-boot.itb
> >+
> >+Burning
> >+~~~~~~~~
> >+Actually, we can replace the uboot part
> 
> %s/part/partition/
> 
>  from bianbu linux which is the bsp_ to
> 
> %s/from bianbu linux/of Bianbu Linux/
> 
> Bianbu Linux may be a part of the board support package but it is not the complete BSP. So how about:
> 
> which is provided as part of the BSP
> 
From bianbu linux official link[1], it writes:
```
Bianbu Linux is the BSP (Board Support Package) for the Spacemit Stone series chips, including the SDK (Software Development Kit). 
```

Link: https://bianbu-linux.spacemit.com/en/ [1]
i think is should be the complete bsp(include linux, opensbi and u-boot in the img it provide)...

>  validate  patch,
> >+use `balena etcher` to burn the bianbu-minimal.img to the sd card,
> >+and replace the /dev/sdx4 where places the uboot_ with the `u-boot.itb` generated from this patch.
> >+Or use fastboot:
> >+Collect FSBL.bin, u-boot.itb, partition_2M.json, bootinfo_spinor.bin
> >+u-boot-env-default.bin, fw_dynamic.itb from vendor sdk
> 
> %s/sdk/SDK/
Got it.
> 
> Best regards
> 
> Heinrich
> 
> >+
> >+.. code-block:: console
> >+
> >+   fastboot stage FSBL.bin
> >+   fastboot continue
> >+   fastboot stage u-boot.itb-vendor # the itb from vendor uboot
> >+   fastboot continue
> >+
> >+   fastboot flash mtd partition_2M.json
> >+   fastboot flash bootinfo bootinfo_spinor.bin
> >+   fastboot flash fsbl FSBL.bin
> >+   fastboot flash env u-boot-env-default.bin
> >+   fastboot flash opensbi fw_dynamic.itb
> >+
> >+   fastboot flash uboot u-boot.itb-mainline # the itb from mainline uboot
> >+
> >+.. _bsp: https://archive.spacemit.com/image/k1/version/bianbu/v2.0/
> >+.. _uboot: https://bianbu-linux.spacemit.com/en/device/boot#21-firmware-layout
> >+
> >+Booting
> >+~~~~~~~
> >+Sample boot log from Banana Pi BPI-F3 board
> >+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >+.. code-block:: none
> >+
> >+   try sd...
> >+   bm:3
> >+   j...
> >+
> >+   U-Boot SPL 2022.10spacemit-dirty (Oct 21 2024 - 09:01:13 +0000)
> >+   [   0.279] DDR type LPDDR4X
> >+   [   0.292] lpddr4_silicon_init consume 13ms
> >+   [   0.293] Change DDR data rate to 2400MT/s
> >+   [   0.430] ## Checking hash(es) for config conf-1 ... OK
> >+   [   0.432] ## Checking hash(es) for Image opensbi ... OK
> >+   [   0.437] ## Checking hash(es) for Image uboot ... OK
> >+   [   0.443] ## Checking hash(es) for Image fdt-1 ... OK
> >+   [   0.488] ## Checking hash(es) for config config_1 ... OK
> >+   [   0.490] ## Checking hash(es) for Image opensbi ... crc32+ OK
> >+
> >+
> >+   U-Boot 2024.10-rc4-00462-g5b138cfcc587-dirty (Nov 28 2024 - 14:56:49 +0800)
> >+
> >+   DRAM:  4 GiB
> >+   Core:  19 devices, 8 uclasses, devicetree: separate
> >+   Loading Environment from nowhere... OK
> >+   In:    serial@d4017000
> >+   Out:   serial@d4017000
> >+   Err:   serial@d4017000
> >+   Net:   No ethernet found.
> >+   => cpu list
> >+   0: cpu@0      spacemit,x60
> >+   1: cpu@1      spacemit,x60
> >+   2: cpu@2      spacemit,x60
> >+   3: cpu@3      spacemit,x60
> >+   4: cpu@4      spacemit,x60
> >+   5: cpu@5      spacemit,x60
> >+   6: cpu@6      spacemit,x60
> >+   7: cpu@7      spacemit,x60
> >+   => test
> >+   =>
> >+
> >diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
> >new file mode 100644
> >index 0000000000000000000000000000000000000000..e7d3d94e4599fbeb8da16c8a837e777a0be06227
> >--- /dev/null
> >+++ b/doc/board/spacemit/index.rst
> >@@ -0,0 +1,9 @@
> >+.. SPDX-License-Identifier: GPL-2.0-or-later
> >+
> >+SpacemiT
> >+========
> >+.. toctree::
> >+   :maxdepth: 1
> >+
> >+   bananapi-f3
> >+
> >
> 
