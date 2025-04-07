Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B83C3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 10:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0844E82E22;
	Mon,  7 Apr 2025 12:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H1hMPg1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B699182CF4; Mon,  7 Apr 2025 12:49:35 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EAE482CE7
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e5c7d6b96fso7569858a12.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 03:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744022973; x=1744627773; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Ej962ipw6wfeq7wwhHxTaga8I38XbEUdpAEB9OZkJE=;
 b=H1hMPg1lGU8nvvBhLVGuvzaKx/JXQ6FT/t1WwwkBOuIAyTUMEkevtVTCxS+t+rZNGc
 ySI6c907Qd2+uIRFEvDEq6sR2UaNMLIigPhwIrreG4Mwan6mXPKmS7HaIcspBoyK9qOV
 bdFS72EVOBzf7/nJk477uh/DQuYuJiYc78iBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744022973; x=1744627773;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Ej962ipw6wfeq7wwhHxTaga8I38XbEUdpAEB9OZkJE=;
 b=dfk+uCEiiuyKPomgLhtZ1n/Drnog1XYbbYKkhkjelmTrH4MLaCxd4+K2b+egEkVIu7
 jVxyA281cCfOB09u++LFPLeIf9qfeZIj23+xObxFv7tFXsG5b4HLheCiIAS5CtuxURr5
 +Y5+fa3h8JKXg27wyGBYnkIRRuZFmffZzS0+1kAzyUS7YlxZJomq4htKnDn1TJqmle7W
 LucpkKcdY/j/nSbmLiXTJXqLI2Wlu1R6eYanu/8eX6FJCAxmf64n0FexDIiNbfEhmOll
 wsFehINvJb2LI2pRd/ogzudaoQWg4DEn/IkHsa/70TtsO8yQKyrOgohtvPv4CsXpmyMG
 jVXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0JSpqmBc+qwCMvgUBuzDpWzm4GYEpzvkV6BNhWRSHd/73cLB2xdT2m3J88vpX2c8PGnqU2G4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8/ViaF3R/dok920yJK64Yzv04sRR8D1+MGMS5D0KcF5tZqyZ3
 41Nm/088M1hKSYLtdHtG9+2f5vSNTOTYcZBcY1jHlIhvZZXXJF0hqTMR69VaV0zK6+IWxhYkavK
 RhEh1A1QPfIPoHFLMblON0pGaNGOD2oPBxZAwZdZAODEte2hDmQ==
X-Gm-Gg: ASbGncuino+UOb75ZLXCwgMi/q3j6m2/d/umfnG8QMVfiwtCSVsmeFsHg+AAnhCphHc
 7gMBDsb0Srp1MPzeiSWyyTh6ONbQV4dM7ROpRznMMAI61dfNpSzFxcBi/vd06L4UvIhxkf+d9tD
 Mw0wuLSF4jQJJkuG3qbcZ/dt57Fo4=
X-Google-Smtp-Source: AGHT+IFDh0UhSUvnD4cLDuABqnX7x59cXmbolE/3ztoW6o7RngxgHqm6/c0AAJxwS1y19P8R5Jc6KUnWb4EC2d2vjaU=
X-Received: by 2002:a17:907:97c1:b0:ac7:95c3:eb12 with SMTP id
 a640c23a62f3a-ac7d6d05ffamr1210741166b.16.1744022972701; Mon, 07 Apr 2025
 03:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250407-fdt-chosen-v1-1-3dda83c48c07@gmail.com>
In-Reply-To: <20250407-fdt-chosen-v1-1-3dda83c48c07@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 22:49:14 +1200
X-Gm-Features: ATxdqUGHQNY7bmbCYdo9Dr98YFRETiBihbq3NvyESsaNMZpPqJX7yEnB6uToy90
Message-ID: <CAFLszThxmoDw=MF3OXLL_Of4r_P8YMcjcN7Qf6D24zC7db6x2Q@mail.gmail.com>
Subject: Re: [PATCH RFC] fdt.c: fdt chosen cmd had off-by-one issue
To: gchan9527@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Mon, 7 Apr 2025 at 18:44, George Chan via B4 Relay
<devnull+gchan9527.gmail.com@kernel.org> wrote:
>
> From: George Chan <gchan9527@gmail.com>
>
> The kernel searching bootconfig will be off-by-1 and never match
> thus always not found in this case.
>
> Signed-off-by: George Chan <gchan9527@gmail.com>
> ---
> The searching will shift-by-1 and never match the bootconfig thus
> always not found bootconfig this case.
>
> Kernel:
>             data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
>             for (i = 0; i < 4; i++) {
>                     if (!memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
>                             goto found;
>                     data--;
>             }
> u-boot:
>             initrd_end = initrd_start + hextoul(argv[3], NULL) - 1;
>
> That would be off-by-one apprently and matching fail for bootconfig.
> Both u-boot and kernel worth a fix.
>
> An out-of-tree patch for kernel to relax the searching is available
> but not ready for submit.
> https://github.com/99degree/linux/commit/9d9ea454fe857a9f550d7e60957253e176e8e123
> ---
>  cmd/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/fdt.c b/cmd/fdt.c
> index d16b141ce32..13ffe929f8b 100644
> --- a/cmd/fdt.c
> +++ b/cmd/fdt.c
> @@ -705,7 +705,7 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>
>                 if (argc == 4) {
>                         initrd_start = hextoul(argv[2], NULL);
> -                       initrd_end = initrd_start + hextoul(argv[3], NULL) - 1;
> +                       initrd_end = initrd_start + hextoul(argv[3], NULL);
>                 }
>
>                 fdt_chosen(working_fdt);
>
> ---
> base-commit: 848f7ffc64aa7c4cc2229095812625c12343c8c1
> change-id: 20250407-fdt-chosen-c87045f2e1e9
>
> Best regards,
> --
> George Chan <gchan9527@gmail.com>
>
>

Reviewed-by: Simon Glass <sjg@chromium.org>
