Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AF0CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0100088207;
	Wed, 10 Apr 2024 19:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N8kkm1xn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C25487D8E; Wed, 10 Apr 2024 19:43:34 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39909881E5
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6ea1189de94so2616557a34.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712771011; x=1713375811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVP/XCSE+AjfD05NamZ2KsxE2kLV14VjjtoPCc4JL94=;
 b=N8kkm1xnagzSZyeEE4UT6y3QfaVuiUVmACwy/jTqXUfYueNSansoucw7QYdesLWhbO
 VCZ5XqQ0zx7TNzpItyfUCA5485c8Oz+6amQuKLZOb+v/TaZVtgzSImd7oUXg8TAfz17x
 /m+bGSOTUeNHejgkOZVScVM0W3HOQbW0EV4qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712771011; x=1713375811;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MVP/XCSE+AjfD05NamZ2KsxE2kLV14VjjtoPCc4JL94=;
 b=f/wkvUdkejr2pEXy4UlYWQzzO95xf4hP+O4Q6x0/2oFeote55FztORAv1O/8mCVqoZ
 R+71/MI32Bipz8/UrKxtJDq2H/zpurSmiDf86x11ZM27NBtGHBtP1ZqJKlHa4W160nDo
 jKeN03yUB0lNdORys1PB5hU4G93CeLyrcH02ccsRtCXkIm40BFTYqLnHchpk567BXiDc
 YmV4k0LjIi+RsZQge9HgfFE8GowTLG+oZofmDcCuswZULKf1vwpSBLkkZb1nz/9fp1Uc
 pgd2cp6EwLsiEMIU5/yWnfoXosbywFfUC5qIETJvTUdSYFHs5ndwerGeeTDcpLYkzWZf
 Wq5Q==
X-Gm-Message-State: AOJu0YztPK+brLqKwlwRCWJuHBzcwsvk/g5xdXRTDB+jiteqhnh/GcUa
 l/EwqQt+aA5GyKcTw2Z26iyoROhx40w3kLFxgvDH+XEKNQEtprEw+pKzxCe4M6rLr7ak+TFFRM4
 dLsVnug==
X-Google-Smtp-Source: AGHT+IEmmctCrFp4IEix2c5NNprc2LJ42yr9BVBchqfgqI8C7ACxmKu12wwyQh745HYaPZ5VWTmtUQ==
X-Received: by 2002:a9d:6197:0:b0:6ea:52e6:2419 with SMTP id
 g23-20020a9d6197000000b006ea52e62419mr813788otk.13.1712771010900; 
 Wed, 10 Apr 2024 10:43:30 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 vq3-20020a05620a558300b0078d6b676b9csm2308177qkn.17.2024.04.10.10.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:43:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>
In-Reply-To: <20240402112916.1613819-1-vincent.stehle@arm.com>
References: <20240402112916.1613819-1-vincent.stehle@arm.com>
Subject: Re: [PATCH] trace: use dynamic string buffer in make_flamegraph()
Message-Id: <171277100966.98421.5070237121337713263.b4-ty@konsulko.com>
Date: Wed, 10 Apr 2024 11:43:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0
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

On Tue, 02 Apr 2024 13:29:16 +0200, Vincent Stehlé wrote:

> The str[] buffer declared in make_flamegraph() is used to hold strings
> representing the full call-stacks recorded in traces. The size of this
> buffer is currently 500 characters and this works well for the documented
> examples.
> 
> However, it is possible to exhaust this buffer when processing traces
> captured when running the UEFI shell on aarch64 sandbox for example.
> Indeed, the maximum length needed for such traces can reach 780 characters.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


