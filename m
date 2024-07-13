Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E15C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5698887BF;
	Sat, 13 Jul 2024 17:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FYp4/vd6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2377588852; Sat, 13 Jul 2024 17:13:58 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09A3A887BF
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b5d6ba7c90so16444856d6.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883635; x=1721488435; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jWs3cooZwYVr68jZN+7rOM7OFkgbgZWb8TS3rOumMRQ=;
 b=FYp4/vd6n/NdKrUuwCrQbt8My8TxdRyOqJGpzbJLGjCnhXEsVj7kOQGFc8PBwWlLUs
 2y92n+iaSxvht3zj227lhEQr22h1AaoJnAOX0V8BdK+gP2v0gFjnoQMhRv3hdXCmugym
 KQbZp62fyFBMa0Xxn54/fMJRSpuszsNDOMyUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883635; x=1721488435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jWs3cooZwYVr68jZN+7rOM7OFkgbgZWb8TS3rOumMRQ=;
 b=WGXzJQpSEfKzU5eYHjCO1wzr3uOJIq7E9pLqDZ+5PZlSg4GiKMIVoM5HAg/a5PyWgd
 ibBdRH6OyNaeOwJDzJNUPlPocxciyPbv0zppWU0ogFnB3c6hROuj7733N/z4Uhj5tIBM
 qg0xUzmR1T6yeUOPfJXyvYcvrjRdGUL/WhihqT0DauJuWuh8CzRy/lL/sbEgrZ6ZmkF6
 DNVnGorL3QgCA/Z6kjCQs1vM87pFhzP34KG3Pr8Lpeg47kTwjWGl9+NZMklpew1HfdMK
 3EiGCotmg8m7U28Z8DXTZwvlAmqoSzNGJE7TIlF6IG1xziaU0q1lAbn9liTU0aWLQw0Y
 7Qkw==
X-Gm-Message-State: AOJu0YxLjUME+zS+3ieVHaDub1fL+QveNmBsf6vj1RmP9wubVVNO3X1S
 ESUimJ45J2mKFPuQsl5sxmNjNDLqBCxAGBFd/BdqMpQS9y7aOxA+nbI4VUmOhhFSxMsaayUUhtX
 FfcDtKQxdr4bKoN/5tONvF8GJP61EQ8AGRL8r
X-Google-Smtp-Source: AGHT+IEtNnhOxD+bBeiKjV/eVHbKSgCEwYliKNlZV4WAGtsx2f3tldg2QEg2xLzCTBudLiC7cQs+pQk2hBLBB1K0vkU=
X-Received: by 2002:ad4:596c:0:b0:6b4:ff8e:63f1 with SMTP id
 6a1803df08f44-6b61bf373famr198151886d6.34.1720883634967; Sat, 13 Jul 2024
 08:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240606163326.386950-1-marek.mojik@nic.cz>
 <20240606163326.386950-2-marek.mojik@nic.cz>
In-Reply-To: <20240606163326.386950-2-marek.mojik@nic.cz>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:13:43 +0100
Message-ID: <CAFLszThhXN_NwUiQAHUmmK7pZ5BXThXhV1P1rqkDCu0n-ErG6A@mail.gmail.com>
Subject: Re: [PATCH 1/6] board_f: Add support for CONFIG_OF_BOARD_FIXUP for
 XIP images
To: =?UTF-8?B?TWFyZWsgTW9qw61r?= <marek.mojik@nic.cz>
Cc: u-boot@lists.denx.de, kabel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Marek,

On Thu, 6 Jun 2024 at 17:33, Marek Moj=C3=ADk <marek.mojik@nic.cz> wrote:
>
> From: Pali Roh=C3=A1r <pali@kernel.org>
>
> When U-Boot is running from flash memory (execute in place) then
> gd->fdt_blob before relocation points to read-only flash memory.
>
> So U-Boot calls board_fix_fdt() with read-only gd->fdt_blob pointer which
> cause immediate CPU crash when callback is trying to modify gd->fdt_blob.
>
> Fix this issue by introducing a new config option OF_INITIAL_DTB_READONLY
> which moves fix_fdt callback after the reloc_fdt callback. This makes
> CONFIG_OF_BOARD_FIXUP working also if U-Boot before relocation is not
> running from read/write (S)RAM memory.
>
> This is required for mpc85xx boards when booting from flash NOR.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Signed-off-by: Marek Moj=C3=ADk <marek.mojik@nic.cz>
> ---
>  common/board_f.c | 8 +++++++-
>  dts/Kconfig      | 6 ++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/common/board_f.c b/common/board_f.c
> index 212ffb3090..22c180b218 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -949,7 +949,7 @@ static const init_fnc_t init_sequence_f[] =3D {
>          *  - board info struct
>          */
>         setup_dest_addr,
> -#ifdef CONFIG_OF_BOARD_FIXUP
> +#if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_OF_INITIAL_DTB_REA=
DONLY)
>         fix_fdt,
>  #endif
>  #ifdef CFG_PRAM
> @@ -965,6 +965,10 @@ static const init_fnc_t init_sequence_f[] =3D {
>         reserve_board,
>         reserve_global_data,
>         reserve_fdt,
> +#if defined(CONFIG_OF_BOARD_FIXUP) && defined(CONFIG_OF_INITIAL_DTB_READ=
ONLY)
> +       reloc_fdt,
> +       fix_fdt,
> +#endif
>         reserve_bootstage,
>         reserve_bloblist,
>         reserve_arch,
> @@ -975,7 +979,9 @@ static const init_fnc_t init_sequence_f[] =3D {
>         setup_bdinfo,
>         display_new_sp,
>         INIT_FUNC_WATCHDOG_RESET
> +#if !defined(CONFIG_OF_BOARD_FIXUP) || !defined(CONFIG_OF_INITIAL_DTB_RE=
ADONLY)
>         reloc_fdt,

Can you not do the fix here? We should keep all the reserve_... calls
together, and have all the reloc_... calls after that.

> +#endif
>         reloc_bootstage,
>         reloc_bloblist,
>         setup_reloc,
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 6883a000a0..569d4be338 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -145,6 +145,12 @@ config OF_EMBED
>
>  endchoice
>
> +config OF_INITIAL_DTB_READONLY
> +       bool "Initial DTB for DT control is read-only"
> +       help
> +         If initial DTB for DT control is read-only (e.g. points to
> +         memory-mapped flash memory), then set this option.
> +
>  config OF_BOARD
>         bool "Provided by the board (e.g a previous loader) at runtime"
>         default y if SANDBOX || OF_HAS_PRIOR_STAGE
> --
> 2.45.1
>

This should really use events. You can have an event like
INITCALL_EVENT(EVT_RESERVE_DONE), for example.

Regards,
Simon
