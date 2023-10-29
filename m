Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD529C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 14:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1704387769;
	Sun, 29 Oct 2023 15:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A39187832; Sun, 29 Oct 2023 15:35:17 +0100 (CET)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3441876F8
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 15:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngompa13@gmail.com
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-99de884ad25so552858366b.3
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698590115; x=1699194915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HGArOgtP/Y8NOacje0SY8hTCe26rkg0NhPpNm2lneSo=;
 b=gDtfIZL3dp5GPgQUGZaMHKFPyxo1SiGixc+Iftxum2YShyhuGKCbHjXojoV66FrpCv
 VIZIKCIHH2YbiYBGZOdb/ik7ia7KKQ0+tCY2i66PoL+J77VxVTpAQT7VbnxBVv4A/jU+
 t+HZLc08Ff6n1GUe6+0JRaZLNaFSi5WD8uRygtjueOElueGaygArxA+9dN2J4UTJ/LrG
 zpc1gT0Cm+eqUYTOf3H8yWwqK7g5UWaLWOqQ5mTDJDyCZ1sgmnkMf34WCqgxrr+iC5+b
 cO3PYBX317BbDwyUJV+G8Jo8hect70fuJt13KzXKb0fnaKtI+ilHIjJ+qggsn7SsIcc/
 3M0g==
X-Gm-Message-State: AOJu0YyafhmCeblqBbtA2+iLDQ06BdKlSTpA1vbbKtQlOTBfRtv4VkQM
 JufLYspXDvrvHEiVhDt+RQb9Hgzlr+vBYQ==
X-Google-Smtp-Source: AGHT+IFArXtKTL3LkODrVzNhchyv6rO1L/nRfNIxY3L9CkNi1WTUbV+7e0eS38kuZ0kHsyqIBwbUnA==
X-Received: by 2002:a17:907:9707:b0:9b2:b9ad:ddd1 with SMTP id
 jg7-20020a170907970700b009b2b9adddd1mr5287039ejc.28.1698590114880; 
 Sun, 29 Oct 2023 07:35:14 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com.
 [209.85.218.47]) by smtp.gmail.com with ESMTPSA id
 kb21-20020a1709070f9500b0098e78ff1a87sm4380237ejc.120.2023.10.29.07.35.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 07:35:14 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-99de884ad25so552854466b.3
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:35:14 -0700 (PDT)
X-Received: by 2002:a17:906:ee82:b0:9be:3c8e:1506 with SMTP id
 wt2-20020a170906ee8200b009be3c8e1506mr6184178ejb.70.1698590114453; Sun, 29
 Oct 2023 07:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231029-usb-fixes-2-v1-0-9f793aa20fe4@marcan.st>
In-Reply-To: <20231029-usb-fixes-2-v1-0-9f793aa20fe4@marcan.st>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 29 Oct 2023 10:34:37 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-20EYdKTk0fGon4w7mBbChrARuyHyfWwbZDwyx2k=59A@mail.gmail.com>
Message-ID: <CAEg-Je-20EYdKTk0fGon4w7mBbChrARuyHyfWwbZDwyx2k=59A@mail.gmail.com>
Subject: Re: [PATCH 0/2] USB fixes: Add missing timeout, ignore YubiKeys
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

On Sun, Oct 29, 2023 at 3:09=E2=80=AFAM Hector Martin <marcan@marcan.st> wr=
ote:
>
> This mini series fixes one bug, but in the process makes YubiKeys work,
> which then regresses people who have one *and* a USB keyboard, since we
> only support a single keyboard device.
>
> Therefore patch #1 makes U-Boot ignore YubiKeys, so #2 does not
> regress things.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
> Hector Martin (2):
>       usb: kbd: Ignore Yubikeys
>       usb: hub: Add missing reset recovery delay
>
>  common/usb_hub.c |  7 +++++++
>  common/usb_kbd.c | 19 +++++++++++++++++++
>  2 files changed, 26 insertions(+)
> ---
> base-commit: 8ad1c9c26f7740806a162818b790d4a72f515b7e
> change-id: 20231029-usb-fixes-2-976486d1603c
>

Series LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
