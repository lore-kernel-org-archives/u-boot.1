Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C254DE77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E74889730;
	Fri,  6 Dec 2024 20:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XGmI5u1/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A328989739; Fri,  6 Dec 2024 20:16:41 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60771896EE
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ee8647dbb9so1983448a91.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512598; x=1734117398; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rS1w1a1RvyayukZSC+zJ3nCnyNBpUdTbWg9Uy+IWrNo=;
 b=XGmI5u1/RSmAeqGTb6R5WdEsA3phKEPFimluJli3n4uLAys1V2oFyqUEfyOdZv2crS
 Tpj6iX25JKT5dEr5YR6ABjEIwiSxZ/+vpGYaPqmbhFXaSzBsYLxr7ONVOhsamYZeH4DL
 ERrB/aklGVy0rIYgTS9CfAYJXa5IQYApHks3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512598; x=1734117398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rS1w1a1RvyayukZSC+zJ3nCnyNBpUdTbWg9Uy+IWrNo=;
 b=BYmaH5ATfh24Xg9Ti3zR4UMWXLGc7Lf1lGXhY1Gg29PgBFyNFEvcqHZ+N2dW6a9ewL
 +T1rDc0kLabiZNTrr0ibBSS150TRNgKW+LC8AKc5vW4My9FoC//NZ9sKAuomsvPh0io2
 O0WaRHj0dhlE1t0rHyuR75uJzQ8L5MRAaJAfZiE/EeWqzgDBSdWbCXigdSFaonFpJKyF
 Nhv3Hby1mmfeEgf2WaLD7Q9yMIW/Gb3kIYUJ80Ias/Q5Qg5DTN6FYC62suMUQYE+6DKl
 s0A+4hIAwlPMFMvjHwwf4EXWg5OO9kQNJorktR3VefHDYLD85LP8DZuMHj9qLAHvuo91
 Kcyg==
X-Gm-Message-State: AOJu0YwdD0HSiemApNTtjIR5t4KU4ryC8u9cBv8K3yGmvzFzKM8E8hAC
 NdqBST7pqx0yaC1sqnEsJg771HPkansuefgjGzRFZ8qhIDFONFHEoRZO2wIZx5n8crijvedSesA
 zl1x9xOhXdrucL/6UdQcL0hb/ocuzsZJNB2q0
X-Gm-Gg: ASbGncuoaW2zstSbbmkgU/j+jSiRRs7z+1TOUd3JeKy9T5x3OM2a/OE0Ilw3IHDyE2X
 PUFvDQYNygbt+RB44K3+b0PoE5bu5a2Dc
X-Google-Smtp-Source: AGHT+IERzT4xEMO3Paf/pFm/bLmVv7nYwXwTOCOCn2o5TOq+S7tH7der0VLwuwLLVwpU0C+2cQZuNjV/3TocmkQmGgo=
X-Received: by 2002:a17:90a:c106:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-2ef69199e7dmr5733133a91.0.1733512597999; Fri, 06 Dec 2024
 11:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20241125174717.1181452-1-paul.henrys_ext@softathome.com>
In-Reply-To: <20241125174717.1181452-1-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:16:06 -0700
Message-ID: <CAFLszTixC5R7uZMt5ZXDH0HxAV5HCPui9QV7Z-FkixE_3jV-ow@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] aes: Allow to store randomly generated IV in the
 FIT
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, paul.henrysd+nodisclaimer@gmail.com, 
 al.kochet@gmail.com
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

On Mon, 25 Nov 2024 at 10:47, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> When the initialisation vector is randomly generated, its value shall be
> stored in the FIT together with the encrypted data. The changes allow to
> store the IV in the FIT also in the case where the key is not stored in
> the DTB but retrieved somewhere else at runtime.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
> Changes for v4:
> - Add a function comment for add_cipher_data()
>
>  include/image.h       | 15 +++++++++++++++
>  lib/aes/aes-encrypt.c |  7 +++++++
>  tools/image-host.c    |  2 +-
>  3 files changed, 23 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
