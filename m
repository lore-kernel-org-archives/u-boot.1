Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50354EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55AA5864C9;
	Tue, 22 Aug 2023 20:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="PPDnFU0V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 259CF86400; Tue, 22 Aug 2023 20:58:04 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A72A864E6
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d67869054bfso4831911276.3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TjhV1vBQ0u55+CVsMxPzmQ11Swv7ocfJOcS1lze8JUA=;
 b=PPDnFU0VIzbDX1QjYUzh6z2KuhSYBZx4n9P9NWehonzdNadT9MArbE9Gjw9Z+Ytqtc
 KQDt1zLDy2lJC0vrVJ3xr1zEdllpSdGy3qKFUxt4gOcTufZ5QlD/9C/H6D0vRxoMcczx
 lmgZaZwn3NK+jXaJQQZsqMDsjOoSOe+L4ixxxR5/gn/18I71oGih8HJN91DP7YjVlMxB
 WFn5eBNsVknG3yq0GthcGzFEiHd5Zf6iQ0zcf/MXog18TZMC3VMjd1XKTzOK/Ei1Tui0
 8oudsDztKRY6a2r4UkErpA0VqyXDHp7tTceux4K0i/z6Nkb9/7G5rjVeukBdkNQUEK5s
 m7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TjhV1vBQ0u55+CVsMxPzmQ11Swv7ocfJOcS1lze8JUA=;
 b=TfaDGgO7fReS68ZHyt8OGS57KCjku7SyWbKAtrgtgSV5b+8cyGumCZ5pOxq10nOXHP
 F/viwhJk7rehTp4UdpxjUy9UA/FaavYUE+jJDaa99D8qE6QoxtBdU6HUnqMZTlVcvnCy
 RtT9KTHuSV8HwbM0y8iYn+XoxULVel3XzRDfijARLe1tMomxWxbKRUv2To2gy7x9GMs8
 UoQa7FzCYrDGxiJd9MzzyhFgrwPbc0D+gh1y0r1Nx3N10tAqufh7Zj9/V2YwOV8cJLwH
 +FNh+GEWHkPmWsnMUMVC2JLA0NUrWrJTioHmYIPpT+8O1itQdII7lUO5JA5jrenVcL4B
 aeLQ==
X-Gm-Message-State: AOJu0YwQdJxfvBAeJmYNxmS5xpK078f3+zVpLURSDzYdKt+sijMjFGho
 EaMcxbnxqmQpcOgsXqZsswT77ZO3zOh92mGKSghUuw==
X-Google-Smtp-Source: AGHT+IEzKRYdlFXPC1GcPQmY9poaRS2R6l6Y/sJvBaOk9iUYDmGFI2fDcNHNxu9Gl/G6k93ucmL8kzhyTGWP1czXlrI=
X-Received: by 2002:a5b:610:0:b0:d74:62df:e802 with SMTP id
 d16-20020a5b0610000000b00d7462dfe802mr9423273ybq.0.1692730678856; Tue, 22 Aug
 2023 11:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230822084306.91806-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230822084306.91806-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 22 Aug 2023 12:56:39 -0600
Message-ID: <CAPnjgZ2pqtgQ3mR2+njDOG1V3diP_d7h2-K_GXnJyc3THJVX2g@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: parameter check in hash_calculate
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@ti.com>, u-boot@lists.denx.de
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

On Tue, 22 Aug 2023 at 02:43, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If hash_calculate is invoked with region_count = 0, it will try to hash
> INT_MAX regions. We should check this parameter.
>
> * Avoid a comparison with different signedness.
> * Check that region_count is at least 1.
> * Avoid a superfluous assignment.
>
> Fixes: b37b46f042cc ("rsa: Use checksum algorithms from struct hash_algo")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/hash-checksum.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
