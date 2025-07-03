Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44B4C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 13:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1524E80E9A;
	Thu,  3 Jul 2025 15:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UCbaMlru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7616F82063; Thu,  3 Jul 2025 15:23:06 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4186C8091A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 15:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-714066c7bbbso91005357b3.3
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 06:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751548983; x=1752153783; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=07bLDUYM9y4Cqt8lFqFg7DLzhArxIBfddkPObA+3IaA=;
 b=UCbaMlruzhRPv6xqQUReCiGLWwfzZLMDIuW5Zb852hhopFlSyvvJAOGS6N7ONmhEWk
 h1xE95AnSTCJ8r10uFk0KYMnX/CyZ3RyER0XHcu9k8pL7OiOOjBGUPivAH866L4rgnfm
 4ZegJnRFvUs5I+bvI4+p9gcEH0roiWzbXImhxlNmWp3qTFnQYAzXZ1GZc1egD4C1tJoy
 AuOHd974WonBPiMeUKpyMjjzWyf04IiO4Hf9vLso+k7R79YYla2kUDFZVTIzhQ6wn/my
 IgwxxUsJhZie8MiEuZrBwMRJN0vEi1WYd3UJG/mNm4l1SeB7T3jw5x6lzBkNGh7xBRUr
 RRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751548983; x=1752153783;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=07bLDUYM9y4Cqt8lFqFg7DLzhArxIBfddkPObA+3IaA=;
 b=m4dCFiHpRn7ku3YOeItFuoM3SmMLQlA2XQkbcWG28Zk8oIUbl2Xg8CmtBG+ILX2sAO
 OY5UavrOVJ5O1hMwubaeuSn61qIPWzfSvg9HDYNw9gQ7oY8ENGgeLEx2XRSFydAdNKwU
 OznJo8g1p1I2aMOn37lz7suW4+TEpBGxbImy6gFAFVrx4UjjiDzg/QTeAuqgCNGyAc9Y
 aDn09sq0uBHJoZeeSvqsdbKr0CG4ZCzNjXZ8a08eTwmA09j+KOxJba+CV/Jt1mz84PxX
 xufp90NECDxzpEj/zaFjW4BsMciwkYVa8k8PpnOAwU+BjWE2rJIwvSp4lbe6aub8uK6n
 bxiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPo2kA3Lj9pGni8KlfPjw8Gq7BToQDUeJ2rx/S4FGhtUjQFS0AMeNJPAIxGdmg6/ukd8HCXM8=@lists.denx.de
X-Gm-Message-State: AOJu0YwS25yJhIzS5/vLJi3bghGlCBB70gExRQQvIcViN7R2J5MWlFf2
 DQbtZ/yid80fjhbnz4R0cWhQdHHLj3Wqj1pa79OwF4bMhDpDuh8BGwgNMOnHmbeK07GH7HmyTIi
 E8YdMwTKwB0/1+LNsSTRmmKJznKRYXqqiDV/PwP8igw==
X-Gm-Gg: ASbGncs2rV4oNx2+DusmixSJQ2Rr1H7nYqR+QsLGLNxEw4SAqSnp6gCj2raQ5vLKrCo
 zeXOcPe7XQCMG3RudXI9pbeuFEWnAFrzFEsHbnhSAKQxgLTfr4LlHhG8eUo61qWKgEX7oeb58fP
 fSYJclqVSEPFKo7KjGsGr8f6TCICRykJn/pDO3bLK5qOGF
X-Google-Smtp-Source: AGHT+IHp3IKMEA6VL9L1Tln1nxFp9pu0gCO+/bYMg5fntY6K+NuX7cRioYLAGLJlODFRZ8Q3Wiwioo6mNSwv2kpFliw=
X-Received: by 2002:a05:690c:6e04:b0:70e:7a67:b4b5 with SMTP id
 00721157ae682-716590aea79mr51498627b3.22.1751548983029; Thu, 03 Jul 2025
 06:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
 <20250703051951.43372-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250703051951.43372-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Jul 2025 16:22:25 +0300
X-Gm-Features: Ac12FXzZumzFEzfB4MDKRYV1jaWj4988RMl3mcJTD-aeBSZNdQiKYhL6ILR3Yck
Message-ID: <CAC_iWjKobrJsF6yndiexeYBfgoaQLmjiOAc+zPx1qrXzUHarzQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: initialize the frame pointer register
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
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

On Thu, 3 Jul 2025 at 08:20, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> U-Boot may be compiled with frame pointers depending on defaults built into
> compilers are via explicitly passing -fno-omit-frame-pointer.
>
> To stop walking frames it is necessary that the initial value of the frame
> pointer register is 0.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/lib/crt0_64.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
> index f3f279f2c39..3ff0577e9c8 100644
> --- a/arch/arm/lib/crt0_64.S
> +++ b/arch/arm/lib/crt0_64.S
> @@ -168,6 +168,7 @@ clear_loop:
>         /* call board_init_r(gd_t *id, ulong dest_addr) */
>         mov     x0, x18                         /* gd_t */
>         ldr     x1, [x18, #GD_RELOCADDR]        /* dest_addr */
> +       mov     x29, 0                          /* frame pointer */
>         b       board_init_r                    /* PC relative jump */
>
>         /* NOTREACHED - board_init_r() does not return */
> --
> 2.48.1
>
