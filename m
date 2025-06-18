Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74AAC7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 23:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D3182BCD;
	Thu, 19 Jun 2025 01:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R2lCIPSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ED2F82DA1; Wed, 18 Jun 2025 18:10:58 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 940AA82D66
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 18:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so48493425e9.2
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750263056; x=1750867856; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UEvMGCfYSqKdSrpcOCzSAX0xFDONrGejRP5/br9AI5s=;
 b=R2lCIPSJMGtdhkDD7KKW+DtWIH4UJW1WkCRTUQKw5//9G/0Btfq/l1fbMOITdJ9uLg
 i24yCFQlDs+kbYCtvHgZAgU5C7hqKTd7Tiv2+tLwDdzSd7sQbZdhd1na0xMVEuA+8vlr
 S6awblqRSLBhuSIgB2u1bo07FfONDGG2UrcYEqLNwLKVgagD2rUSb383WM9O2nIS6E2B
 MIYkDvmxVGP14rrv2qam7q7oi2zZ9BGojO8a1HkWRxMMWX4Y0SViPScmPiCOikAtFtmM
 g8eY49Hga9PdQ7nUw7Ev+vBOBW7mN+I78d1dopEPnvfsDRibm/U+qSI+ARW5tyqm/b1z
 oUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750263056; x=1750867856;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UEvMGCfYSqKdSrpcOCzSAX0xFDONrGejRP5/br9AI5s=;
 b=qeIqH6+4pzMRdXIIDfDL/g0ef3wFh+/ehzUjzHC87y9z9U7XhMr9oTvc30nt5uOw9m
 1mTzzZXZ8/Es/er1T0hP7WauV+bIMqRXW3BL2ZDkDESYjsnuHqN+wrwtIe/NK6VuEsKW
 mmyy/PFHsOPxXcg2x1fEWq0Dle6mkykZnRFLubwxyuZBcWqqw0d5GHCkQXcG+p9zOsI9
 g1TEbcAIEiOitFGhh8kTguXzO1935SU5/Cm4/KsDtn5rRitPNhakBkODERU8uNdoVcGQ
 WlCfDraqyd9o/LNyocaiCiA8i7+sMiewizMay3mspctXEAJGVOz89TSQtIFatIPuJz8k
 Xtcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi5JqjVaxsXRUhfBaBVwaOrt/vX9AuaCWemM6z2sdQ0tTMVMx8Y9f6DZHH9EYi5y+3F7Q6Qxc=@lists.denx.de
X-Gm-Message-State: AOJu0YyPKWOt8QxCV8KE3Amq/P6tfRZpz/n1D1wyqsVQVcLeZfn6QT+x
 MnWopZ/1hINf28mMqnuVAGqNgCaMDaWTCz7OAyz+qeKlER6mFlIFUEJmjxXSv4jaWssdcp5Ntuy
 9VP2ZGCmYTuSjw2jNQAVfODxOLq0M/Z0=
X-Gm-Gg: ASbGncsYQtWizebNASPrkbPp2TlAkm9cAmokgGhB2WSdlLM3gV1/LluFe0uj8cR/s7k
 /7EAXAJivcNwGcYhWcMIGD1fFECDXpjcVVwRLPRHGfhY0XyScGwi+rU/f2GlAje0vitLHncMUQS
 qSyowgaFe01Dpxv/BYnPqe5KcO0Gb/HKF+O9MvLmIGZtJr
X-Google-Smtp-Source: AGHT+IFZlp3SvBNDuLDEPqPb8haSsihnpN8DyJUhImr2kTcQb6HSTaiM5CRODGc7mu2rIND7QYsH5vfzcgxlM7MOA2Q=
X-Received: by 2002:a05:600c:5309:b0:43e:bdf7:7975 with SMTP id
 5b1f17b1804b1-45344e65f1cmr129983805e9.32.1750263055685; Wed, 18 Jun 2025
 09:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <e3ed716de67cf4f46b303e9e7536b4938fba5a68.1750262675.git.baruch@tkos.co.il>
In-Reply-To: <e3ed716de67cf4f46b303e9e7536b4938fba5a68.1750262675.git.baruch@tkos.co.il>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Wed, 18 Jun 2025 19:10:41 +0300
X-Gm-Features: Ac12FXz0uxbSm49hzLfc7F6q0wzq7xj5gbWGHNgbmgA95gk4YRf3XYLSIwT9ULE
Message-ID: <CAGi-RU+_4PpjqRdcpTGfo_nE-MsqJFJBFzYRLTuArbFC5UJDog@mail.gmail.com>
Subject: Re: [PATCH] net: designware: fix bus address dereference
To: Baruch Siach <baruch@tkos.co.il>
Cc: Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 19 Jun 2025 01:11:17 +0200
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

On Wed, Jun 18, 2025 at 7:04=E2=80=AFPM Baruch Siach <baruch@tkos.co.il> wr=
ote:
>
> Device bus address might not be valid for direct access when the bus
> address and CPU address are not the same. Use dev_bus_to_phys() to
> translate bus address back to CPU address.
>
> Fixes: 3d98b8c504e15 ("net: designware: Invalidate RX buffer cache before=
 freeing the DMA descriptor")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/net/designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> index 0f93c25e3fed..fce3ef910cb2 100644
> --- a/drivers/net/designware.c
> +++ b/drivers/net/designware.c
> @@ -716,7 +716,7 @@ static int _dw_free_pkt(struct dw_eth_dev *priv)
>         ulong desc_start =3D (ulong)desc_p;
>         ulong desc_end =3D desc_start +
>                 roundup(sizeof(*desc_p), ARCH_DMA_MINALIGN);
> -       ulong data_start =3D desc_p->dmamac_addr;
> +       ulong data_start =3D dev_bus_to_phys(priv->dev, desc_p->dmamac_ad=
dr);
>         ulong data_end =3D data_start + roundup(CFG_ETH_BUFSIZE, ARCH_DMA=
_MINALIGN);
>
>         /* Invalidate the descriptor buffer data */
> --
> 2.47.2
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
