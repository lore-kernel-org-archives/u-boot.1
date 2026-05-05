Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1522FCD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 05:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D4CA84687;
	Tue,  5 May 2026 07:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xDNvLDDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC99684692; Tue,  5 May 2026 07:42:05 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 893EF80086
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 07:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-651c366f7efso4619199d50.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 22:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777959722; cv=none;
 d=google.com; s=arc-20240605;
 b=bJsBKUFVzFkrMmxbZRieebmW5EAaYMSTluuUTZCrNIEjm/7IAEG/b84T6m/HeTzUmL
 HuEGlT32zf2LB15R9y2B+DqtDdtMgdTy6tnz/hDQpW5JGeMdtb9sXhRvu3NyW1DYmRs8
 b+z9rvXINBg++VAlPGrkcMRmuBCebcJdqXNQiRvEVhiXFdogQULWFxHOXjKvF6J2GSlT
 PgJ+g1I/RDsef4PuWiqrjkrzqr4dCwLkhkpfrKVOEZBwSGNhMlSH2U3prdYFNvOjtZfW
 BYyFmJaj1+GWWe/qNkmcLA4k0aNm0CflujEcTo6e31YQ2vINSLj3yPVyDUmb6gDaUuwu
 vUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zJo7QaGoxyX6TlHT36IvZ0aaUkuKJt/UWnFBQDxzrv0=;
 fh=Jg1GwjOEZ1S4lNqzrPlyRpppkKciiPaSkBs16SCT10U=;
 b=eAw5i30q300NnascxkUnaT7dk3MdvDumEsKMG8FWBkzF924BnV1r6cjsmlJ5NtCU8I
 6AYlZ9vhYtjSN/8IFBRivXobY1AV75xLZqv7YZ41je0ZhFnY0L5CP0baKqr/joQihcpK
 SZTgVE0qOjHY5j95+z6gya7fB2IchvRjFo78xPb3TTAKcoUwAZ+SQs3JSosqoFYlWPwM
 3MW8CbZI7VLwwegvlhpjPXZ5HKkXUa2tOZVxe6wsySO7QnIAJ8dFkp/P4E/Xbk3dVhnc
 yUJT+26tz4xXs80WPKvyLQz4TEFAa3BP+JA8+nAy0NRAl+uMFkC5Too7E5OlzogdssEz
 9wVg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777959722; x=1778564522; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zJo7QaGoxyX6TlHT36IvZ0aaUkuKJt/UWnFBQDxzrv0=;
 b=xDNvLDDvhePdgqfX87CTeGbyYNncnj/TpRTyGF3Oefo+nnkpmRmnF4cP5GQ91ilMHS
 CE7/nJZ79cNuUVp8EYeav+16aXLf0GCNxDFIffrfZ0yA+SOe/1dy7Tr3ZUU89ozxBR5+
 gNbI9824SJ0fYyPXts6XTzB6B4gHiPlmZRZrGv1M4ta4HhAqSEBseq0bkmCDo0DULzFp
 8PDFkoBL6Ret3wPHeajYzcKwJAQObQ02ESAIejEzlndCMPK6LyMlW1Ofw6U+WgKvTaYx
 CQIeYGfGgQTwBwXRw220VUjEb4JKlgdcqw6HHqO7SWDwKW6LzhyhfNrxd81IDo17uO7g
 qPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777959722; x=1778564522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJo7QaGoxyX6TlHT36IvZ0aaUkuKJt/UWnFBQDxzrv0=;
 b=sNUDX4+gHTwnm6E5T9xB6x4aJl2yZ0piaBMN4OKan2cThkhu641eGKhmiM0MD1cO40
 nmG5Me630tIX3bT6AoSWRbAKpH37GoU4ZNl024HPfRypPdBTcWFBP+kLhh6io5nDbLjH
 zI7jw285ZihmnEh3gBqPWsa5NtWuU7rP8lH9OKFIATunTNBIKJYXsPcbX6Rm4AE5T/7T
 GcAoGk/EIuBM8RjzdNor894gkfNk41Xp5X1r4WgnBeIv7X1QEWE3p3yR1wlYGx9M4Bxo
 BHccx3ZV/Gp0qrxha6H6YngsZ7DM8skKPHHxEvuw1nObMKq3s+3F6p4d1tWlf9MoDIvt
 O4kg==
X-Gm-Message-State: AOJu0YxtPMYsDi/S7748qEwaJJj0gdb67DcQVDNs+4d94rj7EYDy+dxO
 NF42R1j6NOh3u8xlR06VAecflZH/GZcKJJObhOTJWGX5OI4hSC4Uc30uoeYZZoOH6FNbvx+h9x4
 9qwCbRcka/FbPyDvZkOjitNUasMp1H2fD2jYuPc+l+w==
X-Gm-Gg: AeBDieuM7DMyT/FbBEJVarRwMS4ppUdithpTq17m+npjYKw1xnbNCym1SgDMxTwq9qY
 TaWKkIE8puzhXAGJuPaBm0Nfy9W3GrUlLj7x0OjW4pOYbSZIjuR9tVdGfS240Lh8dCVsWUEc6/f
 7j0ydJwX89d/KvcROh1WXdIJov9LRaD77BWZAXWlbnwD7SBNo9P5J7n0s1nsnXcaF5hsNuALsk4
 HfoyF4/lmPr3JzmbXD2WUOoYK18uiOx4q2NYHuvLHzejruBY3WZC3iw0EOrcx4b0eOdbAcWeqk8
 KHhtHlMMmo/RHF+f5peO90HQiclfjK4jyX4zpyny5+zbffaGoZFrqNsc+kg8/2JxgGJZUgJQraX
 PjppVenVvbwBvHcNLyo87BHbAkhxQPJUqJeMt4pEZ5c9RPjcfTqgWm4abeTiW7JTHLSs+i7e8Ig
 uK7IsRLw8wiutBPymElMjZaFsv9BHMtDyR1lCOqf/PEQfH22SZkmw2pGMegICVa1y3t5qByEFqm
 EOsOUxskikcM0TRc1ZzNbKruZHOZCCaKdlYHS4YDSD+Px68Mvd4eFLIfMP6D869wUBdzQyA8ooW
 gLLIqIaYId6rGcOKHGZyQVUE/kLoeOWYalONYB1zkENU+ffe17lfkQVc8cti7hie4h8AiYgcgUv
 3Ejuv2ojT8WcqbfDnGhrB5QNt39A=
X-Received: by 2002:a05:690e:e8d:b0:651:e0cd:5874 with SMTP id
 956f58d0204a3-65c3db4e820mr13446746d50.47.1777959722162; Mon, 04 May 2026
 22:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-3-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-3-b19301d1948a@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 08:41:25 +0300
X-Gm-Features: AVHnY4LOrapsd8e4CvgfV252eofNKkG0criu5difRW2w5sxHdDxkPFAcsaXA_OU
Message-ID: <CAC_iWjLX5zhwakHO=SUqzBZmHA+bVSmG8=0y4D96pCGfPJgRWg@mail.gmail.com>
Subject: Re: [PATCH RFC next 03/18] scripts/Makefile.extrawarn: migrate -Wvla
 to a U-Boot-specific file
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 4 May 2026 at 16:20, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> In the next commits, we'll be synchronizing scripts/Makefile.extrawarn
> with the Linux kernel's at version 6.1 which is what we've been claiming
> we've synced to for a while but that isn't true.
>
> In kernel commit 0bb95f80a38f ("Makefile: Globally enable VLA warning"),
> available in v4.20, -Wvla is now enabled tree-wide and not present in
> scripts/Makefile.extrawarn anymore. When we'll be syncing to v6.1, we'll
> therefore be losing this flag (since it's not in our root Makefile). We
> could backport the changes to the root Makefile to our root Makefile but
> U-Boot is not VLA-free unlike the kernel.
>
> We have two options:
> - backport the changes to the root Makefile and disable it in
>   scripts/Makefile.extrawarn.u-boot,
> - only enable it in scripts/Makefile.extrawarn.u-boot, with the same
>   warn level as currently: 3,
>
> For now, do the second option. We should probably go for the first
> option in the long term and try to synchronize our flags with the
> kernel's. Much bigger undertaking than desired right now.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  Makefile                          | 1 +
>  scripts/Makefile.extrawarn        | 1 -
>  scripts/Makefile.extrawarn.u-boot | 9 +++++++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 49d9740327e..eb61df70838 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1025,6 +1025,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
>  KBUILD_CFLAGS   += $(call cc-option,-Werror=date-time)
>
>  include $(srctree)/scripts/Makefile.extrawarn
> +include $(srctree)/scripts/Makefile.extrawarn.u-boot
>
>  # Add user supplied CPPFLAGS, AFLAGS and CFLAGS as the last assignments
>  KBUILD_CPPFLAGS += $(KCPPFLAGS)
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 4e1714c9484..c5ed501d374 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -65,7 +65,6 @@ warning-3 += -Wpointer-arith
>  warning-3 += -Wredundant-decls
>  warning-3 += -Wswitch-default
>  warning-3 += $(call cc-option, -Wpacked-bitfield-compat)
> -warning-3 += $(call cc-option, -Wvla)
>
>  warning := $(warning-$(findstring 1, $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
>  warning += $(warning-$(findstring 2, $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
> diff --git a/scripts/Makefile.extrawarn.u-boot b/scripts/Makefile.extrawarn.u-boot
> new file mode 100644
> index 00000000000..21872a5492b
> --- /dev/null
> +++ b/scripts/Makefile.extrawarn.u-boot
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# ==========================================================================
> +#
> +# Collection of warnings that are specific to U-Boot
> +#
> +# ==========================================================================
> +ifneq ($(findstring 3, $(KBUILD_EXTRA_WARN)),)
> +KBUILD_CFLAGS += $(call cc-option, -Wvla)
> +endif
>
> --
> 2.54.0
>
