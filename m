Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A4BCA0EFC
	for <u-boot@archiver.kernel.org>; Sun, 24 Aug 2025 10:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9464C82E37;
	Sun, 24 Aug 2025 12:37:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="alBIT/fD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6103A82E67; Sun, 24 Aug 2025 12:37:13 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D31A882DA1
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 12:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-324fb2bb058so2140192a91.3
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1756031829; x=1756636629;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xK3dYyxMRFiyrNSP8qAz/hbt7kIZD0cMbZiIU0VMtRU=;
 b=alBIT/fDwgir4fuan8yS9oV0x+0r4A5n/ehGrVTu/GkewVWdtC92C/+76WsArLBq5R
 hXbfduEz0UYtxw+VGMAC4OhxRxAC3DPUHVd/Pplf4cGhTOMRrYhdamN1ajYp53EDL0Ik
 vdC5GiPHd1EyPdSv3UQzSrAEQX4D+APdAMRr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756031829; x=1756636629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xK3dYyxMRFiyrNSP8qAz/hbt7kIZD0cMbZiIU0VMtRU=;
 b=V+6sk4nebrvmtpMr/pV6YEvdR42kqayqqcOqW+TzQURPuHFmnhtmusLE3ZL1eETPzn
 LE0GV/z+GsPWQVGY/vrkVfpEq71WnwH7p4WIxrvCXykt1YDGwIgmLr2teaRUgkZAg0jz
 gRwCmk59HBPnXce4rm947CnO/YhAsaP5kb+fO8gkb0wZh1nEgIFh7WjQ+macwGlWRMqW
 H/sJITvUTNQkUaRAbtQhqYBWEreIu+onnCQdC8E3XH9fWisC3DXrQ/D+Nt18x3IeHS4m
 cgNH6TxSa9MYWjCSEKrj5tFxfVvQcSveb4rBl6iQyvgV47xgEYAqBHBV7zG49mOCp/oW
 5iqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWqi6Nbs7t4h/+gxwLgDoxxMyrh+Cirn6+2mGAgV5T50xuhmge3BacRv0IBRxZBkr/6nrSf0I=@lists.denx.de
X-Gm-Message-State: AOJu0YwI4pBx0qi9g7YRWY2yri/mvjpiRJfpXNpWdRl1vEwFn7bekdVo
 fbO8K7fxEIuCtXD8jYve4e0vQi8lvZ4sBp7F0H1v+eov01RsERMN8Y+snPe+YQ2SlcOapaIpQBc
 Z91cpFPJNNmXi46XqXB0yStAq6beQeu6iPJFSWAwlwg==
X-Gm-Gg: ASbGncskdURw8JksmXtMpJPZlFR4qQO9dBmv/RPodawneo8Ayd/3TiQL6b57+lOXesR
 DOM6e18+zWhe0OPvYIF/Xr+6MPpAkNB84UC0swLCXjfkyF2lrHO0N26I86qVFiCrP7NJUoX412I
 sCcUJu6+qf8KUJibAQ5eUq8rRDVNUeqNrPiiZQZ5rCN6Fr84OQFpsdk3NOTbxH2lFdLvA+rS6Gv
 bkdeD0=
X-Google-Smtp-Source: AGHT+IElIzkY73bh1ok7soxpZXYgdTMW4BSNlSeBZ55fQHJZUVJMfv0WsXji17cELVD64uJKaDiS+iAMYerkh41Vk38=
X-Received: by 2002:a17:90b:2810:b0:325:4c48:af54 with SMTP id
 98e67ed59e1d1-3254c48af7fmr6141572a91.11.1756031828815; Sun, 24 Aug 2025
 03:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250814180647.1805196-1-dregan@broadcom.com>
In-Reply-To: <20250814180647.1805196-1-dregan@broadcom.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 24 Aug 2025 12:36:57 +0200
X-Gm-Features: Ac12FXyQoQVlFyWIryKqKLeW3hY47CgmCZYACEB-0Nrn3Nw-BNrzAVVrfonUJlA
Message-ID: <CAOf5uw=FF=fK1AqvoBhZUN0R2zy7sqRLUWZn=RvBat_W3zerhQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] cmd: nand: various updates
To: david regan <dregan@broadcom.com>
Cc: dregan@mail.com, Quentin Schulz <quentin.schulz@cherry.de>, 
 William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

On Thu, Aug 14, 2025 at 8:07=E2=80=AFPM david regan <dregan@broadcom.com> w=
rote:

> Bug fix of name changed OOB placement option
> Change ambiguous 'count' to 'pages' for read/write raw
> nand dump display update to show ASCII characters and data offset
>   into NAND
> Add option to nand dump with ECC corrected data
> ---
>  v2: applied MTD_OOB_AUTO to MTD_OPS_AUTO_OOB fix to env/nand.c
>      per Quentin request & added Fixes tag
>
> david regan (4):
>   cmd: nand: bug fix MTD_OOB_AUTO to MTD_OPS_AUTO_OOB
>   cmd: nand: more descriptive help info
>   cmd: nand: nand dump display update
>   cmd: nand: nand dump with ecc option
>
>  cmd/nand.c | 56 +++++++++++++++++++++++++++---------------------------
>  env/nand.c |  2 +-
>  2 files changed, 29 insertions(+), 29 deletions(-)
>
> --
> 2.43.5
>
>
Applied thanks

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
