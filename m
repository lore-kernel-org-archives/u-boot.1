Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42DDC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 13:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFE608836C;
	Wed,  5 Jun 2024 15:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="grfbQndV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5319088356; Wed,  5 Jun 2024 15:12:19 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39BC488370
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 15:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5ba6c41e1a7so1033827eaf.2
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 06:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717593136; x=1718197936; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YtfLZNZEw8jbQz+9LSThzUtJzM+8ZScMW0eZB8y5Pug=;
 b=grfbQndVDxZgykbxJikOZEUult67SD2yQXIz+FCUGpqxSmutPzVj3L3Qe0K9yPeIGW
 IC5NLHqeM9FMVKXXo4tCOtzYFUcKW8MuUS84mGwIwQ9Jqz1kqnxCjpK8hB6s0+/zG21U
 hiGa/AIbl7fEB9S7epP185jYMq6xO71SIklZuOHeBRJHb8JHNaeV0t+TK4szRos0EG6N
 y1INQS+P9Le5xy1xf9epWVKYMPHjqVzYPHXHRZD3zMKJKL0Wp7AuvUtESYFXBMlPhjOm
 yXmWpboW4BzHNOOmdUpBSdOuZvwGhFe3xsYSoBxr2UckHp9a0md6vUkTiv3xh/vZMCh9
 3K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717593136; x=1718197936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YtfLZNZEw8jbQz+9LSThzUtJzM+8ZScMW0eZB8y5Pug=;
 b=L9tIzk6u+EB3hpY+9sSIqWsHsElnsTaXr1dGq9g2uvbm/6WxFjoMuZLYkCwQvuU06F
 aSMjon6spMuul1ejEE34l3jd/v/tcwokorF8ESwmoMFaeiHI0uytvNklk+vTNlLll7tb
 ltXyNOn4jJzKIOXaZboQ+4BvrmaX/pDVeRTtmk2cW6PsDN8PE0Qqci6cBJrfiu67nG8p
 Zwh4nd+TD0nqvPrbfd4YoJcobvZij8V9SIzEgeJlDUZjZOkL2e/R5keUU+4quDTZnmKR
 MsZyh9NQLaJQYoWBicv3FW/H9Ub39INjPlDZm2wmKAvkvsJvkWit+V+bcxjmmoA2+I5R
 4rcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMHmrXf4I7Pjw0YBa9d+sdXHRCfU0STtTn3q612wTrO/59mtZCzboWahXwjsa7gONQHKyATCngonAdlzOy7HA922722w==
X-Gm-Message-State: AOJu0YxKlRGDf6+8QUprxWVcQP6DbJb3bvzKBU6f6AlWnl3VeK/sKwPL
 7ODGWQTbCgxHSkZDtXlsPlheNAAsLvdp8XDCeonKgiUoVL8M9KyDaZDrKZ+1sZ1YB8XOMUpDojp
 UjnJnRMf7XUKeKBxhNnb9eL/bX9Y=
X-Google-Smtp-Source: AGHT+IF5hPN6hqq6gCo0BKQeTb/v4dlAbBSFfSYGVlp031UqwOZ+RHUyi2Gorc4tCF59g2OTC51xMT1ny4zNZEVFmAk=
X-Received: by 2002:a05:6820:168e:b0:5b9:f2f4:6a95 with SMTP id
 006d021491bc7-5ba7909bc13mr2594308eaf.5.1717593135712; Wed, 05 Jun 2024
 06:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240605-pmic-rk8xx-v1-0-2349fdf68aa0@cherry.de>
In-Reply-To: <20240605-pmic-rk8xx-v1-0-2349fdf68aa0@cherry.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 5 Jun 2024 18:41:59 +0530
Message-ID: <CANAwSgQR1pWEvUaf-moLK4bF=o7gBUp2KzbWDk8-D7xkZEXFNA@mail.gmail.com>
Subject: Re: [PATCH 0/3] rockchip: rk8xx: fix broken [np]ldo callbacks
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On Wed, 5 Jun 2024 at 15:03, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> This is for master branch, merge ASAP as it's known to break at least
> Chromebook Jerry.
>
> @Simon, can you please check that this fixes your CB?
>
> The wrong udevice was passed to the functions, making them call the
> pmic callbacks on the parent of the pmic udevice instead of the pmic
> udevice itself.
>
> While at it, ensure consistency by having all internal functions use
> pmic udevice instead of the regulator udevice.
>
> Finally, clarify operator precedence in ternary condition as reported by
> my linter.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

I see we have not been able to follow configs on a few of the board's for RK3588

CONFIG_CMD_REGULATOR=y
CONFIG_PMIC_RK8XX=y
CONFIG_REGULATOR_RK8XX=y

could you enable the options with imply for all the rockchip boards?

Thanks
-Anand

> ---
> Quentin Schulz (3):
>       regulator: rk8xx: fix incorrect device used for _ldo_[sg]et_suspend_value
>       regulator: rk8xx: pass pmic udevice instead of regulator to all internal functions
>       regulator: rk8xx: clarify operator precedence
>
>  drivers/power/regulator/rk8xx.c | 54 ++++++++++++++++++++---------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> ---
> base-commit: c0ea27bccfb7d2d37fd36806ac2a2f7389099420
> change-id: 20240605-pmic-rk8xx-52f2286be334
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>
