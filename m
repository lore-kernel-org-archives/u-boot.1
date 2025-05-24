Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF4BC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8446C83334;
	Sat, 24 May 2025 07:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GpbFggMx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33D7683443; Sat, 24 May 2025 07:05:42 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B2BC833FA
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-601d66f8cafso832920a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063140; x=1748667940; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FYn+1LLeJCt/fhJfa66U6CDUhmQrKeltPIRonohSA+w=;
 b=GpbFggMxXaV6XTKLhVHl6uO959r7P72+0JWsmUHRC7m8SfIvEhtig9sBiUEuLX6pDb
 ZMpVjHf1B/DPoMtFZC9Ub92kedL+nLkVMWqexWPmbW4dIFEEPyhD3hhaZdB3weQCkkVP
 wLLw9WFIW6+XcdZA8vJn+RPJP7aLThi4eeqO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063140; x=1748667940;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FYn+1LLeJCt/fhJfa66U6CDUhmQrKeltPIRonohSA+w=;
 b=wYbkTQ+lenTh/B/x1cNAvc+zQQPXG67wMTWtb1zXlekgZ158flOfM+eupOTEfZ3/tt
 si+9xyHfW7yWUbISbrJ2YOrUc1vz91ztUUV0d+PtjdACFpsIoyQwzZvtg0eOj6yzqk7/
 pZWFunciDfZLFLHkWpblOZSznKt2aJ8nufCPobrXRHddjF1/N7l8tBNaeH2bdeNugeg/
 SHWkU5IdX+XLFjh83VPqSRLAkxTvYYXk5vxyWhm+a5+z13BWW9QOX/MYwhql5c4j/G0b
 3/8X3KkXIsnDZluToalV/UWLZ/PGPTNFoTSitoKFkLi3XpuhDSkJa6PhRurezjut1U0Z
 bHpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbk7ntsblEf4CLiRfxuxORr7cikAzv/P9KN4+aHll+JW/YHtk0nxn/FBRTbVwb6v48CG6ujs0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1ZxIt2r/O14JjsmU6fHRXGqvlROFUVKuiQMilhTj3j/keEPMT
 8i0BLvK9InBOzbGKPiNinVl+dwubCMwcVvpnsZpITaRA1Q7+1Wz1At5OnzqFbrKIuLw02mviUdQ
 mE+gOMehDhqAU9I1mkogDem0Bt9k4dzAw59BTDycYnR5IsQdjW5AmW+wQ
X-Gm-Gg: ASbGncu50/UFxm3k97vM+7SRY08qzwgOA8XIaawSbNQqursm3hmWHyw9OZoe/8IjHCb
 ARCUf6aEB9io7eny9DgWi420I/FzzdZRsBkh+t8ueqRlFo5sfHR8bK2g4s6ejaOsydbWsO+4SVl
 lInLVjr4LpRTyiz9jOxLwkhWKsXfG579uuTYP8A/kN3Q==
X-Google-Smtp-Source: AGHT+IFCxyRW2UPRrueSn5mo0BnZ2PxaEYWVWkNpAEOl5upfyN5q6ywVQQskEQhVdICBKl54iDIf+U1X2sjHKQaCIYc=
X-Received: by 2002:a17:907:7e88:b0:ac3:3d10:6f with SMTP id
 a640c23a62f3a-ad85b009feemr117789766b.8.1748063139810; Fri, 23 May 2025
 22:05:39 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:05:38 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:05:38 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-25-sjg@chromium.org>
References: <20250510110535.1453745-25-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:05:38 -0500
X-Google-Sender-Auth: afJAMjsSej-RJ7J86S5Diur2qPI
X-Gm-Features: AX0GCFu07sJWWT2wMcqv0E5aOfGh747NM1hAS9MSt6ZDbWuJxUGVa25E8PWyZRA
Message-ID: <CAFLszTjV5cp07V4Fd8M+n6tqdFEzduU=nAGPYS=H=DGYjxxfwA@mail.gmail.com>
Subject: Re: [PATCH 24/25] patman: Add tests for Cseries
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

Add various tests for the Cseries functionality, including both direct
and via-cmdline variants.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__init__.py     |    5 +-
 tools/patman/__main__.py     |    6 +-
 tools/patman/test_cseries.py | 3684 ++++++++++++++++++++++++++++++++++
 3 files changed, 3689 insertions(+), 6 deletions(-)
 create mode 100644 tools/patman/test_cseries.py

Applied to sjg/master, thanks!
