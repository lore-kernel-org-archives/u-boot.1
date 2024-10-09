Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB87CF042B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEDCD890FA;
	Wed,  9 Oct 2024 03:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FfgryG1H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A611890FA; Wed,  9 Oct 2024 03:56:04 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 589D58910C
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7d4f85766f0so5059059a12.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438960; x=1729043760; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUd8vrfUFAIA0+BTlR+t0VVcSxev9iPXUgETG0dWCy8=;
 b=FfgryG1Hr5FnHYDodpY4NkgA9PrT2ULV4Ni9lihWUj9Mk4/KF4Cyq1FEUQyE7StQmj
 OaqWRKE8MlnB9S+NG27EL1A230nVsJKlHIWRZ/U2dmvq3tcxpVb5udottZITpSOrPLNE
 EPQxxpZgmxBLTYZL8R/o8j5ldIOr7FL+QyaP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438960; x=1729043760;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HUd8vrfUFAIA0+BTlR+t0VVcSxev9iPXUgETG0dWCy8=;
 b=TSQq4XmdL++WehTTg/gOUMH3CxD4R4i1UTpn5oA14rr29BkDm8H85f8D72aJHjv2qP
 clyijt46c8AIHZ1v2ddTi+bk6+OFFpm5jAWC/XYHIWwuJPnuH5n1M/XZeBo/9PeMzb64
 GIeLDw27gVLUhGrnOqak31BaxLnE017E1hly5S8qwND36KdomBIn+027NF7bsdBCXKVN
 ONfMeeTprEEnVq9/lirt5+FxDxcFh5F2Tzg+iMTmhYSM/5i4wHmIZFjkuogwBQy2lOnx
 4fVAstmg1BKYaIkHDH8W8vFeymeuuIyCegtfm3bVFIiJHfRB7ssx7x6zDuWJ0+vUTGDx
 noxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUChsSOMJTr4flfxn+olzPViYT2eRoPNUbH3EU4x3ibvhO44ZZEr9xrMwLHeepbIkfi6JOPeZY=@lists.denx.de
X-Gm-Message-State: AOJu0YxstZGY8TXraKt8KICKSAbwUmYez603ljnZtL1fYmE6YmFQWqkk
 QpDZRGDHpOdYy0zEHT+QIw4PRqQqWQTH9FsDIN4TAo1C6392b8p/OKhrAQeQ1L1waIl+ABHx+oR
 MWsooRZb+KopyPqKsZ/pi2PGSH8MbuU4J2Xdas08+h9B+AApZJg==
X-Google-Smtp-Source: AGHT+IHWXUiE7EWrxXNnNtnzkY24XwiC/GYtb4l/zGKNpucGzsxzPfxpvuLFp6tpNlf4nRfWGa5UI8Oq6q61SJ15E0U=
X-Received: by 2002:a05:6300:4041:b0:1d6:5054:a02 with SMTP id
 adf61e73a8af0-1d8a3bc5092mr1497479637.2.1728438959983; Tue, 08 Oct 2024
 18:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
 <20241005191353.1927660-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241005191353.1927660-4-andriy.shevchenko@linux.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:55:33 -0600
Message-ID: <CAFLszTjff52keqouqR3WK=cM=PX+EiTJQqz+YWBbDe3dSTYY8g@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] x86: cpu: Add a few prototypes to the header file
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>
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

On Sat, 5 Oct 2024 at 13:14, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The compiler is not happy to have no prototypes for the functions that
> are not defined static. Add them. This helps avoiding the compiler warnin=
gs:
>
>   arch/x86/cpu/cpu.c:197:13: warning: no previous prototype for =E2=80=98=
board_final_init=E2=80=99 [-Wmissing-prototypes]
>   arch/x86/cpu/cpu.c:205:13: warning: no previous prototype for =E2=80=98=
board_final_cleanup=E2=80=99 [-Wmissing-prototypes]
>   arch/x86/cpu/cpu.c:307:5: warning: no previous prototype for =E2=80=98r=
eserve_arch=E2=80=99 [-Wmissing-prototypes]
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/include/asm/cpu.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

OK, but could you add proper comments for these?


> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index 073f80b07f10..d71bc1b80c05 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -298,4 +298,11 @@ u32 cpu_get_stepping(void);
>   */
>  int cpu_phys_address_size(void);
>
> +void board_final_init(void);
> +void board_final_cleanup(void);
> +
> +#ifndef CONFIG_EFI_STUB
> +int reserve_arch(void);
> +#endif
> +
>  #endif
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>
