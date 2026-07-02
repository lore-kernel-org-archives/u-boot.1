Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34B3C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FCD383FEE;
	Thu,  2 Jul 2026 12:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZArjS1s+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92A56847C3; Thu,  2 Jul 2026 12:25:11 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F87A80398
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-697763eeafcso2725243a12.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:25:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782987906; cv=none;
 d=google.com; s=arc-20260327;
 b=LLYvKvrOSGK7DaGlJi9Fv3ToQJVL2Zfl//8ADvQUgEyDxJBOXAKU4dNrFwPAbvJrg8
 Hyzxmgstq3+0D5IUCqaVdbR56BHvu6v/ssjIAnAMfe3h88xoESqpemfu8gTQD4pKgIkW
 N8rWgKn53WITs6h1MrQyICOyCILKUuA6IE4zXgCR4Oxno13TVdeMU4CtERuE+Cxbqbn7
 yZm7zDIk8IZOCa4rIn0mP52N/s6Roh/ppG0YSWE49UCFu77RxtxKyQMYhVxdaNA5F2RL
 SkR7RGGwaKyjBEAnqO3gnFcc+pjzirZmcwcTpR7NnzsjIyg1E1p6YVcnk6TRjbKp3roN
 ZyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q/E6KWYj4vRnuQGuP079tGWAATZ16pf6AZwh9r1AdcI=;
 fh=cN3TE29YQ0/F2+YOokb06UaWuBsAd+9btxPUPe+29Jw=;
 b=k2IAPTXIYOMcdk+Q3GdMZx5WMi/XNo75JLe+jMMu4+5Wxi+yVsbe3qMt/VSp9DYMFa
 EW/3d93HMElu2T9fhK+MatWIEMqqxCkyY346OoJWE64WWmptcIXcaGcoe72Qp6/xjsqD
 DdW1VTLPNjecm8pwbwRbj2C5saYho+tBrVu9/PI1UMdVsFryOGQuqCpXxU+ZC0QzUYbH
 OEaAvPsyHxxewY9NsLYZLOrhS7ePVc3Syatx6QTUMzbn9L9yXcQkSBBKtVmTbif5qw7k
 axasbI5RgfJiNyTYe8spLMcHFJfrloq3gyc9K5vhC/ZP1YepoarPsbqOqNY3308WT92I
 zOGQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782987906; x=1783592706; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/E6KWYj4vRnuQGuP079tGWAATZ16pf6AZwh9r1AdcI=;
 b=ZArjS1s+MqMRc4UbwBo3aTvEDCOgYnBOt4nqWsUK4zpdY6DE8slCDGx3Ykx7eqzBSB
 9MY62XCILMjIdTjfw+vPl2TaK53x0UeccwxAsBdRCkBnjK/JmEqzdwx/OkBtvyVKr2bW
 CjzyIVqg/2dZaZDSgm8e1pTBn7cfL5Af6o7z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782987906; x=1783592706;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/E6KWYj4vRnuQGuP079tGWAATZ16pf6AZwh9r1AdcI=;
 b=Yi6+mrisppCuFBxN9Zwt7D0baI6Ej2gKcWYzG4MT/s2wBf9pe0bo6tfsI6hhNtp/sk
 tcbUokM3Ni/i/8E1ADMSXCvBqTUpjDC6Pwshz0T7fQsbvTsodsOK0qRF+SCbgvZmOb3Y
 3Sz5fo6eWJAJSIAgJwr8Y13w39iMlhivbqBU/xqxf/RY2p4ja8D4BWP+ncZpA5rEU7OI
 oRiHQ6B/rUUDDTfvpwiDZCGys/qEUGZn/TtSfcPgo3ELdGPJ6e++ZsQDkLrT21i0tR52
 YGmHQUYM/eNvlToXi+YENBkGfoPzmYgF+8tOZYztkCh0tW5x5aQ5q+mjoqDTD3L/PJAO
 4h8g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/NXtFVvpXNcjzdCu998WPB8OWMrHN+B3pPfWJsxP+VvzmuPU8ku4lDK4dKo1MvoptHPfZI/8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz34+qlZjgFIq4/0mZUhIad7WzUkqCzL191wzIC/dCZsgFcd2MB
 qIX3TEUUOwyhRghguss3AV2Hz7tgKnE7i2n1WYDvl3FuQbUbQC1XGXs5fS1P4I/xNT5x3K0wugp
 h0UKUNRmdjHQe8TsKVEBsBQJIPXP/clHxZHhjm/4gye9Cjmd2zey1XGgraRE=
X-Gm-Gg: AfdE7cngXEqZroZgUFOJ5TIaXm+SIezi4VqW3iEvwCV75bi1e9sP+n4kzOOY/gbAxyc
 BS8fJrWdd9JlAFVX2E2elDdbcVnEaX9pUcITD7QJTBxikupcGkriB86aJkLAfV5N8/kRywF+tWH
 Uk74dWxABgwguidK6G3IqERL3OZLHfjQHAsJ2+Pc3QHIanEncJiL3/yqzoywTnjw8egU+EFINKK
 1DEgjy8mG/MUhICUNG0C27RJz/5N1RcTdgcCFQw0W18/cQYOjkeHxUFOxmG4HTlc/kbeQ9orA==
X-Received: by 2002:a05:6402:1143:b0:695:572a:7abb with SMTP id
 4fb4d7f45d1cf-698a2cd163dmr1507999a12.22.1782987906635; Thu, 02 Jul 2026
 03:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-5-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-5-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:24:53 +0100
X-Gm-Features: AVVi8Cedc3Y9zgmm8amNGuNTE4UNsiHmpxaw_qhv5CHQ-3sLDJV-kNSaVPK3K5E
Message-ID: <CAFLszThFEdHOZf6O=X7r8x9ZDCqNAuSuB5GEHX4a6NdLYgiF9w@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] elf: Define LoongArch bits
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Yao,

On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> elf: Define LoongArch bits
>
> They all come from glibc's elf.h
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> include/elf.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/include/elf.h b/include/elf.h
> @@ -225,7 +225,8 @@ typedef struct {
> -#define EM_NUM               92              /* number of machine types */
> +#define EM_LOONGARCH 258     /* LoongArch */
> +
>
>  /* Version */

Two blank lines are left between the new define and the /* Version */
comment. Please drop one.

Regards,
Simon
