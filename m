Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B39C4167B
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 01:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DE35875F3;
	Fri, 10 Nov 2023 02:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ogrBJupR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22EB38774A; Fri, 10 Nov 2023 02:56:57 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B8CD87504
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 02:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-27ff7fe7fbcso1365897a91.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 17:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699581413; x=1700186213; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1j9b0gbCBqlHeqFyQY0SqNECSJ8ee2kKoWhoZGi//Bk=;
 b=ogrBJupRXoMYxl1d6lZGAui1/OKg/h/prVssUSoJ5u3qbCrjXFOk5DglCM0Vlfl/0d
 1zlqAUbCX4g1ezyu6PDu8D/uAp+aLHu7yO0HA8kUKYAV9n2V067dGLJIJT/7E8UYmePI
 X72LvXOZ20xIqEP60Rf8ur1QNdvBUhYkL7S/cqSvsb8XjWazn6OisZcOgNEG6pLuOQFG
 OYZXNr8MaypWW48eDMaBuVikwE3hUobxATHXjecLTXNMY5fPSNarNnxHQ0veQkBv/+2U
 mvGbmE6p9eGC4MDJvG0Qy6Pe/V26CsKN7Zh0SPy4J9mOVliIvEkP/UnPr7XlHneHhxf/
 LBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699581413; x=1700186213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1j9b0gbCBqlHeqFyQY0SqNECSJ8ee2kKoWhoZGi//Bk=;
 b=i5EEc5gnitfuGKeVBK0ciF4UA7Lbhp8WAuKIUow43gsIOHuYGB9eDo3+r09fHL4Qql
 waSXGS7icf42zwgEf4d2uhIITlgnuw3BaVSFon9/hanacZEYrFlfGIFV+WIaoD4DKv3p
 UmnKFNyJo77MrGnORDe5QEGRsljRtMRxMxw8nd15r64xJwSbVpNY6f6hYJDpTeVOz5yU
 h+xUkZBDTRFQZWPGFCagm75LjxnEun7HAKQ0RkDQbGEHoivD69YOZ9in+3sB3t+fQcG2
 QLUFD6VBpXxjH6jV6LiFu6GxLy1HYAmxXEiQ60mBU7P2h1/Rom04uWqoecOGUT+PZJSg
 rzyg==
X-Gm-Message-State: AOJu0YyZxWRAuYQq415ZuQ7CdtSmCbC0WXQK8mMBX18QbHGf+OaKJHL3
 V8Z4T5P4POlIB+zn02HBVIJo9sRrvGOu3Hzii/ZEbA==
X-Google-Smtp-Source: AGHT+IHLv9x8pWhzgTW8t30WnBH+tlgTk5VdXOMyBbPYMps7qW0kIUYP9xn1kVRcHHMoFNRDd628vYzoG73D02SYhzw=
X-Received: by 2002:a17:90b:1b45:b0:27d:9f6:47a3 with SMTP id
 nv5-20020a17090b1b4500b0027d09f647a3mr3744010pjb.31.1699581413229; Thu, 09
 Nov 2023 17:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20231109223435.706053-1-igor.opaniuk@foundries.io>
 <20231109223435.706053-2-igor.opaniuk@foundries.io>
In-Reply-To: <20231109223435.706053-2-igor.opaniuk@foundries.io>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 9 Nov 2023 19:56:42 -0600
Message-ID: <CAPLW+4kfwMdxxJgYoYNnGnMQsi-UoOUU0_QAdgAWPyJz_Kn4bg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] poplar: provide more space for kernel image
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: u-boot@lists.denx.de, Peter Griffin <peter.griffin@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>
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

On Thu, Nov 9, 2023 at 4:34=E2=80=AFPM Igor Opaniuk <igor.opaniuk@foundries=
.io> wrote:
>
> Adjust mem layout, providing more space for linux kernel image.
>
> This fixes the problem:
> ERROR: FDT image overlaps OS image (OS=3D0x30000000..0x32580000)
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>
>  include/configs/poplar.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/configs/poplar.h b/include/configs/poplar.h
> index 6e8adf9187..629b335f5d 100644
> --- a/include/configs/poplar.h
> +++ b/include/configs/poplar.h
> @@ -37,11 +37,11 @@
>                         "env_mmc_blknum=3D0xf80\0"                       =
 \
>                         "env_mmc_nblks=3D0x80\0"                         =
 \
>                         "kernel_addr_r=3D0x30000000\0"                   =
 \
> -                       "pxefile_addr_r=3D0x32000000\0"                  =
 \
> -                       "scriptaddr=3D0x32000000\0"                      =
 \
> -                       "fdt_addr_r=3D0x32200000\0"                      =
 \
> +                       "pxefile_addr_r=3D0x33000000\0"                  =
 \
> +                       "scriptaddr=3D0x33000000\0"                      =
 \
> +                       "fdt_addr_r=3D0x33200000\0"                      =
 \
>                         "fdtfile=3Dhisilicon/hi3798cv200-poplar.dtb\0"   =
 \
> -                       "ramdisk_addr_r=3D0x32400000\0"                  =
 \
> +                       "ramdisk_addr_r=3D0x33400000\0"                  =
 \
>                         BOOTENV
>
>  #endif /* _POPLAR_H_ */
> --
> 2.34.1
>
