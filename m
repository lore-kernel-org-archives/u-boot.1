Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116BCC54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 351A0835FD;
	Sat, 24 May 2025 07:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gpu9JbFW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E55783303; Sat, 24 May 2025 07:06:12 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67FEE834BC
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-601aa0cb92eso655232a12.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063170; x=1748667970; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8A0jtKePfCyVDK+3/31pzr/NUg3DTd9Ez1SMQwSEvyg=;
 b=Gpu9JbFWZ/EeDh3zx6xrY05irj3/YahEgzyTRe4dIAMwktufuUckHU3bPCITk6LVwb
 7trlHpJ453aN0X2aC7YCa54WZ/BvI0LlT9c5HGsSozdgZf19LbXX3/Ol82i2GFPf0vpt
 9GWrQwZOYLCyGxrSc/GWi06PTyoBRg3TFtpwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063170; x=1748667970;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8A0jtKePfCyVDK+3/31pzr/NUg3DTd9Ez1SMQwSEvyg=;
 b=KO8h5daMYL+PgACB4i50cDexo6/MK8pO4aLvw1oWcM6c0l4KwMVC4Yid/cSHCFG0rH
 zBtt/Ov9aU3KHkSwYNsmhXFG+TjeYZkkgjCn21B4SH/JO1bKqFRRo1kfnhSg9x5zaiaT
 Npd62FlV8CXGskwoGUTXslAiEFnYOL/H1R2Dq56/ywC96Hr9kEarJaGNH6GBhGk4axnM
 ZTaq1MjNYRnsBzum+Ri/OTqOZIHMcvA2jMKxly41Ym3RvBkn9eBflc7JOdF1jXDKWbhq
 6VkQIHAtnr2bwCcQ1JsewZT5b9tBcvTadCn2YM1ne01RmuWrtDxCQVYBSHKTGP5th3vy
 UG3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVckgkUgEh/N6lJ3r65J7GKU4rVtGBhe4q6lMkUjSArWtk620OzFreZDZ31fPy+Kk3WBFW8gAw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw35BxuMkTWfK/sn/iAkK4oiSKXnGbyuN0XP655Xt/Jh77UMbYd
 xY4zJmIF/ScLrZdRQA6eqRPi4AfaJyLNzj1F9WX+IQjeOmjn0FtMou1gzWlo4Dhad94ROyAamD+
 jdSd5OPNmZzVM3EK6v3AvSiRbEMu96BIPi03og8BB
X-Gm-Gg: ASbGncsxm7QkHa+bh3BDqManMRB2wOXKply1gr8C4rPp+ov1KTpIKYuJTmwCsh1+q99
 /aU10ZqjGa1dBg4cehXHs6dueiDYAQk0EaKlAPmGzLXeWnUljB+9OJM+l1YY5pIgib1IBNpJweP
 wgmouys2xFSNqW2Aqd3uMy1rytCELqoe/AhKDg+9a4yQ==
X-Google-Smtp-Source: AGHT+IGJBjamSlniovWtRcuVEYRrgV4vZKXyFdYwPUEADxYihLqy3VSn4i/dSkjBMFK2zS1I+kqmO7q+SKDZTcFpfDs=
X-Received: by 2002:a17:907:3f29:b0:ad2:3fff:7bf with SMTP id
 a640c23a62f3a-ad85b2da118mr115670966b.37.1748063169880; Fri, 23 May 2025
 22:06:09 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:08 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:08 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-14-sjg@chromium.org>
References: <20250510110535.1453745-14-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:06:08 -0500
X-Google-Sender-Auth: O7S0Rct_ViRUM0R_TvSY5bf2BGE
X-Gm-Features: AX0GCFuvM859IOXjoWsVkxy8JVnQrV0pdaffrL8Ah8q8FngasK0a_sJQ0oQsNkU
Message-ID: <CAFLszTi3nOwvitsq=KWZzqedgZe6d0NuXYYZmXeo3Te8Be_EqA@mail.gmail.com>
Subject: Re: [PATCH 13/25] patman: Enhance patchwork interface to support
 Cseries
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

Add various new requests to the Patchwork class, so we can obtain the
required information. This includes cover letters and comments.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/patchwork.py | 428 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 424 insertions(+), 4 deletions(-)

Applied to sjg/master, thanks!
