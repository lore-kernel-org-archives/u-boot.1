Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6247FC2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 17:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C171486996;
	Wed, 15 Nov 2023 18:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Vv2JAs7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 642EE86611; Wed, 15 Nov 2023 18:37:07 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91AA187203
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 18:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EC68840262
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 17:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700069823;
 bh=Teuq2f0CcuPenohQ69fak370nihPLLbfaikwWnuFkPs=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Vv2JAs7xPV/GrSvlTIVYIE3c3JA4v5+feVTGKDD/Sx2w1vyTReGGZprXieZfuyluo
 F6rsbZFRdBKnXEZw83EILdtlvxHH36LzK045AVUvKAUGcurg5mSuVo+r4cTw8qX5Pf
 T2O/OvolLnIxc9DdY76a95WDSvjihnrNd9lqc1BlApwzaF5O4gJbbMvQR/jOnEhWG3
 Uw+dHh7DfzHOzMGoMenfZs2zdPy1I5ed0EzZ81uRR+PoF0zh+wvoGYP04RJXhtA/ND
 Ac5s2+AtJY18F6Db4AEOWnXF9ShVMFc3qXfTZyVvyULK5FuwsDrQxBdfj0URu3gDQS
 KaGYUNhrKHWjQ==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4092164ed09so45913685e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 09:37:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700069822; x=1700674622;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Teuq2f0CcuPenohQ69fak370nihPLLbfaikwWnuFkPs=;
 b=Kwx4bZzo13d2bOyuxhS4c0kzUEI9A/AOj1ss893bQuCsNoHOevC+QngSpxdkflLZld
 xSsTY4gBFQqHQB6ToTKsyqiId2MEAxAL30G/LEKymORGKlhGwqLJ2Ti9owKLTSOgOOlP
 tTkgTv52+/oa/2D5xHIhlLM6/y+mS5HMVQ0IXeGrGbuK4Hh0Yy0qSrXWKLo2pIk0LrpX
 UAVd93piFSWU/1o658r3Ivdo7yvvpNQPjty7yTKDVJGzbLHO6kKjhs3bN8l2sTUWSo89
 q3KSYkM7wyVLRa14eNWQncbcpHT7kyC7JoouSfXrinEL1jiMZtWdV5fjK8m/7t9TIBxO
 5uDg==
X-Gm-Message-State: AOJu0YxRAYlXGU7c4PzalQamD3aOGqi/obP3zr21z2bjeoVDReslvZi/
 atT8lSQRsfMH56b22i5Ag1nn0tviDUdO3jTQ0v3x4RQfLUqJPbs2KbcN0TIT++XdnEGx7gq/GBY
 H1Y5bS9lO8gLTRBKJxSfeZOSQThWHvY2DbucCLDE=
X-Received: by 2002:a05:600c:230f:b0:408:3d91:8263 with SMTP id
 15-20020a05600c230f00b004083d918263mr10519977wmo.13.1700069822593; 
 Wed, 15 Nov 2023 09:37:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1sX1wA/YiCUTUK+SIu5KLbrzapTeZChq6S2j/5xS/jk8LmctcK3BPFrGhcyGFI0AFaEy3EA==
X-Received: by 2002:a05:600c:230f:b0:408:3d91:8263 with SMTP id
 15-20020a05600c230f00b004083d918263mr10519961wmo.13.1700069822202; 
 Wed, 15 Nov 2023 09:37:02 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 az23-20020a05600c601700b004054dcbf92asm373730wmb.20.2023.11.15.09.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 09:37:01 -0800 (PST)
Message-ID: <1f7ee4eb-0e2a-4b0c-b1a4-2c9d03daf02f@canonical.com>
Date: Wed, 15 Nov 2023 18:37:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] risc-v: add ACPI support on QEMU
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Alexander Gendin <agendin@matrox.com>, Zong Li <zong.li@sifive.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Brandon Maier <brandon.maier@collins.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
References: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
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

On 15.11.23 15:23, Heinrich Schuchardt wrote:
> QEMU 8.1.2 can create ACPI tables for the RISC-V architecture.
> Allow passing them through to the operating system.
> Provide a new defconfig that enables this.

This patch is prerequisite:

[PATCH] move acpi_get_rsdp_addr() to acpi/acpi_table.h
https://patchwork.ozlabs.org/project/uboot/patch/20231109172302.54324-1-heinrich.schuchardt@canonical.com/

Best regards

Heinrich

> 
> Heinrich Schuchardt (6):
>    acpi: do not write ACPI tables on TARGET_QEMU_VIRT
>    risc-v: add ACPI fields to global data
>    risc-v: add support for QEMU provided ACPI tables
>    riscv: qemu: copy ACPI tables from QEMU
>    riscv: allow usage of ACPI
>    configs: defconfig for QEMU RISC-V with ACPI
> 
>   arch/Kconfig                              |  1 +
>   arch/riscv/include/asm/global_data.h      |  4 ++++
>   board/emulation/qemu-riscv/Kconfig        |  2 ++
>   board/emulation/qemu-riscv/MAINTAINERS    |  1 +
>   board/emulation/qemu-riscv/qemu-riscv.c   | 17 ++++++++++++++
>   configs/qemu-riscv64_acpi_smode_defconfig | 27 +++++++++++++++++++++++
>   lib/Kconfig                               |  2 +-
>   lib/acpi/Makefile                         |  2 +-
>   lib/acpi/acpi_writer.c                    |  2 +-
>   9 files changed, 55 insertions(+), 3 deletions(-)
>   create mode 100644 configs/qemu-riscv64_acpi_smode_defconfig
> 

