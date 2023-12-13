Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676FEC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19439878BF;
	Wed, 13 Dec 2023 21:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HtjNDkSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FC2F87872; Wed, 13 Dec 2023 21:39:22 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CDEB87864
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a22fb5f71d9so207511366b.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499959; x=1703104759; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uikBuOp2lHVOCPZwmZkVJFMPuWfo3oxBbSbiaiG8v3s=;
 b=HtjNDkScQrP9Jh+XN353OSZurt1/pZSeBmSfoBhp/m3M01V86xCtOw1+XR1IgeEKRt
 C9CALMc+E462ERNf+mgJ59+4BZbmqUGtjB6BTOqf9BQ3mc++g8QQiHIJNUarVJENCCrZ
 6nKb8pxm2ujFjWCVuNKsLSIc/n8FWPSjJTkRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499959; x=1703104759;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uikBuOp2lHVOCPZwmZkVJFMPuWfo3oxBbSbiaiG8v3s=;
 b=Sj+v4FSL6H9NXahYd5Dyk11obXIDIG9WPy5SpD6/vFoMTAz2Giq6eR7EXS/Z9hCNsh
 pkDJY6HV7b2NGFcv6ujQKTRtIr/0FO1RYcyUeiyPKKV4WnLh0nBmGibHmWxH8cdZP0cn
 aOoLrIAVqBGMIHRgYimZsaG9qZBUHzQQYOE6wSFAhhlJUVL6iNAgxcTePMtygo2ygHki
 CHM/91UPo3eL16666OIL0h+utudTUkXCwogn+1PZjOisHJViB+nQ/Y9gUhBYOeTGrWT6
 w8zaYGStl+jquVV11C2XzRnRQhTPdRewR47qrjCrlSgv6qcb1+c2iVjCVIxwhR2ec4Ot
 eiYA==
X-Gm-Message-State: AOJu0YwVWNtwWdE+ewybSsZPr6uWO3H0LOqdS7vySJ+Nr9QKGAMmPXHm
 fthUw7W5KnqXfCsk2B9xENBRYiUr3I2eU5aoEUjg/xehedMqCLiE6bc=
X-Google-Smtp-Source: AGHT+IEg+aULZbuqCDAwNu0FsnKqUsQH4Z5pGd86lMljwiQmphP3Vlg7/WXWKW+LhJwEJAAg5gyoJN0e9lOQ26MD2Ds=
X-Received: by 2002:a17:906:109c:b0:a1a:5397:b67f with SMTP id
 u28-20020a170906109c00b00a1a5397b67fmr9665335eju.4.1702499959538; Wed, 13 Dec
 2023 12:39:19 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:18 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ1VV13ESFie-8XEu1JEC=5YX9D-TATDVPwJC6M7AYTxsQ@mail.gmail.com>
References: <CAPnjgZ1VV13ESFie-8XEu1JEC=5YX9D-TATDVPwJC6M7AYTxsQ@mail.gmail.com>
 <20231118215237.94875-1-heinrich.schuchardt@canonical.com>
Date: Wed, 13 Dec 2023 12:39:18 -0800
X-Google-Sender-Auth: Mql-iWPzFO6soWWrEICWHsQ66Rw
Message-ID: <CAPnjgZ2_c4dz-KSWCA49WmCWpmeapoQZP26KwutiEDJgkK78eA@mail.gmail.com>
Subject: Re: [PATCH 1/1] acpi: simplify acpi_write_ssdt()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Sat, 18 Nov 2023 at 14:52, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Converting to void * is superfluous when calling memset().
> * acpi_fill_header() already fills oem_table_id.
>
> Fixes: d953137526cc ("x86: Move SSDT table to a writer function")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/acpi/ssdt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm/next, thanks!
