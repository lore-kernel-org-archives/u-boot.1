Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF15CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 04:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58C2C8484C;
	Wed,  6 May 2026 06:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="StXygPqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCBDF84944; Wed,  6 May 2026 03:37:46 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98AD3848B8
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 03:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jimmy.ho@sifive.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so3510337a34.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 18:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778031462; cv=none;
 d=google.com; s=arc-20240605;
 b=jxqZWwY60HLJu/f2TzQNaa1mrxnk3SNZ5f/hJKz6tPchPcp0AFHZXs1mXrMPbGNEXU
 BLopvJphuSlhfkXtRtRslVKI+9nGvVx0bxRQ9H+2+9nBzu1JqhAugEdQWyjxEmg6DGVJ
 8EpdNyLg1LZ/LBtjArzuwybkvX+SEoeGEB3nIwrIcYUGCRbTQ0TH58dUITgZ+5emFHCk
 D5UmWKDbi/IN+qGlJajJqBXRm+4lWbPxzmM8bbH9ebN65z98Vja52g+TGmFOMTjZ1i8s
 2JJheDkrafikDX1nr1PfLmFTC80aSMtFxqZqCYjGiMk/lYuBXmVx2nL/AJmO5udqf9FN
 6xPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rKU0dov1MfHfvGQf7nrHOZJaY3QL9tJkEBXd2bOHXoY=;
 fh=U2Z2AAf+0KFq4rU93U2jM/ZGAPn6fMbRi+4UqR11gtw=;
 b=KEl3zmMTZix8H0KRL38UgvefF9RJbTLGcnj9nb1utEK1Dt+0105ghHp/CETAyRDRfj
 qBaztwgElb3XHDHGXf8KsowL5l2w9tsOX/P2F8UdfTdKiroZr+WS3SyAhr3BKb2QHvc5
 0flUT5TysH7akU2tafRC3BNVrMOlX3g1IC9CsMxbDuG5v+lv7KW6QVzYcjuPPrv7iy0D
 BcQi9lb5zaQsR7TzLgo87LnR0VaO6Z9u6MIIKv69lAVeeW7XzihtH2ThDHXRhVLm82B+
 RvgZ3lKuB+/39inyAvFSTDoRHZL5q6lAaSlXyK4OvSwqVZyEF8frfjNCw1+KRRQwCUqr
 8xeA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1778031462; x=1778636262; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKU0dov1MfHfvGQf7nrHOZJaY3QL9tJkEBXd2bOHXoY=;
 b=StXygPqNz/zpudHjzhvQeyPy/gn9uTLmanxlUc1hxRXCefDYE8lPMbs50rqdZ2K/JT
 nLNqPs+SR9QaQHJ7NzTaHB0zTLQdEi2gHM4RxJbTdluUu/UTgovT7Ucb4R99yM3/Pug9
 nD4j4J7RIfX/0bezkS0wufU71lkLRdOCSd6xsPIa7PZcOrFBX7XqQBMnrKLk5lwUMU7+
 miZODCWpbDNGZZ+eoD/MJ+os2UY4YM2pxSj7hV8biGDGj/sADQb+lBxG4prl4S6z+Osz
 J1nsF5sHkafz4gxFtszMVx4WAJhC+Dp7vXQbdQE+HjTeuzrHChlse1Zw0Ald8xKqfLhE
 cH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778031462; x=1778636262;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rKU0dov1MfHfvGQf7nrHOZJaY3QL9tJkEBXd2bOHXoY=;
 b=UXx57HVI5ByO7cAPsBMSGpCIDFr6pP7dj8twJwQdgGOOXuse+lU8Sgk3rPttvb7z78
 XXd7kGyT9Lvwsf8wUEPYu5clrgIH027fyEpxjAONBrGre7cF5QKP+KfEw9Kh8df0Xx9n
 mFHcuh1DLw0JlNm3vVT5XYX/gprdQ/6kCf9tGVYm65UP9Z+dVOiQSOR5qxBRDyDzvXCg
 MHpJmYuqqWfrq1ig071vn+AsexLXjJyBUwb4dqhhQi+bSKESOYr+jnIZ2DMK3Z4uFUdD
 qfjntonqy389RwOSroWNAlJi0eKIOMkwDJhXsXadRR1fjrawDhdMY53L6DHjL4RLucHv
 ojDg==
X-Gm-Message-State: AOJu0YxzY7hh2pEkhlfJAgIiHdq2l3vGzTDu0R6j1wE4GRUrttFWDfvy
 rSCpyOV7IZBuaQvrK7IoIiHfNgMh2l4CK5dWApwEhkdICiDdNFt/QC5g3NRGGFZ9hXmHr4hobTw
 WtLRbg4abMfJoQbPlNo0nsuVvHqYf62R9+4FjLmvd7g==
X-Gm-Gg: AeBDieuPchOUL7YtsmGERpYeEmlUIJG4jnFi+SmbOAMuYv1bu+64Q+tTG8MouxOS0EA
 UJC6LmtPcTIFApjBTVUZSMnNEkfPS5tOBVcCMEqsxM8k1cJ0OAZBHlUrJJABtciiK2aNeKiP+ZL
 Qrm/QbPz530rgtnCobKaEDV34A+Xgxdw7GiZ8dG6Ax+JGaQvceL4yZYFA92ZcR9iaJm0b9bjlqc
 kUZkaIMf1mGqT95R55ReaNuxbSEKCcnPLAorIqowpPxrS3gVkFUgZYhJP8noVEj5wouRW6Eygt8
 GzGsxmg7hzoXQp7nexfjiNA0t2M0O2I=
X-Received: by 2002:a05:6830:611a:b0:7dc:dd58:50b8 with SMTP id
 46e09a7af769-7e1df0cb06bmr790492a34.13.1778031461969; Tue, 05 May 2026
 18:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260119055523.13460-1-jimmy.ho@sifive.com>
 <aYnCoctRzE-DZyuT@swlinux02>
 <CAJh9TSJpyDKezRZ0wEkjb-GEPkiAS1zOGfqm0mY2dzdhXZDf+A@mail.gmail.com>
In-Reply-To: <CAJh9TSJpyDKezRZ0wEkjb-GEPkiAS1zOGfqm0mY2dzdhXZDf+A@mail.gmail.com>
From: Jimmy Ho <jimmy.ho@sifive.com>
Date: Wed, 6 May 2026 09:37:30 +0800
X-Gm-Features: AVHnY4LCo2_hrplB_Ku8fS6F73E-wcE7Yk-QPH8OemlF24Tt76lqZ55O4uVQcsY
Message-ID: <CAJh9TSJV6bsQS8mmR-RFqMWiFYrWo73Jt4SZgcLyFizzMoNv1A@mail.gmail.com>
Subject: Re: [PATCH] driver: cache: Remove SiFive PL2 driver
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, greentime.hu@sifive.com, nick.hu@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 06 May 2026 06:52:22 +0200
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

Hi:
ping to see if this can be merged

Best regards, jimmy ho

On Tue, Mar 31, 2026 at 9:01=E2=80=AFPM Jimmy Ho <jimmy.ho@sifive.com> wrot=
e:
>
> just a friendly ping to see if this can be merged
>
> Best regards, jimmy ho
>
> On Mon, Feb 9, 2026 at 7:19=E2=80=AFPM Leo Liang <ycliang@andestech.com> =
wrote:
> >
> > On Mon, Jan 19, 2026 at 01:55:23PM +0800, Jimmy Ho wrote:
> > > From: Nick Hu <nick.hu@sifive.com>
> > >
> > > Under single core boot platform, the secondary cores won't enter the
> > > u-boot spl. Therefore we move the pl2 driver from u-boot to the Opens=
bi.
> > >
> > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > Signed-off-by: Jimmy Ho <jimmy.ho@sifive.com>
> > > ---
> > >  arch/riscv/lib/sifive_cache.c | 3 ---
> > >  drivers/cache/Kconfig         | 6 ------
> > >  drivers/cache/Makefile        | 1 -
> > >  3 files changed, 10 deletions(-)
> >
> > Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
