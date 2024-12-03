Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D0AE74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3917B89662;
	Tue,  3 Dec 2024 20:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N+oj+L3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8EC4896D3; Tue,  3 Dec 2024 20:46:52 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C96689185
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e9ff7a778cso109263a91.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255208; x=1733860008; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n7RmLuMUA7sdrZCmdT1IxhtSGNr5GTbzfl1Rd8BXMyk=;
 b=N+oj+L3XppLlKBo9tfrbvIkVj8/YLBWgnzR0yn2CrFQEHsBsY1j4UKNMJ2K9xL95RK
 FLi9HtFUD8lTVVPnHekI9vJJT9RnanzXli4lYEeu7qGCA/KJdj0697vMz+eWkBq5Xcpk
 V2RuZSMpWlMCWKbFKOVd/gvOhb1wui6DQHY10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255208; x=1733860008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n7RmLuMUA7sdrZCmdT1IxhtSGNr5GTbzfl1Rd8BXMyk=;
 b=OKKPH07VJjqkQhfSEmR7uHN3rkZ68EPB20pem2ovrVn9G2Luzn25UGSal1cl3nb+SL
 +Je93mAsuMQpI6KERR0dbJxHtwBnb+GmaY6y27B+e9jlvtlhgIUPBa+gSbq5JEFUMmX2
 hWdc9caPUCR1L7WAHwy0A7S1t6cYt2cbuJwIe1aO8c0bEf74d30S8xLSDbS9vISAyIKJ
 X2WQM8vrPfabahFG7+PFCGEL0fcH6hPqR1eCX8NfiuDQLl6curyoFQHiKEfWQ0n0yfQC
 lbpagxcnQe0R7GgCOKtuR2m6mDyOgQRQHbb8fd8/DcuVZdXIkx2e1Pxg011PUrzV/usj
 kKTQ==
X-Gm-Message-State: AOJu0Yw+fYHlqgzjArl95aUEo71i0lzZXPvG2gzD1FPISijT69QaHUy1
 5vhFBO6lfzRCcgBh37wzS4gkiUF9M9npDN2bGooKMoTmMmE7GKcFMqbANf3awTJikKgeyluwUP3
 87xJ6xXDIck2rh/7i6wEd34oq9PBf5YYtQMjQP1mWFlNUUVQ=
X-Gm-Gg: ASbGncs6xph5/ZBWNr3ok2LU9mDz/MI3ecJcHIPLqR128NhLDuDCfFi1ZFZaRUmaTF0
 fuCcf0OpeV12Em2BE8ZzlwlASV/IgcnfF
X-Google-Smtp-Source: AGHT+IE0SlEGO837agRGt2ffBvZRAf5U4Bcfac3xAV/YqVyLjhEDsth0o36WsB5eLAUnCEWG5A/0KCHrBZ/nJVpNpNg=
X-Received: by 2002:a17:90a:f493:b0:2ea:4c4d:95a1 with SMTP id
 98e67ed59e1d1-2ee25b53eb8mr36757179a91.17.1733255208064; Tue, 03 Dec 2024
 11:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20241102221737.547938-1-sjg@chromium.org>
 <20241102221737.547938-8-sjg@chromium.org>
In-Reply-To: <20241102221737.547938-8-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:46:02 -0700
Message-ID: <CAFLszThZrcCGayAMmkqJuirQDuT5VrHThS8b7VT0oh0NuaSN4g@mail.gmail.com>
Subject: Re: [PATCH v3 07/25] common: doc: Drop old LED support
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 This contributor prefers not to receive mails <noreply@example.com>
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

On Sat, 2 Nov 2024 at 16:21, Simon Glass <sjg@chromium.org> wrote:
>
> This has been replaced with a new LED framework, so drop this old code
> and documentation.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  common/board_f.c | 22 --------------
>  doc/README.LED   | 77 ------------------------------------------------
>  2 files changed, 99 deletions(-)
>  delete mode 100644 doc/README.LED
>

Applied to ci/master, thanks!
