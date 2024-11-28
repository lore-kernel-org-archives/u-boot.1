Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A615AD69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0BD889CA5;
	Thu, 28 Nov 2024 16:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="odEyj5AW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A1DA893D7; Thu, 28 Nov 2024 16:45:50 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 778C88988F
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53de035ea13so995257e87.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808748; x=1733413548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pnOHpabJeO+gb8652wk84LtnnH5di9TptqJBFIftdps=;
 b=odEyj5AWBLNU7JSZWxS3h083DEH7RM4Rc59hTres/giTRv8ZjtyDYAusu/xdkceTni
 6szupAalsE7x5ViE7ACunQONpoausBoWmWTmKUG9YGTbINw2PRCeFHT9ptRc60iukCnK
 T/pdwyQUKnI7w04PAJqdPgoxFWi85rYfAymDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808748; x=1733413548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pnOHpabJeO+gb8652wk84LtnnH5di9TptqJBFIftdps=;
 b=lkWJqm8OcVva0BryO4hcsoEixFm+NHKhgouFiRmaTaleh9G1SrvtshJZ1c4TmxAjua
 Sx8cwtWlvXXayIOTurzRhBcMOYFmD/WXQcN/UCIR7rb0iDrRPhmxsT0i4qyBMD0YU/q3
 AX/CEsqKTGCTQKpssNko9R7FjGihCqogZD8zJVOf/tTwUIXtnb6PxazC90vSf7F7v6sJ
 tHybN/485RY8zC8Y/04dyF9t0IjO34dC6ectPB+8zUH2QYmiAYno3dxA6YBovAZw7K4r
 5jnFBdu4ZMB9kcKmhPDm0xiyKkkLQL2oFUrDDqgofgc0C/RCGw7P+0isv5lJFCMKCnFF
 sHRQ==
X-Gm-Message-State: AOJu0Yw1BQXliQghuHSXS49/sp/Y6OOBALkGE0FHGij9H8aH/MS4hdv5
 MzjqqUDApUiehfLuBKZEgXxgE0nt3MUqkHfdigXjsXWaI1PrjPmHTVLXYZEuXG2IZ3VbqjzNexV
 AUi3rnY8hMKlEo7oT/oUDKFKcJ9KO+Da/8Z5A
X-Gm-Gg: ASbGncu/vKW/r944s9ndY8gSQYoZT1vrAvjvFm2Za3qra1dTlcpOi/VGM/A0O6R5/KO
 kEXjOCHZChGMcy/mESDR1P6lOGWaghek=
X-Google-Smtp-Source: AGHT+IGH31n7LTueWCkdMsmGmLPA+ohWiqjpvCo9tsifMr9SFSNjmkXa3tEMdthTqqTmFpqETMaQKauTpM1reRt6DGg=
X-Received: by 2002:a05:6512:224d:b0:53d:d486:9705 with SMTP id
 2adb3069b0e04-53df00c5ec5mr4854953e87.9.1732808747616; Thu, 28 Nov 2024
 07:45:47 -0800 (PST)
MIME-Version: 1.0
References: <20241127172247.1488685-1-trini@konsulko.com>
 <20241127172247.1488685-5-trini@konsulko.com>
In-Reply-To: <20241127172247.1488685-5-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Nov 2024 08:45:33 -0700
Message-ID: <CAFLszThq9dkG82cuzBrYTmXC6gZG2Wihdt1G9yGPHMO2Na_jQA@mail.gmail.com>
Subject: Re: [v6 04/12] docker: Use "make -j$(nproc)" when invoking make
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Wed, 27 Nov 2024 at 10:22, Tom Rini <trini@konsulko.com> wrote:
>
> We had a few places that were not using "make -j$(nproc)" but instead
> just plain "make" and so slowing down the overall build.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v6:
> - New patch
> ---
>  tools/docker/Dockerfile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
