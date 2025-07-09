Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C1EC83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 14:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C8A583542;
	Wed,  9 Jul 2025 16:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bq1jMOR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B1F483526; Wed,  9 Jul 2025 16:22:04 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3C888331D
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 16:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-611e455116aso3652891eaf.1
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752070920; x=1752675720; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J/9Rh0xFGHTrnuas6ztLXb2h11qiGH3YsV7QCeAFNIk=;
 b=Bq1jMOR36sas4G0pW9PBiiKR5lrGt0pjpwqh5pkeyvAyDNZO1CIQ82GKsTbWLI+ze9
 BNYEpPBgJ5PGZHsZV+dJfAm7NoIlZM9c8aQIxc23ifLrtMGTimUWtDTvR5IKx87oz2i7
 eLjGNJXsnOnxfQJw1ograpxR/7+Qz5BK2Q4pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752070920; x=1752675720;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J/9Rh0xFGHTrnuas6ztLXb2h11qiGH3YsV7QCeAFNIk=;
 b=I4BLDcTccbRsA7BmMf104NVdoY+fWHyDVA2JGoWjPUv7eRpjMlEGFTQ9GU2fLMbLUg
 yQ4WzVe8zU43usgjJJpk+VVNsK4b8zXYZ8FL4yLXZm6dfE405o6IzA9MawrZ1yhvE2Qm
 AVqq/ZG6NIeSzMr5nW4HUjhjoC9FXrqJ8eaU+AkgWi1s5ph5tY+JFdnQ2mRvZQPLigqG
 EmVIr28r+QE9EVvR8vPAm1jn+LER1mNWqmRkesdnlnSCLX8MkZkxdgDG+94mYtfFOScJ
 tdaIQHgpxYjsj8ETGIoZy+ZqR+DDsW8jWUCoF7tRRnjjifw9hoE/zroAQCql5YLo2GhN
 AW/A==
X-Gm-Message-State: AOJu0Yxu2ioGWyMb8pmoILm2FBfpIxipbyxNJPCX89M8SsjrLvEWXP3v
 ZFyjIAzyj0cDpWHqB3X3O0k5jTWgD6LagLpKGi5L4FljZQCLgVZ/tt5xYt2kT34eLIo6DOyCGpP
 VYI85/4s=
X-Gm-Gg: ASbGnctd0lwfsOwPkTyoN/Lc5SEvZnOnYZyqI1r9NGAFQuBcYqrafUR46GBhLAO8mP/
 jyhClZE+oe8L+xgFI5ZazL1X2wznV4sqq8Zlrn02mtzZc+2PVjJdPavf/URVC7pmfdrI95X3YeF
 iugXJCo51x8yXuqpzaQrUTyqaFoB02yeMJsqqD5g6BNT1YxPeSPg/I4R+xAtwlFeNhFJlg2uIba
 OD3Fg0ap/octNxz68i+7gOv/r5QpRkWwfde7yhtAmpDqtGlxF1OCV+aBmCnmR52AMb3Dql1XkJO
 Bhvz9nabEFJTtIM/MVsy0RFm3nuujExVusqpVWVMmz6PislWF/95QHOgXJpvnTNZ7xPyeY7wrrr
 I/guMrchw6Bz15MGyAr0=
X-Google-Smtp-Source: AGHT+IHC4YNPJv+7xMrisuIofYXKZT1L5Hqhze/CA+QlAy1jjzR5MuSSWeqcYSgR8DAcAM0gO2tGZQ==
X-Received: by 2002:a05:6820:2d03:b0:613:cb90:21c with SMTP id
 006d021491bc7-613ccec0da9mr1685662eaf.8.1752070920300; 
 Wed, 09 Jul 2025 07:22:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac83esm1919975eaf.27.2025.07.09.07.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 07:21:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Wadim Egorov <w.egorov@phytec.de>
Cc: d.schultz@phytec.de, francesco.dolcini@toradex.com
In-Reply-To: <20250626123930.128398-1-w.egorov@phytec.de>
References: <20250626123930.128398-1-w.egorov@phytec.de>
Subject: Re: [PATCH] board: phytec: rm-cfg: Update rm-cfg to reflect new
 resource reservation
Message-Id: <175207091963.1813324.11029546074355439618.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 08:21:59 -0600
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

On Thu, 26 Jun 2025 14:39:30 +0200, Wadim Egorov wrote:

> With the latest TIFS firmware, an additional virtual interrupt and
> event is reserved for TIFS usage on am62x and am62ax devices.
> 
> Update the rm-cfg to reflect this new reservation.
> 
> Based on commit 87720385ab69 ("board: ti: rm-cfg: Update rm-cfg to
> reflect new resource reservation").
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: phytec: rm-cfg: Update rm-cfg to reflect new resource reservation
      commit: 537dc703d7dd2ac1a50e87a8b6ade04f17a9bcf6
-- 
Tom


