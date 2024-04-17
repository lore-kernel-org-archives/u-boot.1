Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6823C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 19:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133F988457;
	Wed, 17 Apr 2024 21:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZKjsUH4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF4A8847B; Wed, 17 Apr 2024 21:15:14 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4603287D40
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 21:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-78f056f0a53so4500585a.1
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 12:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713381310; x=1713986110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7HU1WOLXZ6qsTFGfDYRC69zSKvgyVsOdLtMNj1+VERI=;
 b=ZKjsUH4hE3CioR+ztLnur7j6djHunS5XZq3I1YvFJWVD0q8jqcmNTZlDCP3rdhWxU6
 Z9WVVxrAECDR7fbOUKHbq3C80EYVkDjT2wZVO7Q5qDcymkTf6bbl34olaF7dCgiZ4FhU
 CLSkPBxeGHIodx1BLnUfsT20h8qDeamrOa8Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713381310; x=1713986110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7HU1WOLXZ6qsTFGfDYRC69zSKvgyVsOdLtMNj1+VERI=;
 b=WK5aSbO0AfSbRKFKXcX7aSAciAwrX7dz4iaH14yKyqF0mdNqpRsxhaVhrmfJAk1O9e
 I85SzgNuxVwELkbCEcXX9ASrbBHsYXqRWh3WDhYNjlPa7y/N3Qng3xIeE4CfXtLLdEUG
 Dc4GoJGRe6dZJbuz4KbWvBDn5MGvubnEJ5iYYQzRX9fQ1k6W1oioegi7N3/y0eiAjQb2
 zukhR8XiAotpVe9xjxQuFkqx2tF5mk4AcF1ji3Mbmr2Vbz4jdfndasDjLQDQtgbfQ3gS
 sbWsx9LDNlKjVKdN3I1Cac5naTmgB9DAPqYvcFZmUgxDH5jh1plio6OivGcXAnw7Llly
 4Dzw==
X-Gm-Message-State: AOJu0YwQIIHUREq+m6By6yAOP6TShqeLbsnrNzWb2TvnZ9xqQEwWNB/X
 F3UCI97oBIBvzshhAS7cDRQys0TDGjiPyEiBvMFDE2n9VDllscZLB67Sz6ruRSps2PCiBbsIt7K
 XkthTeg==
X-Google-Smtp-Source: AGHT+IHSDqgxOHz3ze0OdNJ6t2EmnAgNligprF/h77Gdi7EVFZj0A3z5vmkLQkV7gIwv8pPvmZl4nw==
X-Received: by 2002:a37:c40c:0:b0:78d:39ef:c1e4 with SMTP id
 d12-20020a37c40c000000b0078d39efc1e4mr343293qki.24.1713381310647; 
 Wed, 17 Apr 2024 12:15:10 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.73.35])
 by smtp.gmail.com with ESMTPSA id
 v1-20020a05620a090100b0078ede19b680sm4833280qkv.75.2024.04.17.12.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 12:15:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	mwleeds@mailtundra.com
Subject: Re: [PATCH 0/5] zfs: Fix zfs support on aarch64
Date: Wed, 17 Apr 2024 13:15:07 -0600
Message-Id: <171338126039.1227309.12521345948308526989.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240407014743.13872-1-mwleeds@mailtundra.com>
References: <20240407014743.13872-1-mwleeds@mailtundra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sat, 06 Apr 2024 18:47:24 -0700, mwleeds@mailtundra.com wrote:

> This patch series is needed to get U-Boot to boot from a ZFS filesystem
> on an aarch64 computer. Some of the patches are not architecture specific
> and would be needed to boot ZFS on other platforms as well. The ZFS
> support in U-Boot hasn't been substantively touched in several years and
> to me it seems like it must have been broken for a long time on all
> platforms, but I have only tested on aarch64.
> 
> [...]

Per Igor's comment and Phaedrus agreement, dropped his Tested-by on the patches
themselves. Then applied to u-boot/master, thanks!

-- 
Tom

