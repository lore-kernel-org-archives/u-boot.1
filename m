Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C05CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8F0B846CE;
	Mon,  4 May 2026 22:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KQaTYDlS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B7E0846F9; Mon,  4 May 2026 22:34:47 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 661658394E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bb91b426e40so785393766b.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926885; cv=none;
 d=google.com; s=arc-20240605;
 b=bfRmUkF4icjwyOjVG1GJI1dlZLbkZs1QibdFtYP9Voj+/Z5zre8ja7cMG27izH+56y
 uXXjtHjWt1sGH0udwS1KQwW/eYV+2CR3ciuIBymkdaacU2kRamOAgtUjxt+Ifj/Uyyi9
 dgeKndkCZXXV2DpgZ2d3z6OsHsdV20hlB96o0sABlUDZloDlQp03Wu2kFHa3JhMGx2/c
 gK02dI6U+/YeOOLrVdpJyUL9Zv181HUOPADR7HHHGiEzROS57OIPQhjtavLOpM3cJlUj
 TeIRYNqUm+9UiJQ0AyRMIdD+uIjCis2ymhwN0Cf7AZc9cwe7PUa/tD6xNXkvMdYHvLNi
 vsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JajZdT8hm+y8Yc+hHroG2zhHdrF/3UnXJfMal2EaMcI=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=B4wL/VNPuya5iBQVCD+p/AXU/ZveDlcC233vhGD/M/chZi+0jTyitA2LFvRHqKvnr4
 6qjPIJNa/XJzFPB1TJAR/zKPCBErIFEDU+mZU/t4245k08AlF3io3o+rL+zhD1VldY5t
 g65BqldtrMX+zLQJKxV+tKbN/JaAAtPbFo5S4mPrgMZ6wWsf56S24OVaDlpVGLaqSIn+
 AanQzY+QSJSa5++eRqcf26mKd6qlYWAELibMtCE3dToqwFMMm1WxbVlVeYmI+57Avmwz
 DEj8n+klz1LbMw5Cs7bDqZiKuwVneP0H5QRkTWVHLiDvEvJT5mENeLo4g4R/FjqkjFqS
 Ofag==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777926885; x=1778531685; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JajZdT8hm+y8Yc+hHroG2zhHdrF/3UnXJfMal2EaMcI=;
 b=KQaTYDlSgZpjd6S9I1bplQQjcVkdwhm27cg37fgOmAiFsc5iLtahfc/U0R0+nPyQOC
 5zC4vJAYLUu8dfgVT3wHaU/IHc8jlilZOJR06M36B0KxduhsnSArWNLrnawg2tj9LwMp
 gGLgLwA/9KxK9+/1TQMkJXBvqQh1NGHmscwc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926885; x=1778531685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JajZdT8hm+y8Yc+hHroG2zhHdrF/3UnXJfMal2EaMcI=;
 b=cuxckkKRt4xrMbrJmK+nDJcYmtgvCid2biUF9Zo0RvqnZcRJcItq+wwwzQWkOhs1Ju
 EaCihw1kU6SEGF2vOUj8HS859OUo1nus1hy/lERouMbbF+EYDh82WzEpqKOlxRgSgZTz
 GH2DwZbukMQmeSsBRIpejZc+qnS4lpyjdpWT/gyJLvw6E1Ogm0LslpNNmHZPGzm4L4JL
 roxWOb1IYkHI10FqF5SFyQxkGXpZ7R9z7nu3ieJPCh3BXjq58RzuWt8dzsTeT/u2er55
 d84kTyNqT+7c+SHGm0HtW2OpS1Nj5Korphzl5c7Xmy3eEH96nLmNyk5TuziHrdrlqluT
 vaaQ==
X-Gm-Message-State: AOJu0YyJRLf5OyV3ETDoqHjqyf6Amj8+5fMW3pKSANLz/OTtvCceyps5
 m1HEMUWqZfDQyVnEzjxW2tvDVNU01VckSU26jtiesoss1D136bKo7cn4wGSxYELHX+kdiHRTVSt
 52mR4qqfhiDIFJl92M2n79WiCrVE3OzrhAGy0EUQH
X-Gm-Gg: AeBDieuLYcsjoA2L4CDYc93h593DfUnTpEEzftfDDkFR+zqUxINKLVQontxPWHFDR0d
 PPKSziefieH/1+uUd18pmEk864sQwLH2r6TiUAGw/RpJkDSwidfVJFmPdzWIgZL2fGvdDBPth3I
 IVNHAeYw8nsdmETD8jn8UQW9n0KmaCAuZiOojfZhpPQXGOmrazM2yDn+KtRH2OfGst0cs1kv1cU
 ehjJ8s1YZZ751Xy7ULiyDy7ILREtPIlkLOURDXEPVrwt6vOkN3YxWAjOb20vvePUQljBLnXreoI
 X1myVoa2NNArxwdX
X-Received: by 2002:a17:907:874c:b0:b9d:3e5e:fd32 with SMTP id
 a640c23a62f3a-bbffa02f981mr702536866b.8.1777926884742; Mon, 04 May 2026
 13:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-8-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-8-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:34:31 -0600
X-Gm-Features: AVHnY4LkghKT5eSs8pN6JURhxESn-AHeXiFkQYtsEOJ7hsRgxeJkxhQYSODfDcA
Message-ID: <CAFLszTjS4guQy-sW4SL3fzpbcNNqJKxMYn1qDDjpUhdP05YwVw@mail.gmail.com>
Subject: Re: [PATCH RFC next 08/18] scripts/Makefile.extrawarn: sync with 6.1
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> scripts/Makefile.extrawarn: sync with 6.1
>
> Sync scripts/Makefile.extrawarn with Linux kernel 6.1's.
>
> Since it adds a new option for KBUILD_EXTRA_WARN with e, document it as
> done in kernel commit c77d06e70d59 ("kbuild: support W=e to make build
> abort in case of warning").
>
> s/gcc/build/ in Makefile as done in kernel commit e27128db6283 ("kbuild:
> rename KBUILD_ENABLE_EXTRA_GCC_CHECKS to KBUILD_EXTRA_WARN"), part of
> v5.4. The rest of this commit was backported with commit bd3f9ee679b4
> ("kbuild: Bump the build system to 6.1").
>
> Our scripts/Makefile.extrawarn before this commit is Linux kernel's from
> v5.1 with the following diff:
>
>  # diff --git a/proc/self/fd/11 b/proc/self/fd/13
>  # --- a/proc/self/fd/11
>  # +++ b/proc/self/fd/13
>  # @@ -13,17 +13,8 @@
> [...]
>
> Makefile                   |   3 +-
>  scripts/Makefile.extrawarn | 154 +++++++++++++++++++++++++++------------------
>  2 files changed, 95 insertions(+), 62 deletions(-)

> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> @@ -22,64 +17,101 @@ endif
>  ifdef CONFIG_CC_IS_CLANG
> -KBUILD_CFLAGS += $(call cc-disable-warning, initializer-overrides)
> -KBUILD_CFLAGS += $(call cc-disable-warning, unused-value)
> -KBUILD_CFLAGS += $(call cc-disable-warning, format)
> -KBUILD_CFLAGS += $(call cc-disable-warning, sign-compare)
> -KBUILD_CFLAGS += $(call cc-disable-warning, format-zero-length)
> -KBUILD_CFLAGS += $(call cc-disable-warning, uninitialized)
> +KBUILD_CFLAGS += -Wno-initializer-overrides
> +# Clang before clang-16 would warn on default argument promotions.
> +ifneq ($(call clang-min-version, 160000),y)

clang-min-version() is not defined anywhere that I can find. So I
believe $(call clang-min-version, 160000) always expands to empty, the
ifneq is always true and the inner ifeq always false.

> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> @@ -22,64 +17,101 @@ endif
> -warning := $(warning-$(findstring 1, $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
> -warning += $(warning-$(findstring 2, $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
> -warning += $(warning-$(findstring 3, $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
> -
> -ifeq ("$(strip $(warning))","")
> -        $(error W=$(KBUILD_ENABLE_EXTRA_GCC_CHECKS) is unknown)
> -endif

Dropping this silently accepts make W=q as a no-op. That matches v6.1
so I'm fine with it, but please note the behaviour change in the
commit message so anyone bisecting a "my W=foo did nothing" report
finds it.

> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> @@ -22,64 +17,101 @@ endif
> -warning-1 += $(call cc-disable-warning, missing-field-initializers)
> -warning-1 += $(call cc-disable-warning, sign-compare)
> +KBUILD_CFLAGS += -Wmissing-prototypes
> +KBUILD_CFLAGS += -Wold-style-definition
> +KBUILD_CFLAGS += -Wmissing-include-dirs

...
> +KBUILD_CFLAGS += -Wno-missing-field-initializers
> +KBUILD_CFLAGS += -Wno-sign-compare
> +KBUILD_CFLAGS += -Wno-type-limits
> +KBUILD_CFLAGS += -Wno-shift-negative-value

Several flags previously wrapped in cc-option / cc-disable-warning are
now passed unconditionally (-Wmissing-prototypes,
-Wold-style-definition, -Wmissing-include-dirs, -Wno-type-limits,
-Wno-shift-negative-value). That's the v6.1 behaviour, fair enough.
What's the oldest gcc we support?

Regards,
Simon
