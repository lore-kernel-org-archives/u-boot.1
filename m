Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75732C47063
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B528746E;
	Wed, 15 Nov 2023 14:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dj5VAr9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC7387227; Wed, 15 Nov 2023 14:17:11 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5629B86366
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5441ba3e53cso10169363a12.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700054229; x=1700659029; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R0xJlnnCbhxUFsvMAwVQKb8gHtrOrQ+YqvZMRXvxxyM=;
 b=Dj5VAr9xQLXoOfZ22nWMNz+jKrLEdFkDUGxmIo8Y9ehQfPznoRSH0sYYfpDpfmXQPV
 Bt6DQgBTd6do/qX0awAPNV1IPn4p4QKw1Y1EwvZdmC+p0qc558tS3ZZS50wO7Tw8jId2
 /e4C3r4DRcnIHUSEFonG6cH3Knqu3zpLq7zoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054229; x=1700659029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R0xJlnnCbhxUFsvMAwVQKb8gHtrOrQ+YqvZMRXvxxyM=;
 b=TIIopJyOttwlDvLRcmW3btu5qTm5EeXprn7IvnOWwkIKfPS3BbEZJDwvcLcLLTyOta
 t00cqzlv4vbd4HJooe+FfZNdEQVoao42B6x1k4tz+xzqwh2p+rUpaO1Rz7demuaezIGS
 zUrR6mrpaIY+sfoWPGhaA4fqpS/EG/mlcZPvEEdVd58Nu8SQuKn7qGVeVeTGGacbKPwS
 6AEyboc7h/MzhjqGBf98ovO5+iPDbYU5K0tvFsdkhSSGi2saDy8zsrmSB3gZ/psv4nWW
 zLjxZ0cnoBFztDXxFQai+pgJr/5w7K5bREtRXDlWcnfzcLwxpFcvc1YDnNCc0uyUkco+
 eAjg==
X-Gm-Message-State: AOJu0YxXV7XtzPApo1NKsH6/0eJmDQIpV3r6jdDu+RmYr7TowUtZddnJ
 q4iRvEzHDCjbNPhcp65oDWAkEt+I8hZMBVfKU4XjGA==
X-Google-Smtp-Source: AGHT+IGpCdguhv+Rd+WtBDERPZp44kUUTowGHber/qwcCjv/x7clQEHZWdXzESrZGfcREvcdBjbhQ8iFJhcxBE23+KQ=
X-Received: by 2002:a17:906:7943:b0:9a5:874a:9745 with SMTP id
 l3-20020a170906794300b009a5874a9745mr11622400ejo.26.1700054228720; Wed, 15
 Nov 2023 05:17:08 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Nov 2023 05:17:07 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAEUhbmXs+r6Rngsv91ku4FWpq59w8Wq=PjX_sGdHjkaY4md8wA@mail.gmail.com>
References: <CAEUhbmXs+r6Rngsv91ku4FWpq59w8Wq=PjX_sGdHjkaY4md8wA@mail.gmail.com>
 <20231002011450.462468-1-sjg@chromium.org>
 <20231001191444.v3.1.I9f7f373d00947c704aeae0088dfedd8df07fab60@changeid>
Date: Wed, 15 Nov 2023 05:17:07 -0800
X-Google-Sender-Auth: Tz_0DmDDOzK7A65aCyd-0ZV0auc
Message-ID: <CAPnjgZ3-rRTiLs40ub7sRA52-r1bBoXMDdMAt_21pm5HU-RU-A@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] efi: Correct handling of frame buffer
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>, 
 Anatolij Gustschin <agust@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
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

On Mon, Oct 2, 2023 at 10:23=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> The efi_gop driver uses private fields from the video uclass to obtain a
> pointer to the frame buffer. Use the platform data instead.
>
> Check the VIDEO_COPY setting to determine which frame buffer to use. Once
> the next stage is running (and making use of U-Boot's EFI boot services)
> U-Boot does not handle copying from priv->fb to the hardware framebuffer,
> so we must allow EFI to write directly to the hardware framebuffer.
>
> We could provide a function to read this, but it seems better to just
> document how it works. The original change ignored an explicit comment
> in the video.h file ("Things that are private to the uclass: don't use
> these in the driver") which is why this was missed when the VIDEO_COPY
> feature was added.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 8f661a5b662 ("efi_loader: gop: Expose fb when 32bpp")
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Rebase to -next
> - Add some more comments to the header file
> - Add fixes tag
>
>  include/video.h          |  9 ++++++---
>  lib/efi_loader/efi_gop.c | 12 +++++++-----
>  2 files changed, 13 insertions(+), 8 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Applied to u-boot-dm, thanks!
