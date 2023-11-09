Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920F4C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 01:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38B8D87150;
	Thu,  9 Nov 2023 02:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kwXF4gcD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D9C87230; Thu,  9 Nov 2023 02:16:00 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20D3E870DD
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 02:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5401bab7525so409724a12.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 17:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699492548; x=1700097348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7UItqxUMtjKajyJDP4DloV/6c5p/UTkdVyc/DeN1+mY=;
 b=kwXF4gcDAkjQtRf6n3YmUwX+nJDNK3ZAA/3pgW7H0smabp+Lh90PPOv5tlO9tQtCEC
 UzNOC5w0KfJqRYtN4PRxK4FpfGgfimWI1plx+cL5uq/++M70NHGYkSW+xBGCkZUJGZPR
 t4ccdJl2ClrFxnzNZDx8cXmHQtx3kH3AyGP1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699492548; x=1700097348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7UItqxUMtjKajyJDP4DloV/6c5p/UTkdVyc/DeN1+mY=;
 b=ViUctVQkC8soAt75lmhfOUbKa2CXh5dDNHJz4uTz+WComA4dPduZn/W/2/r3efqMB7
 F8ZKp2o/F+Oq5xU7yu/0P6mheQw40H1gsmh/tuWxZHay0XrVjaYHyXnUiOgl8aGmLPGG
 iDB/Dujk1MieHuiMyfrmiPx9aU3YsANpFs8PZgwQ2KB/DccEvVqkAQ08M2CKRcPmB0JG
 vdFCTXFjxA9BmO4qTGEHRTDYpyJnkvItNt0nsAA1AvRF8UucwEhTxYMn7zY9LetCsOaC
 gz4+kBUVxSLZYnp1K4evBCF9eTWFrqv6/xvUwKXi0B2ef3lQRo6Pm7tdGvQB3GmZSGI7
 b44g==
X-Gm-Message-State: AOJu0Yx2iRx7hucDem7znDJMzEbQze84+4I95GXoBo7WAU2yKrWQZKK8
 XVAQdLbMQgvHc662/qEOpINw+4X3I5dK2JMXi1Qm+w==
X-Google-Smtp-Source: AGHT+IH8Aa9BecatefHvTpnTv5wizuL6u0HY7t738J/2zf5HlIiMT2RHpkkdmZhWsPpm6MFxiyVu+sCW2rOIOJ9tzPo=
X-Received: by 2002:a05:6402:3896:b0:53f:c889:8f89 with SMTP id
 fd22-20020a056402389600b0053fc8898f89mr1413949edb.36.1699492547764; Wed, 08
 Nov 2023 17:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20231108164858.3497420-1-seanga2@gmail.com>
 <20231108164858.3497420-11-seanga2@gmail.com>
In-Reply-To: <20231108164858.3497420-11-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Nov 2023 18:15:31 -0700
Message-ID: <CAPnjgZ1HgKOFT5TMeGmyAda4uwDf0v0Y2XgipQBcZc4Df9Aezg@mail.gmail.com>
Subject: Re: [PATCH v7 10/26] spl: Remove filename from spl_load_info
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Stefan Roese <sr@denx.de>
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

On Wed, 8 Nov 2023 at 09:49, Sean Anderson <seanga2@gmail.com> wrote:
>
> For filesystems, filename serves the same purpose as priv. However,
> spl_load_fit_image also uses it to determine whether to use a DMA-aligned
> buffer. This is beneficial for FAT, which uses a bounce-buffer if the
> destination is not DMA-aligned. However, this is unnecessary now that
> filesystems set bl_len to ARCH_DMA_MINALIGN instead. With this done, we can
> remove filename entirely.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v7:
> - Split off setting bl_len to ARCH_DMA_MINALIGN from filename removal
>
> Changes in v6:
> - New
>
>  arch/arm/mach-sunxi/spl_spi_sunxi.c | 1 -
>  common/spl/spl_blk_fs.c             | 7 ++++---
>  common/spl/spl_fat.c                | 4 ++--
>  common/spl/spl_mmc.c                | 2 --
>  common/spl/spl_nand.c               | 3 ---
>  common/spl/spl_semihosting.c        | 1 -
>  common/spl/spl_spi.c                | 2 --
>  common/spl/spl_ymodem.c             | 1 -
>  include/spl.h                       | 2 --
>  test/image/spl_load_os.c            | 1 -
>  10 files changed, 6 insertions(+), 18 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
