Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F97C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 14:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C3758719C;
	Sun, 29 Oct 2023 15:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEEAC877CF; Sun, 29 Oct 2023 15:36:51 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F61A8715A
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 15:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngompa13@gmail.com
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso505065566b.3
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698590209; x=1699195009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQSmnqte/YS0gnA72GqEYQS6BYIWW/IXAm8JEmiPV4o=;
 b=ka6PHqneuklBoV7095uZYpt9JR+XtRDnWm+xncgu+DaFqf4yGRN2NNNHu4gONyHTT0
 Kj8VhheiZ4KOxj2cB50vqpOPOWyV7Zb614OiFjERXX7vgT9MNsglPgBP8DzGcQw/CTOn
 cpzyoCqrotQgfoi5lkaPOgd/7REC/uufOUcRrE5R1ojrR2/TE0MgLozV3IzImQK93vY1
 Uufh99bGLqfbAF5eD/JgVWaBXT7gFmYNmdA+jP7qpegN7GEfXh5cxfB4T12sGudv73nm
 jqhmOs76dJzxv0ovke1uGnwd35Q1FuFawJaY3G4rt93ydrTSCQbc8+cp3erRW0mRdXvd
 eEJg==
X-Gm-Message-State: AOJu0Yzobjv1FLc+h+Ep33hSp5Y1Fais9zYu9mDQS7V+xWYhX3mqlByv
 U9vuZFCdkc7JhiDV4RWQqYd795Forx+99w==
X-Google-Smtp-Source: AGHT+IHgazQDsPZFMBUkLrkQNmDzwvfjc/PSRMOQvof8xiFz5svIgnHU19XeBxXhz/TzQodceOPRxw==
X-Received: by 2002:a17:907:c25:b0:9be:45b3:1c3d with SMTP id
 ga37-20020a1709070c2500b009be45b31c3dmr6747051ejc.48.1698590208865; 
 Sun, 29 Oct 2023 07:36:48 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com.
 [209.85.208.41]) by smtp.gmail.com with ESMTPSA id
 d24-20020a170906041800b0099b7276235esm4418715eja.93.2023.10.29.07.36.48
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 07:36:48 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-53f6ccea1eeso6137707a12.3
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:36:48 -0700 (PDT)
X-Received: by 2002:a17:906:dc8b:b0:9ae:52fb:2202 with SMTP id
 cs11-20020a170906dc8b00b009ae52fb2202mr7347961ejc.40.1698590208337; Sun, 29
 Oct 2023 07:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231029-usb-fixes-3-v1-0-0153210a7f55@marcan.st>
In-Reply-To: <20231029-usb-fixes-3-v1-0-0153210a7f55@marcan.st>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 29 Oct 2023 10:36:11 -0400
X-Gmail-Original-Message-ID: <CAEg-Je81t+Ty8sQVOomETNti=htz=gj4Lr1jQb0ucoNDXoqkPw@mail.gmail.com>
Message-ID: <CAEg-Je81t+Ty8sQVOomETNti=htz=gj4Lr1jQb0ucoNDXoqkPw@mail.gmail.com>
Subject: Re: [PATCH 0/4] USB fixes: Mass Storage bugs & 64bit support
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

On Sun, Oct 29, 2023 at 3:23=E2=80=AFAM Hector Martin <marcan@marcan.st> wr=
ote:
>
> This series fixes some bugs in the USBMS driver and adds 64-bit LBA
> support. This is required to make USB HDDs >=3D4TB work.
>
> Note that the increased timeout won't actually work right now, due to
> broken handling in the underlying USB infrastructure. That will be fixed
> in a follow-up series, which depends on [1] being applied first. The
> USBMS part is logically stand-alone and can be applied in parallel
> before that.
>
> [1] https://lore.kernel.org/u-boot/20231029-usb-fixes-1-v2-0-623533f6316e=
@marcan.st/
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
> Hector Martin (4):
>       scsi: Fix a bunch of SCSI definitions.
>       usb: storage: Increase read/write timeout
>       usb: storage: Use the correct CBW lengths
>       usb: storage: Implement 64-bit LBA support
>
>  common/usb_storage.c | 164 ++++++++++++++++++++++++++++++++++++++++++---=
------
>  drivers/ata/ahci.c   |   9 ++-
>  drivers/scsi/scsi.c  |   4 +-
>  include/scsi.h       |   8 ++-
>  4 files changed, 150 insertions(+), 35 deletions(-)
> ---
> base-commit: 8ad1c9c26f7740806a162818b790d4a72f515b7e
> change-id: 20231029-usb-fixes-3-c72f829ba61b

Series LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
