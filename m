Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E669CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 16:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1E15831D5;
	Mon, 20 Oct 2025 18:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZN7IYxrr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BCEF836B4; Mon, 20 Oct 2025 18:08:29 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4276E831D5
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 18:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c290b18a76so1252817a34.1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760976506; x=1761581306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nm7jOO5UXHZrqKScRYuKe5VWYazf5Z+FzzNQL4GNYbA=;
 b=ZN7IYxrrpL3AB4RE1vUfuQwryRHjYghhjsuODbXtyAM5U6j2jfMrRgWeQXue8Y6I2+
 1jCVvKRZNLFl12mmeSRRiycKMVUeaz39KC4GCMlqJ68GOoHjhln46HK4dNehU/YLXKW3
 HCFNC+BPl6PcUrq2K8Y2lrRDAX2ctMLJbB6vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760976506; x=1761581306;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nm7jOO5UXHZrqKScRYuKe5VWYazf5Z+FzzNQL4GNYbA=;
 b=dYMSXPecydlEG9wl1uB89VvZw24n6NU6jOpQn42UtQ6JtCrPtOop8gV+lPVe4r204u
 m52HqJOCOxK3TH/pWtrj2zTS0ZVvSwhzsuS3Qzok2+9f36fsdoMna7ePz63x9e5c9xFy
 /iAYZCv16aSb0PQ6V4N0ptBK35RkbotANSAdL3oY6h3M6BIYik/rHrsYM+/vUQmXqrGu
 z34IbCIewbwa5L8fQNI8Yry/hNqcBzjAlWphkt1CzkXkbPCDNb4q9XFho9/MFoXmgY0E
 HrR7dt6jck4pNUQk1HgCsy/2BVJlEI4QB8whX8oeK0O5Zxdd2DQk+5tMV0P+MtvdvPCY
 PXDw==
X-Gm-Message-State: AOJu0YyqfDj7m9ZmgRlwIXynlvIQ6cFwDvDbYIzfQDL8zlcQhpVk3YQm
 /nbPIG7ZORrVH7p8W1Z3pMSkVERpEIlowOmipDZ0fLssEHF1Dtm/IgLbC++NcoLV7O0=
X-Gm-Gg: ASbGncsH1MX5jWdrk8BitFGQD+thFGJqbUOmSyvEzZRUhFTOSRLjOdWKndwxQZhuqOM
 D8GdHWc8nqXcESljp/f5/arFfbpN4+iKuVMMRIbp+GCyZtaV/i1GOH7Ur5HkMp2KWXAnPq+NmPi
 LAJ96Zjg6oZn3fy17wH2nB7OnQ3kjLuZ9FNknDKb+hguFSo2mSFA+YYqs+BmlQ3S6t+FDqBlTfR
 UVDbQ179Qb0PWXLn1m8kLCCRFfYRPOe4ZTJjj1kR7xo67Q+udBesGj9ZPagezb1z8xg7zFer5wq
 ePuLn52/5QB7JNBt+UF0oHwLwn5Iqh6ZIWfBKET3frxA+Ilj8uLpY35W0vBN/dx5yOhDrGCYVRO
 b4ERtoylb7M+85eE16BsnWbChxTIMcJ7H5jjigcEN3YQqbkB4hIVOtAd6jNg3O3/2Nibi5qtsUz
 B/YV7ybFMnU9YcmDvo4s1Y3m0orHmEkj9iIlUYRg==
X-Google-Smtp-Source: AGHT+IHlMdq31KoBDCRRZTz3s6pr4lCT8BEVd0ahghQMRcf5xz6AqayFta6siGjYxptk1gXgqh9wOg==
X-Received: by 2002:a05:6830:264d:b0:78d:15b5:43fb with SMTP id
 46e09a7af769-7c27c61c643mr6580651a34.0.1760976505999; 
 Mon, 20 Oct 2025 09:08:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c2888ee009sm2752470a34.19.2025.10.20.09.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 09:08:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@amd.com, ronald.wahl@legrand.com, 
 e@freeshell.de, Michal Simek <michal.simek@amd.com>
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
In-Reply-To: <eed1378a51e63a58fda116f8cdf580ebd779ca7e.1760966019.git.michal.simek@amd.com>
References: <eed1378a51e63a58fda116f8cdf580ebd779ca7e.1760966019.git.michal.simek@amd.com>
Subject: Re: [PATCH] Revert "spi: cadence-qspi: Remove cdns, is-dma
 property handling"
Message-Id: <176097650455.2620434.14362144005499877980.b4-ty@konsulko.com>
Date: Mon, 20 Oct 2025 10:08:24 -0600
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

On Mon, 20 Oct 2025 15:13:42 +0200, Michal Simek wrote:

> This reverts commit a040578d8270ed8788d7663808ea63ce5ffd7840.
> 
> Based on feedback other SOCs (for example Star64) are using driver in non
> DMA mode which is causing issues that's why revert this patch.
> cdns,is-dma should be removed differently.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Revert "spi: cadence-qspi: Remove cdns, is-dma property handling"
      commit: aabda5407ff2f6d896215b2b8a31064f939fb4dc
-- 
Tom


