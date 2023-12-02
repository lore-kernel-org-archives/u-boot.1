Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B0DC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B084C8771B;
	Sat,  2 Dec 2023 19:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MNbjZUDd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5568387642; Sat,  2 Dec 2023 19:24:15 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 404D387702
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5cece20f006so36832857b3.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541452; x=1702146252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pSampsbLmxbl3+HjengSlsb9T2MppNy96zc0bADlh+Y=;
 b=MNbjZUDdf4spulzBHsiYdraFOQ9WDOgWucakPujj5f8RiaRpDewayfAofh42a1L0s6
 QC2x39RRRq9hN1G+kaEaDHF6LC9glST8hlqUmMIlHMEqjQIqJub/k/SGeNhWZ3i1UOub
 /gvZxQZVMra+HOr/mWOJVgBZYSOIaftKKCrW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541452; x=1702146252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pSampsbLmxbl3+HjengSlsb9T2MppNy96zc0bADlh+Y=;
 b=qncV5MfDdq+rzuCxkiNOaX/uK5o+s0F+TWukzRKydssCdtzm63z0KLTj2SKjd1oBmO
 nu//s/CP+0lBnSA0SdB5BqJ9pH5khw7HSePNN7S+cjn7WLrPvnKYNZGePb4FJlHYJLBQ
 sEvZ/aDMBITGgyIRb3L3P1MiZs0GvQreSjLLHGeCZc7fYjnbK7IVc/0UGY5CWIGZrpBQ
 vbcgNETCrEEMSwMa8QdYU5z2boUW2Cfp8vTENiyYUM3F8LENYQ3oQvgrgtEv4Kx/jsob
 DUt9ychIqML58qruusixlIWg1l0EZOhIx5YHXZ7Tctx8sevUaY/Ix2374XJ3i+A7tdL1
 8DWA==
X-Gm-Message-State: AOJu0YyQa8bVP7SxmfQ61e3ZDlGOPU0AuQ7DHzD0Xd1nCGCE3r0ElIZ0
 2SeCk+w+6Hrwpd2kq3GkSTSrAbBiAGxaZTuDQkjv0RWLtmkzlbl2zLARYA==
X-Google-Smtp-Source: AGHT+IG3srbGZxx9S3RnxrLyYiN0dvQt3OMXwOP9reyqSl1uSQUJgnJS3or3dmpEmy6xjcmU3yJdOrz+vKxeNfSulX4=
X-Received: by 2002:a0d:cb48:0:b0:5ca:4b49:48a7 with SMTP id
 n69-20020a0dcb48000000b005ca4b4948a7mr1523973ywd.43.1701541451715; Sat, 02
 Dec 2023 10:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20231122131154.2444690-1-trini@konsulko.com>
In-Reply-To: <20231122131154.2444690-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:23:09 -0700
Message-ID: <CAPnjgZ2b00ZfQKRgXw71Tta9-TwRUGLu-h4usi3+xgOeFYFPzw@mail.gmail.com>
Subject: Re: [PATCH 01/11] global: Remove duplicate common.h inclusions
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

On Wed, 22 Nov 2023 at 06:12, Tom Rini <trini@konsulko.com> wrote:
>
> These files include <common.h> twice. Start by removing the second
> inclusion of the file.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  board/data_modul/common/common.c          | 1 -
>  board/grinn/liteboard/board.c             | 1 -
>  board/toradex/colibri_imx7/colibri_imx7.c | 1 -
>  board/wandboard/wandboard.c               | 1 -
>  drivers/gpio/gpio-aspeed.c                | 1 -
>  drivers/spi/fsl_dspi.c                    | 1 -
>  drivers/video/exynos/exynos_dp.c          | 1 -
>  7 files changed, 7 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
