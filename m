Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E07ACF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FB99890E5;
	Wed,  9 Oct 2024 03:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SwMmNqPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7282890A9; Wed,  9 Oct 2024 03:53:17 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE31890AE
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7e9ad969a4fso3942806a12.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438794; x=1729043594; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I7jzDMfhoV2K32xFMvyyAR9HAWLNJiP5tTL4LXcOYSI=;
 b=SwMmNqPC1bJQsNvXqXWR8ahZNevhVJu1xAM3ucT31gYxOTEOsoKkAjOZRTbU7gSTe1
 LFnxR08pfCi6okHqkxTfNCt09dxklqs3yAoplk0M87xLL8MXAUrWQGpzZC9xVfjhbhx0
 y2M6uXwIzGZUxo4au36Z06fcjIpErg0tun17Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438794; x=1729043594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I7jzDMfhoV2K32xFMvyyAR9HAWLNJiP5tTL4LXcOYSI=;
 b=c9vwh2yhWrmIDOF8F8HX299GTjkZXMdmwFzR6CT0lOSMEW9AQxx/7esQGoJk32zoDh
 xBAhVxkTtThtldLc+8EoPAaeVZnZzJoRQXHTC9Zr+OKQbzL5aaAUhvlFJ+ZeBJ75b7C3
 9izZmatBn0KiA14OUH/VkUWaChd/11287gQrtNHyeGrTh3Pj9yBoeYCEcUEWceb5ozVm
 qNK/DYy2iJOqSsIFMWLnwkAfQg3Qe8SSArTEr+ho0DDVutc6f3Rh6gCuIc5Y3gaT/mXq
 e3Nsy1aKWL3Ql+99QSv4YaBPQnEbiXwOhSGDWgnK0df89BFVJz8LImhE+n+QjQ7ZenJU
 DTrw==
X-Gm-Message-State: AOJu0YxHRtvdbuDGdwzM8Ouh3duiXcfSoS9Ssj202bieogBv3jCrGsIY
 jbUoLOmaoa1g3SpLeFMqzQAkYzITdDEeIporn0MI0F3jDwGMqAFs2QH75rsn/eG4GRlDEBVtQnl
 l1xeLpNoWDh7MIezlvEbaGUZtl3a8PMqVBkoW
X-Google-Smtp-Source: AGHT+IE5vFsr0SBj8Vcxnb4Bs1HD0OVNU0yKAubqO3T0DySg2qxQXVyuww0m+XaVb3Umw9KqNBpBO7si/gHHahHy33E=
X-Received: by 2002:a05:6a21:2d89:b0:1d6:e673:9bf6 with SMTP id
 adf61e73a8af0-1d8a3be3701mr1843146637.10.1728438793909; Tue, 08 Oct 2024
 18:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-9-ravi@prevas.dk>
In-Reply-To: <20241003212802.3810-9-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:52:44 -0600
Message-ID: <CAFLszTjQYTXMU1yYuiqpzB7upiHuNba+BKppBm1nSuXHb-D+OQ@mail.gmail.com>
Subject: Re: [PATCH 08/13] watchdog.h: change include of cyclic.h to
 u-boot/schedule.h
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 3 Oct 2024 at 15:29, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> Nobody relies on getting the cyclic API declared by including the
> watchdog.h header, but for historical reasons, many TUs include
> watchdog.h to get a declaration of schedule(). Now that we have a
> dedicated header for just that, include that header instead of
> cyclic.h.
>
> Eventually, all TUs that call schedule() should themselves include
> u-boot/schedule.h, but this is a step towards getting rid of
> unnecessary include statements in cyclic.h and global_data.h.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  include/watchdog.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
