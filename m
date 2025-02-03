Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8556C02194
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 13:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B89180079;
	Mon,  3 Feb 2025 14:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lRQgnyy4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DADF80087; Mon,  3 Feb 2025 14:15:58 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2AAE80077
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 14:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e5b107c4346so90923276.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 05:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738588554; x=1739193354; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xRFx9tF/Bj+QNvMHcwgEW4i9i+zIfQjWj2+95LjyP6M=;
 b=lRQgnyy49cbzuSXX9UM3zXo7LF42wqxaSUp7oGP3+CgFZIiMAMg868K/hudcMYS7Ut
 gtmAth3DbwVvrNCH4UVvvnZEJRK/3YjMrlugmTV1IfOQ0cmuezGIPS2eCHn9U0iQUTza
 Kc5ShkLzdLHLJofVIiC4zidPAYU9zKfZuMGHx6Nw+hOrV6pcgvTfHBz7+rn7B5K4o4rs
 Ur+Cb3vCeI9mM+nkDsAVnZTSOeRaEpC5LIJv+oiVTQtK/b56UFQqM5q1IZpTGk/pNtNP
 vnlPmgtSHaE8O213uCGeahRyE+CNuGc64aNA+/7h/Zove8Tm5vkjzmUPKGn5I7hUNpVV
 7wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738588554; x=1739193354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xRFx9tF/Bj+QNvMHcwgEW4i9i+zIfQjWj2+95LjyP6M=;
 b=SHtpGkl8Wkn+wG8bITjOKbI81lBvKlgQ2SqW4zuYrfcXs0RftLBXkMqoTLAlYhNCQO
 gqRk6n48kEmkgBBmbVZXclA7okL4u1HF+q03F1Dv6PIb3CKYqC5hTH3hXaUkTnAh1rgN
 /sUETtstUcIYJzc5OvDN1uZ+8n0c1ikXTJE502Qavx9i84IBuu9PuZmX6aDpLGcgKVYH
 z3y0FhzFXv2jBOSIl9ipSJsfwbHXL+6U0rXf8YaTLTjPxCGumasrNkTxPccYbt0HNmL7
 hMG9+rMkr72cwhSyfz5NF81KUG8pyeXTBCEijXvaziQhkgJ2p2JTkhZ8WFoQhPRH7ZTq
 T7jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4M/HnjvpDXduvM4leET/Mr51MxNJW4nyobBd4CbmAYJSUsigvsCb3n/BERiEmfCwhl9iw7ZI=@lists.denx.de
X-Gm-Message-State: AOJu0YwBGX8eYy1GbOTZzhxRb2EQsE1opQ37SuuxkgkcPyJP8AzcaWN+
 rgOrUI42WZwAuZ8Wnj/nDtCMgXFZp97ZCCcFoG8tAHeL/U26/Chg56Wu8PzQo7ThbGMbOKaDa3k
 RQAaqVfcYs/iyRYkC7lyO5M/G5JQtCzYQ9VkZNQ==
X-Gm-Gg: ASbGnctu3eerAHY/npXgCxzxOMRFwS+JbO1nx0qxbly4QPv3nYcIa5JfeJZtMI1ajs0
 5sIYPi4Y4gaAo3G10t77a/7ZQ0ZrKsnYRMhe4w9QXQ/dpQtfkhF9Li6H8GVFIaWG8W6l0Tl+G
X-Google-Smtp-Source: AGHT+IFLx3ln9p66vl0HC/C5hDdzMZnpDJOo08EFYRE6XqVffcP7+0Tgab0GsKKRjCuF42qA91pckH/QmLlyt1dx4mM=
X-Received: by 2002:a05:6902:2006:b0:e5b:111b:a8d7 with SMTP id
 3f1490d57ef6-e5b111ba9abmr58497276.41.1738588554659; Mon, 03 Feb 2025
 05:15:54 -0800 (PST)
MIME-Version: 1.0
References: <20250130133646.2177194-1-andre.przywara@arm.com>
In-Reply-To: <20250130133646.2177194-1-andre.przywara@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 3 Feb 2025 15:15:18 +0200
X-Gm-Features: AWEUYZljDdTjmzQGR4E3Cpqhisg7aDAhD6S_HFNZeAI55qIqGmdCIK8g4bhSS3s
Message-ID: <CAC_iWjL0MQEwk7iVfBDYE6bA+ULkP1Nct4OjsRSbbjVefmkF4g@mail.gmail.com>
Subject: Re: [PATCH] env: fat: Avoid writing to read-only location
To: Andre Przywara <andre.przywara@arm.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Thanks Andre,


On Thu, 30 Jan 2025 at 15:37, Andre Przywara <andre.przywara@arm.com> wrote:
>
> The env_fat_get_dev_part() function mostly returns a fixed string, set
> via some Kconfig variable. However when the first character is a colon,
> that means that the boot device number is determined at runtime, and
> patched in. This requires altering the string.
>
> So far this was done via some ugly and actually illegal direct write to
> the .rodata string storage. We got away with this because U-Boot maps
> everything as read/write/execute so far.
>
> A proposed patch set actually enforces read-only (and no-execute)
> permissions in the page tables, so this routine now causes an exception:
> =======================
> Loading Environment from FAT... "Synchronous Abort" handler, esr 0x9600004f, far 0xfffb7d4c
> elr: 000000004a054228 lr : 000000004a05421c (reloc)
> elr: 00000000fff7c228 lr : 00000000fff7c21c
> .....
> =======================
>
> Rewrite the routine to do away with the dodgy string manipulation,
> instead allocate the string in the r/w .data section, where we can
> safely manipulate it.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
>
> found when naively testing Ilias' series on some Allwinner board.
> I am sure there are better ways to implement this (probably as many as
> there are developers), but this works for me.
> This does away with the optimisation of doing the manipulation only
> once, but I am not sure that's really worthwhile?
>
> Cheers,
> Andre
>
>  env/fat.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/env/fat.c b/env/fat.c
> index b04b1d9c315..1ad301eaaff 100644
> --- a/env/fat.c
> +++ b/env/fat.c
> @@ -41,14 +41,12 @@ __weak const char *env_fat_get_intf(void)
>  __weak char *env_fat_get_dev_part(void)
>  {
>  #ifdef CONFIG_MMC
> -       static char *part_str;
> -
> -       if (!part_str) {
> -               part_str = CONFIG_ENV_FAT_DEVICE_AND_PART;
> -               if (!strcmp(CONFIG_ENV_FAT_INTERFACE, "mmc") && part_str[0] == ':') {
> -                       part_str = "0" CONFIG_ENV_FAT_DEVICE_AND_PART;
> -                       part_str[0] += mmc_get_env_dev();
> -               }
> +       /* reserve one more char for the manipulation below */
> +       static char part_str[] = CONFIG_ENV_FAT_DEVICE_AND_PART "\0";
> +
> +       if (!strcmp(CONFIG_ENV_FAT_INTERFACE, "mmc") && part_str[0] == ':') {
> +               part_str[0] = '0' + mmc_get_env_dev();
> +               strcpy(&part_str[1], CONFIG_ENV_FAT_DEVICE_AND_PART);
>         }
>
>         return part_str;
> --
> 2.25.1
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
