Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530C3C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 21:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73F6D87469;
	Tue, 26 Dec 2023 22:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tzRM0zCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74DF08781A; Tue, 26 Dec 2023 22:48:57 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 703F786F87
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 22:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dbdd013c68bso2707818276.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 13:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703627334; x=1704232134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fqOZm91zwovsE3l9TafplmP3ru88cYUF09wnB31WGqE=;
 b=tzRM0zCypWMnfS4f69MruFN55ZGVOjDIZHEIpJGTGhRX4NctND5CXrFenO69Cr3mhG
 F8xs7d8x5O4VYJ41eGE82iocUD85NxGCTvI+bB31CiFOBetjuw0Kgfl9rGy+jrFCzVCM
 kU3h4BM3giGQfo+mT1kk7rrtSrwrJ4Za1I1VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703627334; x=1704232134;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fqOZm91zwovsE3l9TafplmP3ru88cYUF09wnB31WGqE=;
 b=USrPvwMfFneVv8/R3QPPdNVGBe5ROlw36u+wxT/Ky9OLhd3uAzCK00aJmRjvqdprHM
 iWk43M5D8V38pBMPrKllExqgMnDIhxlyyB3xbfnsR00LvmlBoFBlUO4Vh7miKu8Zdh9M
 WHCPo8RzE+yipEQ/znN+bXypXXegh9LIk9Lb8f+rUutXMp0sQKqEc3v03ImdWxxhIqYK
 OpplvgHxe+C2aZ21GOiILdXtURb3nSghEy7EnlFpBtqTduu9Q9ZTSKyAVtfL57MvprvO
 T/dxAOwMEP2b2WXnvsolBTx3TiTMcEZrg0ghwzFD5jb49Nj3hDWKpiC2HpbhNfCvttpe
 p4MQ==
X-Gm-Message-State: AOJu0YxPjiWgH7Cz3Re3zz1IMm+IsYX9svLAv6gDo4hSA6b80Q+3LbZi
 9Mvl9YPPyA+UphASnXKhE1U2aWtIeGsc3w==
X-Google-Smtp-Source: AGHT+IEVPdhkfhWoQm7h0uexqLMqNQYR62KnLUVhJNo5BVysA9KhAGLRv3bH9qxynh09iyUSP6RSFg==
X-Received: by 2002:a25:dbcb:0:b0:dbc:b0f2:94f8 with SMTP id
 g194-20020a25dbcb000000b00dbcb0f294f8mr3281138ybf.108.1703627334150; 
 Tue, 26 Dec 2023 13:48:54 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 p139-20020a25d891000000b00d9cbf2aabc6sm4788164ybg.14.2023.12.26.13.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 13:48:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com, 
 jagan@amarulasolutions.com, Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20231226020006.1052698-1-JJLIU0@nuvoton.com>
References: <20231226020006.1052698-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v1] spi: npcm_pspi: Fix the wrong clock divider calculation
Message-Id: <170362733307.442931.5943385108092682942.b4-ty@konsulko.com>
Date: Tue, 26 Dec 2023 16:48:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Tue, 26 Dec 2023 10:00:06 +0800, Jim Liu wrote:

> Fix the wrong clock divider calculation.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


