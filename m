Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEBAC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 04:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F26805D7;
	Tue, 18 Mar 2025 05:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hPbJhCRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39B02805D7; Tue, 18 Mar 2025 05:56:19 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AD1980107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 05:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6fed0620395so46435557b3.3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 21:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742273776; x=1742878576; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KG3BIfnQA7DISNL9qvQw12vdo74o+KaWlfd4/mU+fyU=;
 b=hPbJhCRRDhQseCGTra2nGCclbKudXoyFcghQEuMkfWfVYZlBLauSR0yROtX4uHsj7B
 lOkbT8vItOewnqyr3x9bCY+VsR0hKdn5Viw9sto4mAzweeC1tqoKgxZaMa+7je3BnIYg
 y5FWD8CAseWwUrxPzcXu1N2jGQOHZhxekrwxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742273776; x=1742878576;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KG3BIfnQA7DISNL9qvQw12vdo74o+KaWlfd4/mU+fyU=;
 b=L0G6mBDuOJmGwAboIBGyNP303+X3L/m7hfhBC98yxy78k4jaUY5jTbgp7yOjoSR/d/
 Z4AaGZKpqhrONezs8LD+wiIoORMK3T6rKsBgu8RqHZLCLQUoLTtDa3WVHMNEFXklzXgH
 M6kwNnO0dBSFCdYBueYDXbx9mWKOSMjZdulD0kHoYYBlWjzm1KEiZO8UlJg/BLXzmXs5
 FmYknorf9sCv7auLrcWFH9hFRLOGKv8q0hH0gvgg910ubgJlJn1q9c7pFENuVk7WuCGk
 phdWM6Qo1pZBXXGzeBLpvgdZBzvs5/w/LbRNPveIEXvWHiW3zznq3X+P1Tg8IDNfGh/k
 IHVg==
X-Gm-Message-State: AOJu0YweC6D9YqPqAPrh9fFv5EVj1DgYotp8lZJyeFOkOvEG0qkLeK7R
 uLLEvWfrFcd0TToqmzMT/wCqrpJd4h0A2HXpuN+5Xtk5+0m5vaIohDtN6aQKBw4=
X-Gm-Gg: ASbGncsy4jXjZOjsySTnyvOSz+Cqwpg1d3CEQ9csnLB2ATnZYQTMrMbV3OyxkIQJ7VT
 ncd2e9hW1HqjyuBe77B6HhY+vyuJm+Xi+AdAj+weVIGv9Uk3ReDEh7qWHr7MHOkXp0APDU3alHn
 dMNE5c+Vm0ZoEAXt3AD0mot5uVxEPE6fg2Sha5yVwD2REBq2zzUeMLh08BD61pBbE6fvBx/firP
 4p5UJrkrcuuy4Knn410eui5OlWosuhOYdnizpL6gizdVrMC1X8p20kZLwfdvn52sw255rY9waYS
 4jYoC+DxcJZY0IuMblzc0ez/em3KmsMrUYgNH2YjqRrm
X-Google-Smtp-Source: AGHT+IHCGZRn4w15Ajt/NFv8SZ9Bv2S2euPnmqjxdBNkHUI5uKW+tlaaZVbxi0H2Bus2TOBPvfm0LQ==
X-Received: by 2002:a05:690c:a98:b0:6fd:3d37:99ce with SMTP id
 00721157ae682-6ff45ef5047mr181522797b3.17.1742273775907; 
 Mon, 17 Mar 2025 21:56:15 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ff3283f82bsm24865867b3.23.2025.03.17.21.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 21:56:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Udit Kumar <u-kumar1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250303133231.405279-1-sughosh.ganu@linaro.org>
References: <20250303133231.405279-1-sughosh.ganu@linaro.org>
Subject: Re: [PATCH v3 0/6] lmb: miscellaneous fixes and improvements
Message-Id: <174227377421.1705416.2950364099998830494.b4-ty@konsulko.com>
Date: Mon, 17 Mar 2025 22:56:14 -0600
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

On Mon, 03 Mar 2025 19:02:25 +0530, Sughosh Ganu wrote:

> The patch series contains some fixes and improvements in the lmb
> code, along with addition of corresponding test cases for the changes
> made.
> 
> The lmb_reserve() function currently does not check if the requested
> reservation would overlap with existing reserved regions. While some
> scenarios are being handled, some corner cases still exist. These are
> being handled by patch 1, along with adding test cases for these
> scenarios.
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] lmb: check if a region can be reserved by lmb_reserve()
      commit: 56f186a68b35e8b45136fd44b69c554a0bb0ce35
[2/6] lmb: handle scenario of encompassing overlap
      commit: e0a7ea3725d8931a2c31f29ed665ec1f22e37172
[3/6] lmb: check for a region's coalescing with all existing regions
      commit: 6e4df5886d27cff043561c8087f373e26cfe9f34
[4/6] lmb: remove superfluous address overlap check from lmb_add_region_flags()
      commit: f5f0a0287134223c16ce64303df60c3708684e6a
[5/6] lmb: use a common function to check if regions overlap or are adjacent
      commit: fa5b4f5a5f99d1f4ab995d07845d2bff50aaabb7
[6/6] lmb: optimise the lmb allocation functions
      commit: 2bf5811e22efffe37bf5dccb8d13529c51fc65dd
-- 
Tom


