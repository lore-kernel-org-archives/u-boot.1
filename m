Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A9CC7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 19:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6162282BA1;
	Fri, 20 Jun 2025 21:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YPIYrkQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F93382CBC; Fri, 20 Jun 2025 21:43:09 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DEC680C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 21:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-710bbd7a9e2so21684437b3.0
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750448586; x=1751053386; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3cusA/BW5FA5hAGc/6BzQqlF4VUz0gZ2M7NQNCfjhY=;
 b=YPIYrkQkT14KJPCc+e/ll0K2Ub05DZbNrhPK8OaUc8hHazYS62TbubZtN1RM3WPCMu
 pPk61pA3pfBjMJ5Ew5h/wNrJ4vTp1Zgv4D3JlOQ8FQrKSPjpxYp+BD8rzLA/xUQbcN7H
 SgXqW1QbI7uvQQzRr5DcSf+NSWK4YxN3ArBoXspe0boA4lmjFJjENt//C8cw7G9smf8T
 WBosIX9xnzIu4HP3E0lmMF6PRYGN1tBLQTvlgYliVOaosyu4j2MDCXNdpVsCbkX3QhUX
 kksT5VrGUkcwwX6JPUtkirYdUpBy+xYwNHfDboI/YGzxYTInqP4x9SVQ9D7FKm2foGKO
 lrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750448586; x=1751053386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w3cusA/BW5FA5hAGc/6BzQqlF4VUz0gZ2M7NQNCfjhY=;
 b=uYc6JssciBvIqsM6OsKizT5qcIclGRIY2/sq5szU74RW54oAve3iJlhJGNim9hYvo6
 31BAe1fcY81eomRSakrAvuAf2tfFbVu72a0XBvrY/9brQ3P+IPsW3JtmMuowNtRQoWgU
 g97Dgc/yTlXu6xV3UvRoaY7A9WmvEsPUyRL/iabEfuqAD3sPO6k2TApP3DhR3WmrzcHS
 DtHMt+wJd6GfUCKjE737XfFU2e6zvtf6ZbtR0x1ZU8QgFw1Cd3vTiEQWOqU05zVm1Yd/
 WgWn9IffnxATLo5KUWL5/f8B7VZtaMfra+xmhCdQVxdThRGMYtRMyr6RGUBs86OXgihI
 y6DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4k7yzy2AQ6STT/JAjPoeBe3cOshg948aDULqRdsdn+ozl8Fb26+2I7BszpQGb3Xh5CKHj7mw=@lists.denx.de
X-Gm-Message-State: AOJu0YwDQfRz9PE7aNCAqaUujKh4V0yfpyUsDTYtR8v948fa9dcoJe1/
 kuu6HTJF2xKKC9FP8PfZmUXRKcbPuvRF7ERiDSIJx2oSsqW75vGFLVoYukTA6NyIpaOIdm8hGbM
 7lhID/8s8dVt1IBJc4yphz8ufezPb3LUfTJQoA1vSew==
X-Gm-Gg: ASbGncvyKCTOD8FPkHv99NA3/O6mVEIIUSE1qgQj2MnpNAbnmJxv7Hchl9orPUbikJV
 I1z/t9UqkjFnouk03KjXUQSyf9l1nz+0L4Qv4wxvmpn5XkLAFrCoR1SvhnNzGI/eZ2gj2rAiMws
 GvRol7gayZHP5M2BU6VgyUfJZmGCIbH/X2PwLR0js4rZutGNrcfwghXf+yZIvfthTYtEj6S6L1+
 4zFgA==
X-Google-Smtp-Source: AGHT+IED4hi+Oem0ZbHKvUJKP6F3Eeeq9z5xsmO55jCYznHfXjR/sSb1ZtROm7iKrQj/MpAEB3LgLOhLX4itPArLUnA=
X-Received: by 2002:a05:690c:c14:b0:702:d54:dd28 with SMTP id
 00721157ae682-712c64e56edmr63569117b3.32.1750448585840; Fri, 20 Jun 2025
 12:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250620185010.11400-1-semen.protsenko@linaro.org>
In-Reply-To: <20250620185010.11400-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 20 Jun 2025 14:42:54 -0500
X-Gm-Features: AX0GCFvqQ9bj3nUDCb54b_upRWFkh6Krs3B-fxqaZJLNCYuBthkCagTkxd7jO1Y
Message-ID: <CAPLW+4ksWWvGtV-u_CuxOv_FJjMR980Fs1jxasv0AM9sQjtHxA@mail.gmail.com>
Subject: Re: [PATCH v2] board: samsung: e850-96: Load LDFW in board_late_init()
To: Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <promsoft@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Minkyu Kang <mk7.kang@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 20, 2025 at 1:50=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:

[snip]

>  int board_init(void)
> +{
> +       return 0;
> +}

CONFIG_BOARD_INIT only appears to be present in -next, but I'd like to
target this patch for v2025.07. *If* it's possible, and it can be
applied to both mainline and -next, I'll then submit a separate
cleanup patch for reworking all empty board_init() calls w.r.t. new
CONFIG_BOARD_INIT option.

[snip]
