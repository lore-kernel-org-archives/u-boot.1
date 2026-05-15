Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A11CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74945846AE;
	Fri, 15 May 2026 16:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CFnsCnHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0D84846F9; Fri, 15 May 2026 16:15:22 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D258384676
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bce386d5b85so1071661066b.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854520; cv=none;
 d=google.com; s=arc-20240605;
 b=ke/jtQKUqvReCHj8pLWF3caqzHMLvaFnNViKX76mfZu1G3ESmTGHqCDmlyzcBw/By8
 bpm77zdQc1f85lJd+/wyR5j7QXtiUMlBqxKqxq0hs7s3NkossppCh2+P3CzuUNm4BSRL
 ufXCghfQA8OfAYAyiZX6OpELsfSfczSdsfvdvc47LDf3K8C23cBGd5PC1KN5spgawO9J
 8CsmD4KjqUUiKt3wrEmqHZKTSFJeqMht6naTup3vODxsefB909jiluFuniL0ncTnNAlF
 YjOk6FGqFtODG6UHTM30fJS0+M4Wn7LLjYQIwoiFU6AyPpWwIT5Uiq9pXkAYSSMBGuah
 Xjsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iM5wn4QOxk6ZufoF7sstH3lGmubt7QbYVr3tc/BJkT0=;
 fh=/9dRg05TWxMu6GYndjS9/cjxspW8q/mBJWDCwSbiK3E=;
 b=EacV/PzZaWCZ37OcL6j097wJODh5/Wbnq8xnvmex3qeGjEit0/RNp622IBlaUd6wwq
 RSGL5h3BridlmbFn9wKUyskOzMzidXaT7ICUVz+lJOFr4ot5Q844hF/yux0FMHMBzn4F
 1PBqY8IXUoteyWY+Y46yLFGLBebu1mDBJe+b6j8zFkO+12NUXfvouNQgkRiXMPi3MHpi
 IgtO8VXxkTQ6bbK6SIR44si3GMstKFkoUrOrN1HWbQ6jsM8bSbchp+SD3ouBWTFgIRIa
 PZJ542WGLqxjfWISdVg18/p891BL0LGh5uuEGb/aHI4xnRnPkreCMsjflox4VNrG14Lv
 frDQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778854520; x=1779459320; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iM5wn4QOxk6ZufoF7sstH3lGmubt7QbYVr3tc/BJkT0=;
 b=CFnsCnHyb20cAo0T830f6hQSFFRn4oMLhOY2w3/0znzIBO6dxgNyTX97IbMhQQ0ol6
 00y/NThaU3/7AnADbqQkyLrUWz3GtuLKpHgWgGpy6EinsbGJHy6rFpyAy/s0b+5NK0tz
 xxpFAdH0OcdWz0jDJpXRG15ykbASxVSwm448Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854520; x=1779459320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iM5wn4QOxk6ZufoF7sstH3lGmubt7QbYVr3tc/BJkT0=;
 b=pOL6DPLCe007KUJ6MxTT7GxZpbd3ADpU6jT125PPgGq8g0/+bhKVD1VKmic0CEh/0b
 WxAp+S68zHHzL6JJywgSu9ylLTkgGyTKbs+Jy38rSl1fQWfMLbxdIhZcbHRT3j6dpTc8
 SZZu8GFNW8lyazxSfdhQNbuqzNWETR2E4ZtAYeq6tHh8ppYVPhl897KtocPpD0Au11hZ
 inglEf8tQ21Z707WZ/RMfLrDbYy5zq5CQI0dTQfVW9c/Vh9LhJB2KXbLnWTI8WPos/QQ
 OPHWWcAQDwUiWGPdCjDGUnyM1JZZ/vCoh5GZx1+FxHThmJ66H/Tfas9OioguURHtpCYg
 l3Hw==
X-Gm-Message-State: AOJu0YylMjs1YptMC3a8G7DlabWCOz7QckwKpBLApjAKxtUeh8wy7fwJ
 9y0wxjXa3JpPY3ueu0cCfN7yYz0jEwlVfwlgbp6PWJufKekQbr8hiXvZDnAafP8HJrBJfJ3NpIk
 PFQc4jbnUrZrfQCSWjmD0PVsqwTnioiddgbnTQhoo
X-Gm-Gg: Acq92OEmTA50w2gKfzjI/vgiiSGJAn/KCkhmjUdoXPxaEpFnPc7pV1e/tFpJaYiRYOg
 qxhisjHNE7QNluagWzvfN2+sUBMCwX9QybQVKjrvdi7yB3lRaR3obFM0RtkpqR01DnDQg5Okful
 vL20SXLB0iQfsnxQ84TXY0rC0Rc3LDssyKVCUD2AFWurByrnvtIGhPZUPU6juVuA05A5yeXp5ZU
 85i37GLz4+wkBdvazK3o6jvLmuxHUEuqF2rx1R4fNmlY9Sjenq34uGr/C+1XjkaPJIJ/a+HtdZ6
 EgAWCWt98ymEH0V+
X-Received: by 2002:a17:906:6185:b0:bc4:f44f:e145 with SMTP id
 a640c23a62f3a-bd5177ecdf9mr219077066b.16.1778854520126; Fri, 15 May 2026
 07:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778619453.git.aidan@wolfssl.com>
 <20260513002625.76915-10-aidan@wolfssl.com>
In-Reply-To: <20260513002625.76915-10-aidan@wolfssl.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 08:15:08 -0600
X-Gm-Features: AVHnY4LDnVeZ8CiHni-cs18GZG1o6Y5Z7YGUYDfgLUs3MT8OT8jm_WxDfJBIDko
Message-ID: <CAFLszTi25b03eNwFhkSrAK7VAS-7oLws7UACTc5ERiyqDuetYA@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] cmd: refactor tpm2 command into frontend/backend
 architecture
To: aidan@wolfssl.com
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 David Garske <david@wolfssl.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Jerome Forissier <jerome@forissier.org>, 
 Sean Edmond <seanedmond@microsoft.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Heiko Schocher <hs@nabladev.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, 
 Brian Sune <briansune@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

Hi Aidan,

On 2026-05-13T00:26:04, Aidan Garske <aidan@wolfssl.com> wrote:
> cmd: refactor tpm2 command into frontend/backend architecture
>
> Split the tpm2 command implementation into a shared frontend and
> two selectable backends. This allows wolfTPM to provide its own
> TPM2 command implementations while keeping the command table,
> dispatcher, and help text shared.
>
> Architecture:
>
> cmd/tpm-v2.c (frontend - always compiled):
>   Contains the tpm2_commands[] table, get_tpm2_commands(), the
>   do_tpm2() dispatcher, and the U_BOOT_CMD help text. References
>   backend functions via cmd/tpm2-backend.h. When CONFIG_TPM_WOLF
>   is enabled, additional wolfTPM-only commands (caps, pcr_print,
>   firmware_update, firmware_cancel) are added to the table.
>
> cmd/tpm2-backend.h (new):
>   Declares all backend function prototypes that both backends must
>   implement: do_tpm2_device, do_tpm2_info, do_tpm2_init,
>   do_tpm2_startup, do_tpm2_selftest, do_tpm2_clear,
> [...]
>
> cmd/Kconfig        |   11 +
>  cmd/Makefile       |   10 +-
>  cmd/native_tpm2.c  |  516 +++++++++++++++++++++++
>  cmd/tpm-v2.c       |  559 +++----------------------
>  cmd/tpm2-backend.h |   66 +++
>  cmd/wolftpm.c      | 1170 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 1840 insertions(+), 492 deletions(-)

> diff --git a/cmd/wolftpm.c b/cmd/wolftpm.c
> @@ -0,0 +1,1170 @@
> +#define LOG_CATEGORY UCLASS_BOOTSTD

wolftpm.c has nothing to do with the bootstd uclass. Should be
UCLASS_TPM (or LOGC_NONE). Likely applies to other files in this
series too.

> diff --git a/cmd/wolftpm.c b/cmd/wolftpm.c
> @@ -0,0 +1,1170 @@
> +             /* full test */
> +             if (fullTest == YES) {
> +                     rc = wolfTPM2_SelfTest(&dev);
> +                     if (rc != TPM_RC_SUCCESS) {
> +                             log_debug("TPM2 Self Test: Result = 0x%x (%s)\n", rc,
> +                                     TPM2_GetRCString(rc));
> +                     }
> +             /* continue test */
> +             } else {
> +                     rc = wolfTPM2_SelfTest(&dev);
> +                     if (rc != TPM_RC_SUCCESS) {
> +                             log_debug("TPM2 Self Test: Result = 0x%x (%s)\n", rc,
> +                                     TPM2_GetRCString(rc));
> +                     }
> +             }

Both branches do the same thing - continue is meant to be incremental,
not full. The native backend passes TPMI_YES/TPMI_NO to
tpm2_self_test() to distinguish. Please call the appropriate wolfTPM
API for the incremental case, or collapse the branches and document
that there's no difference.

> diff --git a/cmd/wolftpm.c b/cmd/wolftpm.c
> @@ -0,0 +1,1170 @@
> +     rc = wolfTPM2_ExtendPCR(&dev, pcrIndex, algo, digest, digestLen);
> +     if (rc != TPM_RC_SUCCESS) {
> +             log_debug("TPM2_PCR_Extend failed 0x%x: %s\n", rc,
> +                     TPM2_GetRCString(rc));
> +     }
> +
> +     unmap_sysmem(digest);
> +     wolfTPM2_Cleanup(&dev);
> +
> +     log_debug("tpm2 pcr_extend: rc = %d (%s)\n", rc, TPM2_GetRCString(rc));
> +
> +     return rc;

Most wolfTPM handlers return the raw TPM2 return code directly to the
shell. The native backend funnels everything through
report_return_code() which maps non-zero rc to CMD_RET_FAILURE and
prints a useful diagnostic. Returning a raw TPM_RC from a cmd_tbl
handler is not what the shell expects - please use
report_return_code() so the two backends behave the same from the
user's perspective.

> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> @@ -511,7 +55,22 @@ struct cmd_tbl *get_tpm2_commands(unsigned int *size)
> +#ifdef CONFIG_TPM_WOLF
> +     U_BOOT_CMD_MKENT(caps, 0, 1, do_tpm2_caps, "", ""),
> +     U_BOOT_CMD_MKENT(pcr_print, 0, 1, do_tpm2_pcr_print, "", ""),
> +#ifdef WOLFTPM_FIRMWARE_UPGRADE
> +#if defined(WOLFTPM_SLB9672) || defined(WOLFTPM_SLB9673)
> +     U_BOOT_CMD_MKENT(firmware_update, 0, 1,
> +                      do_tpm2_firmware_update, "", ""),
> +     U_BOOT_CMD_MKENT(firmware_cancel, 0, 1,
> +                      do_tpm2_firmware_cancel, "", ""),
> +#endif /* WOLFTPM_SLB9672 || WOLFTPM_SLB9673 */
> +#endif /* WOLFTPM_FIRMWARE_UPGRADE */
> +#endif /* CONFIG_TPM_WOLF */

The supposedly-shared frontend now contains four levels of
backend-specific #ifdef in both the table and the help text. The
shared-command-table argument for splitting the file is weaker than it
looks. Worse, the inner #if defined(WOLFTPM_SLB9672)... tests a symbol
from a wolfTPM-private header, not a Kconfig - so tpm-v2.c now needs
the wolfTPM header search path even though it otherwise has nothing to
do with wolfTPM. A Kconfig (e.g. CONFIG_TPM_WOLF_FW_UPGRADE) would be
much cleaner.

> diff --git a/cmd/wolftpm.c b/cmd/wolftpm.c
> @@ -0,0 +1,1170 @@
> +int do_tpm2_device(struct cmd_tbl *cmdtp, int flag,
> +     int argc, char *const argv[])
> +{
> +     WOLFTPM2_DEV dev;
> +     WOLFTPM2_CAPS caps;
> +     int rc;
> +
> +     /* Expected 1 arg only in native SPI mode (no device switching) */
> +     if (argc != 1)
> +             return CMD_RET_USAGE;

The shared help text still advertises 'device [num device]' but this
implementation rejects any argument. Either implement device switching
or trim the help text when CONFIG_TPM_WOLF is set - quietly diverging
from the documented interface is worse than either.

> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> @@ -521,7 +80,7 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
>  'autostart\n'
> -"    Initalize the tpm, perform a Startup(clear) and run a full selftest\n"
> +"    Initialize the tpm, perform a Startup(clear) and run a full selftest\n"

> @@ -573,6 +132,10 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
>  "change_auth <hierarchy> <new_pw> [<old_pw>]\n"
>  "    <hierarchy>: the hierarchy\n"
> +"        * TPM2_RH_LOCKOUT\n"
> +"        * TPM2_RH_ENDORSEMENT\n"
> +"        * TPM2_RH_OWNER\n"
> +"        * TPM2_RH_PLATFORM\n"

These are independent improvements - please split into their own
patches so they can be picked up even if the wolfTPM bits don't land.

> diff --git a/cmd/wolftpm.c b/cmd/wolftpm.c
> @@ -0,0 +1,1170 @@
> +#include <wolftpm/tpm2.h>
> +#include <wolftpm/tpm2_wrap.h>
> +#include <wolftpm/tpm2_packet.h>
> +#include <wolftpm.h>
> +
> +#include <stdio.h>
> +#include <hash.h>

Include ordering is also upside-down: U-Boot convention is <command.h>
and core headers first, then driver/library headers. The file also
uses camelCase locals
(doStartup/fullTest/pcrIndex/digestLen/manifest_bufSz) and
uint8_t/uint16_t/uint32_t throughout; U-Boot style is snake_case and
u8/u16/u32. Please run patman / checkpatch and adjust.

Regards,
Simon
