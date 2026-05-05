Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9F9FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 05:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9B64846D5;
	Tue,  5 May 2026 07:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AbZSexnF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A21684702; Tue,  5 May 2026 07:50:33 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A3B284683
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 07:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-65c5361142fso1635339d50.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 22:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777960229; cv=none;
 d=google.com; s=arc-20240605;
 b=cCavNrRH8S8hilixxyXCxfKjMUHomDo22RDdpVoNqnX1W3OXu62rLHLLvXyeeLqodk
 aHKFpbdLV8qBNPjGtwhaicYcBVKnxYYMrwZo8mzcLu7onjrr6ElRq1AV2sGQr+1QdLZO
 2r74q59TiJ4uog1LTMSohswSwtj1RKPJ9eRVsUD7/fbJQUfj05hTPsVwVbOhu4lXmMvr
 zE9JUIqJmkMYd5yiWY0JOtViNbzeImoaJqJxC0k5p7XBoBz7bnGZ03BoVMzv7z2xMzJn
 wYRx+dFaBAAERexN+gZeYOIsDHUXPiav6GjsrB/MP63xVUuAAXYpA1JgwjyINZ801kVt
 plFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0sZIVAOk5A0QAEeXl8CqPDYaZRsRLkOoSiSCwokycN8=;
 fh=Jg1GwjOEZ1S4lNqzrPlyRpppkKciiPaSkBs16SCT10U=;
 b=f/bpRaXX6C/Kpg5/evYG3Sbmt9fKXLbsFMemXognUa5iGaP9t2g4YGKFe9zTxjTAuo
 5x1wNusP7/RkLcJeGtYQKLZAisk1jfLXoh0TtZkwEzsANIMMPl1QjipapRs3ZbLzAMdS
 LXvr8m6u5LIr8ipkLdKBSmv0jeQtQavJnPgWnLfgJbEuh0XiEcd5tnOuduVAUcKeQqql
 3LaJGI8OGkt/1VPLDMCr1rpDQNaqiiLAmF0fjMibxkwHktEIs8IfKWrOWQtPZXyldGeJ
 g6R+94G5ysIsCOTYH38uYfTHw0k1Z5LPMSXjpixQeG8nb3EuUZgzEJsSCf1ci5Le7JVV
 Ki0A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777960229; x=1778565029; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0sZIVAOk5A0QAEeXl8CqPDYaZRsRLkOoSiSCwokycN8=;
 b=AbZSexnFTXz8AlbSPEl4A1jMKpc34aUXAqAjJCHeUX5fMe4gL9sohSZ+/7aiBARpEx
 W3fROSAxb8xnD8sP5KkByvrDjZ1CfmTdNhBzBONrkG25pqsnopmNvP78hi1uGGMSKid+
 w8qk6/8zUVDa6OhZlraXhW0csMDAhN7Z8vLVr3tVvM9qUROf9IpWVLyocP2oyjUbseNb
 FZ/F3f3PKMOzVf0ZT90u0KnosCyVGPAh2dUCxb2pzrYXQM4uzA29i3NNgxiWC9DbfuZ7
 PvN1FOfLWh7KQpxNNcNHwcvKWFnfnNqLgNVTCbIRw1xCik+nGcp6dReWdOY/crFOOpSD
 SWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777960229; x=1778565029;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0sZIVAOk5A0QAEeXl8CqPDYaZRsRLkOoSiSCwokycN8=;
 b=LGwJzhC3qdt4iO4An0GpZiWoNhYBBqJ/gOwp6mhEQKjfXhaf0xKgW7SMqlTCTCGdpI
 YO3sbbDGl7+tec33rUZVMWSvGIe3zxN9PV51xMCtDcjJgWkc3ul6Ny2hB/lCy0P8wcYo
 j7HXTmOlkg9Pui1anf1h27WqkBxO+gw2KCPMerrJ2uYJKvjPNsDVlpjh0uz8EJLv2qTE
 j9vg9mObPW9Bonx5cmFdK5qCEqo5fQLqQW5EPYw1l1OKq3ajVYOpW8bKBYJdFO9fzbMt
 k4oVdeIT3mZahb4YY64Z3LzjylxrfIqAUMmx/RqD8aFj4dcR0SQUArBFKZePehMaWLWG
 2Lig==
X-Gm-Message-State: AOJu0YyFXLgwBaMV7rYDntG9AsfyOmb1aNqLfyS7yN6CrZ54BKT3BHdL
 TWRmsVmAb+r5SoWWOOyT7263nMic1M29Hu3lZnY+Ct2oUy9U+HWYF8lOxUA3JJvqD2Ry1HjH4M3
 UKGEYy3KLQ824Z7ujSLqr6ffqh+LLdPkvZDAVRFO5Ow==
X-Gm-Gg: AeBDiesF0bYAS1QJGU37qWQfuCHHLb5nSLVwD1MsUGSJxIVcZNZtvwaRk+vxWjOlst+
 wbfTrG1+T8jVmJXotPS+NTtZ0vcrHyIJEfXrrzmhGCIH9A81gLa4HerpZZJD97IHRxTFYaD17n8
 QTa8y3feCof2I5+WeCm3YGnl6o2OL6u9vKEGVpLyxmjOQ8ht6yxXGtR/D/Gb+xSnS/1o9078KRf
 AwFxPGWkOjLCkbLe0GpS/eGrgWkZz/+GmTc6Z7ThFctiV3sXlsivTyVShL//pTLH6FSy8U0Hcfo
 NO4Y2NcIRWitNkR0GQg9O+VOdb5BnGP01Cr0hjTpOnDMX4cdcCXpuA+NSP69lIKWy1141vfBnD7
 DjHReHtzL/5FGbELGFbgXDQGrrQTcgO7AAW0y2pGXRmfARnBC4Mf2K1dpeASr0Eb9S4wVRJ5N4G
 yHfr6QEP9T6smkF8wN1EEwltDLA6shOOAX44lpcbfSoqXMJNps6qvnegc9XA+qHPP+UDIHBj5UT
 v8U8O5P/sSR/Oa1ffxZOCYabp4f1/hA7dMbxE+NYkXG5Zu/JalJhMPAQmD7tNlrZ17Z50hT+LOA
 RsT/h9OgS2PqEqnfHs53H8wcB10wb3BYPxiLF8lNZbc9rnPQVJcteG4NQCMsMNGzSoFoboL0oRx
 /K1IBKnBG+mXECLVu
X-Received: by 2002:a05:690e:44c6:b0:651:b962:bc22 with SMTP id
 956f58d0204a3-65c3dbe643dmr9886713d50.63.1777960228851; Mon, 04 May 2026
 22:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-16-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-16-b19301d1948a@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 08:49:51 +0300
X-Gm-Features: AVHnY4I6Pu3DelO8T3cKWcKaEQKEQNHBLiVgw-zrhIaX9nW6J6avXyaX-JnuXwU
Message-ID: <CAC_iWjJhOKyz9PESA1d215DC5CtEE8tP0ccJN38QKZapS=hPOQ@mail.gmail.com>
Subject: Re: [PATCH RFC next 16/18] scripts/Makefile.extrawarn: Respect
 CONFIG_WERROR / W=e for hostprogs
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

On Mon, 4 May 2026 at 16:21, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> [ Upstream commit 7ded7d37e5f5b36b4acd74380156cf07b6640c5b ]
>
> Original commit log:
>
>   Commit 27758d8c2583 ("kbuild: enable -Werror for hostprogs")
>   unconditionally enabled -Werror for the compiler, assembler, and linker
>   when building the host programs, as the build footprint of the host
>   programs is small (thus risk of build failures from warnings are low)
>   and that stage of the build may not have Kconfig values (thus
>   CONFIG_WERROR could not be used as a precondition).
>
>   While turning warnings into errors unconditionally happens in a few
>   places within the kernel, it can be disruptive to people who may be
>   building with newer compilers, such as while doing a bisect. While it is
>   possible to avoid this behavior by passing HOSTCFLAGS=-w or
>   HOSTCFLAGS=-Wno-error, it may not be the most intuitive for regular
>   users not intimately familiar with Kbuild.
>
>   Avoid being disruptive to the entire build by depending on the explicit
>   opt-in of CONFIG_WERROR or W=e to enable -Werror and the like while
>   building the host programs. While this means there is a small portion of
>   the build that does not have -Werror enabled (namely scripts/kconfig/*
>   and scripts/basic/fixdep), it is better than not having it altogether.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  scripts/Makefile.extrawarn | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 8988308cc36..9fdc38a40af 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -108,9 +108,11 @@ KBUILD_AFLAGS              += -Wa,--fatal-warnings
>  KBUILD_LDFLAGS         += --fatal-warnings
>  KBUILD_RUSTFLAGS       += -Dwarnings
>
> -endif
> -
> -# Hostprog flags are used during build bootstrapping and can not rely on CONFIG_ symbols.
> +# While hostprog flags are used during build bootstrapping (thus should not
> +# depend on CONFIG_ symbols), -Werror is disruptive and should be opted into.
> +# Only apply -Werror to hostprogs built after the initial Kconfig stage.
>  KBUILD_HOSTCFLAGS      += -Werror
>  KBUILD_HOSTLDFLAGS     += -Wl,--fatal-warnings
>  KBUILD_HOSTRUSTFLAGS   += -Dwarnings
> +
> +endif
>
> --
> 2.54.0
>
