Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CB5C52D6F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 06:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42D6888618;
	Tue, 27 Aug 2024 08:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fD1DafZy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4FCC88915; Tue, 27 Aug 2024 08:27:43 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9095387CF8
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 08:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7141b04e7b5so3122495b3a.2
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 23:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724740060; x=1725344860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xRH9FT2eWlhloasZZkgXgGZReo/OyYASz6Da54RfDr8=;
 b=fD1DafZyhvLdOGnxDlo4jHPXrW7WMpqmkhSV3IEOlF5Aa8NFRbAno11ete8/D813l2
 nG4SAUD1pMJXLtdbZBLpgMdPhc4HT5UaVj+7VYVqiu16gSUxKmpGCMIgwT9VxonTfdtg
 oRu2EKguRH1bCqVzaIDI2tDltLJf+ZrerVEChkav8NRro/enMj2lgNxVOSN4kGEl6Fhv
 0odQXPHTRZ9NLQxHPSK3DKvhwCA7X0vxCHLxsYAY9hEJ9xK7adr6KytRQxUToBnFGAnU
 AqvUao3md6bVm+4PSmAi1NEU/p1cPjuf9ziT4k8tw0q70akCdV6GT3cqqd5CZ4nUq1qx
 Zfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724740060; x=1725344860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xRH9FT2eWlhloasZZkgXgGZReo/OyYASz6Da54RfDr8=;
 b=W9iJQh2/Mm1chjfs367uAgzNZ2yB35zOZ+OH5yYOzOp8uazSM7gHkI1xY2BiS+Uiva
 veu4foQdHMHVdHMsgzeAgmbMl1eqhAc1S7x+w7KVTHfZnfdYrU7fZ7XuCXQ0CDE4PS0e
 FThLfG78ureMMewycv8EC17/eAse6PxZE0R73oljXZWKEXtw4toX+DtARMFA65yITlDd
 5U/OakCSTQ6oaI+G9xYPijx6OS+mMwdEA/CWDyR7K/MCzE9x6cWz6MUWTyHwjs38Kzgc
 I50s6Xp/XiXTtZJ9NghswC9MfM6+N4UDKMAkmZjGAshb2btXrEHUkRAccCuj0RXSltyW
 +zxw==
X-Gm-Message-State: AOJu0Yw1tNCEU8KYaP/AIflv0CwMiP0eibhmiQC6XsdBivmcB9G5V8M8
 TbusKn3ZCy7luJYJeTIBBsVxvFFF5JoPCHZUo3JNrp9Aovc9pruu17Nl7fNCltbbq/ksb2vpuH/
 /ZPNyBdThR5ct0PajYj/azrb1hXeSlUolRNEmDA==
X-Google-Smtp-Source: AGHT+IE/mk2BHYbmhV5dk+WEEZtb82yP2qEizr+Qc18q9gBkyYC03RHtw0u0VH4nfWbmmkzDx7nAPFcMmUrcGKhP3z0=
X-Received: by 2002:a05:6a21:4a4b:b0:1be:c2f7:275 with SMTP id
 adf61e73a8af0-1cc8a0810e2mr12039194637.50.1724740059896; Mon, 26 Aug 2024
 23:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
 <20240826115940.3233167-15-sughosh.ganu@linaro.org>
In-Reply-To: <20240826115940.3233167-15-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 Aug 2024 09:27:03 +0300
Message-ID: <CAC_iWj+8RuPyb0AzF7Sh6HPgS32WxfO=MD3TGYqTgBXpEEB+Eg@mail.gmail.com>
Subject: Re: [PATCH v4 14/27] lmb: bootm: remove superfluous lmb stub functions
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
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

On Mon, 26 Aug 2024 at 15:01, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Remove a couple of superfluous LMB stub functions, and instead put a
> check for calling the lmb_reserve() function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes since V3: None
>
>  boot/bootm.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index ddede08979..a61bbcfb45 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -239,11 +239,6 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
>         return 0;
>  }
>
> -#if !CONFIG_IS_ENABLED(LMB)
> -#define lmb_reserve(base, size)
> -static inline void boot_start_lmb(void) { }
> -#endif
> -
>  static int bootm_start(void)
>  {
>         memset((void *)&images, 0, sizeof(images));
> @@ -700,7 +695,9 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
>                 images->os.end = relocated_addr + image_size;
>         }
>
> -       lmb_reserve(images->os.load, (load_end - images->os.load));
> +       if (CONFIG_IS_ENABLED(LMB))
> +               lmb_reserve(images->os.load, (load_end - images->os.load));
> +
>         return 0;
>  }
>
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
