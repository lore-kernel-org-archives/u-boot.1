Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF88C3271E
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 00:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C5A883AF;
	Tue,  9 Jul 2024 02:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nBMliaew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8FA2883BB; Tue,  9 Jul 2024 02:48:26 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 837F887CF8
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 02:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-65011d9bd75so38669157b3.2
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 17:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720486103; x=1721090903; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMftbLVfIA2+6/Pi6gF8nLJ2rwLvq8dokdHkdHWd58c=;
 b=nBMliaewDI1Gg9w/WqGreiPrSLrZxAz2RgPT56GOOrAPZOtmHc7KbhJVjEupzVYgAQ
 ZwHK7I6fQT+8KlDfyeDLru8yR3pq5kwQrHZTRVL80lLo1jN1bZtKCR6CLjOt3bTN6Bu1
 G4iGvqtkKDSRsTtGDlf6bkt3PDSzm+eV0BVsk5tE2/ryPE7hwv2F/hByXjtFb9TfolA1
 xMPhKY9o9zS0HJhNdrFfBSa7wL8cpjqAkyz+ac/JqgUnCXxJuxo8H1t1p8txbpEkMQGQ
 mqZi8+52JJYuamRmFcUUrciQlzHbmB1iL677pc4ahhMrBBrk7jlr+A4M5x1sgNyk23VR
 rlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720486103; x=1721090903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KMftbLVfIA2+6/Pi6gF8nLJ2rwLvq8dokdHkdHWd58c=;
 b=ByUPhIjdV3d4nsFgcXRmoUd93IqyI7aca7XGPBeLZ2n1tEEJb1O94JfA4F0bNe6zlm
 cputZh8KI+ifweK0kEtW4t0KkpfkLdVqw3lBUNiaM2iYUeONdQ17i1UzKKko9YfOsvuH
 hmUTxIBx+6FT/tqUoKZwN+dfwLNqcokYcrCvwgKoBDWigm0yY2k7KKb/dSdfN9gA5xvh
 9DDTXkLjUWK1k3HBI5o08A281sEuCm0n1DpPTqCtdOTuQg6iIj5lWnyiQ6uXK2G+/vSd
 QDA0ddCzSlU/D5gnhi2wcvzvsUjgETI98qpDufxD86lbjZa15pWgKntzRjx+4zS2RMCh
 +QXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkYtKbNeTaTXKM8ZWy9TQiNJDXiq3eBAwvlZYJ0tdRfLhm75Vb79gSQWQHTa0NmkS+1KnRo7L9BJD6Crm3mdCa++YZQg==
X-Gm-Message-State: AOJu0Ywnxio4z7Ma/Cnl8pr80TgQzwD9V+gNEBh6JHrokrl/HcvnpzWx
 In3hv7f17l6v15VlxNGhBf7wxc107ItdE5wmibekfVNg8L0PPeA7o/mRPHiDSrXV6PTfrL4vl0q
 OF75ZH77LsfGp989r/DTfOjR80rf6PU6iUzCFyA==
X-Google-Smtp-Source: AGHT+IH3nhpTfRr+EKQMk4zczNQFXXJa4CC4YnqCFl0id37V38uSosCsqz5H3HLXv9aSDJFheBNR/bp7hyDl1/n9o9E=
X-Received: by 2002:a81:9c51:0:b0:631:8969:865 with SMTP id
 00721157ae682-658f07d7841mr12969797b3.50.1720486103328; Mon, 08 Jul 2024
 17:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
 <CAPLW+4=xXM8m7y030kcxTBwgLfm_cud8HYrwF0k75=GOg==zAg@mail.gmail.com>
 <CANAwSgSw3ZkZBaVeAUoj6hCtGoydEmMEoLBaEkU4JW586M5TEA@mail.gmail.com>
 <20240627144205.GB38804@bill-the-cat>
In-Reply-To: <20240627144205.GB38804@bill-the-cat>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 8 Jul 2024 19:48:12 -0500
Message-ID: <CAPLW+4m6SjAmDxQFBJhQwmGP-DOOPXipEY8n6CuWk81ZFZRbeg@mail.gmail.com>
Subject: Re: [PATCH v2 00/40] mmc: dw_mmc: Enable eMMC on E850-96 board
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Yang Xiwen <forbidden405@outlook.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, 
 uboot-snps-arc@synopsys.com, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

On Thu, Jun 27, 2024 at 9:42=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Jun 26, 2024 at 10:12:12PM +0530, Anand Moon wrote:
> > Hi Sam,
> >
> > On Wed, 19 Jun 2024 at 02:26, Sam Protsenko <semen.protsenko@linaro.org=
> wrote:
> > >
> > > If there are no new comments on this series, can you please apply it?
> > >
> > > Thanks!
> >
> > Tested on Odroid XU4 and Odrroid U3 boards
> >
> > Please add my
> >
> > Reviewed-by: Anand Moon <linux.amoon@gmail.com>
> > Tested-by: Anand Moon <linux.amoon@gmail.com>
>
> Thanks, Minkyu will you be able to pick these up (and other outstanding
> patches) for a pull request to -next soon?
>

Hi Minkyu,

Gentle nudge :) Could you please apply this series? I'm working on
some other features requiring eMMC enabled, so it would be great to
have it merged soon.

Thanks!

> --
> Tom
