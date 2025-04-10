Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3D0C369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 01:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11A688395B;
	Thu, 10 Apr 2025 03:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I4H5irE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A18C083971; Thu, 10 Apr 2025 03:46:21 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CAD8838BA
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 03:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60208b7a6d6so76375eaf.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 18:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744249578; x=1744854378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVBWECDTfaSQuTfA0TST4GoFjs/2l0a52Smh1PkM980=;
 b=I4H5irE/wYhMj5433vcfA7DKi9+lgJYDhxeXavL9pzTQQEapzwRGZ8H+1uW917WG8o
 Thgdr05c0lCXJ2I5chxbC6tbeUivkISnlDCdAhfMvQ/7O54n29ewof4Oa6dyCbVRZPwi
 jAk0od5MpWtW4ZQInnEFTej0NbVzS8+ql6BdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744249578; x=1744854378;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kVBWECDTfaSQuTfA0TST4GoFjs/2l0a52Smh1PkM980=;
 b=M/poSRkkqvteLgjrjBwIsRqvBRdcwW3FsoGiLTe4QfsjNMotjjotU+H3gAF4tEafdX
 dk35OmrJxGL5pLMOO0C5Wi+BUIzhzk43SYkzZHqiKJSpzQMG69xfC0E9mxl2PYaeQZXX
 XKJxFh+pQRuJlilIVJJRxI0OIcp3FSMmQ7FJBThn6v/xegyQKMvkCgzM0k8JYkx8X/rn
 KLiPOvvC7dc1oyYNTjglBmCAqWNlmlpV/AxaUg2ffxXZB7Ifqm5v6dfI9U1MPN5et6OK
 Z16IeAJwtpEBeMHNZBdhhux4iOEyjY80EpLJUDKFyQeMRK0Ts0rkBuoGhR+jUYlpYoZx
 zGag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR+yEF9ZqEt9O5IIvbXpc33R4NDzz3LFAf+tI+CkiSn6NoqVXf+qHFCREEjyXHhSkW6FYlfPY=@lists.denx.de
X-Gm-Message-State: AOJu0YxV3lAP7ZwMpCoRi4EQzU0kaDY2leL/+xqPM2ECllvmCpd1nrsu
 z8WZgpFT2mvhzU6WK0RDgGr5mFDfhUugypIE4D25xwzloktO9Hz0euKS6+PkM64=
X-Gm-Gg: ASbGncscAr17bY6FXIr8qryeQKH3X0EOZx3wgB+yVrBk8kDupWtCYRbc98pNvLtTKSj
 t7BtjXEPTam5wrX2sQIeibp6NzhKzlBLWwBZ7nm2LR1rNf3EZSyb6ki+6V0sQhEFUaZQi4Bv5OA
 IbKbzmkWHAq026yaYqOG4qviV+Xp7WhqYi3N95+KtoZY5ieCxdt7AsmU+IiDB8y47tAZlTzwByQ
 yh8hIREwDbXq/Dh58XPs5n+qrJRhhPaoSSjsF+JPxIQyWO0hv3HsVANk2aHmtvZ9eJR7lGeBCp9
 VfR316hhMBH3oJ8jG3m3FZ+czvhgOgxwPUQKEIcq32tGQv7ybrNjN+rys2M2IYtZAAi+qxsiLdf
 Dimrdzz4YcYE=
X-Google-Smtp-Source: AGHT+IENezPMul6b9stGN4hcQtvbRd2F9s8IUF3KidnfpMRhHrT6RqVOSqZ7bPIEWSwk9LwCazPT+w==
X-Received: by 2002:a05:6870:1655:b0:2b8:3a2a:af31 with SMTP id
 586e51a60fabf-2d0b30d99f6mr630808fac.0.1744249577803; 
 Wed, 09 Apr 2025 18:46:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096cd3764sm474569fac.31.2025.04.09.18.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 18:46:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, Neha Malcom Francis <n-francis@ti.com>
Cc: u-kumar1@ti.com, afd@ti.com, vigneshr@ti.com, devarsht@ti.com, 
 quentin.schulz@cherry.de, j-choudhary@ti.com, jonas@kwiboo.se, 
 richard@nod.at, raymond.mao@linaro.org, m-chawdhry@ti.com, 
 u-boot@lists.denx.de
In-Reply-To: <20250319140327.301266-1-n-francis@ti.com>
References: <20250319140327.301266-1-n-francis@ti.com>
Subject: Re: [PATCH v2 0/2] Change DRAM message and add RAM doc
Message-Id: <174424957616.1824423.4212381391788741775.b4-ty@konsulko.com>
Date: Wed, 09 Apr 2025 19:46:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 19 Mar 2025 19:33:25 +0530, Neha Malcom Francis wrote:

> This short series is an ongoing effort to make RAM utilization clearer for
> easier debugging and understanding of code. Intention is for users to quickly
> be able to identify the CONFIGs needed to modify for their RAM usecase.
> 
> Neha Malcom Francis (2):
>   board_f: Modify DRAM message
>   doc: memory: Add documentation for system RAM
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] board_f: Modify DRAM message
      commit: 7dfe3cdc6c58f428803b0f1698bbd4b283103adf
[2/2] doc: memory: Add documentation for system RAM
      commit: 284ef1bbcefcf3180592ed48f522c79618099bd6
-- 
Tom


