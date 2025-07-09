Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB118C83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 14:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F26B835B9;
	Wed,  9 Jul 2025 16:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bRJ7ZOfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF9038344C; Wed,  9 Jul 2025 16:22:10 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B3A4835A2
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 16:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-73a5c41a71aso2947491a34.0
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 07:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752070927; x=1752675727; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUjt0asMXIkw7maGeo4E4bCCaTKjNteA3m7Sb38uRxA=;
 b=bRJ7ZOfMGASafpVx9TsesAaBBxcA1jM7eC7FMwTXjGapb6FE8bqy+QUbMlxagi+A2Y
 LWZZiAgwFYH3MeJXqZkf37Rd4patXdPUpVZc/jarjPAWTlvNJD07qx9ssdMXCVqV7FK8
 A/ZXrzErkPMT1L2EBmJ6grOsSMHMjZKZ/H3yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752070927; x=1752675727;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUjt0asMXIkw7maGeo4E4bCCaTKjNteA3m7Sb38uRxA=;
 b=qCkPTBwtUH9nVGj9zXn73do8xIId+EbP+0CYXCfH1A71n+pITr+iQ/CahD/5U4cKtu
 sCnyTWqypI1kB1f3avx+SMh23q134WlFmKBdDfuypzt2es88T3w81ch+I2rCg+xJhSQx
 jtizNQox1s6e+XF75SOqARmsMhiLd3vW+H0d6s9N5o4HEtdBScHK/Afe9z+OCvOg57a2
 xsYg3TKbGFeJxBWycDexUNVtgcjhpwBLSRqxZvwSjoMxeEWFdGE8Dxg8xWcV1s8oBaNu
 /kzmPCprNAdVAbUmtTQ63swryiq02de9wM/8pSBioyym15/KLIv7F02y7lR6ATrp/zdF
 O2dg==
X-Gm-Message-State: AOJu0Yw/9NhicwPcXFuEMK32H7E41q20jSmYrks6YtEaYgk6xnhhnLlM
 oHbYNvhdeg2hhknTuT4cWD5ziZFvpn3Y5QYQrlbVhPPpvYfzZXc6GReaF16vf4TimoA=
X-Gm-Gg: ASbGnctgiIQCBiAnvLn4CyCgqQ6YwkzKgdfmy/2A8s3MF/qj5g0YBqDK4vsDDyXlAqf
 nczY80F0ZH3ZmPk3MZyURls31GwV5OwMNO1iBoSI6ydafQEXggwfW9ViQqk5usYQp3gOCb3V3Ue
 hHLl8eP583aDxHKf8GbODrxM1uEKzmORERuAN3tKNWJUtPrK1JRyKpKD1k9r7jksY3yaeGnWcpm
 DUTshfCz2OYgiwxIPr8idWcoCBvIySVPu8drT6AX4lCeSRGC7yaPCWsowtbDyYqWxpbDHxkwVn9
 1+rdmCt5sDBQSTdFsulZ0SeOzGeF34sjXJWb+ysJaH4FVIkvCDl7EQ7bno9l1sMPNuoV3HobCaJ
 Xng1cBncMgVNrceUIlWs=
X-Google-Smtp-Source: AGHT+IELMr5tM1t6gSGlti8sMZtDAop5Vr5q2Rf9WetoKvvrFABEPSCYmLg07IxfbpHvcCVbbbM7eQ==
X-Received: by 2002:a05:6808:16a0:b0:409:f8e:726f with SMTP id
 5614622812f47-412bc0044cbmr1903656b6e.25.1752070926966; 
 Wed, 09 Jul 2025 07:22:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac83esm1919975eaf.27.2025.07.09.07.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 07:22:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250630-scene_menu_fix-v2-1-7d9141a45a63@linaro.org>
References: <20250630-scene_menu_fix-v2-1-7d9141a45a63@linaro.org>
Subject: Re: [PATCH v2] boot: menu: Do not dereference pointer if pointer
 is NULL
Message-Id: <175207092587.1813324.2472736234356771827.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 08:22:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 02 Jul 2025 10:24:16 +0100, Andrew Goodbody wrote:

> scene_obj_find can return NULL but this is not checked for before
> the return is dereferenced. Add a NULL check.
> 
> This issue was found by Smatch.
> 
> Also add a NULL check for str.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] boot: menu: Do not dereference pointer if pointer is NULL
      commit: 074e05952705972072f52128cf2e3ec2d8f35de6
-- 
Tom


