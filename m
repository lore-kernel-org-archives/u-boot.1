Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04DAC83F14
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 12:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3989F88B23;
	Thu, 29 Aug 2024 14:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ED+4raBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3C2B88AD7; Thu, 29 Aug 2024 14:53:04 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A336288BE4
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 14:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5334c4d6829so795539e87.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724935976; x=1725540776; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njCxtvhO2DhRlGjGeUUhgFuEcta2vt1MdzgZ5GW8MEE=;
 b=ED+4raBzybWpSTI6OiiuDiQqegvwwUgpQmkjwtTwsLWF7/bkRw6nzQzDczd6CqQsyD
 BUQhbfZRrL5RbBOh/6Q46VKQ+jQwUvNqBCRV3rBGhoGieZPrwpk3MEyqz4e+pS5yjnYR
 ePhh+AWvsGABdR1DkkmIyeVM/gq1Z4Sj1zZ7xC+a/xTYQ0fL3fpsHGwAWDcq865ZwiY/
 A1P2AQDfF+gjNYFz87R0erJ20a14KhyLEzVgqjRkV16ceSFFitIEMdgfxZok1aGrqAt+
 Py6eBOTOiE1t9slGRw4t0cgEG4l1TwoA/tkMIB0OZQLmhL+nD6gY3nvzk9gOWkNGFe3y
 5hKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724935976; x=1725540776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=njCxtvhO2DhRlGjGeUUhgFuEcta2vt1MdzgZ5GW8MEE=;
 b=BsXwHbmMIURyCPQr95zLogviyIq5uVBqKOgz00dk0lcqAXpTXBBdBwR/Ug+bffvFsV
 nz4yP7jx08ayvcwNnrN+4dF+2CG9Z3FFrrTNDp0lrJpmsxnWKsZ+9u6k3cZsseJkzv1N
 0sHWJkjI8I8gQY0XwxaC1DNYN4eQnO0xqy8utHdb5lhm58vm7hKnPNHw/JihI3jhEu6o
 zLHc4fmeiEtaHgytzfRntf9NqoC7qg2rcV4hXUIEvXh/e9WoPJTLZXstBHuQ1Utb/iqI
 5u9lqIij+fWO3ne9JYcS/WJMBT/BhkkUy8AsfkBcgf8BummqbhIYi7cm/3hBmYSGCAxk
 KTvQ==
X-Gm-Message-State: AOJu0YxYy5jrYtgfIj3Hp+uI5QeoPVlgH6E0xrquD7u/AtUc/uxq5JWO
 elSc2wtQTvsPwsXLVY8j2c3qLiO40t/a9vRIHWqnUatMBcktbLaYaYOiEsDqp8rYjqU1x/SGSEU
 B+hbsHcuk1tnFwQp0naEmHNoZ+DI=
X-Google-Smtp-Source: AGHT+IF0rLdsBMY+ff+7TZjd3TJH9KaQcab94QuSL7wnB/6eRBSOFj4QCNX2DnO3VwLySQTrxk/LvL/8Vf8km0SeGHk=
X-Received: by 2002:a05:6512:3189:b0:533:77d:116f with SMTP id
 2adb3069b0e04-5353e541ceamr1678938e87.9.1724935975367; Thu, 29 Aug 2024
 05:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240828153637.1818625-1-jerome.forissier@linaro.org>
In-Reply-To: <20240828153637.1818625-1-jerome.forissier@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 29 Aug 2024 09:52:44 -0300
Message-ID: <CAOMZO5A0+xsoQ=3jETxnmJnhVwUjSfEZagEE9jZT152Gu=aUtQ@mail.gmail.com>
Subject: Re: [PATCH] mach-imx: do not use if_changed more than once per target
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Gary Bisson <bisson.gary@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <seanga2@gmail.com>, Hiago De Franco <hiago.franco@toradex.com>
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

Hi Jerome,

On Wed, Aug 28, 2024 at 12:37=E2=80=AFPM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> doc/develop/makefiles.rst has the following note:
>
>   if_changed should not be used more than once per target.
>   It stores the executed command in a corresponding .cmd
>   file and multiple calls would result in overwrites and
>   unwanted results when the target is up to date and only the
>   tests on changed commands trigger execution of commands.
>
> The mach-imx Makefile does not follow this recommandation, so fix it
> by implementing a single command that performs both the cpp_cfg
> and imx9_check actions.
>
> This change fixes an issue with "tools/buildman/buildman imx8ulp_evk"
> failing every other time [1].
>
> [1] https://lists.denx.de/pipermail/u-boot/2024-August/563192.html
>
> Fixes: f637dfe8c468 ("mach-imx: Add i.MX93 binman support.")
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks for the fix.

Applied to u-boot-imx/master, thanks.
