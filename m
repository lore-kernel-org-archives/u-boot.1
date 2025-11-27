Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2981FD111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 16:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 040C184476;
	Thu, 27 Nov 2025 17:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WZniIXFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3517C8438A; Thu, 27 Nov 2025 17:55:50 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B68C83B4A
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 17:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-3ec96ee3dabso771489fac.1
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764262547; x=1764867347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMcsmR3eeNoHhUm+hAAD09to1NNqgcAlk5wY26qQMOo=;
 b=WZniIXFuLViZ3z0gdTD2kmgf0PkCiUHu7Ewur2FQ/WRkIMF3K2OxqqaI9C9vCBX657
 NX2SGPMgZ3nQu1UNmNHYxH0Dp5fuoocxAsZGy3gEjqGXVJXUIiXrFXqNArA3t/qlMpET
 F64tXGP0zCOGJ7rKqY3c+XIzKbTvM/izi9YNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764262547; x=1764867347;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eMcsmR3eeNoHhUm+hAAD09to1NNqgcAlk5wY26qQMOo=;
 b=nEFKm09Tmk+w2cJNMjO4B4S0Sj43AHMWOt01/dn6SKOqFRiUPEhlHVbKbemiadLjiZ
 EdZRcyh8VP7SnpcduGOkNz9WLG1kCqR16hmwx2p3C5+LUvcX9Mmg5xpuBtGocBYr/n1s
 13Z1uMB1PrXMaueJHgf2/6jPmi8uLsPyWQxMS4lKSvLB+dF3eAFq8cbdv1JibCDMpb6F
 rfeS5urni3JNzBIw/Za7VMILLdPdINajwGZC3o3teiwi1MWT+fCigieGpVaqJ2P/up9A
 vMQPmN4Ij6OAZoBXcKRWQT2y34mdvLyGqPxh4tjyX+fG4MieyrpvnqpImfYHjCYCxt6U
 K98A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSYgjgtAhu2SUQuzG57jw9ldeFOMGM9LvqQyczqUK054bAFlauHPh4/OnJz5HJZB4teWdgdHk=@lists.denx.de
X-Gm-Message-State: AOJu0YxfJq2FQBKFvJfUtjICASOIQamQ2LSFkcqQo+S61hyvIGBQpDCN
 i4jo9ppwbNTSO6UOxsDJ191AxI7bET23mMNs2ZLTf1OaMRygFJeUN2+qqi236NM485ChdTCamsk
 tZA8PWmQ=
X-Gm-Gg: ASbGncukCYcpfF+TNuD/wnb/YFUYDEdA/MUYjmvunE/0MUmkIf/XL8mZ2MOGvvF6IHA
 4/OMwJ9wyQsTDThYGwZ9nt7eB180YNn+CJv0fDx81+7y8rEpHFFOuqhmSdFZyDjI+3cWMncR1vo
 03dFxxEMtm12CnbDTBPaQBRs65lbQxyJIPQhmdwYSKJukWZ6rRFG6a6l7p9ITuz4mZPCN8uJcbw
 IYDcyVOT0jYenDIGLliO8+nGelMsXsB3TwlpvB0m+qLL6byUi/5F1rcNvLkh/UN3HL28mZjVjPy
 ChgWj/7O54BvTU4VZaUc9dtbFbYieotck/LePJAr/gEw/cRZJdxwvUwMhgZaCgT8Y50+ka2HJQ+
 hzdCNKsRz1qRZmNDCrYoUTAj4WMZR+5fqrbLZweCmYEczmSTyIxad2Xmv/9FUaeg9ERJhGi2kQx
 lQzIZXxvsnVe9EGHpMzOn52IWTGqMMEfB+SQagLEPQvPlFvcj+
X-Google-Smtp-Source: AGHT+IGrUCR7wFZCBwFdFOeznLqGK2IhEfITKp/rB6Du+4dqbNX4KLjh4c2B+v+d3OCiZkHwAIV8bg==
X-Received: by 2002:a05:6871:60d:b0:3ec:565a:13a4 with SMTP id
 586e51a60fabf-3ecbe529e17mr10678673fac.34.1764262546894; 
 Thu, 27 Nov 2025 08:55:46 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd05e0afsm741584fac.20.2025.11.27.08.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 08:55:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, richard.genoud@bootlin.com, 
 matthias.schiffer@ew.tq-group.com, andrew.goodbody@linaro.org, 
 c-vankar@ti.com, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: w.egorov@phytec.de, u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20251121132156.3987128-1-s-vadapalli@ti.com>
References: <20251121132156.3987128-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: Ignore disabled ethernet
 ports
Message-Id: <176426254559.4117678.14584974186266351612.b4-ty@konsulko.com>
Date: Thu, 27 Nov 2025 10:55:45 -0600
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

On Fri, 21 Nov 2025 18:51:53 +0530, Siddharth Vadapalli wrote:

> Currently, the bind callback of the driver namely am65_cpsw_nuss_bind()
> registers all ethernet ports including the ones that have been disabled
> in the device-tree. Since the ports that have been disabled are ought to
> be ignored, fix the implementation to register only the enabled ports as
> indicated by their 'status' in their respective device-tree node.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] net: ti: am65-cpsw-nuss: Ignore disabled ethernet ports
      commit: cc0ce9e8c494d20e75258584807aaaac4cc514bd
-- 
Tom


