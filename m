Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9E3E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 478D78971C;
	Fri,  6 Dec 2024 20:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eBZFayYw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA184896EE; Fri,  6 Dec 2024 20:17:47 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 954CB8921B
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7fc8f0598cdso2840655a12.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512664; x=1734117464; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hEVIDf2ArseCyx+qsrbqJwmc7mEHJV4yMGEW1vekbcU=;
 b=eBZFayYwQ45zyUWO9dIcSYjEe+GFpTi7g07mok7Fv6jvVoBgGFomKjRGaOO99nHrsq
 VWuQ5T85xeF4A63WyeOkjlpqQYiRB3Xe6wxbVwTlnKSi4js0VkpbzmNvN7yJnix9mh80
 1DncGKmE0XRDTLmp/vKJwWeVwPY/bgDjETHaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512664; x=1734117464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hEVIDf2ArseCyx+qsrbqJwmc7mEHJV4yMGEW1vekbcU=;
 b=IB1u+IRjWzcyI/qybGt4AzQ8+VO0yh4fdH/mwAk93OeVgqg3VyIUiyGCA0KZAqURic
 WqV5JLPlvjFpsTHVb0oF9YPh28Gxqyspzve+TY3uJ+C5aAHz1RShPljnVUygdXoC9H1I
 anO/hchkn9LOpnvkuSOnLpIU1QeCd0PvG24hLJ6VsBbVCD5cPfBmuXILUYlOnDi5bhXh
 3f5t+itpKLqfzobOr7ZqIJWSRKZgVxoDiGMzFR5GXNC5syv8mEw62xXFXAYf+QsoWGwT
 ZI53iXK6vuzUdl94auNqdSN/Zmwj9Iul9jw5eG+wby26u8UKMb4RHDVbrRtTOFiScS7a
 mzqw==
X-Gm-Message-State: AOJu0YwHZeJheOzXJDbD1kt9u31ur4ClQ6tZJRE70059NWIa9lrNJkJa
 3x7mjRt6WSoe+W/KW1eYkk/TeHtYGjoPRagTGP7VDwCPz3zRppiPJQIwinVn94uzNDPpxWsIH9J
 /kM7R0eEClyRJJahmz3Xo9icExaKJjtOX6vKW
X-Gm-Gg: ASbGncsI9GwQhAgweKENWxhfEbNoZb009atCRklDwN6jh9y8QBA2F/guZ7yQfG2BNIO
 a/FtlzVhzB0NR6+pcb+l+SQljnwEx107F
X-Google-Smtp-Source: AGHT+IGsqz2M54IwO7wvX+dxZRYoA9Fz2Cd4zu1awE7s2joL0CXZnQuVjmJ07VcQe3sSS0WYetVWQlwjEgF/2lhQFzM=
X-Received: by 2002:a17:90b:33c6:b0:2ee:edae:775 with SMTP id
 98e67ed59e1d1-2ef68c88ef7mr6511534a91.3.1733512664159; Fri, 06 Dec 2024
 11:17:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730452668.git.michal.simek@amd.com>
 <f1379d2587f9bf279a7a75c318aabbc1b35ee0c6.1730452668.git.michal.simek@amd.com>
In-Reply-To: <f1379d2587f9bf279a7a75c318aabbc1b35ee0c6.1730452668.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:17:29 -0700
Message-ID: <CAFLszTjaY1i2D6PsL9fc_DJRsX5XwMdmHZ5Pq2AXpNS00L_t3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] binman: Add option for pointing to separate
 description
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, neal.frager@amd.com, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Michal,

On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.com> wrote:
>
> Adding binman node with target images description can be unwanted feature
> but as of today there is no way to disable it.
> Also on size constrained systems it is not useful to add binman description
> to DTB.
> Introduce BINMAN_DTB Kconfig symbol which allows separate DTB for target
> from DTB for binman itself.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Changes in v2:
> - Change subject, align commit message
> - binman - rename variable
> - Use relative path
> - Use separate variable in makefile to also handle empty string and default
>   to u-boot.dtb
>
>  Makefile    | 11 ++++++++++-
>  lib/Kconfig |  9 +++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

This seems OK for now, and unblocks the migration.

Longer term, I would rather have a way to tell binman to remove the
description, as mentioned.
