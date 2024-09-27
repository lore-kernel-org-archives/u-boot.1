Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF0CCF6488
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 22:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 037C08913A;
	Sat, 28 Sep 2024 00:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T15gUw49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F407C8913E; Sat, 28 Sep 2024 00:10:53 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B778911B
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 00:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5398d171fa2so98224e87.0
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 15:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727475050; x=1728079850; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWTltMf2QRsl1SnLWMM9xxFWtmS0+YeEQHhmpg1G0dg=;
 b=T15gUw49jwwwXkkqSwVvLKobBp5MWS4vPfj8uSyy5/A9d7Pe5E4oVSvOcax3e91ozP
 7PVtoh6QMAxmF0oL1JoHZZ6jxFyYlin88o1LlDot6unHdIf2UQdkDJRJEiWJonqfvz0o
 Tfv/Ud9hgVFOy1OqfismoDyd1Id5JdYOn86h79CgZbu6abpnIoNn0lOvPPzNEj2pslUa
 vK8DIbFg5t590ti4f1ZU6sEphec/PpnaIym6labPLig3FKDhePNBysD5fMZFeFP//6gM
 VVHCiPIqMGpXjDkOjUrGV0zdaXgzKp5slSacddibAe+X/+FQLV83Sg3A0zPRL24gwBDw
 acCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727475050; x=1728079850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dWTltMf2QRsl1SnLWMM9xxFWtmS0+YeEQHhmpg1G0dg=;
 b=YNbRqIwHxqrVcjtRkbUQP5AmfVSft+sw5iICepPmnUV00NDEGWjvaX2E77fqTstoyW
 sQQpx3kJBkQk7Gb/cCitGa1a8KYFkGLV6raBjwptWZvwbvu+9HYA1XbH0dDBsLqly1rH
 qLSS+IAk/7FvKRPPxjcnu2KRCDatNmzqN2sPSN8SooIRV+NGbY4OB7Eu5q0IZ9Z2dNu3
 AyaLNaQ1k29BsQm/wmcpD6Kyc12jn+CWAoGG97L7nwfYv5SDAcVoVZQSahNxOir3pgPq
 rsfmzuwRa9dmGuAkcsyu2Ur2A5lJNbBr0STz3WiZuIVLvtYP71dzKyR1FmGgy1v4fR9b
 U69g==
X-Gm-Message-State: AOJu0YwK6mn1qPeRHqoBtHxB/U3FJZ9dErABD8D1323438dYKbXVvc/x
 uCAI/XcwJpgp/45S5ipzceR56QWuwu57DbKXb2MkYI6vaP7WZeGEEboQqDmfCNKEzlR7u6/QIA7
 kRYIwdNw3hhSxzGmQ/bADX5gey3/Emv+f/s1kH1AeDuDGOvpc
X-Google-Smtp-Source: AGHT+IHwfEGj97GBjVR0lEcRzsghm4vmKBYHSfheHCPfazguZJzzjLMKECFv2D/FxWb3cLGkbyAGTlyZpvVUJO0QySg=
X-Received: by 2002:a05:6512:3b22:b0:52c:e4bf:d55d with SMTP id
 2adb3069b0e04-5389fc33149mr2927158e87.8.1727475050340; Fri, 27 Sep 2024
 15:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
In-Reply-To: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 28 Sep 2024 00:10:38 +0200
Message-ID: <CACRpkdaHpgCT28uKerpfoDxMPRhzr862zf7=pgO7CacOEZFUjg@mail.gmail.com>
Subject: Re: [PATCH 0/7] mtd: nand: brcmnand: Backported fixes from Linux
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Kamal Dasu <kamal.dasu@broadcom.com>,
 David Regan <dregan@broadcom.com>
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

Hi Dario,

On Wed, Sep 11, 2024 at 9:11=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> These are a number of assorted upstream Linux fixes to the
> BRCMNAND driver that I have backported in an attempt to get
> BRCMBCA working with U-Boot (still not there).

The patches are ACKed and tested, could you merge them,
or should I collect the tags and resend?

Yours,
Linus Walleij
