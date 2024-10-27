Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690F6D13576
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 17:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2201C8904C;
	Sun, 27 Oct 2024 18:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RYvj/ydA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A2589043; Sun, 27 Oct 2024 18:17:04 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 550ED8841E
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 18:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a6b4ca29bso441171866b.3
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 10:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730049414; x=1730654214; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g2kKS4a/efWSVsw10b3R+EGxAxhon8ONJTvZdatzwYw=;
 b=RYvj/ydAOXQnX9K6J+BOxRKCozWbh06tiA3eQKAzit+slTn8IjJ8kYK4Pr6FslKgu2
 Ymesgt1CAg4+Bi+J8iHVX9nVnIieWPIGw2XXeLHN9+WQg0DuDCQHSGIr4LywE88WPhRI
 nEo4liM+Tzg2sE13VrMV/rqKo/gFHQXb7U66k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730049414; x=1730654214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g2kKS4a/efWSVsw10b3R+EGxAxhon8ONJTvZdatzwYw=;
 b=g27WS+Tuj3N0F/sVJ0g3XRuar5SNY+etC7bKkziPwxWLgAOJ+OkRIx4h7BBSlkRlZx
 jQA6WitnSQ8V7zyn2CAuNeN01f0VUhqX82SBOLY/yqbQTwzDZ0E5k+8An/ZUeIcaoIIY
 wi3VUygQyZHn2sRYZe9qClOu8yzCaPEgyqfMCXH+F5Bz5Hz1kAm2IMrCklvUk5wHrfAi
 T3qPchTMxpPzDovsjnnIdDt3+3qUKA94z6/roOlvbe0HVWaPIwSJDJIDFjJMbSXSsbbK
 RRSl+zPV7zRwyDSEH2y0jL5wYKi0IWuA0NBTUv9loJ5hmneRDFLTSkJcwFEWXOau72+H
 5Ytw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXb5gjQu4CU/rreQCjSBESBISy+/XR322/8rJcGAcJG25LWm29lkFM0kpDfKK50Rez/BkByq4=@lists.denx.de
X-Gm-Message-State: AOJu0Yzh3x6PUGZb4jUpxJ7Wm+CsbOINy698QFhvkZd3Ld2cV8L6H58i
 H0+eSvUZRU6m0hGqRqqkCZgh8FFuGCrnxjJGgDYuJqU3ybdscLgGBWbYxkO21m2zcUJ8oPnXRC6
 1GGuMjuc4/1aKptEuTlHOa1TNpbiTTLW93Ho8
X-Google-Smtp-Source: AGHT+IGl8RuOlL4e+m28T5e0SPXgxWD5ObnHnJ4N+xoBl9xvKoHIOHbWVnN3O+Itr3o3qb55yDKp6fcD86XiR4Nbnlo=
X-Received: by 2002:a17:907:2d86:b0:a99:5f16:3539 with SMTP id
 a640c23a62f3a-a9de5a41c9cmr453763866b.0.1730049413592; Sun, 27 Oct 2024
 10:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <20241026064048.370062-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241026064048.370062-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Oct 2024 18:16:41 +0100
Message-ID: <CAFLszTii8bMyEL7rURxHxD0QzJ2JXDdgwzuAC0mgKx=m=ebW_Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] fs: ext4: free directory node in ext4fs_exists()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Sat, 26 Oct 2024 at 08:41, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The directory retrieved in ext4fs_exists() should be freed to avoid a
> memory leak.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/ext4/ext4fs.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
