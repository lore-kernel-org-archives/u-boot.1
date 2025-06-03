Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C27BC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 15:22:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E525B82AAF;
	Tue,  3 Jun 2025 17:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oTXl6Xqy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF09C82B0E; Tue,  3 Jun 2025 17:22:09 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1956882AA7
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-606bbe60c01so1494022a12.2
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 08:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748964125; x=1749568925; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=S0BbJOPXjcCRV5UE0QfApUCdHRM4Pax3JxonCv1twF0=;
 b=oTXl6Xqy8ypp2+27nuz2wXmwIwO7aY+FJtZE+PhL0eVYzkXPOSnRjO03H7NTZzz8Gc
 zdQc3mZH1xUVaygXR017qIPZL7TDGqAf1/T6ynkUvi8hrFwcEcmwcP43cXYranY7Hnss
 MFFyfhS+Wv9C/TQMpCwLn9J4+w3cMAOY31HHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748964125; x=1749568925;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S0BbJOPXjcCRV5UE0QfApUCdHRM4Pax3JxonCv1twF0=;
 b=oLwTZhjMETF4+2l5WEjXCNAjjBcoHKUYfe+xbHprFnHPi0YPDeGjD6N+S6Z3HS9h0v
 RSogCWh9cNJPqW+A5nzetsc9zn8guKYtTlP2kYnNHKCNkGcNpk0rLM39pSdWI75fZOxt
 RNOywzfyV6hG5xFjobx5jLUp9Weqe4DJMKIqqq/VSgmquljlK2VQlkMcnx8huYgNKbb7
 SAzPVYPukw0BZvW+RYIc5F5ifo7SAm2Wl86v+H/g3Xn6NhIxJbPOOAOPOS9nLvqf+1j8
 4wYFfeEZPJiaJQBgp0rbk2Iy9w9yPrFDpC+xDO5g/4Q4zfa1G14bAzyv3P5COF/hfqIU
 KkVw==
X-Gm-Message-State: AOJu0YzJf4b/DP2hPz3Q3lHxK4WkT+3H02sF7ybN68ZiL9LdYwC/vsgp
 R912/4n04+nAKxvdUC41bRCF4Ay27Xl7GsiTZ6jZlkrh1m7qCNYn+xNV+qdnbjNBAO8M4qBeLT8
 wuM8UkbtCdCKNsgALHA3M4Fd9Qjah4aNMKFpIqBt+HWhgE68XdhZBag==
X-Gm-Gg: ASbGncu2N/2isp8QTKC52KVK6G3fNTF+SBpOUoytpzpUB2tRq8V5LFJ39dfQKCmV6GJ
 3jOimRHPKyWpJzYNiBqVmqemM7nmJ42livmbrn1IEviBCwCsgRpv49MVWUhNtotrXpZu7fSry/M
 bHv6h++eXEB6INDN0LKCftWTx1086Jw5FsKQ==
X-Google-Smtp-Source: AGHT+IECvmuZFTdQONb/7wNvyzq9uOr5A9Owi+yZDRJ1BCnJRbG4NmjNK04W8FBACR5RnAuD4KlTKnPrE8gU6hn1HlQ=
X-Received: by 2002:a05:6402:280d:b0:5f7:f55a:e5e1 with SMTP id
 4fb4d7f45d1cf-605b7b5f7cfmr12454950a12.24.1748964124727; Tue, 03 Jun 2025
 08:22:04 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Jun 2025 09:21:52 -0600
X-Gm-Features: AX0GCFsKHZn6HnjSM5587qWzKu2Is-M7g0cwz3chIiWudyW3lAI6lSEcmTk9s08
Message-ID: <CAFLszThunmVcg_HnF+UJotswTvGj1uX2+huWJjQnKXysdrRqkg@mail.gmail.com>
Subject: TPM result
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

I finally picked up the TPM you recommended (LetsTrust [1]) and
attached it to a rpi4 and used the instructions at [2]. It seems to
work fine in my CI - see [3].

Regards,
Simon

[1] https://buyzero.de/products/letstrust-hardware-tpm-trusted-platform-module
[2] https://github.com/joholl/rpi4-uboot-tpm
[3] https://sjg.u-boot.org/u-boot/u-boot/-/jobs/69998
