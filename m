Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3344AC87FCF
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 01:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E5483621;
	Tue,  5 Aug 2025 03:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hSH4DDhS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C23D83420; Tue,  5 Aug 2025 03:29:30 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53174833EC
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 03:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3e5128c53abso613935ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 18:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754357367; x=1754962167; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0+BX3vlfArn/aEgZpb3zsdkrpZF0jHbOwiD5KVcU8VU=;
 b=hSH4DDhSZhMhv5sX6DqDvDr6ikJRQM26EP+DA9Y0RmaOfxXhWMOqC/GsIVXGonlDz0
 +VIpC86CRuZzsOneoU8qVPaxz5QZsAkU4edu3RviSOPdjBGdZ0th7Z2xp7gTaqLsJJhD
 /+8Pyc8ZswWpCr9565vpj5nPjluLHGd3Kcltc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754357367; x=1754962167;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0+BX3vlfArn/aEgZpb3zsdkrpZF0jHbOwiD5KVcU8VU=;
 b=gS49OXZ5YPPaTPUXvWLNs/D00EDILVng+G8SbDKHZOmnEaAdfG6bwjdgx1p+4fSjzG
 zVzK17h5ox0F5ve1LPQgpV3ek1oxVjgDGeoHA2pKem3atFFWECtpcufAyd5mZsfFfTR2
 LaRBDJzCP3OjGY1pHsimyLw93zgJ9lnNKrcWir7ICFc31VuNWKoz5qVOv8ilPSGH7973
 R1uyoMnFmbHBshjmqVdGYFgeD0qrNHb+KR+78RmRmGv6qNk/5G2R5iuVG7tFpVY/eLC8
 fYm4nEjaVwI6G7dFPAfIt7cs37NtmD8S5lDsYY9R5SMkX3ZdSlLTdG9awn4jPpRGnygK
 +OEQ==
X-Gm-Message-State: AOJu0YzEbaVOsEjPUcTgYgN4Mqwkaq+qI3/QUAWm9VS2kwLmFa+u4FjI
 dL8hQSDugAyZWZBB598e6w8Btadn6f1ylEUPXp5AUU2feA6iDTNcrfAA3h3R82Llf1C45OD3w8X
 ef/eBwUI=
X-Gm-Gg: ASbGncu60xld9Z57oFvGffTFzeciPF0+8V1Su+cbKEHehMDCGgyUNF8PuGdXnpSNg/5
 OM7XCeuiddTqXB4rM131ME9E6mh3mCMtvRRQN3fkYF5pAwBp8U7TJ83g8xVAyL7ClvWc+DNoGXG
 Y8SFMurudL+Yvy6wUbOap5P0drxyZIpMC+3DmCBpi08e4CbTNSYNZVXwlX9AX6iXdC65H3eSDw0
 uEuOHkWWpwRIYAucNR5WuJW4KkQ4lHKG4itqmug0oYgBNUDSKzys7J7efOX/DKio56WqIh/3PnO
 +vBuNq/2SL4SZNjPnVJxmwuFkghdEyuPLfPZvowuenlO6o18LQrMNz4RzVn6awfax0W0JlJdOTj
 nfgFn7Yrm/J/eRj7OEZ4fW6tgQdVRK/MPulKi9QydjbX1oUPPsvRPnHXiZo7lSGg5zA==
X-Google-Smtp-Source: AGHT+IFd5DDgXYZQ+5EASZz+TOg97Rvo3hEk6fi5n3HYHdt6xgf291gRJAHVyq7zkZBuYDJ9QmamoA==
X-Received: by 2002:a05:6e02:2511:b0:3e2:ac27:6ba with SMTP id
 e9e14a558f8ab-3e4161c7d26mr215528625ab.19.1754357366955; 
 Mon, 04 Aug 2025 18:29:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50aae78b8cbsm539506173.21.2025.08.04.18.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 18:29:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250725194214.4156440-1-trini@konsulko.com>
References: <20250725194214.4156440-1-trini@konsulko.com>
Subject: Re: [PATCH] test: py: test_fit_mkimage_validate: Only run either
 test on sandbox
Message-Id: <175435736599.1435425.14490689532909415041.b4-ty@konsulko.com>
Date: Mon, 04 Aug 2025 19:29:25 -0600
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

On Fri, 25 Jul 2025 13:42:14 -0600, Tom Rini wrote:

> Both of these tests are only valid for sandbox (and require dtc) so both
> tests need the pytest annotations.
> 
> Fixes 93d09d3bd8ea ("test: fit: add test case for invalid default configuration reference")
> 
> 

Applied to u-boot/master, thanks!

[1/1] test: py: test_fit_mkimage_validate: Only run either test on sandbox
      commit: 12a94b894dec1b682068e70cd9cc11147242f70d
-- 
Tom


