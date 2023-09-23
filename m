Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB83DCE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 454CD86B53;
	Sat, 23 Sep 2023 21:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DC1WYcBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61CBC86B5E; Sat, 23 Sep 2023 21:57:06 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C42E86B09
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-533d6a8d6b6so896974a12.2
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695499024; x=1696103824; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YUQZX0ibc7W8Li7Ln0ptGnc7PtpTMOK42G//26gnHhA=;
 b=DC1WYcBpvhWhP/YmUSZDM153aY0gpC0lquua1aJeCAd1ZXE3HIolmNS603OZHCl1V1
 GFrIqTMHgiYdemaqpEZSKzoJiZsZWZs6hLuZGByNeWYQ6gcvDuCFdHCmLUZh/ryI532d
 4iZoZHUcwfekpxW/1uW8pvLjgGTadywMPWny5r/5yQ7BFMFqzeujVIFCKH/cut+sUeGe
 WF6g0eveZXBDLeYdyIInTuOa4gPjOlcMLJp+6xFwePJGtqfs0QwelUd9sv+czGIRwLJm
 9uBZJwyTEIZZd4Q6FWbotI8Y4zXkIQuygaYHG3BPzXoBuUm+FUrLHwjNaxFa5rgpScmB
 pu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695499024; x=1696103824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YUQZX0ibc7W8Li7Ln0ptGnc7PtpTMOK42G//26gnHhA=;
 b=cBY3vqRgvmVF/3FM1+pRHcGclcixlpA1c3n50on1FdzIziPnL9avEFvbHGAA38lTLw
 SfvdyO3ksrZtVlTdWX9E1d4k7uiibosleNPfONEjgCvX+rXuYsckwkIWbNMGrhXARNkx
 Z+tN+0f28NKe5WPLHf4OoPbxlEQaXVyI3UwAPquMjSnzWzZSGAuvoLJxaPMfEcCDpFEu
 2TP8LK1p3dX3PYZAwH1nZlOoFIfCyC968ES1w64zoNsQdebh8G3h0Dk0TDa/lJeRxKKv
 X/Cf7Iv/VgJ9yXQsBEsr7Q3wi3GVwrdTUgEnJFXOXFSveFIw2hnYDMi17cT1wHrnZITH
 U3FQ==
X-Gm-Message-State: AOJu0Yy0OtMdCw3E5VmT7M1DAM5zsxKkIDdifypcYFgsYEKv9oI9aBvo
 NEATMHfgZZnGFVOK3deyONFkHS0NtqJrDMRoFKY=
X-Google-Smtp-Source: AGHT+IERnGWNiE77QxXZi5i2mKUEI3E0mPYwmZTWmQA9bHlWBnfJWTLDY/g0YIx8yzeAtQBdKIDk560Yi0IGSGTX6w4=
X-Received: by 2002:a50:ee19:0:b0:530:f296:d446 with SMTP id
 g25-20020a50ee19000000b00530f296d446mr2163100eds.34.1695499023878; Sat, 23
 Sep 2023 12:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230906052242.21568-1-mibodhi@gmail.com>
In-Reply-To: <20230906052242.21568-1-mibodhi@gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sat, 23 Sep 2023 12:56:52 -0700
Message-ID: <CAJaLiFxwDDMfb04T17U6En4VOLJoUH6varqw765JyqQ_9N4qvA@mail.gmail.com>
Subject: Re: [PATCH] arm: mvebu: sata_mv: Add bootstd hook to enable
 sata_bootdev
To: Stefan Roese <sr@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

Hi Stefan,

In case you forgot, please review this patch!

Thanks,
Tony

On Tue, Sep 5, 2023 at 10:23=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrote=
:
>
> Add hook in sata_mv probe to enable bootstd bootdev.
>
> Note: bootdev_setup_for_sibling_blk() invocation is a noop if bootsd is
> not enabled for ahci sata yet.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
>  drivers/ata/sata_mv.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 18c7a66db1..55a5365b5a 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -34,6 +34,7 @@
>  #include <common.h>
>  #include <ahci.h>
>  #include <blk.h>
> +#include <bootdev.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <log.h>
> @@ -1104,6 +1105,12 @@ static int sata_mv_probe(struct udevice *dev)
>                         /* TODO: undo create */
>                         continue;
>
> +               ret =3D bootdev_setup_for_sibling_blk(blk, "sata_bootdev"=
);
> +               if (ret) {
> +                       printf("%s: Failed to create bootdev\n", __func__=
);
> +                       continue;
> +               }
> +
>                 /* If we got here, the current SATA port was probed
>                  * successfully, so set the probe status to successful.
>                  */
> @@ -1116,7 +1123,6 @@ static int sata_mv_probe(struct udevice *dev)
>  static int sata_mv_scan(struct udevice *dev)
>  {
>         /* Nothing to do here */
> -
>         return 0;
>  }
>
> --
> 2.39.2
>
