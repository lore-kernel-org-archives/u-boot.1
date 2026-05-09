Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8185CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 13:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD1C984CD5;
	Sat,  9 May 2026 15:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MQnWZJZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6727184CEC; Sat,  9 May 2026 15:06:33 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE49B84CC7
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 15:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ehristev@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 32C4543E69;
 Sat,  9 May 2026 13:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796B2C2BCB4;
 Sat,  9 May 2026 13:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778331987;
 bh=inBXH8pjkMshWf7AkgW+C53cHyQquEGa4wL1tBL4Sq0=;
 h=Date:From:To:Cc:Subject:From;
 b=MQnWZJZW6T/8O/xZD3legj/YQ1qA7Ubo5+QIwSLPhUz1RNrAlfg12B8xwq7Q1JlVx
 kiR9iemnZauD0P41n65kjBk9XJ+KIli/c6m8yoZdmPr9TCpndUVi8CairlH2R8poIx
 ejZslIevShfeBzYwSgPFQs+r28kI194fervpcFcUz1upVFtxx0n55IdOg7JnrnMCs+
 jVr7+PLXLrpUR3gwf+BoL/8ZBxMvQsoY1MJAJMvj8SShwABJRknHw8LWim0UyfXqT7
 z/HKJfgJCtFwm/8GezpeMKYM9HTCJPJ07QzOhBO6+/SPtfrVgN9BgOMEhmPFbOx4Ky
 PBbqLygkEgeGw==
Message-ID: <3262be87-a39c-4676-ae3e-c8efd2f4ec17@kernel.org>
Date: Sat, 9 May 2026 16:06:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: open list <u-boot@lists.denx.de>
Subject: [PULL] u-boot-at91-fixes-2026.07-a
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

Hello Tom,

Please pull tag u-boot-at91-fixes-2026.07-a , the first set of at91
fixes for the 2026.07 cycle.

This is just one cleanup of some useless code.

Thanks,
Eugen



The following changes since commit 9f61fd5b80a43ae20ba115e3a2933d47d720ab82:

  Makefile: fix host CPP pollution in cmd_gen_envp (2026-04-24 12:49:27
-0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-at91.git
tags/u-boot-at91-fixes-2026.07-a

for you to fetch changes up to 301bad079b15bdcdae1dc7c3f4f7b30cff15ba84:

  arm: at91: Drop unnecessary BOARD_EARLY_INIT_F usage (2026-05-01
10:00:13 +0300)

----------------------------------------------------------------
First set of u-boot-at91 fixes for the 2026.07 cycle

----------------------------------------------------------------
Tom Rini (1):
      arm: at91: Drop unnecessary BOARD_EARLY_INIT_F usage

 arch/arm/mach-at91/Kconfig                          | 21
---------------------
 arch/arm/mach-at91/spl_atmel.c                      |  3 ++-
 board/atmel/at91sam9260ek/at91sam9260ek.c           |  7 -------
 board/atmel/at91sam9261ek/at91sam9261ek.c           |  7 -------
 board/atmel/at91sam9263ek/at91sam9263ek.c           |  7 -------
 board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c     |  7 -------
 board/atmel/at91sam9n12ek/at91sam9n12ek.c           |  7 -------
 board/atmel/at91sam9rlek/at91sam9rlek.c             |  7 -------
 board/atmel/at91sam9x5ek/at91sam9x5ek.c             |  7 -------
 board/atmel/sam9x60_curiosity/sam9x60_curiosity.c   |  5 -----
 board/atmel/sam9x60ek/sam9x60ek.c                   |  7 -------
 board/atmel/sam9x75_curiosity/sam9x75_curiosity.c   |  5 -----
 board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c     |  7 -------
 board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c |  7 -------
 board/atmel/sama5d2_icp/sama5d2_icp.c               |  5 -----
 board/atmel/sama5d2_ptc_ek/sama5d2_ptc_ek.c         |  7 -------
 board/atmel/sama5d2_xplained/sama5d2_xplained.c     |  7 -------
 board/atmel/sama5d3_xplained/sama5d3_xplained.c     |  7 -------
 board/atmel/sama5d3xek/sama5d3xek.c                 |  7 -------
 board/atmel/sama5d4_xplained/sama5d4_xplained.c     |  7 -------
 board/atmel/sama5d4ek/sama5d4ek.c                   |  7 -------
 board/atmel/sama7d65_curiosity/sama7d65_curiosity.c |  5 -----
 board/atmel/sama7g5ek/sama7g5ek.c                   |  5 -----
 board/ronetix/pm9261/pm9261.c                       |  5 -----
 board/ronetix/pm9263/pm9263.c                       |  5 -----
 configs/pm9261_defconfig                            |  1 -
 configs/pm9263_defconfig                            |  1 -
 27 files changed, 2 insertions(+), 171 deletions(-)
