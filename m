Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABB4C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E06D889D0;
	Tue, 30 Apr 2024 01:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UZcgY/t8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773C4889B7; Tue, 30 Apr 2024 01:04:14 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B995889B9
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78f05afc8d6so391962485a.3
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431851; x=1715036651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0YZx0MqOjOUCJ+EGn3rGdecIWJbuHeF9UNW676Zrb+8=;
 b=UZcgY/t8rAF3qdoAFsCvawKCd8GH0M+4N48TeI/uZqRnHgbBTvzM62REOckdwDHFK3
 YjhXz9U4WK6SltXy16iSlkc2FoBkpZfwtqxkxyOLNvpJfo34ZQYFANfyX8Azrv5yDl0t
 MxbKf2aYKo9zOjLbnV4oBhJaeXBdC2XhmUqAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431851; x=1715036651;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0YZx0MqOjOUCJ+EGn3rGdecIWJbuHeF9UNW676Zrb+8=;
 b=NWvUAVuswt/tFKWhvfD8ck4saTy26iZQxcMCxvWhm80nXpPTs0rslqmw5GdseNF5LB
 T2KBI+DkSAmya1PKz4F4h1ajf+LOqg/NuciEUNkmkGz2C4dMyXc6Dkz641JrRFKZRdWC
 oadqm9U/6JUK99oN/TgfnYDKFk1FyKhUwUywRrhIYDGY+0MaPii139F6NksYAk3cHAMe
 iU7CBuGAnawrxxP61mIOulqikHB0JenvAM3/TpDYTgHHUss78Q5fzrPdfryzGVJ7IWWX
 meY0nAznkPfQrnK9sreJK3U5DWhEemdQKyRCPhVXueiYNTvZcYkp/FcRpY7zqGTnsgXM
 zjfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc2mms+p/IpF1f1eMWOcd+xFOCpK7BxsUsOEOw4ysCpdJJ1Oc7jWbl45lFdcwDk7tmda1hPtP07TnyJSIdBSHrtSDgEA==
X-Gm-Message-State: AOJu0YwMtETedyOaioGNaCY2Er/Zm8f2imMofk93O0YaLwpAKBcVYtQ4
 EFN2UDyZfW5rr64i2plRG/6foowf3vlaR8Y4wpGBeSFp/0VUP4GlxLjbHCCK9r0=
X-Google-Smtp-Source: AGHT+IF6OE06AhZyRsoP/0mk6Y8YfsMngzRvfL8DwtRxtPqXJKnjFTlOtZflHrYl2VyoRljVV9C/mw==
X-Received: by 2002:a05:620a:5783:b0:790:9ebc:5a04 with SMTP id
 wk3-20020a05620a578300b007909ebc5a04mr12752454qkn.10.1714431851105; 
 Mon, 29 Apr 2024 16:04:11 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:04:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>
Cc: Jon Humphreys <j-humphreys@ti.com>, u-boot@lists.denx.de
In-Reply-To: <20240418175828.84548-1-afd@ti.com>
References: <20240418175828.84548-1-afd@ti.com>
Subject: Re: [PATCH] arm: mach-k3: am642: Fix reset for workaround errata
 ID i2331
Message-Id: <171443184991.1749944.13038684112080352359.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:04:09 -0600
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

On Thu, 18 Apr 2024 12:58:28 -0500, Andrew Davis wrote:

> To workaround an issue in AM642 we reset the SoC in early boot. For that
> we first probed the sysreset driver by calling uclass_get_device(). The
> ti-sci sysreset driver is now probed during the ti-sci firmware probe.
> Update this call to probe the firmware driver which will then probe
> the sysreset driver allowing do_reset() to again function as expected.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


