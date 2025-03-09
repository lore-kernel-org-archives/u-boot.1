Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1516C28B28
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 08:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCF3801DE;
	Sun,  9 Mar 2025 09:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y169CbOV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2662280FD8; Sun,  9 Mar 2025 09:47:51 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E878480107
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 09:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e636585c375so1341487276.1
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 00:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741510068; x=1742114868; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+PmDKW25ZigNJPYKCwp1eLOwtuHFn6QZSuqkuEpxH2s=;
 b=y169CbOVNBCaMPX4RrVoNDZJ9MFd6xWGAwaMoYhh4WnrNt6cIQPK0p+HLCuoAqCHuB
 h2Q08wghz0BFwLXUC4UTRt0m44YQM1gvQMKHjd8TDwf+DNvIfwE5t9Lm1Kc9MlG/nKHz
 dcCyOJHwxHf1hKLelZRL93MmJxlLHZtm92N9mXBC2gHn7lQx8pWP0So5mOoEwqaVUxKV
 hyIqWI7Q4jvB9FaXqOQbJ9iqFbms54CLHjwrlSHTQRxEApw6XZmOWXmi2nPttm0nMDAF
 aThU4V4N8FfGu5Hxe944bj8qCdC0/KMhOEd1YPpPPHqUI6dl2m6/xfF/hLVjkX50SIVn
 jtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741510068; x=1742114868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+PmDKW25ZigNJPYKCwp1eLOwtuHFn6QZSuqkuEpxH2s=;
 b=WGHwZ09KoJGDeVD0zlXfZly2rtlhwdU4J8Nw/jwtkdgufyrKtFOV+o3wYdDLqbqC80
 14B+bbxlaxlQQWBGWPiWN8zF6+X50fAuWXJK1fDcll/+FJ0e3wIQVxmENoneo272Qenp
 rKykW0J5RDvyMY+IoZ0mrKUQ2jWnhre3rHae1e2ppocm7S5rKu62f6gEivRYoGFWc4bY
 g3ZrIHOHHG/xiPlYat91UEuQbD61sL06KWUxdC/7S/hr9HvCAvovPXMjP3nWlQPUtgfT
 FowHOp0+bfkMvUqjKfVMPmJstT2jmNISqqrE2G82UEliWEZyj8E9e3+XKrQyJMMZOnzv
 9Wug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBQdiLICI8bQP+G4k/S/yVwLSuUYNJbKOr7Kuec9HgPllPBOUQk/DazXRbhXWWMYHvNa6CxYU=@lists.denx.de
X-Gm-Message-State: AOJu0YwFb+hZA1gq6zrH6LcBtcD2LMe4fVHhsQi+DCP2doX4nFWwzzJE
 VTwJuGvYrmzQYux8Cdv33H0fzgoMkDOD48lim1vRKbhyeisznwD571d03bvhyC6ayVfy3QUT93/
 DCXKGa0YktuZ7zq2zsTg47iQ1oDtQXqhJBuBOpg==
X-Gm-Gg: ASbGncsB3OeNhftmvATH4B1MslrC03qwkWIdyAqWU9+ho5114n+mVeoZMuYqs8kC4TZ
 G1UvexpGa++1ujC0Bhkf4bRTtJCrRyC5VglCy4Bs+dL0Izk+KOFK5R30VZgNYLy/g1EqJN7vGFM
 Bv16ead3rAx/3q5B57LxRYunKfq2Q=
X-Google-Smtp-Source: AGHT+IGDVxyniGLyFGVeRNFDlHAVGsShb8IG6IJ9P+rs6uAjVky8xjWp7zTHxnlj9Q3RUaBKaO6fnVCBVdEYy2HSOyU=
X-Received: by 2002:a05:6902:1896:b0:e60:8734:64df with SMTP id
 3f1490d57ef6-e635c1caaacmr12463055276.36.1741510067790; Sun, 09 Mar 2025
 00:47:47 -0800 (PST)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-3-CFSworks@gmail.com>
In-Reply-To: <20250224055524.1334929-3-CFSworks@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 9 Mar 2025 10:47:11 +0200
X-Gm-Features: AQ5f1JrAPK94OGB8Gl-18-iPmJD8iZmv5kl1xRx8uQYWqKiRuKbf3AYWoXIcnRQ
Message-ID: <CAC_iWjJC_eDyt_1o2-+JKrULe8ETDmBZtLK73xjWE0Qj0LugJg@mail.gmail.com>
Subject: Re: [PATCH 02/17] arm: Exclude eabi_compat from LTO
To: Sam Edwards <cfsworks@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de
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

On Mon, 24 Feb 2025 at 07:55, Sam Edwards <cfsworks@gmail.com> wrote:
>
> These symbols need to survive the IR-level dead function elimination pass,
> since nothing at the IR level is referencing them (calls to these are inserted
> later, at codegen time).
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  arch/arm/lib/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 1c95dd6fed2..74cd5051552 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_GENERATE_ACPI_TABLE) += acpi_table.o
>  # For EABI conformant tool chains, provide eabi_compat()
>  ifneq (,$(findstring -mabi=aapcs-linux,$(PLATFORM_CPPFLAGS)))
>  extra-y        += eabi_compat.o
> +CFLAGS_REMOVE_eabi_compat.o := $(LTO_CFLAGS)
>  endif
>
>  # some files can only build in ARM or THUMB2, not THUMB1
> --
> 2.45.2
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
