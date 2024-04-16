Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9329C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 11:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16FD9883F4;
	Tue, 16 Apr 2024 13:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nbvMKrtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB3B9883F7; Tue, 16 Apr 2024 13:53:54 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93DED88346
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 13:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5dbf7b74402so2419826a12.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 04:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713268429; x=1713873229; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z76fMC7TSY4HttWNujRUUyvj7J5jRQ4H/gKbhqNHB+Q=;
 b=nbvMKrtRteg1FexzOl9UMnUMMM4JFl3ryIBcrS5wapTztykLWXmJO+K0T+RjelfdQM
 Vnt55X02CXVb8F9Eyf4NlzldFHCO2IUQNwj+1dfArj4YEjEeG4CdIotyrdKlT2GYNCw8
 wuh0RccgiwqsSFWCxKbMORnazje4Gwi5Tf/Yu0YdrGiW5cZC1YwfU7jwA1MiccWc5M75
 OJMidCVTrPfPxVG0s6s22vyWuylupkEu5LEJ8RIjNtryM8qJqS0RiZWAG0XqwJbxEtTu
 WEh9oq6bcaxR3B7HxXHY65Fyt4ZGvGicVhbbuD6lACCPJxI69PYwli5zOhXsihSHMCyT
 GDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713268429; x=1713873229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z76fMC7TSY4HttWNujRUUyvj7J5jRQ4H/gKbhqNHB+Q=;
 b=j+k4nhUzSGid+0BgYHMDXNYUkRZh1JwRUsbZG1LICO6iyqLQtNy6a2KsyoveldURBr
 rL88eHn0C8L8uNa6BvShiqRTR4Q1e+0dl8/CJHcZosYU23zsXb9iJuJqYZwxTbndKyBK
 Iidshh+1604aOZank06Dn1RXcczS5OOMq3WRNshwCcgSAyYRqARk1nTNMt7d/hh324Sr
 qPWcuOi4/YRlWR4SdkFYek8/mY+l6Xg74dA7ECNHrUv2UcT740xaa4P7l6KrbwO/D3Uy
 WwzV3grUO24ooJB2ElefqtJM5k5EJuGtL5g4o8xSKsZblal7EQsDW5+qKf1SVu6QI2dA
 aBhg==
X-Gm-Message-State: AOJu0YzuTAS5hDZS4pym8lgOeiLiPvryMqnQMB9rn9FtW0G7PWxaxRqm
 opdT/+Bn5Pvuk5UwbCp1KO0g4rJYSh3GPhjD7++F7+mVJdrHyqfP1MNoTxW3mj792CeSJmx3uRj
 JhJyAb25PqhpAz2z7AlcA88uzweo=
X-Google-Smtp-Source: AGHT+IHgvXngibSYVfihoYB7sjhrH1/ekPSNNGSG/fbs84hU4buJCMIe5ci8D/ZZ1lXAYF/sYk3WP07jXvSAsSYOfa4=
X-Received: by 2002:a05:6a20:9c91:b0:1aa:58d9:18fa with SMTP id
 mj17-20020a056a209c9100b001aa58d918famr626145pzb.48.1713268429398; Tue, 16
 Apr 2024 04:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240404030031.4726-1-aford173@gmail.com>
 <20240412000539.GM2493117@bill-the-cat>
In-Reply-To: <20240412000539.GM2493117@bill-the-cat>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 16 Apr 2024 06:53:37 -0500
Message-ID: <CAHCN7xJRkUYCQkF9Lvm1PcpcoTjcqJy9fZAfcP=2ebRJsc2E9g@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm: davinci: Migrate da850-evm to OF_UPSTREAM
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, Andrew Davis <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Martyn Welch <martyn.welch@collabora.com>
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

On Thu, Apr 11, 2024 at 7:05=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Apr 03, 2024 at 10:00:09PM -0500, Adam Ford wrote:
>
> > The da850-evm can remove the U-Boot device trees if migrated
> > to OF_UPSTREAM.  This means pointing the device trees to the
> > ti/davinci directory.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> This series leads to failure to build for omapl138_lcdk and lego_ev3 or
> was I supposed to bring in something else first? Thanks.

I just got back from 10 days in Europe for the Embedded World
Conference.  It should have been based on [1], but I haven't checked
to see if it was applied.  I (maybe wrongly) assumed [1] would have
been applied before this patch was.

Once I get caught up, I'll look to see what's going one.

adam

[1] - https://www.mail-archive.com/u-boot@lists.denx.de/msg505123.html



>
> --
> Tom
