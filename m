Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C2DE674A8
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 06:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98C6488C05;
	Fri,  1 Nov 2024 07:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f6R6vlaU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E1188CD9; Fri,  1 Nov 2024 07:22:40 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0EF688B9E
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 07:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cb6b2b7127so2229426a12.1
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 23:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730442158; x=1731046958; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c1YY1jFGv5oVnraeJjIgHN7TbveNNr82eLrz7voFNEA=;
 b=f6R6vlaUspJM037YjYaPzZYCXRjDpBeppI0AYxPlyuW11w3jraAax2p7ZytsF9Ugvq
 NjrOU+/RfykyuEcouplFLR+sZCyiRbFTwtm2NlOKWoqtcto0mnRUhR6xmsrRDvvxkfpu
 ilnW9R1c8biaafTi83Yb9qPLqSgQ+en9rTlLnwFF3LWiZX/FlAGm+FS3s/ZLShStXVgZ
 cOReX7W3a/aqyL5mJjppgIRko+hjamnBQJdOGz6xPcXi6BLLy1zucQwICyOPRtrDvJ0i
 at8OAGTsE0YoQ/gvzvZAyl2ZKx4dRqMkNg84NpbMBdX0WCgKRkjpiFHKQ+b1t9s6vdFj
 I3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730442158; x=1731046958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c1YY1jFGv5oVnraeJjIgHN7TbveNNr82eLrz7voFNEA=;
 b=Q7B4CaocG2+bkQqXn1hj6aANyXiaWoSUQPZryUzl7SOgbox+Pl6FG/Xne2J2T69Dye
 Fray6k8z3irqfSlcO0/hgSd+rbEm0DPrFtMt3POpa572oXCXAJZKdRnT0JTqoYMZ+zb1
 UDh3WCu/ysMdXHWGh4LyvzFBHpapHnxBLwZC7zoRk30iIlAA4EWk3HkD15ph5VoyW9lr
 okdr+nJoUKCr9Q/0CaEfSQrslpWgY7pYAmpwo8HT2GgtSt2utsZ6raU6KtUmu72N7gYE
 07cNEB7t2M0xBH7YGzdg7FLf9Q5VvhivigwDYw2R7eB5vkALcssU/AoQAO7WvmI8cRr4
 NQQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV934EO7O4rG8gWkSVIF6iqqqwOWpPbuiSmvDzQ7uAsLVh2ibCBu/tJYXwGpqy7HkqqIgVxsDI=@lists.denx.de
X-Gm-Message-State: AOJu0YxpWejvCRO8Khg333zFRrK7pSW05hLbOtUZ9Tt502iQz9p4jdaq
 piEP6fpkPlf2mbusb6tNNCTZ4SKiJ7gehrnKmmUEDpn1OhhC5YJeCpaSpkFNCh7o7QmhJME3Ujh
 Ln/Frfrrqr4vWDh1xb+M77XiVwA1lImldipvLPA==
X-Google-Smtp-Source: AGHT+IEPneOQzh/XhtAApIp/w9lwPBcuquEQq5YKw7mlcZPWEsZLPyzo3D8Qm5csriKtL92s0aRuL+tgp+S3UuraolA=
X-Received: by 2002:a05:6402:2687:b0:5c9:7f41:eb19 with SMTP id
 4fb4d7f45d1cf-5cea966bceemr3990564a12.4.1730442158090; Thu, 31 Oct 2024
 23:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
In-Reply-To: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 1 Nov 2024 11:52:26 +0530
Message-ID: <CADg8p96v8ocR=8yRLmC7j0CFcCUCFfQv6P9YaST_i-ewUP4RdA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix device removal order for Apple dart iommu
To: Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Fri, 1 Nov 2024 at 04:37, Janne Grunau <j@jannau.net> wrote:
>
> Starting with v2024.10 dev_iommu_dma_unmap calls during device removal
> trigger a NULL pointer dereference since the the iommu device is removed
> before its user. The sparsely used DM_FLAG_VITAL flag is intended for
> this dependency.
> This series adds it to the Apple dart iommu driver and implements the
> two phased device removal to the EFI loader.

Is this also the cause of the crash that you were observing with the
RFC patches that I had posted earlier?

-sughosh

>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Janne Grunau (2):
>       iommu: apple: Mark device with DM_FLAG_VITAL
>       efi_loader: remove non vital devices first
>
>  drivers/iommu/apple_dart.c    | 2 +-
>  lib/efi_loader/efi_boottime.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> ---
> base-commit: 1d147b74f437fb0e85821e8271fe52bc5fd30194
> change-id: 20241031-iommu_apple_dart_ordering-558e62671512
>
> Best regards,
> --
> Janne Grunau <j@jannau.net>
>
