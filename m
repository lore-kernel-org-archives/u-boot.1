Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4CCC3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 23:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF92D820F6;
	Tue,  6 May 2025 01:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="erlHg5RV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3E9882102; Tue,  6 May 2025 01:35:28 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C164380079
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 01:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2db2f23f174so376862fac.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746488125; x=1747092925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06+snIcCCOa8caU6T+OY597oFgRxFzUJyu6dOHa1nxE=;
 b=erlHg5RVuIT0xAgy2m/pD9HL4iRYpSzf5MdHlC29NLNJ78wLMPTrtZ2J/qMTmtmd+l
 tYs3DXf7mZinTQfnJ0w4Xp0bloMSt8LcNPhwMUnP70aahGE3WtR8+mUmPe9bLqWCxYvU
 kfwtzcBDkktbEklV2eyvrl+OThrOPj6WIear4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746488125; x=1747092925;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06+snIcCCOa8caU6T+OY597oFgRxFzUJyu6dOHa1nxE=;
 b=dRK8WPS6P4ggO45ZMZCQl2bm6t875IM99AGA3qjLR1xLcrbTir+hUun74hAqm7huAz
 kFpPFYhvCy6dGBEYBZ/dOgMTOLBpvunCM/2r5eRvQYub1QqqlW+VIVWzY5ZfoPIMogz8
 HHk44yld+gNb/3W9y0N+eay0R7n96MqewH4t6rFh/gRQoOCnmDrzeeTnjpbxzCTaVQRR
 5LhvbMfPGZzOtrBM6sADYBc04kyiE+yi00GczVqyDz0/r+qH7GnrqrUjG7SecCDXXqFl
 pFAJBeL+NqWJj//KXvDn331+Gzbph6ohmeg7oLL/ZhFKfZbz8c5yHHGvehqpSFflxDO5
 YEpQ==
X-Gm-Message-State: AOJu0YxqF4up3DcmCMytO0TAcIUyrtV8L5VcG+co51e2kFBbmT4JrgbW
 aENyoUe4A+DvCwXEEeiZSHYnEJ1m3cBgii5seIeksWSzVc9NV1Pp3R+PSHT6N57aETHiUnu7X+K
 O
X-Gm-Gg: ASbGncseysOl0NjvyTX0pn/9m/PNuZVyMeECtKu3GfH4dAmtl5qU3lQUMShDxb2/ROY
 MY02DjakNuCGAy3ZxJ/z6BIFTAPtIsX9ZfZSpJgYRAmtyrZn3qzumwAipe+25cPcOEQ1vCNMTXC
 W2+24MGSkSg5cu8/YPBfQL45w0qzVcYl0h/RCYZESJWkD1CjCCdK3Miw/8o0cer/5UT9xj2fnMq
 UmERhVzxgSgdZ2GTn7lL6Uca06m6LwW3YiLr4URIEW7Yp8DcF3s7c5fvySpmzYk6F5hNN65UG8X
 c3D62vlHC3RqoseTtqFVo88ZQ+IcdM6J2TwOwdL4fLEK4ovn63rwJjKVlv6+OatYamd5SeApX7P
 SKjj0HtdCkj4=
X-Google-Smtp-Source: AGHT+IGdwN3uGo9TgJW40DCQEdhX9pHZyZO0GZhEwKvTJsZ4sV+bMP5RVtfTIeD7+RDL+gYG7K5Pvw==
X-Received: by 2002:a05:6871:7401:b0:2bc:9197:3508 with SMTP id
 586e51a60fabf-2db3d16269fmr558808fac.34.1746488125332; 
 Mon, 05 May 2025 16:35:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fe85a4sm1913408eaf.39.2025.05.05.16.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:35:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: joe.hershberger@ni.com, zhangzhijie <zhangzhijie@bosc.ac.cn>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250421090826.3126977-1-zhangzhijie@bosc.ac.cn>
References: <20250421090826.3126977-1-zhangzhijie@bosc.ac.cn>
Subject: Re: [PATCH] eth: Support E1000E I225-V
Message-Id: <174648812394.69658.10814516421158485365.b4-ty@konsulko.com>
Date: Mon, 05 May 2025 17:35:23 -0600
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

On Mon, 21 Apr 2025 17:08:26 +0800, zhangzhijie wrote:

> 1. Add pcie device id 0x15f3
> 2. Add IIC phy id 0x67C9DC00
> 
> 

Applied to u-boot/master, thanks!

[1/1] eth: Support E1000E I225-V
      commit: 81191427a4e667e083dc4fbcbda6a1250fca54ac
-- 
Tom


