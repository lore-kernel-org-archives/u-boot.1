Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8769CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 18:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A9C836F0;
	Thu, 30 Oct 2025 19:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pn8nmKFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3354783893; Thu, 30 Oct 2025 19:05:43 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD320836D1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 19:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3d2059871d0so956527fac.3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761847539; x=1762452339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=biENHp/B2bq+OXCcnn8Qqg6Kk0tiM73x42AFQZEHwcI=;
 b=Pn8nmKFYsXOdRfkdVNfmC2Gr+Y9AWL/nt7SQTbh3SltF5w7vHnMZKG1QrYVBYmWKC9
 /p1CWvizzRX09+2li5X99oA1iDoZ+bFiV1t/hLZm54t0Su03tWNmT36AdUhhHbVYbtko
 Z5uV/k94tqxARZmMUJ630zWJblzOzQx1hlycE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761847539; x=1762452339;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=biENHp/B2bq+OXCcnn8Qqg6Kk0tiM73x42AFQZEHwcI=;
 b=gnOUdAM+7vYuL561GrJPVvZt6pVXPDXUY5oiW8wWnJXXpZJb3RRBk21GM5HwRCc832
 hcaB3F3FsClC62MAQWrq6sd3+8DBc0kATvqZ7W4jkz86utyaVU+GVTr7dh3UbKWCph24
 cyOtUCWbuoDQDobLcZyZhAUW8wuB3sbatA1qOKQV/vcZ2XzNyCDKWqsQLwLtILpyJDcU
 5nvfrKa7lsQYAkJsYGvZAxiLAHA+94ZSQ4tXMLSqMUfd1XNQapojm4szUTDJcF8L/f5j
 47ziKqzlfzvZ7IWswYOcSXguRV3GLq9dJzoJmLRstvNk7h/qIZxrgUKJT34OGHchGXZF
 kWMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+RCBZt6YHIdYiConlzJrG98D8Eh3G0XOWQA3eb+G7X/AEe3ajF5yXAMWdb7lltENyMp6R7NE=@lists.denx.de
X-Gm-Message-State: AOJu0YwaEQbwGqZ5ITiBU/K+QT9JBYtbCZpZrVvTmvqdVScENAhrOdPe
 FBJfTgzC8jLG7UnDQOVKYfmvGeiXza1DaHBT1u0el84Yjwpoj8GLY+Xua1xHq7hh2C0=
X-Gm-Gg: ASbGncv5rFz+0A1DgHr0UYx9W3BDl2N7qdr7WwUAvJHA4E126D7S1iNvqlTf5FKewoP
 Iz8wNj3sOL45Uh5iFC2uZG9DUNcNaNudx/pb91c0ZRv8kBOhg6vEb+o1lbvgo1uE5A/uPqKuMUf
 HCkn7fFdPWVH1bgCzonu7Z3RQ31RASXJPEatY3TZo6b+qpBiPBJM/123k7g7J2XpSoKwiQe9DNh
 xNbBAIQDv9EsNtOVt1s60OZEP8NLU7+6zTE7QcjGxS+GfXrOJ8M2ch3DDnssUme73eQJ3oXvdpF
 NV2lIioVkN6mSWIlT9XjWjDiAfLw8ZuW0i7Leq+hJno0jPUHutMoyPxv+j1R3bGY7MHY8A9b825
 qS7tGhX3s22KKrKiPrQOIk4KWcHO2AmQkBEUWzKedR4LJpWAk8npvoMhKpzlhYtMRdfCsHn9uXQ
 y8sGwm7WF/2OJLvCe/a7+YZRX8NyODiiwgE0np4w==
X-Google-Smtp-Source: AGHT+IHXI7L/6heDH0pWFHMVQNiuAqEf7y4IXBOtfPI19jMziy/TGcM2JPj46i5j0G9BgdaPU+cSpw==
X-Received: by 2002:a05:6870:5390:b0:332:1b00:6d5 with SMTP id
 586e51a60fabf-3dacc6d7c27mr292233fac.39.1761847539467; 
 Thu, 30 Oct 2025 11:05:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c530221d90sm5276964a34.33.2025.10.30.11.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 11:05:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
In-Reply-To: <20251030035201.GA16948@nxa18884-linux.ap.freescale.net>
References: <20251030035201.GA16948@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] please pull mmc-power-2025-10-30
Message-Id: <176184753852.2789371.15201266188369340282.b4-ty@konsulko.com>
Date: Thu, 30 Oct 2025 12:05:38 -0600
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

On Thu, 30 Oct 2025 11:52:01 +0800, Peng Fan wrote:

> Please pull mmc-power-2025-10-30 for master branch
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/28083
> 
> --------------------------------------------------------------------
> Add support for Samsung Exynos 7870 DW-MMC device
> Add support for Samsung S2MPU05 PMIC device
> Add compatible string for Exynos5250 in Exynos DW-MMC driver
> Add support for handling UHS-I voltage signaling without power-cycle
> Minor misc cleanup
> --------------------------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


