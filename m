Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9999DCF6494
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 00:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C897588C10;
	Sat, 28 Sep 2024 02:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UwIoDCOO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 909A788C3E; Sat, 28 Sep 2024 02:51:04 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8726388BEF
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 02:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c4146c7b28so3022319a12.2
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 17:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1727484662; x=1728089462;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yditFhklJMFh5An2KAW1tOSVxvCSNumgPo1/3KKnKr8=;
 b=UwIoDCOOMZtgZNqXajufPfBgLRjvqrxFTvk0HRb7CdFVfCU7QXDRfTftCrhmHnZEl1
 fv1eqlRHFmP+vrD+UEtl6JxiOjxlbLdPvAUqH3PI0TVG60lUNZQxDhhW8rV8SjlONXi7
 X5k0vzv/iwdMZqW/I/zfS5RevtTunoMx5qIl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727484662; x=1728089462;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yditFhklJMFh5An2KAW1tOSVxvCSNumgPo1/3KKnKr8=;
 b=IQfh1NPgQROLTfXjbNjM6z7O4xRsWIQLYlYq/dvzkEJQSce0vI6iX1Xy2WSgxIc/E6
 vIkvL8KeuBYASb4PB9QL+v0uoCu/aNDLCB1iC+RZI50NoM8QSM3t4LsGapQOpXDLv+ty
 e3kVgdwmFDaDAL2hBdFLy0wXvtGegodoPDPfK5Ct5TQv629a94BJrcxJvVfVrHDC1Eb1
 fSanVx3qEYwczJDcphlS+gGZXnqzUFZJP7zzspQcLJpt0QsQzCwV7874L8PjaLZS30vO
 KBhlkjPiGyjzhuKreXHZbUtqKFUK1qdFgQW5/X77qpeDxRHrTaPB87pS2+lejSKAPano
 8ZEw==
X-Gm-Message-State: AOJu0YwXdMPfMc8xodF+B7Wk7fVa4zEehpJz6ipMN3O2RoNJlWM/ktrG
 omFU3PbrAfkqWvHZZ8CCr4dXOUbHD6OYLVV1AzS7Og+T5/W/DzhycX2fX+LDB0pI++RoXuzl3qo
 DDQnYzOqU2klzqkOfFxuHk44tqX2FJL2lWumdxw==
X-Google-Smtp-Source: AGHT+IHTw75JSVPxUAL0Lya/UkFXBlSDYJDNabjvIhhjQOxE4T0bBlG82lQmcCZ6bfS3KepkDXxmBAj2dWuL0FE4efg=
X-Received: by 2002:a05:6402:27cb:b0:5c8:83f1:2531 with SMTP id
 4fb4d7f45d1cf-5c883f12765mr3143482a12.28.1727484661410; Fri, 27 Sep 2024
 17:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
 <CACRpkdaHpgCT28uKerpfoDxMPRhzr862zf7=pgO7CacOEZFUjg@mail.gmail.com>
In-Reply-To: <CACRpkdaHpgCT28uKerpfoDxMPRhzr862zf7=pgO7CacOEZFUjg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 28 Sep 2024 02:50:39 +0200
Message-ID: <CAOf5uw=hF8f4LKkhvPwOe56L-mMNEaXiQP8eXXcGQ1v+zFSZog@mail.gmail.com>
Subject: Re: [PATCH 0/7] mtd: nand: brcmnand: Backported fixes from Linux
To: Linus Walleij <linus.walleij@linaro.org>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@broadcom.com>
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

Hi

Il sab 28 set 2024, 00:10 Linus Walleij <linus.walleij@linaro.org> ha
scritto:

> Hi Dario,
>
> On Wed, Sep 11, 2024 at 9:11=E2=80=AFAM Linus Walleij <linus.walleij@lina=
ro.org>
> wrote:
>
> > These are a number of assorted upstream Linux fixes to the
> > BRCMNAND driver that I have backported in an attempt to get
> > BRCMBCA working with U-Boot (still not there).
>
> The patches are ACKed and tested, could you merge them,
> or should I collect the tags and resend?
>

I have already seen all of them and I follow the thread

We will pick them up

Michael

>
> Yours,
> Linus Walleij
>
