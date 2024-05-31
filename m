Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DF5C25B76
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 02:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A0C288763;
	Fri, 31 May 2024 04:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FBmR6RxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C561882D0; Fri, 31 May 2024 04:48:07 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7640D88735
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 04:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6ae84d171fcso1921666d6.2
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 19:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717123683; x=1717728483; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JjQYNhGeZvolDp/bdAJ/I8px+Ol00vaeg/dkj9CHuqU=;
 b=FBmR6RxKTONyLNZIriOiv6H043E+eIHp68P6Y/vFYdWon8xqfj1/q6MQAAwkM6p6ei
 nfiNE7unbvdicIzbObzoHRXwSI9BNzQPSmAx4603Pwk6YPjL71lnQ4UGEI34w+JXVfWC
 U9hdQmAn1LBxHCkvvZasqynQYCTw+QF4Qc7tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717123683; x=1717728483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JjQYNhGeZvolDp/bdAJ/I8px+Ol00vaeg/dkj9CHuqU=;
 b=ees1VLOzmipI2h+4JX1aav7AyUt3aJIc9GzOKbcsDo9YV5X9bZKS95jtVgweexVjX0
 1SjTvpr6BSugWXOX0bzIG1/xbuUtyoziyHLe0oXo1UTxb1EXp11WpzjO9MQlxFszsaln
 nIJ4+sEHnKsvNYXGpTPZDfI10NFr1aC/mPAR1R/9TsElrjZ4pcyou2yYqWQk59mdzii7
 gsCYnsLtzs4byoVspDcaEEXRAW1EFWOedwCbXnHwWX8NDbzJGwHGH/DP0FYtZ/MyBNPh
 4GOjHZxrGqcYVHYVa8XmD0Toum3Rqg/p8IadN42eFm9E+FPyYxOpknAYJewDO3cSI0he
 8How==
X-Gm-Message-State: AOJu0YxWPKQBuI/DpIFzff9H5I/cX+9nz1egu3HKPdooCjEBRvsFJHE2
 bo+awaTbVuB0FPRZ9hdTdzk0JtUonRtJRvb0uKi/HJisyGq5llCot1e4EtFsfshFTvlyttERDxn
 NtcKh6CvtkW16GTKUdeTrQUIFGIRwtczWyV5i
X-Google-Smtp-Source: AGHT+IHdTwzS9/HKmNl6x3DzrENIhTsejKn+DC/+31pjVaqdwkizeIG+RSD063rfHHAgR1AxPusswhyP3GvdTybV4CU=
X-Received: by 2002:a05:6214:5c46:b0:6ae:d19:b2f with SMTP id
 6a1803df08f44-6aecd6dd17dmr5998006d6.47.1717123683329; Thu, 30 May 2024
 19:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240530220634.155951-1-tharvey@gateworks.com>
 <20240530220634.155951-4-tharvey@gateworks.com>
In-Reply-To: <20240530220634.155951-4-tharvey@gateworks.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 May 2024 20:47:52 -0600
Message-ID: <CAFLszTivog4FkLmdnZmi7Y5E9CqAmbTG2C3-6-TxRfDVym6OdA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] use fdt_kaslrseed function to de-duplicate code
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
> Use the fdt_kaslrseed function to deduplicate code doing the same thing.
>
> Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
> but left in place in case boot scripts exist that rely on this command
> existing and returning success. An informational message is printed to
> alert users of this command that it is likely no longer needed.
>
> Note that the Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for
> randomization and completely ignores the kaslr-seed for its own
> randomness needs (i.e the randomization of the physical placement of
> the kernel). It gets weeded out from the DTB that gets handed over via
> efi_install_fdt() as it would also mess up the measured boot DTB TPM
> measurements as well.
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
>  board/xilinx/common/board.c | 40 ------------------------------
>  boot/pxe_utils.c            | 34 +------------------------
>  cmd/kaslrseed.c             | 49 ++++++-------------------------------
>  3 files changed, 8 insertions(+), 115 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
