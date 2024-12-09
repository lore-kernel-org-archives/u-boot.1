Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBEAE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 13:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C3CE8971E;
	Mon,  9 Dec 2024 14:30:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HgXU/Ynx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6628388EAB; Mon,  9 Dec 2024 14:29:59 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D465D89757
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 14:29:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2163b0c09afso12625915ad.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 05:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733750995; x=1734355795; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fOxpn++7dMhnAplA2dpIU7FvZRS/VTMfmXio9Ep6cH8=;
 b=HgXU/YnxlXgcN1/TxXqkkmiIL/QdQGj4UsEpr1cHMLlsuZj+Jl+dSbPY/NdFof5HN4
 jrWNSMMyouWKaHx7HlX/ZXoRE6btj/95jkKzRYEdwExYiO7PD/QCdU6He9ZAQ8bz5FAm
 FPxJ+6cjmo5oqtYK4wuGMubOPOvJM8fFq6ILE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733750995; x=1734355795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fOxpn++7dMhnAplA2dpIU7FvZRS/VTMfmXio9Ep6cH8=;
 b=CYZLvDBh2wibiv0I11ma2IMA/m6pGj5sXCtyAlN+20hS+U58rzqIxkkVK0WZAZz6ZU
 pWNnBir7To/dihW8Z/C9WUHmFEqXNex0F9Le60y2c9CEi2LecVgc6nOOQaaVmp1prmKy
 Cg8Ww6Fn+DS2BXuU+zvZBto1nhRR0dJzCffZBYMrXwVvTUz0V7hoH7k7G3LiNAvo2giP
 gwFNZbGa2HMFqRlIO1xI/qT/Z+M3A1I0rcJ+sKMHi5b1W7Ky4JS+PklE+Y7Hn83IS6l8
 7DHj2gbZlIJ9tQXQxTA8M5sudtjL24/evPsXOeu1Akhu3A7Px6CuPJ03vNUPKx3yrc7q
 ghQQ==
X-Gm-Message-State: AOJu0Yyjf5Sr+9JQk9dfHGUPHb0SPmSqZ5NqbBvTF2cZM37HdTg1aMrS
 ACcPOVEFkQMuXuYcC6hIYBStj1voOdQbBJj7X7VNrY8wrvYhoBe3NCf/s7R+fbl01rAuB3wI9sh
 moUdx3mQDUmTx8ch/g+1bnpOBy+jIZ7WHmMJX
X-Gm-Gg: ASbGnctKVVYRPZeuOz/Emo8/EjlaQAzsqzQiMWgwLFrIUAucGD4F6izuuIvdEXDVON9
 lDCOLocoNZ2gbIPkTx5UT15Nv4l+wDjXF
X-Google-Smtp-Source: AGHT+IHZWWxWjqZ0DxYg5+kU2obw5N0ENDQSxGrq5UL31ZGujslwi0Q3fVabtYuHUwDt3lgnKtJc727eQeY3heYDdng=
X-Received: by 2002:a17:902:f551:b0:216:59ed:1ab0 with SMTP id
 d9443c01a7336-21659ed1c26mr30426905ad.27.1733750995334; Mon, 09 Dec 2024
 05:29:55 -0800 (PST)
MIME-Version: 1.0
References: <20241208190741.4192601-1-trini@konsulko.com>
 <20241208190741.4192601-7-trini@konsulko.com>
In-Reply-To: <20241208190741.4192601-7-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 06:29:21 -0700
Message-ID: <CAFLszTh00Gv30UE-AikMX6HkhwkMRhbqrSa7Zafji46VmFLRCA@mail.gmail.com>
Subject: Re: [PATCH 6/9] docker: Ensure we use the cross toolchain for aarch64
 on arm64
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

On Sun, 8 Dec 2024 at 12:09, Tom Rini <trini@konsulko.com> wrote:
>
> We do not want to use the host toolchain for building our platforms in
> CI (it is both too old, and would be inconsistent with our CI
> practices). To do this we need to set the toolchain-prefix so that we
> don't end up guessing "/opt/.../aarch64-linux-aarch64-linux-" as the
> prefix.
>
> Link: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/32
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  tools/docker/Dockerfile | 3 +++
>  1 file changed, 3 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
