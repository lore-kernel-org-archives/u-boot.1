Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF16C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 16:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1DA682D34;
	Fri, 13 Jun 2025 18:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="3VUf2gT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6050582D4D; Fri, 13 Jun 2025 16:46:08 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7621F82D21
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 16:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-32a81344ae9so24386811fa.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1749825966; x=1750430766;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RylEmOefYsrQEQMghcsVjmta78DESV3npmLBOaP/YQ=;
 b=3VUf2gT7608O5RAMOJynVR8bdKd/CrAqDZ073hJo16u3bYnwEYYa8fQMOvdskVXmSr
 NEf6odTr6jNAqHqBWErjdSEMa5N4YFWb/4bB936AZFJiE79n4jrSS8EV6swEH8Z2vaTT
 uu5DoOzQSAvZT22227gHBp7uVDKw6mAS0RbsvS2g12McXGPucg8diUprW7IFyOLsd/Ek
 R0GVImSBG6zyBAmztqQ9kG1CqwOySecftL1GQSZ87hcAdGawMXghZOhfW4sDo6SioJtt
 3pnDUszXdOkDwby5ixAuKPkHkofDVul/Tr/nce4WYUU+pDfcTr6VRzIDTHPfCc5onZf6
 svhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749825966; x=1750430766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8RylEmOefYsrQEQMghcsVjmta78DESV3npmLBOaP/YQ=;
 b=QZ7a4fAzq5S4G9OmrNOnbGRoF01bbT3oRHJcmNf4l5VFTVpsUTwka/6hC8YofBY05B
 U/XIvK2gQIwzR96TgYWlwWWiwUB+DhCdtan0ZeAL5auJGHg7qCQL5IkPnPy2KM9Papi+
 7SKUGUh5H9x8VPSl3i02BRZ3IRhvSCRNLf05Nif0mvRyq/kkh8Dr+JXg/Fse4oMZtgTz
 QXhiFn9ly5P2pL3paRFl3cxWUGO7hsfO8GDkMnXsgzVDexFk0hJmP8xm34HYUG5/RZ5s
 9tAA5bhqYStXG3cMwgnudcVboX2v44V2p4oc1HIdKvQR63UScyzwMNLO44gNLYorElCc
 YynA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+HIrPiGuOguIopzp4IOgWeNuwnvd+LCHMSDuSEnS3/s6KGZD8mw4lbppPDeDjxtBkXvpqLww=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6BoPDqMHGxnMsG5vy+TPfPfCRQkR95/Yz0cHsedBi+xnSIM2H
 ZNCTwkiqjNF+pXMyYnRMr56SOHy+QzCWqD6DCnxVq5StpcEId5sZnMTIp2+MYU/1wxJQvRcD7uX
 W06PIJRbiSXUH+LXqo29XJXxq+tS0+xt3/0uys6+7qg==
X-Gm-Gg: ASbGncuZnMIFncMFV5dcIXsqSY88sbcakAKLUb8Q+Ii5uDucDNfOvycNB90pQUy+laL
 1zqq23vYNzapuLQ2jTQFtCkUJ/+o00jZWYOWJP+wVb/8i0qdetvYB3FA0+4SsYUNB+wEuSK//xy
 xMDuhaJa81vJYytU/9sAWPQWJxwmh4b/c9Slddtlqv73zuQYOwmjo=
X-Google-Smtp-Source: AGHT+IEXkgwCYi4x/DHYMp2EeBNL/emBCBiyr1V/plofW56fHPScWqyBXjEhm6NJCEsvH0M3w1JufC103L00UqJE2bE=
X-Received: by 2002:a05:651c:2122:b0:32b:3b5a:c4a2 with SMTP id
 38308e7fff4ca-32b3ea1ddf8mr9010691fa.6.1749825965456; Fri, 13 Jun 2025
 07:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250602-pullup-v1-1-edcde5a050dd@hifiphile.com>
 <87iklbuddu.fsf@kernel.org> <dd3a3cad-75df-43b7-862f-a51cacda3de6@linaro.org>
 <CA+GyqeaPEiwu7b3E-Gm+QMntGgcAVufAhy3jXZ4DzL9O9GANLw@mail.gmail.com>
 <87tt4k3sit.fsf@kernel.org>
In-Reply-To: <87tt4k3sit.fsf@kernel.org>
From: Zixun LI <admin@hifiphile.com>
Date: Fri, 13 Jun 2025 16:45:53 +0200
X-Gm-Features: AX0GCFugkTnMI-Wk12N_dzkpW8x4avXOGfM-56ZYMCroFuDg2MdkKiU9qIC1PfI
Message-ID: <CA+GyqeYhMBW2Hpa0cr=ruA+LJiOm4ycL0mzcKfkaF8w68JVdJw@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: atmel: reliably generate disconnect by
 disabling controller instead of toggling PULLD_DIS
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Mihai Sain <mihai.sain@microchip.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 13 Jun 2025 18:01:18 +0200
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

On Fri, Jun 13, 2025 at 11:22=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
>
> Mihai, Zixun, do you have any update on case No.01589331 ?
>
> I'd like to pick this up and some point so please keep me informed.
>
> Thank you
> Mattijs
>

Hi Mattijs,

The case was reported in early May and MCHP have also observed the
missing of detach event on host.

My latest measure shows a differential signal level about +-350mV
between DP&DM lines when
DETACH and PULLD_DIS bits are 1, much lower than the detachment
threshold of 625mV from
USB 2.0 specification Table 7.3.

From my view the patch can be picked, even on an unaffected family it
won't have side effects.
Unless one day we decide to implement SAM9RL and SAM9G45 errata then
it needs to be retested.

Best Regards,
Zixun
