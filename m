Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FCCC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06A5784A29;
	Thu,  9 Jul 2026 03:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FU/hfmjk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AD9984A48; Thu,  9 Jul 2026 03:21:41 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BACC84A1F
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c126b8118afso182930766b.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783560097; cv=none;
 d=google.com; s=arc-20260327;
 b=h8XhtpqHjEfggVwu61/xJH8gwMywUlAKwzlAb/sMDJIA9ZdhRYE3eXH3sWYqFLc0f2
 fLsZUDgM2ByFb31XZvKSnHqP869S4h9MjtMpGhz4dV8IxRJ02A/oW1xa/Tjvib657+Ez
 qRw8ZQk31l7qI2R9poBw/seZqxM5xQdQCAwouwKdg+UzxF6BAKlPxfkOD9BfKumHgDh1
 w9OTcIqdIv8FgGwNsx/WlLWRvuzkzuhV5Fi+ecuJw14rhCPzB4+UXtcKThxeAgWSzI2h
 r24DG1yJW9NR1ZGjMH1t4iMj9PkbyG8vnxkRadsApJB0vfnpqTr35mxzrqqxODHATf3G
 7UMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=riu1GDlfFuE1XslP52ibE8UDCHWccwkoFDjY5jH64z0=;
 fh=DDQzrwH1M51KrRiJ9rD49fa0HzsLApQ8iBK28xqUwYI=;
 b=q0ZNQSm4ND9FKEowQ1czoMphXTrOk3HP8dSrESGt9JZaoaRcvrvb8vHNLvEW2E0xte
 vjdgfAF179+PLuIvmmoM16relP/2HUZdt6mhjic1xhuMINypzZlseinikzrLZVfz+Plc
 slzabaaBbp9rqvoJNvI/EW5TZsVxTJYHHA3KYst9HhVkPtyc9qTIKuJzKBiyGla9XbH7
 dRn/88O6oIfPWgt3vh0pKSGsa5wxBN18kFEiINhbRVdzFbIhnbswvtzlq/kNO9Yxifj+
 FEFpPpqtUDhR6OK2d2/sdDqqNUnq4zRmYeu9LbwXjwmQwgDuIayULDwaBtCOorGM5i5i
 n33g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783560097; x=1784164897; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=riu1GDlfFuE1XslP52ibE8UDCHWccwkoFDjY5jH64z0=;
 b=FU/hfmjkFYEf2C9DVe+b5F3J3OgQMCNkNkuBzt2BE+7/7U4lGvvL/kMHXh96r44YEx
 EI3M1Ef0/4u5I1IO+xHdmIJleOVwauHrTbRxOXgNuJXrz8Sn4PA2LzRnD0aM1vfMbMSo
 8yHuBlq+PE0+PtH4hZWLCoww3gfs9p9FgV3Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783560097; x=1784164897;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=riu1GDlfFuE1XslP52ibE8UDCHWccwkoFDjY5jH64z0=;
 b=TnByGWGgi2p21JO4I+1J6FI9YtntigNkzkQn/u/Rzz4W6xSVFxqMfdYspCE7YtJ0yS
 SoFqV4J6Oo76fBvIdv85gbcSbO+CFIKmEen7zch+idyeGpHofPDh88A3ei6s8X1O5Zzq
 pckJjJbeVUYLI8TRJOQICAuupShJi5mvklxIbJaG/ljcL14GXyHPBZM97nWYy4iFEsHn
 UDOANEo6EGOwQ2ScP/l+XEqRSOjiwakmfgU6WRC5w2ggioIfKvU+P7IZ8K/QGRCQrAqP
 iul3Qhq+G/I3SJgF7zWlHYS1ZgxGCfER8t2aI2fcYdUk0VDrQf6AHRpEuLdbbuIad1NZ
 FMrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqqCI1n9O7DJ5qfsaq0Bce2AzgCwuMcK2dJTs/E4t+Xfx2uG5vFh15FFGXITJ7ghGJUYON/0c=@lists.denx.de
X-Gm-Message-State: AOJu0YxbeTpl8YzA+z7nOEHC9STYKX0OP7WK3flazGXBt+cV62vVen1h
 EQislzkskhPqLGRJhVQcszto/XrBM+hNC+aJI1ZI8k5Rk4ZwUniGIgTnEXD9rczuImA8Ks38ftt
 FVRrxZEoiLwx6T3sFlMsUSX3SHrnfDcHhIbZ7aOms
X-Gm-Gg: AfdE7cljGgAWJ1Ev7aKztbkQz3BdnU4HJblXLd9gT7i9bGTEuXfbzTs/UAz4NwD5bPh
 IBFUqRvJMkjZb9REi1+cmEl7ldkUVFZkK8D+ynr0tTydyvXVeiztV/v4f8jMkP73R2NIwfimU8w
 UYw9pAIxK+O8NWh6zo1wLnpMVAbDSZdZJkdBAljQh7+UJCgY6HtkwnlS9S10e5FmErWahRH/KAU
 P2IEbSq+xCUHS1Igsq0Ce7cStT9rdLnBbB0uKEdxrgzGd+BTM4m81t072+1YvXWENQkrrm3ZeZv
 VKkECA==
X-Received: by 2002:a17:906:2083:b0:c15:b830:8bf5 with SMTP id
 a640c23a62f3a-c15ce1085b2mr102235666b.43.1783560097547; Wed, 08 Jul 2026
 18:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260603132953.36042-1-jayaramudu.desapogu@amd.com>
In-Reply-To: <20260603132953.36042-1-jayaramudu.desapogu@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jul 2026 19:21:26 -0600
X-Gm-Features: AUfX_mwtaHwfXWymdJIgSWbsBRwu9Myy650EYVWkxEo3wbvCK-LakDXOxAKXwbQ
Message-ID: <CAFLszTgvBrNzb1Nvrj6CH0KBFW=v-Af5=0Q7UAHP15vy4P-LqQ@mail.gmail.com>
Subject: Re: [PATCH] video: fix no display when serial console is disabled
To: jayaramudu.desapogu@amd.com
Cc: sjg@chromium.org, u-boot@lists.denx.de
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

Hi Desapogu,

On 2026-06-03T13:29:53, Desapogu Jayaramudu <jayaramudu.desapogu@amd.com> wrote:
> video: fix no display when serial console is disabled
>
> When the serial console is disabled in coreboot configuration,
> no display output is observed during boot.
>
> This happens because DBG2 (Debug Port 2 table) configuration
> is required for proper UART initialization and affects the
> video initialization path.
>
> Fix this by ensuring DBG2 is correctly configured as a
> 16550-compatible UART, allowing video initialization to
> proceed independently of serial console settings.
>
> Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
>
> include/acpi/acpi_table.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for looking at this!

The commit message does not match the change. DBG2 is an ACPI table
produced by coreboot and consumed by U-Boot only as a fallback in
read_dbg2() when lib_sysinfo.serial is NULL; it is not on the video
init path. Please describe what actually happens. I suspect that when
the coreboot serial console is disabled, coreboot emits a DBG2 with
port_subtype 0x0012 (16550 with parameters defined in the GAS), the
check in serial_coreboot.c rejects it, the UART is not detected, and
that somehow prevents the video console from coming up. Please
describe the real chain of events and the observed symptom.

> diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
> @@ -667,7 +667,7 @@ struct __packed acpi_dmar {
>
>  /* Subtypes for port_subtype field */
>
> -#define ACPI_DBG2_16550_COMPATIBLE   0x0000
> +#define ACPI_DBG2_16550_COMPATIBLE   0x0012

Not quite. Per the Microsoft DBG2 specification (and Linux's
acpi/actbl1.h), 0x0000 is "Fully 16550-compatible" and 0x0012 is
"16550-compatible with parameters defined in the Generic Address
Structure", i.e. two distinct subtypes. Redefining the existing macro
silently changes the value written out by acpi_create_dbg2() in
lib/acpi/acpi_table.c and by spcr->interface_type in
acpi_write_spcr(), so every board that emits these tables now
advertises the wrong subtype to the OS.

Please leave ACPI_DBG2_16550_COMPATIBLE = 0x0000, add a new macro
(e.g. ACPI_DBG2_16550_GAS = 0x0012), and fix the real problem in
drivers/serial/serial_coreboot.c by accepting both subtypes:

    if (dbg->port_subtype != ACPI_DBG2_16550_COMPATIBLE &&
        dbg->port_subtype != ACPI_DBG2_16550_GAS) {

That way the coreboot fallback works whichever subtype coreboot emits,
and the tables U-Boot writes remain correct.

Please also include the coreboot output showing the actual
port_subtype in your DBG2 (a hex dump, or the log_debug from
read_dbg2()) so the reasoning is verifiable.

Also you might look at this series where I had a similar problem:

https://patchwork.ozlabs.org/project/uboot/list/?series=433605&state=*

IMO coreboot should provide the serial details regardless of whether
the console is enabled, but I was unable to get that change in, so
your approach is the best.

Also let me know if you are working with OpenSIL. I would be great to
see a coreboot + OpenSIL + U-Boot combination.

Regards,
Simon
