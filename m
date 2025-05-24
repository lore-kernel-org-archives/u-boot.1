Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C04C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84EB483438;
	Sat, 24 May 2025 06:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KDwgbpTG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A44D83303; Sat, 24 May 2025 06:25:08 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB54883334
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ad1b94382b8so73332166b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060705; x=1748665505; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zNudZLzT3zeNuxQH1QAVzbgbo1sxk43d+97z7QKfhxc=;
 b=KDwgbpTGFpkDI9b44idJ1j1G4j/dIi3tHHidfIcwADavAV/pGthBV8Syx5+0+/KrGV
 TwmaqfxE9ZMpLcMmuWp1EuJzjDHfekr9/LMdd17PWOg1F5osq1xcgibQvDJscsGfbBMo
 YBac8QpK/1UHSBBaCxUXuz692ZDaidyc04lPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060705; x=1748665505;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zNudZLzT3zeNuxQH1QAVzbgbo1sxk43d+97z7QKfhxc=;
 b=MoCV746SB8iH/Ku7Sp8skAJi+yTTg6oKT/9UXDfO18KhTPfXe7DeyG3cLBEsz/tkUz
 s5kGMi9mem513sglENigQdKqvh7GVdSzNfBfQsk9pAv7mMioe1cmLlH+aFu8eMP2K8CS
 LC123eioXD0kBZercnsYH6Ks+eRLry8a3bNx6kiKSDTGE+Y0PV40tamVNKNYEAuHUt6O
 pdicZP2Jq9c/uy7VexkYVhXkQXh0x6FHPoVXlM8Qt3cHD/dU9HNhq+I2l1DlMiYAZvhj
 1YL79ayjYgby7unUeeEr38E7eXQGFAt8j/AIVvQ+ZTNc3Q4VLgZcZmVvwR4nQp4kIq6z
 t6dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJPNZcerxSFwmUyh5eNQl8mtizB/MZZDP4rIa8iIMzjSDnE0NR+jDK8g0dvmkZNyLG+BgdP8U=@lists.denx.de
X-Gm-Message-State: AOJu0YwgOJElwqOOZ8X5sDUBnbnuuw8g1th05EMXyy1GFmwLU2lJy9z8
 uNSWt2WDutUp06ES+X1XyKCiRCtSj3ONj+gQIbp4LjwV1yJpg243fhcsp5IsH+6CROLQqcagvD7
 1AHUvcV1hoKlRCxZ6z36QNeUuY8dTYrcbZIJUMszG
X-Gm-Gg: ASbGncu5GBY+2jdv+19mQFfYTo2k7vS6Q2pTgqEyKEeXv/2dxC/XeTZFVQYSFX0A1PP
 kK4p8t3J/FbzpAIR+Qg+tWQcbBaRs7QA7zfRa8BfyLP1pw3/yep6BGveoq30oEugSdQZwhHrNaG
 xQXXKlO0bOGR2ZMaRWWcxrGR6xCbhdsYU=
X-Google-Smtp-Source: AGHT+IHpF6Zhmxo3cvC+xN1p3x6OzioOqsCQkYfYmwqvGYSty+tEvPXVZd7BqeJN6i5PpH0TMhdEITMau5iy2926qho=
X-Received: by 2002:a17:907:c26:b0:ac7:16ee:9112 with SMTP id
 a640c23a62f3a-ad85ae09b3fmr137310166b.0.1748060705232; Fri, 23 May 2025
 21:25:05 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:25:03 -0400
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:25:03 -0400
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-20-sjg@chromium.org>
References: <20250508072907.207175-20-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:25:03 -0400
X-Google-Sender-Auth: yVEKCdojHumbzgbBV4ZwlP4Cmjg
X-Gm-Features: AX0GCFtm56rvl6_4FDPMYLy89gS5ZHINw-7eKZEhIQfwWya7_gmak_tBKyLM7SY
Message-ID: <CAFLszTjVBxEdvr-WWp63DzCVn9K3EsXT1u69UmHbkvPpbWmUSQ@mail.gmail.com>
Subject: Re: [PATCH 19/20] patman: Tidy up function comments in the series
 module
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

This module is missing some comments, so add them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/series.py | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

Applied to sjg/master, thanks!
