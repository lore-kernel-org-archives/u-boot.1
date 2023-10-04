Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20773E8FDC5
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 02:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E775872AD;
	Wed,  4 Oct 2023 04:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ef0OBe4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9890A87284; Wed,  4 Oct 2023 04:12:00 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EC958745B
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 04:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-59f6441215dso19760677b3.2
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 19:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696385516; x=1696990316; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OXsA8XT/Y2XR9Y2D4HLJmfINW7ZoNO0C+742udrdo0w=;
 b=ef0OBe4FCc0Pj5KWckEZVfM7pXZ6LAGUyoerMBXZCGlVMpXreEixcv4b6EXjkRmrvp
 hvIfmZLk3dFZpZDxfRuby9UMbRhynkgETbCSC+z1Z2vY0F7drzyjl9vHB+g0JMrpqsMx
 LI3qNLqVMa73to2XpbrP+r6LaG0HX+Gu9bx5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696385516; x=1696990316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OXsA8XT/Y2XR9Y2D4HLJmfINW7ZoNO0C+742udrdo0w=;
 b=M2MtHxzz7Q0CZqBOx7udtvXQ3DxJvzzOY4xM+hhBjqLNCg6VFV1lokONp3L4gpmhDr
 loEQIJ5ItJQw+enLPQufUtqG0PMVKKW62MC9ZBXeNbBaWFNlsvoY+tv5rW8pVJy9PNFG
 HtsdlVlbhYcPxy76ZhtlR47xY1iBL4xuZQWPS6xQCf2ZIO5T2QlIJqzJ+E37kFUxQ55d
 9D2xV5ldW+U3tKqZCA/Z8dekMKMpl0xSMiiTWQsBh+gAw02Azo1Sc2sxRR+FyyVWns+Y
 LB3RKfE8ZWrR52URtsZAnC364Y4Y8OAJN00KzSSbNS34wk8kCXWl2AIRUm5ye9dgKMvg
 dvtw==
X-Gm-Message-State: AOJu0YxLahz4bZxlMk+jf4xc5nXUj9Ef3UpyXAwVRTUEpjq2DPwRBP7w
 DVncSc6RQ7fjn4GHp5lUSbg60W5NxvdYRQuZ/oDjz/tClLZ3wKyWsXc=
X-Google-Smtp-Source: AGHT+IEvRx3i0Nc4VI/O2csKYjxoE9V45CT6H0VuSeo8j25b/3P6OyxienpFA4+dnmVd3wNhisATeJF6IvOYkaJdGno=
X-Received: by 2002:a5b:4ce:0:b0:d81:6151:2031 with SMTP id
 u14-20020a5b04ce000000b00d8161512031mr779653ybp.61.1696385515898; Tue, 03 Oct
 2023 19:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231003010901.98121-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231003010901.98121-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Oct 2023 20:10:55 -0600
Message-ID: <CAPnjgZ1sAyr4XEgutrt7_max2BzhumvSnKVKP70j-2a+yR570g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] input: avoid NULL dereference
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
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

On Mon, 2 Oct 2023 at 19:09, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Before using the result of env_get("stdin") we must check if it is NULL.
>
> Avoid #if. This resolves the -Wunused-but-set-variable issue and we don't
> need a dummy assignment in the else branch. Anyway this warning is
> disabled in the Makefile.
>
> For sake of readability use an early return after the configuration check.
>
> Checking CONFIG_SPL_BUILD is incorrect as env_get() is only defined if
> CONFIG_$(SPL_TPL)ENV_SUPPORT=y.
>
> Fixes: 985ca3945fa3 ("spl: input: Allow input in SPL and TPL")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         avoid #if
>
> v3:
>         use an early return after configuration check
>         remove CONFIG_SPL_BUILD check
> ---
>  drivers/input/input.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
