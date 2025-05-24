Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22E2C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDEB183483;
	Sat, 24 May 2025 07:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ilQc5yuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 999B083559; Sat, 24 May 2025 07:06:06 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1941834BC
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ad545e74f60so59718966b.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063164; x=1748667964; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=emSQ6c2j1Ux5J6rHEkRCXBEQRtlziERoJjDyRrYutB4=;
 b=ilQc5yuFy315X8zQ4GvkF2Gj55QVqq9dKdbXCCPZEUgtOdoo/kJuDclgW95f4sTNYb
 bsS5Dc9G/Db2gpNtQnOQGTESG1oVB+EGrKHcJUK2kH4zt5YN3geCdiYPwa7sGxd3oFYy
 /2fkFmbnKkNxtRGc3FLeSgYF+hvAm6okYzzyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063164; x=1748667964;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=emSQ6c2j1Ux5J6rHEkRCXBEQRtlziERoJjDyRrYutB4=;
 b=XOyPdVinnp40UQ/giVq53ifa+dt5G8M682VBDDKXC2D7axqEujLEDr0tw8Gnr/h9th
 xTWShyO6o3x+PzsXm422sCP/wqwRz055kX18O43MHZKqJ9innjAJ1lgnFxtEhLe+JeAs
 a8govA9dtBc65K1nlBuG80kJpavC9EhOajxuNGUbDx2XXSP+nzxhDTC1/TsIYRXA2Ayt
 BtsFnkL5AVZH5xj88bMBTVJbOGFm8hAc2+rkMRXZ5SfVafoX7YLnnFBEYXtmT4gkkcVU
 p5T2xz6PRwk2QK+Uc9thtOWrBaa50ZeHZHVLN6QOLTZnvPPRHZQ47HjVZKvzSv83PT+n
 hfew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIo/iGshY45T9UbmWnBTdSlLjXrBRnWr/Tnw2PW7lVNhsHfr1wUZHx2bhsHhmhW4UOsADltwo=@lists.denx.de
X-Gm-Message-State: AOJu0YxYVtGep4Yeb8a/O9iC1dRDWgJmPeY5EjKJdZpHIO2L17+6TeeR
 wxndKukGb+dqoC9ZGNhs478dsvdFj6hWFbUOezro0WDBMddHly1MXYqEfM3Eoc5KBoXQgK3t6dA
 AGLNO5nYFoAqeL6T0zF5n7rx4F9fyTUohPa41o1jRUGBx42Tu4fs23KRu
X-Gm-Gg: ASbGncs2CNs+mx5Hgzh76fCXsD/NwroPdyu65vKocTWx7SIxiRdD2C6WBT/WUDOv5DM
 x2/0W4yGpFiIsm0dDii6zW+7MpustG8pgr97EAwlrz60kL0sJlyr+lV+1u4a4kiRrR+2uaIjE0Z
 jVSkF/FAt1f9JDyedGFzVFh76jP5xWWzk=
X-Google-Smtp-Source: AGHT+IFQJT5/Hf1zShZ5V1Rlv/7vDyvsfL6LM42vfU3p2+gAY2NXsuF6IrQacTCj7eW2h/tbRaPvYMSzZpJExPF54lw=
X-Received: by 2002:a17:906:478b:b0:aca:b72b:4576 with SMTP id
 a640c23a62f3a-ad85b1ce893mr133978866b.33.1748063164157; Fri, 23 May 2025
 22:06:04 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:02 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:02 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-16-sjg@chromium.org>
References: <20250510110535.1453745-16-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:06:02 -0500
X-Google-Sender-Auth: I6i1lJhlyafT1G9zj8hONx1yC4c
X-Gm-Features: AX0GCFuLK0s-mWJffwRyBqvP3keME_T-m1aNckVYUzjUW7Ixps724xPQ1oMTrD4
Message-ID: <CAFLszTjoz1+xEc2SpN0EOHQ_-TAREuVXAQVu3gmhZmJGyOBgJQ@mail.gmail.com>
Subject: Re: [PATCH 15/25] patman: Use -c to show patch comments
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

We chose -C as the flag to enable showing comments because -c was used
in 'patman send' to specify the patch count. Now that the 'send' parser
is separated we don't need to do this and it is OK to use the same flag
in a different subcommand.

We want to have a flag for cover-letter comments, so it makes most sense
to have -C for that and -c for patch comments. Update the latter.

Put this in a function since the new 'series' command will add this flag
too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Applied to sjg/master, thanks!
