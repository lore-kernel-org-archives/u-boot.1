Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E9DC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 02:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3B7287483;
	Thu, 30 Nov 2023 03:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BsDVEjVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C194E875F5; Thu, 30 Nov 2023 03:45:54 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0577870B3
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 03:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c9c18e7990so6093481fa.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701312350; x=1701917150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v+fCWiOcncDoTXf4A6j3L3y9crWHav080T/K9rZsd0s=;
 b=BsDVEjVz7gXz7jhisIJRW54dH6/NEk7uXwSbMxOg76hF1xc16XvpxblOiqEbuBijkB
 pR0m0NIpyev2nhxIKob9mx+YsFuGUyFgtEPizug4a0G6ermIQ3tqOtRYhcbqxVxgqDEJ
 91sq52ZajFDYiWDI17RYnCsS+wR1Oi81O1U3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701312350; x=1701917150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v+fCWiOcncDoTXf4A6j3L3y9crWHav080T/K9rZsd0s=;
 b=VwKsX1WgEa6XSIxVjXFLmIYZUiZCBWAaaOMotQEYi475a+S2fnCY1Juu0piPc3OxWU
 o3rWg0j5m0Be3mgoTUaqazq7V8GOb7Afw6wfHl+Zz5OMCYWZQ1ufzyvjcevK/ZTZCY1E
 qLlNJNqk63GNKnq1QHQFGUsWTddB+1NRq7mkrIyB877XFOcIq7FNS/D7JnQ8+7jxnTQA
 WS3d8jU3BlGn2hUuI0Wy3rKkyOF5PTXjPdmt4Wogzy2wghMh4Cb/TjCwVgq+el0DbCIM
 27pBnoW3kz0xyNMVIQiRbNWHYVdLIhCepLCAZJp1RROVBW5gQOJGFX0668uSoIZWkQVS
 s0bA==
X-Gm-Message-State: AOJu0YzZqnX+hcMVJgX48+jEndew84oUDv+fFalC8DHviMALh/cWSDap
 xIQga8ctaHbb2dTZYdYqjQIIPPwqLvPbpOdLzAwtcb+z7iBYZfyd1SM=
X-Google-Smtp-Source: AGHT+IH5Co1ujObTX4/BifGUeUydSbPDyJg/KxkE5z+GtGFRHDyRzE9OKZ2wM32uoOsXNNvQmWEXtW4Tf5jM+Pp8ClI=
X-Received: by 2002:a2e:94d0:0:b0:2c9:c86b:14e9 with SMTP id
 r16-20020a2e94d0000000b002c9c86b14e9mr426397ljh.24.1701312349908; Wed, 29 Nov
 2023 18:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20231122131154.2444690-1-trini@konsulko.com>
 <20231122131154.2444690-3-trini@konsulko.com>
In-Reply-To: <20231122131154.2444690-3-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 19:45:35 -0700
Message-ID: <CAPnjgZ0xG+92iLwyc_g0X5rex5ruohXQ6czRkOzi5pCkL7wMRw@mail.gmail.com>
Subject: Re: [PATCH 03/11] sandbox: Add <linux/types.h> to asm/global_data.h
 and asm/io.h
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

On Wed, 22 Nov 2023 at 06:12, Tom Rini <trini@konsulko.com> wrote:
>
> We need <linux/types.h> in these files as we reference Linux types.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  arch/sandbox/include/asm/global_data.h | 2 ++
>  arch/sandbox/include/asm/io.h          | 2 ++
>  2 files changed, 4 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
