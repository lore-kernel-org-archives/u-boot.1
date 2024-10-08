Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B64CF0427
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 21:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2312788EE8;
	Tue,  8 Oct 2024 23:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mm9bYjAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE61A88FCB; Tue,  8 Oct 2024 23:37:06 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F191188EE8
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 23:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c915308486so1030818a12.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 14:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728423424; x=1729028224; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IwzhIKGncDs0WW1NiiiQu/3zt6AQsBOwwcddElwLDFA=;
 b=Mm9bYjAbjSWUdjwy/TRfN5CZuzcU6hAQk8mHbLB0SvCdY6x4EMFasHf4+Q0ohFEd/e
 OtazADVH3oOEr7r0mWThZCp/YvKVrUGJLYSkYWGG8lDdROW++P7EpCRnUgV2xrFmDzSp
 ApcIOOdkmjE/o61dsXVpgPUDW6Jm1iZe9j2E92j4UrMO++eHL6QI3BRN8GoI8NblDWrK
 iFtA7T03SoSzxfkorpvNPqytk0FJuuu6KmZ//f3Btq6xJKtYUrtlX+IyPMPLRxYlyYGP
 cV/kiE2Mm3ghkDOKvBUmqFyCaC6N19SyMF9XEayPVg9nrOXfsvSOqwzqSts+ZGepKE25
 8S6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728423424; x=1729028224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IwzhIKGncDs0WW1NiiiQu/3zt6AQsBOwwcddElwLDFA=;
 b=s8fbdZILrhX9/UBNvZoyQ5MmNsFyQ51UNUtNYMyPO42LDrB3wvJ4Cg4sF+LCrcgwd1
 Kz3NgVXIcOfLMrMtyDC6e6C0wz1Buu8YI3DDhTHm/6Btn+3vNfIz234MgzyxzyKTZN8T
 Sku6IJHIP0r2JBImP19K2vAiNnzmX9Ue/AFByJ3btVvrSLP2xOQhKRMroWUcoONS006a
 Zu/2jyl6hFJkiYbWr8XMucPz9RsecjlpQfTrXxL2eJpONgEB5JO3yAtUeoLLiJUhU9QP
 xmFrRjngqtpz9eK3EaFNvZkjK9EkFqx23+rKQC9RGkydIEr9apZ40hqxDWnGl9NdSnYM
 mpzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjsG719h6wvsTAoycJjYsJQE4AZ1sQ+w83XwOsAy9lb1qBqdzhOCI+Y2KRyQTNDhIVSBiwruY=@lists.denx.de
X-Gm-Message-State: AOJu0YyCCu/8oV5NsRmHlDtSCIUJKNxz6kxEZliNhXb4LLZ0VrMwECyF
 5LBG7e+icMAn6PCPAjI06+GNmrMURDm++tQ9fcDZNSG8e4hV6SJYy2EIAHq9AUDn4kD9DylsNgr
 W209EFloO6emVjqtE7HOBIyOTS9Rgo8Vp
X-Google-Smtp-Source: AGHT+IHqLLLJ/Ru2IKNgWotHCaPwydzGD24AlJR6q7x1zUGm2XzpvzeLUGsXQ9gP58ZAiQq/0dl7uJvzUQL4oU/nHc0=
X-Received: by 2002:a05:6402:4402:b0:5c9:1f1f:8317 with SMTP id
 4fb4d7f45d1cf-5c91f1f86ccmr23940a12.26.1728423424207; Tue, 08 Oct 2024
 14:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20241008204614.56215-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241008204614.56215-1-heinrich.schuchardt@canonical.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 8 Oct 2024 22:36:53 +0100
Message-ID: <CALeDE9P_=8nRdRzE-rQSG0qcJ2ToB5O1yg0-9HH=Bm45NLabMA@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot: type boormethod
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Tue, 8 Oct 2024 at 21:52, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/boormethod/bootmethod/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> ---
>  boot/bootstd-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
> index 5de8efce19a..fdb8d69e320 100644
> --- a/boot/bootstd-uclass.c
> +++ b/boot/bootstd-uclass.c
> @@ -122,7 +122,7 @@ static int bootstd_probe(struct udevice *dev)
>         return 0;
>  }
>
> -/* For now, bind the boormethod device if none are found in the devicetree */
> +/* For now, bind the bootmethod device if none are found in the devicetree */
>  int dm_scan_other(bool pre_reloc_only)
>  {
>         struct driver *drv = ll_entry_start(struct driver, driver);
> --
> 2.45.2
>
