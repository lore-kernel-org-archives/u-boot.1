Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D8CC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A794F8773F;
	Wed,  8 Nov 2023 05:26:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SqKYLSxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B84C78773A; Wed,  8 Nov 2023 05:26:53 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CEC087725
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5a7dd65052aso79688877b3.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417608; x=1700022408; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+McHZHc1F2/okqfEyJcafyb1to2TgbPaofm6aFmt5iw=;
 b=SqKYLSxWsIouhMVV7RW5yKrcCYkoDKt14LBSTE/HCmxexGl8G5M55DdjhouA4Ust0O
 tUfllBxs6Iw+2OVlWRVo7jhOS3EpNrnxdiZbMCZ6qrUZ5DU6+TW7Vv/YdxWeC3N7Oi4D
 P1rTd7PDOx5yfPgVofm0VV7C+SqfBeThPAQOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417608; x=1700022408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+McHZHc1F2/okqfEyJcafyb1to2TgbPaofm6aFmt5iw=;
 b=dy4HaMgFk632m6YvlJEOuE2aSx1DjzRR6PVGDc0IxaZYxDnF2gQkvFpXMWbggkfaVP
 JjGwdulIl+ILLz7LFezj2eT7oo+f5rGDVIbvXaurfnjsipu4GxdFCRLaRaiaPhF92BNx
 qECSdYXmGYyAcet8SlvzXRF26TBrM0NPsCAOFswzQAMxFGyik+y+rzVbb76shMGkD/k+
 sgxw9YqQGhk7SK8WtThVn/yrbueUybyfR/7jU7AJod6DL30Dh13/HfTDkvL5uCslAwCc
 s192MOhEdX752W0gaISfYNfHTuF1L9+u8FsBL6/bc+0r7Aza0zs3zzZUKydmDppPHn/q
 zt8g==
X-Gm-Message-State: AOJu0YwEu5RAO/f14YVk/F45iRbY906G8OSCQQLjTelgS5flbetFpain
 bt12A9CpX9P1I5K0+573HCvBXxvSRjqr7eb8p4lL3A==
X-Google-Smtp-Source: AGHT+IGNtQbJga+Zevjq5xeB0MzNmp7DcERJLNc5chfzDnVdvTf4Grqe8Tk9qvQWsKMdGDKMjthArKDaUAnR8FOwkdc=
X-Received: by 2002:a0d:eb01:0:b0:59f:4f56:59bc with SMTP id
 u1-20020a0deb01000000b0059f4f5659bcmr710587ywe.42.1699417608078; Tue, 07 Nov
 2023 20:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20231107201349.5775-1-semen.protsenko@linaro.org>
In-Reply-To: <20231107201349.5775-1-semen.protsenko@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:47 -0700
Message-ID: <CAPnjgZ0HD41x+c4je61AkXr6c_QUu2-QJCdHrxLgDLrQL7B9Pw@mail.gmail.com>
Subject: Re: [PATCH] serial: s5p: Use dev_read_addr_ptr() to get base address
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Johan Jonker <jbx6244@gmail.com>, 
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
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

On Tue, 7 Nov 2023 at 13:13, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> As the address read from device tree is being cast to a pointer, it's
> better to use dev_read_addr_ptr() API for getting that address. The more
> detailed explanation can be found in commit a12a73b66476 ("drivers: use
> dev_read_addr_ptr when cast to pointer").
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/serial/serial_s5p.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
