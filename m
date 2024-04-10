Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2C5CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70FF3881D3;
	Wed, 10 Apr 2024 19:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mgMlrC3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 179C5881DD; Wed, 10 Apr 2024 19:43:26 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A956881BF
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78d5751901bso304158985a.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712771002; x=1713375802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ddB4h1sd5+jtC7JMh22wxBJ5/TfWzstcJTtUUxFL1Kg=;
 b=mgMlrC3/ycsU3aHXwEzVnynPnZxH9BXd0PvxL3QswiflIOMRGhWHkpEPcA8wP6Lig1
 CddpEI5PUktTvwPH0EVz9hsRZlyE85t9Fo7c8XxwfPWIa6xbCearNIFmp/dvOJYWGfSN
 H9qHz0038nC604kkUJJRyroZ3PrxuGTW0ApNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712771002; x=1713375802;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ddB4h1sd5+jtC7JMh22wxBJ5/TfWzstcJTtUUxFL1Kg=;
 b=mMXPSvTxrykpLVS7dUykt/afkuDMic1ifrFhPApXnf6NftFAq/Il9DI9gl0Tq6/RFt
 wathjLR2LCsKIquuE9uVl3l5Ktw3Ioqid6Chqm5MgUYzUT1qV22fQZJWKqP58a63+qxm
 ytMHWAKXuSBqi2U2vrcoB1s7trZ3vA5fRIi6bzDYRjJE9fZGo+r/Rc9zTHD+XVRau93W
 B3zS1uhsqX366BuJZxHOx+JThbTUwYNKnBY0RpLX4jInBW4PFdl4Bz8CDa29sRChHVwb
 jPGCShlxgd2DFCgi6oBzLL4VTXPFnUHKw9oyv0cYNoN7R8pTKVkIyOjh50/cHbeXj1rJ
 nOhQ==
X-Gm-Message-State: AOJu0YzVdovf/NtQhg9Rw3GZXgdOvvNEiz0JjVlOPpwo8iu7ckZ/EL1S
 TNmMMEULkjXJdEfenuo4J03EZJpp3DP+ZWZpz/hbmAYTmhVAaT8ryq8HuqQotrQb8GGKeqt6+TK
 KwIwT6g==
X-Google-Smtp-Source: AGHT+IG3mwXDcJGBD3kCKTFqCxv+PFzkbXPwhdQRndDePgvrFcjhSitRATo5fL7GJ8wyIs7B/3e2Kg==
X-Received: by 2002:a05:620a:3711:b0:78d:7760:3ffb with SMTP id
 de17-20020a05620a371100b0078d77603ffbmr4234377qkb.61.1712771002616; 
 Wed, 10 Apr 2024 10:43:22 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 vq3-20020a05620a558300b0078d6b676b9csm2308177qkn.17.2024.04.10.10.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:43:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <rt336whqarwenm6q2pbla2x2yewfxwjpxuh2x6mmo5i7ynfopl@tarta.nabijaczleweli.xyz>
References: <a5562c55fef9fd07e8a087ebcd389e60@manjaro.org>
 <rt336whqarwenm6q2pbla2x2yewfxwjpxuh2x6mmo5i7ynfopl@tarta.nabijaczleweli.xyz>
Subject: Re: [PATCH v2] tools: open FIT image read-only
Message-Id: <171277100189.98421.9993365770069790250.b4-ty@konsulko.com>
Date: Wed, 10 Apr 2024 11:43:21 -0600
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

On Thu, 21 Mar 2024 19:31:54 +0100, Ahelenia Ziemiańska wrote:

> Open for reading as O_RDONLY instead of O_RDWR:
> the only usage of the fd is for the single read() below;
> this prevented
> 	mkimage -f auto -A arm64 \
> 		-T kernel -C lz4 -d Image-6.6.15.lz4 \
> 		-b mt8173-elm-hana-6.6.15.dtb outf
> when the inputs were unwritable.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


