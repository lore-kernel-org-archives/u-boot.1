Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CFEC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 15:41:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4276A81276;
	Thu,  6 Mar 2025 16:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZWYmHU39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6899981249; Thu,  6 Mar 2025 16:41:18 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 364CB80FE1
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 16:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so668528276.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 07:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741275674; x=1741880474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgxSy4+Q/LSkikBrGAAncM7nCGP/uGhQVX+wqYrzSrA=;
 b=ZWYmHU39nzlAHUbaGdAjUjllkW/uUba5CUJ5e8IqOM+w5+gU8Expb98eB9B4NIvqyh
 Z2AtVE0qqxcJpzI8P7iWVGCwmb1ign9VYtmEDByMs3sxxdL+7wasUtOHBDvmM9ChxVV3
 nmSPaQJWhAYaWhk1xkRYQQDiUJiMZll64YL9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741275674; x=1741880474;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgxSy4+Q/LSkikBrGAAncM7nCGP/uGhQVX+wqYrzSrA=;
 b=HnP+YIU0Rk+1LUnBMnBzBiHuDSetAuCPCYatuhsD5HXmPku2U+1ufqYUoOps4xaPnX
 RveuYmzTIZdVB+KKMcxkgvLO719vu6r+CTL9zi+ZvdzUoV6BhSmUTNl01G00fqsTdikj
 hoP6gaoSo7QO/fS4y97V7Rd9oua/9HDmNiW57RjouYmgRgsViRvGV8AFk6ld+Qq6vKSj
 xQimOaclC3yz2Ti+RBjCdrvMQgOB07KhRgXzAIJuE6BeD8TTDPw474jl8N4tLiMO0qEc
 9Jf0WbXOt6/tU5jp5quWZPIkKBCLWHuQEcNU6bZ6mQ1yvGjJaL61w1GsARF4vBRlQcko
 LGQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Oukj9I8YohI9Y6IuC4Z3pzGqRBmn8Dk/2JZmQwlWdt4tB3AjAA60UWb7AoBpGUUOxJqvjHQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxJtBjJhm3kjz0zwSk0wTXnVPZt97BWO4nMyuzDVaj6V9i+non+
 No05a4P3Ocm2d46kLddYlHJ3acCX5rBmUyzQhiM+0gLgYYfanrkPiC1eTsUX5N4=
X-Gm-Gg: ASbGncvq8XpWY6NBCnvEssrO5cTLmMvapGHRZj2wXKx+1hW/4acTqds+3aJkdTL0ZMq
 8kgp9YTbv9fX9OCsgDQltAM2hxsEAJ0uAIndG3g4hSnMJNpc7HGSdKJps7MsGcnxW6AObQMA/nr
 8Zvd8sHNVW327DO6rHJa0WdnPMQehMs3MXXOsQEDwYGp1k0S1a5J0qxc/A1tMCK294XUHaFtqMR
 91+/Ab3Mun5/WzxsWKKlSN+jOTPqUiQ6UC0oeq9d00N3LQzEb+Oo5nUXMBpkftGCC8MsxfuaHgb
 9gi1wOkV/xaFiH2DyJefn9QUHs5N1Byyzgp+rKqLLOOt
X-Google-Smtp-Source: AGHT+IF27e0juWhC0ZzLJ0ZJ1sM3EQI8umD+hLs0AFp2TWfEN9Wd8iI0xDNj3bK3tBjnbLtegBgZoA==
X-Received: by 2002:a05:6902:cca:b0:e5d:ddd2:8acf with SMTP id
 3f1490d57ef6-e611e30699dmr10750514276.38.1741275674700; 
 Thu, 06 Mar 2025 07:41:14 -0800 (PST)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e634b842f58sm348755276.22.2025.03.06.07.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 07:41:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, sjg@chromium.org, 
 ilias.apalodimas@linaro.org, sumit.garg@kernel.org, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
In-Reply-To: <20250227120904.1811565-1-sumit.garg@linaro.org>
References: <20250227120904.1811565-1-sumit.garg@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: .mailmap: Update Sumit Garg's email address
Message-Id: <174127567368.3636414.6307507554655382981.b4-ty@konsulko.com>
Date: Thu, 06 Mar 2025 09:41:13 -0600
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

On Thu, 27 Feb 2025 17:39:04 +0530, Sumit Garg wrote:

> Update Sumit Garg's email address to @kernel.org.
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: .mailmap: Update Sumit Garg's email address
      commit: 19715a7f031a998f8641949fbbf29a2fd1a58f0f
-- 
Tom


