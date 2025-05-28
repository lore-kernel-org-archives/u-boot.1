Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93122C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 14:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D1AF83314;
	Wed, 28 May 2025 16:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MUE6tzE6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBAF0832A4; Wed, 28 May 2025 16:32:40 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D405983323
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 16:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-604bff84741so5861335a12.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 07:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748442758; x=1749047558; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rR5T3lBUk9nQW3Jtd+170KALT+wnlwAEnl4ixheCCa8=;
 b=MUE6tzE6yiSBhphGujOzt+uynaTdJYDCZQdQg3D4x/6zej0leW4YpRJPRGF+Hj1Fj3
 AfsWQd9ChyF0Ijpi1jIt/Uap5VRm+XPDQ6ovbEkf9PT4Aw4c8Lq/hsp5VqErL2StYYOO
 c/APu2Y4L84AnxMPPqrndeNASW+I8Fw1DS6Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748442758; x=1749047558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rR5T3lBUk9nQW3Jtd+170KALT+wnlwAEnl4ixheCCa8=;
 b=lgNT+Zo/zDrcprDIy29TUuusiiktcfXoHdLfZISrHdUFREJuH3BSbHxIDWPvKHXL9q
 St34pVS2ulFNSqJCgp7rD7sPwsEoXWUCyuwzX6ZrWuHHGBuu0y8bIcUEQZvfajMrb33Q
 QpWV2OYW7YekUW2A3KK8FWfY5fMRX7QSYF+lmzb3+m+iQw/vEPyVNDyNj3MJLMjbfOft
 Nevp5HWTpGqALsWFJ7Yfg+uBiiQnsT8+SrbqMiHpwCrSTF7jhtYxyJ0GOibQpqXyDzIG
 xuHxYehu9U26MwqjVCOiL+x5CVGcduWMZyU/zLBecmCHpbZnaxPdYuWIMtEnZOzCCQs2
 MOVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAmL6Ju8iW6J+2x2Dv6sG1YQkmQ3d90j9NZXz6YAx55PaQ+12vhQ+Gdi+Rvd+n97T7v5Y70Yo=@lists.denx.de
X-Gm-Message-State: AOJu0YzRCGz/j2q3IfjTlZpj7SK90Gzp6oCTzaLIkuzSee4GSiaRYjZA
 51ePrAIx6/Amg1LhS0BHyvSGK0xnbCjoN1TsNKy98NdtzaDR/t6LK0Ked3s7oULbqPUERkA9SEK
 vNXM8P8FZ3EaCLp8VeSvytbN0eNT6+pNXk1vUnRwV9xcvmpQuz+a79g==
X-Gm-Gg: ASbGncuw6M1oVBQ/KNRAeQ8/I5R6df5X8Gr9g2eFlbK6gGTld295M3uYItJri0C9S2+
 oovv++e5wY6pKUQOivPj2LL/v05sxUqOiCPW5DNO72Jzump4qEXzhSiq+aIK6FEVLye5Gk3QT1G
 GWedhrD4sSJJERTlTqqkUHxJQaAQB6MU4=
X-Google-Smtp-Source: AGHT+IGtXySC6qsBVk68f/Byg/1V/dBcevaU269hE8qdOHURHpS151aHBe3q2l6E5hhCXCqpkbTUSNKmvxr7l2cQUSA=
X-Received: by 2002:a05:6402:2713:b0:602:1832:c187 with SMTP id
 4fb4d7f45d1cf-602d8f5d5camr14036659a12.4.1748442758170; Wed, 28 May 2025
 07:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250528-dev_read_x32_default-v1-0-6ab1734dd7a2@cherry.de>
 <20250528-dev_read_x32_default-v1-2-6ab1734dd7a2@cherry.de>
In-Reply-To: <20250528-dev_read_x32_default-v1-2-6ab1734dd7a2@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 15:32:18 +0100
X-Gm-Features: AX0GCFsVemvZ-cl_tx2GKsBTfGQ6xm2mFkQfm5SITV3r8qB2NNPEIlh2U_LNkSE
Message-ID: <CAFLszTh1jzRM+SCSKdNG9CQsJ4pZCaKCMF05edDgyAkFfQR+NQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dm: core: use s32 instead of int for
 dev_read_s32_default
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 28 May 2025 at 14:06, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> dev_read_s32_default is for getting an s32 from a Device Tree property
> and allows to take a default value if that property is missing.
>
> Considering it calls ofnode_read_u32_default which takes a u32 and
> returns a u32, it should do the same instead of using an int, especially
> considering that int size is typically architecture-specific, as opposed
> to s32/u32.
>
> s32 and u32 being the same size, dev_read_s32* functions calling
> ofnode_read_u32_default shouldn't be an issue (at the type level at
> least) as the information will be stored appropriately in 4B regardless
> of the sign.
>
> This incidentally matches all other dev_read_*_default functions.
>
> Fixes: a1b17e4f4c82 ("dm: core: Add a function to read into a unsigned int")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  drivers/core/read.c | 4 ++--
>  include/dm/read.h   | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
