Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31146C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 19:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6F5D8800C;
	Fri, 10 May 2024 21:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UesDO+fg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F2DB8811C; Fri, 10 May 2024 21:32:36 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBEFA88005
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 21:32:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-43e06d21a06so3435011cf.3
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715369553; x=1715974353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQ7EWZgLUisf8Z8AOEsN9UMoUE6hiaCEQBXjDSDFoQE=;
 b=UesDO+fgA3eDtq0Q2qvDjKl54QC2hQr0erXBgw9LaL7swHwXMl5MZpND6JumDIDEJ3
 TcK8GKMyUQcpbgzqvqioRbLdQnOFNbvbes8g5TKW3ZJibadc7+ilneY/6mYPqvYXTab9
 Erk55G2cp2XdxdfPsjN4tu5fVlCTZQezr4gtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715369553; x=1715974353;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQ7EWZgLUisf8Z8AOEsN9UMoUE6hiaCEQBXjDSDFoQE=;
 b=isEhGMAtZl81Y4LFTjPH7/3rTAAVLbIHhbaDBgdxM7VPDcTJyfXnpxIUlZilBwezbB
 4t48JBn5kW9wPlOs5OidBPDPgxv89sGPTlzCsatzHWwsrqW5Os5XOhqqS/Pw2+tPLgCs
 w3XliEk4Bn17btviWX1nFV+tmnTl0veV/sUeH9vFexWYdAFJqgKyXPS2RL6f7AJdOOJK
 4Yra36y7TnEEslXN8MLvqIsegE5r6KzqkHjd+qlxjvbXONBNn/Ibn4wWqR2/54OJtG+4
 2HYMTANwZ9bmBO+yOyJ+k5kVhr2lV1y30WyJC00M9KutXX8Z+/UZxvIVaq1CusC93r6h
 G38A==
X-Gm-Message-State: AOJu0Yy+IDgWwourgvVnhkLGY9hY2uiEAlhvaJ0diEv/i2r0UhhwWgtM
 4gMjHFcoWtYfN0yXCsbUKmuzkikipTfLrEEKZ+g//sw4V7BnAfY562+dAuh4WLI=
X-Google-Smtp-Source: AGHT+IEa6Y8JTplxjvFBl55VVe2+NgEIydK01fsE5EpT2zSYWVwmcHDeDni0CsSGlArp6Cgg7E7V8g==
X-Received: by 2002:a05:622a:64f:b0:43a:a965:b0f3 with SMTP id
 d75a77b69052e-43dfdb4915dmr35910111cf.49.1715369552803; 
 Fri, 10 May 2024 12:32:32 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df5521c21sm24474961cf.48.2024.05.10.12.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 12:32:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, sjg@chromium.org, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: afd@ti.com, kamlesh@ti.com, m-chawdhry@ti.com, u-kumar1@ti.com, 
 bsheraw@ti.com, s-anna@ti.com, a-limaye@ti.com
In-Reply-To: <20240425220659.2056955-1-n-francis@ti.com>
References: <20240425220659.2056955-1-n-francis@ti.com>
Subject: Re: [PATCH v2 0/2] Generate all SR boot binaries
Message-Id: <171536955137.3410219.9458118815786867978.b4-ty@konsulko.com>
Date: Fri, 10 May 2024 13:32:31 -0600
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

On Fri, 26 Apr 2024 03:36:57 +0530, Neha Malcom Francis wrote:

> Add support for missing HS SRs in the build for J721E and J7200.
> 
> Boot logs (updated for v2):
> https://gist.github.com/nehamalcom/e652752623537aced8cf31308015d7c9
> 
> Changes since v2:
> - removed redundant HS-SE SR2.0 generation for J721E (Andrew)
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


