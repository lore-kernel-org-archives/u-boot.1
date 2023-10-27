Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9067C25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 20:41:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9667E87763;
	Fri, 27 Oct 2023 22:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998288763E; Fri, 27 Oct 2023 20:59:22 +0200 (CEST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63C118712F
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 20:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngompa13@gmail.com
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-2c5b7764016so17559901fa.1
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 11:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698433159; x=1699037959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=slTU4mDtqByVYMShnYphjovLZd8SOqKqLDwGE2v9O7Q=;
 b=iP4JtLDht/LnL+qhJj10qDHBvpNqgHPwMLgC7+mq2K27O2W+nrZ3rPhJiSUfp4Xqfb
 WephIjy2kmgpQ7Z6Y7pL4GvqM1lpN/Dzmy2cB99pJLW6JDkcl4cCRthO5leWOyuLAxY1
 hPQ0vpzKyzLDajVZEH9uaFgtcR8Q/S1hsvGHSYf43xqsXEFhxbjShMhiuIJFeeg2UcP3
 riUTtn2EZLmFa03Smj5W+SJjLu8z+Bg6H2qGF+jIt6zQ69ELWY9b/oMxtYnhqMmu6uUs
 2n2h+4SDbTT5KKTad6xMV6lCPgdgT3CSjA/VM43/vpO5L3iYmFfzvujGtqqB4r5MA1hl
 iW1g==
X-Gm-Message-State: AOJu0YylvhNwiy9QJg6Y73srdarOktDDs5FfG7RfktvAz/hCExFXCMTM
 XUsZD/eamID9heBmhepZV1sYv0pTmANxpGN8IOI=
X-Google-Smtp-Source: AGHT+IHnjPdkyO8oUUY/FEu3vgeikJ01HGCPX+7ffKbZFnUzqCLPry2v6rb6nNnP9o+JEoVYlBuANQ==
X-Received: by 2002:a2e:9e50:0:b0:2c5:13e8:d54e with SMTP id
 g16-20020a2e9e50000000b002c513e8d54emr2754628ljk.38.1698433158995; 
 Fri, 27 Oct 2023 11:59:18 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com.
 [209.85.167.47]) by smtp.gmail.com with ESMTPSA id
 k18-20020a2e8892000000b002c0055834b3sm387793lji.4.2023.10.27.11.59.18
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 11:59:18 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-508126afc88so3576221e87.1
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 11:59:18 -0700 (PDT)
X-Received: by 2002:ac2:4d81:0:b0:503:388f:30a3 with SMTP id
 g1-20020ac24d81000000b00503388f30a3mr2539613lfe.26.1698433158499; Fri, 27 Oct
 2023 11:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
In-Reply-To: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 27 Oct 2023 14:58:41 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-o+xSG-Yxtqt=+HAZds_HO62dtkAZ64kon_a6xG5SaOA@mail.gmail.com>
Message-ID: <CAEg-Je-o+xSG-Yxtqt=+HAZds_HO62dtkAZ64kon_a6xG5SaOA@mail.gmail.com>
Subject: Re: [PATCH 0/8] USB fixes: xHCI error handling
To: Hector Martin <marcan@marcan.st>
Cc: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 27 Oct 2023 22:41:10 +0200
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

On Thu, Oct 26, 2023 at 7:26=E2=80=AFPM Hector Martin <marcan@marcan.st> wr=
ote:
>
> This series is the first of a few bundles of USB fixes we have been
> carrying downstream on the Asahi U-Boot branch for a few months.
>
> Most importantly, this related set of patches makes xHCI error/stall
> recovery more robust (or work at all in some cases). There are also a
> couple patches fixing other xHCI bugs and adding better debug logs.
>
> I believe this should fix this Fedora bug too:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2244305
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
> Hector Martin (8):
>       usb: xhci: Guard all calls to xhci_wait_for_event
>       usb: xhci: Better error handling in abort_td()
>       usb: xhci: Allow context state errors when halting an endpoint
>       usb: xhci: Recover from halted non-control endpoints
>       usb: xhci: Fail on attempt to queue TRBs to a halted endpoint
>       usb: xhci: Do not panic on event timeouts
>       usb: xhci: Fix DMA address calculation in queue_trb
>       usb: xhci: Add more debugging
>
>  drivers/usb/host/xhci-ring.c | 100 +++++++++++++++++++++++++++++++++++--=
------
>  drivers/usb/host/xhci.c      |   9 ++++
>  include/usb/xhci.h           |   2 +
>  3 files changed, 92 insertions(+), 19 deletions(-)
> ---
> base-commit: fb428b61819444b9337075f49c72f326f5d12085
> change-id: 20231027-usb-fixes-1-83bfc7013012
>

The series looks reasonable and has worked quite well in Fedora Asahi.

Reviewed-by: Neal Gompa <neal@gompa.dev>



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
