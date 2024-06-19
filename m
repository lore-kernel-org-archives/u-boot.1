Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB777C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 20:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C19884D1;
	Wed, 19 Jun 2024 22:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hg8q1rBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6932F884C9; Wed, 19 Jun 2024 22:26:57 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7E59884A9
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 22:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d24a231342so58768b6e.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718828809; x=1719433609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhcgDoI1tRciEzIixNXbs2MvdxBILy+RuhOxv3MDe+4=;
 b=hg8q1rBXiiMg7X0MqZv78GMCa+Ns7aDKCdohyg3R+BT6bCpRfxCd2pKZ5rXr3b0KCb
 4WOB9CWcRL57neUwLLN7b8N5RUUeSUZ+GCR8c5KQUK7RU5h9QSx8iH+AtXo1kDk9YQqC
 1RKrUsHxuWgLEzNvktcXZiley8eYzLHadS3mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718828809; x=1719433609;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhcgDoI1tRciEzIixNXbs2MvdxBILy+RuhOxv3MDe+4=;
 b=ogtBFol3SDw9dk8KLHO0l7aayZeOhQ5PxuK4RJPys8awfaijfo2BMkTfBg+Z6xYu2q
 5+JpGTkmdaPpKPpH/c+8iqQb5xXyOfl0u8w3ycvgn9ui2mFJqfnDv/5cNBxjAzV7j3YW
 16jgoy65Z2+NGI5CVPgJznUDIXrlsVB1LVHBIjfbOS/YNOWu8QgaCZhyO9wrwi5Xjhw7
 vo4KDEND9m61irDBTb9jtc4eCcKaZTEmi8M/WHQNZ+saKKZH0ct+WfvyRqWZqerdpErE
 WOED9GOe+l9mCCCh93X+J6TBG83nJOWEgL+gmNpUIZuxxVmZscU3O92E4g6Sgc34kWRg
 o/Wg==
X-Gm-Message-State: AOJu0YwItXfmv//wTu800r5B/GxJzhqVhUYhbUYs/wwYss37NudHuekf
 CJLXBpZ6ZtpYu/Tv90WDnpA75EbwIiB27TwlISPVf8rPUcIzN6JTyKR/h0RmgRs=
X-Google-Smtp-Source: AGHT+IHntKu05OXbpyPAt5O+PsDlp4K9A0xpUz4QF4h3dr+jCckWtLEypBwJ8IJ803OJ+QIYXPmZnQ==
X-Received: by 2002:a05:6808:1705:b0:3d2:1e2c:3a7c with SMTP id
 5614622812f47-3d51baceeaemr3655859b6e.44.1718828809501; 
 Wed, 19 Jun 2024 13:26:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2476bb36fsm2251402b6e.40.2024.06.19.13.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 13:26:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, jh80.chung@samsung.com, lukma@denx.de, 
 seanga2@gmail.com, vaishnav.a@ti.com, n-francis@ti.com, u-kumar1@ti.com, 
 sumit.garg@linaro.org, afd@ti.com, Jayesh Choudhary <j-choudhary@ti.com>
Cc: vigneshr@ti.com, nm@ti.com, bb@ti.com, rogerq@kernel.org
In-Reply-To: <20240612091123.253835-1-j-choudhary@ti.com>
References: <20240612091123.253835-1-j-choudhary@ti.com>
Subject: Re: [PATCH v2 00/14] Add basic U-Boot Support for J722S-EVM
Message-Id: <171882880769.3451762.10763255890997844792.b4-ty@konsulko.com>
Date: Wed, 19 Jun 2024 14:26:47 -0600
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

On Wed, 12 Jun 2024 14:41:09 +0530, Jayesh Choudhary wrote:

> This series add the U-Boot support for our new platform of K3-SOC
> family - J722S-EVM which is a superset of AM62P. It shares the same
> memory map and thus the nodes are being reused from AM62P includes
> instead of duplicating the definitions.
> 
> Some highlights of J722S SoC (in addition to AM62P SoC features) are:
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


