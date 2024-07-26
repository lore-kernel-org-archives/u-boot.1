Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFB4C3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD70B88646;
	Fri, 26 Jul 2024 14:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RcjFqZeX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A2D7885B6; Fri, 26 Jul 2024 14:59:08 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDEB38861A
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b79b93a4c9so5219346d6.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998745; x=1722603545; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZG6Pc/z/blE97ROowyNzLt50JTa+VBFuOmUX2kjvsqk=;
 b=RcjFqZeX7tfu3zIp0YgL9a5zxOopIa22cEHjAtxHxl2+M+YAd9XrlaM1obLpDOiJX7
 Epki34D09o9P1XAxfDuvzbDDpNulcz4Y9cGkeQBjyu7LNawpslP7vDayEf8afrXYkqum
 wlhvNI0A6ojQ61OR7ZZHnEowGIbC3SqVYl5lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998745; x=1722603545;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZG6Pc/z/blE97ROowyNzLt50JTa+VBFuOmUX2kjvsqk=;
 b=ay9ELzRY6gJpT1XiXnzSpqWe87ZpZfZyNVWM/WjJn3DaBUfvq9evi6ovFD58L83CGY
 aYZnTd0w6k7btbKWCrvR7R+3Fl4JmUnD2dIPxyCoUbSkq4F15NBoxiXLWP538IW+QDZg
 Soe8gNmd0vflXeMcBoYJ0Iypl0DM0AC7F/veaHS7W/xrpUxz4O5L1lVddvq2eGSgXkuW
 wKM9U9rgZ19cxT1y/bm7plTwkuFxxY1paq3Q+tqrLKVeqHdZMvZGROW1mbV5b9cRjw1w
 70Zt8z+MO0u/mIkoNURrXZbzdijyJNsztP+jMmDFPvflBFJpJXM0c9m1YzAEdHahtLaS
 lStQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtfXUdQgp+6Ahw1mQk1SszzX4JoW8Qnz6XbK4PlDIPKTP2FvgR72EIQKogXH3bcc4CWzyCrbLklBTmFR8UZqQbXRWmag==
X-Gm-Message-State: AOJu0Yyk9b9maTnElrwelnN9NAQqQeDikIMQ2vAdQbBPq60Gos1X3YbI
 kWslrB1ZefrQUCiIRazRLcBJSDZv8f6LtalZjWMc9nuUD2nj5VP7fjDEfMW2YzKdWSG0pKwFTuy
 5ZQ0pOJSDtphZYrOrIugq20Bh0k6/qZIRyf3romvwsUKf+h4=
X-Google-Smtp-Source: AGHT+IF8ut+6Y3u2rtIks/gLI7qX+i6JJZgXIYTKpKOUFXMBZIWPY+nDEakcBbxQfd0Al14k61rUj7K18RGdbe5QOsc=
X-Received: by 2002:a05:6214:c8b:b0:6b2:a333:2a9f with SMTP id
 6a1803df08f44-6bb3c97d3d9mr114310866d6.23.1721998744728; Fri, 26 Jul 2024
 05:59:04 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:03 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-15-sjg@chromium.org>
References: <20240717155712.2913651-15-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:03 -0700
X-Google-Sender-Auth: F4rr5Qeh0ivz9U3o02KIRkVY7X0
Message-ID: <CAFLszTjrvHQm0i2hjj0-JE+scAs6xxzwFaPd=Z42E2oWaXw72A@mail.gmail.com>
Subject: Re: [PATCH 14/24] qconfig: Add a return value to do_scan_source()
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

Return an exit code so we can use this function like do_tests().
Refactor the caller to handle this.

Reduce the size of main() by putting this code into its own function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Applied to u-boot-dm, thanks!
