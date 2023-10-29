Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99782C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 14:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1160687895;
	Sun, 29 Oct 2023 15:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D928719C; Sun, 29 Oct 2023 15:37:55 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F2E787895
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 15:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngompa13@gmail.com
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso574370866b.0
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698590272; x=1699195072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+CbmyRxF4VUwyySze5hLqducEioPMLXYFdj1Fi2dXk=;
 b=tVfT1fsF645NA4f0v1Zp3DhsHQfIq28XBbc8gYSFPx6mclM3TBqYBBfZP0vf7BpOns
 PlYj5sVqBReKIRF9QmoL243LERKsGLhPdDVEHqk06mFhv0EM2s6iidNXaNeosPkt2ng3
 ZPmKk4e73CxQ4VoS635xpU0b7pJlosqXXS+foLazmIrBwc6X1uOWubFm++2A5XYs7UcN
 3V9h+IJdcjx2uA59WNdUAYZKDXfxHD62t3d76HVZGBXKIfUVpfo5aygkJyqmnYAbbsTa
 +DT3xFwyOKrS+LoH4fjQlu6tMS/8Nt/Y24kFcz0drv/Dw2l+AN21vUNZ+JmKCBrFk5e0
 QWmQ==
X-Gm-Message-State: AOJu0YwzUTYJWMaJ8qxFclObd7nE20lNepYRrJ7fLP8+/F+dabwRnucw
 uGe5sJRMYXaFfk8vOroB/lBrQqAJOvpE4w==
X-Google-Smtp-Source: AGHT+IEyz7JtQpMeDMQoqfU409tuW9G1cUd4JGB1OHIoqifhkHjoS4/mHn+ZTMlax7iKvFMHpUhyhg==
X-Received: by 2002:a17:907:841:b0:9be:263b:e31e with SMTP id
 ww1-20020a170907084100b009be263be31emr7066274ejb.33.1698590272550; 
 Sun, 29 Oct 2023 07:37:52 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com.
 [209.85.218.51]) by smtp.gmail.com with ESMTPSA id
 h10-20020a1709063b4a00b009ae587ce133sm4366755ejf.188.2023.10.29.07.37.52
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 07:37:52 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso574368766b.0
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:37:52 -0700 (PDT)
X-Received: by 2002:a17:906:db0d:b0:9c7:58cd:b57 with SMTP id
 xj13-20020a170906db0d00b009c758cd0b57mr6821776ejb.37.1698590272121; Sun, 29
 Oct 2023 07:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231029-usb-fixes-4-v1-1-fe973dde7e59@marcan.st>
In-Reply-To: <20231029-usb-fixes-4-v1-1-fe973dde7e59@marcan.st>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 29 Oct 2023 10:37:15 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-iXWXQC=QFEh2bS4hDv52Tp1ZTwYzCdSf7rBuYm4Se5g@mail.gmail.com>
Message-ID: <CAEg-Je-iXWXQC=QFEh2bS4hDv52Tp1ZTwYzCdSf7rBuYm4Se5g@mail.gmail.com>
Subject: Re: [PATCH] usb: Ignore endpoints in non-zero altsettings
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

On Sun, Oct 29, 2023 at 3:25=E2=80=AFAM Hector Martin <marcan@marcan.st> wr=
ote:
>
> We currently do not really handle altsettings properly, and no driver
> uses them. Ignore the respective endpoint descriptors for secondary
> altsettings, to avoid creating duplicate endpoint records in the
> interface.
>
> This will have to be revisited if/when we have a driver that needs
> altsettings to work properly.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  common/usb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/common/usb.c b/common/usb.c
> index aad13fd9c557..90f72fda00bc 100644
> --- a/common/usb.c
> +++ b/common/usb.c
> @@ -463,6 +463,15 @@ static int usb_parse_config(struct usb_device *dev,
>                                 puts("Endpoint descriptor out of order!\n=
");
>                                 break;
>                         }
> +                       if (if_desc->num_altsetting > 1) {
> +                               /*
> +                                * Ignore altsettings, which can trigger =
duplicate
> +                                * endpoint errors below. Revisit this wh=
en some
> +                                * driver actually needs altsettings with=
 differing
> +                                * endpoint setups.
> +                                */
> +                               break;
> +                       }
>                         epno =3D dev->config.if_desc[ifno].no_of_ep;
>                         if_desc =3D &dev->config.if_desc[ifno];
>                         if (epno >=3D USB_MAXENDPOINTS) {
>
> ---
> base-commit: 8ad1c9c26f7740806a162818b790d4a72f515b7e
> change-id: 20231029-usb-fixes-4-ba6931acf217
>

Irritating, but makes sense.

Reviewed-by: Neal Gompa <neal@gompa.dev>



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
