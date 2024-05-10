Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB6CC25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 19:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1518881A2;
	Fri, 10 May 2024 21:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fNunzkxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3957288005; Fri, 10 May 2024 21:32:37 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22B8888080
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 21:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-43df732cb05so6702911cf.0
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715369554; x=1715974354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KsMlzj/NpXpZlc9vAvEdKI/KcQovB59d6c0VOp5hqns=;
 b=fNunzkxHtx2wbkw6cJytkGOENIJQyq88FNZRbLGo2ES9SbLVtmqvfkohpI4l9oYcXk
 MhqtB4kZrP8M9KiF191aQhawNxuqBNKq0hn6fj0ZDa45XZoq9UDqWxdtvP5WjoPQauYa
 tAVvnmPTXXlOSxHdziGfEsh2cGQGP6P2+NpBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715369554; x=1715974354;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KsMlzj/NpXpZlc9vAvEdKI/KcQovB59d6c0VOp5hqns=;
 b=FpAfBj2PcVKwLaXhh6iNfUYn4i/YBgfdkJm0IVP8wxGDeO3/++uVsfTBd3ozm6Dpk2
 6IX2bWWzM+jCjEtI+bMWKUbZN7Xbm4O6QZAfRsDnWlqlKIXdVAhT66TqvY8TrdtBLLL3
 sckjBF2lvYR7KiDDDmMQPzN5KEcfe+dI1cGnzpVWVXEll5ZIpuh1YxvZJ3R5WMQjxqqn
 ZyQzPYqJpppR3eYL3KuCx+cerdCDekZUIikCyRASDbGJQa6S/uxvXP08vk2KVX4L+AGN
 dTv7k9pYD5Yz5c5l/evbOax44tlCzOBFgAejyciFibRSgRu0A/V88ka3PbfBAGzHxJC8
 BYkg==
X-Gm-Message-State: AOJu0Yzr4PrT6UJHDK7IxdA04dPCeITlpgPQ8JJHOjJKWvND1vgd14/q
 EWO054UWotp5dA7C8v+e0y769vJ85a9fzhtlc+y1SJKe5/PFVqhNenMF2MkiWr8=
X-Google-Smtp-Source: AGHT+IEqkAC2oOW2Goen3HHebVkpnYE17kgAkHHL/uxo5yKc3zUuaGZzkidBlQzR47fJzQON5p1TvQ==
X-Received: by 2002:a05:622a:394:b0:43a:e9a6:47e2 with SMTP id
 d75a77b69052e-43dfdb7b644mr28487231cf.36.1715369554011; 
 Fri, 10 May 2024 12:32:34 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df5521c21sm24474961cf.48.2024.05.10.12.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 12:32:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>, MD Danish Anwar <danishanwar@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>, 
 r-gunasekaran@ti.com, Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240430104633.1445311-1-danishanwar@ti.com>
References: <20240430104633.1445311-1-danishanwar@ti.com>
Subject: Re: [PATCH 0/2] Add AM64x Support to PRUSS and PRU_RPROC driver
Message-Id: <171536955294.3410219.3302090701043655645.b4-ty@konsulko.com>
Date: Fri, 10 May 2024 13:32:32 -0600
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

On Tue, 30 Apr 2024 16:16:31 +0530, MD Danish Anwar wrote:

> This series adds AM64x related compatibles to PRUSS and PRU_RPROC drivers.
> This series is a prerequisite for ICSSG Ethernet driver.
> 
> Once Support for AM64x is added to PRUSS and PRU_RPROC driver, I'll send
> another series to enable ICSSG Ethernet driver for AM64x as well.
> 
> MD Danish Anwar (2):
>   remoteproc: pru: Add support for AM64x PRU / RTU cores
>   soc: ti: pruss: Add support for AM64x
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


