Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D77CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 16:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BA1386FDF;
	Wed, 18 Oct 2023 18:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c/LUwIuH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E18D86FCB; Wed, 18 Oct 2023 18:10:24 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACA9486FCB
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 18:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53f3609550bso2499966a12.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697645417; x=1698250217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OuQS3c/aQuW/GA+btmvipLNjtFzoCtgsog/M+Aeesd4=;
 b=c/LUwIuHXV7oW3c/h7Yg06hIgU1gqbDwoPnVkE5yOF0Iq4oRiOmseqqvx4KD6PWXcJ
 9wAG28dLeJQrNCJ6eCr2iRfbS80d9n1Ym2VDHQ1Gc672muQ9jqfIC30h1O/BstEODtED
 e7FCn6LshlMgeubSBNexJ/96uTnzM3RnUI56Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697645417; x=1698250217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OuQS3c/aQuW/GA+btmvipLNjtFzoCtgsog/M+Aeesd4=;
 b=VvF0VTlequqztaOwq6ZurF/vldCOIGNsyzUFl43zyleOeWi2npJaKOPVZWk9TSsYRO
 W6a1v4HIiopWus+Oqw8Ix3w1qrLcu3rrrnPI8eeYhPIziIFb/uetm7+iwniMNXhctybA
 5/SJ6bVFBYA0QGGi4Y3WAS+A4uL1lvsZezte0hAHeK1w0ilNwdPWfFdtgxNVKBz8ovTo
 RFIo/Wy4BqqaPT4+p5goIsEKghOmZguIwyrnJZkhzK1H5ePI/+PnHdVDjoFY9L9oyhBV
 4sWKksfUrcUO/f6kYIihEUmOYaKWlSTS0lsu5LLoP7eqKhbB8subbo0IJSX1CXIAw8Nx
 nBQA==
X-Gm-Message-State: AOJu0YwBQWkWPBiHfvl/Sa1YWBbZCVda2abMY0/1LeK51jc4oj6MUAgA
 TU2XZk7s8AD58nntv7Z0ClZA22nvHhYSPxbozCOQhg==
X-Google-Smtp-Source: AGHT+IEa3y/fDNHn3OxXKBci06KI9kbHL1BPmUIZN9I2i3bExaIx9RR0Wi4eXLF30H6EO3yP1oHnHj1edk+scEpwpW0=
X-Received: by 2002:a05:6402:4306:b0:53d:a1c0:410f with SMTP id
 m6-20020a056402430600b0053da1c0410fmr4472209edc.2.1697645416795; Wed, 18 Oct
 2023 09:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
 <ee332375-8812-8e12-da1c-9973d10a41af@gmail.com>
In-Reply-To: <ee332375-8812-8e12-da1c-9973d10a41af@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 18 Oct 2023 09:10:06 -0700
Message-ID: <CAPnjgZ1yHdm7MRn1h3PWzkqM+1UwuVC+DsA8Xwy8yMD8frq9CQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] rockchip: block: blk-uclass: add bounce buffer
 flag to blk_desc
To: Johan Jonker <jbx6244@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Marek Vasut <marex@denx.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 18 Oct 2023 at 08:01, Johan Jonker <jbx6244@gmail.com> wrote:
>
> Currently bounce buffer support is enabled for all block devices
> when available. Add a flag to blk_desc to enable only on demand.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>
> Changed V5:
>   New patch
> ---
>  drivers/block/blk-uclass.c | 4 ++--
>  drivers/scsi/scsi.c        | 4 ++++
>  include/blk.h              | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
