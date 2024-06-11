Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C410C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B49398875D;
	Tue, 11 Jun 2024 20:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lx44gbrG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 521EA8860C; Tue, 11 Jun 2024 20:52:19 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 445FA88729
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b064841f81so38350246d6.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131936; x=1718736736; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r6NeU2JIBwJhlTgsAsQOVbj1xU6g4ln45CtSQG42xQU=;
 b=Lx44gbrGp8w3a76EtNIiCV+cauiFKGDOLB4pqQTfB72vD4Sgrpqwe0jB7oDtNGXv4n
 b7N+MLdC5/5C8Z62ni/SWbUcY39sh1N9fdEL7Bniwtwjt7lyfVvIKJZQ8tgTrSeVR4B1
 geF1Hvd+lxnJxqWsouRstfX+oPkaiDOiooDV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131936; x=1718736736;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r6NeU2JIBwJhlTgsAsQOVbj1xU6g4ln45CtSQG42xQU=;
 b=YtPn3OJAZ96ay7r5qAzmFboEO4BJ+aGWtle+rnudXC3vcVX5WC01FA7pCEHqio5WUY
 W3aJUBrAghqwyC5i638OgPV0jPvyN37Y8cEI4Hi9kTk5iurpwfBDT15FClIFMNNwlCHv
 jDEhPKQgRFOvc5yx/qky23eH0am0MqU9Hjbzrj5+h/QQAJjVoRy9JPHWLrvPKZ26M7vw
 lt8EmPxYSQqlgHYSTStgEW9YhpMCKO8ZP19oX8sFFYynyBF3EeVsyedb9M4DcET9PiD3
 T4mPaaroeGj0OKZkxLZpV/xbN5cn8HY1bTpjm1E6T4Vs3xAJyr/hmG6kFvA+sLzBbHZe
 V2NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2tGyvqRuAXHnDekw/YUK8WTT3i29lg61KlCi//XpI2K1R9pJRcLB1ko6fDjOr7gRrxVU5bkIevDf9lPAN/GRHckHT7Q==
X-Gm-Message-State: AOJu0Yx+zhJQMSgkkEJ7pA9nFBXpMuR7dEwjClfkBncRym1gnjMaN8AQ
 IGCVfzCMs5lAUoMeRDknuOTwb22wnZhLf1vD5OGAweGROvkSaTIASQrbxy4GUclAKod0+blIEi0
 iefHiHdrsdmgzymgUdWAOkg4smor21S2xEhme
X-Google-Smtp-Source: AGHT+IGdskxhR64jaKTYO158s+s/IVb5HauTnutKRaNakL7rfF4i+nNyfxkbr8GRZDukhfQjceDUnDt1V0v4DZMvNm4=
X-Received: by 2002:a05:6214:5884:b0:6ab:7067:6f6d with SMTP id
 6a1803df08f44-6b059f948d2mr123300606d6.56.1718131935893; Tue, 11 Jun 2024
 11:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240610-smbios-sysinfo-v1-1-587e100a9d92@cherry.de>
In-Reply-To: <20240610-smbios-sysinfo-v1-1-587e100a9d92@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:52:05 -0600
Message-ID: <CAFLszTiQ2cZ7y1TMquc12C0uj9SvO+TYrMhJ_5Aa7QPrs_twrg@mail.gmail.com>
Subject: Re: [PATCH] smbios: only look for a SYSINFO udevice if SYSINFO
 support is enabled
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 10 Jun 2024 at 10:13, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> If SYSINFO support isn't enabled, it's a given that uclass_first_device
> for UCLASS_SYSINFO will not find anything, therefore let's skip the test
> entirely.
>
> This allows to get rid of the following debug message that may be
> confusing:
>
> Cannot find uclass for id 118: please add the UCLASS_DRIVER() declaration for this UCLASS_... id
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  lib/smbios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
