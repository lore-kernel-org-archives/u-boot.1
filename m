Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B827AC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 22:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D5C8875A4;
	Sat,  9 Dec 2023 23:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="PT30q+lv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4952C876A2; Sat,  9 Dec 2023 23:21:07 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E6A78758F
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 23:21:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5d226f51f71so31227917b3.3
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 14:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702160464; x=1702765264;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Orv69zXUxxtDDIhvkdmqYkykW0usTEifr+/+Ex0qPs0=;
 b=PT30q+lvESGebzva/vfnDPt7YbJvlrYBeUy54e/wVH+iHY/Qzt94j0WCWOyX+sXoaA
 GvKusuPNO5Ox08947A0clr8JHFwwFJefpCLZvTZsuqiSIWxnCK6/dVbaXnyBLx6tUyzg
 G33Qtv5vv6MwPQ8wI8FU5GdkVDtsiZBTuLNb9NXXv3EENLz0YtLJz01332WW4b7gqtYg
 hzpLwqqYPM0E3ApLwrKrFmWLMg9sAanvlBJy4BBvok6g92CV+RLjy/WWzASYQZ89BCvD
 91u/y2++X0eXmKWR9VEVyOGCBgg17uNktQnK0jMJ+iN4g7o1bkNWKeyX6Waow7vE29Xr
 b6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702160464; x=1702765264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Orv69zXUxxtDDIhvkdmqYkykW0usTEifr+/+Ex0qPs0=;
 b=iKVjzL6HThdnJicld9DwjgAgHfIYJubkTlxX3ESj7TnKzGJBfAzRN/43GwkFWkVZ96
 ldJUuOJLVvPx5hY6vvVxedmcVNwfG4vdLMTCPgipuS/QMLjPcn/WkQM9Aw5bihaa7RcS
 esqLWlQo4wug8tYQ87iQDeckaFPhJt5CUcxRzGvjav2xhFZJvFJ2aa/x+5UMUocc+K8M
 fjhiA1//lWgiyWs+HSupNRor/hJk4Mw78f8TkKapJ59fXjQ5UcDlYqNjpR685i2ooK1Y
 34XRwesE/4iI6s7BMjdk81PsZ0KDHyFdITGuFtfMCIJkzcQtYFNg9b/YqGlMufdL/EFu
 29Tw==
X-Gm-Message-State: AOJu0YwV5D5lEkKA9q4D30dxm/mKGnkFHgiq7mXdJtRlUqPwSYOWT704
 f5QtJb/+4PQ0a3zf0+RQL/UKOc/7HbdTNhQ1e6SnWA==
X-Google-Smtp-Source: AGHT+IFTFh7xHn10xg45Ud7wkymiadLHPb8uyh6/9F0cygdYReytaQi8oZ8vNjhNAnZbmWaEGlXd/OELoyTo4Z07IqA=
X-Received: by 2002:a5b:34f:0:b0:db7:dacf:622a with SMTP id
 q15-20020a5b034f000000b00db7dacf622amr1273671ybp.124.1702160463930; Sat, 09
 Dec 2023 14:21:03 -0800 (PST)
MIME-Version: 1.0
References: <20231208000947.248849-1-i@shantur.com>
 <20231208000947.248849-3-i@shantur.com>
 <edd57912-f38f-4589-bb21-c638db8535e1@denx.de>
 <CABEcMwWA1FzdPtvRBwk_9KaXC12R1OCDMoOtuFSvuG8XhphQdQ@mail.gmail.com>
 <e9e44210-0330-4ecd-96e1-629ef519202d@denx.de>
In-Reply-To: <e9e44210-0330-4ecd-96e1-629ef519202d@denx.de>
From: Shantur Rathore <i@shantur.com>
Date: Sat, 9 Dec 2023 22:20:53 +0000
Message-ID: <CABEcMwWhBUj4CFz8XbYYuhntRzJGZXKUoQ47QLo29XC3DNdGmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: rockpro64: Disable usb regulators-always-on
To: Marek Vasut <marex@denx.de>
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, 
 Jagan Teki <jagan@amarulasolutions.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Sat, Dec 9, 2023 at 10:05=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 12/9/23 18:57, Shantur Rathore wrote:
> > Hi Marek,
> >
> > On Sat, Dec 9, 2023 at 5:31=E2=80=AFPM Marek Vasut <marex@denx.de> wrot=
e:
> >>
> >> On 12/8/23 01:09, Shantur Rathore wrote:
> >>> USB port regulators should be controlled by phys
> >>
> >> PHYs
> >>
> >>> so we remove always-on property and let phy manage the
> >>> regulator.
> >>>
> >>> Typec port has misconfugred
> >>
> >> misconfigured (typo)
> >
> > Thanks will fix both typos in v3
> >
> >>
> >>> phy-supply in upstream and
> >>> now that we are removing always-on, we need to fix the
> >>> phy-supply until its fixed upstream.
> >>
> >> Where is the upstream Linux kernel patch ?
> >> Was it submitted already ?
> >>
> >
> > No, there is no patch yet for this in Linux upstream.
>
> Why not ? I would expect the fix should be consistent between both
> U-Boot and Linux .

Yes you are right. I will be raising a patch for linux too.
