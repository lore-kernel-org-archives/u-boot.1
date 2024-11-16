Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1E8D68BE1
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 03:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FD0E896C3;
	Sat, 16 Nov 2024 04:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YKlyoy2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD20789667; Sat, 16 Nov 2024 04:41:16 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B0B48911B
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 04:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b152a23e9aso154127285a.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 19:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731728473; x=1732333273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ShO1K1bwzB7Jxr3zJ53wZOvsMHuwLGY4KUPRU6VaAEY=;
 b=YKlyoy2Zg18dEkQpQLcirPS7Pc3DzpW0W/zac6+sgVQJZro5QtuNAO9AEVZaK1aLMp
 s2XumLEXai0ozzXY/wo3oxhxvQvyyGQvAyawzQlATMUpY2gPr6qeNolfQJFYBu08WeZJ
 e7h3d0PDPRj4NOvArHncJoaM4DIeHz/5azU2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731728473; x=1732333273;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ShO1K1bwzB7Jxr3zJ53wZOvsMHuwLGY4KUPRU6VaAEY=;
 b=tczXgWs6ZJqYrZ+faiPApHCIZRGtO7VOO7VF9Cd8l4GIS79FknGnb4Vl4a7ZXI5o1m
 hrIFv7YqhOpYL7BmLtpK3OghLRLRix7hj5Hud6pq5OOC87LOUvHYACDJCPix9ZLz3T2Y
 edTbsa5UeSKMsLidNBUah0FuQ/1/HttiiMcoK9p+bVUsAubrf7wRLCzNL6Q2Wvbjc36s
 BvrJqDBLb09QAFe0HjST+hfb4ETqSulyKL46L6k7sTZeOcGOAiCqV2vASDSRWLx/BAY0
 I4voqx97MKVD89vmujvTU6bUwMqB4fQ6c5vuz+UEDMdoiT7/tmMeGmzpqIdjJKi08jeK
 pwHQ==
X-Gm-Message-State: AOJu0YyckEUFleVxvpvMAx7Xjcktt9mnhKq3nVmFmT7mcle347LU0FNJ
 R5zmH42xC5IK/XgWCj9RP9W17lAZitZmnbooUcpMbnQw8mSAbtFQJHIpmZPxkkc=
X-Google-Smtp-Source: AGHT+IHmojBDUiuTqCv4jVy76e66jbADzAfrnBCxHw2VIuWtVg2CknRW3UDN1nLQo7YwrPMT564LVw==
X-Received: by 2002:a05:620a:290f:b0:7b1:ae66:e8dc with SMTP id
 af79cd13be357-7b362338caemr714202085a.53.1731728473503; 
 Fri, 15 Nov 2024 19:41:13 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca4dcdcsm225181285a.102.2024.11.15.19.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 19:41:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ravi Minnikanti <rminnikanti@marvell.com>
In-Reply-To: <20241030213404.2894247-1-ravi@prevas.dk>
References: <20241030213404.2894247-1-ravi@prevas.dk>
Subject: Re: [PATCH 0/3] teach 'env default' to optionally keep runtime
 variables
Message-Id: <173172847108.2921272.14044217647965166827.b4-ty@konsulko.com>
Date: Fri, 15 Nov 2024 21:41:11 -0600
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

On Wed, 30 Oct 2024 22:34:01 +0100, Rasmus Villemoes wrote:

> Doing bringup of a board, part of my bootstrap logic is in U-Boot. So
> when tweaking that logic, I was bitten by a previous completed
> bootstrap having left a copy of the environment on the device, which
> was imported and thus overrided the new logic.
> 
> So I thought, "ok, I'll just make sure to put 'env default -a' as the
> first part of the bootstrap logic so I'm not bitten again". Alas, my
> logic also relies on certain variables that are set by C code
> (e.g. for detecting board variant), and doing 'env default -a' also
> eliminates those.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


