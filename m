Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F23C4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 19:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AF2C87B71;
	Sun, 11 Feb 2024 20:42:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cYUMc7HM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A176F87C48; Sun, 11 Feb 2024 20:42:58 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08F5B87B71
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 20:42:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.liu@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-296c562ac70so1921837a91.2
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 11:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707680574; x=1708285374; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4g0seGyuIkw4Xdy0ITWVqkBRiBto08YjwvVaW5H0E2w=;
 b=cYUMc7HMOhc5S0lMrHIu/tDOzviYwi3fSNNsyHEs9RAdz12Lf6fg3igW/4po08klBm
 0cQ9dhJuD9kaozn0e97ZT4PwScVOlGHwHRO+YkIlnwYkkZVKLmc5wb5jb8zcjaW2XHrU
 fmM2T73l9MN+k/8hxDVjJg4vnIaNy9FPlnD6LVJM4JQxwDzIqncyqXJXDH+hLj+P0W6g
 bdH2gKVst0Dj9qureuIwkqntzKCQm2u6SPMceDbvKZUQ3Z5GfOW97YAIUCfH6a20kaZ7
 5RfKUGdG3cYAI70G7WSr91T0OrLrOWrMh+1wV5QcQD5ALrJAZS2iSCaz8xNVIExbxGSR
 uqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707680574; x=1708285374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4g0seGyuIkw4Xdy0ITWVqkBRiBto08YjwvVaW5H0E2w=;
 b=Lbd1NM5nPPMUmWy1utibpTU4+9kTTrcvmdTGoQqip/Mrkm5db074oYzC1aTNDmNF9A
 0NigmKPgqburz2jdIZuC0ba6R4h9fDxp6qSoKR+TbUHFU5++PJpdDJIaXMYPJ7b8Fb6/
 J5HZFUAOQDGTJiIaHJf9Soc28WpneLpruXCmhadYukUzmGnONRbD1jIcQif2lksvhjES
 YSOGnvs41/Ml9Rc3Rk49ZdbjJuBevitit2XE8D9yKkcfXrmxX5z3jDDJIzgyV0K6Zgbl
 dydRseXRzqnni2I5yJvZDuxV3qdreq809LjJgwKlWhqS8bUCfL+jMOndHdwfH7NG1PUD
 q9gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4uEm7KLi905pN/M8UZ8xMARU4goAd7Q46hIgTDWoOsDA6JXEi+c2GY4fKQhgZxW8lYD+UG75bpEUkKV1SwCKCE5vhBQ==
X-Gm-Message-State: AOJu0Yz88/xmv9RVy2YFxVf0duoo4sDgat9IUr36snkfskObSHFB0vVK
 3nLcSgZw417Fc8EPmgbsvFvjZTPfSMcHAG06tnQdEN0JQ/mVFMWnSZwBT7Kjxaxo8hLOJFJrkrr
 Q+XdeRReMP2Ocxc+dsrm3SNsGTcb9tE/sY4WHUA==
X-Google-Smtp-Source: AGHT+IGSQ3N/vHPc1FMYNDEL8UIJeRy6PAK160m1sPfnaGPlb+yv6c2I7kfgJhFUElOOuPJ+uOdvJ/botetJbPkZo2k=
X-Received: by 2002:a17:90b:19d1:b0:297:fb2:119 with SMTP id
 nm17-20020a17090b19d100b002970fb20119mr2990388pjb.42.1707680574238; Sun, 11
 Feb 2024 11:42:54 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
 <20231109001746.GX6601@bill-the-cat>
 <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
 <CAOMZO5C0ZR=DgXkGHyG-Fgt9HEr3Z_x4qhgkfmObBpTTXUmpAQ@mail.gmail.com>
 <CALG-KHx081qs+_LHTSu7ssAOd0AX-N64OPht8M8nGufU778SbQ@mail.gmail.com>
 <CAOMZO5C4qF4A8uLdRfMeDVosA2NLNU=+WvidGR7QGeSyYJOTmw@mail.gmail.com>
 <CALG-KHwHxdd_7wz6L+6VDGS04LggyqhTZUoqgV+euSqPn9D2KQ@mail.gmail.com>
 <CAOMZO5C02Fwe0ci1RW64E2Gxi4BbdDfhDAJx4ycczE_6oW-oxg@mail.gmail.com>
 <CAOMZO5DbSnU0LdUJwZGF4C2wFuO4WDaoODJPy8WqLa=aoN+0zg@mail.gmail.com>
 <CAOMZO5DjB+AmBteNJeda51zrFO_atDZN_5gg14KmVgZpiTioqA@mail.gmail.com>
In-Reply-To: <CAOMZO5DjB+AmBteNJeda51zrFO_atDZN_5gg14KmVgZpiTioqA@mail.gmail.com>
From: Paul Liu <paul.liu@linaro.org>
Date: Mon, 12 Feb 2024 03:42:43 +0800
Message-ID: <CALG-KHzmrULyRYEiN_c9Br8gr=Rvz7jyKWfA87C_9Jawn2BKNA@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>, 
 Marek Vasut <marex@denx.de>, u-boot <u-boot@lists.denx.de>, 
 Duncan Hare <DuncanCHare@yahoo.com>, Simon Glass <sjg@chromium.org>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Fabio,

I'm on vacation now (Chinese new year). I hope I'll find some time to
revive my imx8 board.
I've tried sandbox and qemu. Both of them are not reproducible. I'm
wondering if it could be some packet loss that causes the issue. Because
sandbox and qemu there won't be any missing packets because of loopback
devices.

Yours,
Paul



On Thu, 8 Feb 2024 at 02:00, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Paul,
>
> On Wed, Jan 10, 2024 at 9:20=E2=80=AFAM Fabio Estevam <festevam@gmail.com=
> wrote:
>
> > One colleague from you at Linaro was able to reproduce the bug:
> >
> >
> https://lore.kernel.org/u-boot/CADQ0-X_cj1ECn67U3sefcZ-Jm4OBSYmZkA+JaZRCa=
3ekq84RaA@mail.gmail.com/
> >
> > It is not specific to i.MX.
>
> Have you had a chance to look into this wget problem?
>
