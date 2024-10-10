Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3BECFC5E7
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 17:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86BCF89114;
	Thu, 10 Oct 2024 19:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AJQDhDvM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DFA3891D8; Thu, 10 Oct 2024 19:10:02 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E80988FEC
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 19:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a39cabb9faso4495765ab.3
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728580199; x=1729184999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MT+6/K+3tpmASm3n3NDJsBEBK1H4vsAvvR8EZy46znM=;
 b=AJQDhDvM+fvuELWqtAhT4cLP5jN/l2aMXDGUx7ZtM42jFMoEFyNpsr2Bp4LfUizZL5
 Y4KKVr+G/rJQYN8ffHCjIWwa+kxHEmOZkpvgtzn8B1nBo74YHCowx3so0QDtHR2+RX6U
 hxUo+UYGDh5JSwdCnEE1EZ9KxMA5lxuY6+fqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728580199; x=1729184999;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MT+6/K+3tpmASm3n3NDJsBEBK1H4vsAvvR8EZy46znM=;
 b=TEshm4nxyNG6aqxD+UjVpPrctJEfcW4WqBrsqtT4R4Hg7ZJ4T8LJpiQZ+pN7VKI9OC
 RWZWXEiFVwgihQawK+0nEJLKkd93UnA2qG3x7Gzr//+7i7aqFKBrZzt/m+QZ+thu+7Oc
 Uf1fs1lKld6LwNHjKQRdirq2GTVTWbp9XXF3nsugzMEYBQC6bzR0zk+1vAJ6NOdUBn+t
 1ZhHYho/XFJL8Jv9wiPg8BWw6+DtXYWHkSHmvP8rrL/U8SuGhoPqJrdl0Lg/tc8wqaGe
 KdCCQikbMmL/Ny+YlM5A+uallh3q8aVzWzzGBUkY/0mkgsDQiGxEZvpoHHGG2rQv5WFy
 Uvew==
X-Gm-Message-State: AOJu0YwV+mFrgvo2W+qzQg8T2Jef4VjEL66rEc6J752llIqfCn3F48W7
 hCXaclbT//Qda6RN7hNqwaRln68NDTbNR66BLxhCYCab25l4ZWV9qmG5WUz+Sa8=
X-Google-Smtp-Source: AGHT+IGrCJyLX4LqjwEXUAowLIGV9YQ3qNczLqP2YSWBOjXYWO9aqzRkMIesDGjMQzF2b+5twgMFxg==
X-Received: by 2002:a05:6e02:1d83:b0:3a0:9238:d38 with SMTP id
 e9e14a558f8ab-3a3b51589bbmr2683695ab.10.1728580198743; 
 Thu, 10 Oct 2024 10:09:58 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b114956069sm60577185a.74.2024.10.10.10.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 10:09:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Dhruva Gole <d-gole@ti.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jim Liu <jim.t90615@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Michal Simek <michal.simek@amd.com>, 
 Neal Frager <neal.frager@amd.com>, Prasad Kummari <prasad.kummari@amd.com>, 
 Teik Heng Chong <teik.heng.chong@intel.com>, Vignesh R <vigneshr@ti.com>
In-Reply-To: <20240906211105.193254-1-marex@denx.de>
References: <20240906211105.193254-1-marex@denx.de>
Subject: Re: [PATCH] mtd: spi-nor-ids: Extend w25q16cl entry with locking
 support
Message-Id: <172858019696.3696879.4075776337512505642.b4-ty@konsulko.com>
Date: Thu, 10 Oct 2024 11:09:56 -0600
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

On Fri, 06 Sep 2024 23:10:42 +0200, Marek Vasut wrote:

> The w25q16cl does support locking the same way w25q16dw does,
> fill in the missing flags.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


