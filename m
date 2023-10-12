Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D576CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7611486EA3;
	Thu, 12 Oct 2023 05:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kiJpkvlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8751586F09; Thu, 12 Oct 2023 05:45:02 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A9386EE6
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a7ac4c3666so6823487b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082287; x=1697687087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ymumAyVlSRfaKrBAtsQd3Kq5hydW4MtfQH5cnkCqZmM=;
 b=kiJpkvlJzWaMiDiMEqZWIq9hpSkBdvEas31lANNdEzhtQNhQtznFnQv6L9IpXgVSbC
 hj3YGpbIlcCTThPBpY5LwuZNVzmLM023zqm0QF4ycCJfCfkyukzA9WBnjXdGPiVKmqUL
 cCpCGaeoyzU1Z9o2ID8j06m4qw40O6E0EGI4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082287; x=1697687087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ymumAyVlSRfaKrBAtsQd3Kq5hydW4MtfQH5cnkCqZmM=;
 b=dQz1QyEweuWbuBoZuQrjdYbkwvxhRHyxI02iwZQET/revlAfBXq6XqG2KCO2JUfiW0
 06JnFzz/wBFGUrPB9I5+kc1Czb+SDNXMUUEgjFcMruC5OA4rFxjiSg184cgUa+9AYWLk
 6sJPsP/MWnsUqLEnPP1Ilj3BitOsjno5COx/LldzubZ/kYu6KFDQtuJDWgjZGyzY63YP
 /XksTwOCqEOsi2bbiGZcbSXNPIPocAmkHfgNQaLcqEHebCq29cqBX7Thq1a1mYAyN11L
 kpSA29TmgwKNUuMKzPeDrFexxb3ZgN/Z55ut4BaeKwkj2JYxzdykVAAmFF3ceFQJ7Mgi
 bnKw==
X-Gm-Message-State: AOJu0YxhcpghhyuL09jAvw9BdkYGCA6Dp28QTVND6g/Id/SB9KS1n2JZ
 8fl504H2RJ9ciEs8Xw7OCPJcfiBQavuJiM48ywz30Q3nd6eRQMc4MY0=
X-Google-Smtp-Source: AGHT+IHAPV7/9FxfAn27u+viA25NqrYEcSXEXjB/emoEgZbP/JxKjtK1GGKKrNZRiz/aVIq/QPiN6mpueFZHHpPRNgE=
X-Received: by 2002:a81:6c4a:0:b0:5a7:bf52:8bcf with SMTP id
 h71-20020a816c4a000000b005a7bf528bcfmr7117991ywc.5.1697082286558; Wed, 11 Oct
 2023 20:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-19-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-19-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:10 -0700
Message-ID: <CAPnjgZ0b3WVfDYsL7CSswYb28FXecezM51c7Rzt1h6BNeT8TxA@mail.gmail.com>
Subject: Re: [PATCH 18/26] test: spl: Split tests up and use some configs
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>
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

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> In order to make adding new spl unit tests easier, especially when they may
> have many dependencies, add some Kconfigs for the existing image test.
> Split it into the parts which are generic (such as callbacks) and the
> test-specific parts.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  test/Kconfig             |  1 +
>  test/Makefile            |  5 +--
>  test/image/Kconfig       | 20 ++++++++++
>  test/image/Makefile      |  3 +-
>  test/image/spl_load.c    | 76 +------------------------------------
>  test/image/spl_load_os.c | 81 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 107 insertions(+), 79 deletions(-)
>  create mode 100644 test/image/Kconfig
>  create mode 100644 test/image/spl_load_os.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>
