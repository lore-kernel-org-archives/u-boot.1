Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4AEF8D761
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 17:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7846E8421D;
	Thu, 16 Apr 2026 19:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KtXdGqI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0456084222; Thu, 16 Apr 2026 19:37:20 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B55C8421D
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 19:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-671c5eb7fb0so4559506a12.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 10:37:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776361035; cv=none;
 d=google.com; s=arc-20240605;
 b=Vro3q+xB7bZcC88g5tjgqsidAwG5FB0SJTvwuP+IgAqv/478FMIseIF7yg9yGfB7O8
 tCYiCiafRTxKiYBCNgUtdw+b0hoIGO0S8WAp0exXvrgqHktFgQNmn/V4TwL5GJHtVUXi
 Wh7/PLuuNjip/V1MOwIBz/0GGVcgEOj+/ibF7TeWTko9i0jrWPOpwTSuwnosUyywBq9k
 tf/bbY1od3GNB/ZRQOfdvPaATg4UR0Y7eYWy6/uvpXwTHS9lT7BdzEhcv+MawJ5fivZw
 LTi80QAEOSgQk6B6djq28dVYXpPRJslFvMRUWkMzNOZmCb3+sRh6fJUxX4yZLEou3nJ+
 M1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=etALzh/k03WJ2YZi0v53pLNLJ64d/Id7dVYyMtvhZTs=;
 fh=/yPc9P/j5ufpE1JyT0kMiGN7TiTmU/sqveLOrA8l9l8=;
 b=kx8MhnujEjgrYW0v4c/ygdbW3pJsllZCinuEGvZmYW9inhzDav64OXw3VE44aG587r
 Mm1xJAVU0PH/IoNfA3R7y6ldtA8+r/OGHNcRbUzDLqDqqIeLJ6+v4ntbdiiXIcye1jkE
 yt//AA+bhpWZ8xcbjjQfupvSPSEyOrw44s4OP7IuFm7odB0S6Zrf/r2iRWJPs9pkfNOM
 yxUX0BYbBTZ+MPBgPghUpGKXIONr7lLSBHI/tKq9+XW3xCEgJXMN06uwQMwIuGZFmiUE
 7xJevR0Ua/sflsy+qYX4S+hJ5gDqsyyjQHhouits/f2TydsgpQL7Fd3FBOkes+cx2YE1
 xE4Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776361035; x=1776965835; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=etALzh/k03WJ2YZi0v53pLNLJ64d/Id7dVYyMtvhZTs=;
 b=KtXdGqI3y8ARW2TPizsaFrHne7VV8Rj3G4p0J7HQAhKsZlWa7Ht7J+ngDE5x3KBnTi
 wsYfChGcOLdSImt7zImdBuV6W0LyBI8qJYHDfjl3NJ0WMPSbUS7v5UYdq7PrShbqyb9j
 AqBGGqgjIk7Bbdg+uWmm9dyor3LKHNTZO0+Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776361035; x=1776965835;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=etALzh/k03WJ2YZi0v53pLNLJ64d/Id7dVYyMtvhZTs=;
 b=m/Ph1WahXFEjIY9dTFeJ0/bfFcGIezvaxgmUF4rhlYRjE019Rykk4GQM2tRdNOBbw9
 5N9QqHnw/5Hsd5jZDcPTswBGIo3T5BxLhcRITHV3DiEC9YiK5ZomDwoy1v2mtsZ7sll2
 knt2XTtzmQRx8F/P39S7pYkybPc/hL5bo/5ZFnvI9745zIQePduw5ZiWh2OTz/AIREwH
 5htBJh9GhkSl3xywfDzmnxTWfvnIu19tZWRsye0kJbENSsd/JBD8ziFPMo+T/acrZJyL
 ynZfFSwUx+tJf3PEPJcYJFqrFYdpWv4kcuSrR/lhbcM8r2q9baDDd/I5BG4401YpA6c3
 OfJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eni9uSBiVKUHQyoxVYNOmf9jakD5VzdCGyiIuQteicSAbLxrW6ftOQCvd1QEDtP9t6TQAFSo=@lists.denx.de
X-Gm-Message-State: AOJu0YzpR8EQ64Akl5WCk7r4JmEg8I3E6LBYeKkyV+YfTa1QZ8MgdsRu
 najOXhD8UOoH8Hc46tAWNmR0aHrnjaw+ckunMnsSa3jvNkPAN2xRU6VxUMs25L4oWNrDvCsTEoO
 I/GXV/Xg3/pRVxWMstXc39nlxYHDEFPBubmAUnjVr
X-Gm-Gg: AeBDievEbag/ZipM+dmZHMTEOSWBNKRLSgTSmzZ9ZlY5H5cH3P/AZlDmK4oIxlgpR/F
 4B+cBH/HfIIsZXgRH/Vx6JmuFD5uteTzG+OZmWp+QXClFws1uMx7FMMotM1cbxkO/uyGwzwOFCH
 lq/Iel3OkwOs5aBjNUURn5nxprAUOhDR3tU9O717VpqCd3DmsVCbpf7WG9UsQX/E4vLKkmbkOkt
 yhkzshF8LFWHRXJ/jrHCG2hXrgVXG05G3Y+trEeloLxjVn+VNUn/PRP2jM5BIhyEGO1riEkJmCD
 y1nGAhAnlIlDDGdHRM54
X-Received: by 2002:a17:906:5988:b0:b9c:30b8:dcad with SMTP id
 a640c23a62f3a-ba3ddeac44bmr12920066b.34.1776361034763; Thu, 16 Apr 2026
 10:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260408150201.217942-3-paul.henrys_ext@softathome.com>
 <20260414131558.538656-1-yan.wang@softathome.com>
 <20260414131558.538656-2-yan.wang@softathome.com>
In-Reply-To: <20260414131558.538656-2-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 05:37:01 +1200
X-Gm-Features: AQROBzC9jOIuroJZmcWCD44Qa60PTPu-KHqpiRaoLe5SnSiGQIDAw9P5AInGvlY
Message-ID: <CAFLszThK5Tyf3j5fsdFQDOixY9LJmq6=EWZXaMKPzuTSxMg-zg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] binman: Generate preload header and sign data only
 once
To: yan.wang@softathome.com
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com, 
 paul.henrys_ext@softathome.com, u-boot@lists.denx.de
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

On 2026-04-14T13:15:55, Yan WANG <yan.wang@softathome.com> wrote:
> binman: Generate preload header and sign data only once
>
> To optimize preload generation, generate the header and signatures only
> after all data has been collected in ProcessContentsUpdate(). This
> avoids signing the data multiple times.
>
> Since header_size is known upfront (from __init__), create a placeholder
> in ObtainContents() to avoid an extra packing pass when
> ProcessContentsUpdate() detects a size change.
>
> This reduces unnecessary repacking and signing operations.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>
> tools/binman/etype/pre_load.py | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
