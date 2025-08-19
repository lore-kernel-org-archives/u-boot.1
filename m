Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC050CA0EF5
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 08:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E75A282BF6;
	Tue, 19 Aug 2025 10:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="sxFTYbK2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1340F82D88; Tue, 19 Aug 2025 10:48:59 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3361780FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6188b73bef3so9100784a12.3
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 01:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1755593336; x=1756198136;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=y94xqTbFgyD/KdFYon9+rTtAVg9OiH1rlaOFwjVj1AU=;
 b=sxFTYbK2x9Fzux3AyqtvqkF9PydvHe7m6wshgvxvf4lkLBNhskgbQzcQnFHJWHJ+/G
 yoh3LAVTpR/2T+1xZoc+9sKJnnpM+FldP/0LLPri+s4Qn4e4UEcpbKvadmoZL9MQcgBk
 zWPGAsB7U78VaUUKEBQKi2g7su+Sn0hcr3kLLaTf+jqbrEs093xACuxc6+VCT2YKFgL9
 w5JGoTNX5oHPXabQtpcsi2GuKUOEJ8lyUMthm/jl53Jxd6rScsCUZd6+FrawYA/NvPxc
 H7DH7SQgq7cZlq4bsKa17+LRBrjHNamtvxx0WZYrUOhyDkIiv4CFsTr7M5NnPVHYcMQ0
 AQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755593336; x=1756198136;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y94xqTbFgyD/KdFYon9+rTtAVg9OiH1rlaOFwjVj1AU=;
 b=PbwRYcOnkw0zUKumNRzskWL7ZrNE7bKzZUiCk+eY881/SJpYH68CLVjoA5KGSul3yi
 diKdu17uNu/HRYRLd8+YKx/CsllwcNrRYeQjqqt63OQSXBE7sr5ccjwrbYFT77jVD0zM
 YjMRm3pafwWZKlGEupbgEKxE0muNut1L7yX0TKbwbhOxBAOFe5vDUkYaD+yMpQg08XMw
 ifLyQis5CyzbSd9/K68+R8K9nkTj8pC3T2dBJPZ3XnuDsNvWXAvUKompG9HIMoIHiYYB
 BQ6CuGOMPK1zCh/+ZX0Xy6Wrui7j+xNpxYEkoVQXHsQx3Tk30tN0ZOZ81pB6rZvMw8MX
 CPPQ==
X-Gm-Message-State: AOJu0YxdXXFl1rMPggxHFd9osku//CnYX7V3ySK79cSVmxDPVqtnBG9b
 H6XhKbiKHd6U9Ug6gu3rzWab8BlVPUPPqmISpECIdY1lqQOfJwD/CmUJj6E2oWnE4MLdJMcgDP3
 /UylnUzLe
X-Gm-Gg: ASbGncsUp/bhFMuI1G28OCPGVOGCWRVjq/I76XJwaVr6xtI6vPShautTd+apv0AVHha
 XIwMzMO+N0yi6SAlZ8uYp3kmocgOaxhe+l5gRZNReb6FCG555ECcRkclbFhbo2bK67JJuw9aLTM
 pw5h1dlZ/8wmzV3fTMLec8bdu98IGbBvpx5oH95djJrH4bz4D8XTJW7mGeb5+3RmC0KR/W6OGGr
 J3/qRkwYdbFmhzcp82NCcBHzU1wTad4xzCMGBbag2QoD5Alug09o5sKAl3d586yImIf2t7cBb0M
 rJVbiiMufPZq/53p5qwcJFSeVDAMK5+JyZHTqIAnAcFSU/wfnJiU6jy8xx38G5jOUmvzev0KSvI
 sy1XWV/8+YH2wYSc4lQsZZKCI
X-Google-Smtp-Source: AGHT+IEoPxMfcqf3oZknU+DILaBq7TNXpW/2fMrxc2C0x3yvV/3G6r0b9DRfDDpOs+hz1CgN+f3p0w==
X-Received: by 2002:a05:6402:1d4d:b0:615:4106:9c10 with SMTP id
 4fb4d7f45d1cf-61a7e7473a5mr1496498a12.17.1755593336355; 
 Tue, 19 Aug 2025 01:48:56 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61a75778c5dsm1325203a12.31.2025.08.19.01.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 01:48:55 -0700 (PDT)
Message-ID: <3dcc839f-2700-4074-a8b7-99c2a1e0d069@monstr.eu>
Date: Tue, 19 Aug 2025 10:48:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] fpga: Remove lattice and ACEX1 support
From: Michal Simek <monstr@monstr.eu>
To: u-boot@lists.denx.de, git@xilinx.com, p.bruenn@beckhoff.com
Cc: Alexander Dahl <ada@thorsis.com>, Alexander Graf <agraf@csgraf.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <cover.1753686468.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1753686468.git.michal.simek@amd.com>
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



On 7/28/25 09:07, Michal Simek wrote:
> Hi,
> 
> when fpga drivers were enabled via sandbox some coverity issues came and
> make no sense to fix them when there is no user of these drivers that's why
> it is easier just remove them completely.
> 
> Another candidate for removal is FPGA_CYCLON2 which is enabled only by
> mx53cx9020_defconfig.
> Patrick: Is this board still maintained?
> 
> Thanks,
> Michal
> 
> Changes in v2:
> - Get EP2/EP3/EP4 sizes back even they are not used by any code today
> 
> Michal Simek (3):
>    fpga: xilinx: Check valid desc structure
>    fpga: Remove ancient ACEX1K support
>    fpga: lattice: Remove unused support
> 
>   configs/sandbox_defconfig |    2 -
>   drivers/fpga/ACEX1K.c     |  245 ---
>   drivers/fpga/Kconfig      |   12 -
>   drivers/fpga/Makefile     |    2 -
>   drivers/fpga/altera.c     |    5 +-
>   drivers/fpga/fpga.c       |   23 -
>   drivers/fpga/ivm_core.c   | 3149 -------------------------------------
>   drivers/fpga/lattice.c    |  379 -----
>   drivers/fpga/xilinx.c     |    3 +
>   include/ACEX1K.h          |   32 -
>   include/fpga.h            |    1 -
>   include/lattice.h         |  298 ----
>   12 files changed, 4 insertions(+), 4147 deletions(-)
>   delete mode 100644 drivers/fpga/ACEX1K.c
>   delete mode 100644 drivers/fpga/ivm_core.c
>   delete mode 100644 drivers/fpga/lattice.c
>   delete mode 100644 include/lattice.h
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

