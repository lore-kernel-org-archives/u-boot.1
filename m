Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA3DC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 744FB874DE;
	Thu, 16 Nov 2023 17:04:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VMvq5sWE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF244874DC; Thu, 16 Nov 2023 17:04:55 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702168744B
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9e5dd91b0acso140052766b.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700150680; x=1700755480; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HYcoaSFWm/0+KZRKZmN/JE4BqTtY11eoth+6C0eFH+s=;
 b=VMvq5sWEOqlAnkjjwLLlYz2DQpnv6riNtT4jvPbhL3dsTmhrllSpBnwX+OH46HPfJV
 J5nDj1hpSjK5EZOi+OVm5mN3/AtSFfKDUWUbmZhaiUcnlgPBK7ab1+nJIJXZAFzMXxQF
 ztLWBKH152nQ4HafhZn9zR5zmv0IxUeE+cVW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700150680; x=1700755480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HYcoaSFWm/0+KZRKZmN/JE4BqTtY11eoth+6C0eFH+s=;
 b=eCDx75IEDhfheka8a1JiHmGPwOuWS50vanY3wgFqetYeC4GqinW+luA7SzZMCOXqDT
 KqsQ1WHNBduFc1nCw+Vn3ZxarH78FK0CoS9ytpXtIl8WzNKUrQNK77N3Ce30NrSqT+gm
 sg4FEEEiyUl6Py76UBH0uUFgV4FCuKaPs4sRzxtaY/QO96qvtp98L8BANuGbtI+B0F8t
 5Cio8hMH3asA1hbVn7WyVU5uVoR9QtaXAB4jW4P/LAJJ1vT0cBgKI7o7Y+PXelUtD6ZT
 T7wRFukSU9EXCYD+3N/NdtwdknOuT/g7tDO+/38dwV2kJZ9HgKr5GS3iv73fq9E6s3KG
 AZeA==
X-Gm-Message-State: AOJu0YwDlrpsvQvZteoHTllsDHG3ga8nzc3Yr5joAf8As/BA4tTo/LQE
 a/5zdyb76zr5P7UjoUyYQN4KXVhlzKmwATxYXKV0EA==
X-Google-Smtp-Source: AGHT+IGG1SrKpPKMnaUbPkbHVumaGgT4/be+HRbpdVfnvva85SJl+fFh0keDxmrJPIfoHd30tZBWCPSr8i9VIOSmls8=
X-Received: by 2002:a17:906:dfc6:b0:9ae:5270:46d5 with SMTP id
 jt6-20020a170906dfc600b009ae527046d5mr11362328ejc.73.1700150679735; Thu, 16
 Nov 2023 08:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20231116101750.2624046-1-randolph@andestech.com>
In-Reply-To: <20231116101750.2624046-1-randolph@andestech.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 16 Nov 2023 09:04:28 -0700
Message-ID: <CAPnjgZ0rLHvBn0+TDjYNoL5giqRVAYCPAmBPV4A6YGYkktT0ew@mail.gmail.com>
Subject: Re: [PATCH V2] riscv: binman: fix the load field format
To: Randolph <randolph@andestech.com>
Cc: u-boot@lists.denx.de, randolph.sklin@gmail.com, dylan@andestech.com, 
 tim609@andestech.com
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

On Thu, 16 Nov 2023 at 03:18, Randolph <randolph@andestech.com> wrote:
>
> Using /bits/64 prefix for 64bits address
>
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  arch/riscv/dts/binman.dtsi | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

It is normally written '/bits/ 64' i.e. with a space.


> diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
> index 6b4eb8dc7b..777b1309d0 100644
> --- a/arch/riscv/dts/binman.dtsi
> +++ b/arch/riscv/dts/binman.dtsi
> @@ -5,9 +5,6 @@
>
>  #include <config.h>
>
> -#define U64_TO_U32_H(addr)             (((addr) >> 32) & 0xffffffff)
> -#define U64_TO_U32_L(addr)             ((addr) & 0xffffffff)
> -
>  / {
>         binman: binman {
>                 multiple-images;
> @@ -36,8 +33,7 @@
>                                         os = "U-Boot";
>                                         arch = "riscv";
>                                         compression = "none";
> -                                       load = <U64_TO_U32_H(CONFIG_TEXT_BASE)
> -                                               U64_TO_U32_L(CONFIG_TEXT_BASE)>;
> +                                       load = /bits/64 <CONFIG_TEXT_BASE>;
>
>                                         uboot_blob: blob-ext {
>                                                 filename = "u-boot-nodtb.bin";
> @@ -50,7 +46,7 @@
>                                         os = "Linux";
>                                         arch = "riscv";
>                                         compression = "none";
> -                                       load = <CONFIG_TEXT_BASE>;
> +                                       load = /bits/64 <CONFIG_TEXT_BASE>;
>
>                                         linux_blob: blob-ext {
>                                                 filename = "Image";
> @@ -64,10 +60,8 @@
>                                         os = "opensbi";
>                                         arch = "riscv";
>                                         compression = "none";
> -                                       load = <U64_TO_U32_H(CONFIG_SPL_OPENSBI_LOAD_ADDR)
> -                                               U64_TO_U32_L(CONFIG_SPL_OPENSBI_LOAD_ADDR)>;
> -                                       entry = <U64_TO_U32_H(CONFIG_SPL_OPENSBI_LOAD_ADDR)
> -                                               U64_TO_U32_L(CONFIG_SPL_OPENSBI_LOAD_ADDR)>;
> +                                       load = /bits/64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
> +                                       entry = /bits/64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
>
>                                         opensbi_blob: opensbi {
>                                                 filename = "fw_dynamic.bin";
> --
> 2.34.1
>
