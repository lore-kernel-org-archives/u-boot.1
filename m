Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532E2C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE1B88835;
	Mon, 29 Jul 2024 17:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H5K8wD+T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5AB388852; Mon, 29 Jul 2024 17:28:47 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C10AF87E13
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5d5bf833de7so1981045eaf.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266924; x=1722871724; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/ZYe8zRMoyQ8z2hTBx1JSg+ZqPwFrJa+2VIBqvjbvBQ=;
 b=H5K8wD+TT2sT9z04sDuxINa1XV3oUyh7iAb3ZOE8LbBetGrD2LCCN9g/HoNEXQypf7
 rnitBzFB5x/cqSBQ8LMo6b6wb5SrWb7i6wdFJNkDB1b/cwBdELa13iZkb7ur+7/n1oqD
 t8E9SNEg/aQQoupPVsxf5cBNwBKV/UUzJsEGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266924; x=1722871724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ZYe8zRMoyQ8z2hTBx1JSg+ZqPwFrJa+2VIBqvjbvBQ=;
 b=fg4RE2ih9IRxtkGYa1CHROVsJ4XzH+U8BDl2YRtuNm+ZySlurLOMX0vRhB8rRQtGyE
 TvVs0BpWI8ORBcu45oGu+0XdpHReHMdZkLQKv1Z4hpdfUSXA6W2JA07Y+HYrpFLoVxBQ
 vCr0pOaE2yqn7pc119OaKMiztePgkizjaP/FA4S0my6sdEHmGbmCA2dIrPKl7fOJsB5p
 X8sbbQ6EhqibBR6DvGtqkgEj2ZcaO6Z93uCORE8SMkQ0Nr6VxZ05Qq/4nD6TMXo5dOE7
 qZPSrjHpfTdL7d2UNHbpyR4RCffbBbMAMf+oqxId+uq/VCMPRyJyilPyoGX/chNzua6Z
 cquA==
X-Gm-Message-State: AOJu0YykwXfea4ML5tHYkd/GZgbCil4TPFoXiabjkMQvoxxGTRGN+fZQ
 FY1MRfhWFyTcvElKitXxBG22GCRpvpSOXh4kvj0h1I3vm4uENZCcw0i8tkuNDZ3OZ7HYzV1eKun
 zcXs7Qu+c+70BBogK0ehABaUuRa3YGYDptPKr
X-Google-Smtp-Source: AGHT+IH1AL6RKCEPGxH5qhBVtFwvOH7mZvAUkTB2RyVF48YhidVsUaryopxJVPKV/hup97ZAo74j+KeGGv25B7xKTOw=
X-Received: by 2002:a05:6358:758e:b0:1aa:9fdd:af89 with SMTP id
 e5c5f4694b2df-1adc06d4d7dmr1543145155d.20.1722266924435; Mon, 29 Jul 2024
 08:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-4-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-4-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:33 -0600
Message-ID: <CAFLszThVGswtjS5+1T8Ot0G1LYa9p6XaZpLpX3c5vOhDAKHQqw@mail.gmail.com>
Subject: Re: [PATCH 03/17] acpi: x86: Move MADT to common code
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com, 
 trini@konsulko.com, bmeng.cn@gmail.com
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

On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Write MADT in common code and let the SoC fill out the body by
> calling acpi_fill_madt() which must be implemented at SoC level.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> ---
>  arch/sandbox/lib/Makefile         |  9 +++---
>  arch/sandbox/lib/acpi_table.c     |  7 +++++
>  arch/x86/cpu/intel_common/acpi.c  | 20 +++++++++-----
>  arch/x86/cpu/tangier/acpi.c       |  6 +++-
>  arch/x86/include/asm/acpi_table.h |  3 +-
>  arch/x86/lib/acpi_table.c         | 46 ++++++-------------------------
>  include/acpi/acpi_table.h         | 11 ++++++++
>  lib/acpi/acpi_table.c             | 31 +++++++++++++++++++++
>  8 files changed, 81 insertions(+), 52 deletions(-)
>  create mode 100644 arch/sandbox/lib/acpi_table.c

Same comment as previous patch.

Regards,
Simon
