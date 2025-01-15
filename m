Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A4BE77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E6AC8069A;
	Wed, 15 Jan 2025 02:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NM3REaux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73A8A806EB; Wed, 15 Jan 2025 02:13:15 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFFC08069A
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d8ece4937fso50541246d6.2
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736903592; x=1737508392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOTBurSWhu++6ZLyzoh75kAVfJUSE6nIiEp9MqgXiwQ=;
 b=NM3REauxFZDGdjUja6uL8sTc8sBoNxZrq5wPIj87kuNGN0r5tDijvp5aS0wkpqXQ97
 5AOSc22N509KdEjxG/+byNCmTKW5MUG1XPZDVhC/6BG9evSwTR/+cyaF9damyBttu9vw
 C1QhKZYcGXHbDGCk0Eyz+kV+g7rMWzTcQFJ+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736903592; x=1737508392;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XOTBurSWhu++6ZLyzoh75kAVfJUSE6nIiEp9MqgXiwQ=;
 b=rBeswidFqA8OuiYjmZ+J32UgkRNqFObIVzGxQvvdCG8d4Myjdwc+VVym+T/Jw2WMsd
 MC+CUViA1d06cMFPlFOnxy72GDXR/rDF7vTS+v++zabVeaNJRDtW4zbQUGlxc3JyXwnO
 zEc5gAJ+FGUvparIos5agJzFOjneD74gxOaguiBwjU5pc9F1eMXvRyLxMqSlQzNrzirp
 nA1Hw1Qx/ShysWlk/UU5uzhROJzITpylAxHlNN5GnPucOlWsxFE33lx5qavdDLvf4Zfl
 ShsxL8k1csdc/vrEZGkxTFLYVsC2/SJprNzO6S1SA8Z1FsfMrA6IoBa4v9WOHgRxxm0o
 DFUw==
X-Gm-Message-State: AOJu0Yw98RIIGSXM/2s+sVQ8hs8RvqJoGfStpKnmTpiZREdPRYIXstdh
 ZyGPuWvckta2Hpb1oXOa6luNiYrfAT85cfhlwbNWjaFj//6QcaqCFlNDwxFYupY=
X-Gm-Gg: ASbGnctDLiXpuZSAnl3FzEfUftja527CcGVSWQbMTEswGT5i6DyA/XMnW06nLciaBTh
 PVLCV1rDzc1QczP7E9cwpgFSsop0uHkSNm/PuSLFgxtlYGVL8R0LT73bZ9K61BR8hnTn2Qq4c4Q
 adtM13i0MUzOvYgm8wvXQmOLE5tE7E3z/eKv3WMfsOrnQyPlGqH7MmJRSG/afwvwynubwUdBLJz
 DBlrJlhY6vonfCSOexMgCq7lPZk7h7VpXgbZkoKhH1WbKDA1KKF
X-Google-Smtp-Source: AGHT+IH0t+mE5QbntCVsySkWnVbwLUhW8HxiiT3Z6CwVhyCkMq/GV65KnJBlbO3moLeSCGwciIQVfA==
X-Received: by 2002:a05:6214:2349:b0:6d4:1f86:b1e6 with SMTP id
 6a1803df08f44-6df9b2328b9mr339995576d6.22.1736903591858; 
 Tue, 14 Jan 2025 17:13:11 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade89283sm58989756d6.105.2025.01.14.17.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 17:13:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: nm@ti.com, vigneshr@ti.com, u-kumar1@ti.com, bb@ti.com, 
 m-chawdhry@ti.com, vaishnav.a@ti.com, j-choudhary@ti.com, 
 Santhosh Kumar K <s-k6@ti.com>
Cc: u-boot@lists.denx.de, w.egorov@phytec.de, n-francis@ti.com
In-Reply-To: <20250106090708.1541212-1-s-k6@ti.com>
References: <20250106090708.1541212-1-s-k6@ti.com>
Subject: Re: [PATCH v6 0/9] Inline ECC Series
Message-Id: <173690359009.213810.14536717429114166440.b4-ty@konsulko.com>
Date: Tue, 14 Jan 2025 19:13:10 -0600
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

On Mon, 06 Jan 2025 14:36:59 +0530, Santhosh Kumar K wrote:

> This series adds support for Inline ECC in DDR for AM64X, AM62X,
> AM62AX, AM62PX, J721E, J721S2, J722S and J784S4 devices.
> 
> (1/9) Add ss_cfg reg entry
> (2/9) Enable ECC priming with BIST engine
> (3/9) Add a function to store base address and size of RAM's banks
>       in a 64-bit device private data
> (4/9) Setup the ECC region start and range
> (5/9) Enable ECC 1-bit error, 2-bit error and multiple-bit
>       error interrupts
> (6/9) Add CONFIG_K3_INLINE_ECC
> (7/9) Remove 'ti,ecc-enable' flag
> (8/9) Set default NR_DRAM_BANKS to 2
> (9/9) Pull Redundant DDR functions to a common location and Fixup
>       DDR size when ECC is enabled
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


