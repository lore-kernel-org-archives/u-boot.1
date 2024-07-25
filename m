Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F8BC3DA70
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C972588609;
	Fri, 26 Jul 2024 01:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b4cuCqpO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42D97886AF; Fri, 26 Jul 2024 01:32:54 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2C4B88606
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-44ff7bdb5a6so96791cf.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950367; x=1722555167; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8WVFY6dnOm+6yqa8EszY/mlEge5uZPY6Ptjz4St/VbQ=;
 b=b4cuCqpOvqCMXZMavEaZPHsEWNqhTE8/ZMH/s/vziXsOmLfxfY67VY9PnhxoPSV3vi
 1K6RPH2QKbPIfPIR27Q4ZZkCMz/shJmH4pkvQS/7aGgxPe87s1GgnaMjR69otc+e+Y1j
 Rnn64VOQZCJ5L9ASn5kskkBHaWfRjZh6oPnuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950367; x=1722555167;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8WVFY6dnOm+6yqa8EszY/mlEge5uZPY6Ptjz4St/VbQ=;
 b=D3XpMbQ5bo2beiKYJCGClj9n90hep4Q2hSsrYu0OM+XDIvPh6y89Rm4tN91suXzULk
 7TWi6Td/IuURjIAygUeUjXhvVC7cOKdKBMxteRC2zFVgf/rGn1usjErY6M52Rn6UbT46
 rJxpFhT9rf2QMmBLGVfqBmWEWk+ZSyuX3u3Ga+aCRasqBRF48Lu9EWHTphe9A0YVuNgs
 Plt5rVdR7Gh3guXlHHDLyqNAukCoX6I0w/VD4Z3P8GZwN3zFBf1XTLzWIh+02nnEOge5
 3kwlkUPQYFQ18AMQMLc0gRcpduz8Hjz6ZJpyFsFdtB8oqpryG73vzZ9K7GPKT+Aqq7DM
 4skg==
X-Gm-Message-State: AOJu0Yy3tlhPhKiv2rymxi2B+MwP0xvxGhxdi2n3j3sIMZJ7xts81ywf
 0/eoNufULEWG6KOgBwQ+5r9bdBMkxh+VdRj8+d10CBEZXrJCTAPtsYRZyuWiuxIOicQgtH9Do7l
 9IwxwbVK1PjvAGFVWaNvQdIMZiNXsZ5mTJOSe
X-Google-Smtp-Source: AGHT+IHVAvPfrPv6GXP7RAVo2hKUtfMbi8aFKPp/JYppn6vjHy0SXk/8dtR5ycGgCCfqje9bfXFUambl5WI4I3Al4qk=
X-Received: by 2002:a05:6214:246f:b0:6b5:4865:948f with SMTP id
 6a1803df08f44-6bb4071023cmr40227176d6.27.1721950367530; Thu, 25 Jul 2024
 16:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-34-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-34-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:36 -0600
Message-ID: <CAFLszTg1nywmyXRJ2Dgsg97Mfbps7P37jDD72dNafo0wHF3RZQ@mail.gmail.com>
Subject: Re: [PATCH 33/40] test: cedit: use allocated address for reading file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Instead of a randomly selected address, use an LMB allocated one for
> reading the file into memory. With the LMB map now being persistent
> and global, the address used for reading the file might be already
> allocated as non-overwritable, resulting in a failure. Get a valid
> address from LMB and then read the file to that address.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: None
>
>  test/boot/cedit.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>

No, we should not start putting lmb into tests like this.

Regards,
Simon
