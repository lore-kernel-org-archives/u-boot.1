Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3EFC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 06:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D25188349;
	Wed, 29 May 2024 08:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cq8cqqhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FC2B8844E; Wed, 29 May 2024 08:57:29 +0200 (CEST)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4629C88253
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 08:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-803261419d7so599284241.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 23:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716965846; x=1717570646; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oEMqsckHA4t7az+7UkpGY3ogCLYmcIqLQD5uYn+dt+M=;
 b=cq8cqqhsLOv7mkeC20K33rZR7I8iT/5zwDWKGyDSdq/yQbHwl8dm24opUIgw+XMXPw
 JUuAhTOUdFCl2V0CF1Z+EDo2qX6uuqFSHZ0ceoWqRLztGo06lc2mmzBbwtrqYBzWTDfj
 Q50bkBuqvd3adzms0/wfraW9/kF+28xvTSSqLI3ep6meiYb885M2XuCW21umgqx6tKgv
 W+rkJ5nuZVoo4B1Zx/kdqRsc7wIK1ZpGonoawwqNAlwQ2edGMNFyX/nXuIRDB6rJ1Kzt
 pH4Jm8oVUABKleC510EOwEK7AA/5JIeNJ5pvL0X8mlu5NsTxl9FmGgmPpDDGXOuSxKLI
 RYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716965846; x=1717570646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oEMqsckHA4t7az+7UkpGY3ogCLYmcIqLQD5uYn+dt+M=;
 b=sfV0w4XOFv//wdPnQKT4U9yS13mNp/lD29zYjadbwsx8zxFe1C0FbRNB/7rDZ124EF
 H75r8U/bmB4tM95vxMIeD8DlfzYkNwJAltpeM68e6As0ExKltCjOX5vvwUVMd/fCIvOY
 JJIHVAuC+LVfuJVc9N/1H4IOdCGkRsCVdh3z8MNQJY3HZoDuqLhwgzPH1xn8IX292ecY
 1752UrbnghzuDaLlyNYg1DQjpbe92m7Q6fUknDPXSvvN0JHgWw34vQM0PtTYoZUw33wl
 cMJqt5ku3ucgWzz+fzx3Jlme4rfkY+DZqQ3oa1of4ltUniAkTF7xdpywnbtZpJ2ansxS
 2t1A==
X-Gm-Message-State: AOJu0YwQaYFIgEPunIDTAlueczpRr+P4ZDMeiYIZi5DLw9+qubhJeQoP
 yomjTTRMRKpCCwBjXjmxkA5DfdL0FSwC2J2uncmm5wB3ULtZIZUPhoy79fjZIZ3jQbbjFLfOvcI
 VHlSAPsTo69ds1qympGqyPK6a9lDYA2AEkSb5yA==
X-Google-Smtp-Source: AGHT+IGyNz+5ciJoZaNa/kFm+jtAE+AXgfO8F4qE5PbAyWMAG45SwJpNcGLztkP0fE4dg9QnDEas2Lus/y/wya0oD60=
X-Received: by 2002:a05:6102:2835:b0:48a:31bf:2106 with SMTP id
 ada2fe7eead31-48a38622e27mr13701984137.26.1716965846019; Tue, 28 May 2024
 23:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240528084224.113385-1-patrick.barsanti@amarulasolutions.com>
In-Reply-To: <20240528084224.113385-1-patrick.barsanti@amarulasolutions.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 29 May 2024 12:27:15 +0530
Message-ID: <CAFA6WYOGXA7rPoVG_dJTfMYmKXS=Zik+9saP70Sc82C2L_mFUQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Fix include directory for OF_UPSTREAM
To: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 xypron.glpk@gmx.de, afd@ti.com, marek.vasut+renesas@mailbox.org, bb@ti.com, 
 mr.bossman075@gmail.com, leon@georgemail.eu, 
 linux-amarula@amarulasolutions.com
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

Hi Patrick,

On Tue, 28 May 2024 at 14:16, Patrick Barsanti
<patrick.barsanti@amarulasolutions.com> wrote:
>
> Always prioritizing u-boot includes causes problems when trying to
> migrate boards to OF_UPSTREAM that have divergent devicetree files with
> respect to the upstream ones.
>
> For example, migrating a board based on `imx6ul.dtsi` to OF_UPSTREAM
> breaks it, as there are some missing defines in the local dtsi file;
> the solutions would be to either patch it, which defeats the purpose of
> OF_UPSTREAM, or delete it entirely. This last option would then break all
> the other boards which have not yet been migrated to OF_UPSTREAM.

Can you elaborate more here regarding which dt-bindings headers
conflict? Also, is it only the DTS files consumer for those headers or
there are U-Boot drivers depending on them too?

-Sumit

>
> The opposite problem also exists: by always prioritizing upstream
> includes, if changes are made in the kernel headers and devicetree
> files that are not backwards compatible, again all boards which have not
> been migrated to OF_UPSTREAM will break.
>
> This patch fixes this problem by prioritizing upstream includes when
> `CONFIG_OF_UPSTREAM=y`, while keeping current prioritization when
> it is not.
>
> Signed-off-by: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
> ---
>  Makefile | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 79b28c2d81..899ae664ca 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -826,6 +826,19 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
>
>  # Use UBOOTINCLUDE when you must reference the include/ directory.
>  # Needed to be compatible with the O= option
> +ifeq ($(CONFIG_OF_UPSTREAM),y)
> +UBOOTINCLUDE    := \
> +       -I$(srctree)/dts/upstream/include \
> +       -Iinclude \
> +       $(if $(KBUILD_SRC), -I$(srctree)/include) \
> +       $(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
> +               $(if $(CONFIG_HAS_THUMB2), \
> +                       $(if $(CONFIG_CPU_V7M), \
> +                               -I$(srctree)/arch/arm/thumb1/include), \
> +                       -I$(srctree)/arch/arm/thumb1/include)) \
> +       -I$(srctree)/arch/$(ARCH)/include \
> +       -include $(srctree)/include/linux/kconfig.h
> +else
>  UBOOTINCLUDE    := \
>         -Iinclude \
>         $(if $(KBUILD_SRC), -I$(srctree)/include) \
> @@ -837,6 +850,7 @@ UBOOTINCLUDE    := \
>         -I$(srctree)/arch/$(ARCH)/include \
>         -include $(srctree)/include/linux/kconfig.h \
>         -I$(srctree)/dts/upstream/include
> +endif
>
>  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>
> --
> 2.43.0
>
