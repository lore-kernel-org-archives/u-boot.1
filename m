Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C97AC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 17:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5AAF888A4;
	Sat, 20 Jul 2024 19:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ouC6Q5td";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6F188881; Sat, 20 Jul 2024 19:10:20 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160C78883D
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 19:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-706dea920f3so1376957a34.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721495417; x=1722100217; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UuuPybzcfKAWRb+MpL6SsV7M2/GlV533M8xWBii3/A=;
 b=ouC6Q5tdgtDSF9NTp4Td3D8sBpVSWbMzXHvwteTAwmAxNNY8voHocBJMo4LAXRk6Rh
 hEQZtpoT32TwCt66G765i3PfvHGGjycKndH1neW5pdPVd/On64xUUeHumyyaoXtAUk67
 ztXj28fjNvI96GJirmtHZVMhmSfuZmZwV0j78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721495417; x=1722100217;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2UuuPybzcfKAWRb+MpL6SsV7M2/GlV533M8xWBii3/A=;
 b=KejatNPuDdIwphED9TDfM3JwxUTrnwyrQ+3ONsywk3FUsRYx9p/M77nAg4Ab+4ekzm
 /mC8ZwyiFsjpVKrNh30SXtAL5K2jw/HoCOITmrbPdGhi4t4PP4Z34VERLOdYa4whPAKe
 h2qgT/83sRbatt9rC3qIl0qm6tBR315jFp38xv0/TlpA7GK57HtmcCic7lSV9SzeqFDw
 37GD2MhUsT4fibCfjJ+8y1FdJnXWzOgboUFHsVY3+hM9DypXyto9aaso3m7zy1QOrOb/
 Ac4yTCFxn4aCPn21ETjkwWwwMoeGbb/3S2F/4TIW2mOepq9WhvWnybLZzdWRnu4T0IPJ
 DCwQ==
X-Gm-Message-State: AOJu0YzAJeyiacbmpC2eTDcPzXjXChFETG9UvR5hY++V5ppBu02RSd6V
 bZWqevLKgdCxq77Da6GZZFSuU8wG9oX8hw0N91fwV7T4qRFUpMSGHIr97OaLdpY=
X-Google-Smtp-Source: AGHT+IHSGxAP/rtvHsZvcyVXQD5JU4etu/GGwkc0+GICBQdw/IgZX1OcN6eRmzL6+DZdCqYKIO4ZVg==
X-Received: by 2002:a05:6830:600f:b0:704:4563:b6a2 with SMTP id
 46e09a7af769-708fdbe214emr1689045a34.12.1721495416193; 
 Sat, 20 Jul 2024 10:10:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6189bd5sm773037a34.65.2024.07.20.10.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 10:10:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, sjg@chromium.org, 
 Maxim Moskalets <maximmosk4@gmail.com>
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
In-Reply-To: <20240715200110.34230-1-Maxim.Moskalets@kaspersky.com>
References: <20240715200110.34230-1-Maxim.Moskalets@kaspersky.com>
Subject: Re: [PATCH] cmd: correct ELF-related commands dependencies
Message-Id: <172149541467.3268377.13323867288470473385.b4-ty@konsulko.com>
Date: Sat, 20 Jul 2024 11:10:14 -0600
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

On Mon, 15 Jul 2024 23:01:10 +0300, Maxim Moskalets wrote:

> Enable BOOTM_ELF by default for all configs with LIB_ELF selected.
> Use OF_LIBFDT as dependency for CMD_ELF_FDT_SETUP.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


