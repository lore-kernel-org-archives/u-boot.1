Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC41ECD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 23:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD9D84CF2;
	Sat,  9 May 2026 01:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aErHtrBh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E27FB84D75; Sat,  9 May 2026 01:14:43 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C805F84C9E
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 01:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dbe437b072so1316835a34.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 16:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778282079; x=1778886879; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ycz+ci6DXUIrfGbTuzeH+ugIAWvS9IASfe2yohy2vlo=;
 b=aErHtrBhdizr1EtTcJL9qf3wh9LLayOCxmBZRLNeC1qbCiPZLNUx+IYwBaXOaOf3ki
 B+TEp/3njNI1UMbE2in0GXE+AadfFxcSwIWP5gInx+dRhSMR6gKtoPZOZYVk3idCDH/e
 eUnqPHOCGkK0y5W8NQpcRAVMlZhvA3rukyOFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778282079; x=1778886879;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ycz+ci6DXUIrfGbTuzeH+ugIAWvS9IASfe2yohy2vlo=;
 b=HfbI9Suh2RGWGbsPWERqp0DZLPbEb+hvCkSaGwHmwucOMu7NIUtYVqNXY+fTDNWZ+0
 QrfJ2A9S5TIEoSDetx6naAE9agp3BiTz3HvAjQxiXDD05FQOisyuJ8NvnKQDBu5cvG82
 hv6XFc2D4uRR0Y68j+c3eK8LlyqqdcDNVwdK1AgahKdFvL3niPhMUNfYjG9mKEKa1Rja
 AHafxGQgyQgB6wYWN9MpXrBvuhewMDCuQ0TR6iBsikO8y7VKSX+5Ww42ykVSWoMd+Scx
 0bdZKHv2zhJT2JPhqtCBbZYw1LqR9PD9CS5YEUelxFoY1zlqi08MQM0DvgZwiTGwT1Oz
 xs8g==
X-Gm-Message-State: AOJu0YyvcWHpSyutdoo1RAvYioK6UQnBjZJz/eSC+3BnQajj3YqIk9Te
 ctdNTKPmXXTtoAZ8hDRuCzoXyWWFjJAS56rH9LEBLibweO/T9r1cwu4hkHxxTnM7174=
X-Gm-Gg: AeBDievjO0fgbxH2B+q6Ww//TwkR86fmJO8RiY8ux4gBQLWHdO/ofK3RzWlW/28I6d5
 ioiI3rdL2M5RQPCX3QRxGnSjmBbE/TLZngEYwkRgPBRMRAdHrBaRcRIc4BRmroPptXlsqXgddNG
 ISUj8x0cv+hWMP4eMEBxdjbOTfz9dqADzx6OCQprv+S734PHzrNKjBjpom+1k4b8bOEd8auuG1B
 hqr6rCgLf/D+rmFgaU4bBrKCF48qFrhVmE/CI5el67KB1o7ca3hLsndWIJOJG26f62341L/9AaC
 TT0d7djiGmho3RPpCK+GmvijR9JsRKgba7WnSEZin7p+BnO3tPDBuzJ6PGTAV9nkS1oKsLvwdM8
 fGO/3YlhSNsdm/omyxbxajHZy0H6kEoROyMQyHNAquF52dNuKoYlqx0rKGyDkO3dqhao3h/Kkd5
 grL14dBGElVxMORzEbOk29pIg6KaGee4rT0Q/wFYfwqYnSSJ3qb8dxA///3fy67mkqMtkkPltRP
 l8F3fWCa+h8LrcZGN0fM1oo8Mwq2Xa/ujTeJNEe/bFLnwNRmg==
X-Received: by 2002:a05:6830:2116:b0:7dc:da80:42b8 with SMTP id
 46e09a7af769-7e1defc88c6mr8896666a34.18.1778282078687; 
 Fri, 08 May 2026 16:14:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367be1168sm2005082a34.5.2026.05.08.16.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 16:14:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Brad Klingerman <bdklingerman@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260501143850.2714779-1-bdklingerman@gmail.com>
References: <20260501143850.2714779-1-bdklingerman@gmail.com>
Subject: Re: [PATCH] Makefile: remove block from conv=block, sync in SPL
 alignment dd
Message-Id: <177828207777.1997265.13549459510970054465.b4-ty@konsulko.com>
Date: Fri, 08 May 2026 17:14:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 01 May 2026 09:38:50 -0500, Brad Klingerman wrote:

> The line that produces $(SPL_BIN)-align.bin invokes dd with
> conv=block,sync but no cbs= operand. The result of dd conv=block
> without cbs= is unspecified. GNU coreutils outputs anyway, but
> uutils (default in Ubuntu 26.04 LTS) errors out for files with
> newlines, including SPL binaries, producing:
> 
>     dd: conv=block or conv=ubnblock specified without cbs=N
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Makefile: remove block from conv=block, sync in SPL alignment dd
      commit: 26b17dbdb0f19efa67365b30d939d3572871e8ca
-- 
Tom


