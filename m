Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC29C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E74F0832A4;
	Fri, 23 May 2025 15:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ev/1hOyX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3647C83108; Fri, 23 May 2025 15:18:32 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56083830B4
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6023cf146d3so6143887a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006310; x=1748611110; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GdRkvkuixT2ZZUaP4vuE78w3uRGB4mY9xwAzZ5fwrO8=;
 b=ev/1hOyXDDNOQEcSA/DRKbgkzXVK7ae5yj05mSi2GKEBzyr7WMqQYFJ9IRg8ay8xku
 ROyCFLOUG4qTKWXLwD89B26B/HvJ7EVv3izzRcVplFOMBkE5wT9JuRsAS7Epi2oXbwgM
 BV8JId0btZIJAy8Qpb0F6DFXtZdAh4ZbYbnrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006310; x=1748611110;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GdRkvkuixT2ZZUaP4vuE78w3uRGB4mY9xwAzZ5fwrO8=;
 b=mohjN5F+ZbGunIsOrA1Z94RsvSmqolZA2GfSsw+nnWsYfRa+4uBiGhtHJ001Elhyzz
 rW0wtCE+7e/um4BQ9RXyQ2eLYBIZ7yoJQlgXM9l/rNoaq4zpokjWgF7RD8lQSyz88nb8
 t0CUobUOZbTg2fdaNQUXHEkFNVpuHZDMZYyZcpZsv+yFWKGFt94ETN4IQoulEfdx7Ske
 /rSGek92F+s3B+nYVIGrET8i+Rmfk7MCmy1ptxeXt1Am0S46aMtE1lR0JMIzMdTvWoap
 QQBhTJtMyE+b9zz4EKagivv59o7rAE9Ch6j1omTmZZiteP5c/WyBFa16Z/QWh0EBD52S
 jgyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp2hZWnBS92IC04gVqNgjFClZGDCHgjk++R7hUElIxrlMdomia3zvmjLSBp4IC6hALUG9Zsmo=@lists.denx.de
X-Gm-Message-State: AOJu0Yyp5ZZh/0/Y+nS3aS7JFsLfu5loRBYJemN4fG6o5j6QkdHPxAqX
 78OAqAlT0LW74g5EDkG45bJc6ZI4wAJC01VQ6UcOL0EHau+YOiqnj702CibdFAIZL/B+0X33H1a
 j+8sqg4q3+VROpbitS+GfKwOpVhU2u7GFIokQW3lY
X-Gm-Gg: ASbGncvfI2YTu6jnkHWe43g+9H0qqcdb9UaQhRf4jYd1pQO397PCDkj85FG6j8Ie7Qb
 ltoVxJwKS1t1sKI2+1XqZ6cpNeekvmRs0ztwwa9p0WYiwQYxndjr1iuwu8lyCsZZPgeF38ZZ0s8
 wrQfJWN+P/qBnO3fnQ7s02FL5nff7/SaztYw==
X-Google-Smtp-Source: AGHT+IEErjFmJObxCpKAewBy/4vkOmwrIGyLQQ7iaHLGDxtUmKXxnkS77/3bBOk4aifhpTKcxARGf4+TlywjVtrDaY4=
X-Received: by 2002:a05:6402:34cd:b0:601:89d4:968e with SMTP id
 4fb4d7f45d1cf-60189d49a3emr25844014a12.27.1748006309857; Fri, 23 May 2025
 06:18:29 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:27 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:27 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-25-sjg@chromium.org>
References: <20250504132356.2317305-25-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:27 -0500
X-Google-Sender-Auth: l4Owzc5VVETyLy6CohMngta5Kmk
X-Gm-Features: AX0GCFuc8yGBr8gG1R0m1IerjCMfCt-j7x-W5GDjwO6Btv50id16o5hKuNFB19I
Message-ID: <CAFLszTh-YqGaStYh8BSvRKbC2aBturpkk+oP8egy93Ep5kGpDg@mail.gmail.com>
Subject: Re: [PATCH v2 24/30] patman: Show patches in yellow
To: Simon Glass <sjg@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

When comments are shown below patches it can be hard to see the patch
subject. Use yellow instead of blue, since it stands out better.

Pass the colour object into show_responses() rather than creating a new
one, since that is tidier.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/func_test.py |  8 ++++----
 tools/patman/status.py    | 15 ++++++++-------
 2 files changed, 12 insertions(+), 11 deletions(-)

Applied to sjg/master, thanks!
