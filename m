Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF6ED18129
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED607891E3;
	Mon, 14 Oct 2024 17:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CzbDA886";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76758891C1; Mon, 14 Oct 2024 17:51:12 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5732F891DE
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3e5cfb970c9so1292432b6e.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921069; x=1729525869; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p4Io2nLDx+Q1os+/+IbK1TK69GRwFzgWVYgMdJH0GAE=;
 b=CzbDA886dapS7w2XLCXW6NfQQlQW8NenGVC7seek7C/5TVMxoHwu+o2S9vfLKkSd+y
 GivImwEBymslSWZp012LRhcFprkOrUwBByduihrDMOXljBixbXsR/RpAMQBlkmyqTU6+
 LYEN04eLHAYxOKH+N4ymkUtTp71dj0L4ynkE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921069; x=1729525869;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p4Io2nLDx+Q1os+/+IbK1TK69GRwFzgWVYgMdJH0GAE=;
 b=LtDzVcpxHWHKzocEBAUdqre0kQRhsNmO0+xNmGJ1/0RH31hhRAQmD/TC5BUpSlnFK5
 k5S3/E1gzg78KofJTs6+W/3ZLxDklbzwBuGhsUVNeie917q0aiW2NSYjTY0LHjny92vK
 XTxYSUj7eIR0/I+nTJilISPbm9APUirDc3mNTnLdbcYO7KafefjRAs6zqZJcVlr20mYP
 cPg7zPpmRYTYWXf7hUo67TM3ob/dNQ0DYYOHV7Qbz5h9lbpz/i2kcLRTjWFArNYPRStJ
 t/E2oFHk2X1GnP+kyuvIqQsiTU3OR9JxdoTtpOmcC0v8ALpiCf3fs8yLxKIW0/dM5umf
 uqSA==
X-Gm-Message-State: AOJu0Yx0t1L1/42Lwh62JA78TjXumsw2Tm9lnfqtXe/jWuVLNeyOTyk9
 PoBBKPoVdcFjLn5Av4uvVNAulR+OboJ/0Q1FjIS41BX6heIp+iZ6yKE3BoItYgID41FP675HSds
 R0tUyYLDkgFzL4MMQN9HwRGxD5Be6U5EdxI3m
X-Google-Smtp-Source: AGHT+IGhgSc6lotYd45eisuBIFHoU2XRn1J9RYXqVMRhI1ZSCKKskAuFKH8Zb68ukE9sykT3Ow4GyKacf/CFhtKNrnI=
X-Received: by 2002:a05:6808:1884:b0:3e0:3c1c:169e with SMTP id
 5614622812f47-3e5c90d6fa0mr5354882b6e.14.1728921069110; Mon, 14 Oct 2024
 08:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-16-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-16-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:50:58 -0600
Message-ID: <CAFLszTgkK1zyaFh=96dLa6ebPowucWu_R=7GiT2eKA4xeWD46g@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] efi_memory: rename variable to highlight overlap
 with free memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Sun, 13 Oct 2024 at 04:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The variable overlap_only_ram is used to specify that the new memory
> region that is being created needs to come from the free memory pool
> -- this is done by carving out the memory region from the free
> memory. The name is a bit confusing though, as other allocated memory
> regions, like boot-services code and data are also part of the RAM
> memory. Rename the variable to overlap_conventional to highlight the
> fact that it is the free/conventional memory that is being referred to
> in this context.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2:
> * Rename overlap_no_freemem to overlap_conventional as suggested by
>   Ilias.
>
>  include/efi_loader.h        | 16 +++++++-----
>  lib/efi_loader/efi_memory.c | 51 ++++++++++++++++++++-----------------
>  2 files changed, 37 insertions(+), 30 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
