Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0ADC2BB3F
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 00:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CA0986EB8;
	Sun, 19 Nov 2023 01:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lfbkchfO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AE5C874B1; Sun, 19 Nov 2023 01:43:58 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC9C886E95
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 01:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5c9ea2ec8deso744847b3.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 16:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700354622; x=1700959422; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WvI6EuPMdQ1ud+zD8KW+pkwcmjNg5XDVZn+Fq1nKCBI=;
 b=lfbkchfOOBn3tx9XQtjff3x2mWdt6ASYHuqVAaCbHMNJsdNBecnyJqWQhnX1S/UDN1
 R7P9cM1FyJua1YKUlGM//uumbe5zLaM2Gh/0T7sIbn6kP6I5KNZ2O+rJJ4fmhja8Vo/r
 cKdvFyH4Mci8gIkmbh9SJTI6ZWKY5Eor1Km68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700354622; x=1700959422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WvI6EuPMdQ1ud+zD8KW+pkwcmjNg5XDVZn+Fq1nKCBI=;
 b=tw07HvYl+Xv5PTfpDyER9X1VVHOSTUj2c0vhmXxQ7ikgo0bMr7tBEcLzWa/zomlGoY
 7JxNOg1sCZJEWral/MPVBRVC3tlGWbMrKFhCpwaIXRv0RQmhQnKJTJbSh/BqALa2B5s3
 k8vHJfG1W01mLY91+shiue7hmkaZ1vrjIyOh+tMDtWM3BcKWd6/ZwrFf+BKeQLv+ll0Q
 89TbBvI2aOVYRHx+SxUNj5ZWboHH9os0NgxaWALAq6Jm8s8tOrCMHkMzYN1TiNQMevU8
 A/16disfzBddBdv0t9DbrKsGcgkDpZZlBJivoySf9Ino+1GUFjjUSVu1Ws+bvciRcAD5
 wq2w==
X-Gm-Message-State: AOJu0YynFWIfgAslwz64igoS8OeiWmISnGbPXocUf8rH9lheie6od1k0
 aMuD7R97/7/GMfTJFqPw3imxVm+Mh+LDXgUlDLuA7gfmm8b5Epo+9fQ=
X-Google-Smtp-Source: AGHT+IHNl/R7xyTY6ZLq2T3GTiRna7MCTV4T0HAU93zzgAG0J1L2ivrnT6xBXb0iWGdmHtUNGw88u02xZlCgdzDcZD8=
X-Received: by 2002:a0d:dc43:0:b0:59b:ec85:54ee with SMTP id
 f64-20020a0ddc43000000b0059bec8554eemr4227007ywe.39.1700354622208; Sat, 18
 Nov 2023 16:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20231118215727.95086-1-heinrich.schuchardt@canonical.com>
 <20231118215727.95086-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231118215727.95086-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 17:43:12 -0700
Message-ID: <CAPnjgZ3f+emLPjdhSSLBnGrGbqnHe1a5cajyL0csdVz1KTDfqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] acpi: consider XSDT in acpi_find_table()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Sat, 18 Nov 2023 at 14:57, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The RSDT table is deprecated and does not exist on all systems.
>
> By preference scan XSDT for the table to find. If no XSDT table exists, try
> to use the RSDT table.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         consider that map_sysmem(0, 0) != NULL
> ---
>  lib/acpi/acpi.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
