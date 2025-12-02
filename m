Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E03D116F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 12:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F97B83E3A;
	Tue,  2 Dec 2025 13:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z6HWeE9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CFBB83CAA; Tue,  2 Dec 2025 13:40:17 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 431FB83CAA
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 13:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-786635a8ce4so39236867b3.2
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 04:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764679212; x=1765284012; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wWfkkJ3eb4q80k1wQ1VKG4Fx/4XaH6Kz6Zeud4JnR2Y=;
 b=z6HWeE9ruexGOM1j4nocupmp1a9y63pKvjh5tDlUFhaAf3naEmvTJZJhpwQkHwQSY6
 a/L6Ejyt7pXPbAiZidj6DscccaHiVveoQFQtoLtwwk0zH0+8VFsTIPDgDtX4W3231oK6
 V5DUU75lZZGgqL+mQ+ll4EKjvVS+o/7xVUoCozuG66jeAEIFU+vQiv64dsOyclUueoU7
 JKDRY1rFK4ynM+rKbaXsfcAAhi1otO77SgehzdBpN+N5KSA0QvtWWQBOL/edSfsDUOzG
 0CwBfdb3HH/A0RiEpuiGUBD50rimZTqbfeEJeisZiam8o3jxT1IljpDWPvcaRlnHq6io
 GqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764679212; x=1765284012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWfkkJ3eb4q80k1wQ1VKG4Fx/4XaH6Kz6Zeud4JnR2Y=;
 b=mZ7jMJpeiVMqrEXXOZ+hUYbJgxLVJPwMLoxyyVQCKZLZmn+5/w5F+K1ja6F/fKibKG
 T9pam+9g3XAviVmRQDud3+T9SqyKcBx1kmz5icztEXoZbcAgMHl0QuJoVBjtlN0J44P3
 YbstZgbLRHZV8do/OrWQW2S6JnAArnN9Cx8c0ZUfmkGDhAajX/kCAKa9NSMnKBzE290b
 CV3JwdWlSm4Gu2qSr5Q4kE9+K3bbc1JqGy2YPvU1TOVeHvY3fmIhezXZ5qnlZkTbL2W/
 ktNhSmTENz6N98B6VkXZMw5ev3BkIq6UqYDvPPFyZOuLfCpiR9vzMBYOhsh9zP+EMDMz
 8aZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzXk5OiAtSft5tpXjip4grmyV2IWFIXMFo0xveKOLEWTxsniRhaFLKIeVbdT1roWfuLkiG4K0=@lists.denx.de
X-Gm-Message-State: AOJu0YyzacmyhP37AUPR9QRsbIneoeZLJDPCJ4OGNzXdtxU9BBgEyhFJ
 6i9Dk/ptJVB/tuekQeCel0NLPux6t+kG5DSmAMunC8GMqUSGFcbbQuDRGN62zz0aDzMoNnKw0bz
 t96ues9SF2WoblTiwu74CEKLSeW4F/mcIX6LFzVnxFA==
X-Gm-Gg: ASbGncuRzYBxYw0GjvTFuH6iU+82aEaiAHH9Vva9hSoyWkRXGSzNtFWkNxmeu7HS5u+
 K7RKuVE7+eTynM0/dxXuCsxGWN8lZQ1WKEmuWR/Ofelcq4CLmL3PrNQKkKH1I39dotXTzr0EsUL
 XPNlVXmTB2tl2Q4BXId+9KYMhpIsisfkMK6IjBjhyXhr68TSTAst9qekwiG3wLWeOKlY/0/N4rN
 MsEQz/K4fI9iD69YF9Uwf5S4k9eX369UNye0EGL+34+/+4xZNbM1PFcFfhvAupJQ+fFkntNDGSd
 rv+UkARQVZpcjFDO/3Czj1wXXRTflRnyptvQz5vtWpVL2PCWaWpJoZPYBm7huTO5Kq/DWs0LALd
 yAHAVZj8=
X-Google-Smtp-Source: AGHT+IFpDUGZLRCrN6FCtmQQx27uzBV56+LKpd5e86FLMhS5O3kEAoYTdqGzjq3hBu4Ka1E+iIYOVY9suZfDxeXpqzg=
X-Received: by 2002:a05:690c:e3c8:b0:787:ffa6:6c4a with SMTP id
 00721157ae682-78a8b529d37mr355782847b3.44.1764679211971; Tue, 02 Dec 2025
 04:40:11 -0800 (PST)
MIME-Version: 1.0
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
 <20251123225711.227016-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251123225711.227016-5-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 2 Dec 2025 14:39:36 +0200
X-Gm-Features: AWmQ_bl3eN7WaQ3nVmuHI_kceTAQ_N7q8Pwl1NNLJKhcOq7EPRiKzTPsKXv_b7E
Message-ID: <CAC_iWjKA7PKkgPV6ojvw_vMS1VDU+67OB11NvudkwX2Qd5fAtw@mail.gmail.com>
Subject: Re: [PATCH 04/19] test: don't test for CONFIG_UNIT_TEST twice
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, Alexander Graf <agraf@csgraf.de>,
 Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Richard Weinberger <richard@nod.at>, Guillaume La Roque <glaroque@baylibre.com>,
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

On Mon, 24 Nov 2025 at 00:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Makefile already checks CONFIG_UNIT_TEST.
> There is point in checking it in test/Makefile again.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  test/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/test/Makefile b/test/Makefile
> index f7ab9a36b2a..5676bd35963 100644
> --- a/test/Makefile
> +++ b/test/Makefile
> @@ -9,7 +9,7 @@ obj-$(CONFIG_$(PHASE_)CMDLINE) += cmd_ut.o
>  obj-y += dm/
>  obj-$(CONFIG_FUZZ) += fuzz/
>  ifndef CONFIG_SANDBOX_VPL
> -obj-$(CONFIG_UNIT_TEST) += lib/
> +obj-y += lib/
>  endif
>  ifneq ($(CONFIG_HUSH_PARSER),)
>  obj-$(CONFIG_$(PHASE_)CMDLINE) += hush/
> @@ -19,7 +19,7 @@ obj-y += ut.o
>
>  ifeq ($(CONFIG_XPL_BUILD),)
>  obj-y += boot/
> -obj-$(CONFIG_UNIT_TEST) += common/
> +obj-y += common/
>  obj-$(CONFIG_UT_ENV) += env/
>  obj-$(CONFIG_UT_FDT_OVERLAY) += fdt_overlay/
>  obj-y += log/
> --
> 2.51.0
>
