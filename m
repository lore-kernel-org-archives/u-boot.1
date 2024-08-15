Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850D7C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D18E188C6B;
	Thu, 15 Aug 2024 22:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fDGrvv6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703EC88C4D; Thu, 15 Aug 2024 22:34:15 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48F4388C52
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2d3c0d587e4so987132a91.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723754050; x=1724358850; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K/U6YC1zLSlyzV0xI5r2BAI43SeKR4qijrwB2iDh+Zo=;
 b=fDGrvv6mK8sJSCgotf63dyFVJrgjYI8neiQmyfyAp/KTDVgKVlxR8U4ihKK+VDfXX7
 0+3UX2albkMWMa6Z4vPwOZFtf89vkNP/G6h3bM8p8KEbx7MOHvBHfo9ghnOOI1AWwEr6
 /taymDnXkngd8Rhd/Kcab08wXzreLah/i+WzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754050; x=1724358850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K/U6YC1zLSlyzV0xI5r2BAI43SeKR4qijrwB2iDh+Zo=;
 b=Kv+Wq5YPg5NAVc/aPJd3yDaAInLG6ZmfJ72hRCkBxB6kS8TH71A7ucUDDC+Z3gFEWA
 xA1x0K14+3TXV/g5E2VCQkv5GxIeUEfAoSszMzNPy3qBWMJ71W1rYIxRFyWWskXww8Gz
 DuPNXdD6TRxDrDwJI+8Viqh1W6egxL6zVV6I8u+scUCUuxBODGAP0Vx9KP4Xw7I9gBv7
 6/cZqeOGditgxjnVukGLNR6GuAx7tTRDq83NuxyA0wPAqIajrzkUnEgoRelh/P5TkVQD
 w6pBnvEQypdP5jiQ8+CSxlue0s5ExcfOzOCWPNeieNiJ3Gy/kqllWl+jE5ZheAOcBlfC
 N/Hg==
X-Gm-Message-State: AOJu0YzdsWhFmyyCf2ON0qr3Is55g4KZSQkexM6ivYRSAbcwGgsRDKB/
 oz7kKY3AiT6MLmcWJFeWUugh2d8hxkA/md/Bv4M39kmDPmiCEsRw1HMAjgse+BTZgYEnymylTvq
 asjE+E4M6/hdvSWfKKCsNbQLdJpG/dGp6KUDU
X-Google-Smtp-Source: AGHT+IH55hDghZ7i3B6AplvEWOZQ1gn6jQ8nSeI5ApCHTzCjU48quYMeGrW4iPirTZstWYKamwHeobEDmnU2dikFUfI=
X-Received: by 2002:a17:90a:c28b:b0:2d3:c4d3:de19 with SMTP id
 98e67ed59e1d1-2d3dfac98f0mr965730a91.0.1723754050162; Thu, 15 Aug 2024
 13:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-19-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-19-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:33:59 +0100
Message-ID: <CAFLszTipEUzOg9S-Sqo74Q-HCqE1U6RwKrgxE8FKiggZD26MHA@mail.gmail.com>
Subject: Re: [PATCH v2 18/32] lmb: add a common implementation of
 arch_lmb_reserve()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 14 Aug 2024 at 12:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Almost all of the current definitions of arch_lmb_reserve() are doing
> the same thing. The only exception in a couple of cases is the
> alignment parameter requirement. Have a generic weak implementation of
> this function, keeping the highest value of alignment that is being
> used(16K).
>
> Also, instead of using the current value of stack pointer for starting
> the reserved region, have a fixed value, considering the stack size
> config value.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: None
>
>  arch/arc/lib/cache.c        | 14 --------------
>  arch/arm/lib/stack.c        | 14 --------------
>  arch/m68k/lib/bootm.c       | 17 -----------------
>  arch/microblaze/lib/bootm.c | 14 --------------
>  arch/mips/lib/bootm.c       | 15 ---------------
>  arch/nios2/lib/bootm.c      | 13 -------------
>  arch/powerpc/lib/bootm.c    | 13 +++----------
>  arch/riscv/lib/bootm.c      | 13 -------------
>  arch/sh/lib/bootm.c         | 13 -------------
>  arch/x86/lib/bootm.c        | 18 ------------------
>  arch/xtensa/lib/bootm.c     | 13 -------------
>  lib/lmb.c                   |  6 +++++-
>  12 files changed, 8 insertions(+), 155 deletions(-)

Rather than a weak function, can you put the extra ppc code into your
generic function, behind an #ifdef or whatever. We don't want it to
diverge again.

Regards,
Simon
