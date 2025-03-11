Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C4AC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 12:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1005E801FB;
	Tue, 11 Mar 2025 13:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b8sCMDVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E2F78083E; Tue, 11 Mar 2025 13:45:36 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA61F801BE
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 13:45:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e60f212fee7so4137123276.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741697133; x=1742301933; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HOiuyGfrmJDzqmQ14k6WXkGIwbDj0u1oadO+IiMZfE8=;
 b=b8sCMDVs33PRZ0jnSO6JXhxB5lHrrluyaroMbKzGi7mlc2i3PUgX7PYuJmIA+Wja+x
 8mM/s+SHdg+KJGSv2qEYcVDuimGZGb7+7Mk1XNrXI4NyPN8jFCoN9ZTq8kKFUv8pIzcF
 QFnHIDCfmF8KkFKkiE7BRUiqorKQ07Fa0jNMtYYTd0uwVShYo9Tl7Iy/Pww/7sIJr23V
 OjtutXZsXY0NGGm0W4oUy5UMYhzADz6KO0lcLYX1nrqED9ei0slUMUc0Tgy8fTQHMqb6
 GJkknQBPoUtmKO7UiKi06KG8AlqGpRVtmTcLRNY/zozMJzJfvLSvhN7+f7Z1jDzQ+9dX
 8A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697133; x=1742301933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HOiuyGfrmJDzqmQ14k6WXkGIwbDj0u1oadO+IiMZfE8=;
 b=D3UKcghQAhvTLT7fMN9i/qg9lZFrvUNhWU+LI2ASAdUn4PNA5ogi/gunSy5sy+NfT7
 RHL17xzZax14ZM2n4DOPBMysMiLnxtBPs9IvErGbXtCMMDQaYyHN/j6lkGBSMXg3eB93
 nsioPMc4drv/EXX33O05ClDOuwy68WcLHbVg0xdmbbakpP0mWS0Pl/M6d7UcO0q+1gfi
 sLRPuLafDoXzIS/D+eoITeRTc0IyT/j7OGw8nbyYhF6NKu4Wy3zX2rxS2vieXimISTeo
 C8tDPzWjjGlr8p88r8OBIITVoIlqR707Zev9QM6KDaIGPhh4bmd7521NHZNutHPCQ8Jf
 5QKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXph6kDuxWj/pLOhNeFPohayZnOkOLlPTnimwMzcUhXXfF/DNiKls3vsDYqLgnEmbcdCuP1mNU=@lists.denx.de
X-Gm-Message-State: AOJu0YxXdm1hYJ4MGaBCblvBzJc3+i4eo8zdJBkpUbtxInVDrPcTPx7M
 YZ1N3h9H0o8xTL8a7RmmgG5ITyBeysER5g8cyok3VfoRhOJajjlsWYzqXz9rf1R2bSO5Rv8vMDg
 dDW/baNMNsas5PU7yYZg+aAu1bdqKzj8iq6kM5w==
X-Gm-Gg: ASbGncucNoMrG7w2EnvEEilcewZAmcq1NeWlwi8wog8UJI9G59L6BF9JMCaaN8XMOFJ
 mkcNcKBJ7IpidQIHsJMoNsoockSOeJdgiujxWnQpT7I32KuLzaojXH4zU72uvwhp5cQY7vlrqTh
 cB5EqLZMCRQO1G7kuTgbZrTO1EdXk=
X-Google-Smtp-Source: AGHT+IHkyv/WSjZxFe2e4w2qlqdgkXAakosLfGUodV5+1H6XkgyZJB9nAFqWUKwqtrHD6I3vjDEMe8uX7NgRjSJd9x8=
X-Received: by 2002:a05:6902:2a8b:b0:e5d:c6e8:2e32 with SMTP id
 3f1490d57ef6-e635c179f67mr17470214276.24.1741697132645; Tue, 11 Mar 2025
 05:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
 <20250302142121.150480-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250302142121.150480-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Mar 2025 14:44:56 +0200
X-Gm-Features: AQ5f1JrtdvgovuaEcXe9oEAdBGhZohcje3dyNzI-ZwdPnlIptUFPrD4BOTurOj0
Message-ID: <CAC_iWjKzoN1_qN=WAtR3rm4KoS9ny72xG_XE0XBk513QLWL+eg@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm: include asm-generic/int-ll64.h in setjmp.h
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Janne Grunau <j@jannau.net>, Yao Zi <ziyao@disroot.org>, u-boot@lists.denx.de
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

On Sun, 2 Mar 2025 at 16:22, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Don't assume that u32 and u64 are already defined.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/arm/include/asm/setjmp.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/include/asm/setjmp.h b/arch/arm/include/asm/setjmp.h
> index 662bec86321..9a7f5af9f8f 100644
> --- a/arch/arm/include/asm/setjmp.h
> +++ b/arch/arm/include/asm/setjmp.h
> @@ -7,6 +7,8 @@
>  #ifndef _SETJMP_H_
>  #define _SETJMP_H_     1
>
> +#include <asm-generic/int-ll64.h>
> +
>  /*
>   * This really should be opaque, but the EFI implementation wrongly
>   * assumes that a 'struct jmp_buf_data' is defined.
> --
> 2.48.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
