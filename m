Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0A6C52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 10:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49D3B88A01;
	Tue,  6 Aug 2024 12:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2X+0r5AZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9391D889D1; Tue,  6 Aug 2024 12:00:22 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17DE588A1E
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 12:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4281ca54fd3so2461355e9.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 03:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722938419; x=1723543219;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pW8wswKK1Bmo88Ilwbp+eXQMvJtS4EIkJYPaiY55NVA=;
 b=2X+0r5AZ0Jdrx8CdaLjYJ21/p1Yc27BOn3CVNRtvMnSKtdxEBJWDfV1DNH2YCURRO3
 r50n1LrcLQVV7XfeZXztlf7IHDyYWP8pMJRT36n7wqnJQV/rH7G0odC4mNiKPl314JaR
 kph5NawK9vUrNE2Bh27j8yAAatqHzbmtyQFebq9irmBYvtGQjQd3kWEoPaSf6NWuSmVB
 UeLW3ia6wzswTZUDMVu/gsmD9v8O9mpBHYr5CMhz5m8xYmIjeTJgR5fSyEF8HvoC+sth
 G1psX6KjQ8VAcN2xpdW3f7P61KUb7LYcVzfDjIxm5IpsynE2dyM0QAjf+kxPo6DJjULw
 JQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722938419; x=1723543219;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pW8wswKK1Bmo88Ilwbp+eXQMvJtS4EIkJYPaiY55NVA=;
 b=s8QM3qqYjevFNSp+4XKKnfzrvYw5vGtdvjN2z3WiCw98bm/KdcdDtqY6zy6JwHuxgx
 hGu47nOUFsGZ5m40IGKDA/r4jqePjaYoG/9Dn25U7IvvA1Jpq2gU0Hxu6SUmhsJCBbmo
 c82k34yJBHz5I4lgbmVUrUuraad0s9oB3PfRL7uvZb4GE/T/+bq0teQDey+r9ITDZTo0
 SH8C2NGZnCccPvUZ4+8PzTDckXD8FVTWm0TM+jf88yo59QYO1RACWHhMn5FC9Ymcypxy
 Q6hcFRZNAGHeGiSd9ROY4u5sDbtVASYFV9EhMaJptwiNfq0wcB29dNRzkptbmQvIap8+
 OOJA==
X-Gm-Message-State: AOJu0YzKnGRKKgmqJGumqzvjpIUEZstvZ+C9i3X06F0NkQZ8ThRMp+ob
 J+/y7rHKb3M9q+J3t5Eik2pPnZpmALQFTdAusva9fmzOuCvs7yn/5lltNQyaG9U=
X-Google-Smtp-Source: AGHT+IH0uc5n4YP/rZj6JXYamxg2Vq398k4tfUEmhPp7viaXRjyoA8jztQJdkfMMUeS0eD3PISzi9w==
X-Received: by 2002:a05:600c:524f:b0:428:1608:831e with SMTP id
 5b1f17b1804b1-428e6b0978cmr111148945e9.22.1722938418681; 
 Tue, 06 Aug 2024 03:00:18 -0700 (PDT)
Received: from mkorpershoek-xps13.home
 ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e7d615sm173248245e9.29.2024.08.06.03.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 03:00:18 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Michael Walle <mwalle@kernel.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240729213657.2550935-1-mwalle@kernel.org>
References: <20240729213657.2550935-1-mwalle@kernel.org>
Subject: Re: [PATCH v2] boot: android: fix booting without a ramdisk
Message-Id: <172293841767.29842.3059312237349095567.b4-ty@baylibre.com>
Date: Tue, 06 Aug 2024 12:00:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

Hi,

On Mon, 29 Jul 2024 23:36:57 +0200, Michael Walle wrote:
> android_image_get_ramdisk() will return an error if there is no ramdisk.
> Using the android image without a ramdisk worked until commit
> 1ce8e10f3b4b ("image: Fix up ANDROID_BOOT_IMAGE ramdisk code") because
> the return code wasn't checked until then. Return -ENOENT in case
> there is no ramdisk and translate that into -ENOPKG in the calling
> code, which will then indicate "no ramdisk" to its caller
> (boot_get_ramdisk()).
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] boot: android: fix booting without a ramdisk
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/2a75793bc55ec1ace0a66e96102beec3cb7ab64d

--
Mattijs
