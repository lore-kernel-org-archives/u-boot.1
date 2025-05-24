Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7416C54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49121835C0;
	Sat, 24 May 2025 06:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IltZO6wb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFB1B83460; Sat, 24 May 2025 06:25:58 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C10E9835B0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9ebdfso950469a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060756; x=1748665556; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f7c86nBq0v+w8bk+nL/pE0b9gZdcdznAuDOtXQIpBA4=;
 b=IltZO6wbEdKhpGxvuAUb4YIM7eXoOn4P8nmPcfsaRHpzIvBHHB9s+cBwcbylqkRZHi
 b2PPTA30lcp0D5Zsa666YnL8jNAWgc82gBVovp/HPDb6Waw/6hkeFOG67zdxsfprJE16
 DgZj9JYmNRQM0CB1UqlJkAoDzpX8amOVhfs/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060756; x=1748665556;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f7c86nBq0v+w8bk+nL/pE0b9gZdcdznAuDOtXQIpBA4=;
 b=SjV4wnm8y670/VfK1td4VfGhIeSVXfiIuAdLfhvzIQE4FsvgunAqU9yZMJGF5wZA9x
 JjCX4SQayezZihH/xscKEP/1tAtn9oLaQIBWavFt44fR+bbW6naBW2TlP9Uto7cRiYNL
 I9N5wdJxw1ZcE3BZMdkTd3kY2W+AZtSBQakF3S38f4YxTgVD1Jr2lwgaoZS8md3fdRYH
 pdrDp/ubzVpywl0IHahcCuA7BtVq1Nq9jXbgLA9sNV5deFLG3QPD8Lmjb+CijhIBrVry
 d3YkZI+vntlans2mGDt5UM/0TcX8s3dFSu70N5rSkZsdGhFb+ALwyuWWw2Yn7ntLE//D
 etIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzLtpTTE5cZcWA0C1pPgf1fo2GnB0lf3xNxM3Sd96Yg6myxT/vNcb05krG4EZch/5f5Yyj7hA=@lists.denx.de
X-Gm-Message-State: AOJu0YwbxmV8QC6WF4a9Z1WGSY0ogSDbJ/KaF5I5vigI4In1j9pP6JHk
 VZnUuxGFRTidNBt90A96ZzpUNuMYso7qyrMXLaoQO89ufglZh3ndxf1j/HH6qEqyIQqjxi1yZpl
 9708+oP1OSeo+me7w5BaAOH8gEwOQI8Xfi6EfneOsXwHEBhP8Z1z0s0HR
X-Gm-Gg: ASbGnctfaA/emxVT3a22FDQ04VteDiqmY++yyzSlhE3dl84jEAbTDZIlVwgAK1s8ztU
 t6Xqdj3Es3r2nGnAphssxSHd01VC4NcBM9ooQ2MJm2xYD9CFv51DBRLLuDgacB9LWomExA/6mkV
 RAuffz9zhFESHWUXc9VtnayMcecMsf+GfHnF5IPS1d0A==
X-Google-Smtp-Source: AGHT+IGxuuSTW+g+t7xts55YZGG9T16riAtAKVAqRDPaojykbw5RqYwLnIdc5RhGUH3VFb8Ta1/RWsG1f7tNDRLieok=
X-Received: by 2002:a17:907:7da8:b0:ad2:4ed5:ca4b with SMTP id
 a640c23a62f3a-ad85b2c3abemr118928666b.61.1748060720358; Fri, 23 May 2025
 21:25:20 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:18 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:18 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-15-sjg@chromium.org>
References: <20250508072907.207175-15-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 23:25:18 -0500
X-Google-Sender-Auth: 7YFeZH7p0uuJ5o0_HOS5HO3GxBs
X-Gm-Features: AX0GCFspV_1-u8sIYCkyA0Tw0b6tSLdWaLBPRhP3xLEqlltX2OyN4AVqLZ-rA5A
Message-ID: <CAFLszTh7R8+nFDL-bov=Mo6KDv1oF9bH40ZpGpGpYb=TERGvug@mail.gmail.com>
Subject: Re: [PATCH 14/20] patman: Split parser creation from parsing
To: Simon Glass <sjg@chromium.org>
Cc: Brandon Maier <brandon.maier@collins.com>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Tests may want to parse their own arguments. Refactor the parser code to
support this and allow settings to receive arguments as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py       | 32 +++++++++++++++++++++++++-------
 tools/patman/settings.py      | 28 ++++++++++++++++++----------
 tools/patman/test_settings.py |  2 +-
 3 files changed, 44 insertions(+), 18 deletions(-)

Applied to sjg/master, thanks!
