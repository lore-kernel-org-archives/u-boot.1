Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCAEC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 21:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21FCA60A78;
	Tue, 28 Jul 2026 21:56:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TUBngFKgv7mG; Tue, 28 Jul 2026 21:56:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C90660A8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785275816;
	bh=JlDoBwakHNKG1ZeaET193jxjxPLsTLcSoGbwAHGzmrc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZdZLYkYpSyq+tHkwFtHc9MQGo6N/goniC6FV8aail5oNzSirdRDI5gRccFW5Iw0H6
	 ybuD/Bv2oxWWiib8chSB+3dV/Sc20nTcZPM1A6CjXAqyteHcKZoYCpmr34CtID+eF/
	 s6cBwPxziCNIo0OccwWDMFolpK+Bfjnn7R9rWN/7dqP0wHN4x8Zov1oKsH9t4xRvDI
	 /ouhV+SYUn/0xtYvd98SEgAip6CbI99yJa/se5pK0+rmbMCfVQJ9i7rpGWrzfHmkqZ
	 LAazaNDXuHgztq0QW4T0CgIBkT3WPUC5ulAiHPYn82GaW0vhIgPCoHo0YOKcQsHLbs
	 u3VMZpDGiCgGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C90660A8B;
	Tue, 28 Jul 2026 21:56:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D1AA788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5198860A56
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bPYIt1O8dTc9 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 21:56:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9849460A48
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9849460A48
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9849460A48
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:48 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e9ecd7216cso181449a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785275807; x=1785880607;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JlDoBwakHNKG1ZeaET193jxjxPLsTLcSoGbwAHGzmrc=;
 b=KBDY9yM7mq8p+kubdgadv8tZaEBURT2MgNkGDeD7HYfJVX7GrblS9yw32Y0vnWGX4W
 UVaJYPcLArRWBAbzVgmVn4o7eZbLrExC2Mg2JQtwdu+bHGRSrbySXOR4/1YL7rNnu/v9
 ytssfmpCPL/P/Be9oBWBga/3q0N3OTs678vk/dazzGVr6dL3sjm2ZRq1MqjoBaN3DNri
 RNYi2gu3tayBrVknv4Uka/bcvGc6Do0KOiI3pLmIY3nQf7Oq9K6Dv/yaEqU6XZyrYxUr
 JtKC8P0tXj1hiv8FzEkMRAzLpWqe9nuQLuCOLgyOrDfKejwh/Na9nvU+M2f08Vl71jP2
 YHnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPD78OWnCqqMHj1vEc3tLoYHap5tcrZ+Spd0uREFVgqzWOdcYgxLusjtbcI0ZWbiE8/IcpEz8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzHTLMn7f7U3bIwzFRtZlsb5Ep2cWpQNe/dOpy1vCqeMqBe1YVc
 DxmiOfoGJJR/htXo481yF0gCdC8vsNJhX8zYJkJ8MY3mHiKxt8jT845Zmc9eKfYCBVEOg7xmenj
 0UH3cnc0=
X-Gm-Gg: AR+sD13d5O5QZ5FeiwUx6PxUAFUl11aqWMaN6vMC/Pt7u2EeM1j4x6O5fn3r64Xvx/h
 BUqGBropYrkiSqNHJzXnycKQOFi0EzLfvtSvtkf/TVx3lYbslSMl8k9qDoCU5Ls46Y1Xpb8Jma6
 Gi2wKYE5zFrbJomN9HwwJqUNMSDHCrjPQEMDMvuvqzPrjtmZhJs84cruN+puZx5AacOLU759WoI
 /duDdJzEKBf13BBSNH1+iFLijP1YzYJr/yEeXDrZua8qy04ZnjJmGtEmTKqaVC6QYNJp04rdASn
 Xe8Wj3T4/io4rJ3XMFbS2S8vYuQ/1QaZW6Rd98Bd3vTpI2f0sD7HWGI53uYZG4SIS9vmU7AhDTW
 3CzXbBsao+9qRxxNOAWKSrz+X/4D8F07Q9LH/r+zW2I/igYFlsI06TfQa1CVMGVSQW5aATdCIhv
 9bmGzJsuIdFKPY+Mexjff6zbRxkotM4w/EjFLFzv0d8te0K1WMXKIpL9i7tyxhzI+7NT2E6y2l3
 m6mo99tP1fGxT2R/86M3S954rK9er9rDdJzq9a4J3hXFWx6VJU2ODUTRKG1BWIUSzssWuySqCba
 lsB2KuNE
X-Received: by 2002:a05:6830:927:b0:7eb:c8ed:71d5 with SMTP id
 46e09a7af769-7efff0f7c2bmr2191893a34.14.1785275807506; 
 Tue, 28 Jul 2026 14:56:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d2d8112sm780106a34.0.2026.07.28.14.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:56:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Dominik Haller <d.haller@phytec.de>
Cc: upstream@lists.phytec.de, u-boot@lists.u-boot-project.org
In-Reply-To: <20260715231742.56105-1-d.haller@phytec.de>
References: <20260715231742.56105-1-d.haller@phytec.de>
Subject: Re: [PATCH 1/2] arm: dts: k3-am68-phyboard-izar-u-boot: Add mcu_i2c0
Message-Id: <178527580684.1742553.1897730143371027049.b4-ty@konsulko.com>
Date: Tue, 28 Jul 2026 15:56:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785275807; x=1785880607;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JlDoBwakHNKG1ZeaET193jxjxPLsTLcSoGbwAHGzmrc=;
 b=oW4mpqX/uEGv7M+0acqTEO9te/FtBqO8igpv2RPvWJ1pVqbDW13v4E4sqJ6N3O0ATL
 7IQxJQgoG8LwfLjnK+OJ/1WvujmvCjz0fULuCfHiq8ZtLmrP5qSUYkowOurXtF8r4vH5
 8ehnja4z2ToW/0afr4yGl+xvop2BaABbOsUZo=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=oW4mpqX/
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 15 Jul 2026 16:17:39 -0700, Dominik Haller wrote:

> Add mcu_i2c0 to access the pmic watchdog control registers.
> 
> 

Applied to u-boot/main, thanks!

[1/2] arm: dts: k3-am68-phyboard-izar-u-boot: Add mcu_i2c0
      commit: 1efe750e728e18fb37c1705d4ec3f6176ca3d9d5
[2/2] board: phytec: phycore_am68x: Turn off pmic watchdog
      commit: cecee552a732500cf822c94014fdc56fddd1af4e
-- 
Tom


