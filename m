Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F2AC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33FDE87B3C;
	Thu, 14 Dec 2023 19:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mJP8Yr1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 299DA87AF1; Thu, 14 Dec 2023 19:21:27 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63DFD87B4B
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:21:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5cece20f006so84223617b3.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702578082; x=1703182882;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2VS2Ig1ur19SLkcnjaU3RcvKowke3NFo7juz9fHXDc=;
 b=mJP8Yr1tetXCsHiurEc6G2opwUbCHDeHkiF1Uxu2KSW/b8U9dpkxDyepOcubiKzL50
 935z/WjJQtVU/eLKSDp56i8kR/WOdTuP4ZF33POIgJSiM/3DQuUgcEveeGehyL2j7JOZ
 sFP0ZMGAhi3G6IW4pWvgH/AN9mrRwmbQuNQXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702578082; x=1703182882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S2VS2Ig1ur19SLkcnjaU3RcvKowke3NFo7juz9fHXDc=;
 b=Ovj4FzISQO5fSFa3ZgXPHXCnA3hBOBvMHStkKLZyx8fqg0M0EmskdzTo8VbZ8lqxCh
 U9MH5dxYFuCj7cMc5QeLZQWXfbtkAcuvrP006OmJ9xCLxnqXEtAsikhQ95TJ01Ka94su
 dp/QUNpvaA4xT9yOVrjgORR3oH0XdvRkhATdyolmMspdRpEHPWSwl8bvfUJ4Oy6aZwu4
 y9a1drxiO5+1H1xGXuFjgSLpSgkvwaYpbwpdQZ+3IKZLbeph1jAU+Fwwa/6QEMxAjXRU
 aRMzHao57VjYnVbGtEsxSiEPKKUiS5V/Zm/ig59EituU6KjNn1dxVcALY3SbXRRbBnpP
 i3Vw==
X-Gm-Message-State: AOJu0Yy2ODLMhBwRFtIh9FqFHBxeRv3L59vf7b4ZEhOPz7FHrpeu7KYT
 UWrC5fToprRsWS5IbJ9Fmg5Pt/GcWD0dzqVZifmVfg==
X-Google-Smtp-Source: AGHT+IGMPEHn0HMdEne71oq8MF6IaAIixN6IxneniZRS2awtY93A7sMMOtTr6+RmO7WhFBtDCeQsgT+/SYrwLZQp2EE=
X-Received: by 2002:a0d:d8d0:0:b0:5de:a315:b727 with SMTP id
 a199-20020a0dd8d0000000b005dea315b727mr8830309ywe.25.1702578081940; Thu, 14
 Dec 2023 10:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20231017192926.54397-1-ivprusov@salutedevices.com>
 <20231017192926.54397-2-ivprusov@salutedevices.com>
In-Reply-To: <20231017192926.54397-2-ivprusov@salutedevices.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 14 Dec 2023 23:51:11 +0530
Message-ID: <CAMty3ZDXP_dOK8W=OoxuowKMtz4sh7DY2teBqw1V7UxxCPAjDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mtd: spinand: add support for ESMT F50x1G41LB
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, prusovigor@gmail.com,
 kernel@sberdevices.ru, Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, u-boot@lists.denx.de
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

On Wed, Oct 18, 2023 at 12:59=E2=80=AFAM Igor Prusov <ivprusov@salutedevice=
s.com> wrote:
>
> Adaptation of Linux commit d74c36480a67
>
> This patch adds support for ESMT F50L1G41LB and F50D1G41LB.
> It seems that ESMT likes to use random JEDEC ID from other vendors.
> Their 1G chips uses 0xc8 from GigaDevice and 2G/4G chips uses 0x2c from
> Micron. For this reason, the ESMT entry is named esmt_c8 with explicit
> JEDEC ID in variable name.
>
> Datasheets:
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50L1G41LB(2M).pdf
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50D1G41LB(2M).pdf
>
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> Tested-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> ---

Applied to u-boot-spi/master
