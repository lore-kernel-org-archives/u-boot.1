Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D3FC0219D
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93DE280BA8;
	Mon, 10 Feb 2025 21:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iptTjSTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38AF280AE5; Mon, 10 Feb 2025 21:38:51 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B7580AE1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6f7031ea11cso46210357b3.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739219927; x=1739824727; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Ycu78fi72luWn/rElZVrGrPPJfJubNyW3vXvIPSQYU=;
 b=iptTjSTU3HwWXbd5fAHiGvpU/kFUb0i/UugVy2RqEcSo22ZTFPMYW/SUFxxv8SzXpM
 gX5Ieb8/Ulh100GhK4Pdtrd7jzVGPqE58CeKqs37Fz1H56Rr2mO5gdMZPSZTpl0tTByM
 hQOAiaBWlgVCwYKniC56Z55AlfQpx5l2J3A7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219927; x=1739824727;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Ycu78fi72luWn/rElZVrGrPPJfJubNyW3vXvIPSQYU=;
 b=gucCqtiizbFKNDZMWZX1XO3aVabRZ5OZpoiCJ17ft5ne4GaDgBn+hl5cbsMoqLGzUE
 sW+GEknTuxg/rZ/vt+UmMJNkec+kiaPLlWr0pbQyGlXDSVF+LqCPrQep/GbZsmUzC8om
 MgxB5na/x8Y1BNlXsBTb7qtVWHzQkoL3jHOGxQFWST+svXSjT4uxA/1WpGfKCCwHxRvZ
 +/CP3cCsaAlMlRrSuANoDvnzTRgddAI/J2OZ1cfNhEX5x3B3SlnR3TFBAk5rb1sCLHwP
 FtvEQCm3qrA//NuemxN5mc8LkkBdU0qjQngVBY/c9IujnN5cVeYRFwh7xD7Bw7JMtN6z
 3kig==
X-Gm-Message-State: AOJu0YzuTgsagcyZs7sXV+jjRApsVLCUOvQpmFCpM0GxlQki5UKebsME
 NZrVLJQNTwYTpRsmTfd4OmrqmPOPYH88oIccyxKiUxa1Lz5eEwemYU12E7S9Ye4=
X-Gm-Gg: ASbGnctxMsnTv0sWuYLju64rHkxhxpkVwb/ct7i+hZHWGNMBA1t6BIOC+9dCnfUQl2B
 RPln4OIXX96vkISWL+23rLczlwMLFt6iGVy5f+M4YwZ0HQyn41DgZ/wGH4Oj5DD9id/bn07YuO7
 VUM5NcwbjbIW1d2nqokwWxa77dF5BBpzBDaEhXnjptwbWiLaGRzJDcjWnE52WXI3m4AGHNGoMb5
 mxwQG+x1VivXjBmexNUdubY/vu7Ps/A4cnLI8yGWHn/F/qRUNvbfZb7kxs0jTkWneXgMjFZBUw2
 MSyIvvSdMLwAwQ==
X-Google-Smtp-Source: AGHT+IGBbuSM7v9+uZ4l90GjCnDTjCDlMZF1IDRsBUFoQxhBFe7NPlnMrg+N1ma2/cxZ3uf5FvrJ0A==
X-Received: by 2002:a05:690c:6f8c:b0:6ef:e390:1d4a with SMTP id
 00721157ae682-6f9b2876ac4mr150568927b3.11.1739219926934; 
 Mon, 10 Feb 2025 12:38:46 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a8d8sm18233207b3.79.2025.02.10.12.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:38:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: n-francis@ti.com, nmorrisson@phytec.com, d.schultz@phytec.de, 
 d-gole@ti.com, sjg@chromium.org
In-Reply-To: <20250205043013.1404917-1-w.egorov@phytec.de>
References: <20250205043013.1404917-1-w.egorov@phytec.de>
Subject: Re: [PATCH v2 1/3] arch: arm: dts: phyboard-electra-uboot.dtsi:
 Add bootph props to i2c
Message-Id: <173921992565.2921783.1935684972841276497.b4-ty@konsulko.com>
Date: Mon, 10 Feb 2025 14:38:45 -0600
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

On Wed, 05 Feb 2025 05:30:11 +0100, Wadim Egorov wrote:

> Add bootph-all properties to I2C0 nodes to ensure the bus and EEPROM
> are accessible across all stages. This enables reading the SoM
> configuration at any point during the boot process.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


