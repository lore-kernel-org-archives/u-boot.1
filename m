Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63005C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 21:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8482B881FB;
	Fri, 12 Apr 2024 23:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jNWSaPGW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1175087E01; Fri, 12 Apr 2024 23:59:33 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A6DE881D7
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 23:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e3dda73192so10736335ad.3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712959167; x=1713563967; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2eO/bnb42fVtSFD9iOrq1fb0Pzu6fRM37cjitElvTo=;
 b=jNWSaPGWFW24ROUFgnC9Kk7L54BLLgeY1oal+5gZQ10r0pGAqRl3LbF3EopEk5cGlN
 6hKHukCy9RnJttsvnFc6XX4qDsSLtgn3B1JDYGcaZP9RpKUP7Nvk2AZZt9no/mc2IT6H
 zGrxcWhBial/v/xIC1a5fgysVTHHCEKQ0qzIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712959167; x=1713563967;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P2eO/bnb42fVtSFD9iOrq1fb0Pzu6fRM37cjitElvTo=;
 b=kAeKRo537qSJWLx7jz7Awk89d4SPcyzSp2E0wuKs88ZjULDrAtKq+JABBp9sr7ZMfA
 6ClZrsrY7d+pIqZfEGu2xP6TDqkaxupsi4W98knOMGk0zXhTMnTQZLBwASdHV2b5UG15
 g898b1L/TXZwg96lzcNU9pLdpquCdjLR/nnQMhYv2XxKVxw7dMs5zgntiYZiGyhzytiQ
 804bW6TuFoW4R6h6hpiFCgnyCdDw4AgFFgt37XHQ0E9Yd8QSzVXLighp4p+kkNydHJP0
 GPJVm262meWpfzrtXowNSQq4NmWnyfCfEhLt7Jcns+fTGwbjNDjClzCCD+Kl111nhq3I
 4RTA==
X-Gm-Message-State: AOJu0Ywt/71FEewZ/ONcv70WyV2vzGtDqF7Ef2EJxFHu+u2/Ey9xTvqT
 eVet4JeWBKoravpnwQdvMk0R3xmfFKUdN/hAMApgE3R1Bq2yVUfgBHZ4fYKDCwR1Cz+lb+UlOfq
 GWYTM+g==
X-Google-Smtp-Source: AGHT+IGPCrBJFPpPrujn4vqaJvdkgpTS90IEFMpGsVT/wH6tgvD2eYJDoTc3FdIXO0IrdKImFrLkHg==
X-Received: by 2002:a17:902:ea08:b0:1e4:6938:6fbd with SMTP id
 s8-20020a170902ea0800b001e469386fbdmr4627321plg.7.1712959167681; 
 Fri, 12 Apr 2024 14:59:27 -0700 (PDT)
Received: from [127.0.1.1] ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 kw7-20020a170902f90700b001e45240eca4sm3472958plb.196.2024.04.12.14.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 14:59:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Charles Hardin <ckhardin@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com
In-Reply-To: <20240401191319.62652-1-ckhardin@gmail.com>
References: <20240401191319.62652-1-ckhardin@gmail.com>
Subject: Re: [PATCH 1/1] net: add support to parse the NIS domain for the
 dhcp options
Message-Id: <171295916665.1044279.9919195588191913553.b4-ty@konsulko.com>
Date: Fri, 12 Apr 2024 15:59:26 -0600
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

On Mon, 01 Apr 2024 12:13:19 -0700, Charles Hardin wrote:

> There is code in the bootp parsing for NIS domain and add the
> same support for the dhcp options as well. This allows the same
> usage of the data when the dhcp command is used in the boot
> command.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


