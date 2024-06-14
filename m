Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D643C27C79
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3C60889E4;
	Fri, 14 Jun 2024 16:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C2ej14Bp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3A9F88A26; Fri, 14 Jun 2024 16:54:32 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B43188A15
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2508320e62dso1058683fac.3
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718376869; x=1718981669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BcNyvZHXI9tCKAb/fXojV1lZInd27rshCTXh0DMEDMw=;
 b=C2ej14Bpvry1MgzaSHxMqZV0ygjhjLMqJGWRMu+3cMD94h6re/vkeLqxJ9WCaKcLjI
 h64Dkinv4Ub/OdXtezEwXE8dfJQGYRp5JJFyvvbTK8/3RgV1beB27lThHyyu+KLLReQe
 dyTJp19KUsAXHm3puHjKosv+xMSaNNw8Jpl80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718376869; x=1718981669;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BcNyvZHXI9tCKAb/fXojV1lZInd27rshCTXh0DMEDMw=;
 b=AR/pFTxgMtwpbnITZPmlwwifKSezHp+CFnnKLUB6z7BNG1PMf4/AkTuR9RB2QO/L1Y
 UjxavT7ju25uRNVl1fPWVMTwygyP9CPw/PQ8aKzJCUkfs/8j4VgqUHRBZ5rToGGZ0PRv
 BueEH/LIvrLVLZM+DvpZz02MUbALZTdtQiFXcXcHot602VrKc9plTYV7JZE0yKKLcGmj
 +Y7ju4dbXcqCL+H4ZcpbqXJ/B7BTQ0MZuP1f6WRTMWcHnaF0WZNeBCTTjGfYfxSyxs5Z
 nvW9pZDZV1Jl1yjzpy/X1ZaWuc/Gjw9JPER4+FAll6Uen4BcozlwGidRQROjLTnoMF0b
 pPOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX22jVWGfwT6vYaSc8AetHNoKhScuqb8itE/9PRY9D9OyAZkdstHw3Cr5dn9XrsrhaZBZ8QixEkUO+RyURf8o7M5/BCyQ==
X-Gm-Message-State: AOJu0YwBhBZ4Rf68BvBhUYtieh1t88AmL1FHC+WANSXFRZ9XWhzT7JJG
 2DE8TaeUCo71cfPBgk5CK/DDEgDsJajP47V9TcFm2ltZj/2oQu23BVlX/mfqHRg=
X-Google-Smtp-Source: AGHT+IHVccqZPfbaMJ5dD/vhCLoAXYd8P0ipxg7JNscOkjHJoXf65DcsNexLOsmpFhvKA7fFSaPpyQ==
X-Received: by 2002:a05:6870:a18a:b0:24c:ae57:b4ab with SMTP id
 586e51a60fabf-25842893a0fmr3067986fac.11.1718376869035; 
 Fri, 14 Jun 2024 07:54:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567aa2fbe8sm986898fac.28.2024.06.14.07.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 07:54:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Dmitrii Merkurev <dimorinny@google.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Cody Schuffelen <schuffelen@google.com>, u-boot@lists.denx.de
In-Reply-To: <20240603-bcb-compil-v1-1-4edc2c77eed3@baylibre.com>
References: <20240603-bcb-compil-v1-1-4edc2c77eed3@baylibre.com>
Subject: Re: [PATCH] cmd: bcb: Fix bcb compilation when CONFIG_CMD_BCB=n
Message-Id: <171837686846.2655592.10430407875355941164.b4-ty@konsulko.com>
Date: Fri, 14 Jun 2024 08:54:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Mon, 03 Jun 2024 11:04:58 +0200, Mattijs Korpershoek wrote:

> commit dfeb4f0d7935 ("cmd: bcb: extend BCB C API to allow read/write the fields")
> introduced the bcb_get() function.
> 
> When CONFIG_CMD_BCB=n, that function is stubbed.
> The stubbed function has a wrong prototype: value_size arg is missing.
> 
> Add the missing argument to fix build when CONFIG_CMD_BCB=n.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


