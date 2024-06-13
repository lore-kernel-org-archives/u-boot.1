Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F40C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 07:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C258888C3;
	Thu, 13 Jun 2024 09:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fjs4TFrX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A640888C7; Thu, 13 Jun 2024 09:02:44 +0200 (CEST)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8EEA888C0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 09:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-80b83c2f18aso169383241.3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 00:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718262161; x=1718866961; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l7kfdVc0YfMNKLF4G6pN9dx86/QrF4IBl3HXMIKcexU=;
 b=fjs4TFrXFC1UOG/zdWx4QmZxm0o+JeLWbFMkHacLkJ8dAfASLjTvNsRpecOusLfDKn
 wH37XGGdT1u9tNnetZT6+ilePTIlDpEbuSN1uhlpNjkFzuy65TdZVQs1Axj1zzvfiuH8
 nzPL5P8LBBi+l9UM5JjpiCQixcHpxjnmGoZpZG9SfbocAFHw1Fy+DRqhMFq/UwKkKd0s
 bD3q0/dK529L685SzRwv5rAZoG0MjoKzrGQ+7wVCAAdt9zAnkcDVlfOuE9g80hXIX80Y
 eyghD8TbTzNTRtV41VXPmza/tZX5gVWSHXHq3MqvQ6XO9MkM9w4jOgp/gfEG1rtAAgVc
 QGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718262161; x=1718866961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l7kfdVc0YfMNKLF4G6pN9dx86/QrF4IBl3HXMIKcexU=;
 b=cO4cBeJdn3m165FC4juHkR2NRawV6FRQquJ5TJ84opWejflAC67AXJJFjFbnye6NI4
 P7SnKi+oGgtUHj7xYmvRctairnLdlda/TzVNoBC5N04eQxRiycBE2al3C71GjYPc+8N+
 pQDTZNTee+IpGqnGOIfI5pLApkSUvorrSTFdX/phSBqrkv4ekgIy5Gzec1bI66I3o5OU
 E1WKa5SHTaBKlPGODODlkd41hQrL9UVpqTEiqAZNdoiGHnSTg79g5+mhjdvbJejdqE+3
 DZ5/XPz37GogI4jIst4fiUquzaHt5in7dvtFQ8ZIbeLDwco1CpX6lk5wSVnQRoU6/4vE
 dEqA==
X-Gm-Message-State: AOJu0YxxnKKaeobvIptnVL/BQJ2+f4PZFmkwz2idJMxw3lTs6dmVTbT0
 Lw8W7TFHcskzE8f6XcriuXNtJGZPGJG8emMAQ/xzuXQt1BrFZxntXpLOPCKC8MxHj8tvEwADxB7
 Bbk9vIiowxd3yaFVMUE1mmD4fpxj1NADj49/sTGrvZPUsPe5Q
X-Google-Smtp-Source: AGHT+IH6pC4OcEgKCysDtdMvFJTSfSaw2UgXvbZaEQ0XsCdkt0mGsJDEvMuH6BqQh0AwyltmkPNqeqPexa1yM8wofyY=
X-Received: by 2002:a05:6122:21ac:b0:4bd:32c9:acb with SMTP id
 71dfb90a1353d-4ed07b25702mr4851080e0c.7.1718262160565; Thu, 13 Jun 2024
 00:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240603150749.507797-1-patrick.barsanti@amarulasolutions.com>
In-Reply-To: <20240603150749.507797-1-patrick.barsanti@amarulasolutions.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 13 Jun 2024 12:32:29 +0530
Message-ID: <CAFA6WYPB17=YNabDyGTqo3p=uYD=Vy+Ec2P2VepXT6P+75f+VQ@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Fix include directory for OF_UPSTREAM
To: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 xypron.glpk@gmx.de, marek.vasut+renesas@mailbox.org, afd@ti.com, bb@ti.com, 
 mr.bossman075@gmail.com, leon@georgemail.eu, michael@amarulasolutions.com
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

On Mon, 3 Jun 2024 at 20:38, Patrick Barsanti
<patrick.barsanti@amarulasolutions.com> wrote:
>
> Always prioritizing u-boot includes causes problems when trying to migrate
> boards to OF_UPSTREAM that have different local devicetree files with
> respect to the upstream ones, if local DT headers are not dropped.
> At the same time if local and upstream files are the same, migrations
> can be, and have been, introduced without dropping local DT headers.
> This also causes problems whenever upstream DTS and DT headers are patched.
>
> For example, now migrating a board based on `imx6ul.dtsi` to OF_UPSTREAM
> breaks it, as there are some missing defines in a local DT header file
> (`imx6ul-clock.h`); the solution would be to drop it, which has not always
> been done in previous OF_UPSTREAM migration patches for other boards
> because most of the time the two are the same. This solution is also
> vulnerable to ABI breakage, although this has not yet happened since the
> introduction of OF_UPSTREAM support and is unlikely.
>
> Maintainers assure backwards compatibility for DT headers when syncing the
> upstream folder with the kernel.
> The problem is that, at the current state, all boards that have not dropped
> their local headers when migrating to OF_UPSTREAM will break once the
> upstream devicetrees are patched, for example, to use any newly added
> define which is not present in the local DT header file, even if those
> changes are backwards compatible.
>
> This patch fixes these problems by prioritizing upstream includes when
> `CONFIG_OF_UPSTREAM=y`, while keeping current prioritization when it is
> not.
>
> Also in case of ABI breakage in the kernel, keeping redundant header files
> (only until strictly necessary, e.g. until all boards including them have
> been migrated to OF_UPSTREAM) together with this selective prioritization
> of the include folder is a solution for keeping not-yet-migrated boards
> from breaking.

Let's just not try to make assumptions about DT ABI breakage due to
using upstream headers for not-yet-migrated boards but rather talk
about some real world examples. Have you come across any DT ABI
breakage with usage of upstream headers? The breakage you have
reported is due to usage of an old local copy of DT header.

However, if this patch is only needed to address fear of DT ABI
breakage (which hasn't happened in the past) then I can live with it
such that it can help convince more people for OF_UPSTREAM migration.
We can drop local DT headers as and when people feel comfortable with
upstream.

-Sumit

>
> Link: https://lore.kernel.org/u-boot/20240528084224.113385-1-patrick.barsanti@amarulasolutions.com/
> Signed-off-by: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
> Tested-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>
> Changes in v2:
> - Reword and correct the commit message following the discussion
> with Sumit, per Michael's suggestion.
>
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
> 2.45.1
>
