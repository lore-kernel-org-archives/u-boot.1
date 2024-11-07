Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB1FD43367
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 14:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4BB688D51;
	Thu,  7 Nov 2024 15:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d2Lj37/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DCB888E94; Thu,  7 Nov 2024 15:17:24 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C2E988B1F
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 15:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6e33c65d104so8265847b3.3
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 06:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730989040; x=1731593840; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfaiMnbrF7UublBLgtJF+O3Wdjc50aMywjDwVJKLU18=;
 b=d2Lj37/X7/OO+n6mkOOsDaGPgANUJ1GYP/0o9ifnyJPaFQ5jGavBG8cj1cKnd7qvC/
 0sgZrALNl2lxfkyPXM7E6ree/5sqxYjNMeJPK5+9ust2TBbZu68cj7U/tgd4ugSBJB7p
 XzFPjTG9wB1dqCwHHjn16X7lgv5cbbOnhBAJe11wfEbf8dCtMXXU9EqOa8c7ul80ccyk
 MWX7Hk07Ebavk+KyjSYw0nrDfBgJhu3x/b9+giO65Hr/sPIQctMgqwm/SKJ60kYQVJRz
 Vnl7TsP30oIQW4pRNKPIDtE96HMNAEFGlxEMPkhwOMzJ115F0QQSM7QZVrlTFl1+bmvm
 JfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730989040; x=1731593840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TfaiMnbrF7UublBLgtJF+O3Wdjc50aMywjDwVJKLU18=;
 b=hZlOODV27tpbVTA4PR6WTBIg5tLpXMNBOjK+iw22pKDZC3p5k3r1+OQ6jMeewCS6SL
 7RDN6dZ2wDW5iid9ljuc7Ca3kqxfLtQJpwFV5aF5ejcrr43MWNXSGno4fY2J2McMoJho
 ZoNkrygS/ywytaHuR6MxGzuMAoWd20K9rAG1uHmV15t/r7wqknnqSLBYAYVigDaJap5v
 bKt3Uu9vwBo7rLMtxGb8xpjwpIpfWcg+E7qs0bIIl6Ztjs6EDQmAShZKeD8fQXg/TB0h
 JAcgrv1ZWcOQ78jl6x/ZiJVskz+y1f+/CdVJMOAxrpyOMmwQvZviVYF6WCcx3HVWzd0m
 e5MQ==
X-Gm-Message-State: AOJu0Yx8kc9z1q76vygC1Isb8TzGBMuwGn7JX0ec/syW4b8f7MuEnJea
 TOLId8nP2rCKi3dVuKUpR5gVMHUFJN1iUw4NvxhrrsQZhBNdUgUo4rM4OjZquUyugPVAERYQ7qA
 16ytTMIGbf/6f7H7gpZA0bJKn02rvOvqFGOkEpg==
X-Google-Smtp-Source: AGHT+IFrPK6N3tCqE6YhgOf428h49UOnOVw1wDf+mCpD6ZPjwEE56otLICh+lLcdLNdadJTHupDlLjW4+nseGHZtQVU=
X-Received: by 2002:a05:690c:23c2:b0:6e3:420f:a2d1 with SMTP id
 00721157ae682-6e9d899d91dmr487860637b3.23.1730989040474; Thu, 07 Nov 2024
 06:17:20 -0800 (PST)
MIME-Version: 1.0
References: <20241106210348.218507-1-dregan@broadcom.com>
 <20241106210348.218507-5-dregan@broadcom.com>
In-Reply-To: <20241106210348.218507-5-dregan@broadcom.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 7 Nov 2024 15:17:08 +0100
Message-ID: <CACRpkdYamM6q9gOJv0O_1HiDvsRQCw_u=H5RkWrYqZUiKVs88g@mail.gmail.com>
Subject: Re: [PATCH 4/4] mtd: rawnand: brcmnand: update log level messages
To: david regan <dregan@broadcom.com>
Cc: u-boot <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@mail.com>,
 Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Wed, Nov 6, 2024 at 10:04=E2=80=AFPM david regan <dregan@broadcom.com> w=
rote:

> Update log level messages so that more critical messages can be logged
> to console and help the troubleshooting with field devices.
>
> This is a port of the upstream Linux patch to U-Boot.
>
> https://lore.kernel.org/linux-mtd/20240223034758.13753-4-william.zhang@br=
oadcom.com/
>
> Signed-off-by: david regan <dregan@broadcom.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
