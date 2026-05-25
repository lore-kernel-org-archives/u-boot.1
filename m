Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEDCCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68DC284859;
	Mon, 25 May 2026 17:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eqiiq93p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C3A848D7; Mon, 25 May 2026 17:28:46 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D8B6846D3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd2087858c4so1780388566b.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722924; cv=none;
 d=google.com; s=arc-20240605;
 b=cJFGEDPujmpvTiRJxC6hprOBbmlq86HYUgMUcVB6LyWad8Oz5DY5sbouRSvsOynYfH
 zXxTqs9LYORnXMJjkm1Dsa9Ttt+yZx/v4zEJ/ZVFosfQeYsPcFl4J1uOiODQeKM9YGkN
 TsJdqQIdgO74K/bu5ut4rnrefQg+QDgCNbfIqHU00m00emd3EMAF8mIFLRgIpxEewvGX
 S3QXlqwQhT4d6nYo+7zsf8nfJXSC+y9rQhnIxL64evCBKE6ylyII2mHXoBu8H0Mo81Dq
 wBMIXRkYqJY5AEdtCoSuTHsATtpjJEFmZgTxWL6to+HCIhLIWkZsFHX1sGgWR81XpKSN
 iDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=k03YAnks427YRRfuskyuiwcJgAld6GDam5ZgkAbPTMo=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=RHEgkq02hk+2QPJuRTb384mNVnV+yajSauPlKDQhfrZTjQtq2DnM1eVVE/ZluV4zdT
 iit+QlkRkrfzgUP3AgwzpgxMqvEhunVkb+eOFLrtLzV9JTaZIbaRWK3TuED66AnpEiXb
 EWqGgiS5Mr0orDShL/MXJcCFZN+GfswAoQp4oFyUDlqZJ6ZONig7gYUT2q1idm+//i5/
 eicnqtP1USMw9d+XqT8AeBNEpIAE6VS5Q92HDfdVyt8hvYkqO23fEFRLruLjeVPciYbR
 q7tdR3XwyVwwAM/pCju+Kr25cPeRKvFv29mD9eH8JoUDhil7vg68TqLkwrJJqDyVZBFf
 f6ag==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722924; x=1780327724; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k03YAnks427YRRfuskyuiwcJgAld6GDam5ZgkAbPTMo=;
 b=eqiiq93pwQyOW+tvtGObcrvcehoU41ADMwjvbsYk4K+3pke3kticXdNUG3jp2TTle8
 2gZ2OQNjPfUV9CpkXJjvOpeAL1Mak5jRrx+OrpCOr7MMx16hrY8jLwabHrSWwVBBUbj/
 F9zngpbkooA0ogXn1CafmjiqMXsxW5nb2d5qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722924; x=1780327724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k03YAnks427YRRfuskyuiwcJgAld6GDam5ZgkAbPTMo=;
 b=JkKpIBFy2rY7b7j7OpoAN/BUQvF9fl+e7imWqesBnJkrQZPCiOx4GBZlXgSQ65IGS5
 9YbrRFsjOUBPCXc2DFFGUcG1sDppLXgFTpdUzWwquJHSrwzWI3ZAEM3Wts3ijGr1fL6U
 PFdogSsIJKOR6jv2dX96mp08JMVENOAj1YvoxqGJc5Qzrd1VxEmQCtCyj6N/QXF8HFoy
 XfWmIqaAFmyMWJroZjFE1xCFS49Ew/nzMhoDSGnxJkC4J2grsrBhtvKtCyDe3CDXZ5JK
 HyRgsaz3PUFworuFowDprb+SeghIhuZQRqpkQ7f1dveRaYMhBt+QFvBB9ig75IpIrQTt
 gFJg==
X-Gm-Message-State: AOJu0YyTBuk6nY8VLmbNSgbcVO+AkmjUK6pCUvrMyTB3gu4+xzp9N5/K
 cyY97by6W5Dtx+HSe+wYaXWtfTF66fkQ7Q3ZL4s7DbzfhF3TluhsVWWC47d3zUUiPaJttXrUJu2
 nxPQdsEF+SatufOrOiAR96s759xQP4ocZH2Qf0+4v
X-Gm-Gg: Acq92OGEJ4JpGqYDDjti0PNvie1NUag/iYXewgUU2FPOyBTPYcv1L8BPABd6nLsEeZz
 iZyBetKMyFQvrH7MPYjZxFEW+dpBu0WXm9TsLLWs9XxxnW3G5YDMX9uFQXlJK9p6/7EEHxtpKiz
 W0qyFYKNK0RMYW3OUjTLZ5GfqAecQ0gyMAn1kvrNXXIZh8Xr/losxmFCOTkVwsh17zhDBs93QoL
 TgxPTpx6Hw5GBVtpyRxyhlE4MZeT2urw059hQN6DqibxGwxyusgfjnDs5RUybFj1xCLSEIKNuhP
 AoZTuA==
X-Received: by 2002:a17:907:3c92:b0:bd4:f594:8a59 with SMTP id
 a640c23a62f3a-bdd279d2c18mr799844766b.38.1779722923480; Mon, 25 May 2026
 08:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260522012312.860026-1-dmukhin@ford.com>
 <20260522012312.860026-2-dmukhin@ford.com>
In-Reply-To: <20260522012312.860026-2-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:28:30 -0600
X-Gm-Features: AVHnY4JdM4E6qQ3Z9LZzm1KP-ylaOmo-As1L1XleIcKi1Xt-MQi9Tu_dx8t34vE
Message-ID: <CAFLszThsj6qU6t=D9vecX=2doi17g2CzPwBK1+-pjaEmezVykg@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] reset: Allow per-board reset type
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-05-22T01:23:09, None <dmukhin@ford.com> wrote:
> reset: Allow per-board reset type
>
> Some prototype boards may not have (temporarily) all required reset
> types supported (e.g. only warm reset supported).
>
> Add board_sysreset_default() to obtain board-specific default reset
> type to enable reset command on such boards.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/sysreset/sysreset-uclass.c | 7 ++++++-
>  include/sysreset.h                 | 7 +++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)

> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> @@ -150,9 +150,14 @@ void reset_cpu(void)
>  }
>
>  #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET)
> +__weak enum sysreset_t board_sysreset_default(void)
> +{
> +     return SYSRESET_COLD;
> +}
> +

I'm not convinced a weak board hook is right here. Since the value is
a compile-time constant per board, a Kconfig choice
(SYSRESET_CMD_DEFAULT_COLD / _WARM) would be cleaner: no per-board C,
visible from defconfig, and no new ABI for the sake of prototypes.
What do you think?

The cover letter says cold reset must still be enabled for the
production variant. If the board gets proper cold-reset support before
shipping, the override really only wants to live in the prototype's
board code - a Kconfig option makes that lifecycle obvious.

We could perhaps go in a different direction and use a sysinfo driver
to specify the default, but that seems like overkill.

Regards,
Simon
