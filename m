Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7BEC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 12:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7866F88986;
	Tue, 13 Aug 2024 14:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="exN10LeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85ED288997; Tue, 13 Aug 2024 14:27:53 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DB1288842
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52f00427236so896521e87.0
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723552070; x=1724156870; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=knYw6YsUlQfTPrg+RY3O3g03gXIZNRMs8ObAgkg1V64=;
 b=exN10LeQa8OqmMToD3NyLvp2WsI72eS33+FAdLtS2N/P7CWlsMFtj1jnwhV1VH4uHY
 LTyYnFaEnoVmI3+jSGFWBs8XscJbcj43tbBatYxv5qT5wJQRiGolTAHH7KN0VYvvfJZN
 3D1x47OySppNKG5+Z7MYS6hHg9yZSn7Om5jo09c31dO8gYDvTBduhSKLGwag0iDulLKM
 ImKqp/16TRIBK8LPdpd7I4i1R/vFxNk+MBobvdys3mNv3l9t7gH1Ppkt4nD8hnO0y0rL
 BKp/63ZH9SzUx9BfZMKB2v3u90XqcPpECjyfIkUxNwgnZDBNmgfLDaJMn7SLYqsmdybu
 0Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723552070; x=1724156870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=knYw6YsUlQfTPrg+RY3O3g03gXIZNRMs8ObAgkg1V64=;
 b=hgbq1Ayzyn3RHwLgFUXswBxvChXcK4XH+W4TsUNKVgZdhgXphz67baJe9i+UzYUQ0v
 7b/pv3fCznsSisMIK4xrl2NDMNGp6lQsFrpmAGTm/uxiAWMcein4elHlfdkbBM43hZ3Q
 yJsbqcB5WrfWnPnUKck5EU2XZleHc70EqM6iKOtyBUCJB4xbpufYQXK19+NGRT8W1ZKA
 L6dk7MqNktLqL44SfK1AiTDzFcoFMhF9JGMEpm7lcfiiAKNl3rIvDeEnrtJeJm8MtMCg
 4/ZoqyOeS4oQNkRTebSYU6mNOF+DnzphvDyevEuCL2zyagxkRusiKGnx4e/eoiStcKM9
 dllg==
X-Gm-Message-State: AOJu0YwiZrPcGFobxDUqjktWMSFSu2xMEiaMe+yadcLEhrZjl9A0mSh2
 SDF9g478iv0gBy6TayLJrOjT4a7h4uD7HaPsIazyRRT2u83kSs+F0SecxX6K9NMoQj5v4uEkPGg
 LvAQPpZnedV986OUTnfBzcMs9DY4=
X-Google-Smtp-Source: AGHT+IHHx4AjxnreYHp+E3F3k2nSSGy2Z+zc8BaKw38dRRkMmJG4HAGFUSGVpBe3AO3AuA58wO6pZrXHBhh4ga9YTL0=
X-Received: by 2002:a05:6512:31d6:b0:52f:c438:883c with SMTP id
 2adb3069b0e04-53215c82cf5mr959151e87.1.1723552070271; Tue, 13 Aug 2024
 05:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240807155343.122377-1-hs@denx.de>
In-Reply-To: <20240807155343.122377-1-hs@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Aug 2024 09:27:38 -0300
Message-ID: <CAOMZO5A23hR6CbLbvUR-ck111iowq=BKrMz_4PHwL4hQsmyxDQ@mail.gmail.com>
Subject: Re: [PATCH v2] driver: pwm: pwm-imx: fix probing on imx6
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>, 
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
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

Hi Heiko,

On Wed, Aug 7, 2024 at 12:53=E2=80=AFPM Heiko Schocher <hs@denx.de> wrote:
>
> U-Boot 2024.07 drops on aristainetos2 board the following
> warning:
>
>         Failed to enable per_clk
>
> and bootlogo is not seen on LVDS display.
>
> This patch uses old behaviour for systems without clock framework
> if CONFIG_CLK is not enabled.
>
> Fixes: bfc778cb93a3 ("driver: pwm: pwm-imx: get and enable per/ipg clock =
using dm")
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
>
> Changes in v2:
> use CONFIG_IS_ENABLED instead of IS_ENABLED
> as Anatolij suggested.

This causes build failures:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/887503

Please fix and resend.

Thanks
