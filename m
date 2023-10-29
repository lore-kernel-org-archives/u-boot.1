Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6356AC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 14:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C6B8719C;
	Sun, 29 Oct 2023 15:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A43E8794F; Sun, 29 Oct 2023 15:40:03 +0100 (CET)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08B9587895
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 15:40:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngompa13@gmail.com
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-9d2e6c8b542so72158166b.0
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698590400; x=1699195200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9yBNk5oGsfX6qpST/nmf4obxEIq1XqbX30WaF8PcVPo=;
 b=jz5+WvQ6EtINDr2bPIIdX8JKPJjlKRRwdw9484MyDmeZFvIXZlCZOklerUqvMQk6bO
 ALnBFnvRTk2AVeDzjHm+O9mJBbvEcy3rvIgCq2ajIJz9ibqel/b9YboEYnVTNd5U9E4O
 z+tgmWSkjvu8PsIM3VTVDtFHPNNO1xlcuwbB/aufoDqNGJ3tp8EJ7wxckhOjYmzAX1CN
 8B+355BwEe90+Y59FuZX56XvpfBhv71G7jrOLUiWRgJuJE1mu83Ie7msdd0Wswhv48EV
 GF4FbQUGPX/ITkGQoXOZikytiUkpI7nnitwZ/BnSRVY0ydqzX7FhVI3TCBZ0NoizMwNB
 y/Pw==
X-Gm-Message-State: AOJu0YwkbRtvyaSBmC/VvEKrlW3Ct4MnerDcYyvZppI0LSm25GPD/2Ca
 4AvS2jMHqqUs0cHniTNExxaOR5uSr4KfwQ==
X-Google-Smtp-Source: AGHT+IGOs3OXEDqkCERexcRoe88oGW863LWURnuosrBAfEaca79chO7nM8BH0DP2HtsBz2Nz1I3OfQ==
X-Received: by 2002:a17:907:2910:b0:9c6:724:fa1f with SMTP id
 eq16-20020a170907291000b009c60724fa1fmr4896394ejc.66.1698590400035; 
 Sun, 29 Oct 2023 07:40:00 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com.
 [209.85.218.51]) by smtp.gmail.com with ESMTPSA id
 k13-20020a17090666cd00b00982a92a849asm4402500ejp.91.2023.10.29.07.39.59
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 07:39:59 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-9cf83c044b7so472640266b.1
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:39:59 -0700 (PDT)
X-Received: by 2002:a17:907:d385:b0:9d2:20ee:b1c7 with SMTP id
 vh5-20020a170907d38500b009d220eeb1c7mr3005377ejc.45.1698590399726; Sun, 29
 Oct 2023 07:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231029-usb-fixes-5-v1-0-54bb13001f54@marcan.st>
In-Reply-To: <20231029-usb-fixes-5-v1-0-54bb13001f54@marcan.st>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 29 Oct 2023 10:39:23 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-g+WP84Deqzg+h752xMefKLxSsUYoA7WUVBg+tmDw=mg@mail.gmail.com>
Message-ID: <CAEg-Je-g+WP84Deqzg+h752xMefKLxSsUYoA7WUVBg+tmDw=mg@mail.gmail.com>
Subject: Re: [PATCH 0/2] USB fixes: (Re)implement timeouts
To: Hector Martin <marcan@marcan.st>
Cc: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 asahi@lists.linux.dev
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

On Sun, Oct 29, 2023 at 3:36=E2=80=AFAM Hector Martin <marcan@marcan.st> wr=
ote:
>
> A long time ago, the USB code was interrupt-driven and used top-level
> timeout handling. This has long been obsolete, and that code is just
> broken dead cruft. HC drivers instead hardcode timeouts today.
>
> We need to be able to specify timeouts explicitly to handle cases like
> USB hard disks spinning up, without having ridiculously long timeouts
> across the board (which would cause endless waiting when things go
> wrong anywhere else). So, it's time to rip out the old broken nonsense
> and actually pass through timeouts to USB host controller drivers, so
> they can be implemented properly.
>
> This series adds the necessary top-level scaffolding for control/bulk
> timeouts, and implements them in xHCI. I didn't bother with interrupt
> transfers, since I figure those probably never need long timeouts
> anyway.
>
> The platform I deal with only has xHCI, so I'll leave implementing this
> for EHCI/OHCI to someone else if anyone cares :)
>
> This series needs to be applied after [1], since the xHCI changes depend
> on changes made there.
>
> [1] https://lore.kernel.org/u-boot/20231029-usb-fixes-1-v2-0-623533f6316e=
@marcan.st/
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
> Hector Martin (2):
>       usb: Pass through timeout to drivers
>       usb: xhci: Hook up timeouts
>
>  common/usb.c                    | 21 ++-------------------
>  drivers/usb/host/ehci-hcd.c     |  5 +++--
>  drivers/usb/host/ohci-hcd.c     |  5 +++--
>  drivers/usb/host/r8a66597-hcd.c |  5 +++--
>  drivers/usb/host/usb-sandbox.c  |  6 ++++--
>  drivers/usb/host/usb-uclass.c   |  9 +++++----
>  drivers/usb/host/xhci-ring.c    | 32 ++++++++++++++++++++------------
>  drivers/usb/host/xhci.c         | 28 ++++++++++++++++------------
>  include/usb.h                   | 10 ++++++----
>  include/usb/xhci.h              | 14 ++++++++++----
>  10 files changed, 72 insertions(+), 63 deletions(-)
> ---
> base-commit: 3d5d748e4d66b98109669c05d0c473fe67795801
> change-id: 20231029-usb-fixes-5-ca87bbedb40c
>

Series LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
