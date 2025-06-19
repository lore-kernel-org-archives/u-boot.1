Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D0AC7115C
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 14:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA1782CF4;
	Thu, 19 Jun 2025 16:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yff+JwXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6CE282CEB; Thu, 19 Jun 2025 16:06:03 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C4382BA1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 16:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2db9e29d3bcso271730fac.1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750341960; x=1750946760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eixxMM00ckm366h5Z/Qoj/w1NlVGqUIFJWkE/pJTUKk=;
 b=Yff+JwXEmEOrlSJGJetDHJQPOK4FLLxNsSDnc15WoPByrsRePUzvqsAvKzIntL9TPc
 lEFUn2cevaxsb7F925fObbE7R7zIhr3e7Jh+lanEIxSEVch5KEMOmIRS+XzQm/Vl3gDf
 y0MZ5g1frL2OnT55EUwRgSOODA5VtNtQRbQ0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750341960; x=1750946760;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eixxMM00ckm366h5Z/Qoj/w1NlVGqUIFJWkE/pJTUKk=;
 b=ZHq9NGQrZNd0Lo/UnaBmZxRZPICM8R2EDhpkRUSgidRq6QQ1If5GeKjwN/kP75KqmJ
 C38C0IJQM/JKnKGizZiCn2jOGQ8kHIffEuxCyJb2OEZTInLz57xfmjCawCurDe0TieZl
 mQ+lq1oDCaAK3Z5vW0rhlmugMA0aw+NUVQQ7fYGeAseGuhkHheSFT8mD+FnEAQ+/ZT3K
 9HCV7C+xZ9XdI4C5VkPF3YCdbTHYL60Q9okwerYypZHNou9xkJq61SU1fqDLgHM7ilam
 wWApcANWGh377jBqDd9WQvV4IuAoNgIt4tRq2Q/N8CokOSvwwzywDGjo7r3HGxvIxPIe
 MLQA==
X-Gm-Message-State: AOJu0YzEnvJve6Jygmfd8KLkvUqegw2FTd70y5LvL2gJvEFR017F+uVP
 t6K8k4monPYr6bMARuirsnCEon3D7ewv1RBiqms/f1mvruyk9Rv5eV/QKgt5ennv3TM=
X-Gm-Gg: ASbGncsnkLpBHoZ/DanGiTQcoCNtnTXlitId12mdakGkuj4GHaWMxFL/szBmGOG0Y99
 IPptjQtY/0Icx2wwWuDJ3Of3QvchNI3xm7mz1xRZFRYC78cTSXkI+oRiiO7xHxebZZk+04T2IBC
 yJusbT9gDljIv/QhX1Ob9BAUvhECjuHVC+eD93AQ3vKnxynod/7rcfx5AYZFZdRRbRqiIsTY8gT
 bR3rjMDZTZE5vGF7wMhTuEud504XPyyTaeexGCflcV+QLz1pdPIr7DuGtYKKQKNNHh/vIusO2V6
 g1sb7I/Kuq3bCbWsWIyZnlOZNc1t20IUgRHPZOQcPU6qqzRyKCYY1YZScvnKMcpxrY5sCfXJfPg
 8J+1Jxi7z4fPuM0CVW2t+pg==
X-Google-Smtp-Source: AGHT+IEhGE3jHfJFHMn7MFA7rlmps/k1OYHZA9mkxBfymMHgwCKU8OVklpFsRxdjo+J7Iurzr6tPmA==
X-Received: by 2002:a05:6870:34b:b0:2d8:957a:5178 with SMTP id
 586e51a60fabf-2eaf0b0b387mr12861966fac.21.1750341960063; 
 Thu, 19 Jun 2025 07:06:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61108d73d75sm1610633eaf.5.2025.06.19.07.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 07:05:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Martin Schwan <m.schwan@phytec.de>
Cc: u-boot@lists.denx.de, Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
References: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
Subject: Re: [PATCH v3 0/2] bootstd: New bootmeth for RAUC A/B systems
Message-Id: <175034195863.205241.10407674489087579636.b4-ty@konsulko.com>
Date: Thu, 19 Jun 2025 08:05:58 -0600
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

On Wed, 04 Jun 2025 14:15:28 +0200, Martin Schwan wrote:

> This series implements a new bootmeth for RAUC A/B systems. RAUC (Robust
> Auto Update Controller) is a lightweight update client, providing "Safe
> and Secure OTA Updates for Embedded Linux". See the following links for
> more information about RAUC:
> 
>   https://rauc.io/
>   https://rauc.readthedocs.io/en/latest/
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] bootstd: Add implementation for bootmeth rauc
      commit: 7e5c2c782fb9aba2d9a2e580f51582dd394dc5a3
[2/2] doc: Add description for bootmeth rauc
      commit: 309f77c33a95ce4e23a5c63b5904a7847d1b6347
-- 
Tom


