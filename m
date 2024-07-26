Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674DBC3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 12:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB8FE885CF;
	Fri, 26 Jul 2024 14:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DfZbNKlq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B39DF88614; Fri, 26 Jul 2024 14:59:02 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A24DF87B84
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5d437791affso575602eaf.0
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998739; x=1722603539; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=peqOv4DsegRKQKv6GGF/Y5AQyXthUv1vPDh9KvYHfNE=;
 b=DfZbNKlqr20/+nxUIVD8fP9vnOVZk2aG3f+1RuudQnXt0eeLhUeWexYFSBryj683Jd
 iN86xZhS6xake64zplJgOJBu/Assh5AMjLFc1FgkyqOfV6d/Wby7PMmaAXmI16lAbtI8
 KLPwUw8C8qPK7nBWfG4ILDXKQX8jlBlRdQvUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998739; x=1722603539;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=peqOv4DsegRKQKv6GGF/Y5AQyXthUv1vPDh9KvYHfNE=;
 b=rqOw7MObH4O4nzVgyVwHN5tduA658Webet1S21hdR0QdyA3S46azQPWfisayy3jQnA
 GE+YMosy+RZBJX8rYN6O/VBlgAr+3Ji1a9SO2fHWkVg/fV++3CGtkXQPWWtsakLo+/3G
 4qUa6X6A0XWOz2ZPM/fv4ZUHlydfZv1E5/qdj/ZYePetS34w+Zzr4rv2qm2usI0qIj6l
 bVvGKatIaCK4ZjnkZcApU0HHp2zN5AYy39HpyTOuGSOObnc1NcaOpIClxnm8K5VmhzO3
 EWNxul8AcoaKuFpZ4LL+1wnXefHPcgGCX04x7tbsydcWKFZYHjoRv9xF8GmDaB373mXh
 XWHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB8kvOMLk4C+oAL0HjXRolXY1DjAm9raRvANYm43XZ7iJX8Gvd97gje7O7rmahtq/SvjoiQkhe/O7ZkQg0DukuJXZT4w==
X-Gm-Message-State: AOJu0YzGkAixn1Ofp9uTQOaW0dCWYkrs5jB8iKl59mKYAajHHt3jF4VG
 dD3fFinH2ChOB2vI5PI00LnnQNvuarrqK2M9PEvTzS47jYFZd9gP3HVMZZ7hFRVHsQ2MdF2O1C2
 Vof9f78RFvcH6slQF0y+9md21EQCzm0H2+QID
X-Google-Smtp-Source: AGHT+IHr2tY/t4AUbfId6p1tOXAKLszBnPfvYo294mc5wDVF+iYrIMNj+DlAKqOE8Bgb4/Vl+vZcszs4k2dg39I4L5A=
X-Received: by 2002:a05:6358:3417:b0:1a1:c19f:403a with SMTP id
 e5c5f4694b2df-1acfb8f1836mr538442855d.17.1721998739226; Fri, 26 Jul 2024
 05:58:59 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:58:57 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-19-sjg@chromium.org>
References: <20240717155712.2913651-19-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:58:57 -0700
X-Google-Sender-Auth: zfPsNoGboIHERIr_fDQAper_P64
Message-ID: <CAFLszThsJOu36Kzr0n0t08n82patrdzQcJYX4AV-71of-kgNRw@mail.gmail.com>
Subject: Re: [PATCH 18/24] qconfig: Move commit code into a separate function
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Reduce the size of main() by putting this code into its own function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

Applied to u-boot-dm, thanks!
