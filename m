Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12EEECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 10:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7456B88D8D;
	Mon,  9 Sep 2024 12:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VrVZFJOQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA86C88D8C; Mon,  9 Sep 2024 12:14:35 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5825888D89
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 12:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f75b13c2a8so24009201fa.3
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 03:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725876873; x=1726481673; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YAn+Dr2cLdku6y9yTIzZe4hdLOMhQzsulsdvyAniklE=;
 b=VrVZFJOQSgmtCIKluNXfpcll60V2pw9D5qKotYLvYS+MYDj/4pOZ0vKoetACALXjS2
 bQGda8GOQOrU3UoqBihiXhUo9cdS6oP8D9mHGqrFqCCSdDxD/TGXLPo4VXA4xUk+MZNQ
 4362wdKAjFzCLXmHcUZA5aTg+dpx3zKYp5pLnYnt0xUdnyXfiYtrzKBOC0CBlkTlkyTS
 YVzK3hd/LNppvl48QKHdNT2iGEYAWQCz37+tRZSJS/r/x/T/F1OnfwqEqHIkCoA2fdwk
 yfDecZT9x8kra/P5o26vZtFS1aKeiNSigZ86Fd7Q2RUVO2jg4Xdvt1RtFUkyfuNrCgih
 lDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725876873; x=1726481673;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YAn+Dr2cLdku6y9yTIzZe4hdLOMhQzsulsdvyAniklE=;
 b=fNCA/vnuhGaUAUWP1MG6nQ08F14kU65hI2zBy2lUH/RRJH0iQzbgM24E6noGuLvdsZ
 WRUNL0bZHkRSWOAwRY9SsIGgYPlkIND3oO5lnB5X7CaC+DdQGZGL3OLAvyB+Et0yj9wT
 x/eoJEi/XT9pvAQ/OLXYQTWar8qCZh8FAaVPv9TJZo80v7l54Fh8UiZ7pGd7UAY/pP58
 3yAiwDcKDnR+QyEWkmxJyJhG17R990/sp5gDFzSHPXNhGe5G9EH7bI5x9hROOCIWj5HF
 eVNv+sglVXLBPHNaVq0qnJ8ogDCocmkhReX2CAY7Nu26fDYz5ntSM9hUz8Yx8XFB+0Wh
 1qeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYQCB4mIJJ64GTT440NxDnxuTrBN9Eiv/U5ZOY9eT9DcqMY4ZtK07WWQSR++jbaQoWhhyEViw=@lists.denx.de
X-Gm-Message-State: AOJu0YwKnTwIZnVRn+mS9QM9skKDvyvm/3QXZuvTBBCTp27rjqqhjA2z
 Ut8VeAfMC7h4huXKJXVc3tRlgfKyT9Xp0iw9lXT5rJKDKSpsYfQba5dkDapDgOY=
X-Google-Smtp-Source: AGHT+IHj8hjZpB0cbEsDwJGBCNvjh5OqhZVTyWfH4ajAK3OnJYL5uMYEejVE6UMorOCYkCOB60Dzfg==
X-Received: by 2002:a2e:602:0:b0:2f5:1fa7:ac3a with SMTP id
 38308e7fff4ca-2f751f671fcmr52750941fa.28.1725876872438; 
 Mon, 09 Sep 2024 03:14:32 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8db? ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd76ef0sm2832581a12.63.2024.09.09.03.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 03:14:31 -0700 (PDT)
Message-ID: <82c398d1-c5ef-48b2-8cf1-fa4d692b1865@linaro.org>
Date: Mon, 9 Sep 2024 12:14:31 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PULL] Please pull qcom/qcom-next
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20240909101245.1302713-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240909101245.1302713-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

(Mixed up the mailing list address)

On 09/09/2024 12:04, Caleb Connolly wrote:
> Hi Tom,
> 
> Various improvements to Snapdragon support:
> 
> * Bumped up the pagetable size to handle newer SoCs with much more RAM
> * Made memory map parsing more robust, fixing chainloading on SM8550/SM8650
> * Populate fdt_addr_r with U-Boot's FDT by default, and set $loadaddr to prevent
>   crashes with some commands which expect it
> * Added initial support for SC7280/QCM6490 and the new RB3 Gen 2 board
> * Add debug config fragments to enable debug UART on some SoCs.
> * Enable RPMh regulators on SM8550/SM8650
> * Map the cmd-db memory explicitly since it may not be in the memory map
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/22255
> 
> Thanks,
> 
> The following changes since commit cbaf53fdf12534be50075fdd84105c682955424f:
> 
>   mmc: consider cd-gpios in Synopsys DesignWare driver (2024-09-05 19:08:14 -0600)
> 
> are available in the Git repository at:
> 
>   git@source.denx.de:/u-boot/custodians/u-boot-snapdragon.git HEAD
> 
> for you to fetch changes up to 41864bb2b66d0c68e6b2f6ae0c70d3c239ad258d:
> 
>   board/qualcomm: add debug config fragments for some SoCs (2024-09-06 11:59:51 +0200)
> 
> ----------------------------------------------------------------
> Caleb Connolly (18):
>       mach-snapdragon: refactor board_fdt_blob_setup()
>       mach-snapdragon: parse memory ourselves
>       mach-snapdragon: set serial number
>       mach-snapdragon: allocate fastboot buffer dynamically
>       mach-snapdragon: populate fallback FDT
>       mach-snapdragon: set loadaddr
>       armv8: mmu: add a way to map additional regions
>       soc: qcom: cmd-db: use strncmp() instead of memcmp()
>       soc: qcom: cmd-db: map cmd-db region
>       qcom_defconfig: bump CONFIG_NR_DRAM_BANKS
>       clk/qcom: add initial clock driver for sc7280
>       dts: qcs6490-rb3gen2-u-boot: add override dtsi
>       dts: qcs6490-rb3gen2-u-boot: USB host mode
>       iommu: qcom-smmu: add sc7280-smmu-500 compatible
>       qcom_defconfig: enable SC7280 clocks
>       configs: add qcm6490_defconfig
>       doc: board/qualcomm: document rb3gen2 building/flashing
>       board/qualcomm: add debug config fragments for some SoCs
> 
> Neil Armstrong (3):
>       mach-snapdragon: use 1MiB for get_page_table_size()
>       soc: qcom: rpmh-rsc: add back __tcs_set_trigger() for SM8550/SM8650
>       regulator: qcom-rpmh-regulator: add support for PM8550 & related regulators
> 
>  MAINTAINERS                                   |   1 +
>  arch/arm/cpu/armv8/cache_v8.c                 |  25 ++++
>  arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi      |  28 ++++
>  arch/arm/include/asm/system.h                 |  10 ++
>  arch/arm/mach-snapdragon/board.c              | 204 ++++++++++++++++++++++----
>  board/qualcomm/debug-sdm845.config            |   5 +
>  board/qualcomm/debug-sm6115.config            |   5 +
>  board/qualcomm/debug-sm8250.config            |   5 +
>  configs/qcm6490_defconfig                     |  21 +++
>  configs/qcom_defconfig                        |   2 +
>  doc/board/qualcomm/index.rst                  |   1 +
>  doc/board/qualcomm/rb3gen2.rst                |  53 +++++++
>  drivers/clk/qcom/Kconfig                      |   8 +
>  drivers/clk/qcom/Makefile                     |   1 +
>  drivers/clk/qcom/clock-qcom.h                 |   1 +
>  drivers/clk/qcom/clock-sc7280.c               | 132 +++++++++++++++++
>  drivers/iommu/qcom-hyp-smmu.c                 |   1 +
>  drivers/power/regulator/qcom-rpmh-regulator.c | 136 +++++++++++++++++
>  drivers/soc/qcom/cmd-db.c                     |  11 +-
>  drivers/soc/qcom/rpmh-rsc.c                   |  43 ++++++
>  20 files changed, 664 insertions(+), 29 deletions(-)
>  create mode 100644 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
>  create mode 100644 board/qualcomm/debug-sdm845.config
>  create mode 100644 board/qualcomm/debug-sm6115.config
>  create mode 100644 board/qualcomm/debug-sm8250.config
>  create mode 100644 configs/qcm6490_defconfig
>  create mode 100644 doc/board/qualcomm/rb3gen2.rst
>  create mode 100644 drivers/clk/qcom/clock-sc7280.c

-- 
// Caleb (they/them)
