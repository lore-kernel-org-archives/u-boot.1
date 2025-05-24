Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087AAC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB475835BF;
	Sat, 24 May 2025 07:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VL0Fa8lD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B40AB834BC; Sat, 24 May 2025 07:06:09 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CC1F835B6
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ad56cbc7b07so65312766b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063167; x=1748667967; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+k2MAtZo+jSOFjM7dzVEpweavr2gqM6R14XTiqoAxr4=;
 b=VL0Fa8lDl0DFiTiE9EY/3dmEJfuAjRmQged/8/MYg9VEzCnHJgLtptw2lsFSCTFuAR
 F/hLds5X+yIXY1IWcI/VnpY98Tp/pRytnfMIFXwZ4bv9CSWqGmmj9zdztm/ftwipBOxS
 xmDrUTz42YLlBmDMyy9ZtXIwM4mSN/OivGAR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063167; x=1748667967;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+k2MAtZo+jSOFjM7dzVEpweavr2gqM6R14XTiqoAxr4=;
 b=nyUUjkJbZD/TFeEkvFvtDjJgMo2HMQttoqYtSO8S+AZOaXKu6X8M1iW782FAzCDfUC
 ITAO1t2OGe3Z+Hvm+PMwTQA9BlvNIlcHe1+a7tM5TYs6SHHYGshodMHtwdx7guDNsioy
 pTa3VDZoRgBJ0+f/J1cdx8I5cWvvpMQYddN6Z2rnz0KYrIYTg6a7wkYAhcudw24VSixd
 X+KLostbZ3WDCdvpWTHL4aeyV/PJm71ZyCb82++GQF8AqyoAk0jmgDovU5mSVItzSDKs
 V9k8jvxTe9OuhfOAYLUafVevJXSWn35QuFKtaa0zPuh4UddNt2FsoLfffITTFoeJmKmn
 BiYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSqAeT/LKk6kfwdNUb7PAZdr/AVzEB4UPt4EmEsyvFxrAqaVmOuMLDH/vG4UvEsTpSdM+kXAs=@lists.denx.de
X-Gm-Message-State: AOJu0YwqYfaW4fTvELMK/jHDCF7AsF8RkxjQRbkVu0PgP50SfIDqyRSI
 rdteeUNPS/T5ubiRrEmriTjtIjTrMpaYNXb6GknHlFjWfk3mfA+PymsSCG0ff7WITODDFnYcxdT
 VFYRGGZgjj5kxl1jpOLHRN/QCEkQGHbeSHBca5BIqcmJaoVgwdzXt9AXJ
X-Gm-Gg: ASbGncufnMgvcuX1Hv75bsd0Rr2EBUVmUzbHGsAdxF7dW/YziuCPsySDV80XM46mgxL
 CjT+IbwYsYBbSX7j2NdfeSKG656u+xohC0YNTPeLhSedGFXqGxewdxRSy11jq2hy6K2opC0JFqu
 9LWilUmPMwPZu80YToWcDZ37H1X1AGg70=
X-Google-Smtp-Source: AGHT+IG483uFeZA2U0Mn5uKaobGYzl/hjbO5qck+KhcFxBs43GRby6jXRWUtr6jOwfyKFBh5yWewcTXkV7OJ0JTeslM=
X-Received: by 2002:a17:907:d8d:b0:ad5:5067:6bb9 with SMTP id
 a640c23a62f3a-ad85b1de2e2mr119756766b.47.1748063166941; Fri, 23 May 2025
 22:06:06 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 22:06:05 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 22:06:05 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-15-sjg@chromium.org>
References: <20250510110535.1453745-15-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Fri, 23 May 2025 22:06:05 -0700
X-Google-Sender-Auth: qvvBAbAkgP73_HqesIW2JDhIaww
X-Gm-Features: AX0GCFve0JPbOVSITdkMoSrTJjFU0gQExE9VP-RnUR7BCrc7uIFyRjRxATXhTxY
Message-ID: <CAFLszTh0gsu8q6qS71-L4Oa2LNvOvn6A-jB1X9Smv6i6Rqmo7A@mail.gmail.com>
Subject: Re: [PATCH 14/25] patman: Enhance implementation of file-based
 defaults
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

Patman allows defaults for its command-line flags to be read from a
file. The implementation of this does not fully work with subcommands,
since we don't want a default for those.

Also, it relies on being able to parse any sort of cmdline in order to
figure out the options that are available. But in some cases, the
cmdline may not parse, e.g. if there are required options, or
conflicting options.

Add a class which can be safely used to parse any cmdline, since it
allows execution to continue even when errors are obtained. Use this to
determine the defaults, being careful to skip sub/commands.

Another way to handle all of this would be to maintain the defaults
separately and insert them into the parser manually. For now, I'm not
sure which is best.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py  | 21 ++++++++++++++++-
 tools/patman/settings.py | 50 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 65 insertions(+), 6 deletions(-)

Applied to sjg/master, thanks!
