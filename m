Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C74CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 508E288ECC;
	Thu, 26 Sep 2024 23:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hgZTX4iS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E54388ECC; Thu, 26 Sep 2024 23:33:59 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8696088ECB
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6c582ca168fso10008216d6.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386434; x=1727991234; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=avVobZbFlgNdFYyHy0QVLfFi9gOea/j7LUAweJH7aeE=;
 b=hgZTX4iSoHeQCg+qlwfVd88jqY1mhVIuzYoIB+ufKRiNl3dQbLltHEc9l0jbmRzScD
 I/qoazxksqJ77B9ZBnFAHFJYZhvn+vBtXDQqFtj+q19IYX6zniSPQtS7Lhs1yGbfUiCw
 knL/gyhznZpnGWFztmkWGFpLewNVq0gkwV3X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386434; x=1727991234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=avVobZbFlgNdFYyHy0QVLfFi9gOea/j7LUAweJH7aeE=;
 b=qRAZc61fqXmPDBed+qN65CqA+RhFD1KjN9AOsTlG/PfhD69rBPQ6QeBgU5WC+ch5X2
 vX9vSB7DGVBntTDICKFdk1Dt6hW4vNJXqmjFZ4xcWpBoZkW6Jp5orreVt9WgD9NirXPi
 A2ITo2n2LPEwbl+5kUODGXL0gVMA3A5m75yzt1NZjYX8tuzxjb4QESOQstZLh94qDZgG
 5IpdbKkSHmcZlWhsU2ESnB8zILs69owsekf19U1g1eU6Ti54j8ICaml1AilY2zF2Gr6J
 f4HOm3YFyA/neHUxWzMFHnuvul2LbZ+eJ4wADwxD6O/369d95I+Sd/taHdmXkjvejKAN
 L+8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7RO3SrbhZY3tB5YwWWiNXZbnOWE09JXuFwNotOkXAs3FEIeOMcL+3q9MLUEovcFPNmIz25bk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxz8ZYIlzClRqNnjFb4GCkv8eE9XeRmqaI7V7d/k4nq2WHh3X77
 NDMFrUn2BpzUdfMvsjDFVCk2zBZ1/eDKo21uzp3I5oOhlrMug85AHV+aoWiTPOO9IHuhj8KpMh2
 pvvJpzvguygbCpvIQJHe5PdkDI+gcvdWvWKh6
X-Google-Smtp-Source: AGHT+IFcecrYmsOjFems//Prhue5Yb2HFfGffK2hiyuECQbKCjuPiNZIHlluOwLYYrcMLw050Os3luhZw07SzPVCZQM=
X-Received: by 2002:a05:6214:4509:b0:6cb:3ad6:c2dc with SMTP id
 6a1803df08f44-6cb3b655d72mr12796046d6.50.1727386434468; Thu, 26 Sep 2024
 14:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
 <20240925014058.1679074-9-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240925014058.1679074-9-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:33:42 +0200
Message-ID: <CAFLszTjO3mtgZqTam+KDE4onaUWyGpK8OTc-ux9r35q+Wa=zfg@mail.gmail.com>
Subject: Re: [PATCH v8 08/13] net/tcp: simplify tcp header filling code
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
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

On Wed, 25 Sept 2024 at 03:41, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> This patch:
>  * remove useless code,
>  * use a special function for pretty printing of tcp flags,
>  * simplify the code
>
> The behavior should not be changed.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  net/tcp.c | 66 +++++++++++++++++++++++++++----------------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
