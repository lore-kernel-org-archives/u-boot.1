Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802B2C52D7D
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 15:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABFAA88872;
	Sat, 17 Aug 2024 17:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F/XueVEq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DCBB887E4; Sat, 17 Aug 2024 17:58:31 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A9AC88872
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b7a3773a95so17641526d6.2
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910308; x=1724515108; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRu3ifL9YSRNVQjK1CroqSVgrU84fP3wwRD0zmvJ0rk=;
 b=F/XueVEqiLaWaozZdu2UHMgavYyXAdOR4VDJiPEysN/g1RmyyLqwYw7xVZRRkmA4Xx
 wm2eSWx0Av4GtbGfZzXVLeVq1EKHgrQwbRpHEB1sSYVJ1S67ddxvuPt70M+0O/ncJTwe
 92aqd7AbuL8CsgupGoEY3POcq/2xMYjdBY/Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910308; x=1724515108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZRu3ifL9YSRNVQjK1CroqSVgrU84fP3wwRD0zmvJ0rk=;
 b=vS0zJC524qpKBVjcZkLkC1P+xLvY2hFGDEl8xFTxyHre4mTmyjIaW3gTqRBZvMdn+2
 9ETAv/h79hrQln0dxCf3oGJGmMI/0yfNTIw3tkBbhSv42BhiUbgW9erQ232W3m8nTa/1
 pHOqz7V1pOnlvOATabkopoffP2pbhkk6bgwJnTmweNwRgWZ6BtFe5EMnmhmE+kClE0rZ
 iTbUSUgOz+luh1rSY63rkocWr8CC7LjVy1tkmmaVOo4xsjgipqmSh4xak0xyp/rtbJRb
 SJyMSIA0p3eoFPd9+tMTpVQyXcjZ+duCEwtxa9pJ+E3kcdKLRBPAcSIkQzJy258Ax+Iz
 YoEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1BDKsXFcaE67WZZnEix1JJ7E9LETb9TVIWshK66TyuWmiensra97BN7hhKYLTGAhjZla9LvtK1TYXZ4B2POP8rjk7Cg==
X-Gm-Message-State: AOJu0YzVSqnxfQARY6qyhNeLII0jyakQpY1xwmnCwjDpnpAQhKqsCZ3m
 G2FPmqcBeKDOvcCPfRL5FPfrCAc2BXMIhf18wkW80a2DqENshN0hNuagdpdiM26WYKF+NrrKJwt
 StelyJtjqSl0/WA7vDkl2oLNIzOAQLMJ/mAQI
X-Google-Smtp-Source: AGHT+IFSBIzKEldNkl29XKDeLtXqsfDUQ83DUO/uoAwDjrZEPL3ac5v15FQGEUNPeTlMYWP1uj24yXegENTh/ysFX/Y=
X-Received: by 2002:a05:6214:540a:b0:6bf:700f:a3b7 with SMTP id
 6a1803df08f44-6bf7cd7ac78mr61005786d6.9.1723910308154; Sat, 17 Aug 2024
 08:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814101918.1347167-11-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240814101918.1347167-11-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:58:16 -0600
Message-ID: <CAFLszThDQqaUofT2Jetw7bYc5M_+oBMswc9r8Vq2ZPhC-V9xYg@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 10/10] mtd: nand: add initial ecc engine support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 William Zhang <william.zhang@broadcom.com>, Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, 
 Bruce Suen <bruce_suen@163.com>, Alexey Romanov <avromanov@salutedevices.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Mikhail,

On Wed, 14 Aug 2024 at 04:20, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> only spinand on_die ecc is supported for a moment
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/Makefile       |   2 +-
>  drivers/mtd/nand/core.c         | 130 +++++++++++++++-
>  drivers/mtd/nand/ecc.c          | 249 ++++++++++++++++++++++++++++++
>  drivers/mtd/nand/spi/core.c     | 207 ++++++++++++++++++++-----
>  drivers/mtd/nand/spi/foresee.c  |   2 +-
>  drivers/mtd/nand/spi/macronix.c |   7 +-
>  drivers/mtd/nand/spi/micron.c   |   2 +-
>  drivers/mtd/nand/spi/toshiba.c  |  10 +-
>  drivers/mtd/nand/spi/winbond.c  |  10 +-
>  include/linux/mtd/nand.h        | 261 ++++++++++++++++++++++++++++++--
>  include/linux/mtd/spinand.h     |  13 +-
>  include/spi-mem.h               |   2 +
>  12 files changed, 830 insertions(+), 65 deletions(-)
>  create mode 100644 drivers/mtd/nand/ecc.c

Somehow this should use driver model (along with a suitable API) for
the ECC acceleration.

Regards,
Simon
