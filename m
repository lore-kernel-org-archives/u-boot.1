Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC71C30659
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 13:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6B3886D5;
	Mon,  1 Jul 2024 15:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SNZgcVmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D6A98863E; Mon,  1 Jul 2024 15:57:57 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 575E7886A8
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 15:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6b4fc2b5277so13133096d6.0
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 06:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719842274; x=1720447074; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTv9beDXBfJ7pJ5BMo36mN3NmJBASQK9N1tgLQy0TV8=;
 b=SNZgcVmdu7YewnPNJzuY3hvSOP1kWLqsKOAQS/Pow7qn8tCVJuUIwJQtJvP31Y69JV
 w9ptcNqTqkQ5xODGcR4dA6bafWehVuyw28LGSHqeiqUouLrYQXEH1CT/y2DhMSuJhFjt
 b3gakp8iVSfaSep7CyS72velEzjRtX8Ec9WuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719842274; x=1720447074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZTv9beDXBfJ7pJ5BMo36mN3NmJBASQK9N1tgLQy0TV8=;
 b=Yhz6bF9rpnru6nBJCBxh1bajDqLHxy3vmqPxvJbM3CI9/8c35A6+9TReQkO8ZCjoEF
 POcdBB0FmgmcoOzY+oetzHdXyDyE6nX4w1SrmAe9FTbZg4Rj86qeE1gUm9NYsPwmNHw2
 dcYovvexFHpHFEoC0ucGXTvnuT+6nXWDZ54xY5JObDmFxL7s2fyaQc85lzmqubs4xKvx
 sSyRuGGYaOOGmDtTkD5vRQAcjwMaUhJwJhqutf8OYF6rFLjT/b1/Ia4P4yB01GjkKGsc
 QSzR+sD0HjHqiAW+emiw7JbKcpMTq8haGVJK7mQk3x9PufTx9cveQx70XoVfeLuUnDQI
 vO6g==
X-Gm-Message-State: AOJu0Yw9P0Xb48GcQnQMh7S4IrgBshmg3m8x9CQNDB95IfqA4HwpS9c+
 qzb97GDb89RYudLeZqwentyA7k1DkGSkf6CZE1JpyCpfD+xL9xwDQDumXC1jJkH4coo9233RWOd
 KEQ2YNemeXeTBj8kHwI3GMhWc+sqlCJ6Pi2s2
X-Google-Smtp-Source: AGHT+IF79KLYG6cKjjGuMu54SsINCGTp7HjnUeBbA+dcjwZCjyOLKNbr7c7e7ePoopyxUEWv4k33LFbpznYE2OzC9R4=
X-Received: by 2002:a05:6214:f01:b0:6b5:550d:bff2 with SMTP id
 6a1803df08f44-6b5b70bce4fmr89100426d6.25.1719842274279; Mon, 01 Jul 2024
 06:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240419023632.29078-1-seanga2@gmail.com>
 <20240419023632.29078-2-seanga2@gmail.com>
In-Reply-To: <20240419023632.29078-2-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jul 2024 14:57:43 +0100
Message-ID: <CAFLszThrC2DnGw1PBh09Bx7PYvfuLXcM2yUNpeBYiub6ebRsOQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] patman: Fix tests if add_maintainers is set to False
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
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

On Fri, 19 Apr 2024 at 03:36, Sean Anderson <seanga2@gmail.com> wrote:
>
> If add_maintainers is set to False in the user's ~/.patman config, it will
> cause the custom_get_maintainer_script to fail since that test expects
> maintainers to be added. Set add_maintainer to True in the .patman config
> to prevent this.
>
> Fixes: 8c042fb7f9f ("patman: add '--get-maintainer-script' argument")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  tools/patman/func_test.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
