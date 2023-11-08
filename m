Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D021C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 144B5876F1;
	Wed,  8 Nov 2023 05:25:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TAXrNUBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD8E874E9; Wed,  8 Nov 2023 05:25:30 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27562876F6
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5be8f04585cso1054747b3.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417527; x=1700022327; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gi4G6PmOjehxuEWcxB4x3QohzdS6SidmfgPHSLW4XPM=;
 b=TAXrNUBP38cGjQvk7nvkFQlHl3rtBgiI9Q/Z85AT90r7pDjrs8OgLMUQAeMXCn3OpH
 XMsMXRxYAEN0ZuNLhyRIbMjllSQcysw4qeiBVArrjehnF7QMuytIHsFnueF1w02e3FZI
 LL8pjvMVvKC5EujcJ6ePioVPuRoz8Da/bUGpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417527; x=1700022327;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gi4G6PmOjehxuEWcxB4x3QohzdS6SidmfgPHSLW4XPM=;
 b=OS1ZbcY49PcYrCoNACWQP4EqxiwDpHc4g//VZYhvj/1xhvDqzuruhwfMhWw75XafWr
 Oig3AAyIZcJqQnVsYzsISl2gePqm1XCeuKLxZfJzBO2iJPN4XHiSnKU1PTVgryqIgCKL
 /rClD7m5949JLE8vFeSk9KLW0eBZ4KkRfPdN8yaFICaWiGQ6VjNlmv02xvpgUkbCxXtb
 0TKbND75UdZlUXk6BqaY3QAnWwl7hJt1yTxoHkSF57+gbJmOHuyUsPKt4HcwSeZNjQYJ
 Z+oCOyWEEJQF7gw1arVOs6LhgTtVHXe0laEY2GHcBKVxFNdt2ti4RP2jpfPmKMl5XylC
 dHIw==
X-Gm-Message-State: AOJu0YxrEJdoCZLMRdh+0AwEuarglxEcfc4mbpJa1yOfzXvr6nChNanF
 HMpTkJkf0c+PC1FhD2267d0BqIo6Rbq20Wx3U+04AQ==
X-Google-Smtp-Source: AGHT+IFB/bXhea5j3BmicFTEB9FomE12pjmXDSlD4U2g0YJNijulL4GJTHawLmrUGkzrecV/snw/2W0/2hnmWsuXC7w=
X-Received: by 2002:a81:4e16:0:b0:5af:97b6:9def with SMTP id
 c22-20020a814e16000000b005af97b69defmr3566308ywb.24.1699417526722; Tue, 07
 Nov 2023 20:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-4-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-4-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:42 -0700
Message-ID: <CAPnjgZ1jXKCv2wy-3mbROXD0P2+gH066Dh5Zyvb+txnkFZgGXA@mail.gmail.com>
Subject: Re: [PATCH v6 03/25] spl: Make SHOW_ERRORS depend on LIBCOMMON
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
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

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> The purpose of SHOW_ERRORS is to print extra information. Make it depend
> on LIBCOMMON to avoid having to check for two configs.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>
> (no changes since v5)
>
> Changes in v5:
> - New
>
>  common/spl/Kconfig | 1 +
>  common/spl/spl.c   | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
