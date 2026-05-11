Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAA8CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5E2A83E36;
	Mon, 11 May 2026 15:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sq5lyFFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1340E83EEF; Mon, 11 May 2026 15:08:28 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 447E0800AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bc356898256so725852066b.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778504906; cv=none;
 d=google.com; s=arc-20240605;
 b=lsHSHv9PNOwVVe8T6gVwlbQx3AoseOn3vi2f8r5URl1uRRF5y0HSWWI7XHU6CycpjX
 N3VlHjqTLaNihFPNQZiRhQfw7di93DjZupb5+TYqJRIuGF/EaKU0kXUUzxmt1F5gXwFv
 2XTcgN/okAEyF6EWGZIyf2EVUxnsC9d2pHdjpYwo8rb3AtbYhzEiY2enKhiO1TuSjd5H
 hnx6Twkfdj4zdgNQGFTInS2Rs7Zjj+kF+81XRH/7R24WHK5YYQPeYohjw7FNK7gYkAYU
 ZhhJxwCIKiOvVieQ7H6bR9G4MjcPuClLqvBA1w1s9sgT130Jo9VPwJetyifwb4GEwTvC
 8LWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2E6x71goXlTdZysK07s8h/8ymZb9CU8O6lZbYBQQSKo=;
 fh=DHWba/x7tuoorNirX1jlfatUYioWd7qRviNee1YRGB0=;
 b=WWTEKml8ALUdsmCwrmZcVDb/S2VXrZ6XUHLJNqy5xbsWOt4YsG3Yk8HYGBa20uqIBa
 V4SXZ43nhs4evu+56xK5QgY7yGcndJ1TST/OwPSGv0Crh88LXe5lY0LRK86BoxbHLSkU
 OoP5FfmjmxM0Y/zrn/bot18Pb0Si/ml08yQnWb9TQ6JacsJmv6UKHy+LDq14q+PwOUqA
 EdgeFOks85OTpowQFL+qeVK3D+YqYrqmJ1LHHgXniUGedNmxeVlUns2ZkGx6O31hQIsk
 4wnWEm72ROLtxiR2KRCwD4SgnEmoNCW9fTWGAtF13PXkFMr8Cz8RKJahDKZse6VxYeSR
 GLXA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778504906; x=1779109706; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2E6x71goXlTdZysK07s8h/8ymZb9CU8O6lZbYBQQSKo=;
 b=Sq5lyFFv+eyRWn120SQy+oU/I2ra+H7GU769Q1oEX47qKIN4rRge7xE2uy/nuUWzam
 a4ngmpZb8ronmC9p7qjrQJF+Q1RUWihYDloTL/7Pj5lRg1wOxE2mUTpP4c2XVBnMXpeQ
 Qkh6OBvBVVny6bqGgv5Mdc5EYonvuwmYYAsf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504906; x=1779109706;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2E6x71goXlTdZysK07s8h/8ymZb9CU8O6lZbYBQQSKo=;
 b=ZxCK5JR2QIEf44NvatIxQWVrPdQgYcUuaPhBqux3DSXhtBIckJlbnkp5BdanDfSYwM
 h8qYDOwH4dtbW93HOUtrtk0GjAxh8lZjVaVAZcLMf/1zknDl9bqPsL1PTpVJrAPpCDvK
 +TZ7L5kcmnmcSGOYV+GlmybKhsBynemU7Z9+6CJQMz3m0DjcHhS8AG6VmrliQcbTjfIg
 EaojrytnT8dkvxG8GOiiZPgP1optEHNIrW8Ns4n2fRbZ38cnptoGjHIXqLfHeMWy6ciZ
 KLo2eNUNT5aPmliFgB00ak6jxp12VpMgHXHWSR8eysuUJNs8qrU8oWJmJKmk03hVMvSc
 8AsA==
X-Gm-Message-State: AOJu0Yy9d/FefZBBsc9dzPMjp3+CwgMc7+dMV+8u+QzWPYl8ogEN3Hpm
 rutG1erd3Nd/ssFaglh7jXlLZ7vdqMVhep4ugGtDW0Ab4egH4R2xY1EgwuPFt/AKmH5amHNUM+W
 OdoyA022nWiz3pilCht7QEWmTCn+kRa8n/dCbgLUF
X-Gm-Gg: Acq92OF+jAKmaMshi8RDgKCODTvJ7MhQfs0u3Nj293U6zNkxO2tC4PUYdcBkpGW5Gwi
 qYbAgO0CbDLNfmJSpAzgiihpvYFWOMIidvUbkLls3Ex2edfY7DwH4wNdTPmHGAdmO5j+ghHI/y2
 f6A5XYa2SzNTNUx+QFGuaNPv20mHS6JYGQePsq2FwZiNUNxFTGNqOJVqir/5WAVsHsWXUu7ds7d
 fjADrHyhnoo21uO3mbh6F0wCesrqYnl7PqJ6pzowpwtzEM2Z/tMfMNORnV/ey5luAGPrN+rop/k
 yAWdxd2kbYAVB6jM
X-Received: by 2002:a17:906:6a25:b0:bd1:ba57:ec8d with SMTP id
 a640c23a62f3a-bd1ba57f385mr115473766b.17.1778504905577; Mon, 11 May 2026
 06:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
 <20260510171723.56866-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-3-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:07:56 -0600
X-Gm-Features: AVHnY4IPeuWPSc7DREXMmZHuOdyeg1coT0N01plXl7NarFEa2VbDFBjEMuoZgcA
Message-ID: <CAFLszTip-mNGvwo3yxn1vdThb5_510-JYGhCxq=QU+eeZ_AHHw@mail.gmail.com>
Subject: Re: [PATCH 03/11] video: bridge: ptn3460: Staticize and constify
 driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On 2026-05-10T17:16:56, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> video: bridge: ptn3460: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/video/bridge/ptn3460.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
