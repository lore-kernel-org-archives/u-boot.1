Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B87CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 01:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DAFC836D1;
	Fri, 17 Oct 2025 03:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aB3Tn7ji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA2A683710; Fri, 17 Oct 2025 03:24:01 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B348F8367F
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 03:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-646f75551e7so633811eaf.0
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 18:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760664238; x=1761269038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yue9gRwxJge4DvN6MaHW7OHp9C3Mm7iTAqObgz7s3Zw=;
 b=aB3Tn7jis2VKa2uZW55MbV7ivJI4dEri24or5KB3o53aIiZMHw9cKAWlC1SWS3Uood
 jb5x2GAFl1/T3j1Js2x3RX9xG7qazNdw8e8mSwPg4K8lw/0M06UkDtaN06m4yMwqYMB7
 U70orbiuF5Kl+jCCkGDgZ3z5LlfQ3xh8Z1y2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760664238; x=1761269038;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yue9gRwxJge4DvN6MaHW7OHp9C3Mm7iTAqObgz7s3Zw=;
 b=YwgjV5iFVo1SRKqTdeK6ihjyNijLWxI66wj2UJytHs5JDAhHyqNa5oFrLooII2daRb
 kWli51jOkXLXtO5iuezDh0lCTwl02bUU64LmwSiWYqBv1phljNJfCLJ0qePTobnN94x9
 ++PhmECwVEfcwN/98flbOKF22ZWOBY+aswZvIrF3vjeN77tXDhVbHYpXTy++t6C2VQcg
 lO9CqsaZmS1+zNhXGPvzB+Mm0AGBDrizoYVO55YZU7BK3ZlHfx7qB9iwg9e8GYs0F2gB
 /x9s0GN6zJbGwHvkuGTYZp7AX4R8iUR2tvrfzY1GNRyB230Z7TFOXIVdeVLH49cH0xAk
 FAwQ==
X-Gm-Message-State: AOJu0YwyviwAITxBWjfGi7EV/qEpBZS8PMsgxE/Gj9S7x76kdaJiRjRX
 NfZqncmjYtULgqCBHOv/2vq3u/vnFFjoG0iUFZOIPYzo6yaFPdV/xrlCIInBi2xVaF+OfNcnyDo
 F+H7jh5I=
X-Gm-Gg: ASbGncvOMdwVtkl1ZNQZYXlf+49oPnpmLL/1yG7wKYKOcUFti37sc/yO9XxpEDFWV0S
 PzwPT7HeiC/rGG7heEJt/fXUMqhGapSbmKi9wNIiDjv2AiaVoDLbgxF8K6gapzKKiiNQYVvroRd
 2qhxsXO/tCna5jyYRfHR51wGu/HdZvg2LCHkj8u0bgQuaNZZMffl6KtjP5OnSDI5AgVhMHUac5m
 9xIZiwaH5dDR+vgYz6f4SHeS8eELeTaYovH8MVdoNdH58U64Gupq1EYjlNBspEbBBoOC7bEuqXE
 UCQBjezJ2km8XnJY9LC5n+XmXuEGzjfKMJhFyP3X59Ax94T6ABJQQpY/NZD1lWFxDw6opkVK7sI
 bgmbYVBI9Ifcokqwb0o7g7o7WpbYGw+pYeI5fUNq8J2xT1JVBF7fS9eLKYuOsx2it7I24NOyhyy
 kMk3SUbLiPkOK6BBaP9hKQf9BTkqTn7sdt+IyaewIMp33ImUEM
X-Google-Smtp-Source: AGHT+IH3gYwgEGrD7mJYm9OEo1VMlxUnpS252bVamhkUhviuDcb2mKGedvKz6QdNSnGRrygcOiEv7A==
X-Received: by 2002:a05:6808:2112:b0:43f:1b7d:b631 with SMTP id
 5614622812f47-443a30af9femr998347b6e.35.1760664238453; 
 Thu, 16 Oct 2025 18:23:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65018130f87sm5157512eaf.3.2025.10.16.18.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 18:23:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251010220900.1197565-1-trini@konsulko.com>
References: <20251010134330.1094378-1-trini@konsulko.com>
 <20251010220900.1197565-1-trini@konsulko.com>
Subject: Re: [PATCH v2] test/py: Update to a newer pytest release
Message-Id: <176066423677.298873.3037138015940767723.b4-ty@konsulko.com>
Date: Thu, 16 Oct 2025 19:23:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 10 Oct 2025 16:09:00 -0600, Tom Rini wrote:

> Our pytest package was pinned to a release from 2021. The minimum
> compatible with labgrid v25.0.x is pytest 7.0.0. Update to the current
> relase which is currently 8.4.2
> 
> 

Applied to u-boot/master, thanks!

[1/1] test/py: Update to a newer pytest release
      commit: bf1d8c1fec863b7da2f0d1ed4bd5526275d70dc2
-- 
Tom


