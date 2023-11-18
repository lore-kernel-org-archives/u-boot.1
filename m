Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5556C5ACB3
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 285F286EE5;
	Sat, 18 Nov 2023 18:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lSkBesye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 291F786A6B; Sat, 18 Nov 2023 18:10:30 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33F0786EB8
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9c603e2354fso571736666b.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327422; x=1700932222; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=76kAPuYL/YpEcKveCGdBWhoJsWqzjFudMNF6ewQj4c8=;
 b=lSkBesyeo7VmJgMn0XswqyjmFLhWtvnOXbgR8FEMrilqT7rRR4+TPM6ZR1Jz6awAiB
 OxhN/Iz1HVMLZI/dCKLp9nyu75Yku4WMRJnC7DhAnKLctlKDuRPNEdCvqPklY2hBmrra
 iSV5BsBx0V4B/9hw76TAB2xaQnWLFLh1SQh1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327422; x=1700932222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=76kAPuYL/YpEcKveCGdBWhoJsWqzjFudMNF6ewQj4c8=;
 b=EvNn+UuAuZ9Xh0KL7mNeIB3JLc0ircwheIAIYQZAnokWom3JzYj1sF6BgkqzIWr/FH
 HxIAiYqQQ23fdl2f/0bOqm7ceZH5bNVT6R/twJaLicxpdyVgs7y9ZwDOeHYbppANHofb
 LcVTk/umWh9o4A+jYQ6scZFseP+m3qJy0uojDBQKpc9r+nFchaOJiCZwOHZcvP6X7eMI
 DjHKb861bir9VFEPCBgLQcMjhNy2tdUv5Ya0FsJ0Eng+AHFE37crZCpyeyGBZscfPFz3
 /QKvuuWQ6JFCr3fwua7+o3at6NlekZt+TsIOEZPEsOUty52RCrsNOE3055D1ccLxk+9s
 kcXg==
X-Gm-Message-State: AOJu0YwnVU9K7cezbRT6pMD8VSkcYspWEy2d8WVZkKZxGBkggBLUnq/7
 5LjDFURao3o0KtZi5Z1U0wVylWlXu5DAhxaV921bLg==
X-Google-Smtp-Source: AGHT+IHAB9UTPxWENDRrESAk19gtY4zBVz3h8KABQiBYiId96Gg7iij8Zsfc1i3KbxH5U2lhvMxHlrbeB3kHM5tLUik=
X-Received: by 2002:a17:907:801e:b0:9c3:dc6b:b7ad with SMTP id
 ft30-20020a170907801e00b009c3dc6bb7admr2185298ejc.22.1700327422498; Sat, 18
 Nov 2023 09:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20231117223829.346652-1-afd@ti.com>
In-Reply-To: <20231117223829.346652-1-afd@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:10:00 -0700
Message-ID: <CAPnjgZ0bg298+KMmtWeQLHTK51QZH3KcP+XrOG32b8Wqoy2_mw@mail.gmail.com>
Subject: Re: [PATCH 1/3] configs: keystone2: Remove unused SPL_MALLOC_F_SIZE
 and KEYSTONE_SPL_STACK_SIZE
To: Andrew Davis <afd@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Fri, 17 Nov 2023 at 15:38, Andrew Davis <afd@ti.com> wrote:
>
> These are leftover definitions. While here cleanup some leftover comments.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  include/configs/ti_armv7_keystone2.h | 22 ----------------------
>  1 file changed, 22 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
