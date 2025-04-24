Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3387EC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 18:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B74E68056A;
	Thu, 24 Apr 2025 20:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AoCS4HcM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E40680BA8; Thu, 24 Apr 2025 20:31:40 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64DB6803CC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 20:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ace3b03c043so218594266b.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745519498; x=1746124298; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kEAUnEPIr6LaG+yu6vZ9WznLvbekV3fzYQARbkqHz4o=;
 b=AoCS4HcMhx4iRG7ZI+SQ2ekecjOR61JVWxB5PFUGJV9swPJZtobQ570zhkFJ/Qyzo6
 UC9k1L6CGx3MMMUvXJ80kTMbabWOpD55Hsnss+iaTAjfwigthOzHIX2/lp+iPV2y24Ii
 hViEcmS0RwYGHvVOplzJX3iLsBg3iNcWNprTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745519498; x=1746124298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kEAUnEPIr6LaG+yu6vZ9WznLvbekV3fzYQARbkqHz4o=;
 b=pFtWqGtm3AuJmqlsRZQXyiOVLAZpQRuI0sKjhykQrs+EKyQIAinG8Zmnz0qYMIhx6g
 utLjsCjOWKdLE1TqEsH+WpyK7qAODbVyoiQz4wkhx25KhjnKbQMmJpVMUgmKvAosQrYJ
 6aPyn0WgBBSXc8Ywu8lJpLsy1yrxT+IENXu4z2aBBD+n4iRJsi1P7AsXBw0qKlbjKQhh
 v2fzj/pl9ogUOoDUsCnac2DPaL+mfQnB+5DpVowRdG0RYH1L5DGkTOj3ZVuLqxLjQ74m
 lQh4QY6UT+kJG2RJeA3DoWZs/qUtX5gD6NzbF2OBFwbTN4mDKttinvrYzYWl0o7yWaYL
 Y+kw==
X-Gm-Message-State: AOJu0YzwT0/MYs5Hw0IM582KKo/LR6mJ1hEqdI4hSUJhWwgAIppC8TPm
 INH2vRKcKYUQid3ko/mRhg7eaQyolS9TAqzV/RwUlEuvMx2LpDVZxWJPbxwZIKOTBaYutiaFEat
 BLYUbXwMFyGekYVQJkJPD04O1dt3AidxWitNW
X-Gm-Gg: ASbGncuGzHeHjoBCCLVI3ws3zKej7okMXLox60cPxctzz9J1PXwqRQRhrNAlPt4O44T
 +4Yyq1Zyqj/pHi0xHi0RTvn906QwOlepRndR+Vxp6z1oX+lMbOmfDJ/pjVOr1lLPMa0NNsAj1i+
 WkW3V6fTDZOcosfysPOkOFUQ0=
X-Google-Smtp-Source: AGHT+IGeSh5CY6Dxgtaib0ZFt3XvARJ9vM1bsYQvORluO/kJo45RQ1ad5v7bwp5TOPtt1477ls6UeJqP3YmnDFNwoSk=
X-Received: by 2002:a17:907:8693:b0:acb:6177:8fbb with SMTP id
 a640c23a62f3a-ace5728022fmr378862466b.32.1745519497760; Thu, 24 Apr 2025
 11:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250417132718.2023555-1-jerome.forissier@linaro.org>
In-Reply-To: <20250417132718.2023555-1-jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 24 Apr 2025 12:31:26 -0600
X-Gm-Features: ATxdqUFhJGOTyI--yQCj9otzxEccdwSy2Qaz1hXVvf9KbhU1Ux5B8IZDs4YV2NY
Message-ID: <CAFLszTiDw1VvRS_HLbqguC4YxU+4sZHV2oTyBo0ZLsURfSG45Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] NET_LWIP LMB fixes
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Jerome,

On Thu, 17 Apr 2025 at 07:27, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Two small patches fixing issues with tftp and wget when the network
> stack is NET_LWIP and LMB is enabled. Plus one prerequisite patch
> fixing a problem with wget that does printf()/puts()/putc() when
> called from EFI which is not allowed (messes with the console output)
> and a small refactoring in net/lwip/wget.c.
>
> Changes in v5:
> - See changelog in the individual patches
>
> Jerome Forissier (4):
>   net-lwip: change static function wget_loop() to be wget_do_request()
>   net, net-lwip: wget: suppress console output when called by EFI
>   net-lwip: wget: add LMB and buffer checks
>   net-lwip: tftp: add LMB and buffer checks
>
>  doc/usage/cmd/wget.rst                        |   2 +-
>  include/net-common.h                          |   2 +
>  lib/efi_loader/efi_net.c                      |   2 +-
>  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    |   8 +-
>  net/lwip/tftp.c                               |  56 +++++++--
>  net/lwip/wget.c                               | 117 +++++++++++++-----
>  net/wget.c                                    |  23 +++-
>  7 files changed, 159 insertions(+), 51 deletions(-)
>
> --
> 2.43.0
>

Now that you have your sandbox tests, is it possible to add a test for
tftp and wget? It would be nice to see code in test/ for changes to
net/

If you need help please let me know.

Regards,
Simon
