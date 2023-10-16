Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E471CDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86CA286E16;
	Mon, 16 Oct 2023 23:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d1oOMvMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC65185423; Mon, 16 Oct 2023 23:54:57 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F3ED868C0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53dd3f169d8so8521884a12.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697493295; x=1698098095; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UwoENVq1Stkme0zA0e2LXckG1W94d5TwYu4Du5g4+NY=;
 b=d1oOMvMfVH5MIvK2AtIjCWLsXlJMOdKbeygCu63B2Epd9KWqyYl5dEIKQmAqKk9OZD
 T5dvh1Li0QMVu7UOYCymUcQyZVoQU/iMDs1QkaTiesSTV+X2nCV6O94WM/E/DyUx6wBV
 bLgszPxYcFVGycNQPCpv04OKc6vFmuDLaKbOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697493295; x=1698098095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UwoENVq1Stkme0zA0e2LXckG1W94d5TwYu4Du5g4+NY=;
 b=GXqFz19eheGMwE8BDMymlCmltI77IPxpTggsHn8DGCKn3X/Kx7eOBloPc1bLZ0xRIl
 +r5uyHNSQBjfyXAKdd7h/VDUzjv52BLaas9zotFFO3tx35iREChTarriqSko11CpWR66
 nWMXp6y2nP6Ex8cK/Vodpp20MgbJ4PYjeJTj+6n1NCGGKuwsCZhHu3ibTPxf2XgAbh6N
 OZYVXK9DTqOa2Xa6UhiDbPKLvwjbcXi7qLZlR3WXrZYDRX/gO6ZgC4P2hhsnN8PS4bqW
 ZeYJiJ5H+xgKUm22u6Pc5mixMQyS8z2LOvtHICZbvPSVBfuI6E64VYjrjOy27Q5NdtFG
 4BEw==
X-Gm-Message-State: AOJu0YyDHMetIWmqTa7bMtlUJGbvtjPeboWhjrLTmTg9S+LOmAvS9w2D
 YK9xAe37IcmnZ+pNDIBHnTsBx+WbV9KbxuV2uVE5ew==
X-Google-Smtp-Source: AGHT+IFchksVmpLV34Tp8S/I5r7tZ6TqYpxCucFJqdRkWqpZ/jjVHYh+SkVB65CUyWFbTTIydXKEtF0vA44y+XwFrbk=
X-Received: by 2002:a05:6402:26c4:b0:53d:ed7a:11f2 with SMTP id
 x4-20020a05640226c400b0053ded7a11f2mr444199edd.38.1697493295383; Mon, 16 Oct
 2023 14:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
 <abd6a9d8-7e38-a48a-b298-08f19444b5fe@gmail.com>
In-Reply-To: <abd6a9d8-7e38-a48a-b298-08f19444b5fe@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Oct 2023 15:54:43 -0600
Message-ID: <CAPnjgZ2mW8V29sxzxB=JeCXkqPiD0A-jFa-78WZi+Nv5HyJhvw@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] rockchip: dm: prepare rkmtd UCLASS
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, 
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com, 
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

On Sun, 15 Oct 2023 at 16:32, Johan Jonker <jbx6244@gmail.com> wrote:
>
> Prepare a rkmtd UCLASS in use for writing Rockchip boot blocks
> in combination with existing userspace tools and rockusb command.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>  disk/part.c                | 4 ++++
>  drivers/block/blk-uclass.c | 1 +
>  include/dm/uclass-id.h     | 1 +
>  3 files changed, 6 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
