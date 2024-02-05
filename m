Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3AEC48291
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 10:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77C078777F;
	Mon,  5 Feb 2024 11:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UCEzoXWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E8F86D38; Mon,  5 Feb 2024 11:42:42 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5036A8785A
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 11:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so5973737a12.2
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 02:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707129759; x=1707734559; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s5FEDBUGoF2Ul4UPfnvxQvEVnzHFgkKySvONX1TXMAE=;
 b=UCEzoXWNWMw/Ji1oqWHgEmCirKvvkH/Km1eicBBqPDGo1BGiOJHv+lQ/nauf/N/0/p
 jrWNDV4kJGPwKMasdyJ+rbVASIgKQBAtA6ebGCnPSlQOzXpADpftX749EHhu1b55GhiQ
 AE/+NYXLAHr97vQnRzCps+SQcZoHpAtjGbgyPRdqGSMkrFa0uZF3J+NGCFugaA8gdXjW
 9OUd3MSGbNEuYFcokvytYGNcjiVk6y7/3+ZQ5ZxgMklWMaXzwzJMvzKdxNLtDkBjXHM6
 9Z65cDA1YNibkPS3MIaBbjl79KWu8aPWOBMYcHxcAm2YredkkyBUis47G61V4gXFFAyC
 jWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707129759; x=1707734559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s5FEDBUGoF2Ul4UPfnvxQvEVnzHFgkKySvONX1TXMAE=;
 b=v7bic8KW4GI34SdG+GxxTyLp/3qu9I3lgTQbZzGH8RQ45tj9lxXnLGsr9WFHXTy/+E
 JSG9r5t8mSabrqXdJMN2asIiEJLEshCwfHlM0NhXRAd/8t5r4dvXWPW1MR+qppfAUS0m
 bR7gW5kM/7NYFSCs/fhiStqHKo6eSLxD7G8kRDouh8XQ06CW1b4D8o0PsujOvPm+eLLG
 Y2enKKWpJmgh+VoJBrR0Aq4rIYvEfbbvKypFjZchWOL287UUeie26bN3P2XSuyC9tG8K
 HVQuaOdpVb9uvXkxuf48MZXcOwr2cAnhypV2Yi3yYOw60aPTWQ8KYrw+p4u9yfTu3Je5
 +HQg==
X-Gm-Message-State: AOJu0Yx7I5kzvGs8QfIUpsskYPPz1km7H11ONrEzFkc6KWuMO3XT59ZJ
 EVOymz4GHaAfCZ8XqtqOKXqfoeb+1t7lZaQEW2xIjO2q8YInxJyIv2ECRHT9x2DvLtBuolzNHAn
 QQrlj7XptOb2Bohpw4hB8V27sIVI=
X-Google-Smtp-Source: AGHT+IFZX6qv8cON+OyOb7KQKpIToe9nPW5zDy6Rpift9SKn2P6jaNSRGg30Ir7Blnawh9Oq1Svi+NybvGwshrdkEQ4=
X-Received: by 2002:a05:6402:78e:b0:55f:fe4e:9cff with SMTP id
 d14-20020a056402078e00b0055ffe4e9cffmr4634543edy.32.1707129758453; Mon, 05
 Feb 2024 02:42:38 -0800 (PST)
MIME-Version: 1.0
References: <37425599-aba9-4abd-8fb1-3fc9fb78dd8d@suse.com>
In-Reply-To: <37425599-aba9-4abd-8fb1-3fc9fb78dd8d@suse.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 5 Feb 2024 10:42:27 +0000
Message-ID: <CALeDE9OgMjnqa+CWdGfmooBN0j0jzgjEtFcAq+HJWmMBSZYEuQ@mail.gmail.com>
Subject: Re: [GIT PULL] rpi: updates for v2024.04
To: Matthias Brugger <mbrugger@suse.com>
Cc: Tom Rini <trini@konsulko.com>, "Ivan T. Ivanov" <iivanov@suse.de>, 
 Dmitry Malkin <dmitry@bedrocksystems.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Wed, 31 Jan 2024 at 17:00, Matthias Brugger <mbrugger@suse.com> wrote:
>
> Hi Tom,
>
> Here come a small set of patches for v2024.04 for the RaspberryPi.
> It adds basic support for RPi5 to be able to boot on a SD card.
>
> You can find the passing tests here:
> https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/-/pipelines/19512
>
> It's the same commit ID as the tag, although it's not the same test-run.
>
> Regards,
> Matthias
>
> ---
> The following changes since commit 6faba41927bdc8973b59678649ef83c564cc421e:
>
>    Prepare v2024.04-rc1 (2024-01-29 20:53:19 -0500)
>
> are available in the Git repository at:
>
>    https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
> tags/rpi-next-2024.04
>
> for you to fetch changes up to 12d479d01849c164020e17c3ae921f974b96372d:
>
>    configs: rpi_arm64: build position independent code (2024-01-30 17:40:13 +0100)
>
> ----------------------------------------------------------------
> Add RaspberryPi5 basic support.

Acked-by: Peter Robinson <pbrobinson@gmail.com>

> ----------------------------------------------------------------
> Dmitry Malkin (2):
>        rpi5: add initial memory map for bcm2712
>        rpi5: Use devicetree as alternative way to read IO base addresses
>
> Ivan T. Ivanov (5):
>        rpi5: Use devicetree to retrieve board revision
>        bcm2835: Dynamically calculate bytes per pixel parameter
>        mmc: bcmstb: Add support for bcm2712 SD controller
>        configs: rpi_arm64: enable SDHCI BCMSTB driver
>        configs: rpi_arm64: build position independent code
>
>   arch/arm/mach-bcm283x/include/mach/base.h  |  5 +-
>   arch/arm/mach-bcm283x/include/mach/mbox.h  |  3 +-
>   arch/arm/mach-bcm283x/include/mach/sdhci.h |  3 +-
>   arch/arm/mach-bcm283x/include/mach/timer.h |  3 +-
>   arch/arm/mach-bcm283x/include/mach/wdog.h  |  3 +-
>   arch/arm/mach-bcm283x/init.c               | 74 ++++++++++++++++++++++++++----
>   board/raspberrypi/rpi/rpi.c                | 22 +++++++--
>   configs/rpi_arm64_defconfig                |  3 +-
>   drivers/mmc/bcmstb_sdhci.c                 | 64 ++++++++++++++++++++++++--
>   drivers/video/bcm2835.c                    | 18 +++++++-
>   10 files changed, 171 insertions(+), 27 deletions(-)
