Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E153E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 03:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 954D180312;
	Thu, 19 Dec 2024 04:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hL+PdKGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 930E280283; Thu, 19 Dec 2024 04:11:08 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 296488021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 04:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-467a1d43821so12767701cf.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 19:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734577857; x=1735182657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IUPfLELppUjoq2syQkT8NOI4ZmYQzM+mIkAGfOo+2Eo=;
 b=hL+PdKGNmGzxGfgFNgY1t/Fo+uOxMcFIjAqn2gXWmGLEF0mdjU0D3iFYV81KWA+IXY
 jdxpegLqsMzL1PJm6Spt33GBtaPbtQEpDNaRoMmekIGNPfosH2SLbbrKYgJxXFVdEAUL
 ZjPm0bkcqeW7eRzPYFHfQ3Zxioae3xnz1KB78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734577857; x=1735182657;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IUPfLELppUjoq2syQkT8NOI4ZmYQzM+mIkAGfOo+2Eo=;
 b=TyISehOej4u64d0YBG2z1xk76s/ujEeakUSxLBft9LjBpHLyK5okQYhg94+siC9a2j
 SLYP3lPcdWthW+IUALfZe7Hk0wdESeDBVjhZiun94oaL/sQbm+xvmIGEuF/ODdTKtxD5
 99qBi+l/KA3WQR78qGjIp84HzA/GGLamxb24q0rfPpnD5cOnxC2LYwvLhHyXpQGpeSUw
 jRURsPpE95DjwA607pJn/HDuzZpKVA0mAqB36jmO15RZKSUCsY5dvjjeE+LoceYlgT+M
 9gXnAa7RT9pjFPo490EqL90itaOLK0i/L3xnACCQs3AXHWzPkKCcinN3iDTVtoJWJZMS
 fdRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0mLIyP5nv3Vt3tG8iM6glwsgHynJ7YE/XM3z/KwZBDbk/R/s+1ausZiPDfNVmCUkeEzj6PkE=@lists.denx.de
X-Gm-Message-State: AOJu0YyN54tA17ut4pwVDuZwf8nLokJ64h62inNsesEXYZpK62D4OqzH
 vxL3pCEbieRPGTQpxq6SSMflvkMBMyI9cWOdPh6etumqXEMYZsumYTFma6zjVxA=
X-Gm-Gg: ASbGncu8glt1wfKH/MhewnHUE0ss/OpnfvY/wKQ6kvQBe34AjGmO6PezROqKCkWoCAm
 KXFEC6WbvklAjdwITWpirNvYxEZYurbfSgSCsXpTTgbVwSEiCLKFj41e3qXXjHLz5uhuSFnLQDa
 oVID155JZrT+1myv176dLW+Fm1e2FceYLiBl8hToU2feP1ef70R/Sz0BxZkFDVUhlqapDsZ8ta+
 oR+KGNtD7tjQz2HjmOkJHuK57UBCMyuGYQxyz2UIW2MKba5ar2WIHk=
X-Google-Smtp-Source: AGHT+IHr2SHR6lJzC8BNny0Kzl9nzE2raxM92NV9gFGU0nJZ+qitqHvgA5E/bRI8oKPsAcvOP5NWIA==
X-Received: by 2002:a05:622a:1a82:b0:466:91f3:12ca with SMTP id
 d75a77b69052e-46a3af9ea8bmr25165791cf.8.1734577857091; 
 Wed, 18 Dec 2024 19:10:57 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e64cb04sm1751541cf.8.2024.12.18.19.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 19:10:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, nm@ti.com, Roger Quadros <rogerq@kernel.org>
Cc: j-humphreys@ti.com, srk@ti.com, s-vadapalli@ti.com, u-boot@lists.denx.de
In-Reply-To: <20241203-nophys-v1-1-a5fdbccd2af9@kernel.org>
References: <20241203-nophys-v1-1-a5fdbccd2af9@kernel.org>
Subject: Re: [PATCH] phy: don't spam console if phys property is absent in
 device node
Message-Id: <173457785481.3566318.3198007491251780305.b4-ty@konsulko.com>
Date: Wed, 18 Dec 2024 21:10:54 -0600
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

On Tue, 03 Dec 2024 22:57:36 +0200, Roger Quadros wrote:

> In generic_phy_get_bulk(), if 'phys' property is absent in
> the device node then it is not an error condition.
> 
> Change print message verbosity to debug to avoid spamming
> console in such cases.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


