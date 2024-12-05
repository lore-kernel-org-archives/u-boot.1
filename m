Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA48E7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 17:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A0F89523;
	Thu,  5 Dec 2024 18:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ioSLYfQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3C1989338; Thu,  5 Dec 2024 18:58:03 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8AA689523
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 18:58:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa62f1d2b21so93195366b.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 09:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733421481; x=1734026281; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MvcL0WuAN4wSQHIX4G+ZqU5fKEZeBBkSkKim/K1RSPw=;
 b=ioSLYfQdHjiBX9kx9HqHCuJqHZKSkCXDJRIwC/32E2RXujUr5tLo8qO/y767qCZ74j
 hk3b0CUbANwG8FFmjErM+FsvH9hbNxbYV9SWMrSDYGODA/ysbl5L8pLLaeNAoMtLmH/z
 YqCq/1O7lWJCzQddNvtGJYzfpilQAPHMQhiYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733421481; x=1734026281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MvcL0WuAN4wSQHIX4G+ZqU5fKEZeBBkSkKim/K1RSPw=;
 b=uZBi9h1T4LWGF2niB2pBrz/COvTVb+Lv0cpqpLULKAxJLhPzAauln4hEFjvejAZQ/0
 +31OsOxim05a3MtYi4jttFbiRUZfVXalDXLP+gt3ECJzcFyaDbVrmzx96F+FSwQknz7X
 4jmVMGi/hkTdb8r/5PTF9LDEjNIoMuSaesPvdwxnXyrBKqQJ3mRJp3BLnf5nZd6jDEFY
 9zxIwYZGZY2OgCUD4aBxxkud35Lt2nY8T6yosWCGfyiAjZ6dtSdBhaa+pCS2lWgpF3cy
 a5NSNL5ilyyZUvD5OmVhuBMa7sbRRIuhHljO9n4FtDjsSy5Tpv3iFP3bpvMY/NNn14VI
 QYNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk+z3xOlMjaGsmkR/kh8c1lz6Xm7hbJKNHFjJnT5vDbifDpRgA2+FLDw1cJYjL63vzjUdJE7o=@lists.denx.de
X-Gm-Message-State: AOJu0YyXsZXAiwFOlkDylRr8pp4zEALJA6OajEMgDMB6JgcsQ+I+C4c5
 ZtRDfJfEwbBbUZblumcgBFAGFy69Zwi+MXFYDR10D+exGBtE2kh5MyFfAhojljXV0vR6ZP7yAFR
 HP+DNHomBdXF1jDVjbN9A/Ebx1Kv2yS+SvgFC
X-Gm-Gg: ASbGnctMHBHm3qcfbc2oDBqwgJOre/XEsd8Eg8Dd6UkIIhObGBQm+W8NS/NWkJjCyyG
 8ffJmXCHdXi15eAyi4RK1fdzEDIH1gGPp
X-Google-Smtp-Source: AGHT+IFw7rMuCzmIeCsWS7RBfjro2Jj/oySSWM7fp0TQmNEDfyNyIfhSAu+3qNHgm3K2oOjgSJWEWtBZ4IbrrElSmPs=
X-Received: by 2002:a17:907:784a:b0:aa6:291d:a3de with SMTP id
 a640c23a62f3a-aa6291da469mr216866966b.18.1733421481356; Thu, 05 Dec 2024
 09:58:01 -0800 (PST)
MIME-Version: 1.0
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
 <20241205-ge-mainline-display-support-v2-4-4683bb4388dc@bootlin.com>
In-Reply-To: <20241205-ge-mainline-display-support-v2-4-4683bb4388dc@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Dec 2024 10:57:46 -0700
Message-ID: <CAFLszTik989_5fxTKzTQVp0ykB-fJiJiOcG_Hk+yZ_7owRJ2wQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] test: dm: test-fdt: Add checks for
 uclass_get_device_by_endpoint()
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

On Thu, 5 Dec 2024 at 06:54, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> This is a new DM core helper. There is now a graph endpoint
> representation in the sandbox test DTS, so we can just use it to verify
> the helper proper behavior.
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  test/dm/test-fdt.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
