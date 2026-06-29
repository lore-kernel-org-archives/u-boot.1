Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04D3C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 18:12:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACA3484942;
	Mon, 29 Jun 2026 20:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="BRsP6AIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D0C384A27; Mon, 29 Jun 2026 20:12:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3CB5A8490A
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 20:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBDAB27DC;
 Mon, 29 Jun 2026 11:12:42 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.80.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3A2C3F905;
 Mon, 29 Jun 2026 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782756767; bh=l9oakdauRcqR74vVDtGtVPIPWVQwC/bfF8XWob0pfCM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BRsP6AITUX3tkQWw/3hA6LTlOnTFdGt9b6+l6DEJq44/gWTEDPrsujH1DKl7+pIOp
 lMYaw5gr6ulJyXS4spZDjitt1029QBlmPSCLPpblmcqDbi14IlLW+jGE1H5O5G1zjm
 mOaR5wKvGw8tCyFLztjGhJfp8xZOMkAwPhH6Uk1Y=
Date: Mon, 29 Jun 2026 19:12:32 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 02/10] arm-ffa: add FF-A bus runtime support
Message-ID: <akK1kDtpTkoKRgrE@e130802.arm.com>
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
 <20260627144421.2067410-3-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627144421.2067410-3-harsimransingh.tungal@arm.com>
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

On Sat, Jun 27, 2026 at 03:44:13PM +0100, Harsimran Singh Tungal wrote:
> Add the FF-A runtime infrastructure needed after ExitBootServices() so
> EFI runtime services can continue to use the FF-A transport layer.
> Introduce drivers/firmware/arm-ffa/arm-ffa-runtime.c and
> include/arm_ffa_runtime.h with runtime-resident FF-A helpers for
> direct messaging, SMC invocation, and error translation. Add the
> sandbox runtime SMC wrapper, the ARM_FFA_RT_MODE Kconfig option, and
> the ExitBootServices hook that copies the required FF-A runtime data
> into resident storage before enabling the runtime context.
> 
> Tag the runtime code and data with __efi_runtime and
> __efi_runtime_data so they remain available after
> ExitBootServices().
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> 
> ----
> Changelog:
> ===============
> 
> v3:
> 
> Simon:
> 
> - Move ExitBootServices event registration to the end of probe
> - Use an early-return guard and log missing-context with log_warning()
> - Rename the runtime-context helpers to the ffa_runtime_context_* form
> - Drop the unrelated whitespace-only hunk
> - Fix commit message styling
> 
> v2:
> 
> Simon:
> 
> - Leave runtime mode disabled if private data is missing
>   and update the log message
> - Remove unused global-data plumbing
> - Switch to `IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)`
> - Fix style issues
> - Register the ExitBootServices event earlier in probe
> - Keep the runtime-enabled flag separate from copied boot time data
> 
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

Acked-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
