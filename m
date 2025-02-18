Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B58C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 19:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97D6880EC0;
	Tue, 18 Feb 2025 20:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o+C49+3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52E0A80C98; Tue, 18 Feb 2025 20:35:12 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1602E80ADF
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 20:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-221050f3f00so66748945ad.2
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 11:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739907308; x=1740512108; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmIVm3yG3QfnKMUPVgdiAOrZdq8vlEEr4GVOiRfbKJU=;
 b=o+C49+3fcAoYvGWi+/IBn7BEgAFHDbz4EYyDJiyqmvwV0Ldb+/grzpn9VeQbQBhd0s
 EFJU19qdafqaCbnRKk2tyVlaXT6ghfuVP7DoTWHV1aur8TGuqPMYwo4BYUs7B0OuULw9
 g5Sux0GmrrNhehAponS4ERdAmg86a545UDVhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739907308; x=1740512108;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pmIVm3yG3QfnKMUPVgdiAOrZdq8vlEEr4GVOiRfbKJU=;
 b=Xk2ia9MYdovXenoTkhqGwsnyBsD4v24BsNbVpJe7Pa0T7MFbo9og7+B2YtzkIEUsXO
 sTYHIxvGnLXM9f7yQQgSyL1TchZYYKVYLt+cnr17DL81L/XlM44TDot23GdiHGkXP0Ep
 +misw1R9UtiO6xApe2jDl95/nRnqxwvgSCatMLFoFChQAGTs7kfpXwS9LGaXInOxuYPg
 LPVYW7dsgcKVoY3RkwS4Msk9KZuLqcS8Me81EmI3xF7ULVO54B1pEo6oBX3anbp0XOSd
 /chfd2FSJ+NYoxebHAkxEO94rkYFv+v25bdHisy6LtVIEABF9L//K9jeyW7y7bQzOO+t
 JjIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYuD9Nri/hdU4fDlzUfRZ2o3hAH8xUeBJU+XAHhB0cYBTISsus6CT+Odyt8uwPGKeW9hWewhA=@lists.denx.de
X-Gm-Message-State: AOJu0YxM27ICg+Y6unPHLsbFQmXEoRBHTrrdDwOcy5JEjQHgJzzUt5ft
 w2AP319OPKExYSsPWUWYzNMMx4OZ2msA2Mbs9WopK9qaZCrNGB0vENmq9+9aZ20=
X-Gm-Gg: ASbGncthYOmKwjWyINO3yCJs5r4QuzIeDCb2xT2+8xMlsGrZAElYuT/yx29ma0gOPhj
 fU8CqMbxNxs93EmZwKvt4qykz6z28MZHhBhqugpbeV45iNkMUMsXBfoveU1/RHDFVjqRVFIwgID
 sCZcDarmgYbWgXetGPx+1T6ctNkAp0YSKVa5FIAYAS9p8jbfeq/o2PfpMoPf67nWBVd/S02Y1MK
 hmS1nvEeOch/Ihw90c9Y9SNsn9sBLIUrbnFnQGYgrUxV2LChL01S7DOrgxvaiMQh9OinlcF7GTt
 wWFZJefHE6Ju
X-Google-Smtp-Source: AGHT+IHs2Qjo+sWXTiwrWMtoVCGGX2K27KjS5VGwbW1KZBNQMUDfAJbOKLznq6gt+eTJz7UtrqpLiQ==
X-Received: by 2002:a17:902:ce89:b0:21f:9c48:2557 with SMTP id
 d9443c01a7336-221040d74eemr252616155ad.43.1739907308558; 
 Tue, 18 Feb 2025 11:35:08 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d52esm91875995ad.121.2025.02.18.11.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 11:35:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: jh80.chung@samsung.com, u-boot@lists.denx.de, Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, d-gole@ti.com, n-francis@ti.com, vigneshr@ti.com, 
 m-chawdhry@ti.com, b-padhi@ti.com, j-keerthy@ti.com
In-Reply-To: <20250211175158.867154-1-u-kumar1@ti.com>
References: <20250211175158.867154-1-u-kumar1@ti.com>
Subject: Re: [PATCH] power: regulator: tps65941: Fix voltage calculation
 for ldo
Message-Id: <173990730685.1542939.12583337115446305575.b4-ty@konsulko.com>
Date: Tue, 18 Feb 2025 13:35:06 -0600
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

On Tue, 11 Feb 2025 23:21:58 +0530, Udit Kumar wrote:

> As per TRM[0] Section 8.7.1 "TPS6594-Q1 Registers", LDOx_Vout
> bit 6-1, define the NVM voltage settings.
> Along side table 8-4 of above TRM, shows voltage to value mapping.
> 
> Driver wrongly using bits 5-1 to calculate voltage, and to convert
> voltage to value driver was using buck's calculation.
> So fix those calculation.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


