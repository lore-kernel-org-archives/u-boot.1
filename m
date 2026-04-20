Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC864EA71B5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63876842E7;
	Mon, 20 Apr 2026 04:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e9gNeuhv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E393842E7; Mon, 20 Apr 2026 04:13:34 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1601583BC8
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2b25cf1b5f0so14473645ad.3
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776651210; cv=none;
 d=google.com; s=arc-20240605;
 b=GUwMeec4OyM0a9XroJmeSchZLgOrh1lYyhwHy3e7qs4r8nI1iOHIYvN46IEmA5MZtv
 Amqzr+gn6c/AT3dEwJ1Zdz9c+2SIZAVYvv/Yedpi6oGreK3FqxNvJPxdNp5l43i+HmnF
 eiAl2RgnKLvzvlYedprH/ybw2kdYYLn0uK7CirPew4ZLTnrfdwsBYiL8PSRmMT8G0xkx
 gFzms0QA7HudPXlnu4x9ZJxgyCB2EFDbO603voUAOD38azP4ka+v82DS5/qt3tEplIFz
 JHo9mZTa9znfQHlAD2Z8iWlgq23stx4oHSqEugez67BRy1eclWoGw435DLAy/Wuer6e1
 i7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=x6OTa1/OAPvemAy5gvqSiNxuENbBixG7ta7G+B7xKcw=;
 fh=cYPNPW62ZtpubGVbdXxT2ZbTqj7KJRUp3ONAIYi7Y+0=;
 b=cndDXL3p2rur0P+/StvvRIXmVl5Pmvr6IitC4ra2IGwS6sZyUiVskxEIf4seU0dQkt
 zq3emOcAOd2T+WXhflygsXufhNDhamvlCSGqJhexeKu8Yjazk/Tgz7yaPwNRtehAy6t+
 ckH8F+hvyP/tAVR3KsnC9NO40w1lQNCE8xzW3bJ2+Fh7g1eMhe0YiqsedxgJaoArZ2DG
 ZoAp62+ZF8XU4XUr4VZE56ynC3niw4WpVkl16R+qj39KLx8I15a2+iI2Qn2WV8YuusrB
 Yp741KWwQabyw2bc1/xaSSpGtUc2P4ytC6PHFyeQ502yAXeMPw6pI0S4+ft5Tioao61U
 I3yg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776651210; x=1777256010; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x6OTa1/OAPvemAy5gvqSiNxuENbBixG7ta7G+B7xKcw=;
 b=e9gNeuhvcVGL8gicFJJPtwbTn54ur3NaEFmqhspA8Aq76eOafDOqh7tRbSQKna5t1C
 Fb9oPWbDrFwGELvWaz9A25cFdFUAiNUTTCTHRM2VHITDJkRPaWWZSNL0uPCwum2X2aIb
 ryJJL4/NZk54oUDj68Bw9ruhAW+zUjW/Ja+VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776651210; x=1777256010;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6OTa1/OAPvemAy5gvqSiNxuENbBixG7ta7G+B7xKcw=;
 b=bivfsqnGvmgAGdOtd6eh8o7K6ZuEytlj8TR6jJD0JjApKjctqELI7WgGr7QOH0EL6z
 uhfqEGSCHqYdLolZfknp0guujILoAi9EGZyyUDujLUMFV7cQ2WaXZm7JegoRjmD9Jp8P
 3z5WBNPURPRI6Cj0oKTOAnAmliV+DOYQPoiZ1KBVNqcCYOocmboFQTdeiUb5hN06QzXv
 ajiRpZG3ImAycoV395k0JunQBd3V8+01mRod0cDpRHDAJY6nKWqBMPkcrTeRTyy1gqyD
 HAPiPeNpIL1VCXsJrOJekqOUV821EPuYDnhZNOhA3F7klFLIEbUvm7SeBJyNxSdN+Anp
 QzkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9IHzn5aCJh4+JnC1O5+i0f8o+0IHOTI71E0JnlK5NOKoCwzPQtl8JcG97HDXdYI/z6pRnQg3k=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0ytq/ZHTWhlq9dZwkDy/qLui1YU61VOyLI5uzfK7lOSTlxWvw
 CN6CoENHn+cP0WqUIQsgts1DJhWrmtNAZF/t9HR1i9AFARSeLSlo0r+ktCSqGsyk3CT2pk+iYTY
 8wSxf2c5kwiVwD9wU2KXFzKeLVr15eAMyVjAYN8OvEnmOs3F/GMNoIg==
X-Gm-Gg: AeBDieunUGtoo01bZYMuhZQ0sup6TC2tMESP801kc91ukfmYZdMHgcBMXMyw1Ayg2oG
 Dtyid4y+w2rGQnX8FX5HN3eNGM8BkTq+YteQEHxBDcUTRjphF/UavdrzZiArev5tTuHaVlF4VQr
 0HnX7CIrqXi8NZ56dzhula0C4SB4YI5+b2hicmfXpwtQXmBKfYizI9xCRNx123tJlCJuXaen7CC
 Q47mGHveK61swAw9cZpPRZLb8wnWk9Jlo2npswie4gdMDlByxUtfym/vZb7UAagJmOFsp5ElVgM
 dAKHwkMgeIc9ilxGK5Lf
X-Received: by 2002:a17:902:db0d:b0:2b2:4fe3:7b89 with SMTP id
 d9443c01a7336-2b5f9f52879mr112233285ad.38.1776651210520; Sun, 19 Apr 2026
 19:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
 <20260417130204.49896-13-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-13-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:12:41 +1200
X-Gm-Features: AQROBzCNrNb1LPDNL6b14tYnD24uqymil6ER8YmihBCXgACCeliQMTCB5vcT7JM
Message-ID: <CAFLszTiBscZPVs93mT8qXG1rt=vYxwohSKaPjctx+vVC0VjZEA@mail.gmail.com>
Subject: Re: [PATCH v4 12/14] tools: preload_check_sign: add support of ecdsa
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-04-17T13:02:04, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> tools: preload_check_sign: add support of ecdsa
>
> right now, the tool preload_check_sign may only
> checks an image with a pre-load header with rsa.
> We add the support of pre-load header with ecdsa.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> tools/preload_check_sign.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

> diff --git a/tools/preload_check_sign.c b/tools/preload_check_sign.c
> @@ -8,6 +8,9 @@
> +#define OPENSSL_API_COMPAT 0x10101000L
> +
> #include <stdio.h>

This patch uses EC_KEY, EC_GROUP etc. so can you add <openssl/ec.h> ?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
