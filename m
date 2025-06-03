Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C27C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 23:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DFE82B37;
	Wed,  4 Jun 2025 01:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LHAIbxsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B0980F9C; Wed,  4 Jun 2025 01:19:23 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57A5882B81
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 01:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-40667dc8a62so2915357b6e.0
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 16:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748992760; x=1749597560; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48CKNYsofTusMZDmrMAPy6GJswrY8feTEx0bO5IFpCk=;
 b=LHAIbxsjlpCUdjielLczy0Z6NNs3TxnV3T8FyaMCPnlz3kjXVQBDaCyaM/2AxGppAR
 df6uO9deRSqPEBilI8tt+GnSEg3Q+1x8Iof9SLFyYcB6/Yv4AJqbQ1y+Gg10xgDAMdnR
 wJQa0R+dmKURrA/4qZ+2KGYPIoJTITqRXbB8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748992760; x=1749597560;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48CKNYsofTusMZDmrMAPy6GJswrY8feTEx0bO5IFpCk=;
 b=MjWcaee4eNwVXtSMg6cy9Fqw+lvRl7db2+1bIthqkoHnYW78FYiIjfblLtugit9wRO
 g97V4e11G9c9R353xuZ2rGwziuCYmO9b0hYnumuwdjvbGu8tz9AJrLrccB7xaAy///ln
 R1vLIsZTgH7tbbaFZuWyKeOC3DAXyjevMuODVHX4wuV76J3r5zwlkFh0Uc0J9hysxXr2
 mGPoteohe2kvBf1QqOaDQH/U+Z2JpWANDEFQrcwQ7RuXhCwQmxaOWxWH8us8dS7w1PXA
 deUOP7vADtr6fA0E40ayhAX5yBIGJzPBJuZzlpJO3dfBhoUBeqxwYn+qdfvz2eedyncP
 WUzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaNj0WnP1dRlG1SZUpxO9Rh/Kqi49pYZsGnq+5Yke8UEaFPSP56CE6TPasB+N/BzSK6XkBP4Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yyw/use9W+WvIAOG+M4cExnxs5pHCkAEeh1RrFx8xtIwiNbPQah
 ea9UT0hqrc5uOCYkuYKLjiZO7v0h4uT64BeO9I8VEhK3RqojSX8cRt2btl8Ph+KLXGQ=
X-Gm-Gg: ASbGncul+PenQRYk3IAjc94etPJ0jO2EtCbJRFVJNYv3zsYfhmz6II8f9gdPigpeWt/
 +d0OkAvjiffVdtqR0YL6xUY4ko8fcLa1D43QOUtqDK/HHhI5XKAuxkIQ90vGvt5lxVsOMr82EW/
 PJvX+aU2H0j7YDYGmA4JjV3QEds6iGisAA3dHmFpU2HsYzUQqdBsx3tVyKbsYT+9ceEx/2wzCDP
 rCZiQNhpd/82fNqhQrl9cCIJn8DnJJEuOpXp7KTt9OrPGq9kgjuD0MH+ClQ4x1O+20g9VeEiKxL
 2zQMe0mO4blcM+Ol+0k/TSBkRZJTSIamLWtDGNmURucDtKqs9uDdhP/XLnBjkdd8yDvv4C71jex
 jNpC66safcRw=
X-Google-Smtp-Source: AGHT+IE+D0RftDANGeGH9ep2/a9fCdNGhroIe/XnUgA+dIPpReeFSv3JyMEyJ6odWjWrl64DRuYPcw==
X-Received: by 2002:a05:6808:228d:b0:408:eec4:eb2 with SMTP id
 5614622812f47-408f0f1408amr767265b6e.1.1748992760061; 
 Tue, 03 Jun 2025 16:19:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678c1db4asm1990941b6e.12.2025.06.03.16.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 16:19:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>
In-Reply-To: <20250520090924.2638187-1-ghidoliemanuele@gmail.com>
References: <20250520090924.2638187-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1] linux/sizes.h: sync from kernel
Message-Id: <174899275836.1527530.11834601508574132867.b4-ty@konsulko.com>
Date: Tue, 03 Jun 2025 17:19:18 -0600
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

On Tue, 20 May 2025 11:09:17 +0200, Emanuele Ghidoli wrote:

> The kernel added new size definitions and substituted the
> boilerplate/reference to the license with a SPDX identifier.
> 
> Drop a local SZ_8G definition in MediaTek MT7988 SoC board file.
> 
> 

Applied to u-boot/next, thanks!

[1/1] linux/sizes.h: sync from kernel
      commit: 422222f5170ac399f0e5fd39290f8508ad777fcc
-- 
Tom


