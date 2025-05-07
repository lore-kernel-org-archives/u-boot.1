Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7F2C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 15:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22098820EB;
	Wed,  7 May 2025 17:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K9MR9rK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B364A8211F; Wed,  7 May 2025 17:24:49 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBADE8059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 17:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-400fa6b3012so693835b6e.1
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746631485; x=1747236285; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ooymJopPBzCkcxdA7czfVEA4JGNGPf5290R4WL4XgPQ=;
 b=K9MR9rK019Rd0MRHZlXdEkUdyre3RUUTgG9N6i/LTDDtB6EIT6fhivIyh3nvgEPKUg
 1/GKeu4sTctgfOYe1Ekl1tyTptS8nq9JDLtbcuOMVTpiA2NHSmB6Q1a3awzFj73GNRPP
 nG66lt8WSiuDu0iB7jUUdsJUsDlPOUvc7FTTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746631485; x=1747236285;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ooymJopPBzCkcxdA7czfVEA4JGNGPf5290R4WL4XgPQ=;
 b=aYBIXha4ul+HCISMEkU3hKMxF0Z+lgPCYu9gQxzGvoX5WXACjjbRuCOBdud9j1+5Xz
 ZFH4DXJ8aAlWh9nASIywf3dK8LYLDKP96lZofG/X4lN8FOJIcYfNbOxhjbJ4zunsWzFA
 ydZoVVPOeYyLFlLdrTS+PnxLxq6EXX2FyKHZc/Pc8GcDkQvPnpWuio53HDYDYLMPcaRx
 UbXifRx/eIFbuPpZcIEcRRBQCb7W7APrV6MxCCenbd1pHFprxlZo1wFv9EcVKu0wGQPG
 TAVMe5K+Toa7RyCJ5xJs8HH3EFuU2Tvy3RGatwbrwN5PmE7bkrtnqL6+mjmKWK2t8ZdY
 Fu6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2UUiWsS1yG2NTF5ftWzOXPWkoj0LH5N600AIdHycGvaCpgy0zHYltlD2mRNMeByTS9x9ilyU=@lists.denx.de
X-Gm-Message-State: AOJu0YzTipqK6EovcPcEYBDlhiZQ/QXZRZKLHyp/jwX2uVQKxhwn9nbJ
 6IsCCpX/bNjMlEQOWI7eDsQdPcBlcUzdocxE+ysRe9pQftVgNSwSnEPyAQMcM8Y=
X-Gm-Gg: ASbGnctSEriJtdOF7lU5YqJPWvbvKvdASEwl6nMYh7RwZLq+kNPbA2doO8GEUntHxNB
 VlY2yDVU/nmEYNIKSfyNiUpUbusm7Wdh4cfChXrrgZmNB4Vs9WfVI7hYI9fQWq9fjUnth8Bznf6
 xkGqYJs9hdDlj7f0Yd1zZXBdfuK0U4VAA6i6Bfg+jm9IKzK1/YbbzQvvYbnxryQHMoYGrBUlf3a
 tkk7bgGczpvDz9CxWzfD7OSv8TrJ7Ea62JktAifDYfNfkdodQ8opmmZbUf7Zb+LqzEUWZHxrJkF
 Wj2qK7kyLxte9GhgZo8mH1l/O7rr8495q9yodcPdrd42mYezwVgvAgDmxuG53aczisrGmM26zUp
 i
X-Google-Smtp-Source: AGHT+IHOpCTYxV29gslfVh4vFA9cLYnG6N5x4euhRYAZ/sSjZR2znSRywb1kx/hc61wXJOwYQAFVIw==
X-Received: by 2002:a05:6808:3c46:b0:403:284b:2a58 with SMTP id
 5614622812f47-4036f34fde2mr1993722b6e.6.1746631485079; 
 Wed, 07 May 2025 08:24:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4036f340be5sm567442b6e.23.2025.05.07.08.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 08:24:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: ggiordano@phytec.com, w.egorov@phytec.de, u-boot@lists.denx.de, 
 joe.hershberger@ni.com, Daniel Schultz <d.schultz@phytec.de>
Cc: bb@ti.com, nmorrisson@phytec.com, upstream@lists.phytec.de
In-Reply-To: <20250428144904.1058574-1-d.schultz@phytec.de>
References: <20250428144904.1058574-1-d.schultz@phytec.de>
Subject: Re: [PATCH 1/3] include: env: phytec: k3_net: Remove
 net_apply_extensions
Message-Id: <174663148371.479629.18304486876009168786.b4-ty@konsulko.com>
Date: Wed, 07 May 2025 09:24:43 -0600
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

On Mon, 28 Apr 2025 07:49:02 -0700, Daniel Schultz wrote:

> Extensions are now handled by the board-code. Remove this non-existing
> function to proper boot from network.
> 
> 

Applied to u-boot/master, thanks!

[1/3] include: env: phytec: k3_net: Remove net_apply_extensions
      commit: e75070a8f46f9e154f1ede8132ff3b8c7cfad604
[2/3] include: env: phytec: k3_net: Use get_cmd
      commit: ad2ae4d2b250e25e305ddad9b9337abb4d796137
[3/3] board: phytec: phycore_am62ax: Update Environment
      commit: fd446b0c84478b4673b41a1440cd9116fdd41d92
-- 
Tom


