Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113DFCD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D107284840;
	Mon,  4 May 2026 22:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="icFzV2EG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB6D284832; Mon,  4 May 2026 22:36:19 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E09D684832
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso4689162a34.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777926975; x=1778531775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e4TmhJYsGWG4K06W2iDuzwujTtDtXx2nmjaADcS3CyM=;
 b=icFzV2EGlw3QcK1NmxfHTqKrACDJ+LbTertT4phMdXLSIkg6+gvOXbf1c6GhZhpYGs
 9WhvML8a0JPcX739JGFQpoynIhyJ4iR1uSqvolqaiMqMyK1eeNc1c06zd414rwe02lJb
 0uinuWLBDmmRspyy5PGc2fz7wxRdyMXABovgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926975; x=1778531775;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e4TmhJYsGWG4K06W2iDuzwujTtDtXx2nmjaADcS3CyM=;
 b=R3t5ZvXCVzxh4z3vuMzqdRIGG3ZW2E/2n787+zIvJ9KsqnGc6qykCNLucY4xMo/re1
 Y2b1akh1KvIdLCgOk73dfIQnydWvz/iSurZRuTV9zhQVgQ2FukcRFqHtJ4RSjDlezwRU
 1g4Tt/2lJWa5CAvcYL1yFCCcopdxSToRS9hdevC6wQ5m7gSmcvVnavA/DEMVXukcyHvd
 EYdnw85g2Ywq2AC9SiKphDbfcQMs01Tdz3OzDFMKbDGDdT5Bqv+e0hIboujuk//Pfx/m
 85iHlbPwotPcpCePObgRIrHGkW+Ze+vocGbDYMkktOR/8138iPe5QDEt+r9S8T5/S4Yt
 wPYQ==
X-Gm-Message-State: AOJu0YxkxCtiosVG6w1rYFIEGgNp42fCx7k5gV7DtWC+J10EZmaxl5B3
 tTOz2Pz6vCxZXKhgAJbg5NOzFxg0LOnoZ9V6UuG/a4e9AhYQiMVgHLQNI/3ZSiya+YrFQdQnm7p
 0MZ78mzEPiTDV
X-Gm-Gg: AeBDietDZPNrgXFy37xsGMHHlH3qt3SkEdMLwy757gs6tUbeJKnAO+TJy8rGih462ws
 ZB1Fn4HINQvg4vH58DIX6+rXBQ3r8yafxnHjgdoC716oYzG/VstmlxiSImV+/3Ro/DvDQnFvPG5
 yJ9Af844fPspXnQfgTUTiceGxfm8gl2VYFm1r1nqmN/JRMobQ/0OlE8nDorZCTKDUkkA2qPOX9z
 4bjnWPg9NYXxHzXLWUP49N5E7LYpBkEKJIXdvRXZcjfTL2g1L3oanWnbDUA1FNh6yKdckWMLJiz
 PSfEy7DBtgHAufqMRJWeHxtyqVm9mIsd6EQRd/6ZT7SSdq5lA8aKFlIXJccTRqK1G8DtDJEmilc
 h8QdS7tJNPBRo6sWG7uEPLqJAYh8/9VeMWaTwZ7xJIoS7r0EBlVgEcdfcvhrjnMIZI8l8gtI63B
 ANd8mC3x2MdF9mSAK9kX4e0EKipfJiINyWglFj0BAEQhV7I5Pw1bW7GAJig63ua9CplQpHu6r+/
 dv3e24YawULi4iPbF4/ObtUqXoBHS5gMvScRJTXhNcn781twcaKt1+v7STO
X-Received: by 2002:a05:6830:310d:b0:7dc:d7e5:8d43 with SMTP id
 46e09a7af769-7e0bfc6a41fmr646294a34.2.1777926975674; 
 Mon, 04 May 2026 13:36:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decac26330sm8464401a34.13.2026.05.04.13.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 13:36:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@amd.com, Michal Simek <michal.simek@amd.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymondmaoca@gmail.com>
In-Reply-To: <cffa552d648f84769f4d5d540f419173f10cb86e.1777444191.git.michal.simek@amd.com>
References: <cffa552d648f84769f4d5d540f419173f10cb86e.1777444191.git.michal.simek@amd.com>
Subject: Re: [PATCH] bloblist: fix pointer comparison in bloblist_apply_blobs()
Message-Id: <177792697469.2985766.12964609704541194925.b4-ty@konsulko.com>
Date: Mon, 04 May 2026 14:36:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 29 Apr 2026 08:29:53 +0200, Michal Simek wrote:

> The rec_from_blob() function returns a pointer, but the code was
> comparing it using "rec <= 0" which is incorrect for pointer types.
> Pointers should be compared using "== NULL" or "!= NULL".
> 
> 

Applied to u-boot/master, thanks!

[1/1] bloblist: fix pointer comparison in bloblist_apply_blobs()
      commit: 0fd32094c04ff736977d88dea02c299a75965c4f
-- 
Tom


