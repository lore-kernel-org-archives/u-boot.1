Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE2BC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 897C4884CC;
	Fri, 26 Jul 2024 14:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="apcxROMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3028B87C7E; Fri, 26 Jul 2024 14:59:20 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 223F588614
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d5846f7970so552189eaf.3
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998757; x=1722603557; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tMkuwSdBvPWCU8OHFu1YmOyXTOq3Cp+GQvLGuhx3iHU=;
 b=apcxROMPuLnD6xLckCWdoI2nR+o3sXtkt7kSrwT11Jns8coNDLvozODxVhtUuAJwmy
 ZEX2IWXoPvAiNc95CyEtj+Us2Lly4JuNhLwcrGDoT5O1a5xZcHr0Frc1eRyOTswgS5KK
 VIVq1BgFDuZno70Qs6d8LkU2rpJurCywxOarQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998757; x=1722603557;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tMkuwSdBvPWCU8OHFu1YmOyXTOq3Cp+GQvLGuhx3iHU=;
 b=OsFlT2TRqROzMsNWT7QrMX90SQG1lxg2YYysqndBHELEXjOlEvC/zOfwEM4B4gg6JQ
 09471BKAf84BqZWXWwAcgsafVtR9JFYEljFv5CkYxpoMLK9t4/eU6tHMS/yVZPq9oyLU
 UsW3QN+wX1KI1Sz96nyxmi9IBnP2Sx4WTvVzrsq0IhpPI5O5en6ft34uwkjxDmprr/EN
 +nJHZ+nldxRY5PHE5wf0R1bLOZr0yQCucu5p10EWqJxo7TzBvM05g1YPN6of62qgYAGW
 JSaVojrtSPWiJcsZ11WP2gn+zFHQ18oO+/zwfeZkA7+hIn0+T9Yao22k+uALd4UtIvz8
 roVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYUKI9e7QcnYS7XbnwjEzntqPBEgYxl7ZayOBWJbNNcz9RLiJ54A+QGeThv1m844kXA0Sc70VkcB+/XhLkgB6BDXcX3A==
X-Gm-Message-State: AOJu0YxmcbtO5SjZhUHS+CXUntKGyLUQTy/yc+jIqz15b9WyTh2APfGN
 +utX3hon00ZUXlwiblOADnMb/UjCOlRAv4lkAK7InB3VIZaWh2VJSKkFxCIyiDnZCzlz3zFwY3X
 Qtvm2aof5VA6BJN3plgMLD6aVq2vLouV2oTBG
X-Google-Smtp-Source: AGHT+IFDwTKmaWj56DNRXT4Zapd8p813Lf+qzZhhLppnMIvkKVatuBh8oBeMMXLonTQCUtL0iypOBSy6d5QWl+owUAM=
X-Received: by 2002:a05:6358:52c9:b0:1aa:a19e:f195 with SMTP id
 e5c5f4694b2df-1acfb894dfemr650261955d.4.1721998756869; Fri, 26 Jul 2024
 05:59:16 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:14 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-5-sjg@chromium.org>
References: <20240717155712.2913651-5-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:14 -0700
X-Google-Sender-Auth: O2qS-RO0NWg1G1icHjmrd1MH1Gk
Message-ID: <CAFLszTjLwaGGFtDXgnLfoxcLBnfLHbmvU4dGCkJBK5aLx80RwA@mail.gmail.com>
Subject: Re: [PATCH 04/24] qconfig: Tidy up some pylint warnings
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

Reduce the number of warnings in this file a little bit.

Add my own name to the copyright message.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

Applied to u-boot-dm, thanks!
