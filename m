Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F063ED111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 16:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E4A184380;
	Thu, 27 Nov 2025 17:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p76C4McK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A54468447E; Thu, 27 Nov 2025 17:55:51 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DF6483B27
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 17:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3e37ad3d95aso713124fac.3
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764262548; x=1764867348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLZEnSGvqlu8JNZ45Rw/TLKcZ5Y3K28QzLLTmuwHXFI=;
 b=p76C4McKP/O1ivX3dT89Gdewtmra97RWP1UEiNrce9j189CMugJa4fBrBe7Z8ILMav
 foFu44ewPDjZZp6yHzq6LYC0gbpDGlrrVRchNR6B90PC0YC6Alq+7EpFu6Y5N6irE2Hb
 x9d9rN9c3Tq+mt3ExGPl5gh6w1Ms654aBiS9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764262548; x=1764867348;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nLZEnSGvqlu8JNZ45Rw/TLKcZ5Y3K28QzLLTmuwHXFI=;
 b=LDR/5fp9S3JGa15QDFLAb6PIkObToIoTJ1Wt4apd8nQZ23TgMXEDq8Pp2nWFXMnU3R
 YYVyiGN+wz29JCnIw9Mh/M4vvWvD1JeLxi/LAY3e1oRL7s7OEWlYzARqohdvOgfXcODo
 hLnUngaKej6qGRDhLFCX9d9TgIQJBcGgAIGtt2tqNktjhadvD1sYqdhraIR+IH0CAc4h
 2A2VSiR67TYWfHKCQH/ZbkDfe0iAfScsnr9Dq69ohUcLwzC0oZEmGq2xrs2j370uLbEy
 lqOrbeBgIWhhGnfcco/+/oU6sSoh8PMcTP5/T+UiovPG1Q4dM6QS9MW4KLhfzPBE4KsQ
 y2Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVM94MbtpeddLHIFyAGsZD1w7J23mHWa5L07B6IQDOlmzVDVsZXyHL9yGUwrgk+rmN0af+r3g=@lists.denx.de
X-Gm-Message-State: AOJu0Yy87vbVWBOZ3Ssj7IOdJ6/ZtqhVeWP4kuzIjuYXUZsrKqk6kdOZ
 6kmARy6KmNB16tRmlxfjG8IK+FvCN1H4NvMH0Or/0NVJo9plkZyqr2JPurnnkFgQIkG3prres+n
 0hrTINVU=
X-Gm-Gg: ASbGncv3lnOcTIFoHPHnDllqlaPowusQcE2jQtF3H8raRD2Bk4F7LnXlwY0u0IL8lZT
 HeFXtSrJn+QYocahueqqTM7Rm1VUwjBPDc1M+SDqJeXToEhtdPN5E8A9iFuvPjBXfmmLta/uqSN
 z/5X4SG5KGb/PCW4uwx/uTjXm77Qg+7yK0est9NSzBuqn22+y0q9ifes0jwFDbnmqa/FqsO7/b0
 EJC2MNHsJt/8+d1B3WQzwExz263N94niocStksyXjLMzw4H1NRz0q3FXjN7Cemv4olzCeS4y2+E
 yNSbhbiLspZAFWnJab2aj9GT22cpddtwIUlm04UGaF4gA914MfDRQVGtwGLHmsaTQqQ5c3x+RK8
 yswAqFjp3E3/9j9w0i5OHpDEcviU2hO5RKiOGIMJUIB2OhvE0kAdR+Mu3q9hRptJbBBQiKeOhHV
 AzaRumKhJ2oyBvLqPHj9Gh7cqovMqUjUpxuqOuPmVrGWkHxSKg
X-Google-Smtp-Source: AGHT+IHtOwjFvRaovja5cIJxcX0x+ETf2P6tos16v5ciqd7bYtdQ37w24Zg31Rq1WwcwzEENfNwvTw==
X-Received: by 2002:a05:6870:9111:b0:3ec:3949:8a20 with SMTP id
 586e51a60fabf-3ed1ff9b7dfmr5619034fac.29.1764262548300; 
 Thu, 27 Nov 2025 08:55:48 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd05e0afsm741584fac.20.2025.11.27.08.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 08:55:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Cc: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Peng Fan <peng.fan@nxp.com>, 
 Santhosh Kumar K <s-k6@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Michal Simek <michal.simek@amd.com>, Dhruva Gole <d-gole@ti.com>, 
 Aashvij Shenai <a-shenai@ti.com>, t-pratham@ti.com
In-Reply-To: <20251124-fixti-v1-1-6b2d37536905@baylibre.com>
References: <20251124-fixti-v1-1-6b2d37536905@baylibre.com>
Subject: Re: [PATCH] board: ti: am6x: Restore do_board_detect functions
Message-Id: <176426254704.4117678.13174903904056299863.b4-ty@konsulko.com>
Date: Thu, 27 Nov 2025 10:55:47 -0600
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

On Mon, 24 Nov 2025 16:09:47 +0100, Guillaume La Roque (TI.com) wrote:

> This patch fixes a boot failure on the AM64x EVM that was introduced when the do_board_detect function was removed during a refactoring.
> 
> It restores the do_board_detect function for the AM64x, AM62x, and AM65x boards to ensure the common board detection logic is executed correctly.
> 
> 

Applied to u-boot/master, thanks!

[1/1] board: ti: am6x: Restore do_board_detect functions
      commit: 3afc99727ad0e829b0275b3ffa5b970b343bc0db
-- 
Tom


