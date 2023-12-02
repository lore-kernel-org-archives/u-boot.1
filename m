Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2BEC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F11087714;
	Sat,  2 Dec 2023 19:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ob0wi7ea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 640D687702; Sat,  2 Dec 2023 19:24:16 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FA64876CC
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5d35a952943so29928887b3.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541452; x=1702146252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mUtkV+5HiThTFoCK9kxwtUkHTS70OwGFGKBybt3T7z4=;
 b=Ob0wi7eaOl1cjFJOT9ghnCqMn/4IQLza7hLcY3+CL+B3vrbIupe/asKfnJW33a1WcU
 VLyXUWoP7LhIxjZM8/NzkPJm8NObg8QgwWugJ3scnf02CZkuuTw8RUgDEPxZ3SztppMy
 tp+o0JaVe77cwlI6xnBdvSAB5Vhk57F9+e4XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541452; x=1702146252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mUtkV+5HiThTFoCK9kxwtUkHTS70OwGFGKBybt3T7z4=;
 b=TdjRp3CG6NWbeyyCkgHBC31UDQSOrieJeKaIwnNYYaMJ7mc3eqlWg9oI04OYU5UUxF
 QFAeUa4QEXPhg0/uE7cAuYXUoJ6i6eTGpysIgCT6H/NdcICZCyKJlI0InH23wkPrG+iD
 tcNpzkwxMlaT9gZwBIZseKzffFqhYcmVuzhqfqn2iVqS4NFEqkez+F6ralCQxT28u3DG
 atIeuGR5PLkcD13lrjNMpHMm+PuJzY9dUXZVEjEEcOLOXSiTsy2m5qjTe0DYpKZ3tUey
 XoEhwysOrWIIbz74Tl4AKUwOZmEXEZZPmMEJUPPPOejyeVC3ZiqAUxIDAcSPTlY09jKt
 tjMA==
X-Gm-Message-State: AOJu0YwKoI8THohj9q4hPOioHVP3tk5bsTXPB2OKPx8XT9rTYLWMN9Rt
 MkQ2fP3FWuTI20E/oIoB+6A9tWmdSn8EZH8ZszKmC725jCecyZJhCUt4ug==
X-Google-Smtp-Source: AGHT+IElXfBbY1sTSvO76+a9W+fcbPYrrVwPEEnypCmBLXQApYCoZLHe5XOxwgMaChu82Q4wONwfd7KsVcc3GwglWE8=
X-Received: by 2002:a05:690c:368f:b0:5cf:9a35:d406 with SMTP id
 fu15-20020a05690c368f00b005cf9a35d406mr1606347ywb.34.1701541451781; Sat, 02
 Dec 2023 10:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20231122131154.2444690-1-trini@konsulko.com>
 <20231122131154.2444690-6-trini@konsulko.com>
In-Reply-To: <20231122131154.2444690-6-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:23:13 -0700
Message-ID: <CAPnjgZ0_U0-9y9o_FZ3-snLmBauuhUW1uoL5ghC=dTRdy3xcKw@mail.gmail.com>
Subject: Re: [PATCH 06/11] lib/sha*.c: Update header list
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Wed, 22 Nov 2023 at 06:12, Tom Rini <trini@konsulko.com> wrote:
>
> Cleanup the list of headers we include here. For the tools build we only
> need to exclude <cyclic.h> as that's used by the target build for the
> prototype for schedule(), and we don't need to get that via
> <watchdog.h>. We can also make use of our <string.h> intentionally
> existing as a redirection to <linux/string.h> to reduce ifdef'd lines.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  lib/sha1.c   | 7 ++-----
>  lib/sha256.c | 7 ++-----
>  lib/sha512.c | 6 +-----
>  3 files changed, 5 insertions(+), 15 deletions(-)

As mentioned in my series this will prevent dropping the #ifdefs in this file:

#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)

Actually I see that I didn't send the v2 so I just did that now[1].

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20231202153400.537050-2-sjg@chromium.org/
