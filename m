Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254E2C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9625687CB9;
	Sat, 16 Dec 2023 19:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kmKq5wPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A4F187C7F; Sat, 16 Dec 2023 19:48:44 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3CE387C86
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-da819902678so1438382276.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752514; x=1703357314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gBwC6qTwzAvugbuMJpxQ9Zp65S071QCSSkF7V1LfBM8=;
 b=kmKq5wPk0PeGUXLkUWIV/T3yKVO1oj2StREsnULJZn6KcYBsYXj5SrOQEPfUHwuzbe
 +9i7zcteyQAKbe0JWSgtlYItw+f5UoEFPbgnA+M5I7GsH81UgbzvLNV3v+eoIEPWazdl
 FmMEINR/geblnHaRnU9FW40wuj7TuCdHU5eZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752514; x=1703357314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gBwC6qTwzAvugbuMJpxQ9Zp65S071QCSSkF7V1LfBM8=;
 b=gRYnkBFIz4CI3GFX6lq6CNiKHggWhw8Xj2TfWNZZ+vec7A9WPbzFRfbsmcM9mBEVPE
 P3CfqJDwBNHO2bRo/sPVLRd3167el2K9Tmz+cGCshsLqJVutFgWeoYrswlcupHeOasoc
 iZ45VLwP85N0NuQmp3tHxzo6N6lmkifaB/hGyTx/JI7oQpu6W4u7IkoDuVHCndiKkbN4
 j23h444DdDY42Y57j1OlKQc7BB/Cc7gIh++iZxZ7jLOAt6D27m85OvbONFIJI0iVbJO4
 T+CFquUC65ea4/2ZEwMPiskzv/4Il3BYMCwcjHZ0eHKvzLWSUpiFl1FcWQWjGlMI3L4D
 kbqQ==
X-Gm-Message-State: AOJu0YwGI+KcJddcv3jeNogjXD4LzAwngyOjOqwOLltSOIjrhqRSXcvZ
 FHpia3YjMwaXHttJv/rvLFVJBsQkTFP14357V7p3pP4GFKWzgigpg1g=
X-Google-Smtp-Source: AGHT+IF0PD+AKUxfRrrUWE1uejICsE86iRUM5UYLbyrUG0K8vYmQc+XETaPKYUhdIot++wyAy9eHJsFB8YYDVWGxiJU=
X-Received: by 2002:a0d:ff04:0:b0:5d7:1940:53d3 with SMTP id
 p4-20020a0dff04000000b005d7194053d3mr11435056ywf.75.1702752514129; Sat, 16
 Dec 2023 10:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20231214181658.3359902-1-trini@konsulko.com>
 <20231214181658.3359902-10-trini@konsulko.com>
In-Reply-To: <20231214181658.3359902-10-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:53 -0700
Message-ID: <CAPnjgZ0wXhbNnLmTU+DDQ4NUWYf+wgmHmALAsHUKJmBf-MLbHA@mail.gmail.com>
Subject: Re: [v2 10/16] global: Rework architecture global_data.h to include
 <linux/types.h>
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

On Thu, 14 Dec 2023 at 11:18, Tom Rini <trini@konsulko.com> wrote:
>
> In most cases, the architecture global data currently makes use of
> assorted linux types, but does not include <linux/types.h> to provide
> them. Add <linux/types.h> instead of relying on indirect inclusion.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - Update include/system-constraints.h and board/cssi/cmpc885/sdram.c
> ---
>  arch/mips/include/asm/global_data.h    | 2 +-
>  arch/nios2/include/asm/global_data.h   | 2 ++
>  arch/powerpc/include/asm/global_data.h | 1 -
>  arch/riscv/include/asm/global_data.h   | 1 +
>  arch/x86/include/asm/global_data.h     | 1 +
>  board/cssi/cmpc885/sdram.c             | 1 +
>  include/system-constants.h             | 2 ++
>  7 files changed, 8 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
