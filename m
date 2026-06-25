Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F67CCDB466
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0E3C8498C;
	Thu, 25 Jun 2026 10:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DEki3A5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B147C849CE; Thu, 25 Jun 2026 10:54:53 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7278084A06
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c07a6527453so351136266b.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 01:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782377689; cv=none;
 d=google.com; s=arc-20260327;
 b=YX4pzShoaJ8MIH1Ob/i7AFk0YWmFBexBet19Fi+UsPD0rA6lWFmsIwqgB3Sa44v6le
 d40mTSKtdOpejB2Q9RcpYhi0c2s8ibj3HOQqqe0kA4xIO/4Xgxoy/m473TGjbvMFirTZ
 GjhqY1jNWxJbI4e8ZzAVDm4QuKXkGRDLKkXbFaRtI6lTCCZiKLldBeD6XkEWgSxI7Zl/
 j+Nfzo9cYL8ETpblVqeeb4M008j+L70tceNZ2lM4rdfGYS8rqgdDHWhl7qkDfkb85Bdg
 EJU5KI2HWZ53pmZaUS6jFiBc0iG0LHI/f72SsPkqnHCSrYEZbHJha7jE9unY5ukn+ZkO
 /Clg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pI2s9+D9kn1OQNWyvX0mKqTDXcVWL+3/DXy6ClV/RDo=;
 fh=8bu+8j5OjBJsJE6XfjivLImgYotwkHNSzjUGStlmYis=;
 b=gr/7L6n9Tu9elDsuIEweek9oz5rqaXVWhAIi5eQpYz7jtfDDlXVD+xH1h2IXYX0dkG
 LWRDKVL4lahfFsgQQaOEHMvHxU1UNFQqeEw7/h2QHK7BbAyUPIysS8kUC+KhW1qKnRM8
 2ByhFLtiAwRvbMBKYQI5jCM0kri1V2jMx9dJVThWxQ7yoweTtfggq4yDWVyni5xIy/jz
 YtkIigU8zg/b0ZsJl/wQK3hZfi0Zpmp7DPn1GdOwuFrEvfxVdVtqmwXK9AqM6tJLLFAs
 WLptclJ3inwIYr2le3ej6V6EbeOkU9Z3czAgNI/7UvxkkpyjLkd2CFZA8Ec60uNmUTJK
 /8WQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782377689; x=1782982489; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pI2s9+D9kn1OQNWyvX0mKqTDXcVWL+3/DXy6ClV/RDo=;
 b=DEki3A5DhCcnVeIYkXXcLWzOH7q/A0f7FbYoOxkYcr1OzH+9vaSZe+YFhL2dPuXY5K
 4Tr6vUoHkmwXKYrBGYjclHL4pcTlhJg4xH7cLUjBeQ3n33lRl4+R4SKqD0eZKbF+XnHp
 uowsJtbppAVhqitdkcm6OOMEoRQ3PjQ2kxlOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782377689; x=1782982489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pI2s9+D9kn1OQNWyvX0mKqTDXcVWL+3/DXy6ClV/RDo=;
 b=ZBnEFPEsZCsic5wt/XhTwkq851gMuP9i9de3JCTfUjlDswLF3BIZezn0ZyDRbTwq4r
 cLxaoDgpARO8hUluKvi+aB8aEgQ9TiEHbShcrBKaFeneMphbqX9oazByNQxf0MEUi0HX
 NCnS4Z6nV0jovoYmidELoQ62KODBpQCRmRfvmxsKfaS3F9MFp0pMj10LOUg5Cb7rf5Ui
 ieVwQsdxxttz1P3tPGPpFsUpdHhcuA/lS++zzGg/Z1NV7Mk/Zm4rgty6k9+Mz26HuNal
 AEZD6lLCCMHPWvZPCeTQZbxK+iD5o9/irngoOP4f6HaLQmv2hflrBHTplrb7j5mz1QPC
 QIvw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7aOBBoc84a/346nTRdzqJ0VmvrkJ9D9ht0/KHXcTBEfP8bBi/IrvThOIq2evUTnVgAestpTY=@lists.denx.de
X-Gm-Message-State: AOJu0YwHM9xb7zq99wwxQ2LSF5+FdRzCEri4Ayw8c+j48EwKhx3QwyYQ
 BA11AXKhuN7THXcUDEqzwIfR5NUsVssft2Rptmzmn+cjhREdszT0ISPfPz8Y+zwR+tdrD9jYSn3
 oSbi1NaFsKakneMUn99Hcb+npaTqcdNYCYeWqG5b6HCw0wPeGVvJwvg==
X-Gm-Gg: AfdE7clshqDf5eXsrIqZGbV5RNI9DFhcH5QKK+Wo1ge0A0E+mhLPnvG1EcfK2POFPAQ
 VJEs4PIpYthjpnBcibRI5bi+oO3/oVyWoRwbHO6FR4kNq7RxcSCKCBc2w1c9j2PknZF5mQ6/QcE
 azrombuKjiUeDGVTw+h+ZWCClllXonyA+TI7rBQ3p55XnWmHOjXCKYP0ArJL4pe+SusMnhC4Try
 ATGsP8lfqfMTSu8IOEQsGJ+IM0PuKkX8EFR755lJA887UhRgClAOb+NPozVwmVvytmrqZ1pdA==
X-Received: by 2002:a17:907:968c:b0:c12:3f6:f644 with SMTP id
 a640c23a62f3a-c1205f178b3mr95215266b.36.1782377688926; Thu, 25 Jun 2026
 01:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-10-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260621081915.19154-10-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 09:54:34 +0100
X-Gm-Features: AVVi8Cc4NZeRum7Yts97n27ObEmrXX7hkoyFcAWvxoUJSjaa5rtg55Bqg5vt90k
Message-ID: <CAFLszThopRDCMspX9yMC3f72fOj9mzqDcFmDVDO-UmucCBUMiw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] efi_loader: move efi_main and command loop to
 efi_app_common
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de
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

Hi Heinrich,

On 2026-06-21T08:19:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: move efi_main and command loop to efi_app_common
>
> Add the remaining shared code to efi_app_common to complete the
> refactoring:
>
> * efi_main() - common entry point; calls efi_app_init(), prints
>   app_banner, calls command_loop(), then clears the screen on exit.
> * struct efi_app_cmd - table entry holding the keyword, help text,
>   and a handler of type void (*fn)(u16 *args).
> * command_loop() - iterates app_cmds[], matches keywords with
>   starts_with(), and falls back to efi_app_help() on no match.
> * efi_app_help() - prints each table entry's help line plus the
>   built-in 'exit' line.
>
> Each dump app is updated accordingly:
> * efi_main is removed; command_loop becomes non-static.
> * app_banner[] is defined at file scope with the application's
>   title string.
> * Per-app duplicate state (bs, handle, systable) is removed; apps
>   now use the common module's state.
> [...]
>
> lib/efi_loader/dbginfodump.c    |  95 +++++-------------------------
>  lib/efi_loader/dtbdump.c        | 109 +++++++---------------------------
>  lib/efi_loader/efi_app_common.c | 111 ++++++++++++++++++++++++++++++++++-
>  lib/efi_loader/efi_app_common.h |  31 +++++-----
>  lib/efi_loader/initrddump.c     |  91 +++++------------------------
>  lib/efi_loader/smbiosdump.c     | 126 ++++++++--------------------------------
>  6 files changed, 205 insertions(+), 358 deletions(-)

> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
> @@ -304,3 +317,99 @@ efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
> +extern u16 app_banner[];
> +extern struct efi_app_cmd app_cmds[];

Please move these extern declarations into efi_app_common.h next to
struct efi_app_cmd - inline externs in the .c file hide the contract
that every consumer must define both symbols; putting them in the
header makes the interface explicit and lets the compiler catch type
mismatches.

> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
> @@ -118,20 +99,27 @@ static void print_info(struct efi_loaded_image *info)
> -static efi_status_t do_dump(void)
> +static void do_dump(u16 * __maybe_unused args)
>  {
>       struct dbg_info_header *dbg;
> +
> +     if (!device_path_to_text)
> +             bs->locate_protocol(&guid_device_path_to_text_protocol, NULL,
> +                                  (void **)&device_path_to_text);
> +
>       u32 count;

Declarations should be at the top of the block; u32 count lands after
the locate_protocol() call. Also, the locate_protocol() return value
is now ignored, so a permanent failure silently leaves
device_path_to_text NULL with no diagnostic; the previous code printed
'No device path to text protocol' on error. Please restore that or at
least check the return.

> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
> @@ -164,60 +152,9 @@ static efi_status_t do_dump(void)
>               print(u'\r\n');
>       }
>
> -     return EFI_SUCCESS;
>  }

Stray blank line before the closing brace.

> diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
> @@ -156,16 +143,13 @@ static efi_status_t do_save(u16 *filename)
> -     ret = do_check();
> -     if (ret != EFI_SUCCESS)
> -             return ret;
> -
>       smbios3_anchor = get_config_table(&smbios3_guid);

Behaviour change not mentioned in the commit message: previously
'save' refused to write a malformed table because it ran do_check()
first; now it happily writes whatever is there. If intentional, please
call it out; otherwise restore the check.

> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
> @@ -304,3 +317,99 @@ efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
> +                     for (cmd = app_cmds; cmd->fn; ++cmd) {
> +                             if (starts_with(pos, (u16 *)cmd->cmd)) {
> +                                     efi_uintn_t len;
> +
> +                                     for (len = 0; cmd->cmd[len]; ++len)
> +                                             ;

Isn't there a u16 strlen-style helper that exists here? Also,
cmd->cmd[len - 1] below assumes len > 0; an empty keyword would
underflow. Worth an assertion or comment documenting the invariant.

> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
> @@ -0,0 +0,0 @@
> +struct efi_app_cmd app_cmds[] = {
> +     { u'dump', u"dump - print debug info table\r\n", do_dump },
> +     { }
> +};

The original help text column-aligned the dash ('dump       - print
...') across all apps. With the new table the dash sits right after
the keyword, so 'load' and 'save <initrd>' no longer line up in
initrddump, and likewise for dtbdump/smbiosdump. Easy to restore by
padding the help strings.

Regards,
Simon
