Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6499AD59D80
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 00:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B83B189A51;
	Tue, 26 Nov 2024 01:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DCXPQ/8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41DB889715; Tue, 26 Nov 2024 01:33:35 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E774488BFB
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 01:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7f3da2c2cb5so3655002a12.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 16:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732581211; x=1733186011; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GUIY8s2Ujla3h9dxRkQ5+NRy6OyU31SytOMVkgH+oAM=;
 b=DCXPQ/8xfUi6Z1IF12k97p3/KaBbzji+GDrhnXs6govH2aCJpfVz8ZZ5sQqGSTLvCS
 dNBwVBeB6cppBLyXhOQkuFtI3zYIh68yNLC47JlOgim3orq2TUm3RzcF+IDbLiLgZqeU
 a7VnxgADyXkYZOOlVDl2r471io0GeUBJYRKLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732581211; x=1733186011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GUIY8s2Ujla3h9dxRkQ5+NRy6OyU31SytOMVkgH+oAM=;
 b=Riuc8bwDQoVc4sjdTUyNZEdbFoQ73+rMXBq73SguHhjSyhga3t7Hj5IaQNsffe08La
 crhLl3gHwcklQv8RYazYm8AJU6FXAqn/oY6cU4uVW1+ZG3iAIu+gEQhFtQTwc5VQF8TG
 uQahhbn6SLxMpgp3zmyJ4jMjECsls2nWTS1TLL1ASMgq2vxzlXUpXFJYvQRCNlV5c5tD
 LrUsy3rGlb9EyLZXXAVFgne8nrCMwV15Y2eTFTLekQ6l3pj+fVbJV+kj/qui2i++BGYz
 EDDX2XEv13twwQ4gqycThEuOdf8UDOnouA3YiHl2iDaCfQTBJQmFGArTfr70v9oN7fYp
 R0jw==
X-Gm-Message-State: AOJu0YzYDyEojcsKvqZrL/8X8Wn8Rbktfuhf6LU58/aAf5STRMUy4148
 jFWpp1Oqzd9locL5st7lrtjp7cC4Dx4vdHCcE/r6tSHj0BYX5n/WoTcv/pJYFflbnnCKFOlx+dW
 W0mMmM95ph0VSKrNR4Lrz/NNRHJsG59wGzwJF
X-Gm-Gg: ASbGnct4cY1epib9dsS05D1eetPebrIGjo7Y+YozZNdxRWDCROjHlNW0YzfoxTWbx6k
 frCWLs/9oWWBDVT4+9f6msHyOk0P/1tQ=
X-Google-Smtp-Source: AGHT+IFv/L/wODedt5VsdfNwkC5tYJkBYrrL5bYkqF5sGTkfNWRgImFxXHgURykBouE2eUC3x5I59RqtvvioYiZrDmc=
X-Received: by 2002:a05:6a21:1646:b0:1e0:cbd1:8046 with SMTP id
 adf61e73a8af0-1e0cbd1839bmr7315007637.0.1732581211491; Mon, 25 Nov 2024
 16:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20241125115554.1707080-1-andrew.goodbody@linaro.org>
 <20241125115554.1707080-4-andrew.goodbody@linaro.org>
In-Reply-To: <20241125115554.1707080-4-andrew.goodbody@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Nov 2024 17:32:38 -0700
Message-ID: <CAFLszTiJ9LOM_EBASt7psJN7tqbtM=i=HMBgrVrNAX+_x62u=A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] x86: select CONFIG_64BIT for X86_64
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Dan Carpenter <dan.carpenter@linaro.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

On Mon, 25 Nov 2024 at 04:56, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> Select CONFIG_64BIT so that we pass the -m64 option (instead of -m32) to
> static analysis tools.
> Introduce CONFIG_SPL_64BIT and select it for architectures other than
> x86 with 64 bit builds. Do not select it for x86 builds as x86 uses
> a 32 bit SPL.
> Ensure that when limits are set they use CONFIG_64BIT for U-Boot
> proper and CONFIG_SPL_64BIT for SPL. This is to allow for the 32 bit
> SPL build used by x86.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>
> Changes in v4:
>  - Add help text to describe new symbol CONFIG_SPL_64BIT
>  - Splite statement in bloblist.c to make it more readable
>
> Changes in v3:
> Introduce CONFIG_SPL_64BIT to allow for x86 building a 32 bit SPL and
> a 64 bit U-Boot proper.
>
> Changes in v2:
> Corrected commit title to be x86 not sandbox
>
>  arch/Kconfig         |  8 ++++++++
>  arch/arm/Kconfig     |  1 +
>  arch/mips/Kconfig    |  4 ++++
>  arch/riscv/Kconfig   |  1 +
>  arch/sandbox/Kconfig |  1 +
>  arch/x86/Kconfig     |  1 +
>  common/bloblist.c    | 11 +++++++----
>  include/limits.h     |  3 ++-
>  8 files changed, 25 insertions(+), 5 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
