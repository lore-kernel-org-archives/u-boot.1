Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A36E7E650
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 16:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C69586DC1;
	Tue, 26 Sep 2023 18:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CAoS8pYs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F5886DCB; Tue, 26 Sep 2023 18:47:40 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B7B8648C
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 18:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-51f64817809so1529737a12.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695746856; x=1696351656; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GY7yvQi2tgk4HAPDImQm3gz4mSrd7DQDTY6+XgVWu3w=;
 b=CAoS8pYs8LuIfSq0qaG/8VQFvM8EJjisNi+LuuyqOsO+jHn1WhB/4wtX1bvqRzXxFU
 xFoNLmT6s+WXhytHPsMq1QFYZzeeDXWKD79s76oynjnPQ1E6DQyV+zNNvfupWZQfe3KX
 fnkRrBy2sqFE0rMb4cGho8C93El15BsfrZmgTp0N0j570GOvbjC1hvhnv5zS35snQJzc
 eC9dQQLQn67n/5VVgTjXo++RN5SKf+CqXEJNuC8TLJ+sjxqacNIbZSPz/GnF0s9rcH8i
 LTkPlQJvHfIijQSAIoHHysV4ZrWHwNLACgzfUxJYtJfLp0a/mEkja2AoPWz2rWaGLaru
 b8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695746856; x=1696351656;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GY7yvQi2tgk4HAPDImQm3gz4mSrd7DQDTY6+XgVWu3w=;
 b=szHXUW2bUYMCvIxh6sid91R3/Cx5gbDur2Doli1h88Z/QKkILtBkrEpTcsKxoOmW/1
 5oLlQ2CyTwqgH6Zba5X7QQZ5R8kiKcaKjDiWNMTH2vvDF3dG3aB62TvBU7Cn3ieelbnf
 Khnemn/3p/urdMHzD7jW9CZQtGXphTnjDcrTM8InaFaV71TZgsvy3C0OtovS6R97qH4l
 aznzgWip83tQBJB/MrguROaLxUB+fWW1J+Kda6cb1PJ1Je29BD1u4aoH8r+AZeb4ndzV
 VXatUFAb+lBonRmkttKrkZNOm0fmsrOT6OPcxOukZsr1g7ad76W/ZERqJLBJIKkEUTQ/
 QlLA==
X-Gm-Message-State: AOJu0YxbUphDs5ItqjZkHsVakAyRbojJwvssSf44ecHM+nPRLnDdmy2j
 WM8JfJrRPP5tGWdeM803TnL5A0ZBN1BauJoQEqs34YtNy+8=
X-Google-Smtp-Source: AGHT+IHE7ZxVuT3jS6lZ2Wh9IpdAyqZiPHUxvTGtq+kPi4ZwH0nTxXSR2WQnLsMOvnn7AFcHiOsVvHxUfXHK+K5JJVw=
X-Received: by 2002:a17:90a:1056:b0:26d:4ade:fcf0 with SMTP id
 y22-20020a17090a105600b0026d4adefcf0mr8927874pjd.4.1695746856249; Tue, 26 Sep
 2023 09:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYdKdjW6Ut3QCMWpu8W7TKuuv9OfehC7tdW7-vkdcN8ZbK3Jg@mail.gmail.com>
 <CAOMZO5BtN6xQJ9j35Wz4wH9p5Q=JoC2Ffb1aN-yrTzUeb0AvYQ@mail.gmail.com>
 <CAOYdKdjnVpt=YOrAzjKiaAZomB7=hgAHe1TE+7MM8PK3g+WjRQ@mail.gmail.com>
 <CAOYdKdirq-H+ZaBmy0sT05sL=C=cJWLixgJLsA5ES9PcwZrXyw@mail.gmail.com>
 <CAOMZO5CTG8bqNoP2XO=6VXXquutg-MFqBTbi9Y2q4Dcg0Mfftw@mail.gmail.com>
 <CAOMZO5ArFiQO=BWvDbR91XhADJ0ks4JTe45zOb+z3aaiED2gkg@mail.gmail.com>
 <CAOMZO5CYnkCC5pmG35+8qHqeCaEJwM3Z3eyoJaTrOMMWj5AWWg@mail.gmail.com>
 <CAOYdKdgLaAx8krbBZV=yaUGTwtf6cbgaTU3=+pRKJ4-w_V3_Sg@mail.gmail.com>
 <CAOMZO5DqKS2w1G3iKKGPS_piXx8JcGoWCFOqCQOoB524O9KyOQ@mail.gmail.com>
 <CAOYdKdjPrRT7F_LFf8YeafX1MWep_p91CFdwc-SH8+diCu+2sw@mail.gmail.com>
 <CAOMZO5BzrfvLDrtqBk1dmLqb9-GxzZs8nRVY7GxqCRY34pKg4w@mail.gmail.com>
 <CAOYdKdgyXi5g9zPNOCBtsrA8KV0L1O0Oyh4Ne-Q79Z=EgGs=zw@mail.gmail.com>
 <CAOYdKdhvKEaeyv5zhXiswuF-Kd6ee8FmdN8MoMS9=5VTWVgMXA@mail.gmail.com>
 <CAOMZO5DS2VHPKvVioSW=7fWfnrP63A6wdga6pFmFuSK2QF8gSA@mail.gmail.com>
 <CAOYdKdjALruh9v6HBO-MSjzZM0whYhbA5YLJxbKk7yQk7cznGw@mail.gmail.com>
 <CAOMZO5AVuBxGFF_itcxvdG=W9JoRtyzzeeC+wji__uUOQirwZg@mail.gmail.com>
 <CAOYdKdingLtAvEnth8mSnazQ2fZ_kCsM_2P_dX7tbL2xe9wyVw@mail.gmail.com>
 <CAOMZO5ALK_O-648FaHFrjJc9EiU3J=nvv1rYDiLOGqhjt3mmkA@mail.gmail.com>
 <CAOYdKdjEOsLmkoJdxk1CmLk6_AJFZhuS_7fWxWOm14Av1n7gHA@mail.gmail.com>
 <CAOMZO5BEqwT+t7hw=neAfww_edg61cC6eggr9NNL3OS3jXOY8g@mail.gmail.com>
 <CAOYdKdjn39rV-z3wRf8tORvxP4riZaY0=POhaVjeGh2i3C-yUg@mail.gmail.com>
In-Reply-To: <CAOYdKdjn39rV-z3wRf8tORvxP4riZaY0=POhaVjeGh2i3C-yUg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Sep 2023 13:47:24 -0300
Message-ID: <CAOMZO5CQrr8QzU2QArS7fTf3beNDxgLRNHNRJSL81gMUJ6NvBg@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Rogan Dawes <rogan@dawes.za.net>
Cc: u-boot@lists.denx.de
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

Hi Rogan,

On Tue, Sep 26, 2023 at 1:01=E2=80=AFAM Rogan Dawes <rogan@dawes.za.net> wr=
ote:
>
> Hi Fabio,
>
> That prints "LLC", but does not print "Pref".

What happens if you unselect DM_SERIAL like this:

--- a/configs/imx28-wink-hub_defconfig
+++ b/configs/imx28-wink-hub_defconfig
@@ -58,4 +58,3 @@ CONFIG_DM_REGULATOR=3Dy
 CONFIG_DM_REGULATOR_FIXED=3Dy
 CONFIG_DM_REGULATOR_GPIO=3Dy
 CONFIG_RTC_MXS=3Dy
-CONFIG_DM_SERIAL=3Dy
