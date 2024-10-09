Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88991CED611
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 22:58:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA87B88DDD;
	Thu, 10 Oct 2024 00:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cX0KLK9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 949A488E32; Thu, 10 Oct 2024 00:58:22 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A08C88DD4
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 00:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbceb48613so2269476d6.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728514699; x=1729119499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9q4gBJmFmaGz++xd//l9czMYpBOQhYM3rMlVVyxZw0Y=;
 b=cX0KLK9GzU4IGqy5z5WLeERef0HEzy+QUc+cxBxsdhFfP9HMUZMQ2fi+TxU/MRZSla
 8/OwXgZ13COlRYfaIQmfMSMakolOZhXMv8CX+gXDJopJC9UeKshmqVi+jd1R8keuzJ87
 kdWEfZYsYq8n/IitweNsfMSIsL2H3rXBJcnr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728514699; x=1729119499;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9q4gBJmFmaGz++xd//l9czMYpBOQhYM3rMlVVyxZw0Y=;
 b=UNpbPMmA9h6DYzxsWLIn+vOC34o72EAmpDEROdvhSG/Qna2KMxuejkl5yIn+6abGvM
 g9V32/01265oWFcK8vI4HnEpgwzi6xxKVvPkz/JXxJcGbiwNFGx3RDC66GVcXaahIuJz
 KMx4Qi1yuhJWpaiTBL8QcUl4oNFIrs7fNKyVkOQmCXu1tv3sjE5MVqCMOb/64ufssIeg
 eCCGK2pAdWvEc6tWqq5l0JRVQ7OiMghf9MAXRE7AolUOgvPAlWj1SzAibw4g7d7QufQN
 rd1qaiD+CdfQFBbwQ98XXa4iGUu6mwHuyOtoWwHRtSx2TWLRankBCgQa7zPzy9pxf2Sx
 tiag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSJsKvQNE2oMERLd19BxenYRRiqioBLZpzVIXLztqplEmeUOMwiUfstgD1A3UbtFnHnh0RURc=@lists.denx.de
X-Gm-Message-State: AOJu0YxUUKvnO1sdGCl98vgu2Q+dyfVPEeewXak7ZjDNKe2yCcf4NnRe
 A/bn3KE0Mf4zlAvmwcvFQhBBqj1dV63kz83bOmghkPTgSXDGiCLPqXK8sT9NT+s=
X-Google-Smtp-Source: AGHT+IGIleGwrxAjdci+ztD0D8EfrNhkJccbvg8kgGedONJTa2E8UvpOQ1liFHvDX9biftxRZF3ZyQ==
X-Received: by 2002:a05:6214:3f82:b0:6cb:5f28:6b73 with SMTP id
 6a1803df08f44-6cbe4a2c257mr22002906d6.9.1728514699487; 
 Wed, 09 Oct 2024 15:58:19 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbc459e16fsm18035126d6.83.2024.10.09.15.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 15:58:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Michal Simek <michal.simek@amd.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
In-Reply-To: <20240604044039.27795-1-heinrich.schuchardt@canonical.com>
References: <20240604044039.27795-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] mtd: simplify CONFIG_DM_SPI_FLASH dependencies
Message-Id: <172851469748.3580955.13398098173754943323.b4-ty@konsulko.com>
Date: Wed, 09 Oct 2024 16:58:17 -0600
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

On Tue, 04 Jun 2024 06:40:39 +0200, Heinrich Schuchardt wrote:

> CONFIG_DM_SPI depends on CONFIG_DM. There is no need to list CONFIG_DM
> explicitly as dependency for CONFIG_DM_SPI_FLASH
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


