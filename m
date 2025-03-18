Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAD3C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 19:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34A21810F4;
	Tue, 18 Mar 2025 20:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="REjtJcUY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 080CD8193A; Tue, 18 Mar 2025 20:12:01 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4EFC81026
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 20:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-226185948ffso51645355ad.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 12:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742325117; x=1742929917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9AdQ/iZQiEybKKt2D+WifV6k+bYnDJmJ8WmY5ZlY6k=;
 b=REjtJcUYHPLiWNZ0AtCKfCdUmlkO7fhssa1VAGO3xiCPeQFbGc0wqhvG3xAkBxR4UM
 hm+XNoKXyBqAqVbJtg+TeqPWAdMEbfsgJGsoI2HPN2RVex4LbS2VgxGRxaDBQsKL9dE3
 N0dDK8XpbUNKQfaJRjW6K8bG5DDMMRIdsu5ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742325117; x=1742929917;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b9AdQ/iZQiEybKKt2D+WifV6k+bYnDJmJ8WmY5ZlY6k=;
 b=NBpd+RRQhSbcr5kYPD9eKo32nh07TRgSiFL1zEZxmH1mUJ1OoCLXEX3Wb4v59wYjuA
 LfnxmhdooUp1usiXqYhqE8Y1x70N8j2O9Wvmn5B6ohFjPItbaVyNda0aNf3XhEo0c3sH
 7YyYT17QcqBZR/4qd3TqSquNLYW2et/P/GKsUKWEBNdJX1hJvgCfTQo0w2lDFLpBFi6T
 1Ej7mC8mQhKlpKIF53kh8fd68QkCbfRtYAJSmpDK1fMFSgnokg+Sfz1kdN2CTPsdZMv4
 cRRSnvtGgaRc1R8lcLsh4r80YelUuMrzD+aSKpHyA3vC4i0fymlaJwNOckb8PWC9tYt6
 pG8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3l2YIPKUKlRh3M0f3NMWymMHGdjv/lFV5l5/oedTL68myLKrALpw3mG5xEWfngYccnjmS6+o=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7AHtpZbB74+kfYHeQf7wISIDJZzQeM+xdLzdbnNmAVXgRJmyK
 NHqNR8LL6u8ki6f2fyJ9oRUV4m9e5wDUp7GSBpkXnU6DKMpvB+qGuwpBEO+0aTwdhwNvCM2fS1Q
 /
X-Gm-Gg: ASbGncuiwFluExmElFHvBuu+qIKWG6b2MMb8zSuChXJxRqOxw2dXKSJtbwTJgYU2G4B
 SnUq8KKtq9TznYzfdHS2X4H3jFcjBXIK4sdTs9GAIVYrlcdGFlmF2YgrM4Wwo48coebUfDV4Ywr
 59z0dIU+UNNVXaO1sSckUmTVHt7scvvwgBFbaiFR+QbOGDLh37y0pYi5OidYMbJqEqSTOHWo/x5
 N2JEC1OlIQDGPFjxjQFRnfBjxbe0XWPCZBJascdNjj26wEkVxUtB1HBP7HHmQHWeTu+ZEbUvhIe
 bCjqDTCX5Kki5IljGqVfv77uL4GRnBogigCXaP9j8m7g
X-Google-Smtp-Source: AGHT+IFN4oOlYTemewjK4U02gZSfSFDuLdJWGqrqdGs0uMMEx7wIQQMfTTM9v6Jw8bW/OHS7Mmtl4Q==
X-Received: by 2002:a17:902:da87:b0:220:cd9f:a180 with SMTP id
 d9443c01a7336-2262c625001mr61732925ad.53.1742325117253; 
 Tue, 18 Mar 2025 12:11:57 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c688866asm98989985ad.50.2025.03.18.12.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 12:11:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <76380583-858e-4d69-a412-25ddef988705@linaro.org>
References: <76380583-858e-4d69-a412-25ddef988705@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20250318 into next
Message-Id: <174232511609.1770758.3649930286570115403.b4-ty@konsulko.com>
Date: Tue, 18 Mar 2025 13:11:56 -0600
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

On Tue, 18 Mar 2025 17:06:18 +0100, Neil Armstrong wrote:

> Here's a small set of changes for Amlogic SoC support.
> 
> Thanks,
> Neil
> 
> The following changes since commit 0e1fc465fea62ebae91f2f56cb823e8b37ee1077:
> 
>    Merge tag 'dm-pull-15mar25' of git://git.denx.de/u-boot-dm into next (2025-03-15 08:19:31 -0600)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


