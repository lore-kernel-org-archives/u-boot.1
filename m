Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B339EC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3063687706;
	Sat,  2 Dec 2023 19:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oc5O1SQ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39E1D8773E; Sat,  2 Dec 2023 19:27:19 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CB7287706
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5d400779f16so14637507b3.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541634; x=1702146434; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o5WG9p14l4OVSBCbguXF64jAa0PTWnDm2pqB6sJF6Ko=;
 b=oc5O1SQ0Q5wQwqm5nX0A8FX6NCHvz2NrlCEen8vhBanaoyp3n52u5P2Z1sqnJWQvRq
 gr34Y97i6OjB6dquzkFPiIp7rTXnbzhwGNsSileGsl5cr37R4ZAqkmqRdXSWTvDp/iPF
 nXtf3yOyAb9ipgd5dRsHWFgn31v6GAehB1R30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541634; x=1702146434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o5WG9p14l4OVSBCbguXF64jAa0PTWnDm2pqB6sJF6Ko=;
 b=qPUiDb3h8cM7vAOWTlSodD713fABQiySEChxl31nmTgr2DHjwtByeBCU7V0HTB24FD
 4g+y40gPP56ZbHr+b7yDQEx7qYmSoa/tohk3f3a5ivMP1F+5pB5xp4K6QcJhxpP3gaeB
 bizM+OzyGDk2xOsJVPm+Lu7qHrgMhgy1VUZvWyNEdA1hZynY8APN+aDh1uEGALf3GNng
 QsFXo/E1PqvtpfwgAlCSbz6t6dzuC4RJUZ6MO7Ff85OKhHkLXsMZsidRKfQieVp5EcsJ
 AFjTYW7Gp2b3P+OlkVhEDg0PAQH8XHdHs/5xXXHxsZT2fux9UNIrxmcVezPTojTrEn3r
 ppoA==
X-Gm-Message-State: AOJu0YximdMN2cSWJ6Mxm9cxI3FfLliFSLRXhOKBN8A9JUsI3NFM0w0D
 rBkNdbIc+YU7DN5ooz/w6quhCrFo8znfQ4O9eOT08CF0/m1GSOl6pAUzOQ==
X-Google-Smtp-Source: AGHT+IGMyX9cUEZ1NrimUp+ftzyDf5QDFokovuuFGnWDiT/xL2x44aeXxw+NJ/UIKr5VWahOkbq8+BuGsK5iOkGQDpw=
X-Received: by 2002:a05:690c:dd0:b0:5d7:1940:3eed with SMTP id
 db16-20020a05690c0dd000b005d719403eedmr1024703ywb.30.1701541633607; Sat, 02
 Dec 2023 10:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20231122235202.630114-1-moritzf@google.com>
In-Reply-To: <20231122235202.630114-1-moritzf@google.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:26:40 -0700
Message-ID: <CAPnjgZ3WovcixU04h_gCXJBQ1CWeTpnQSP_MqC_iixnvWx2e9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: Fix error code and log to indicate busy
To: Moritz Fischer <moritzf@google.com>
Cc: bmeng.cn@gmail.com, zhikang.zhang@nxp.com, wenbin.song@nxp.com, 
 u-boot@lists.denx.de, patrick@blueri.se
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

On Wed, 22 Nov 2023 at 16:52, Moritz Fischer <moritzf@google.com> wrote:
>
> Return -EBUSY if controller is found busy rather than -ENOMEM

-ENODEV ?

> and update the error message accordingly.
>
> Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
> Signed-off-by: Moritz Fischer <moritzf@google.com>
> ---
>  drivers/nvme/nvme.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index c39cd41aa3..ec45f831a3 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -835,8 +835,8 @@ int nvme_init(struct udevice *udev)
>         ndev->udev = udev;
>         INIT_LIST_HEAD(&ndev->namespaces);
>         if (readl(&ndev->bar->csts) == -1) {
> -               ret = -ENODEV;
> -               printf("Error: %s: Out of memory!\n", udev->name);
> +               ret = -EBUSY;
> +               printf("Error: %s: Controller not ready!\n", udev->name);
>                 goto free_nvme;
>         }
>
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
