Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162C2FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 05:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982BD8469F;
	Tue,  5 May 2026 07:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cmNYLf23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71317846A5; Tue,  5 May 2026 07:43:42 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95DCC84683
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 07:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-65c396d3b36so2992972d50.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 22:43:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777959817; cv=none;
 d=google.com; s=arc-20240605;
 b=aM+d4etBi1fWSMisW+204pF7SveoIFZzj52IEnPxtqRkjJhaEaJFOQEJgHeaUFf6yu
 4FrLL4mhoAur4r1Drqd5iOkrjfA66MNo+RJBp7Cu9Ds/vd1M5p3CNThffUV+wViny87Q
 8DKfci9NdZk3ohgd25l1+7eE7qShqx4x7oed2mc56c4MemFLz3WAh3ez+aMIKYTZlLjG
 7i3NOP7oFoOGrLaJCVhoDffkTpqg0Ggmn4gibhFLuDFJC5wLiWvT5KdX6v5tdWXHSPLo
 2f2XIELq5Rt+urjSwpfIaN1wrwZ1q+vm0afkNEqEaQo7Lj7AtJilVD6zaHzF94aosJpx
 F4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6Frqwgt20924NSV+LJDkBdq4NWBMQ07+IZ8tp08fz0w=;
 fh=Jg1GwjOEZ1S4lNqzrPlyRpppkKciiPaSkBs16SCT10U=;
 b=kUuabkzXqwdwcIc008o+aQfhLa+oXe0XlsoIqlndY8j9D9Ascp8GARR58lITx+Y76h
 upmrqdfdt/w4kxyb9wnO7UZfVoEgOxcCCAMI4Uadz+Wr/37ji2Jiljpg6lkkhES16q3k
 0A75fndUoC7uiKtlYi34f1nOHfc7h6lKligGeeaXHco1eXJVRfbHVoYvMD9Y+VV3ujcF
 FIOq1A6P2TolWl/L/yvlF9twcn4b0znUf/S7WnBWYOAZVd58BM2MRIYdTXfIbYjAr3vQ
 0eK0IMh7JUlFTaF0c9T0+DZxeXgRS9FgsW7V3QlmRe+qLX1m0VSY9p99f0MqPNRdBKyB
 PUaA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777959817; x=1778564617; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6Frqwgt20924NSV+LJDkBdq4NWBMQ07+IZ8tp08fz0w=;
 b=cmNYLf23R08/N13MF21xpWMKd7+c0CUKmQ51s2o47XM+ZeCwyy5/ieVzWmp8qTzlwK
 PNHB5fSUyqbau+j3e9Ud/vGjERObyQZyNys8r2EHr2qR0EFrWik8iXgFF3Ix/qys5IFl
 CWdxty+2WaJJzsFbUjoxVioxKNecHNmghM2bMm1onr3uhyqO49Q4fLR8ym6fiECGDhLG
 KYi6jiHufHo9PoOF9wr1KSZRZGTAZuwpmvtaJEhJHrWtg/+smrolb/mv8PznV7vjiujX
 hnbIUxkgJypj/qu9ujjlBmmA1cRqqCPpMzhIfQIgTxOS7VsbGJQu0wbicm1eZhhiR10d
 azvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777959817; x=1778564617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Frqwgt20924NSV+LJDkBdq4NWBMQ07+IZ8tp08fz0w=;
 b=EIIrZ4NosdJr2fXs0O5NbnxsTrp/iXdWPGZKzBNfkWn3qZ2BMwShfkpjiJJi7knOjb
 frqgp/43rxPIm6Id3b6SWWSluPPWKHVTsWjTQnPCAGtWI7lVStYZUdUV0PqtClO7WHAA
 H9rnl1T2oEd0UlnpizizONGBe6BgUSS7CSSrOHOoh6fDB5orE/rkQ4ohNvpWO8b9//sW
 oePtX4MvDKCfkB+BKx7AOwgQRr+5M0NCdmQWfPZRZifX9RaLwRqqDLP745qNx1RRYrEM
 q5rGYR0zaCOnTmuAmylOmx0RisQRlQ6uacJCsEfUmt6WSPiyh133AqV9P7jLqvQXIllP
 rccw==
X-Gm-Message-State: AOJu0Yzi/3lz0X3KrGkVRPwKBVnidOYNjHt4Bhg01VB9K0KpbSTb4zfp
 vpiwschsqgZEN952ZfcMbRAcuHm4zqQDXzBobHFQ9bJlxBOm6SyX+4sIpuUPFkNzXMoJQPKzPIi
 Ofs7einv5gD/oRhBKEAUwwWp7hPgAdzJeMgcEHpLkaQ==
X-Gm-Gg: AeBDieu5OzMJstYdLaqzd0SD5S7mV/PzxuAa+ICGxupE/kCRij89T7tfXFMEgGH9BRD
 Btj/0fxSBLSS7wW3Nrryx4HVClv/xG+ABqRK1z9TjeaUqw6gbiN4mZuzInGdS1LaC5hZoUHcNUU
 PNnHSObFsAP1aqBoDEcra4gQI0AyBw4YhrC3fb2zAzfGB0COPIuGsz19+amQAcgduXD0TjWXfy6
 7/xojtP8PF5gAIf519RpQ7stZ4tpZpPweJmaS41BH7F8Hcbh7v1z9mGSCzv4Tg1TKAUHDoNuEAC
 ZCWf+s7AD4MX9KCIXapo/hE3sM9lfzC1ykajaY6Jg9o2RTAX7+2pvmc/l3RvEanXpc4X0WXjSyM
 qr9JSvooOEspWqESaji1nNy10q5nk29SoGioxbKokN+A+P+cumVKFO75O3zU9RkzAq3r8ipX20s
 lRrjHr3MleWHRrdLHWBizSa0NOokGym0qwT4DM+k2j3ZJ3RpZX55L9zgACJtf/Xl9F3Esc/Hq5a
 EgwXFoL0tsDI0oy1KX5z1DpmLgawFPLmbfLv3gYXthsBwHOUC/CQ8nHRLFhKeFYwIXtXMltxJRW
 tOr0+y9huc6u9g6nMtkr8cUO5D2LqoiFt2Zl0yh31EjdHGoe+d+64iZwIOp2CMOp+bFArnR7Qiq
 NaH/bD2i0iTxYn3P77DYw+Cnm3wIrfYZH4X7FLg==
X-Received: by 2002:a05:690e:4081:b0:65c:65ae:be23 with SMTP id
 956f58d0204a3-65c69f21f55mr1936602d50.45.1777959817361; Mon, 04 May 2026
 22:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-7-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-7-b19301d1948a@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 08:43:01 +0300
X-Gm-Features: AVHnY4IndgXqGqiYtCNCPBs0wtCQ-iEgkx0RCoE9tvEkiM3TChWLJ3Q0tC7SKFY
Message-ID: <CAC_iWj+wmJS9+i1ZQV9+xQ2cwL=6EX-E3j6FMYR6pHvvuqZc-Q@mail.gmail.com>
Subject: Re: [PATCH RFC next 07/18] scripts/Makefile.extrawarn: handle
 CONFIG_WERROR in U-Boot-specific file
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 4 May 2026 at 16:20, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This is not something that is in Linux kernel in v5.1, nor in v6.1 which
> will be the next sync. Since the next sync will be importing
> scripts/Makefile.extrawarn directly instead of backporting individual
> patches, CONFIG_WERROR handling would be gone.
>
> Move the CONFIG_WERROR handling to the U-Boot-specific file such that it
> doesn't get removed during the next sync.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  scripts/Makefile.extrawarn        | 3 ---
>  scripts/Makefile.extrawarn.u-boot | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index c5ed501d374..7dfc374a19d 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -22,9 +22,6 @@ endif
>
>  export KBUILD_EXTRA_WARN
>
> -KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
> -KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)
> -
>  ifeq ("$(origin W)", "command line")
>    KBUILD_EXTRA_WARN := $(W)
>  endif
> diff --git a/scripts/Makefile.extrawarn.u-boot b/scripts/Makefile.extrawarn.u-boot
> index 0a9b49a30f0..86f6fbc2301 100644
> --- a/scripts/Makefile.extrawarn.u-boot
> +++ b/scripts/Makefile.extrawarn.u-boot
> @@ -25,3 +25,6 @@ ifdef CONFIG_CC_IS_CLANG
>  # there are other places as well. For now, we will silence this warning.
>  KBUILD_CFLAGS += $(call cc-disable-warning, deprecated-non-prototype)
>  endif
> +
> +KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
> +KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)
>
> --
> 2.54.0
>
