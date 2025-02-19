Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CD8C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 02:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E9A680BAE;
	Wed, 19 Feb 2025 03:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="puuSwReT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B61780F67; Wed, 19 Feb 2025 03:04:53 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC2BA80646
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 03:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220e6028214so106920855ad.0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 18:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739930689; x=1740535489; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3s0j6OClnFTwCYTEpEn0Mw0EVO3luZQxGipCx7dlam8=;
 b=puuSwReTaXp79etoBxLvLaTRS+xwxiohh2Bwpumbapg+SKPMkX6c9h6qZIKIFnWm9L
 yaJRAZbEiKc+JKDe4eBAKm3O18CEr5ywDwGh7A2KFlje2RNfxePm2wSWETH1zdAHkQ9I
 P6jvbQDtNxE2LESm8nqh67VVMicG1LhF+BXCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739930689; x=1740535489;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3s0j6OClnFTwCYTEpEn0Mw0EVO3luZQxGipCx7dlam8=;
 b=IcDxg0u7uJFplDfE2+ZsovP2gTgrszD76iUKNF6qseB13vbdWWr4gMkgVRIelu3cZ4
 CvzsVdZm7udjLWNIm62K6qjrnt3OJ3br9ZiGjFK0uneCSvL1myzl7Ta4U6T2FOBB8c3m
 PRA9NDrGpX+PWo6qoWskd71CSsPgO87hoZw6UtICAb1uKk7lMyt68rvr32IZ89hBTA7G
 Xg9xLtL3fdgTdvMHNiMRbGF3KPyRPIxTWdFW5mlRJUoD+GH5yVU38dP2e4oTuh+AhbLk
 uLj19aAOQu8uRwvYQFnrunoRfHyoY/fKwEl1QVzwfPXf5C38jL/cHQugug3yruHWy9gP
 qJ3g==
X-Gm-Message-State: AOJu0Yxe7TMussdzAn3DvcdQE6xYsGVD5FABn5MNE/A1pO9wV3E3cxCx
 3Q0eyRqHbhf1w+LyybkhiilSu5CA9+z6VxLdXa8z3cMfD4T80wv2WPSkjZHvlL4=
X-Gm-Gg: ASbGncvaMGD2ye1Pft9MJOfy5uot6HP/aTWRFMiKHCqgDjKjTGMvHY4MFtLvXZ+4tBp
 vz1X1JvIT9TtfHN/agCXitdaJXLZRPP4bhzh88M5tk0oQPcLSa9SvGN5UVCXiFuNvoDKHRu5ZG4
 g2lWtT/cyGUAoomzVT39nNV7fceQDJXVbdx6P+L8SbZtJtab9S4L9gjXPZ7DPI2Tc90e0VePQyu
 gd3zEuKVqk2CahjfInEmTMCv2nRB/6zwztwf/ZeQzkcjS5eaza8NWFLj+xCfbg/07YX3Je3tYkK
 eoX+OaTOKH1p
X-Google-Smtp-Source: AGHT+IEnMgvc5FG6O/KBquGE9agP+H2/cDQKPE9KyuMqM/rOzZIUDk49uo1wGTonauxuBu/HJCbfZw==
X-Received: by 2002:a05:6a21:4592:b0:1e1:ca27:89f0 with SMTP id
 adf61e73a8af0-1ee8cc208camr29226002637.37.1739930689461; 
 Tue, 18 Feb 2025 18:04:49 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ade1c7a675asm6365064a12.48.2025.02.18.18.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 18:04:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, yschu@nuvoton.com, 
 Michael Chang <zhang971090220@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250210023710.1210956-1-zhang971090220@gmail.com>
References: <20250210023710.1210956-1-zhang971090220@gmail.com>
Subject: Re: [PATCH v3] board: nuvoton: use an event to replace
 last_stage_init()
Message-Id: <173993068816.1662848.4417546365362382074.b4-ty@konsulko.com>
Date: Tue, 18 Feb 2025 20:04:48 -0600
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

On Mon, 10 Feb 2025 10:37:10 +0800, Michael Chang wrote:

> Add a new event which handles this function refer to commit
> ("91caa3bb89b1 event: Use an event to replace last_stage_init()")
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


