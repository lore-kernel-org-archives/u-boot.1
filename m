Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26989C47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF60087899;
	Mon,  1 Jan 2024 17:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="inyTikUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DBAA877DE; Mon,  1 Jan 2024 17:49:36 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB70387889
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-680b8d50403so3441746d6.2
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127771; x=1704732571; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nWeNRffTRzUwaHGTATSlduQ+1M4PjU0QP+1c5giEtVI=;
 b=inyTikURs7np+lq/cJF9Wzw/VFDLRubIfZ6yhkLwRd3Cbqx0n3vMz45F6/SrgXom4k
 ofiYVRdA2OP3ADpazKvWsf+WhAp8WJSbNrZh9E7b8E/umIbKsuCAc6hLB0QKAcFlJXOs
 5P4yIPYQg3fflU2Wn1VpSZybOBCdgYIg8pKm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127771; x=1704732571;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nWeNRffTRzUwaHGTATSlduQ+1M4PjU0QP+1c5giEtVI=;
 b=YUlnt7aW5QpPJrgFd2mlGD3ES93WN44jaJE9v2ckz6tXC9KlVjuOWaB4S3KHiKe068
 sfjARZubVhzi+rB5IDUdUrQ9CktACd8oFyXe0GBxM420/tor4l8cfdWGOsgnE+25vLpt
 taDg1b9hMjz6Ca7kdg9AP0MAXjVb8lpyhQg7y9eXzG5FPjcoHMElI6j+5L+quzQM7qba
 03YpoczFFZtaWV+wvgxZC8vz4Ho1sEQYTr9e/Qd5df7/ulgaF33u1bzRDZwYMUGDYNUT
 W4Dj0eF9biFj9I5kjQsFmIDLIeriNLujN2tI57mjqt2HTY4GObWscBa4rnC+g0JXemOw
 cP3A==
X-Gm-Message-State: AOJu0YyQZm5GHIs7NUhTT6OXrtVF3SwL833rSLs3bNGY/Hu+u8pAB3c1
 mp5c87tGdIKUcZ4V0PlvXBrg2AAB1hzMAeLF8xl4B9BxjHhn
X-Google-Smtp-Source: AGHT+IEmNdn25E2d5TSyugI7LgIeXz08pYtiCBGXoT8mhhnzdGqvynAMgbeMkDi6QbjcCvV7MjSpp6dY3wb1C3hDIDE=
X-Received: by 2002:a05:6214:2cd3:b0:67f:b9cd:48aa with SMTP id
 lf19-20020a0562142cd300b0067fb9cd48aamr15202770qvb.81.1704127771691; Mon, 01
 Jan 2024 08:49:31 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:49:31 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0wDm2CdQ94=9w5Cn8Py5mcYPcm-txZbTp-YO1g+xL-0A@mail.gmail.com>
References: <CAPnjgZ0wDm2CdQ94=9w5Cn8Py5mcYPcm-txZbTp-YO1g+xL-0A@mail.gmail.com>
 <20231215232604.260081-1-heinrich.schuchardt@canonical.com>
Date: Mon, 1 Jan 2024 11:49:31 -0500
X-Google-Sender-Auth: 5V8qnhqMWZfUtOcULpSxdRIiRr4
Message-ID: <CAFLszTiiHSXUpD3m66KU4T-9kr+7TVaY-B2D1U-d2=OHJMEGog@mail.gmail.com>
Subject: Re: [PATCH 1/1] binman: used-before-assignment in ftest.py
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Fri, 15 Dec 2023 at 16:26, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Pytest 7.4.3 complains if a variable is used in a finally clause without
> having been initialized before the try clause.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  tools/binman/ftest.py | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm/next, thanks!
