Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EEBC87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 11:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 262B583A4B;
	Fri,  1 Aug 2025 13:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="FayBXJmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FFC583A56; Fri,  1 Aug 2025 13:24:02 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED205839F1
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 13:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-61530559887so1960250a12.1
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 04:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1754047439; x=1754652239;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pWGgi/dHoVN3xRID8DepX1hdqiR7vw/TAMyZkSWalMw=;
 b=FayBXJmC4TIj/nQtCYxjtLFA2QxrE5MAg+Dr3HTX9myGg7xnFoDIIohNvAbO00iDtV
 YroTVPXOhsXgwZaX8PMvqIG0gN7rQIRF092fKlMg6wR48V95x4gL+rn+DAGpPR4Uhruz
 OxkxeXd3mmkG+2nyP7NFEQuuNY1RmqF30Ayo3unCN3IH7C0Q+Xm6yeRa0uZWh8fG/qwl
 UUJ/RJfNuZcwtiB2mMkaDopuejrYhldiD5fjgTOFqKr4PjrhfUrAZoHY2hWXw62Jh2/X
 srADNqmdfbkeiFcIaL1g5U3w3eg088JLA9gMX30RBP23nNus6q3RAzn+cDfMpXuPFtma
 PtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754047439; x=1754652239;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pWGgi/dHoVN3xRID8DepX1hdqiR7vw/TAMyZkSWalMw=;
 b=kPeApwnFElwaufAQ13JvfvNJJ7Pgt2pfVwHoIG40aUJiXkAqwucKDtKNm4LeCgAz0a
 tuJNt67mPk9Jtb43ClxDa/8gAPr5Kb/Q+tOCSbI2L1VlElLYMO/YczPtub0YaVzuoQ5o
 huJSSrntfigBmn+ENBekG75K+a+ARZFCna6Z1eqMAQBYJVmW4CfpxzR9qgjaV2GT56+C
 5LhrIU14aiiE0VFjQfahRN5WymeoksrV92oNIkijPcx72xLYkUhQk3MwhsG8+qIV1C9V
 36RPEJCHqqNzaRHA79+b7+dFh8qtHFi2wNaHvSpq0YBjY3iiMgfQfg7Qr5X2F8XZnVe9
 dM7Q==
X-Gm-Message-State: AOJu0YyRBVI8r5uyD1tDbE4nSxSzNfkoY0JXTPxSl6YaVRNRnZFq55wi
 hWe5zwHXSkI3JscOakegmWiJh9bIJRzoWBtZgMs6Y7DcNfAcOc58EGhYpo1X9t2FmQJ0vQdqHLR
 tHvG+o6Ol
X-Gm-Gg: ASbGnctOK4gzZyUXC0dKgZlLxGa/Pgoa+e3mDrTPF0sE3mbbfKDzahBsZUaBnMRG4f8
 D+ICVRvu78wFuENKItbslgZW0wKoZCd8q0JVT1dr/fWB4pNv/k6NQrtAFFDtEenOGgAsSYJVltt
 vQ+6Guvd2szmhrVblQyQH8FI594oxJzXpf7e9zEs8AWslTiEx5+JRA6MUSR0ROMNd+d8Qbl6AdT
 d5YBJaHNEi0mIbqwjoSw/qUZs2jvFdqkCfma+0QYCVYGhJJIkoaVQrWD2DHgI1PseEjpAWRuQDr
 2CyNqfmUdyCEyQyk7wsTeTM/Bolf8K3IiO2CuIZELzz+MTBHMfFUHTfjhTEI8Lj91lh2aOGAAy2
 7Hwt6kjw/4leZ43k2BNuvvIhR
X-Google-Smtp-Source: AGHT+IHg1EaBu7BfTFV5oOIq4Jz6iU6MnFd0RHMz8LASk5SfapvErp7ZjHz2IqbZ67D8/Sy4gwoDWQ==
X-Received: by 2002:a05:6402:5242:b0:615:7fd8:d955 with SMTP id
 4fb4d7f45d1cf-61586f015bbmr11500926a12.3.1754047438444; 
 Fri, 01 Aug 2025 04:23:58 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615cc38ae55sm1110877a12.10.2025.08.01.04.23.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 04:23:58 -0700 (PDT)
Message-ID: <86d37d14-0975-440b-8aec-40f6bd76093b@monstr.eu>
Date: Fri, 1 Aug 2025 13:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] xilinx: mbv: Prepare MBV for CI
From: Michal Simek <monstr@monstr.eu>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marex@denx.de>, Padmarao Begari <padmarao.begari@amd.com>,
 Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
References: <cover.1753182218.git.michal.simek@amd.com>
Content-Language: en-US
In-Reply-To: <cover.1753182218.git.michal.simek@amd.com>
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



On 7/22/25 13:03, Michal Simek wrote:
> Hi,
> 
> this patch series is fixing issues reported by dt-schema and all 4
> combinations are tested on Qemu to be able to wire them in CI.
> U-Boot hooks changes are sent here
> https://lore.kernel.org/r/82725079ee90362468fe8096db24ef2959725af9.1753181505.git.michal.simek@amd.com
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (4):
>    xilinx: mbv: Disable OF_HAS_PRIOR_STAGE
>    xilinx: mbv: Add missing mmu-type cpu property
>    xilinx: mbv: Fix dt properties in interrupt controller node
>    xilinx: mbv: Use separate DTB for binman nodes
> 
>   arch/riscv/dts/Makefile              |  1 +
>   arch/riscv/dts/xilinx-binman.dts     | 12 ++++++++++++
>   arch/riscv/dts/xilinx-mbv32.dts      |  8 ++++----
>   arch/riscv/dts/xilinx-mbv64.dts      |  8 ++++----
>   board/xilinx/mbv/Kconfig             |  1 -
>   configs/xilinx_mbv32_defconfig       |  1 +
>   configs/xilinx_mbv32_smode_defconfig |  1 +
>   configs/xilinx_mbv64_defconfig       |  1 +
>   configs/xilinx_mbv64_smode_defconfig |  1 +
>   9 files changed, 25 insertions(+), 9 deletions(-)
>   create mode 100644 arch/riscv/dts/xilinx-binman.dts
> 

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

