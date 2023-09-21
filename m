Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF61CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A67BD86CEB;
	Thu, 21 Sep 2023 03:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lokB4eaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FB8486CDB; Thu, 21 Sep 2023 03:03:10 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5E8D86B4B
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d8181087dc9so518739276.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258187; x=1695862987; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8ns1QJdN7daA5+MbOQaUEfv/H2Y2xoq2K+cbftwnkag=;
 b=lokB4eaTEwWz2YqNSgDAG81XlUY/hPpOjfNBBxwviRg0pEUDv2WH4JorkMqCk594g2
 lp7enYYC4YZcWmrm+iz/4YJF/0MvhUfR/2GElwSs5NR7ftNub+67dKT6FienI8YLVfZj
 Md5xv4pJTAMR/iNKA9CAWoT2yYGK9VPo/8eUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258187; x=1695862987;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ns1QJdN7daA5+MbOQaUEfv/H2Y2xoq2K+cbftwnkag=;
 b=p09rwjUwpc8Z6vUoRoVbl2sfJy1YAO30BhHplgxlC4CCO0SNFCJnpbCy97EtYMWmrw
 B0qMNgYJpD+li1i3ezXRuLgXPUFQa48W6TvnL2rLFygmcj1jP2RS04Ux8pgRB5Vxs8QU
 aO3uN0isAmYh52IWVzbrk4LZtnoMME2gKYXmZKOKNK59tP0/+lGHFwHHnzml3JVlBFE+
 Xf++QN7QAheRsJfxmmVLgdt0XTyl5KSAeXn1wnjoBjdemI4GpO75UZc4C1GzGO89huvx
 hiASh2Io+8BzoXk1j26v/hYWjegGlp2eHA8DArNUqHdGjeQBtEL13ijgWgu8rrzTcDeQ
 2jkA==
X-Gm-Message-State: AOJu0YyEpc2k3mpq4hHy0SncCUkxZ4E5QQBMcreoW48aHBxkDFq5JjXx
 UqHXUbXNunP/W8vUvxf4aFTrRdAE0wHbYpEMrqWBaA==
X-Google-Smtp-Source: AGHT+IHuHKtUkehbSFtgU2ji8yxZgIbpKajua1e4t996gUtg81ThNqEiycMsFaxghJwAEwNv9DxUvz8Lh9u9RUO/wfc=
X-Received: by 2002:a0d:e213:0:b0:589:fcb2:d57f with SMTP id
 l19-20020a0de213000000b00589fcb2d57fmr3835852ywe.37.1695258187127; Wed, 20
 Sep 2023 18:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230916082344.583308-1-massimo.pegorer+oss@gmail.com>
In-Reply-To: <20230916082344.583308-1-massimo.pegorer+oss@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:41 -0600
Message-ID: <CAPnjgZ168w8a6uvzPK5RHOEUexdzuOVhV7vEUBM=b-5xTzNriQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] image: fit: Improve functions description comments
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
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

On Sat, 16 Sept 2023 at 02:23, Massimo Pegorer
<massimo.pegorer+oss@gmail.com> wrote:
>
> Load and entry addresses are returned in ulong variables, which are
> 32 or 64 bit depending on architecture. Specify that on failure these
> functions do not set memory pointed by load / entry argument: this
> detail is relavant for correct functions usage.
>
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>  boot/image-fit.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
