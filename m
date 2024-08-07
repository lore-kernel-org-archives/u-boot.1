Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3905EC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 07:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87DD68874E;
	Wed,  7 Aug 2024 09:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MIeI8UN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03D0888718; Wed,  7 Aug 2024 09:07:34 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8B338874E
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 09:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-369f68f63b1so772558f8f.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 00:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723014449; x=1723619249;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G5a9XEp+6EOumcILcxWBGScz/4izcJxR5/8aclld7mY=;
 b=MIeI8UN1YdYrSellk+a7uqePXLoM4ekmkZCE4keazKTtalthiu5rtWV2qRiqIXbLzR
 PygLi0mC1Yw0Uh14ZW/MYiIrriFPLf9+efNfdGhe20kj22dLE6f27aVyua1r2EQ3v15X
 CitT6U4a2AxVvZI0RECLHTBu+tCGFaOHD0rB93tTWUuud5IjXHbHievb2VGF9lhbjuJn
 9xcZIXUQ0GO0h38l9Azf3n/zoo2Jwr+Y9/fEg5+lqbxWPngtA4KQ+IkudSZv0RrLHvDW
 T7Qi7lQ/O/UplYtS1osz6jwcl/WzgjRFD8QBSMq3Zt+8cWVT6LlIHvZn2fUv4C1m5Umh
 n8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723014449; x=1723619249;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5a9XEp+6EOumcILcxWBGScz/4izcJxR5/8aclld7mY=;
 b=hH4kWGdbX6ZPEcq+rhq8g5qZy5Ib5MRArMpS7vgizw1DYRaOvAPCZz1F2v7D+6i+LU
 Uc53Pve66SaW7Bjcak2tIBECgXbV4MWIi8gSZm3LzvN6vVT/sZy+yYQrXV63m79UPDcb
 2wyNATVVZCE69AOHE1yAiDWx9PD4UWSecdss5nv3SQNAfBFI+f1cDw8OFekHzsd8XD6m
 zFAl0NE2/JmdhlL7Zjzwhsfi3ASkDw+eL80Vr1Wk9FB+K8B5/vNtsDArpChghy0IoVFL
 SzAYgIcGqVGp05Crsgd2YvL+XVkTMhPjt8EDSS4y4KPi4cVf2+qxvg3sGvzG9LshCGsR
 DpDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9+YxaGmscdX+uFO2l2uO9BZlgr5RHqnqJcvHAff58nk3OHv379fa7UUo4Jz6Ugiv0T2mU/pOq8fYqD80gh0qG0qRp6A==
X-Gm-Message-State: AOJu0YwgoOjLY+Mj7vySC1IlXWcENHWunICI31huEY9Cg2JIenG72eki
 kYzDO/7MA6RFpOln1P951i04+dwYPfM2I9isd6Vdmh9uNO0U2G7+jzwClyyOTzU=
X-Google-Smtp-Source: AGHT+IGuHf18DPcAUwoj//LcXrAf8h7Bb5tP0PlRqEsIK4/9LKpbadjKGtwsIDXsvHtvn1kpRzXUcw==
X-Received: by 2002:a5d:514d:0:b0:367:9881:7d5e with SMTP id
 ffacd0b85a97d-36bbc0c2799mr10485758f8f.8.1723014448800; 
 Wed, 07 Aug 2024 00:07:28 -0700 (PDT)
Received: from localhost ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd169697sm14959119f8f.107.2024.08.07.00.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 00:07:27 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: gadget: udc: Fix duplicate uclass name
In-Reply-To: <20240802092820.917450-1-admin@hifiphile.com>
References: <20240802092820.917450-1-admin@hifiphile.com>
Date: Wed, 07 Aug 2024 09:07:20 +0200
Message-ID: <87frrgolp3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Zixun,

Thank you for the patch.

On ven., ao=C3=BBt 02, 2024 at 11:28, Zixun LI <admin@hifiphile.com> wrote:

> Currently both USB host uclass and USB gadget uclass are using the same
> name "usb" which break uclass functions like uclass_get_by_name().
>
> Rename the uclass to "usb_gadget" to fix, also makes bind/unbind by class
> index (or sequence) working.
>
> This breaks the capacity of using "usb" as DT alias sequence numbering
> which needs a fix afterwards.

Have you identified boards which use the DT alias that will break
with this patch?

Maybe we can detail the required fix in the commit message a bit as well?
Or, if you know of a board that uses "usb" as DT alias sequence number,
we can submit a fix alongside with this one to document the fix.

>
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  drivers/usb/gadget/udc/udc-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc=
/udc-uclass.c
> index fbe62bbce4..723d1cdfd7 100644
> --- a/drivers/usb/gadget/udc/udc-uclass.c
> +++ b/drivers/usb/gadget/udc/udc-uclass.c
> @@ -83,7 +83,7 @@ __weak int dm_usb_gadget_handle_interrupts(struct udevi=
ce *dev)
>  #if CONFIG_IS_ENABLED(DM)
>  UCLASS_DRIVER(usb_gadget_generic) =3D {
>  	.id		=3D UCLASS_USB_GADGET_GENERIC,
> -	.name		=3D "usb",
> +	.name		=3D "usb_gadget",
>  	.flags		=3D DM_UC_FLAG_SEQ_ALIAS,
>  };
>  #endif
> --
> 2.45.2
