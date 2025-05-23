Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD853C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B99A83303;
	Fri, 23 May 2025 15:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZGzxGImM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4266D832F7; Fri, 23 May 2025 15:18:40 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55A1F830B4
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-601956fa3beso10932741a12.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006318; x=1748611118; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kc2T/xz2XsNRzj6UTkNOzMXue0iAq0Itdqb4EvCdXzg=;
 b=ZGzxGImMg1X83d3oBzK+dIH4I0XVnLkpn9bGE1Sg3NnxMSEQGIOko8vhXPNc/GdfNF
 wBt/C2HYokJxMWUz3v+8Uj2v+2o7rdex1rKPLLpHCo97iRnfdIlMaHEDS+54wa/aPZ8o
 o7ZPOUGdloP9IfziS0gABUyV9im3CNA1IzdxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006318; x=1748611118;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kc2T/xz2XsNRzj6UTkNOzMXue0iAq0Itdqb4EvCdXzg=;
 b=ksRCPnAY9cs5oS61jCkr8tqKaGkTBV9xwKoixmVNxsoy8xKthnp/tSaeluckOSt5D2
 H9Yjpp4UJBYYxl6iGbdIxJk+PBLPIXRquJqLOHD1rU2ng+bmCAJ4m+j4otKCQ88VRNCx
 JAAsmpn3QNbz7yYAt563sjkGecoZzGkCw4ScIBknQtc+nafxUZICsT6Z+nYInG/046RD
 qXnoxwekLCm6bkqOPV7IR7GG+9YZGuNUFdFCraa+pNd37DSfJEPpO8iIYG5HNYRg6Du4
 w0MMu17IjMmlkUhTSK2BvM5I8dgYLm197aKZc/vg7FIHSB8KZ/yjlmFW1rZv7O31QPIU
 fzyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz3JjqaXpRqJCX0Ggx2MuYJSh+aLaEzyiA7JJMxHfKyPo8OK24s31EQzhTFYAFDm3OUDFwjNA=@lists.denx.de
X-Gm-Message-State: AOJu0YzAgnhkyT4QuJVvt+8swPf5WOrMyhVnW1uEdMMZmPxGjGPHTEkX
 05LH54FENRWs51bOyOIzjLS+lYfSNfWUFFK/GZWXUoEkfr5YDiED77rmMevg9ZShRbjUElEisbb
 DMqcMx2MObxsIUbr25Lg/oKMVag+GjhfZRIP//iZ2
X-Gm-Gg: ASbGncsJ3KCfvNQdJmVSS5VqJ3GxTGSNHoGQrXV+CCVhQ1uoKR3iT3ajz3T1hvTYy5y
 jZE2kYI6Gv1lze1d/akM9lW1qMNGC9b8MoaltWu6cDaOStQ3TpboYbzsYUPfpGeDIxvh6PLlqPG
 Z3inAUJDEs60dk0Q9hLCk2SSIKV9sR3meuEA==
X-Google-Smtp-Source: AGHT+IFATt84djR01ynIZXgIjRKfn08zPkyNMd+UYsvw6N3zgmqLmiuK8FY79ph5dUPtL1BVE3c3eQjMF2xCp0CruZA=
X-Received: by 2002:a05:6402:5250:b0:601:e653:b6e0 with SMTP id
 4fb4d7f45d1cf-601e653b9a5mr18753817a12.33.1748006317839; Fri, 23 May 2025
 06:18:37 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:36 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:36 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-22-sjg@chromium.org>
References: <20250504132356.2317305-22-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:36 -0500
X-Google-Sender-Auth: aEziRU8ljXngMCevH8B9x-0ye3c
X-Gm-Features: AX0GCFvIZ_FT_lHJpfD_4jcfY5HoKtOFP-jBq-UO2TbIRq-7-usJi2FnmILq97o
Message-ID: <CAFLszTi_AOhomRohhC+K-AT737k+unnAa5oyv6OLhm+1Up5fKw@mail.gmail.com>
Subject: Re: [PATCH v2 21/30] patman: Split out the processing of
 find_new_responses()
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

This function does patchwork calls and then processes the results. Move
the processing out so we can (later) test it separately.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/status.py | 74 +++++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 26 deletions(-)

Applied to sjg/master, thanks!
