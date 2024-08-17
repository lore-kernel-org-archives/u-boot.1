Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088D2C52D7F
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 16:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4030088C62;
	Sat, 17 Aug 2024 17:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lxbfRHAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A18B0886F9; Sat, 17 Aug 2024 17:58:39 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F11B889B4
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b95b710e2cso19736716d6.2
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910316; x=1724515116; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bf3p/2cZs8j4nwWnODgpH8ZQwjP5nSkASD319UTTelU=;
 b=lxbfRHASGE/Is1bwZx5CM1tLx7ptui9W9l5UvuylpDeaK1ScwRRPCNtcsJCAi4nuBh
 HKMK9QXywyuFK5I0fDbSjqM+e8IIY0Ui6NjjJRo5dmRxQfxWvcXVW0lmwhKJZVS5MZMn
 lf2awU5gzdJHN54MH1PpYq8oZHpwRna0SOF/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910316; x=1724515116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bf3p/2cZs8j4nwWnODgpH8ZQwjP5nSkASD319UTTelU=;
 b=PrITAjiuz4f0xcu54aEB7a6847i5OSAWAGdDcV9lbCahAnbjnYuq7ZS9t3tioXrzW6
 80h7aL7RQpvr4yBc/OaSvXkQwvA9vPKxw3DzoFSaG8TErsaFg0sDjAIjvCjXPZ6CT8eQ
 C6xrpnlmhmaeWYc90vS4MHg91UsIkq4KEHP3/+0ylvu5fspC3Mg86B000vckw3pV3PTG
 HwcVfbsdU1heE7QHimLv1S9mwyXCFrgR3DZSoExTOkgGY7QisHfvRnsFA9K7EsNKD9yA
 dFZa28vGYdHrzn7NZcPpc70L4wrhkTUpGQA4lXqudTJdnuReRwZwcQy/dnTAM4kW2yPG
 GC1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIXVgz/8WjDyocqgfzQsbRLBlNBcUi73gxZdrVYfyoZYC/V+9NPUR78CJDZfbT0QGo5F/VnItx8e7V8+qJ4HUtYtfOZg==
X-Gm-Message-State: AOJu0YwiXz5Y936rrNhSKVcXYMJvJutT6Y7RhANCnme+NxYEhg6x2h4G
 fjZdZKYh27nYh4CcxL3uIwBh6ggzT7LrwbIQf4d9IqdUfEMaMwduAOZhGHcp79snzfGk8qm4GIc
 SnthN5MCsKH5OENmqq9eUReB8Omh9MpCa/OEv
X-Google-Smtp-Source: AGHT+IFLdlolzohZ011HmN7XFIqQevioi/ldfVYZ2iDY9KFgj+PHkXH8q/S5d0UYAdGhiczMGQMj7PXM/nVM2dLN44Y=
X-Received: by 2002:a05:6214:440c:b0:6bf:9654:2c5e with SMTP id
 6a1803df08f44-6bf96542da8mr5192136d6.55.1723910316450; Sat, 17 Aug 2024
 08:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-9-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240814103145.1347645-9-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:58:25 -0600
Message-ID: <CAFLszTj2WH2m-6BP=+FXM2uzU38U_jWsXH96Jp1J4=r_15WY6A@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 8/9] net/tcp: define a fallback value for
 rcv_wnd size
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
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

On Wed, 14 Aug 2024 at 04:32, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> Some driver implements it's own network packet pool, so PKTBUFSRX is zero.
> This results in zero-size TCP receive window, so data transfer doesn't
> work. Avod it by setting a reasonable fallback value.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  net/tcp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/net/tcp.c b/net/tcp.c
> index 7014d5b4f43..f0889d72d44 100644
> --- a/net/tcp.c
> +++ b/net/tcp.c
> @@ -28,7 +28,11 @@
>  #define TCP_SEND_TIMEOUT       2000UL
>  #define TCP_RX_INACTIVE_TIMEOUT        30000UL
>  #define TCP_START_SEQ_INC      2153    /* just large prime number */
> -#define TCP_RCV_WND_SIZE       (PKTBUFSRX * TCP_MSS)
> +#if PKTBUFSRX != 0
> +  #define TCP_RCV_WND_SIZE     (PKTBUFSRX * TCP_MSS)
> +#else
> +  #define TCP_RCV_WND_SIZE     (4 * TCP_MSS)
> +#endif
>
>  #define TCP_PACKET_OK          0
>  #define TCP_PACKET_DROP                1
> --
> 2.39.2
>
