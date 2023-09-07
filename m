Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE57DEC873E
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B63C8649F;
	Thu,  7 Sep 2023 18:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ER06lwSM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E1FF86785; Thu,  7 Sep 2023 18:41:33 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D91386410
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 18:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 64259CE1A59
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 16:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33772C4AF6D
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 16:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694104882;
 bh=TcXlCdBwAdhvSY29Gk4U6YRFj3oqsCMGTaUu7DO7ABc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ER06lwSM/j1xnFBQOrUJerziPgcpI5gDKNTqDixQjhU0k8PiCru4SwlOiLg0ImvO/
 kEl2QkM+/7urjlYrzxPn1a8a1ZCkKhzzM8HypyK/+JghUgI3OsD+X4qRpOf9w0w2ud
 K9Dp7IOFdNfiBgJcfKNJsRDaKud6Z9tI6+OY2bZa7Y0P6V8dNJpLmHShL8JqTYeGoW
 mOODtbz272BFtKswS1WP6lEktZ106QkwAwa+Ag4bzzUqiM0KMPvw/7g9cUlUzd6iyd
 kt9RhoKcdRgV5l2w4Q9WhMRyEXIhDJHAr9j4tVqUCpFDNWVtVVTW6jLSnZrRJfkwKk
 2NJKmzlChFiyA==
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-2bd0d19a304so21029711fa.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 09:41:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YyX32+9iKD6cYncjUwuAUxAtTSqhuSV272VLz3kxETst7hDbDGC
 KKkgVid424hKpFAv3Fat26QZiWXzggQK5DYNFQ==
X-Google-Smtp-Source: AGHT+IG23bFGvQrEWMPrUuiNiXfBfSQ2nV8yCIxtgarBdJYaaWK6UgdiyOScuIdqPU/mpa09cy/VQ6TL5hv239G+U08=
X-Received: by 2002:a2e:3a18:0:b0:2bc:bdbd:1542 with SMTP id
 h24-20020a2e3a18000000b002bcbdbd1542mr5251425lja.11.1694104880149; Thu, 07
 Sep 2023 09:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org>
In-Reply-To: <20230830231758.2561402-1-sjg@chromium.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 7 Sep 2023 11:41:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJFyuHfJ1t1gKfDFp1yGuNB_FhVCnY1Tk9iBzvchHwEOw@mail.gmail.com>
Message-ID: <CAL_JsqJFyuHfJ1t1gKfDFp1yGuNB_FhVCnY1Tk9iBzvchHwEOw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] Add reserved-memory
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 ron minnich <rminnich@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Dhaval Sharma <dhaval@rivosinc.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Mark Rutland <mark.rutland@arm.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, linux-acpi@vger.kernel.org, 
 Ard Biesheuvel <ardb@kernel.org>, Gua Guo <gua.guo@intel.com>, 
 Lean Sheng Tan <sheng.tan@9elements.com>, Guo Dong <guo.dong@intel.com>, 
 lkml <linux-kernel@vger.kernel.org>, Chiu Chasel <chasel.chiu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Aug 30, 2023 at 6:18=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Bring in this file from Linux v6.5
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v4)
>
> Changes in v4:
> - New patch
>
>  .../reserved-memory/reserved-memory.yaml      | 181 ++++++++++++++++++
>  1 file changed, 181 insertions(+)
>  create mode 100644 dtschema/schemas/reserved-memory/reserved-memory.yaml

I've applied this one and patch 2.

Rob
