Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4916C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 14:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E070E88B88;
	Fri, 16 Aug 2024 16:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dmI7MNwq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A204E88B6E; Fri, 16 Aug 2024 16:49:39 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D48388A99
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 16:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7c1324be8easo2279110a12.1
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723819774; x=1724424574; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3QP6JcqZ5knwLE94IulsyQlCMnVXWIeCPqBupr4EjyA=;
 b=dmI7MNwqe89MFwegmM9ecug6W1zN4povdR45GsISIgVczs3XG/bUBqsTdQGvWghvCK
 IeaG0uX6/w6Yjm2nBJAmFC5iNliCwnfjc9dDPCiCiysmuLbVs+bkIEw29EJBOOJV9UKc
 jxjJnR5d522LBZla7RZjHLg+/TpuFULZIZrdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723819774; x=1724424574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3QP6JcqZ5knwLE94IulsyQlCMnVXWIeCPqBupr4EjyA=;
 b=foESu6eOdnfwftIr0zIDIii6eT5fJfoYsCVFCciCby5GlgLwEYf5l0vwSQYFpLawZb
 H0p+k5hDCn8i+LiGE6HZydqxS5KwwsXiwPsWPcvLozMoGypQS/pBCyfO/OEmTbp/kAYd
 b6gh8TcM/K4WOkPOor3WooJmyCrZIF85Lne8HbelRXJO5Hkx8XfRVrdiEdxsB9ZJ8G7L
 Z4t5hGgQbxwwpuU3rDSnkLpzsBpgwR4ACKArf2RO3PpUSOR++cHNJJpX1ULTKjQ/VFKK
 IHRigdLR/+PrfQTJYiSU4cADSffaEqne77RLaxweYJtKhGnr2+fZFtPZyNJNKrV05oKt
 7VVg==
X-Gm-Message-State: AOJu0YwKHJSJ1nl17C5oXF0PH3htYpffvyP5Y51if/60K2kMjPEuQFhX
 iQmIM7znVG/ufs8qEBeHPKDYYXCeCoYDSWAtje50FA126+THQ1+Yo3ixSy4YXyATpzU+GJu3vYa
 VnUMhtQe45XIti5YAU8IVnMVt9g62D4ypilr6tR9MGcJkHDs=
X-Google-Smtp-Source: AGHT+IGnhgvjZgs213kCvO3Ft27CJGCL+5mTnL8byUmntu/aZxsFuwydoZCBTU6NWJeqJbAuJB15w2FropuRoSLNJ4U=
X-Received: by 2002:a17:90b:1911:b0:2cb:50b8:e59d with SMTP id
 98e67ed59e1d1-2d3c39a9618mr10137040a91.12.1723819773981; Fri, 16 Aug 2024
 07:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240816034905.3541020-1-trini@konsulko.com>
In-Reply-To: <20240816034905.3541020-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Aug 2024 08:49:22 -0600
Message-ID: <CAFLszTjXQ7OeXHQyv3D3n1ciQDU5C4ZpMafDdo=EiwTXKBKY4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] test/overlay: Make this depend on SANDBOX
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Thu, 15 Aug 2024 at 21:49, Tom Rini <trini@konsulko.com> wrote:
>
> As the overlays are sandbox specific, mark the whole test as depending
> on sandbox.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  test/overlay/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/test/overlay/Kconfig b/test/overlay/Kconfig
> index a4f154415db2..881848968bb9 100644
> --- a/test/overlay/Kconfig
> +++ b/test/overlay/Kconfig
> @@ -1,6 +1,6 @@
>  config UT_OVERLAY
>         bool "Enable Device Tree Overlays Unit Tests"
> -       depends on UNIT_TEST && OF_CONTROL
> +       depends on UNIT_TEST && OF_CONTROL && SANDBOX
>         default y
>         select OF_LIBFDT_OVERLAY
>         help
> --
> 2.34.1
>
