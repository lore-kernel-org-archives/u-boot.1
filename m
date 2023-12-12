Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD04C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA32E87824;
	Tue, 12 Dec 2023 17:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iN9GOMED";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7355D87828; Tue, 12 Dec 2023 17:13:55 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F458781E
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d03f03cda9so10895355ad.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 08:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702397632; x=1703002432; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWoW3+QAZ8zNCPxTkfmAZQsRiM84rkLe16hyL5QyJXE=;
 b=iN9GOMEDgAg1Y+pQ5L9QtS9eG3n3OR4KcNMlaWpeYcBLctSPzyFF3aGtU3xlkbcAVo
 xa1pL6x0tSVdKah8aXwWDMHE5BtEOKsEknAuFPjgEZ/ltJ2tnhbrhnkaTq2HtATKBlLO
 bcFcXyiiCFQcU3HsWM6Dvy2tgiY1eDluOFWr+AmA+ID9A1IJhrr+xIRDOotXS2eXxeD7
 xI12aV31ddxPQkZ93EB8LQaIAGFQ3Cvc27I96CZVUvWqKIfhTngCY9zag0onoRO2LDCa
 7MMBzCOQ8v6aH4GivsRIytOTWYnYihyUEm7OG2hjtHyPTlsNd6QJhsEkcPgV9eW0kcNh
 GYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702397632; x=1703002432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWoW3+QAZ8zNCPxTkfmAZQsRiM84rkLe16hyL5QyJXE=;
 b=v10nGhyrnH2V8NNx/0n0xct6j2Gd8mDcpIzUOrioSJHOBRkTf8VHQKwMHUsUZ/JMz/
 WY27MvxK38CCT87FcnZslogIBrdoMxYiKzU92J3Df9xoyCEr5Qp7VB8YBNC/bjICJ1Mb
 foaRs0IVu5dNoRDmiX1BJbTmx2cIfrz0byO6EWzz/pUX4ubU+dz6PhteM0Cts+/U2aGX
 v7BXstPevXgP8MFiTtBtpntrqOtyHvHSJYKm4lqBxL9hQfaQyaJAHlrBCjB3q51ha86I
 Dce8ONjDFxKSVXCar//IB9Mb2GmN4MTVokApweDfVIK5y9XJhijWLI0PnisUwSEcExIP
 GNlQ==
X-Gm-Message-State: AOJu0YysJgTrx5d9xE69KoVkVpW+otRMOabZTSDCkiEKupSXjxERYxx/
 T3kwGTlRWi0TnOmRxEbZVrlu/PLiKjXznJMtc/Q=
X-Google-Smtp-Source: AGHT+IGe+qaSEJZbaDNo0B2AXg/EZPnhzxdZ6YzdfCGMCNh3VCxBugq9c3PrMDs4umGv0Y78Of7X0fhsm3x5p52sFSk=
X-Received: by 2002:a17:902:c185:b0:1d0:b6ca:3dda with SMTP id
 d5-20020a170902c18500b001d0b6ca3ddamr12203970pld.2.1702397631632; Tue, 12 Dec
 2023 08:13:51 -0800 (PST)
MIME-Version: 1.0
References: <20231020152516.57338-1-andrejs.cainikovs@gmail.com>
In-Reply-To: <20231020152516.57338-1-andrejs.cainikovs@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Dec 2023 13:13:39 -0300
Message-ID: <CAOMZO5DFnq5xpsmtpWJ2ASY0zgBq5_5FwNxvJ71VYu+iQTqvyA@mail.gmail.com>
Subject: Re: [PATCH v1] apalis-imx8: add USBH_EN gpio hog
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Stefano Babic <sbabic@denx.de>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
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

On Fri, Oct 20, 2023 at 12:25=E2=80=AFPM Andrejs Cainikovs
<andrejs.cainikovs@gmail.com> wrote:
>
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
>
> USB host interface is not working on some Apalis Toradex carrier
> boards with Apalis iMX8 SoM. This is due to USBH_EN pin, which
> powers USB peripherals, having a strong pull-down on some boards,
> and a weak pull-down on the others. This USBH_EN pin is left
> unconfigured, which means it is in its default state at cold boot:
> input with a strong pull-up. As a result, carrier boards with a
> weak pull-down have this signal high enough to trigger power
> delivery to USB peripherals, and opposite - boards with strong
> pull-down on USBH_EN have this signal below the threshold needed
> to trigger USB power delivery.
> This change configures the USBH_EN pin as gpio hog, fixing this
> issue for all Apalis carrier boards regardless of pull-down
> resistor value.
>
> Also, update apalis-imx8_defconfig via savedefconfig.
>
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Applied, thanks.
