Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BB8CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 13:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27E2584874;
	Thu, 18 Jun 2026 15:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HLBmfkyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F2684995; Thu, 18 Jun 2026 15:22:37 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EC3F847C3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 15:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-69583ca0499so1404059a12.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 06:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781788954; cv=none;
 d=google.com; s=arc-20240605;
 b=Givv0ZPktL3bqCw7CbqjQdMvS2kQ5M4mmiNhRCWq/W3Yq9HzFsB1ibDNi46IloR8im
 TlbR40l6jufDupkc7K1zZVmgX7Nve0xW7kZyoB9VgiYs5bX8wpGREKZHzcJC+75qeIlR
 3xpceR62tocCC4IsugrzIEktRlxoyPs01Ki1ylJGQdTygejtlCFS/jno8uplaW0klxd+
 Bhn3lguqRCXHUwdXLBgA1dPysA5QD3MLOj5oeX6ZCbh5gf6K50Nu4+PBbkSor0+Zh2JV
 9h+QI5jDnMWApsYjslyuULaudH7WgbI93gSfAtx723DGVuBEsWP305AnOmRS+Tf7OQMq
 9g3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p4SmV8EQXWIMzXHorb3uCbgcaHl7po98wq82ItvLgBk=;
 fh=5TbwoxwY4MjuQBftzxUXoZSVx8YQnV4DW51bXH07xUM=;
 b=KaXl5I1cIvDp4+59bQVSr4jkxxd/VxmaniabHPf0jQIg2sZY1NhEx9ygcIZXl7xlI+
 MkEh/3zo+5S5wZP5wd8QoLeDXts2mTB58IR6oDlv9D4OBlVQrmAHfnF8nIczJpmFZ44m
 NZzo5wP20kLKifSglq0ysJ+mjHN9hxIQTdpJGMdkSjCFZQqctE3MA4MEfmlsor0R1BgM
 6+iF3F8tT8VzS0UUZgybtViTD1R2TGhKKPjQujs7ZyHbdfn8w7JUaD9pXPanJmGprHfY
 QD80C3kPPO0By7kiC9Vjheuh12c+w9a1FXN7M9TJ0qjbgS5U2ojo9jWl8zRUcTTNYVGT
 ilZQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781788954; x=1782393754; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p4SmV8EQXWIMzXHorb3uCbgcaHl7po98wq82ItvLgBk=;
 b=HLBmfkyWo/IOOl3inNgf4O2kFwxcRkbC0fNy8V4kSP5P9om/yhEExEodBIhc8oS9ZK
 mjfB/ChM3z+foj12hHd1mbl90gjqpXxZNz2d/yVJLVXw9rqOpGpu2PahXySOwbd0qmmZ
 dpEe6KszQezu4MKf5T25LWi7UaWx24uoliIEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781788954; x=1782393754;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4SmV8EQXWIMzXHorb3uCbgcaHl7po98wq82ItvLgBk=;
 b=OiLSWh7TIvkBZbsfD3oFWfUednkLd94HSRT2jRubuW55ia73x06trumm+yaOGfAME9
 VWcUuZ4dqWYHFIIoWcWidilG7uOzhwq1RvR9sTe+Q99NY5v9+CBkiAQEwRGbCfjW3qPm
 lsL5uZ4DynpEMmBvwQGoS31LNq/ZXw3qLZHxX4caF79iVpekgy8zUbzff1OiDWJv1VH+
 /aX9AUngIVrMdlgPyrFuxnMsBTLHVhUSIfhrVWxsKdid9KqOY9sA6KAInux5hNX5CqB/
 2o6C3lhp5QNVA5kOiWQm6xh4EeN4ZBZg4o532WbHmPIrH1XLbTQu1j9iAOyy+XXutNCu
 2JAw==
X-Gm-Message-State: AOJu0YxIVldV1VdaNkzfOQEADjUU6GP89m5Srjt8GxZH2kocNIouAhSo
 d4hqm7nRJCPN9l1q/lsEwkoKWh9zEWMOYXdd2xmo/pvrTawr47HabYqUD9wJS6So+Lmma41goFN
 raZ3ndyR8w/WA/0IK/Qw37fngw+v6WoLPC2tmBwtK4T8MIXtktTPYDA==
X-Gm-Gg: AfdE7ckiM2i14unKg2VtNzDH6+n7Bz6607iQw/5s5RH9G5fzxHo3thtSHnTQ0gxANz/
 LG4NQ422ZQhAQh2CXHJUutnsQ9FwgaYDoDQVcPx1yaSHYqSnw94u2QhYoD0ild7twtwdiNcbYsf
 AiHrEaXdgjI8XJrwTvZcE243+64C9Si4szE3th2ykNXV7rD5e8e7VQH5a+CcM1yDiHrgYcYhPLp
 ATxelLGRv3SL7sRdgzRHGuSvomESUhIzZI02RDk+yNrSyWexFWGQuyiUAL93TGtdVHlLWnocw==
X-Received: by 2002:a17:907:984:b0:bf9:cc72:6e05 with SMTP id
 a640c23a62f3a-c05d2809783mr525916666b.25.1781788954439; Thu, 18 Jun 2026
 06:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260617131204.3737198-1-rv@rasmusvillemoes.dk>
In-Reply-To: <20260617131204.3737198-1-rv@rasmusvillemoes.dk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 14:22:20 +0100
X-Gm-Features: AVVi8Cem-4GLJMhLj8Hu3U3SOfnoszc1nsIXVHc5PC59-KtG0EiBfbuPiwJEqPA
Message-ID: <CAFLszThs_KPKUn3tvZPAZMwE8C3Qxk9aere6F8EQ9aNGc0=NRA@mail.gmail.com>
Subject: Re: [PATCH] Makefile.lib: remove stale migrate_xxx logic from fdtgrep
 logic
To: rv@rasmusvillemoes.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On 2026-06-17T13:12:04, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> Makefile.lib: remove stale migrate_xxx logic from fdtgrep logic
>
> Commit 6d04828b452 ("dm: Remove pre-schema tag support") removed the
> definitions of these migrate_xxx variables, but left behind their use
> in the fdtgrep rule, which now makes that somewhat hard to understand.
>
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>
> scripts/Makefile.lib | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
