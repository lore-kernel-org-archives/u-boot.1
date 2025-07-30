Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B0CC87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 10:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC4CC81E13;
	Wed, 30 Jul 2025 12:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hcVrWG0F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 421B481F6B; Wed, 30 Jul 2025 12:15:37 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 519B7803CC
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 12:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bsSlS2r0jz9sVt;
 Wed, 30 Jul 2025 12:15:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753870532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjWsjpXxtYk9oxzcxMZMAXNjN6khyiKbMS1X1CHr2tQ=;
 b=hcVrWG0FQAzQp+TqpzXKqnl6xk3jISTIPJb7hC5j2BEjZeCCy/JMxvQAiGn7tV4M/jvomk
 2hPG81hEhyVOx5Jtw0NUZSDhePv9/I298Gw3Sd0d8Ah1Ccm9iaPUd8iNLBquX2UlZSFyjO
 1sKLnGk/hNWIoAXbPSlEkj1FlVr5Emn6Umrs87pWvZqY6pt8AyHnI/Ng4ys/i3/ipRAWib
 eouDCYDe8e2wfgXINlAFiGvrKirrCdFkiuKolbqXYH6geBmipypPOfjXegWT0Mm6tt5aVi
 2LmOpPJrF/uHds5Uap1R7SrT2b/Eqiuc+0VHNeWHAOpOg5AMTFcJHN/JRuzO1A==
Message-ID: <aecc4d69-3b7a-44b2-9f7f-a0376505bdec@mailbox.org>
Date: Wed, 30 Jul 2025 12:15:30 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/4] watchdog for STM32MP family
To: Antonio Borneo <antonio.borneo@foss.st.com>, u-boot@lists.denx.de,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
References: <20250521122755.265760-1-antonio.borneo@foss.st.com>
 <20250523094658.299730-1-antonio.borneo@foss.st.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20250523094658.299730-1-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2fd5a40bd343ebfc96d
X-MBO-RS-META: 3i9qyf5zw6srob4obwep4eg8ehhanaza
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

On 23.05.25 11:46, Antonio Borneo wrote:
> This series addresses the two watchdog drivers used on STM32MPxx
> family platforms.
> 
> On the generic watchdog framework, it adds a new method
> wdt_set_force_autostart() used by the watchdog drivers to force
> the autostart status of the watchdog.
> This is used when the driver detects that the watchdog has already
> been started by a previous boot stage (e.g. HW, bootrom, Secure
> OS, ...) and needs to be kicked by U-Boot regardless of the
> autostart flag set in DT or in config.
> 
> On the driver arm_smc_wdt, it adds the API to query the Secure OS
> about the state of the watchdog, and if at probe the watchdog is
> already started it invokes wdt_set_force_autostart().
> 
> On the driver stm32mp_wdt, it adds the code to detect the state of
> the watchdog, and if at probe the watchdog is already started it
> invokes wdt_set_force_autostart().
> 
> At last, since all the watchdog drivers used on STM32MPxx family
> platforms can query the status of the watchdog and use it
> consequently, set WATCHDOG_AUTOSTART default to 'n' on such
> platforms. This implies that U-Boot, by default, will respect the
> status of the watchdog set by a previous boot stage.
> For backward compatibility on platforms using SPL, still let
> U-Boot to autostart the watchdog.
> 
> V1 ==> V2
> - Fix backward compatibility on defconfig based on SPL
> - Fix inconsistency in the commit message
> - Rebase on current branch next
> 
> Antonio Borneo (2):
>    watchdog: wdt-uclass.c: add wdt_set_force_autostart() helper
>    watchdog: arm_smc_wdt: get wdt status through SMCWD_GET_TIMELEFT
> 
> Clément Le Goffic (1):
>    watchdog: stm32mp: check the watchdog status
> 
> Patrice Chotard (1):
>    watchdog: don't autostart watchdog on STM32MP architecture
> 
>   ...stm32mp15-icore-stm32mp1-ctouch2_defconfig |  1 +
>   ...tm32mp15-icore-stm32mp1-edimm2.2_defconfig |  1 +
>   ...-microgea-stm32mp1-microdev2-of7_defconfig |  1 +
>   ...mp15-microgea-stm32mp1-microdev2_defconfig |  1 +
>   configs/stm32mp15_basic_defconfig             |  1 +
>   configs/stm32mp15_dhsom.config                |  1 +
>   drivers/watchdog/Kconfig                      |  1 +
>   drivers/watchdog/arm_smc_wdt.c                | 17 ++++++++++
>   drivers/watchdog/stm32mp_wdt.c                | 33 +++++++++++++++++++
>   drivers/watchdog/wdt-uclass.c                 |  9 +++++
>   include/wdt.h                                 |  9 +++++
>   11 files changed, 75 insertions(+)

Applied to u-boot-watchdog/master

Thanks,
Stefan

