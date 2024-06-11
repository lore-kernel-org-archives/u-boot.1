Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5B7C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53BC88747;
	Tue, 11 Jun 2024 20:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D4D3sHGD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5754886DA; Tue, 11 Jun 2024 20:52:13 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AA8B8872B
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6a3652a732fso7084616d6.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131930; x=1718736730; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dU9ZvcX56kmQDNpJkB0G63NlP8G0RmKvdTdduM3iCdU=;
 b=D4D3sHGDIKU70yC5yChWPqHBF3NKzf9NggbLS52zFKxOxZ3/uyWR2gZ4MWvvd5FslU
 pIv5bzSznWSHd42x9hvo5rxWHaD/XicrOmPloCinQ1zgtLUBoxedwXw++GF9G7T4r4pj
 4Zzr2IZs+t1VWPXaNLomndSXEi5DLrQNvmxH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131930; x=1718736730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dU9ZvcX56kmQDNpJkB0G63NlP8G0RmKvdTdduM3iCdU=;
 b=xPTOMh6eDjVBEyRrQYfbPfp1GJStjH1qlnO/GkWIrzcSvTGbBJx/LNlOATpa5VP3kC
 Gy+zyG3cDsn+r6GN9QCrNYxPFl7ucpZ31bDZA2UhyDuKG09uQewAG3Zk0E+ROeXFTfJp
 h6vch+DwMC14ZRf1pgM7ICt/Occ7AucLlpH55xVdgJNq1MiTGsR8OqtqED1yVPCemUMu
 BQ9HUtuZwQXskeyI/Eqih2RfiOlIB9+i8H6RvK7xSEQtb7NqOv1SYReJTVaFb8YvpolS
 PxqjV3IdK0bIszM8eZGNPfEIYDqE8Rn9oWZmQHiOwoBQHCZcZzw0WfSiUNNKE+wbTbl0
 ehQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRIXHYhldTDbVxEValQXE9CU8rbWOw9UNZn51FIdpjx3zQi5ORmQuGdgJ2Vc6Tz7+OYsJimo59oD8+5L/xmKftpYSg9w==
X-Gm-Message-State: AOJu0Ywwixa6k5FY3GBg5eKBAKyE4BAbAV8J7d/na7LbmZzpNJc4ThTw
 qnNEWfrrjYRws6QpWCIJ2geMrHwQ4e2y9Ykf28aiW/aWWvbdOu+5Lng88XK1vK+AynQZW48DLte
 Q7ch/Tlhl13QJDzmX8ywt5ODfObzRnwXAQ5Iu
X-Google-Smtp-Source: AGHT+IGD42dXuLvDpgQqHrwl19A+HeGjOefpXzTE4AQexYiBcRPUsewYxxGb9ohFHQeED5WwtjB2yduk+SCiLc/unUY=
X-Received: by 2002:a05:6214:5d8c:b0:6b0:737f:534a with SMTP id
 6a1803df08f44-6b0737f5617mr81674526d6.27.1718131930041; Tue, 11 Jun 2024
 11:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
 <20240611-misc-20240610-v2-3-028e82b0b620@cherry.de>
In-Reply-To: <20240611-misc-20240610-v2-3-028e82b0b620@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:51:59 -0600
Message-ID: <CAFLszTh6jukdRUp-6-O_uTLtVrOjssQV5bAfJiWAi+UYeL3qYg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dm: core: migrate debug() messages to use dm_warn
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Dario Binacchi <dariobin@libero.it>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Tue, 11 Jun 2024 at 07:04, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Prior to that, seeing the debug() messages required to enable DM_DEBUG
> which defines DEBUG (and then _DEBUG) which in turn makes failing
> assert() calls reset U-Boot which isn't necessarily what is desired.
>
> Instead, let's migrate to dm_warn which is using log_debug when unset or
> log_warn when set.
>
> While at it, reword the DM_DEBUG symbol in Kconfig to explain what it
> now actually does.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  drivers/core/device.c    |  2 +-
>  drivers/core/fdtaddr.c   |  7 +++--
>  drivers/core/lists.c     |  2 +-
>  drivers/core/of_access.c | 51 +++++++++++++++---------------
>  drivers/core/of_addr.c   | 41 ++++++++++++------------
>  drivers/core/of_extra.c  | 33 ++++++++++----------
>  drivers/core/ofnode.c    | 81 ++++++++++++++++++++++++------------------------
>  drivers/core/regmap.c    | 57 +++++++++++++++++-----------------
>  drivers/core/root.c      | 14 ++++-----
>  drivers/core/uclass.c    |  4 +--
>  10 files changed, 149 insertions(+), 143 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
