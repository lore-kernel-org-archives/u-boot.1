Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F09E77182
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 16:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47C87801B6;
	Thu, 12 Dec 2024 17:01:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="caHP4Hmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DEFF801BF; Thu, 12 Dec 2024 17:01:50 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2FFB801B0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 17:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361c705434so5829925e9.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 08:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734019307; x=1734624107; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84J0VCJoGxPoQd0v6z01rHRda380euPp3BD3MwjCarw=;
 b=caHP4Hmy4XNAZQkG0DUWt+PomncYp263SpavP5tbyZWMGuO6L7Xnyw46OdtGiFc8jP
 AbyqgssRW82MA/PmDfFe94c35+XGexxMmefnfdKhEKNlWKa/gjUEd/2B3pIjm+4DJyg4
 3c46zZLy9aGZMCMRDkOzYK+SHLVRey2jbzI2ps2c8HIQzaHxt7+2/8t2qjlF8yu7p81X
 YBopGRkS2m/I69Chd2mUjFQZl33U3+DriTxk+jszaK6jUBdPtaxh0WZQRbYDCbRyT3Rx
 qSD5HVqYDri7urGJFUKyPKcS3p8ZUe1Xjjog10XHlsQ5g57/dHGgRrpErCJzzH7q5XsI
 CiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734019307; x=1734624107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84J0VCJoGxPoQd0v6z01rHRda380euPp3BD3MwjCarw=;
 b=o4gGjQZYxizgRaOsplW7qAUuRW+GZ6uI8dYtrHgCNnE2td4wPq8uwKcwq1WnQntVJY
 DVTqydPrVl/IHPPgdOJS3IXvZdkMlaHB0GNZa2c26yheWC4mAbJr5z/ZC/EprThX6UQk
 vP14cgsxYhFDVe4VxfbIWiSB7t+I1iInTso2kFxg3mc0m2/syDxJF3zDFnAKKGANLXUs
 2r8mjFuAwgfHdPxu5pKqp7FYMp5XK4B1B7zByB4cAWvxcPCAE2e/t50eY1mPxk4gQo0Z
 j63QIs9kimLuNSV0j2o2VZ3qUfVe5QrZZn6zxWiWJhGs1F1ac+JvxIBRMQM72NKeH88E
 mOwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1ZloqhAsrKhc6mZMe3U7tKUBKixvtDMb8zI6sxEo3QWJNd8NfendtoUHevMsE6DoJrHw8jXo=@lists.denx.de
X-Gm-Message-State: AOJu0YyDrCnMvMaD0WOKu1IIWtxzqYwJQhk79BxNFfeZ5aMUjnrJIRBa
 dVL3kkzU5grwRcMePnUz7X7elLsqnoXUJbYAlRC28QmOpv4wJNJTQNUY3l3jC3o/c85LVmP8FFh
 ikKgHaWilGv2hlbeiRDe/u/0/1vI=
X-Gm-Gg: ASbGncvkoomIeDzd/PCPaSfONN0ZOQHLY+M5kmdZj/NlbMtsNsueZtdTv8MpEqBRSHV
 F5wPxqPh+2IzTzZZbJpAzIjhJ/DDnNpWXD32yvGs=
X-Google-Smtp-Source: AGHT+IFbRguI4qIQI4YXkrpnf01EBy/vU9R9OFAdDVUkOmho73uh3T5wQKSizDbGHGv1MAVImXKFnBOwWNa3ZOAmiwU=
X-Received: by 2002:a05:600c:3b26:b0:434:f767:68ea with SMTP id
 5b1f17b1804b1-4361c346b2cmr59456195e9.5.1734019306555; Thu, 12 Dec 2024
 08:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20241212100646.5646-1-clamor95@gmail.com>
 <20241212155503.GE1505244@bill-the-cat>
In-Reply-To: <20241212155503.GE1505244@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 12 Dec 2024 18:01:34 +0200
Message-ID: <CAPVz0n2J+PCqmi0ZV+4gD89rYQkLUYxeaYnvaSLOMNMB6kQZ-Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Tegra: fix clock init
To: Tom Rini <trini@konsulko.com>
Cc: Thierry Reding <treding@nvidia.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

=D1=87=D1=82, 12 =D0=B3=D1=80=D1=83=D0=B4. 2024=E2=80=AF=D1=80. =D0=BE 17:5=
5 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Dec 12, 2024 at 12:06:44PM +0200, Svyatoslav Ryhel wrote:
>
> > This should fix https://lore.kernel.org/all/20241201164810.GT3600562@bi=
ll-the-cat/T/#m2b62b471fd37e4c9725c98547e2a919cf11db5e5
> >
> > ---
> > Changes from v1
> > - added partially support PLL clocks commit
> > ---
> >
> > Svyatoslav Ryhel (2):
> >   driver: clk: tegra: partially support PLL clocks
> >   driver: clk: tegra: init basic clocks on probe
> >
> >  drivers/clk/tegra/tegra-car-clk.c | 52 +++++++++++++++++++++++++------
> >  1 file changed, 42 insertions(+), 10 deletions(-)
>
> Thanks. Do you want to send me a PR for these, or should I apply them
> directly in a bit after time for further review / testing?
>

I have rushed previous patch since Simon responded that he is picking
revert to some tree, which seems not to be official U-Boot repo.

I have send quite a bit of Tegra related patches today, and, if you
are fine with that, I may pick them all after some a week or so to
Tegra custodian repo and then ask for a PR. There is no urgency right
now to apply clock patch tbh.

> --
> Tom
