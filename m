Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80350D3C90B
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 11:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B88488B23;
	Sat, 19 Oct 2024 13:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gh9jjVzs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5451892D8; Sat, 19 Oct 2024 13:51:13 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BE5A892B1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 13:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbcd49b833so17949246d6.3
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 04:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729338670; x=1729943470; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P0Vd7JwBs73h5PgK2woaxYvdnb6CG9474ACdRhpf9ok=;
 b=gh9jjVzsU/QkpefGcTFcir4D1sXKwCYfMlLH5R/rGlCBYRZ8ZbW4UbmVohSkVWBPV+
 bvBdDXuF46dM/w++JbQWhhLFntCpVimuL+l/wGCzoVTYU2jX3HAT5mYmstQv/XmyPgRU
 LJrY5PsGFRKqVV25aTuJUlSg5z/eT2FFtpszo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729338670; x=1729943470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P0Vd7JwBs73h5PgK2woaxYvdnb6CG9474ACdRhpf9ok=;
 b=RUiX2tJ0n8DAtfd9BTQbik0FN8JJDaGUaXlX7LwL2ijZS3wFthbPTDXvY3CaseBgOs
 mpzF0TFf8LP3IUVIq8lE0eED8VrNoeurpEWJxEfeMG7F9aTWTnGGe+8AUVGzGrvNOPYk
 r7aDnYcXmjzsZ8/BoJohrS68jpn16Svm6GKnPrbCELodG7Oib9lAKrpNgEB9gPlLgyTt
 iUZdZf1fhvjFAAFjtVgfPy3ReoMyqm9mNgQ5XXzXat3sYbxu7Orh48qhjX+9P8wmGQaf
 W1nfVCJC+H3KjPd14KEkzSnPuO1V91wJuUBF8O/CcqMFh3cOhT1A0PL7SeX7Eyi9qLvz
 uiMA==
X-Gm-Message-State: AOJu0Yw9x19+fB1P84Uys499BohB0aeebm6w6ZZjedNJQms4gsZzVtSM
 6LNlNHpwYxQrtOg//gjUmmDZEWHEwelQYBrAWrRO0GxKoXay1rvRGbxSYf2hQwwEpaBmnRJE00S
 wj9LyUNC3XCDqohWOqVgn40LoVhpiQUAbsTPS
X-Google-Smtp-Source: AGHT+IGkp4eUbFwBtdSypdEg26xc1KYtyCWOq+b8+a1PJKw4wuDyDvE7Dlu423e/DG9YFId5FphpH5SfiUJFXc3eYX0=
X-Received: by 2002:a05:6214:44a1:b0:6cb:9b65:5c75 with SMTP id
 6a1803df08f44-6cde15d2f09mr83698376d6.32.1729338670504; Sat, 19 Oct 2024
 04:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241018155557.2184819-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241018155557.2184819-1-andriy.shevchenko@linux.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 19 Oct 2024 05:51:00 -0600
Message-ID: <CAFLszTgmcg+EdhDjiuSgtYR1kwgsTwEBvhC+LZNqB9ypx8ev7w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] x86: cpu: Describe board final hooks in the header
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
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

On Fri, 18 Oct 2024 at 09:56, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The new two declarations board_final_init() and board_final_cleanup()
> need a description. Add it here.
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/include/asm/cpu.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index d71bc1b80c05..a5b2043f7de1 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -298,7 +298,20 @@ u32 cpu_get_stepping(void);
>   */
>  int cpu_phys_address_size(void);
>
> +/**
> + * board_final_init() - Final initialization hook (optional)
> + *
> + * Implements a custom initialization for boards that need to do it
> + * before the system is ready.
> + */
>  void board_final_init(void);
> +
> +/**
> + * board_final_cleanup() - Final cleanup hook (optional)
> + *
> + * Implements a custom cleanup for boards that need to do it before
> + * booting the OS.
> + */
>  void board_final_cleanup(void);
>
>  #ifndef CONFIG_EFI_STUB
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>
