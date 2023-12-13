Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BC8C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADEC087878;
	Wed, 13 Dec 2023 21:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iuG9Q2pd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6451987846; Wed, 13 Dec 2023 21:39:17 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12D3087868
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a1fae88e66eso407313066b.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499952; x=1703104752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FisyoJ/1l7bXM6Izh5ukItPWvz23kkbHFsobLJJpmpI=;
 b=iuG9Q2pdqwR9nzK+pS3nZZhxAZ2j+V/Em7CIjruGOZ8g4bRq1kDjWxWj5V0yws4KEC
 DH9O23Zc2XDyghwYe2CTZ/Ops4+xis5IVJXKPE2U0zyI3wB0pu0bFjaUhHPUO61cvF4M
 2e4gVfI3gfJoN82K8UBa2FGayPzsj+mlIDbkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499952; x=1703104752;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FisyoJ/1l7bXM6Izh5ukItPWvz23kkbHFsobLJJpmpI=;
 b=h3Guo+/qcCZpmCmW+9qqOqHVW1Duqx70cs8ZDKmzNIQHrPfhRmXS5Rjph/5aZ01aaO
 5RmyP6yTDtJSTKqc9hvcUcx1o6cMnGMFBCpG/OCx2HbgEYYkREh4vqS9QsizfqlqwqIz
 1KXfv4ZPCLIxUbb+/Tx1P7ecgDo9aqhjtwDdyYBTdjlKt/zHSDeeQpZawH4JvE+BOGnF
 wk3u47RpTdhggGfPbr0hRkrqwdzdkxx+HoJNttCbhDRF1oATgIoKs8rMYVq22L2ype/z
 P8D/tXxAq3+MEnlKjBlCKYQCqtQGo8nkA6w3Y010Z8eUMYLC32Or+CKOyd0YajfHu17v
 Ix/g==
X-Gm-Message-State: AOJu0YxqzhViLYt/EiqzSab/L0MKcPMXAMydaPiFox9+2yjcMDo8dYY1
 t3+Nan1cJ1K+T9Fin4IVrZ/J5fBI9Mh1NZvtZdYhBOVBk+zC1bZJkJc=
X-Google-Smtp-Source: AGHT+IHJqMAjbUKNIkFS9N0pu0u6BJ8+XhbEZkvMnjCe29z9i/hNsu65EjHNCT2B7jVoaQ39zt3wnbAGwLRYpNj8ZcQ=
X-Received: by 2002:a17:906:8470:b0:a19:a1ba:8cc3 with SMTP id
 hx16-20020a170906847000b00a19a1ba8cc3mr3651306ejc.97.1702499952347; Wed, 13
 Dec 2023 12:39:12 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:11 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231119153611.639252-3-sjg@chromium.org>
References: <20231119153611.639252-3-sjg@chromium.org>
 <20231119153611.639252-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:11 -0800
X-Google-Sender-Auth: 988cicwX_Zdf28-QtdipU6VnMHM
Message-ID: <CAPnjgZ3MOHdea+2SYOaxT-Jvs+7OxDeGFyWD4DuL_j_kBBkazg@mail.gmail.com>
Subject: Re: [PATCH 2/7] u_boot_pylib: Correct readme formatting
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Correct a heading which is too short in the readme.

Fixes: 75554dfac29 ("patman: Add support for building a u_boot_tools...")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/README.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm/next, thanks!
