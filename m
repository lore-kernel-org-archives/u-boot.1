Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B448C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6098770C;
	Sat,  2 Dec 2023 19:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XhWM8//z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 764C48771B; Sat,  2 Dec 2023 19:24:19 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B87B876CC
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59b5484fbe6so36053257b3.1
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541455; x=1702146255; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YgSSlh4sqnxBrvd223rYf14dTl/FQwj+2epVShN4UYg=;
 b=XhWM8//zOqex+CFSEskMaCDKytsFwRQnmklvfDZvNrjyfL9+gVHmhBSYxOjntyhdqF
 c9nzeMHgLYcAfZm3vd9t2KCAfiALIAyUZIs8RPKtBINvWtwEITmCJL5qHoRYwJby+/5d
 ghXvj6kYLW4cbhUQQmfmgzM68A1wRaN4khEGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541455; x=1702146255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YgSSlh4sqnxBrvd223rYf14dTl/FQwj+2epVShN4UYg=;
 b=RkdbiT4ds00ZrC740huHzwz/psaQ9FNEVf/J+9f6vhRknhRItARPdsxqup/k/Y0i09
 M3+afulM4JnsbiPOTjQDuBlRo4ov8NEfYiXeTAu2Egb+gORibnAtE78apqhTVaRE1HuW
 yOOIDYGXHsIsSzYOmz6tPWpOTv50kewSGGl1anDmJzI7haoX6hoZYra4gHj3OVUTgdhd
 LAgYItysp00/nBD16q2hlLlzjHzkAcc6i9dAaY1tzLBcjp1ELMf9PSZjJtMK+dWIz+lz
 +YihQke7b0NM/F6ALOWx/MlAcR3BAg3qqYIKZaFi6IcRtXPDp/tjq4QERPDFXuRM5mGZ
 BRrg==
X-Gm-Message-State: AOJu0YyAdI7Eq+sX/lIWrsFjeBr+x0869i7FtSpDFrd1ISI993OdEU88
 6E4En0GIYcVbXhuNpxy9WaHxAuCklUrf1RzJoazyNw==
X-Google-Smtp-Source: AGHT+IGFNf+IOWSg/wW2S2/Ij/W+QhIlcFB7Nj/HjCbsgb5qpVAk+xkA2FQ06AtN4X6jUMleaMEAv6JEsjphML2B1+M=
X-Received: by 2002:a81:b665:0:b0:5d6:c70f:7798 with SMTP id
 h37-20020a81b665000000b005d6c70f7798mr1510692ywk.35.1701541455227; Sat, 02
 Dec 2023 10:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
 <20231121152740.24783-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231121152740.24783-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:23:15 -0700
Message-ID: <CAPnjgZ1Vh0SNXyN6QVQxsWEFkZRdeTF8T9VQLY7yyujdr4Q7UA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] risc-v: add ACPI fields to global data
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Yu Chien Peter Lin <peterlin@andestech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, 
 Asherah Connor <ashe@kivikakk.ee>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Tue, 21 Nov 2023 at 08:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add fields for the location of ACPI tables to the global data.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         no change
> ---
>  arch/riscv/include/asm/global_data.h | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
