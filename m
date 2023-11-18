Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED21C5ACB3
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E4F887252;
	Sat, 18 Nov 2023 18:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VrQJeA8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E210887083; Sat, 18 Nov 2023 18:59:18 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2645887006
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d9ace5370a0so2866085276.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700330347; x=1700935147; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t8tDyJo/tmq/atUtzxnu+twstYkSfD4EtVfdc49/Pag=;
 b=VrQJeA8xnwQ9JqMzRT7U34ukSEU4gkHEZhsiKIhCqSmwIWa5FJtNoPhumZQgIq3fyI
 uBa91B28noSjiYMMGDN4xMujBBM8c/KljkXDF8VY9CwUcncpiSW+Ld3ipNDItufCOzPD
 akhArajYi+xELBb1moHzvKHTCyKmxj2uPwyZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700330347; x=1700935147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t8tDyJo/tmq/atUtzxnu+twstYkSfD4EtVfdc49/Pag=;
 b=SmT66nf6oixOl1V3natzsy97xAL7mArkJvy+ck5TlXYkTFVmwOw2CC6Ny+ClAEy70R
 NngrpN2Y1+W6zHfs1MtO6R/yyQH+IS+dtxnpxL/AmHpv4Yu701hHunitmSoTsllMIs5v
 DLjYZmqpKerYzBit3JBhTiVckPXSKHn1A/RpFfm0hp9zOFYOzWba0slRugVT5dIrjeY2
 ah5l+56JH5/4CbYix6DZR7I82ahFuuwhPNZV126WBMtn6DOiQ/Sr6FDHUzrSB90Q1dsr
 xKCJIA9wccxshTRcG8bVoX5/ulwFAtu7ia8IwIQ722OTcx0bGyWefyspUgYa/9LU1WL7
 LF+g==
X-Gm-Message-State: AOJu0YwqsBTqJm5cIbfJz9uEDlfNbPyR6efuUs1gG09KjUD9QwBlRXoz
 pEYV1xUwg3mB3U/UApd3YY2N3HLewFFssKQJcaajd0t5OTywMUJlEHg=
X-Google-Smtp-Source: AGHT+IHVir8rQOqLWIGZFQhnqC3Bc58UqFvOkTJvWCaUUB++vAJ3q0A5B5T8DQssgq2lG9VWinydeI17fZ5KYDJ1XoE=
X-Received: by 2002:a25:810d:0:b0:da3:b603:8314 with SMTP id
 o13-20020a25810d000000b00da3b6038314mr2292723ybk.0.1700330346782; Sat, 18 Nov
 2023 09:59:06 -0800 (PST)
MIME-Version: 1.0
References: <20231002011553.463514-1-sjg@chromium.org>
 <20231002011553.463514-14-sjg@chromium.org>
In-Reply-To: <20231002011553.463514-14-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:58:47 -0700
Message-ID: <CAPnjgZ1MZoZ018YvjWnY4kSBSR1ZPvDZSJFg6GqoMjFK_FYcfg@mail.gmail.com>
Subject: Re: [PATCH 13/34] video: Add a function to clear the display
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Harald Seiler <hws@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi,

On Sun, 1 Oct 2023 at 19:16, Simon Glass <sjg@chromium.org> wrote:
>
> Move the code from the 'cls' command into the console file, so it can
> be called from elsewhere.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  cmd/cls.c         | 25 +++----------------------
>  common/console.c  | 31 +++++++++++++++++++++++++++++++
>  include/console.h | 10 ++++++++++
>  3 files changed, 44 insertions(+), 22 deletions(-)
>

Any word on this patch, please?

Heinrich, do you want to look at it?

Regards,
Simon
