Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5FCC71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 12:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EF6482BA1;
	Tue, 17 Jun 2025 14:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D4Bl+zTJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F1782BCD; Tue, 17 Jun 2025 14:36:40 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A21CB82B20
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 14:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-551fc6d4a76so5508430e87.0
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750163798; x=1750768598; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrRWz1HCLHUC+ljRlaxPOgOa9mZW8RwMxLYF/z6fcpo=;
 b=D4Bl+zTJD4bt8LEbjv926knH1vL4xQgNpgkIGO1uzQrlXVsOCM5dnmk0uQ6IJsaEzx
 xv9UOucJy6Eufz+pD7I4xlKOTJ4kqofWFqJdu/9KPdiXYkyRwAS7ollq7lvqhwBWAClJ
 KhshUpFK010ldcfmkaO1nqOxssF6W2uCPdNyKmA0mEsu0OvD1+hF+dI0v9itvYJHkObi
 iStLNzhedkvL+HQeQNrwaM0KNs3IQn3zEBjvl66vVblEU/+i+L23mbAJrFhzJ2iYCyRz
 wQoXpuvL6xkrnLByLwef6gkpIsbfIlA/r/9a9z2gr3Ti+vpAd1GqXI7efBzokDnQjRfQ
 gSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750163798; x=1750768598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrRWz1HCLHUC+ljRlaxPOgOa9mZW8RwMxLYF/z6fcpo=;
 b=s21tqWcCdmWn6D8sIiTC/uUOrhJ/M+FpMZwbxGYWCzWICMpphs0VQnxnvYXnwINMXd
 M8pp66ukwg2D0H2eJmvcOCfBeKXeCkUSuqDF65hLJTfWF7o8a5X7ECBubGh8d5T9a8tR
 qbq+1n3YxRDE5OBZeyxqWIQIizyxjHGnastuLHSLDMU4QyGjWXM8vtnDNaam5YnGK/Qk
 TXtgSe1dxQwHFO5wvfXRa6ZK9erWOshB5IPzivQAidleXGt87ttx/kITQUBTtMLuDwIc
 CsicHe69mPh6FqAV/u8Gz7FTLlsvnY5wqb/TCYT7MC+Bi17pJ5ytrtOa3mmJ9/OGSt5K
 k/fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOeYSL1rYDApxbkxmtKms+nbZMI5pw+v/ygow9XWuroAUCblNJX9fLPqDjyWO93bV7geG/DWk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyb4UqvXpEqp9n9I38z2SWZGDI8RUA2IHmGqKH5lahxzfedRzCt
 tMd8y7cChfTGlrQXwBtGiVY37FKRg4HfY0XHXFOk0hNiGlZwhE143FblhOv234mfUBZ2yiee1+P
 +D77rPbzPmCzUcNTomLM13q+Y4cLy/NE=
X-Gm-Gg: ASbGnctz/bN30QRaoHq1QyzOZQZvl5FIift/+C3yJc9Wolrdb4s5MHW2j7AUzrGuygT
 3Tx6U8Ux4uFCyWX8lzaZAK09UHZUQHhLTM+RYzzfg2OoQoTLGm1/5ycgAAUpWAd8mWrDXFsnXXD
 qAcTKlpM5Wc4VdvN9aZTF6qrMRGiajU5LKQYdd3kE3iKZaQGRXn9sMRJZt
X-Google-Smtp-Source: AGHT+IGtnHJZ1a9QilN93cAqkBaidOAHhlAXZRhd0RCEwE8G6BD5smZIqC6HK8JCcAg2MkPOtAVW03a9DIQ8JryMyrM=
X-Received: by 2002:a05:6512:b87:b0:553:2f8c:e615 with SMTP id
 2adb3069b0e04-553b6e7d4bcmr3136735e87.11.1750163797553; Tue, 17 Jun 2025
 05:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250606103838.1862928-1-lukma@denx.de>
 <CAOMZO5DVh+YqspbbeupVJiE08Uv5rgcE920BQFVrk6ygbB8mng@mail.gmail.com>
In-Reply-To: <CAOMZO5DVh+YqspbbeupVJiE08Uv5rgcE920BQFVrk6ygbB8mng@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Jun 2025 09:36:25 -0300
X-Gm-Features: AX0GCFtqzTUP_WWPQme1xkbxjjHaft4Bk3KFOdevesfVGLsPPe_TEWCMyFi7o4I
Message-ID: <CAOMZO5A8KjAW4STh_ZjXn0hOAR4uDSxQHV1DOSW+Y80Sm9RL1A@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: imx: mxs: Add support for imx287 based BTT devices
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
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

On Fri, Jun 6, 2025 at 11:20=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Fri, Jun 6, 2025 at 7:39=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wr=
ote:
> >
> > The btt[c3] devices are based on imx287 SoC.
> >
> > U-Boot SPL 2025.04-01081-g07e086681d26 (Apr 16 2025 - 12:24:36 +0200)
> > Trying to boot from MMC1
> >
> > U-Boot 2025.04-01081-g07e086681d26 (Apr 16 2025 - 12:24:36 +0200)
> >
> > CPU:   Freescale i.MX28 rev1.2 at 454 MHz
> > BOOT:  SSP SPI #3, master, 3V3 NOR
> > Model: BTT3
> > Board: LWE BTT SoM HW rev 0
> > DRAM:  256 MiB
> > Core:  86 devices, 15 uclasses, devicetree: separate
> > MMC:   MXS MMC: 0
> > Loading Environment from SPIFlash... SF: Detected is25lp128 with page
> >                     size 256 Bytes, erase size 64 KiB, total 16 MiB
> > OK
> > In:    serial@80074000
> > Out:   serial@80074000
> > Err:   serial@80074000
> > Net:   eth0: ethernet@800f0000
> > Hit any key to stop autoboot:  0
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied to u-boot/imx next, thanks.
