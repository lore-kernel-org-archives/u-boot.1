Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89CCC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 19:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67F91871E2;
	Sat,  4 Nov 2023 20:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lGmp5lLA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBEB6871BC; Sat,  4 Nov 2023 20:45:28 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB38871D7
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53ed4688b9fso5180668a12.0
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 12:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699127120; x=1699731920; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bPSnwZjEkbQmhpQ8+Kgnfcbzkvdr6A10T+u4tE+rZXs=;
 b=lGmp5lLAXEUBZXnqJiID+83mJzC658VRUfBTmDqJm2kZ+n2qyEKZpy0yQ/lj1AWsVU
 EQ0Tk/5F5dzaAJ87LHPysVoXi+5KOsVS/5j70SzPILUgI6UppIx7X/jVkUCuwjojUNCK
 NyvQeghLhRgWY0SeNTWKlcsisQeAJIy4+ljzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699127120; x=1699731920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bPSnwZjEkbQmhpQ8+Kgnfcbzkvdr6A10T+u4tE+rZXs=;
 b=NM6Hs7KcWn5IUmUSbA0OZ552BYZw1oFyLIxdl+30kUdIynfUVaA9pqWv3hQvIw52ut
 1LvLFS8DGEwyHVh7UchxLS5FeICKj9hnRL9PKge29gIXHKiuEq0kahvvWfrEmSAjG94G
 tu28iLsXK+3t7VFZjVdeglx9nbTVvKC8utbf28EfHrLcAP0itW9zHOUdPb0cawoolnuv
 mk+zZ9BDjur2HEEqgcqhQr4KIPQ8CtK87KO1JUazpLu+s/+w4MFHGjctqto+MfqigqF5
 lxxkaZiruQsxIJzWIG3Kf3pZ75KtcWaSwR1DDYKogLrBQRONQusEChWbf6xkgxB3WiKm
 pX8A==
X-Gm-Message-State: AOJu0YxJHV0fEQ5IaRXpXj6LR1MFg+4xUhpXp98IvCuEBBm7A6SOKiqu
 fyVO63LTGQmkOWjVzTmIAje6swUTJ8WdUn492rQn6ouN4tE8TgmJsuA=
X-Google-Smtp-Source: AGHT+IG1uDEi5uY8ZitiF3HLoyERAnQaMR8bVvrS6i1Gt76OgaJvLcn4dmLmtkxVLW2UDev6EYrzIJ4PBNUbuVZcR94=
X-Received: by 2002:aa7:d0ca:0:b0:530:74ed:fc8a with SMTP id
 u10-20020aa7d0ca000000b0053074edfc8amr19317509edo.41.1699127120072; Sat, 04
 Nov 2023 12:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231104184043.12419-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231104184043.12419-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 4 Nov 2023 19:45:08 +0000
Message-ID: <CAPnjgZ2cSpXU=RKQDCjzNQtBJ7=rrxPDkqm+g6WQX8KenJftDA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dm: Do not enable debug messages by default
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
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

On Sat, 4 Nov 2023 at 18:40, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> CONFIG_DM_WARN has a text indicating that these messages should only
> provided when debugging. This implies that the setting must be default no.
>
> We should still create debug messages.
>
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/core/Kconfig | 1 -
>  include/dm/util.h    | 4 +---
>  2 files changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
