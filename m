Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E67BC282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 20:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF239811B3;
	Fri, 28 Feb 2025 21:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZY8qN3FM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C454811A7; Fri, 28 Feb 2025 21:23:36 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 379EE810F5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 21:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22349dc31bcso48641915ad.3
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 12:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740774213; x=1741379013; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSmuZLWvDoaLBqgriNx5x19CHJwqldjizNPex1L/fNM=;
 b=ZY8qN3FMolqukQv40eldPhXdE1X5uSg9pi2XXS6fvHpzGFnxO3/71AvgytkslC6CgD
 SKYALr+5ekFAy0TF0YyuBHSO/rUGWl4/ftO4aTmR/fayODLAqOe72mDUacZHrTxjnDSS
 NjWhDZhly2A8r80bkcfgxWxyEYUNShd0vryLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740774213; x=1741379013;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JSmuZLWvDoaLBqgriNx5x19CHJwqldjizNPex1L/fNM=;
 b=XkOOHtQEcqUvZgJgfyKREcONzCSulNkIuj52KdAaQig6B9yoDSln5knVtjykoVgcTw
 a+fHCxKrHEdvsgprLPcJJj3lxaf6wT1fbLMH8IgUQlHMQxZZYIx58zpxNGwLGMIUus5H
 xljWfd5cZsmGOUub7oKw6xFcqO9yr7vEz4kk5u+taotIOlqj/ovyGeClIV45LNTQ75Ru
 voP5ZFDXkKhTRwk0BZoHW4heucetoXem8A+gmLJMO7T1G4PeBwzDFlZ9t4nAQ5WK6Lpz
 f/4rRngfZblIVOcokyC+4zx/a9lHhPzzGqhjzWomN8mcmWcoWXfJz8ej4p1DLuyC0F6j
 RFrg==
X-Gm-Message-State: AOJu0YyWA3MVUVr6I8VxhmVHVrR0AIBNFEgdJaOPHUCil88wJzbPIgeZ
 kd3F2pBgOHjolBKfUbZpqEuR0LS2+j3If7NWpeDGPfzLMQck4gMAEg9tdAbme64=
X-Gm-Gg: ASbGnctH1gY6x5wjBFKJT+NIuusPJn1y/01Y7kuYHAr3KExDGb7xER1rpdBFc88G/Rg
 kNgbuXfPvN6QQYZaIbngUPeJhr94Qa3xXv/pMD+/ZWxzDsfuzwv1mjST5ldG/jpfE6oPkYL9alG
 SQO0AmgQBif+df0+n0UekR84vViTrKwfp1qF/QmHqtFAR2DmsY4mIxltzo5aIkkrx486gPUlb4o
 9SnTODcpi7lRL9ooGdNY21I/ZlWXJ7dx7ExmcE1nTTXgHC/Glmz/RndzYSnCptEvJUpzRYRoTsP
 cJy3YaqagdX8uOwpbURYMzW9CQGA8SPI01kaTM6GNg==
X-Google-Smtp-Source: AGHT+IFcd34Tsx37gcFA8usbQGiLHIKdcs136QrQtZWsI/mPVMsZjRFlsxSXcUHNsnbguJZVAP5USA==
X-Received: by 2002:a05:6a00:c86:b0:725:df1a:288 with SMTP id
 d2e1a72fcca58-734ac428a45mr9312102b3a.24.1740774212795; 
 Fri, 28 Feb 2025 12:23:32 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a003dd19sm4288337b3a.131.2025.02.28.12.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 12:23:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Baocheng Su <baocheng.su@siemens.com>
Cc: Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>, 
 Li Hua Qian <huaqian.li@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20250218023614.52574-1-baocheng.su@siemens.com>
References: <20250218023614.52574-1-baocheng.su@siemens.com>
Subject: Re: [PATCH v4 0/5] boards: siemens: iot2050: SM variant, sysinfo
 support, fixes & cleanups
Message-Id: <174077421151.1188562.17311768866538343333.b4-ty@konsulko.com>
Date: Fri, 28 Feb 2025 14:23:31 -0600
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

On Tue, 18 Feb 2025 10:36:09 +0800, Baocheng Su wrote:

> This introduces a sysinfo driver which also permits SMBIOS support.
> 
> The first 10 patches of v2 have already been applied. The remaining is
> solely the sysinfo driver. To maintain consistency and ease of searching
> through the history, the series title remains unchanged.
> 
> Baocheng
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


