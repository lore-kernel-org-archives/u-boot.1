Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F9EE95A6B
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48C9486EB7;
	Sat,  7 Oct 2023 22:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dzn/sQA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AEB986DEE; Sat,  7 Oct 2023 22:38:18 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B64486DFE
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59f6492b415so29183677b3.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711091; x=1697315891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+InMaafsQuk2T0FfTG4UzrjGp07gtN48GMBnFibMEtY=;
 b=Dzn/sQA9BvNoej8MM81ms8w6xTIRIl9slbCWGjvGSzkTIqOuQ6cn69YbXa5t0j66iR
 pYlBW7HJUUhXZmudDDjvjpnctYyMV9zwyuaWMTuFR1eQu5+g5j3N3uv3pG9Nejvs3zM2
 vdtrqu6KH2xge8KGeT9+U6z2owfux0O01vmpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711091; x=1697315891;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+InMaafsQuk2T0FfTG4UzrjGp07gtN48GMBnFibMEtY=;
 b=l/1J7SJeeDklnoqBKG8R0JkZqWNxLyFCewnAx3swqMwavzo8dvxjc8pBkRRUo+oDSK
 UoC24KMkDLX1pbuLajWhXlLQloNVJkzeo3r70Tkjr9i8pwfwvRIe8ceWgWY8bkDEUglb
 r8JY41uH2C2l1qmKWj93nqNjA3GIFUgUw6u1LfYyqxjyuVUSl8x42rI6TtUbawW4UHQt
 ar9EHWznnLWYlgiijoQ8vy8mbaFQxV17yOnzrhqyOp97zDOWNnA67ZUGQIHjSzd8LbBC
 15D3uMq+OfBb9b2NXcejw9kiy9W0RhZZklKkAeNlo9zIegU8+/aNEYM0ErHaVjVu/YNL
 tsBQ==
X-Gm-Message-State: AOJu0YwUFS2ut9PjPh1cNPM8AIf80ODYy/+WVlpbfJuQZw4Cpet+JCVZ
 v7x8w7rnYchbQ1YyCrIafD/un/Cz1btUik8/8uH1fA==
X-Google-Smtp-Source: AGHT+IHOiYNYKpYpo4wAQIjRylg7jr30Q5Kro18byLLWU5DL+Bf8VpE/ZizXdWcRF9vZMjB2gdrQIyovFi8L5uhUMO0=
X-Received: by 2002:a81:a085:0:b0:59b:b9fe:1838 with SMTP id
 x127-20020a81a085000000b0059bb9fe1838mr5801097ywg.1.1696711090964; Sat, 07
 Oct 2023 13:38:10 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:58 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0gJv1EkfROERHgTdhaafSv5T3dSsf6EkyVQW0tU4Se+A@mail.gmail.com>
References: <CAPnjgZ0gJv1EkfROERHgTdhaafSv5T3dSsf6EkyVQW0tU4Se+A@mail.gmail.com>
 <20230923194424.1739224-10-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:58 -0700
X-Google-Sender-Auth: Pls2KypOxwY86gR4j5cfvuXqdeU
Message-ID: <CAPnjgZ07T66ttp7W-JjhJZDCd-=o98DMb3uibR6QB4d2iGk-pg@mail.gmail.com>
Subject: Re: [PATCH v3 09/27] moveconfig: Correct parameter-type warnings
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Fix pylint warnings related to parameter types.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
