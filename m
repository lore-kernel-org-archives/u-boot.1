Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A139C02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 15:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F822801CF;
	Mon, 13 Jan 2025 16:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P84rFQZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4F9B805DA; Mon, 13 Jan 2025 16:40:40 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EB3D80141
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 16:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21634338cfdso61037605ad.2
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 07:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736782837; x=1737387637; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uRidlJjvn6z+6PP661aCfYD5oiQTOCUXTkjO2Lvf6Xk=;
 b=P84rFQZOc/TXlV2JD4DqhjieDC1PymrvSP13ncKqYLvDVxivFaiplMAcFA/oxPDnKW
 t590WLnyoF6k6MgZptBjCd38MXunvxh+SyKFaxyklm3/ZdFpNQD6c8/u8jigZXQ566sW
 EUFkOi2AlzSfQ43jNJ0MqsNS/+Xszkr0EbXnCpg6oGXEU8VgiBV9hQhV/DOV2bgK36dB
 mLJJpZy/9e/ZDiesOW27PCeIaBt1woo/qjkN33xEepP5PrwuVDUYNqx+a6EnWqMvU77W
 NVy2vzu5DKrCSyYTx8orIlm8DtQT2YWf1p59BYtyWLH1bFo6S8qx90gHBKSDjt8hM/DR
 REHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736782837; x=1737387637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uRidlJjvn6z+6PP661aCfYD5oiQTOCUXTkjO2Lvf6Xk=;
 b=CNfGCSFP87XeS7ZtK16LtmC7wK/iWxLRQFBBu7RzvE/9MJZbW6CFE1vJTcEOYWT742
 WRVV5IGGLNr9aa//yuERKWeFoAfPbGTbGRnUs7jo4FAHn43mXrGzKvQYzRpr0C68Dpsu
 zDzeFK7WN1TSTGqagIfXqYm7Wm8yfP5pdI217qBr4dElV8h3Ie0xkXI3SFHBaDmwrw91
 C23ddQK/ysqQTvYmQKL982CpMNQr6OsyVEsykCQTE8XyHogJYTBk9KqfPgqpSyVZnH57
 5SNgHCWvhg00QsnZWWL9yXxdhjQhWJnJ+QoomDX9+rXXldgQnZ9VJgN5jTCYlA6ruXAR
 u93w==
X-Gm-Message-State: AOJu0YxSTDwsDxrgAl/m/cOs3C6Rmr0tuxKT3z/ikCcpImRirTWbAxmd
 hDRJ/iVdRhitlykXkpRVmjX+MxyG2VrmASzgn9HR6TfcWyXoCOk87Mov98FgUjVbNLHIH5nEWgI
 FO6HjT+32tzcUdGPPxp/Ew2glcgiAbA==
X-Gm-Gg: ASbGnct3G1m0KVzujxwrdfb+lP5adT+pFvnhjMS2PFakZw2S7MH6bhhlBcyDnvz1qja
 s6bMHYVbPUPOP2K4dEz+XLyMAq0XQTTldJ7kXDA==
X-Google-Smtp-Source: AGHT+IGJFr2OTsahKDDrhn2ezM2JHr8tszZcPtZ/3ZPMkokgKrci5+5IcJBy8PwDRrM58b5yNO7p+WqYs2MsRJVxQII=
X-Received: by 2002:a05:6a00:3913:b0:725:ab14:6249 with SMTP id
 d2e1a72fcca58-72d21f168afmr29731530b3a.2.1736782836583; Mon, 13 Jan 2025
 07:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
 <20250112223528.179828-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250112223528.179828-7-marek.vasut+renesas@mailbox.org>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 13 Jan 2025 09:40:23 -0600
X-Gm-Features: AbW1kvaNlHnKF0HEaxup61Ct15nEopx_1Ra-RA16JLDW69GiE2HMR5K12fWKmXM
Message-ID: <CAHCN7xJ+T_m_MR0PuHNMyuMegFGykPp-CpS8sCX6EYb3ksvfRg@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: renesas: Deduplicate board_early_init_f()
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Sun, Jan 12, 2025 at 4:36=E2=80=AFPM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Introduce common weak board_early_init_f() in rcar64-common.c
> which is the default implementation in case there is no other
> board specific board_early_init_f(). Remove board_early_init_f()
> from Salvator-X, ULCB and Draak boards where this function is
> empty.

Isn't there a config option to enable/disable board_early_init_f?  If
they are do-nothing functions, can the config option be disabled?

adam
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  board/renesas/common/rcar64-common.c  | 5 +++++
>  board/renesas/draak/draak.c           | 5 -----
>  board/renesas/salvator-x/salvator-x.c | 5 -----
>  board/renesas/ulcb/ulcb.c             | 5 -----
>  4 files changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/board/renesas/common/rcar64-common.c b/board/renesas/common/=
rcar64-common.c
> index 74ec0a46e6f..69229ea3cb0 100644
> --- a/board/renesas/common/rcar64-common.c
> +++ b/board/renesas/common/rcar64-common.c
> @@ -65,3 +65,8 @@ int __weak board_init(void)
>  {
>         return 0;
>  }
> +
> +int __weak board_early_init_f(void)
> +{
> +       return 0;
> +}
> diff --git a/board/renesas/draak/draak.c b/board/renesas/draak/draak.c
> index a8c40ff1f07..6caa63d553f 100644
> --- a/board/renesas/draak/draak.c
> +++ b/board/renesas/draak/draak.c
> @@ -12,11 +12,6 @@
>  #include <asm/arch/rcar-mstp.h>
>  #include <asm/arch/renesas.h>
>
> -int board_early_init_f(void)
> -{
> -       return 0;
> -}
> -
>  #define HSUSB_MSTP704          BIT(4)  /* HSUSB */
>
>  /* HSUSB block registers */
> diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvat=
or-x/salvator-x.c
> index abb17c3fdc5..9bfcf0d66ad 100644
> --- a/board/renesas/salvator-x/salvator-x.c
> +++ b/board/renesas/salvator-x/salvator-x.c
> @@ -14,11 +14,6 @@
>  #include <asm/arch/renesas.h>
>  #include <init.h>
>
> -int board_early_init_f(void)
> -{
> -       return 0;
> -}
> -
>  #define HSUSB_MSTP704          BIT(4)  /* HSUSB */
>
>  /* HSUSB block registers */
> diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
> index a441ff0e0d8..bd06db23b16 100644
> --- a/board/renesas/ulcb/ulcb.c
> +++ b/board/renesas/ulcb/ulcb.c
> @@ -15,11 +15,6 @@
>
>  #define HSUSB_MSTP704          BIT(4)  /* HSUSB */
>
> -int board_early_init_f(void)
> -{
> -       return 0;
> -}
> -
>  /* HSUSB block registers */
>  #define HSUSB_REG_LPSTS                        0xE6590102
>  #define HSUSB_REG_LPSTS_SUSPM_NORMAL   BIT(14)
> --
> 2.45.2
>
