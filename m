Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2542C83F05
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 23:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 364C886AE8;
	Sat, 26 Aug 2023 01:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZR+gHY1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E391C86B05; Sat, 26 Aug 2023 01:53:47 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4374786AEB
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 01:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fe8c16c1b4so2158813e87.2
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 16:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693007622; x=1693612422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bzguMwbvMoz5IkSWSfl+DBggWggAYLc6Aqp5wkMegoE=;
 b=ZR+gHY1NJlzLBWiVzqY172ktK2ep+54b6TeGwl1XsoY+FcNwQ0MDo13dUDYf9oBaE9
 U82BePSyOu097clpgGdZFYqngMojBzZ3gC2w/V7bBICxbgEoNgHE3HR1wBMnyReotRWP
 GKauJJLjJZVyXTrA4PoD8Gtj9E4+0ylnHq71k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693007622; x=1693612422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bzguMwbvMoz5IkSWSfl+DBggWggAYLc6Aqp5wkMegoE=;
 b=YX7q+ad1sekGRW3xuQcSx1dfMQcrGO3hYukzbuV7xi/JhlhmYnD1G82VLXq85GQwbQ
 1E0s3laNK4JCvscAjJTDgC573eCk8wCOLO95OPBjKNJEMQXmwl8Z4pz0oiKB7GACceI/
 4CZLrjeGgjKgM4S7h+G9pJqZCBslJUkgrnhKPiGgV8e2HsWLLqKR73v3SF8xrM97jemY
 JDL9tIhDHa7vLdN54gFzYr2eIMawXVA8NWJEL1Be97JSlzK9/6TcnSSYpjRg+VZNHDFS
 A8snqvtqEo1VJll6HvdZ9fYp7Kl11nBibF5ut7AMz8woRWo23/H798KXW0EoGgwE7Uku
 0m9g==
X-Gm-Message-State: AOJu0YxS6v62TD/XCTmQn4+H7553Ivx5bwl5uw0+6ZEiKRBjOCSDogwZ
 x2ixJjnFuFyAv1HL4cVkk+xM1hfZ6R67JCz8dwQHNg==
X-Google-Smtp-Source: AGHT+IFejSQ1drJ+Q6MTizugMRtLwg7Lnay2gKX96m92qD+LWwQXSbdJ153kN2X/CAZqkPy6CWoKVdq3WEtrLY0HNyQ=
X-Received: by 2002:a05:6512:11e3:b0:4fb:ca59:42d7 with SMTP id
 p3-20020a05651211e300b004fbca5942d7mr13281528lfs.33.1693007622439; Fri, 25
 Aug 2023 16:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-3-JPEWhacker@gmail.com>
In-Reply-To: <20230825193830.2753640-3-JPEWhacker@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Aug 2023 17:53:29 -0600
Message-ID: <CAPnjgZ2Ko-eEJbwdK70G8HNzTahmJdkiHsT0Cws+ZWUP-scWCg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] doc: Add gpt command documentation
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Joshua,

On Fri, 25 Aug 2023 at 13:38, Joshua Watt <jpewhacker@gmail.com> wrote:
>
> Adds initial documentation for the gpt command
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  doc/usage/cmd/gpt.rst | 141 ++++++++++++++++++++++++++++++++++++++++++
>  doc/usage/index.rst   |   1 +
>  2 files changed, 142 insertions(+)
>  create mode 100644 doc/usage/cmd/gpt.rst

I don't see a change log?

Reviewed-by: Simon Glass <sjg@chromium.org>
