Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AF5CD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 20:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C56768483C;
	Wed, 20 May 2026 22:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C70O4tS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CADE84843; Wed, 20 May 2026 22:42:44 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B22F484836
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 22:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bd4d7f4fa02so949741066b.3
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 13:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779309762; cv=none;
 d=google.com; s=arc-20240605;
 b=atDdM+86rrvq3YSCnm7ieLhH0S54zPZAQuYzWA6e+ezgDTWzXeCxCYs9DvJ/OuR0SX
 IKub5hDYQqBVYSyVgfcCftpdXcKGcR+wPqa6c/FWxZGoP5K3y5ymGZ1xLoTJ66JOxWGD
 hcqrTjwtSWa0Zmm3AqHuLUkkGAUGRuKwR2VXl1kI9vSD8H7I9PlNevWGzQRhiWVs/S85
 +gJvYNV63iHjha5ZwdY/Nu9c/4LHlwpLBD6ZOznEsBJDON9smyrtP9HnzkqcJb0yl4Fj
 buT/vj2de3jhMHeVyODGyU7OqzkyeFjm7RHOVNEwOLQeRfWrKac3NKWPtfsWDFCfwXli
 gs4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8U8EE6Gwhj9Tmv80WlnJkt6UahKZx4YBQTHExbk2/z4=;
 fh=ArXY5PHbD/XKcaqe+MRjaoC6vXOBNIouUbVIy7al9r8=;
 b=ka9iMo3Hrbq6QDBKqDQWhcXbdSdCJdN9r9KApshQhAl1+7ae9aEf/o+kUf4mOQl0BU
 GM/UjB+UUNlhX0ZYUjw5ggkwzAoyR4GqXJEZETpHjh6E1cwI2q8w8SZTm3ffzCVSuCEu
 sm06cZCF98QVBgH/k3rvJThEuqtTdHiZ3uX6KQvII7vpi9tBVcmUSI0MKffxb5sIZX8X
 PQI2Yu0ZFhqMsokvytheTNXV++WY3etbLIjnyCZYc93qt7Rqzu7pSeGMJp3WPVUeTgYk
 SHknDhfJ2LBsEuKnEEs+Jn7MxnUzqvbJslCezcsR+trA41t3kgRiPxvUNEVaHiE+NMNX
 yAVw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779309762; x=1779914562; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8U8EE6Gwhj9Tmv80WlnJkt6UahKZx4YBQTHExbk2/z4=;
 b=C70O4tS0EnEYJe122zCagF0AbHLtY1O8+GTm8zrUe20GfMCQlGocdz09fIPR6svtUR
 T6WOvP3ngEWgJs7VXLHmbn7Sd2cL7w7ZinnVTxU5qZyLCF9u2FYt8N/Sr1LxrlcmqoUc
 wChLuqk18EYCkzZscmedh6KHtPSMEJbJg7l3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779309762; x=1779914562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8U8EE6Gwhj9Tmv80WlnJkt6UahKZx4YBQTHExbk2/z4=;
 b=rjhH6wuuLXhNGySDc6r3Kpk8hbVO+5n7TUq0P1n65rVpElVSfIubgtdKRkx6xkIT9+
 cmCm5MkbapiDQNfkaIvfp/x87qWOk2Iq0r2OWvu5gcq4fpYqJggdn14hX9tiM3ii29eu
 u/yWXQbR68TRtOqf0vCxaeNpW+O9V4Ytiydi4yWSsAILqdTs71KFxr2Fa5z/ovAVjfhI
 JpFKWDgyaYSHOuD+5hlQGJamBnlnaDDeCrGCONgkvruiIhMbeYLtnyffDC+uK9/KCAl2
 SUxnTQJ/PqTkXtiSQfxrNNLtu9NNSa5sRRqpGLRPFfU96m/k9YeRe5gxjZQfA930I4Uo
 NHlw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3KjnJiiNscDLIn6rIK1jeLTOoEwnNwxT94yrTloy9vNnuQdSaZ2x6bTWaLi05Dz6V/d4zbIw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0Bugt1vaKFXndR1aJ68KCUBjJLUOnzFAXf2TAdfAv+qERdPAC
 LlVwFiO3ORjSyuUilSTe3QCSaYJX+qk2BKJvZGv8X9bm3vPEiQz0T4tM2qkqr818+ROvF1K6FDi
 VB0B8ww8KMhOQTu9DAOgffc33MVC8qZg0+vZ6xpFa71F2ldAPWvmBIs4b
X-Gm-Gg: Acq92OGG16P35Y891J+797x32fhI2k/RHQyo52qG8Bhr+V0zlWTf3ata/QPW5mBWtVN
 RbrN/JgyEWpJrID45jVHv6p+l9VU38YwYlIzylzgVjXBRBx2SzCjcduOUYeSJ6Z4X/DZhlAhWKf
 YWKl9g78o+C/1jL/ZeudQkPb2W52WsJQqmwuC8wW29s/wuYqxSw0rRpe99BWSuduJ77sooAstM4
 rsUIIh9dQlqBTlWMV8Zvyj28HNj5NugVIJ0VzEnGhAGosu/3A3wprLJaiTyDiR7+W83jmySS02C
 SAs2Gw==
X-Received: by 2002:a17:907:97d2:b0:ba6:e18f:1568 with SMTP id
 a640c23a62f3a-bd51797076dmr1429892366b.32.1779309762118; Wed, 20 May 2026
 13:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260516183700.7037-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260516183700.7037-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 May 2026 15:42:30 -0500
X-Gm-Features: AVHnY4LeecoEeynuQdZa7xUzc1NCQRbslI0J3_B0AHklJvKouZ5n5pc47t37VuI
Message-ID: <CAFLszTgL-brhHOzCe=JJUgHcp1jVxUA9nLUD+PGbA07e4quaLQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: fat: fix seconds in timestamp
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Daniel Palmer <daniel@thingy.jp>, u-boot@lists.denx.de
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

On 2026-05-16T18:37:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> fs: fat: fix seconds in timestamp
>
> The FAT time format stores seconds/2 in bits 4:0. The expression
> 'tm.tm_sec > 1' is a boolean comparison (yields 0 or 1) where a
> right-shift 'tm.tm_sec >> 1' was intended.  As a result every
> file timestamp written by U-Boot has its seconds field set to
> either 0 or 1, depending on whether tm_sec is greater than 1.
>
> Also fix the indentation of the tm_hour line.
>
> Fixes: ba23c378c544 ("fs: fat: fill creation and change date")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> fs/fat/fat_write.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
