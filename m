Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FD3CF9C55
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE67388CDC;
	Fri, 20 Sep 2024 18:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aBkDd7vn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48F3188B16; Fri, 20 Sep 2024 18:04:07 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 215F788B16
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d88c5d76eeso1657814a91.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848244; x=1727453044; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2nXbsdcftVyKv3ggijxIesZBSkQaOQbjrek7WBhCtDA=;
 b=aBkDd7vnvCndAKA26iao4JoRk2sJE74GSwDR4BERPMhGm6q7nm8eafFiWiNtwTuchX
 6Yt6vDozGNmfdsYaCb6q6WkdF9s9yLzEYsaRksYY5TS1/ow0o6vlybNYDZT7QQCy6eoB
 EFKQMNtSXpMR/yuDDjzDm40o/ToDO36Ok1zkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848244; x=1727453044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2nXbsdcftVyKv3ggijxIesZBSkQaOQbjrek7WBhCtDA=;
 b=xDdI1Jgw6X3Pm7FsohoUStyEkNRWURqfh4bAVqb8raeNbpatr/aNw/PKirUCfe68ct
 nCk4lMwqIps9a1tgXHUpkhbAum/I3+zhZZ4G5Iw/8cwEMokqbwG4lLomOx/hFQDTt1xX
 3j0AHagiTHAbt5yKGK7n1+xLmYqseaOSrRTjntJyXwzLXUhnT5e99CuGcM2vwExiaFlS
 9gkVDi8P8wQXOob47DTYdXZeXoIEGDelqDtKdX05erNoroyvrRzJHagR/snEukRdCa/A
 QVhnxAt8XjK7sOJU3HbxoYDaD5p5UYnVIGJzKUENm344Erbzyc9F1pHKCjITeW6QnR7t
 0XKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl5zFXPXJmq3hS4k45B8HC+81vIroezYiMOLCWiEfhILayJJ2yMuszTR+NDS88YhvpD1UWUL0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9YwPGTSkp2axYx7wwOCoIYLZd0I6Rf8Z8zrN4Y1QcehFcY4h0
 q+7Qn9dGx4LfcqlEERtjcg9z8UFaAPbBii3qS1rvgJKVCQ+/TrCQ/YlHzQyiPjr9VELxcMT1cQN
 HMrqnnzFNaDimVrdR498lOmj01F1MHevNK2kU
X-Google-Smtp-Source: AGHT+IFwSkYZP99jLWlobj9kIbKnHI4V25yxdKCvzBQwwbEf0E8EnOkJpEAZ7/Q+5BpfNnjPtErChsLJmkMqO4NZo54=
X-Received: by 2002:a17:90b:4a92:b0:2d8:e5a3:f6a5 with SMTP id
 98e67ed59e1d1-2dd7f3f8034mr4560032a91.13.1726848243321; Fri, 20 Sep 2024
 09:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
 <20240824092716.1042696-8-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240824092716.1042696-8-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:03:49 +0200
Message-ID: <CAFLszTjv+Un242rwYO-m24S1Q8OKCsPUQ5vjXT53jam_P3sJEQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] net/tcp: simplify tcp header filling code
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Baruch Siach <baruch@tkos.co.il>, Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 u-boot@lists.denx.de
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

On Sat, 24 Aug 2024 at 11:27, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>

Missing commit message

> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  net/tcp.c | 74 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 41 insertions(+), 33 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
