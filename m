Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B29C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 11:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B638036F;
	Fri, 17 Jan 2025 12:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="S9BNFr79";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D27A0806D8; Fri, 17 Jan 2025 12:10:30 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C343880312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 12:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A7D0514845C1; Fri, 17 Jan 2025 12:10:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737112227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GErYahF4PAeV3Q72XExVl9XTTt/RdTrbVRpzjT4W0ZM=;
 b=S9BNFr7902xxT+kqE5392YrHHrkZ1nOY6WZCT+n+Zn757WeIkFMVXpoRcw21AI85Mzs8Sw
 fW5AUZlu3m8OhVgwG6yIAIh7NL/4X9DPeAA/VzGlYAXNBoIjwcEQwzZ04EgnqFTqfm7+7r
 skl/7zr4er2Ca5cEWhQNbux1q1HqGQT+Ysc3jEV4IGTX+D2bBaj5XJqvLdu+Dnr9jfOQUT
 0esJ8O8wf4ghuWUNvNRl6jmZ4cfVjjCRhpPDkzjW7dhcu2+mtXzLcgcHYMgh4I2WkxloVF
 0EhqJCDlaXri91u/cbnnGbTBaxg7qALQxMuLVQ35dtzlF+XPhzZFSFsvw531dw==
Date: Fri, 17 Jan 2025 12:10:20 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH v4 05/15] lmb: notify of any changes to the LMB memory map
Message-ID: <20250117-molecular-quicksand-e80bf947313e@thorsis.com>
Mail-Followup-To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Mark Kettenis <kettenis@openbsd.org>
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
 <20241015153717.401371-6-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015153717.401371-6-sughosh.ganu@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
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

Hei hei,

Am Tue, Oct 15, 2024 at 09:07:07PM +0530 schrieb Sughosh Ganu:
> In U-Boot, LMB and EFI are two primary modules who provide memory
> allocation and reservation API's. Both these modules operate with the
> same regions of memory for allocations. Use the LMB memory map update
> event to notify other interested listeners about a change in it's
> memory map. This can then be used by the other module to keep track of
> available and used memory.
> 
> There is no need to send these notifications when the LMB module is
> being unit-tested. Add a flag to the lmb structure to indicate if the
> memory map is being used for tests, and suppress sending any
> notifications when running these unit tests.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V3:
> * Drop use of is_addr_in_ram() function
> * Drop use of CONFIG_MEM_MAP_UPDATE_NOTIFY symbol to check if the
>   notification needs to be sent.
> * s/lmb_notify/lmb_should_notify
> * Put a check for EFI_LOADER in the lmb_should_notify() function

This changeset breaks build with CONFIG_CC_OPTIMIZE_FOR_DEBUG=y for
me.  In a usual non-debug build, everything is fine.  However in a
debug build now I get this error:

      UPD     include/generated/timestamp_autogenerated.h
      GEN     Makefile
      Using /mnt/data/adahl/src/u-boot as source for U-Boot
      CC      common/version.o
      AR      common/built-in.o
      LD      u-boot
    arm-v5te-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_notify':
    /mnt/data/adahl/src/u-boot/lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'

My tree is based on v2025.01 release.  lib/lmb.c is built because …

  │   Selected by [y]:
  │   - SYS_BOOT_RAMDISK_HIGH [=y] && (CMD_BOOTM [=y] || CMD_BOOTI [=n] || CMD_BOOTZ [=y]) && !NIOS2 [=n] && !SANDBOX [=n] && !SH [=n] && !XTENSA [=n]
  │   Selected by [n]:
  │   - EFI_LOADER [=n] && OF_LIBFDT [=y] && (ARM [=y] && (SYS_CPU [=arm926ejs]=arm1136 || SYS_CPU [=arm926ejs]=arm1176 || …

So as you can see EFI_LOADER is disabled, because I don't need to run
UEFI applications on my armv5te SoC (Microchip sam9x60).
CMD_BOOTZ is enabled, because I boot a Linux kernel.

I can not enable EFI_LOADER however, because there's nothing in the
long list of "depends on" which is or can be satified on my target.

I would really appreciate to be able to use a debug build again,
please advice!

Greets
Alex

