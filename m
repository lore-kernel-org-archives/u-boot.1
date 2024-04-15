Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC67C00A94
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 15:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC697879F3;
	Mon, 15 Apr 2024 17:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="kjJ+ySZt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B183087D07; Mon, 15 Apr 2024 17:19:28 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7176D8786C
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 17:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so2259100a12.2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713194365; x=1713799165; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MqAxhQyCxobF5I7mXsDaU6fgFUghrEYj4w8L+8+ipes=;
 b=kjJ+ySZth0XZw2wsz+VG9OQTP8uiIqnF9CGG6KvbLefDqMYFIyb0LrqH35jMknwajd
 VGiGtB+EupmlJNSVq9uhduAqx5ywwvIbTKdhgLqDKpPyPGRDF3u6MjzENkmGGyijRKD7
 KmVS0GNP1IONbOm5C3MNdtuTN0HEzaQ37j/snzcg1ya86k23pzGrLPJDfuhHmaZIHLSJ
 gXnCJpKLvjCLv1GJ5M1Y6n8/3xYlNG5//2J2dy16cvQq+8XHPihSAUVHoRZapLB0eqxf
 sasJdxlo0nl2ls3yJkLzvrggtJDlGC/tjSgDtMS5uk6TgpJnnNmoXW6SYhGvZCCQE+zc
 NwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713194365; x=1713799165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MqAxhQyCxobF5I7mXsDaU6fgFUghrEYj4w8L+8+ipes=;
 b=JNO16dY+oD1cD/e+/sp6zhMUqwh7yAbSiB0Olk9iwJJIA2ZAmfzyEIfn6Bh8On+MWj
 mdszBYFEpmUDhpEe4ydZh81t1wPFda2AWzXQaNS3+HtnbLv2oP6Bcn50qFgOKaIYLnK0
 bYcWkF5dHBLt9UUYt9ukrrJ/aMku/pS5lHe/OnyFOWX6IxFMTuJ/buXOvdcPZbXdIwhp
 BPevVoRaDqnangIvNPghXydU1wFSyaQD3WoaFrxeq+sXExygEtREVLz59tB+1IAXSRRs
 1qU7KdKC436VWQOlFn7SvJtsLxUzbyqIixFQ3KHLeuJi15HNQXZAK36nWzv7a/PVtwHz
 7kFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkLHa1QG+ZCcSmiefCNsefKpy3N5lrAE1K7wlj5QEHcv3JZ8qJczAONMqb8ezxwa6wKOkU+y+OitrO2PzaRuxYaFaG6g==
X-Gm-Message-State: AOJu0Yxw9pNRZS9rYVQf4SaWpRomg/oRjcivMXHmyM995OI9ce5fw8Rt
 OgB8+GyX9ARkiLYmhsgw738Bxe3RCPhuED6ZsG+mj6VXMUWim+26z6YuLf35ZL5XesDCpxu+ZYE
 j2jcdqjX1SuFYG4Ng/r9FQofyEgFgNOAvYFYICg==
X-Google-Smtp-Source: AGHT+IEuDTbVfa+j+I4vPhBQQYnRL5y0GTqL9hTAu2oDKB0QmFSzUeUZttt8uO7azHFbb5eVTCZLCT56MEHb1UuDaUo=
X-Received: by 2002:a17:90b:1001:b0:2a2:775:9830 with SMTP id
 gm1-20020a17090b100100b002a207759830mr8522654pjb.11.1713194364916; Mon, 15
 Apr 2024 08:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240415105028.432404-1-robert.marko@sartura.hr>
 <7c40379e-6a59-493e-922f-3690ff0edd8e@linaro.org>
In-Reply-To: <7c40379e-6a59-493e-922f-3690ff0edd8e@linaro.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 15 Apr 2024 17:19:13 +0200
Message-ID: <CA+HBbNGVMXqSkpMXQ=L-vNfiT8ijmfBDYVgWbv96Pg6H=pFL3g@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: allow selecting MSM debug UART with
 ARCH_IPQ40XX
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@linaro.org, 
 sjg@chromium.org, bmeng.cn@gmail.com, marek.vasut+renesas@mailbox.org, 
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

On Mon, Apr 15, 2024 at 1:21=E2=80=AFPM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
> Hi Robert,
>
> Happy to see someone working on those IPQ platforms. If it makes sense
> to then I'd be happy to adopt them under ARCH_SNAPDRAGON at some point?
> I'm not hugely familiar with the usecase here (but eager to learn more!).

Well, IPQ40xx is quite a popular WiSoC family and its cheap but the
stock bootloader limits any kind of
custom use case, so here we are.

Regards,
Robert
>
> On 15/04/2024 11:49, Robert Marko wrote:
> > Currently, DEBUG_UART_MSM depends on ARCH_SNAPDRAGON only, but IPQ40XX
> > devices also use the same UART HW so they can also use the debug UART.
> >
> > So, allow selecting DEBUG_UART_MSM when using ARCH_IPQ40XX as well.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> > ---
> >  drivers/serial/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> > index 8b19e2684e..1fe4607598 100644
> > --- a/drivers/serial/Kconfig
> > +++ b/drivers/serial/Kconfig
> > @@ -321,7 +321,7 @@ config DEBUG_UART_S5P
> >
> >  config DEBUG_UART_MSM
> >       bool "Qualcomm QUP UART debug"
> > -     depends on ARCH_SNAPDRAGON
> > +     depends on ARCH_SNAPDRAGON || ARCH_IPQ40XX
> >       help
> >         Select this to enable a debug UART using the serial_msm driver.=
 You
> >         will need to provide parameters to make this work. The driver w=
ill
>
> --
> // Caleb (they/them)



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
