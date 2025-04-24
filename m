Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220D6C369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 16:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B304A81F6B;
	Thu, 24 Apr 2025 18:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DbJ4noBK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEC10819FC; Thu, 24 Apr 2025 18:43:45 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0490680F9C
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 18:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7303d9d5edeso442849a34.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 09:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745513022; x=1746117822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jV6EedStRmmbzspS0wqbrW7v/hdwzaC0xAU4zq/P1Z4=;
 b=DbJ4noBKuLINv1Ab3Kh2O76rFZzq2bDm/e9+FhiWtYHf7MoBreumpyu+e65PgDJ5u9
 IZO4Frd4j54H3K2MT8JlZ3MThqzaTO1hCQRYoNq8mHulEUfxFYEfdGT++zqWgkKVHIgh
 +IJV8J9+NiTFOuI/vgTRmdGVgdXH4c4z0rJRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745513022; x=1746117822;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jV6EedStRmmbzspS0wqbrW7v/hdwzaC0xAU4zq/P1Z4=;
 b=bFeR0EsWke6bcmbLdn2DCIyIfD3+f9ZZUUrp7/U+xpVEvpuJTjqFRt6N80Hc4uGRVx
 1ALt74KyDvzAZhQ7lVEEO050Z3HphZu2kAedf/dVyb16sl9TsBhUupDsmFwNfYccT8sS
 p8x5MHLomF+EInuwlst3ShENCzGMnQxiAE/PjFIB7nTyWQvdk17WaI5uG8q0ZY1ea27o
 6tykrah6qikT7KmY5buMUR9dd1Bqam1bKAIGWTvS4An+Syb0+aOkUJOD6Z685p2teZ6Y
 JPEQq2DkQ0RmI4gjAmf37rk7GUudgah1L4CGjK8uFOpPc5tu60zGONafRKhjmVSFWjct
 XngA==
X-Gm-Message-State: AOJu0YyvCP3CeJPHa46CG12xjraQGv5o3cepb7/nlk6/QnsqkOsinG8l
 1zSsRYUYQ/BKpyOSiEtriubj0BNpwoAKuLUiChfjFg1wG27WGVrOnfZdo0YQYOw=
X-Gm-Gg: ASbGncuy8B7YqmRW5ukSXnFqccXfaGBiTZXY3hYR8c8XT6DbppBtt7YJHXp60pCms4S
 Pi1LuppI9HCbtYbqNN1jXQK8wIQQO+Yx6YW0BRD1iLCRh2JKzh3QVaEEZgcvSKpy/3iFQ+wJ1KW
 bCIaQS7jgWcGVSW1UXtxRzZDIrdQGSUX4Cnb4daUQn1CyYDAMNpCqOIKRtaVeXvRxzmHM4dBxjt
 RuNeklLYViEp0OJ+TOqKHf0h2C5N5ayrRV/+UuL4F5U01GMQ9qH2kE3hfQ3DZvRdNLpiaka+G+H
 xCDmUW6DJbxUBpDoxgCZy6pXBYP6/2ek571Zuqs9mDe/qk0dZ5mjCdtQSTd2HPeN2I6fty3CYgb
 P
X-Google-Smtp-Source: AGHT+IH8rl3FIdagWN3FEpWNFqioZRu6H1AYl05nNHLiIvYp+H4R7F5oRuy2Vf34GnMrUvNkfF94Yw==
X-Received: by 2002:a05:6830:6f8d:b0:72b:9b1f:2e33 with SMTP id
 46e09a7af769-7304db79e2cmr2471919a34.18.1745513021812; 
 Thu, 24 Apr 2025 09:43:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f2af97esm297869a34.41.2025.04.24.09.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 09:43:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, sjg@chromium.org, padmarao.begari@amd.com, 
 mkorpershoek@kernel.org, Love Kumar <love.kumar@amd.com>
Cc: michal.simek@amd.com, git@xilinx.com
In-Reply-To: <abb932b3b23cb3c6035bfdf1929f91fb958d74b6.1744709852.git.love.kumar@amd.com>
References: <abb932b3b23cb3c6035bfdf1929f91fb958d74b6.1744709852.git.love.kumar@amd.com>
Subject: Re: [PATCH] test/py: spi: Prevent to overwrite the reserved memory
Message-Id: <174551302090.4069373.5052733607111888828.b4-ty@konsulko.com>
Date: Thu, 24 Apr 2025 10:43:40 -0600
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

On Tue, 15 Apr 2025 15:11:09 +0530, Love Kumar wrote:

> Update SPI negative tests to prevent SF command from overwriting the
> reserved memory area.
> 
> 

Applied to u-boot/master, thanks!

[1/1] test/py: spi: Prevent to overwrite the reserved memory
      commit: 140e1d7fc3a5634e8a3971b5c6bf9b0239591eb0
-- 
Tom


