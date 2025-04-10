Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE5BC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 22:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF8383E2B;
	Fri, 11 Apr 2025 00:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ulGz+9iY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D9683E1E; Fri, 11 Apr 2025 00:16:08 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EDB083E0E
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 00:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2d0364e9231so350055fac.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744323365; x=1744928165; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQAagmKHdYwvtgAOPhJeSfg9BflxIazW0omBbJFkSlo=;
 b=ulGz+9iYiNXgOUifAKBmminn+4+4hCcByFpy3hn8GqP+JmrCN7SjyUvJo42NVrjOb1
 GnKJc0US7vlWyAGQKsJDkWAapyfodPrCoCdbcJANiZKsms9Vb77omJcyGNc9OHEBw60z
 +34tAR+lbrnZT3l8jNJktjjXED4AhFufW1Kls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744323365; x=1744928165;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQAagmKHdYwvtgAOPhJeSfg9BflxIazW0omBbJFkSlo=;
 b=TnJTlFObILhk8/JQXRVqNO0f6n6IUrk3epfK+kJJId7B480fetI7wZkNZvotuhVPsy
 D5YvtW/C50/BSi857GKn+MgTjn73g1scQEq18NCWZA6SxWw//ZfduuyPugcgl62MvjTL
 qWkxGCojSccl+rLE0Dzdo4abv7puaY5VqPgiIerMeuCq6zysLim59AgKivz8msH5dGp4
 NhgXGPccqcxbhcZxXQSCP2tAKXz+M8ep0+YlAjzObgSIja64MyfjcZMnR9dAeUbDFvkC
 vrC2Pkw7OWxT+nWAb3xEWSZUj7YAGTyunLDgfAspYyA1ghZYOsivBa9NL7V6/GiDO/13
 Jymg==
X-Gm-Message-State: AOJu0YzPoGiE5nRiTkEKw4IU1/e7W1qu3vSRIHbe2ruXUBrTfuwKB2YN
 x/a911dB3YlU+Zi5cduikarsqWvFM5fRxGeO7Bzj2r4HnnTIZyDxmYrU1TDSMX0=
X-Gm-Gg: ASbGncuW+adsW7xqVFRWy0uCC++AZdtZtA0etm0X22OFMVQcCysF07TUym9kGcLaJlq
 ENUE+0Mbtsgnv9UuVW+mGxQHyy+t9cHTiOEAXHHTICA5Lc0fTCo2mVziRqIkKlQNzVrvPgPFe7Z
 Ut9ktPez6HiLrLfowZK1hmhXWC715+HnN3efpwIpk3XjjSM7PYZ625e10KO1ySuiodznsxuBmfE
 z/xR4j86pEJs1Cig9U28mNwkBYxQaGJ0ZzqTg8FnQFzSPYPHLDnW+iynrYHHOJgvBqMRQwz0QlY
 em3Xi4AKvSemAPvXCJU0TDb0Q+eWQcfcRwj1TpCDSW9SV07HtaIYKOvGtYAh+wVFovx92J95ULs
 3YHnnEx2/M8E=
X-Google-Smtp-Source: AGHT+IEfUSKlfh6Wy6eVfUtFQyRtl6i8lkTfrgH1F+ciBh9gMN8svINm7L2mpV8TfiQlekS2EP12hQ==
X-Received: by 2002:a05:6871:50c9:b0:2c2:56f3:1c84 with SMTP id
 586e51a60fabf-2d0d5f35d6emr207155fac.25.1744323364735; 
 Thu, 10 Apr 2025 15:16:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096961127sm838499fac.20.2025.04.10.15.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 15:16:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, bb@ti.com, Santhosh Kumar K <s-k6@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250326121220.1831975-1-s-k6@ti.com>
References: <20250326121220.1831975-1-s-k6@ti.com>
Subject: Re: [PATCH 0/3] Add UBIFS Support
Message-Id: <174432336326.3115550.12054056718983389369.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 16:16:03 -0600
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

On Wed, 26 Mar 2025 17:42:17 +0530, Santhosh Kumar K wrote:

> This series adds support for UBIFS in AM64x, AM62x, AM62Px.
> 
> Test logs: https://gist.github.com/santhosh21/be687f10086fe3b02d76cf5126a99861
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> 
> Santhosh Kumar K (3):
>   configs: am64x: Add UBIFS support
>   configs: am62x: Add UBIFS support
>   configs: am62px: Add UBIFS support
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] configs: am64x: Add UBIFS support
      commit: 11ced9fd7361746509caa5ee7d1fcb8871d43772
[2/3] configs: am62x: Add UBIFS support
      commit: 23e2b6ff8d3cfbdf7f297f52803a6445a5390d94
[3/3] configs: am62px: Add UBIFS support
      commit: a62fc05f44145fcabf30dfc1f218e16637c72a07
-- 
Tom


