Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A04CEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D8383EA6;
	Tue, 18 Nov 2025 19:04:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LPguwu0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A00A83EC6; Tue, 18 Nov 2025 19:04:03 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C838D83E81
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4505b05e7b5so1327745b6e.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489039; x=1764093839; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g0UOFwAZ4Xac6gYXY19jXKN9kE+4nD7V+21SZvXOxOA=;
 b=LPguwu0qTXwnU64+vGSpo7yvjFzTmoxVC3s9S1fjEe5mu7mLpOPP3L1YUGONTOk7/7
 eoZLK2QlTGU29eZxYmysRsem2Nph5ROvJ+YZ5SZ8bxGZSUTW1CyDzB9gEsxpHBJNg1Qv
 FGjRhZeUAelygKiXwrmygJP2abF+LvvWeJehg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489039; x=1764093839;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0UOFwAZ4Xac6gYXY19jXKN9kE+4nD7V+21SZvXOxOA=;
 b=QcBIk6vnX0tkU47D+5fVp0bXwhKxAf3tag/l2+l+xzkFTePTIcmjopM7aWriDZuBQe
 lGlhTZl1Hp1J60whEZPuZbq2axWjJKFnCyClIUfB42MWGczetO6xXInsf49s+i19MLuu
 sCNYV025Z0Qxg7h3HO3n1y8IQXBEjEGG+la9u8a/oWR8zDh+PCu7JZe6pSHZ0Ak83/JH
 36N+fuj3gSFqTjEJA7zMiL8Fm81sbBdBMUKDC+8No6z9vPtqBhx6pQ0sqUf85dSPNwb0
 MhepolpxGcJYXgFaQBEP7bRRMQBO23WXHu6r4yC9ykX21EbD/5g9LzUMHmNnFN5FJ5Ln
 53Mg==
X-Gm-Message-State: AOJu0YzMvidQPJLm1haR31D1WrmemAWQrl2ddF2uKsqsKD2/qOi8UcXP
 HNLgAVicNH+Q0s21oAaRGori9Edj9L4llGd4++iEbk/bd00DlzchyRdJmFaIaPPdkTtmoaXw7dt
 dB6fOrs5Ojw==
X-Gm-Gg: ASbGncsKOyvZOvEEXs/2kf7Y1cJfy/DC9+/3/qSNtcIY7o0sXIT972Qs1RsaK4L7boe
 HhSdFYUPEmkBqblyO3Cb1CHFst0QyaBHV7zmJz1iIA2VfrAhjlTxEV0o80zTGbu57RCf7mrZdzm
 JK0xVQGjljEATq1KA7TLHsMqEeIc62/y/bn9jC0BYQSZEyqb7AruJm4uo/6MUr8VCnXFpzJcqTC
 dZCxUiSsa0Q5qE4bDzEtfisxIv5Lbyyt7D3A4vU2cBscbdOtsU8hnc4Dh1ERhbD+RYQ5sH64ynl
 bujrI1MLj/41eQl/g1qIpWUtC0bW+kbHXFrTZQRw7NGZ7Z+OIwRCJ6DbWkFNAjrmvkMY1U5wChQ
 aLwl01QvreSZH4/tsZxk1hxDu5ACNWD9y1urgPtCN8IEyXCqvcvW4RItF5TeLCZQnQmPLBt/tKD
 9xcMKqzTIJNJQGNv7bBHpCmynOoCxxzEcYshG+vDlRVLW+V/pYZCYDBweO3V6RA4U=
X-Google-Smtp-Source: AGHT+IED8I4BPRus4dMJDEY3RgJR4rvg3zAcf0zQA6wJOPU9vr2Qze2Fz7QLNCoRr3piqZnnrnuK1A==
X-Received: by 2002:a05:6808:80b0:b0:450:794a:6d05 with SMTP id
 5614622812f47-450975f73f0mr8003276b6e.66.1763489039087; 
 Tue, 18 Nov 2025 10:03:59 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450b67db000sm2599980b6e.13.2025.11.18.10.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:03:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] imx6-engicam: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:03:57 -0600
Message-ID: <20251118180357.591031-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Jagan Teki <jagan@amarulasolutions.com>
---
 include/configs/imx6-engicam.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/imx6-engicam.h b/include/configs/imx6-engicam.h
index 3d5701c636c8..f81ae4284203 100644
--- a/include/configs/imx6-engicam.h
+++ b/include/configs/imx6-engicam.h
@@ -30,7 +30,6 @@
 	"splashimage=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
 	"image=uImage\0" \
 	"fit_image=fit.itb\0" \
-	"fdt_high=0xffffffff\0" \
 	"fdt_addr=" FDT_ADDR "\0" \
 	"boot_fdt=try\0" \
 	"mmcpart=1\0" \
-- 
2.43.0

