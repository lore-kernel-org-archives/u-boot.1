Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15932CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 15:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0C3B86EE1;
	Fri, 13 Oct 2023 17:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="eqWbzjW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4377986B95; Fri, 13 Oct 2023 17:15:27 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B285D86EB8
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 17:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9b9a494cc59so343639366b.3
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697210111; x=1697814911; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ocbr/e9lYdNvMzMvNP+Fh1uzAMCy+p+YzE7kGZwQk9M=;
 b=eqWbzjW33zrHiYQFYTNK/JvCAAqoJasVgGXeUIGOIYiysj2AMWQ54gYHYYULFshRYN
 x0BQyqcC39b8VOwQ/QR1ekZIdwY61SThMuPrCcuPq4tiknOE0iPZ0ouUYxTb/7FW1NUg
 4i/pm1DiKZDP6SQRagg7N1xcp+q5tYgbjeifbAPk/Tn7BOLowEHoAWZS5W7CoxzWWt27
 kE43fSJFT6I/cQQa8QIItwQbassgsHkmg9n0M7VQlNDRibRNiC52gSm4+HjgPJnQFzzg
 r3Zui2E88J+yxhjbhASIoGQr3VjklxtvzzGgHwV+76QUkD2GZuC7S+mPeXC7JDGnopFu
 vweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697210111; x=1697814911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ocbr/e9lYdNvMzMvNP+Fh1uzAMCy+p+YzE7kGZwQk9M=;
 b=fGPcKrLntH9Rijkf5JrZzbgBoNM3dRLLKXHj4yq0GVmVTwBKcCz4V3t0Ad58P6umd+
 6HFdE/t30EeouaGRdexFnck42h4t2f3+Q7jmTJx6VxCiQ8M270xF3cHn6ixVO4zMLx2h
 FfoIR7VrF0iTeL0JBPXSxnSdWcZxDmgHivtOFY3nUieqRQ6gSEiAaF712OOj8ahsRu8e
 2uqe6+4im8ileH7aadpPzBRWwd1VFEvUjyc/3As7Qu8QburnzdofkXiDBxABSlTuEhw2
 coordeYC+s4lDribepT60FqD1kD29knRbgn3dSb7hNexqWXE5PmnwbEakqtiYOcP7wcn
 g8xQ==
X-Gm-Message-State: AOJu0YwVvjCpqD6niYNfrdTsryOEJRKyuSoOV5xd3FHm73CvR+i7MFkt
 nf8R2Tmj6P8doM1269ZS41PBUAP/Gp9NzRV4/gmOVOVRb/VnvL6sQRE=
X-Google-Smtp-Source: AGHT+IF9XL1JJpkbsfk/2Ze5/gE++UnpLzEJg8SMH8NSvP7sEALDXO4q66QOi5FuYO7yKexZNke+srwmx6IxmfewZVI=
X-Received: by 2002:a17:907:6e01:b0:9be:23a0:4104 with SMTP id
 sd1-20020a1709076e0100b009be23a04104mr259011ejc.29.1697210111096; Fri, 13 Oct
 2023 08:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231012230359.2005249-1-trini@konsulko.com>
 <20231012230359.2005249-4-trini@konsulko.com>
In-Reply-To: <20231012230359.2005249-4-trini@konsulko.com>
From: Simon Glass <sjg@google.com>
Date: Fri, 13 Oct 2023 08:14:57 -0700
Message-ID: <CAPnjgZ1cSJNXZTdRu3LG_Ojo6t_93s+yRfTAoKi+YkJg7_LdFw@mail.gmail.com>
Subject: Re: [PATCH 4/7] m68k: Remove common.h usage
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Angelo Dureghello <angelo@kernel-space.org>
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

Hi Tom,

On Thu, 12 Oct 2023 at 16:11, Tom Rini <trini@konsulko.com> wrote:
>
> We can remove common.h from most cases of the code here, and only a few
> places need an additional header instead.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Angelo Dureghello <angelo@kernel-space.org>
> ---
>  arch/m68k/cpu/mcf523x/cpu.c         | 1 -
>  arch/m68k/cpu/mcf523x/cpu_init.c    | 1 -
>  arch/m68k/cpu/mcf523x/interrupts.c  | 1 -
>  arch/m68k/cpu/mcf523x/speed.c       | 1 -
>  arch/m68k/cpu/mcf52x2/cpu.c         | 1 -
>  arch/m68k/cpu/mcf52x2/cpu_init.c    | 3 +--
>  arch/m68k/cpu/mcf52x2/interrupts.c  | 1 -
>  arch/m68k/cpu/mcf52x2/speed.c       | 1 -
>  arch/m68k/cpu/mcf530x/cpu.c         | 1 -
>  arch/m68k/cpu/mcf530x/cpu_init.c    | 1 -
>  arch/m68k/cpu/mcf530x/interrupts.c  | 1 -
>  arch/m68k/cpu/mcf530x/speed.c       | 1 -
>  arch/m68k/cpu/mcf532x/cpu.c         | 1 -
>  arch/m68k/cpu/mcf532x/cpu_init.c    | 1 -
>  arch/m68k/cpu/mcf532x/interrupts.c  | 1 -
>  arch/m68k/cpu/mcf532x/speed.c       | 1 -
>  arch/m68k/cpu/mcf5445x/cpu.c        | 1 -
>  arch/m68k/cpu/mcf5445x/cpu_init.c   | 1 -
>  arch/m68k/cpu/mcf5445x/dspi.c       | 1 -
>  arch/m68k/cpu/mcf5445x/interrupts.c | 1 -
>  arch/m68k/cpu/mcf5445x/speed.c      | 1 -
>  arch/m68k/cpu/mcf5445x/start.S      | 1 -
>  arch/m68k/include/asm/immap.h       | 1 +
>  arch/m68k/include/asm/immap_520x.h  | 1 +
>  arch/m68k/include/asm/immap_5235.h  | 1 +
>  arch/m68k/include/asm/immap_5272.h  | 1 +
>  arch/m68k/include/asm/immap_5275.h  | 1 +
>  arch/m68k/include/asm/immap_5282.h  | 1 +
>  arch/m68k/include/asm/immap_5301x.h | 1 +
>  arch/m68k/include/asm/immap_5307.h  | 2 ++
>  arch/m68k/include/asm/immap_5329.h  | 1 +
>  arch/m68k/include/asm/immap_5441x.h | 1 +
>  arch/m68k/lib/bdinfo.c              | 3 ++-
>  arch/m68k/lib/bootm.c               | 1 -
>  arch/m68k/lib/cache.c               | 2 +-
>  arch/m68k/lib/fec.c                 | 2 +-
>  arch/m68k/lib/interrupts.c          | 2 +-
>  arch/m68k/lib/time.c                | 1 -
>  arch/m68k/lib/traps.c               | 1 -
>  39 files changed, 17 insertions(+), 30 deletions(-)

I just wondered what we do about '#ifdef CFG_...' which presumably is
not included without common.h ? How does that work?

Regards,
Simon
