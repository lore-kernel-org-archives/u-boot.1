Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D8CCD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72E8849BA;
	Fri, 26 Jun 2026 12:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="zkHwIOEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD9E849EE; Fri, 26 Jun 2026 12:45:29 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A5D8460E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 874F91A08F3;
 Fri, 26 Jun 2026 10:45:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5A69260232;
 Fri, 26 Jun 2026 10:45:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F34B0104C97E1; 
 Fri, 26 Jun 2026 12:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782470725; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=8HNXycZx7oGaDSM4Af2ihVKpaXW6Ah9oqEmQjYiAq3U=;
 b=zkHwIOEK1CV/HfNDAWkAbrrMdZx/J1lujQrotplZvuIsI7HzDQHpgjGo6XBeb8Lv8XBz3U
 xnJREqAhAtbkYbGbh0S1eF21GIA4IAgOX0tRm4kwElK/NiRpAMgkX2IXeiQ1gsj+vCwjmv
 AQ50UrhZsUQoRU9pvWJa5Ym7vEqXa/5h/5uwpJNlok+KUGxYmH9UPN0cFXj7FuWy3SU0EO
 58xsy9cFDVQsfMSZv7bvuypkSNSQZ48Vd0K/jPbuXbB1Yd5pJjhrjyDDOCKJB9/sAUrAlR
 qIdtHwklanbQw1D2vFaEXeTA0rr+jTl2QbGAMfN5s1i5pbkHJWpcQd7A2zRI2A==
Message-ID: <33a9e8d1-90b2-43cf-a9fd-ffe66f443bce@bootlin.com>
Date: Fri, 26 Jun 2026 12:45:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: Re: [PATCH v4 00/19] Introduce resume for J7xx SoCs
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260625071515.91243-1-richard.genoud@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260625071515.91243-1-richard.genoud@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Richard,

On 6/25/26 9:14 AM, Richard Genoud (TI) wrote:
> This series allows J7200/J721e/J721s2/J784s4/J722s to resume from
> suspend.
> 
> On those SoCs, a magic value is set in a PMIC register by the DM
> firmware just before suspend, then everything but the PMIC and DDR is
> powered off.
> At resume/boot time, the magic value has to be read back by U-Boot SPL in
> order to know if we are indeed in a resume situation.
> That's the purpose of j7xx_board_is_resuming() introduced here.
> 
> Then, if the SoC is resuming, the DDR has to be brought out of
> retention, at full speed and get out of low power mode.
> Between those steps, the DDR_RET pin has to be de-asserted. But the
> DDR_RET pins of all DDR chips are tied together on a single GPIO, so
> it's impossible to resume one DDR chip after the other, they must be all
> resumed at once.
> That's why it's orchestrated from board_init_f() and not in the k3ddrss
> driver.
> 
> Once the DDR is fully functional, the next steps are:
> - retrieve the LPM memory region from DTS
> - authenticate certificates from LPM memory region and apply firewalls
> - ask TIFS to restore TFA and its own minimal context
> - start TFA on remote proc
> - load and jump to DM
> 
> Patches 1-3 add LPM helpers for all SoCs
> Patch 4 adds the resume detection for all SoCs
> Patch 5 adds common code for DDR retention pin
> Patch 6 enables GTC at resume
> Patch 7 detects IO+DDR resume state for j7200/j784s4
> Patch 8 stores the wakeup reason in MCU_PSRAM0_RAM for j7200/j784s4
> Patch 9 sets the PMIC NSLEEP triggers
> Patches 10-12 add the DDR resume sequence for all SoCs
> Patches 13-16 add the resume flow for all SoCs
> Patch 17 updates the pm-cfg and schema to a new version
> Patch 18 removes now unneeded background firewall on DDR for j7200/j784s4
> Patch 19 extends the firewall for ATF region to TIFS
> 
> Tested on J722s HS-FS, J7200 GP, J784s4 GP, J721s2 GP
> 
> BEWARE: This series is based on:
>  commit 8d5f30b52f7c ("Merge patch series "env: migrate static flags list to Kconfig"")
>  + AM62 LPM series:
> https://lore.kernel.org/u-boot/20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com/
> 
> It needs lpm_memory_regions described in DTS:
> https://lore.kernel.org/lkml/20260427160326.370415-1-richard.genoud@bootlin.com/
> 
> It also needs a bootph-pre-ram property in PMIC-B for j721s2:
> https://lore.kernel.org/linux-arm-kernel/20260429-k3-j721s2-som-bootph-pre-ram-pmic-4c-v2-1-31a0e7677216@bootlin.com/
> 

Tested-by: Thomas Richard (TI) <thomas.richard@bootlin.com> # J7200 SR1.0 GP, J721S2 SR1.0 GP

Best Regards,
Thomas
