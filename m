Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D99EE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6204588DD4;
	Thu, 12 Sep 2024 03:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VprHuCnc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C447588DCD; Thu, 12 Sep 2024 03:00:20 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96AB288DA5
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-718816be6cbso296321b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102816; x=1726707616; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WSOq0zMuRL/00GU/a4EeEIVPA/xq+oZI1Vvsa8JByKU=;
 b=VprHuCncepdkzAEyV6ri+cBCDR+GmtAdEt2f/h8AydQHBBG03HMtrhMLPihQ7mLTAd
 wwgszuojDC+hPDjI7VXVBturY8orHX/RY58zTYdfhaC3Z6KkjeIIOPVjrnEBYjosBAB9
 rpfJ4KWTMcCtSwxgkM0W9RzvcYDC/Drtb3Z2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102816; x=1726707616;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WSOq0zMuRL/00GU/a4EeEIVPA/xq+oZI1Vvsa8JByKU=;
 b=QQD4Pm9Naw3+Gzh15QhdHrUraI0+ONvSUN4yHzxClAWStWaFzQdpjrk9vdMPHe0WDt
 TV2vTuF41P6/yGyDxZjL0B+YAFS1M+2hILX/cXtG7MkOgtk0z5WJLE9GAXapjOQ3JZK1
 nmW5d8zVRJit2GabP840ThmRjw/nrmA8GiLtlj5sg7WjeO18jgQNYmXo05kkvCtKHlui
 +8hH1o1hnMBqQrhFp0vF//h+91H7wqubJnTu6oOE9OMzDq1zL7xoZRdyNLBnAW/xiH6M
 e1++DebJe3ts3XfncZp3t0H0ELQg7w+H2/E0JxFGOu2nsQJQDSdhnI6RCGJpVA0NnZL2
 YEPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHAWDRLSHOsqE5+Q7gPXqUSG7aiAEOMaGBDjirw6ICx0H8A5d9wKIccGWvkoWK9vTiA+7iYgE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywcdrrg2ZCBI4CQ+Cl4Ytj9YHc8M6G3Hy3vUZyEkpZYsVJMDMyM
 HERpmTJvjtp8Uil0IjSDv5NAP/44lgBZYBEGRzKosYLZj0+KhdQxnH5wnrYVDqEF3Bl6Auc6/PM
 ZRarFmOsM0r1djmZ8U1ezJt3rU5s9TXqwEdy6
X-Google-Smtp-Source: AGHT+IHduuVy40KC+TZRbN43QYXb64P+mjezytAiLTucm8Vj6mRRSzo2oHN5nz0O7IWN3lPHw4HwBFU9kn1Em7kHlLQ=
X-Received: by 2002:a05:6a00:1953:b0:70d:1b17:3c5e with SMTP id
 d2e1a72fcca58-71926067e78mr1835432b3a.6.1726102815936; Wed, 11 Sep 2024
 18:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
 <20240909222720.2563118-8-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240909222720.2563118-8-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:59:53 -0600
Message-ID: <CAFLszTgoSqTF3ax2gOMRDNRHaiuKdsV4im-hc48YnzRY3aQ0gw@mail.gmail.com>
Subject: Re: [PATCH v6 07/12] test/cmd/wget: fix the test
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
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
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

On Mon, 9 Sept 2024 at 16:27, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> The wget test seriously broken:
>  * Uses zero values for ISS and IRS values (see RFC 9293).
>  * Writes incorrect values to Sequence and Acknowledgment numbers fields
>    of tcp packets. In the real life such packets will break the tcp stream.
>  * The test should fail (see above), but due to buggy old tcp implementation
>    it passes.
>
> This patch fix all bugs mentioned above, so the test passes with new
> and better tcp implementation.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  arch/sandbox/include/asm/eth.h |  4 +++
>  test/cmd/wget.c                | 45 ++++++++++++++++++++++++----------
>  2 files changed, 36 insertions(+), 13 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks for tidying this up
