Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054D6D13564
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 15:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FE6188F6B;
	Sun, 27 Oct 2024 16:44:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mm4EKCq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFAC788EE4; Sun, 27 Oct 2024 16:44:42 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC6F88E78
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 16:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so438173366b.0
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730043875; x=1730648675; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JXnJEzeX+eNAXHuQ2pvXcqFnGYZnV4pzzgeIoL0Q7CQ=;
 b=Mm4EKCq2dy4viYhl2sb2uHXiNytkT6cZRinTDXr+ECBVrbDDZGU1wbHiSMY+3OVAdw
 DNaoOanyQOC+KZLfg7ObCaA3l9YDVAsiTROYWzzQ2JPE3anm1j9Vkbw1wz30gOCRNf7L
 RWaNSXP0oKTjLpsZq9T2NFiG7f6IaicZ2zyJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730043875; x=1730648675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JXnJEzeX+eNAXHuQ2pvXcqFnGYZnV4pzzgeIoL0Q7CQ=;
 b=QhK740VGeXtO3a0S4lWAxJrsSaEGZxN+1NlTrAnqjw6lbMoRwV/x2Fi1lF3k5kAl3F
 un7IPHjX8EYmfK/23UjgCl8qJXDcsJtOrjuDW9WY8JjoK2BPsvS2f0fDWZaaWHCwlShL
 2Vfgb80q4kjkNiC1rcbC1XIc+hEe4nS1c/4spAHaV06o6Ry8tAYZbKmNUoMANvM+Pw4l
 SpbObG2aC5XXKXVBMbk5tYm4Ab4+MJoOFBOOy+VTr4VxY3rhx+hhP9iCq9bgk+BBy0YQ
 SHLKyKV6w5d/aL/l1cyhRILvO5NSoxN7b2TmiXKCcwS6X47GB6wP+H8m1YDz8fcZMOuD
 e96w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiyN+gseXZ0Gax0Xa4OyTsgROmdOl22b/g27PPq9ycmBDiKQKb+kOupS5lwjfjmNM+XMx+Rwc=@lists.denx.de
X-Gm-Message-State: AOJu0YwMcrqLGVkdLrqA+pgHeP8dHglioV3pPrp5yGlE0opVf67U7m3w
 U3k+m5Zrk9YAonT/ngLTG/wtQHUR4g7pYTVI+AjbUkQ95XudmaeR3s77NLrTPyIVpBRG0hcthpz
 N3i4jKxJ+veDJ/fThAihXtx8qE8KIu6yO61fo
X-Google-Smtp-Source: AGHT+IGcaC59EWYuYOGDh7bteQSGOw0MycGzWK9Bz9zxSxSRnWBfH7gIxG9iHvZKeGWTqYxP9BU5FC/2fROcM7UYOxU=
X-Received: by 2002:a17:907:7f8d:b0:a9a:29a9:70bb with SMTP id
 a640c23a62f3a-a9de5ce021amr546297666b.14.1730043874796; Sun, 27 Oct 2024
 08:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <20241026064048.370062-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241026064048.370062-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Oct 2024 16:44:18 +0100
Message-ID: <CAFLszTg6TKpEmxW-OMxfDkz_HCaEC8ZNAv6x1pENnfQxEQ0bbg@mail.gmail.com>
Subject: Re: [PATCH 4/5] efi_loader: fix GetInfo and SetInfo
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Sat, 26 Oct 2024 at 08:41, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Some of our file system drivers cannot report a file size for
>   directories. Use a dummy value in this case.
> * For SetInfo the UEFI spec requires to ignore the file size field.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_file.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
