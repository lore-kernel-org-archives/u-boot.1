Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF63C71153
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1274B86D21;
	Sun, 10 Sep 2023 21:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dvPQw55f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E4A586D13; Sun, 10 Sep 2023 21:14:51 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6168086CF5
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d77a4e30e97so3345786276.2
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373287; x=1694978087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AoTmSpU9+hJIeYy5TWMq4SP3tVazYoHaBXCYKJiHttA=;
 b=dvPQw55f8kYiBgmitUPBvnTkEhDwTchl5jINo+rkk/BVakzCqOtWlFzJpfJ9Cw/No6
 EbUwZ+6/FXR65GOup9vynZB37XUxmNSwGc/XoAS8yC7W4GLiVmsno0D6kj7GNpgJUNSC
 oJpnuiwPK4tvKDeedcBlirRVYz5yFnOV6oTbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373287; x=1694978087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AoTmSpU9+hJIeYy5TWMq4SP3tVazYoHaBXCYKJiHttA=;
 b=urZPiaGZB67NHr0Io6bGBvDdoYxBMy4iV6WxnTul5exznFag8PpbCXE+/YTZ73aCDr
 9uirryticRc6mE+38oHTi4T69/vnyBYf3l42atMHmxMm30wW9Q38ZJH2GcEQ/wtvUdlR
 Gb8qTO9MpjDLAH9ySZoiygjf1VOx2LPtbTyxk+JaaHOkjNfSFIw7nkLM9He3GP0/25ZX
 Kyh2zhN654lCF24GIyGZx1fz7QLoqmgqM07EttqUqDzqi/4mwLahvb16oS1fSEAS9eJd
 aijYAOT1kQz918/6LpcnJGhP2KjSnBZQN/FFxwwvhhLZXAnnVhwRNYfaPrZy8ChfGLnt
 wBfA==
X-Gm-Message-State: AOJu0Yw4qQqOUhELFH92o20vL0dOHkYuIwXtg6YnsxmasOuk0IwUPCke
 CdtFAgXVi/UC+TooI6lpwxZ/tOUl5jttS55jvrmY6Q==
X-Google-Smtp-Source: AGHT+IEefP4fM5BZkmOoCa96Ne7TS5SRxKNJTlBrIyAm4SXprlTyHrAO+JIM/Fa7M8srxCKPPWAKrzjsFIi9GM0cTmU=
X-Received: by 2002:a25:97c3:0:b0:d0a:a1fa:b8e4 with SMTP id
 j3-20020a2597c3000000b00d0aa1fab8e4mr7918377ybo.38.1694373286956; Sun, 10 Sep
 2023 12:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230908120002.29851-1-sughosh.ganu@linaro.org>
 <20230908120002.29851-4-sughosh.ganu@linaro.org>
In-Reply-To: <20230908120002.29851-4-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 13:13:32 -0600
Message-ID: <CAPnjgZ3Zi3hmQg7d5+0461hRK+5O_V89PY=QxMwQarhhqUW6VQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] binman: capsule: Generate capsules through config file
To: sughosh.ganu@linaro.org
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>,
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>
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

On Fri, 8 Sept 2023 at 06:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add support in binman for generating capsules by reading the capsule
> parameters through a config file. Also add a test case in binman for
> this mode of capsule generation.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>
>  tools/binman/entries.rst                   | 35 ++++++++++++
>  tools/binman/etype/efi_capsule_cfg_file.py | 66 ++++++++++++++++++++++
>  tools/binman/ftest.py                      | 29 ++++++++++
>  tools/binman/test/319_capsule_cfg.dts      | 15 +++++
>  4 files changed, 145 insertions(+)
>  create mode 100644 tools/binman/etype/efi_capsule_cfg_file.py
>  create mode 100644 tools/binman/test/319_capsule_cfg.dts

I think we discussed this some time ago. The problem I have with this
is that it adds another way of specifying the image description,
separate from the binman definition. This introduces all sorts of
problems:

- the question of where the filenames are located, something which
binman tries to handle cohesively
- binman has no knowledge of what is being put in the capsules
- the resulting fdtmap lacks any information about what is in the capsules
- it seems to create two ways of doing the same thing

Binman can presumably already create multiple capsule files, just by
adding to the description.

What need does this feature meet?

Regards,
Simon
