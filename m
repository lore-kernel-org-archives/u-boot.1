Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8ACC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 08:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF0581E60;
	Fri, 28 Mar 2025 09:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R97Udu5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29B4481DCA; Fri, 28 Mar 2025 09:15:55 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 250AA81CFD
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so16860735e9.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 01:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743149750; x=1743754550;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sg9kUD09T9KdcxtRqU4uQ2VKlx21kbtALqKbMAtMwCY=;
 b=R97Udu5AJnQ9WXjPYAMV8gUpRYBeVTxH1UpBNkIYu0BoFkYTgKoCp1rxLVw6w4niNu
 2f2MkPcFSwhIVAAUl+ZNvkADsXPkporHsekvDmFWbdzHRyc0TQ0LJLN47LhPz04W0aB8
 hWkmPfdBFPVOsNzrhHbz8jEEyKEcmg/jJ3KnxscF7/uslrGzeDIW+5TtYL/5wXaueeYB
 Ucd2HAwaSrzn05T/td4+cOkPGP8mgdwWb8EbmRmE0wyWfLNO3LojT2YL1eiS6btL/6SX
 AvHJ7ZJtcp8Vyx3GXnlNS9IYZOx22NF+zbDBqI+hhj+zUL9R0tBrUpbreawzGQk7+CLm
 MiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743149750; x=1743754550;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sg9kUD09T9KdcxtRqU4uQ2VKlx21kbtALqKbMAtMwCY=;
 b=TOgJKJkQCJkvttSeNxWt2fREGbhqw/I1nueUQmjfP3NqhrEOgPvK7wO+D5G0rzpkqS
 4UOHkkMvTmwbjwDaBKjT65jklqkwS61hamKUyhueMeKlY/Tuen945nRn+1EH4wnUmSO4
 mHVBpy8nd7bPDQ722jQwsOdXrsdWYZ/86hZJMIV0h/zdrRXCaxdD7jPL3qJeR0mYo1Iu
 xe6fBIrOoiLCPgP0m0BF5t+HdP14O9BzZjiGORb/+h6Cd13zJxuMu4oSml7AP1KRnEyX
 Gx7DhiM2wShSQ48uskkUCkR6U9Ri+/dgCM9Yd5SoTL5vgwmdzb7Rum/HAx9Tmg3FC7HF
 z9hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+YZFW3GMvIVrOYpXgI7gTgMYut1zsC7nIJkEWy98oWlABF8ND5lBSo4Hw/07p2SAQKs/nUuM=@lists.denx.de
X-Gm-Message-State: AOJu0YwTVgNfrtvE765PJlXj5OqUPnQKg7Q45nkjUDtX4+tikEoPrPC5
 OtK0GhIuPPEtiBFoDkDEJ0RF8S3zdnmP/UgkAhMZyCZN8FBHNtIRHVoEMyFm5Fg7rgQpDrZcLDI
 p
X-Gm-Gg: ASbGnctfR34/DRdhdlXPvM9VLUEZqxDBVeTDZl5XCVFvXx1rUc1VHPCT5FLgJjUA7la
 XrVIHyWU2nEkJNK1QNFJ6f2NBA4MOt8ngIDa2pPzTuXMwK1tkJCggXlk3G1gz4lDyThdVXN2FGa
 7dOHP2347FMAEXIeL1T+Kc5CjPHwek2jGACK/u/zgM8w3QlgyJ7WBraNsuWrGZV58QTcLWPF6Db
 LejNc7M0REpSeXm+r7ZJj3tNgh1u6rMQXe8qlFkVy66FFHW5y4to/Qf85TLko3fUloGnGkahtpv
 N655I4SNWpIF9TY6fqeYYBJ8LLlz0sO5Fi4yG3cmETl2ralGDovEUjE0pN+v5N0=
X-Google-Smtp-Source: AGHT+IFX8H7Smf0FAVCG+7p8MO3cxJmcGDUtnwrLc5bUTfpH1duxt4LoHeTKOU+ypCII8jOtrvs3SA==
X-Received: by 2002:a05:600c:3b9e:b0:43b:c6a7:ac60 with SMTP id
 5b1f17b1804b1-43d9147bca9mr13907845e9.10.1743149750488; 
 Fri, 28 Mar 2025 01:15:50 -0700 (PDT)
Received: from [192.168.1.116] ([2a01:cb19:95ba:5000:2b24:7f52:e3f6:e4ef])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fba4c29sm20352065e9.5.2025.03.28.01.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 01:15:50 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 28 Mar 2025 09:15:42 +0100
Subject: [PATCH 2/4] usb: gadget: f_mass_storage: Drop invalid kfree() in
 fsg_common_release()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-ums-gadget-leak-v1-2-3b677db99bde@baylibre.com>
References: <20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com>
In-Reply-To: <20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de
X-Mailer: b4 0.14.3-dev-94c79
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

Boards with low memory (CONFIG_SYS_MALLOC_LEN=0x81000), can be crashed
using the => ums command twice in row:

=> ums 0 mmc 2
UMS: LUN 0, dev mmc 2, hwpart 0, sector 0x0, count 0x3a3e000
|crq->brequest:0x0
CTRL+C - Operation aborted
=> ums 0 mmc 2
UMS: LUN 0, dev mmc 2, hwpart 0, sector 0x0, count 0x3a3e000
"Synchronous Abort" handler, esr 0x96000004, far 0xfffffffff2ea20f0
elr: 000000000102ea78 lr : 000000000105e028 (reloc)
elr: 00000000f2f33a78 lr : 00000000f2f63028
x0 : 0000000100000000 x1 : 0000000100000000
x2 : 0000000000000000 x3 : fffffffff2ea20e0
x4 : 00000000f2fc9720 x5 : 00000000f2ea20e0
x6 : 00000000f2fc9730 x7 : 00000000f2ee4780
x8 : 000000000000003f x9 : 0000000000000004
x10: 0000000000000058 x11: 00000000000058c4
x12: 0000000000000000 x13: 00000000f2e60800
x14: 00000000f4ec0040 x15: 0000000000000000
x16: 00000000f2f62f2c x17: 0000000000c0c0c0
x18: 00000000f2e73e00 x19: 00000000f2ea2010
x20: 00000000fffffff4 x21: 00000000f2e9b500
x22: 00000000f2ea20f0 x23: 00000000f2ea2050
x24: 00000000f2f61eec x25: 00000000f2fcf000
x26: 00000000f2e9fcd0 x27: 0000000000000000
x28: 0000000000000000 x29: 00000000f2e60290

Code: d00004a6 911cc0c6 cb000063 8b000021 (f9400860)
Resetting CPU ...

This happens when fsg_common_init() fails to allocate memory and calls
fsg_common_release().
fsg_common_release() then calls kfree() which frees common->luns.
However, common->luns was never allocated via kmalloc/calloc(),
resulting in a crash.

Drop the invalid kfree. The memory from common->luns will be
reclaimed when we kfree(common) later in fgs_common_release().

Reported-by: Zixun LI <admin@hifiphile.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/usb/gadget/f_mass_storage.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index bd749c033f9a..6f464185bd39 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -2564,8 +2564,6 @@ static void fsg_common_release(struct fsg_common *common)
 		/* In error recovery common->nluns may be zero. */
 		for (; i; --i, ++lun)
 			fsg_lun_close(lun);
-
-		kfree(common->luns);
 	}
 
 	{

-- 
2.49.0

