Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3043C25B74
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 02:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD7D8874D;
	Fri, 31 May 2024 04:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LwTTnUAG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E70288756; Fri, 31 May 2024 04:48:05 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C82688748
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 04:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-62a0849f8e5so14704567b3.2
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 19:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717123682; x=1717728482; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aoEX9aelFQjyPi2PMCSvC4CncAtnOJuuZs+bBwDB21U=;
 b=LwTTnUAGQ1MxUCJcMW+30TkqMNo2XfsnLkpmh4VQCh9THyYKlEW4foERP2eTzRQqhu
 3qCHHd6a8vnxeNL6WE7SD4ozAqIgQdUBCogGrKG9Sg7szT2rnXrBLBRGbcj1huIOdKbZ
 A4BMfL+FaQE0umzDWHv0osQlEU04NW/9EM/Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717123682; x=1717728482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aoEX9aelFQjyPi2PMCSvC4CncAtnOJuuZs+bBwDB21U=;
 b=PlRHlDjO5JLcC59BEk15Q/vxt3YUWI0V1uUyDM9mKQ2q+INu9qN3Lg4IMkCMZIvn44
 qgBfvtfgXYSOGX8wXSsYcXaKkpEa9bwXYaB+sOItvHW8h+wIC40qB04u/l1GzElXghk6
 j5GHESsblelZetvM6IaK+pkalhGbVlmD6z6vRMWn78FGjRSa0FvhiweLTedNWMS1L2UL
 kSTnlP5o0KEbOrZ/M8p4eBonll1UkhFmn1hqm67pHHiU/uA1inovCsPVC8JCGhw29M65
 J8YI3GgZn89HSORcGIqK5k0W7G1r/uac9gN5FLHKMF0zWABcgVX4okoc38zBoOAtwX0N
 wSEg==
X-Gm-Message-State: AOJu0YynbWa5YGG2cBjmWwqtL7b61dpej05cwD0jPXiyHJao+0piEhiQ
 CJEOvWDGiyTO9tsTIV+Xr3b8kL3jJNtfzVyty4/ttAyZnbGS+65jZ+Zc2CEWGnei2Q13pefVew3
 dEs4Hai192zdmcR/sZzeWBKzCMlLGb1McLKkI
X-Google-Smtp-Source: AGHT+IHsy1qVhInLWMDIsZV+yvpkapewnU6GqyD2ZZUPMDTeERzJ1F2X3a22LCWeHlVDdKRVFITPXBWXV4ZcLzY4N4c=
X-Received: by 2002:a25:db8b:0:b0:dc6:b820:bb45 with SMTP id
 3f1490d57ef6-dfa73c22dbamr639610276.27.1717123682016; Thu, 30 May 2024
 19:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240530220634.155951-1-tharvey@gateworks.com>
 <20240530220634.155951-2-tharvey@gateworks.com>
In-Reply-To: <20240530220634.155951-2-tharvey@gateworks.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 May 2024 20:47:51 -0600
Message-ID: <CAFLszTi4XrWni6dUF=H_Dzp_wAR6i+tiytLQyBcz8SESn=sM6A@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Add fdt_kaslrseed function to add kaslr-seed to
 chosen node
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 31 May 2024 04:58:26 +0200
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

On Thu, 30 May 2024 at 16:06, Tim Harvey <tharvey@gateworks.com> wrote:
>
> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> randomize the virtual address at which the kernel image is loaded, it
> expects entropy to be provided by the bootloader by populating
> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
>
> Add a fdt_kaslrseed function to accommodate this allowing an existing
> node to be overwritten if present. For now use the first rng device
> but it would be good to enhance this in the future to allow some sort
> of selection or policy in choosing the rng device used.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Cc: Akash Gajjar <gajjar04akash@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Devarsh Thakkar <devarsht@ti.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Chris Morgan <macromorgan@hotmail.com>
> ---
> v5:
>  - move function to boot/fdt_support.c
>  - remove ability to select rng index and note in the commit log
>    something like this as a future enhancement.
>  - fixed typo in commit message s/it's/its/
>  - use cmd_process_error per Michal's suggestion
> v4:
>  - add missing /n to notice in kaslrseed cmd
>  - combine ints in declaration
>  - remove unused vars from board/xilinx/common/board.c ft_board_setup
> v3:
>  - skip if CONFIG_MEASURED_BOOT
>  - fix skip for CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
>  - pass in rng index and bool to specify overwrite
>  - remove duplicate error strings printed outside of fdt_kaslrseed
>  - added note to commit log about how EFI STUB weeds out kalsr-seed
> v2:
>  - fix typo in commit msg
>  - use stack for seed to avoid unecessary malloc/free
>  - move to a library function and deduplicate code by using it
>    elsewhere
> ---
>  boot/fdt_support.c    | 44 +++++++++++++++++++++++++++++++++++++++++++
>  include/fdt_support.h | 10 ++++++++++
>  2 files changed, 54 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
