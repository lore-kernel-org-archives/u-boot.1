Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EB9CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6C1386C06;
	Mon, 25 Sep 2023 15:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SA/FPbzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E922C86C28; Mon, 25 Sep 2023 15:56:21 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9BA186B89
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59f57ad6126so39019447b3.3
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695650178; x=1696254978; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nsx7zCsnc4Y82Mese57/Z4wPkjXhp6bJOUv8C1RJZZ0=;
 b=SA/FPbzrgc0Aj8ZJg2RtNXQRNfYHwX8KWV2F8/EBexJHbP9i8tWbexjGWVelnMB1hY
 JBfY/n5hvtYDCnJ5KBWicJnZK9pmiMJUCViB2CZw2LxekM0TNISbcVV6iuJVrXnn3crF
 Ze443+0NmkOvwyrsFb/xGOiUu7xxF5HWz8g10YEzOtU9uBdYDo3te/PMIZrVjFYVWXq0
 bTEgzwlTxkgKr1aS76HoZWSkuXqzZUx730ZdpWKB/DrBNSzmXQ4pkUNNQRfFfgZTsjud
 +RpKHc6tGj8fd03XZI/QRMbQ4DpvvxNqf7qabA9Wv5r1WIVG0l94i9LDuFB13sJQIYAC
 rqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695650178; x=1696254978;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nsx7zCsnc4Y82Mese57/Z4wPkjXhp6bJOUv8C1RJZZ0=;
 b=bf9GX016U/5cSTUSqFyCYIpA03TsSW1nX8VA6LimM/YUWH653qhioBNBrVBhZU/5Q3
 QZP8+3ZFdLVHGEiMdVekvEQh0+M6KEjCSx+3jdxXY/Q6qcTj1v/rfkMPCmn/HHVoPIVv
 XaWOLI1FtSzOOD64bFwWgqIlzcdoJkqcdTg2Pe3zM6Do6mcK1SXjhwmn4u/Ow6yIA8MS
 a498UwLNZEKmr1C2UBslnYdityJ40EHN5wHtwuXoLJQzjXGxWBFgyIGUjpC8Zu+QgRnt
 MMz68BuF9OzMSSha8Hi6YElI4pK2drBbXejlWY83laB9jqa0lcTg7MMRnQ3KxVA5UodD
 A5JA==
X-Gm-Message-State: AOJu0YzYSjzp/pmXjmdnRdED4C6kqgFJa1CCpcG2eX/k9rmmjgNuQ5Tv
 /pHsJx/pc84ndqIdPUZi+0JBUd0RUlRKnU5NgOv0rQ==
X-Google-Smtp-Source: AGHT+IH6D2qt/oUR6AU6cFVbhJ81x3/C7n6XQtfZXruK/1W/iIZNZnLE00/yq98Fm1ipv37WgrCoqMHS7oAcJaWrTXU=
X-Received: by 2002:a0d:ce85:0:b0:589:e4aa:7b67 with SMTP id
 q127-20020a0dce85000000b00589e4aa7b67mr6382833ywd.41.1695650178543; Mon, 25
 Sep 2023 06:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230920074225.1130769-1-linus.walleij@linaro.org>
 <20230920142252.GO305624@bill-the-cat>
 <CACRpkdYqO1nH51VxjbpnPjaPy7eHaMDCSP5tWBDB1SB3R0cCcQ@mail.gmail.com>
 <20230920185547.GP305624@bill-the-cat>
 <ea1b9ef4-0cf5-ed92-2b70-6d8f70be17ac@gmail.com>
 <20230921172506.GV305624@bill-the-cat>
In-Reply-To: <20230921172506.GV305624@bill-the-cat>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 25 Sep 2023 15:56:07 +0200
Message-ID: <CACRpkdYWK15i=KEFc_VM+xqgmmnT6AQX3OgnznFrmPhkjCfOiQ@mail.gmail.com>
Subject: Re: [PATCH] bmips: Add Inteno XG6846 board
To: Tom Rini <trini@konsulko.com>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, u-boot@lists.denx.de
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

On Thu, Sep 21, 2023 at 7:25=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
> On Thu, Sep 21, 2023 at 04:00:24PM +0200, Daniel Schwierzeck wrote:
>
> [snip]
> > I just tested it, you can simply add an empty board/inteno/xg6846/Makef=
ile and
> > remove board/inteno/xg6846/xg6846.c. But you can also remove the Makefi=
le.
> > Just the Kconfig and MAINTAINERS file are needed.
>
> An empty Makefile is OK, but no Makefile requires a bit more as we first
> try and include it unconditionally and then try and link in built-in.o.
> I'm poking at this now.

Did you get anywhere with this? If it's on the master I'll just rebase and
be done with it, else I can go with an empty Makefile simply.

Yours,
Linus Walleij
