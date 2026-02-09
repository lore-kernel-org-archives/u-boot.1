Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB53EE94606
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 20:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A0E8388D;
	Mon,  9 Feb 2026 21:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j7xMttsW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23208388D; Mon,  9 Feb 2026 21:41:58 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86F5480325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 21:41:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7d1866473b0so2820182a34.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 12:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770669715; x=1771274515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5QAVyG3e8yrh/PStDf7fANzCGjyQQH9/plVOFsR3+GQ=;
 b=j7xMttsWhmGqovx5GB3MONYHfVQP1O+gPTDYFWz3CRcr45me06YqzToIF8KJlJgE+r
 2tdlvpkDIOLtE8Ja4Me/WBBKLimeE+nfkFPooeegUEn0Q8bpq+l5UQ+nt02LxvgqFP3f
 vEk1E4pRjkHAm0ICtfXgc2SGEZxmIYmz+hqwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770669715; x=1771274515;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5QAVyG3e8yrh/PStDf7fANzCGjyQQH9/plVOFsR3+GQ=;
 b=CSphFOJaumsnu0SBfJT8wu2O7gKYv4SLq1YgMeV32QVGGbWTSKmxafAHPfWEb+1THm
 p/LES2E4zsaE4V9Lrcu2JelbVQ4ynEspomHfjXFBHi9P43NoK443Y6tg4BsvAlJLmXXl
 yP5SuLgdTGM9KSxajRsRrJ5kqscbmRFV9Q6B2dFbleSjBTLlaIgLhmq5WtXReDluEvPM
 ne9CQsnwivmXqMy8l2vP+pIv+PmZht1t1yhNcIFF2c+5ypdq40j0rXBP9x5LPXmNuXb1
 aPbkP5EKP65i5c0/uGlxnKqjjUcEzAUUVE5xaQda3xCI/M56URlJ+1s561XV8+f+rQ7k
 1DIg==
X-Gm-Message-State: AOJu0YyGP8W2hR62PgLP0gX0TWWdwHZuf1bXPDkDbrrFtzPX21GLswhR
 AFiHNBsBbJM6qYER1sW1v7i3TPsZpD3U+LGF0NXgU2haYUg8YvPpYpsGJwsSvjqQcI8=
X-Gm-Gg: AZuq6aIUVAtKXTitI9NyCauzwhSocrbT6/GzTJRmjZHHcE7EvrpW9y6/LIMC7DReBxT
 PC/5ML1Abs1LvNYPh0z5tWg+nX2dIpdoL3FGjBqkDTPt6XtJop8ZVJ5vFf96vAPMg5BHxnc6Vt3
 wTmUFvqYvWQilNGfp7aD1D2Dia7o53HV8zDe+DRXOu60kLOEWqZ5R0pAuwZFjowedmwTVuYf7rL
 ndIvQsYjoz0Cz5nVfWKlQnKTf8YQTpZ6UWZ/S2whhUs1M1Vn6ywQEoLK8UCJrFNbd7cXzgaiq1b
 pVkxMyYVbnr+CQufSJGBYVAnD9BMlzOHynfUNTOvwcB3F/ZFvH4/RthiB/bqVgmsdOmZCY2fhjK
 wt7/0BYQMMbhBIH1eoipT51n3C9+Baue+nMQUZobhU3FaB3oYFzTJ+c2BERm10xIYJHU8JKAN8r
 43CyFBj5w1jWTF6CH7lYmwnFGfbs9/ugY9Eo1Il6Hj5FSHyOkKdlXYKByP2gJ5oCu/2TyBeA4ii
 coqSEpKLQJWWA8TLsCedx6I42O54NUohFNJwQ==
X-Received: by 2002:a05:6830:a8f:b0:7c6:e92f:41cc with SMTP id
 46e09a7af769-7d464467050mr6668205a34.21.1770669715183; 
 Mon, 09 Feb 2026 12:41:55 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d46479b9cesm7875341a34.24.2026.02.09.12.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 12:41:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.denx.de, nd@arm.com
In-Reply-To: <772a6779-699b-48ea-8eed-6ebc9c4eafbc@arm.com>
References: <772a6779-699b-48ea-8eed-6ebc9c4eafbc@arm.com>
Subject: Re: Please pull net-20260209
Message-Id: <177066971457.2412163.6067728689732943011.b4-ty@konsulko.com>
Date: Mon, 09 Feb 2026 14:41:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 09 Feb 2026 09:37:43 +0100, Jerome Forissier wrote:

> The following changes since commit b5213bbfdcb1812be510427857827ee8becb9f8f:
> 
>   video: menu "TrueType Fonts" depends on TrueType enabled (2026-02-04 10:41:48 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20260209
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


