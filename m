Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE820C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 17:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A6AB87751;
	Sun,  3 Dec 2023 18:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FgYQubwd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDC6187519; Sun,  3 Dec 2023 18:44:53 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC5D87626
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 18:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-54ca339ae7aso833799a12.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 09:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701625491; x=1702230291; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mAMvnbjeDvitFnwRlA9/kKXskYvtjTCK754nVHYw++U=;
 b=FgYQubwdURVelsMXnclHxZem9w5j356gQpRX+IFlt+9WG3771D3XTFlA/GOzxXi1Ze
 R6JtkaJ/4IZzxTSUND1lNdNGyM1TT7bC0tslCUNIo8xkB2oVxU0i6ZxBlavg5fkXMY2+
 RHGM/nKdWSO7A3J4hvPwK6xsbGSlhySiXuq98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701625491; x=1702230291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mAMvnbjeDvitFnwRlA9/kKXskYvtjTCK754nVHYw++U=;
 b=G9MXvEd71Ai/9K4yI0xW8OyT84321m7xKC3h5gzJyvOmrhwOiqULZmlpJw+eYNcvJS
 R+rw5diz/eRggldEOcrNC3WtIl65A2lvt1zKwAUXIQhvm/eQAX8dawGm/xPZZ6UC0J4T
 AeCqNQ3XP+90U+hs5d3dG5W07iyyiloZndJdKJRQYsdKZDqCMRnAlvG6eXt6PohUrW+F
 Pxb0AJi+qHdLWiCtHyJ28wDp3zf/XR6BtYtvHDqLi16/sTJsLQ153LjD2cTW5ls5hDX0
 HR3mCD/+xExeuKJTOzMrLAm1OnuExUm6Y2N5QNYb92Lwu6N7dSuIEht9/nW+hQ37TMyl
 qY5A==
X-Gm-Message-State: AOJu0YxC2dj6yoAcxyKfdQzHTBGjahlwmMwsc6Mpfpt3TTvTtP6UlXuA
 /jjUU/m2m5lpsu2j6AcrdsUhqRmXH+hpnAh3eWBZOg==
X-Google-Smtp-Source: AGHT+IHi51DsTfnugN5A94vW1+JfUyr6WCRjSM6hsgDd1DlSenSpMsXZVbfbq+yay5bGKJwV7mS+ccnF9Wf3T5uh2Rg=
X-Received: by 2002:a17:906:18f:b0:a19:5f9b:cb3c with SMTP id
 15-20020a170906018f00b00a195f9bcb3cmr2765934ejb.21.1701625490866; Sun, 03 Dec
 2023 09:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20231202234109.208243-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231202234109.208243-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Dec 2023 10:44:37 -0700
Message-ID: <CAPnjgZ1__QvjN2C8Gc_GCvB++HFv6Ni73nC6wDuN7dJq+wDwGA@mail.gmail.com>
Subject: Re: [PATCH] mmc: Poll CD in case cyclic framework is enabled
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>
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

Hi Marek,

On Sat, 2 Dec 2023 at 16:41, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> In case the cyclic framework is enabled, poll the card detect of already
> initialized cards and deinitialize them in case they are removed. Since
> the card initialization is a longer process and card initialization is
> done on first access to an uninitialized card anyway, avoid initializing
> newly detected uninitialized cards in the cyclic callback.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/mmc/mmc-uclass.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

This is really nice!

Is there a remove() method where we could unregister the cyclic?

Reviewed-by: Simon Glass <sjg@chromium.org>
