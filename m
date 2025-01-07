Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7110FE77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 11:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B5D801E8;
	Tue,  7 Jan 2025 12:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736249254;
	bh=dOfYtZGeTAAY8bckgms/zg6JU+LLafmnqs5FAnjRtNM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i2Kr0Y+CVloUvvq5o7D+E/dG6m28lkQlgmvKprQQRnEhqzDGHjlhny2mu1naHRxcB
	 moQz4xblk/p9w1U+54HNRhABt9mxCtXueJ41a5jMt40z5cOP/qwNhRKCl1Ihcv4KjH
	 N+FHfNNVbk8heyhMb0Q8zAZNBTjjd9tcT6ic0MQctXhpgdrUJX9g4r+XRZs4CLRYzu
	 AMAVynDM1H/zN/rw/nlcWo5tGisJfGL34p968VE2WSbPh1JLwJyaERqMNtmN07r565
	 LS9yq5Gu8Uns/e9apaDNp97pfLK/NyYJNDQClNpCRwc8v/J5qkE3qmhcsm7BDanoob
	 JyZ5NK6iFdspA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68FCA801FD; Tue,  7 Jan 2025 12:27:33 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A7F5801B6
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 12:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4YS80Y6HvLz9sZk;
 Tue,  7 Jan 2025 12:27:25 +0100 (CET)
Message-ID: <07befe54-08cc-4e6d-a0be-6afbea47c4d2@denx.de>
Date: Tue, 7 Jan 2025 12:27:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] Initial support for PXA1908 and
 samsung-coreprimevelte
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Tom Rini <trini@konsulko.com>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de
References: <20241231-coreprimevelte-v2-0-6a5445d92d11@skole.hr>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241231-coreprimevelte-v2-0-6a5445d92d11@skole.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4YS80Y6HvLz9sZk
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

Hi Duje,

On 31.12.24 17:49, Duje Mihanović wrote:
> Hello,
> 
> This series adds initial support for Marvell's PXA1908 ARM64 SoC and
> Samsung's Galaxy Core Prime VE LTE, a smartphone based on said SoC.
> 
> On this board, U-Boot is used as a secondary bootloader to work around
> certain quirks of the factory S-Boot.

S-Boot? Never heard of that one.

Interesting to see such an ancient SoC getting supported in U-Boot.

Thanks,
Stefan

> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
> Changes in v2:
> - Drop arm,armv8 compatible from CPU nodes to match upstream
> - Add intel,xscale-uart compatible to NS16550 and use it in serial nodes to match upstream
> - Add include guards to include/configs/pxa1908.h
> - Disable CONFIG_DISPLAY_CPUINFO and CONFIG_CPU
> - Rebase on v2025.01-rc5
> - Link to v1: https://lore.kernel.org/r/20241227-coreprimevelte-v1-0-ac8243eee4e6@skole.hr
> 
> ---
> Duje Mihanović (3):
>        serial: ns16550: Add Intel XScale support
>        arm: mmp: add initial support for PXA1908 SoC
>        board: samsung: add initial support for coreprimevelte board
> 
>   MAINTAINERS                                     |   8 ++
>   arch/arm/Kconfig                                |  11 +++
>   arch/arm/Makefile                               |   1 +
>   arch/arm/dts/Makefile                           |   2 +
>   arch/arm/dts/pxa1908-samsung-coreprimevelte.dts |  74 +++++++++++++++++
>   arch/arm/dts/pxa1908.dtsi                       | 106 ++++++++++++++++++++++++
>   arch/arm/mach-mmp/Kconfig                       |  12 +++
>   arch/arm/mach-mmp/Makefile                      |   1 +
>   arch/arm/mach-mmp/board.c                       |  82 ++++++++++++++++++
>   arch/arm/mach-mmp/mmu.c                         |  30 +++++++
>   board/samsung/coreprimevelte/Kconfig            |  12 +++
>   board/samsung/coreprimevelte/MAINTAINERS        |   6 ++
>   configs/coreprimevelte_defconfig                |  18 ++++
>   drivers/serial/ns16550.c                        |   1 +
>   include/configs/pxa1908.h                       |  18 ++++
>   15 files changed, 382 insertions(+)
> ---
> base-commit: 4be40460758057b9a85b0303dc072c108813cdf6
> change-id: 20241226-coreprimevelte-1c26acfb58db
> 
> Best regards,

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

