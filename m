Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323F7C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E62840D7;
	Fri, 11 Apr 2025 16:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XkTAGAuV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 881AB840D8; Fri, 11 Apr 2025 16:48:59 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5132C84006
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72c27166ab3so1110140a34.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744382935; x=1744987735; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ee5kjb9lTGAV32TcgUJyG9/BlnDM3Zyv8CO1vJihJlo=;
 b=XkTAGAuVjlxvf3ZKn9hgFUbTwHNhLykBjQ4TiQZ8xsyiGXzGx3cQpKkHkdA5foTjp9
 OktYEWvHH8A+ZFQynQ/lT4hJNEyotObMVQc2mK7IU6oy6nWXTl6afT8K68KoZUR+5yhZ
 IwZNnCvqNGLwwU3jWPsOg1ztFd3Q6R6t79zWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744382935; x=1744987735;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ee5kjb9lTGAV32TcgUJyG9/BlnDM3Zyv8CO1vJihJlo=;
 b=v110nJ/cKSTM6NcGHB4jDbeF1hK+VCuXeK2LiC0CYtiowHa1BnJVPHRc/psk/mQmMw
 DbYMZV8UeRR6+v7IwoUgjZOoycWYS6iJcyEZ7dRwGD+OPmVHojYIQUfNS7YCZS7ySHXR
 5rz3a2835MaZz2LJI8cecs81NylnyeDcWf0rohfB6s58FqK9JUavjqFg/n1Tedhkf74z
 MOS/XNJUisGFEuvl9lRRrt1sWlnEcZ4PWrGgwDBI+yVUDI4OZn25fBa46PaZs+8Mb+fS
 ZkQTWk4dCKqTvp9Sstr0Ak0SQXYUwFr+WGqLcY14CIL79ozsvuyj9mOEasT1dqGjgocM
 Ruzg==
X-Gm-Message-State: AOJu0Yxjw1CmqsYrGRsp964Tb7SQCsadAnWPHGEcUpTCtVtaJyQXtvjW
 JDBK6RHq1kiwoYoza2ZnluLKQ3PhHR/CZ0mDhsvxMLpZD020EifEGY2/bF2V7qU=
X-Gm-Gg: ASbGncvjHFvjAU47O+cUp5EoOyb6XCiUdCsD0ufRP7I3F1bz+PzaBqVxxruuElg4s5X
 m0bV3gV3+EApIZRADn9gSVC0lqvKP1avQEbS5c3Hq3DH4p1WqXqhLHElkmRuALuaCfGSI+b/QPY
 1m0lf3uHMVhuBcfmTuwKDUOtr6zqnkRFN4ZuETVq0lIUbRtAiRowonwCMSkTy51GYA8yPmbiSzF
 qepHzAxl63XHhze6zT1L5AzbxK5QT2BznBaF74Ugmos1peor03ftwqig6O9p2oKbKK/638trXZz
 Js9gGOUNiZGuC1PgpRLbWLtOBhzv50t9fyaB2xfhhGXj3D3s2FSjz798fiB47T42QPJ8O+3yq0o
 PKknvF6GdzIc=
X-Google-Smtp-Source: AGHT+IF2ryAcglnaXT/7aTxMBCJ8Q0ufXjKU0tPj4VR4L1S3hUmPPH8vtjRy90EXvsObPHBUOzv46g==
X-Received: by 2002:a05:6808:1512:b0:3fa:4418:67c9 with SMTP id
 5614622812f47-4008508bc17mr1596304b6e.22.1744382935115; 
 Fri, 11 Apr 2025 07:48:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4007639db05sm954732b6e.33.2025.04.11.07.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 07:48:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250325174744.1778691-1-andre.przywara@arm.com>
References: <20250325174744.1778691-1-andre.przywara@arm.com>
Subject: Re: [PATCH] common: console: move break; statement
Message-Id: <174438293408.3201192.10132411544581044573.b4-ty@konsulko.com>
Date: Fri, 11 Apr 2025 08:48:54 -0600
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

On Tue, 25 Mar 2025 17:47:44 +0000, Andre Przywara wrote:

> In console_setfile(), there is some #ifdef'ed code, updating monitor
> functions for a U-Boot proper build. This is called inside a switch/case
> statement, but the closing "break;" is inside the #ifdef section.
> This doesn't look right: we should not fall through to the error case
> for an SPL/TPL build.
> 
> Move the "break" to be always effective, solving a compiler warning about
> an untagged implicit fallthrough.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] common: console: move break; statement
      commit: 82f5ce11e669d86ac08e6ba800d4a97ad734665b
-- 
Tom


