Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AD3C0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29F8980B9E;
	Sat,  8 Feb 2025 18:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CF87S4bC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DF9F80BA0; Sat,  8 Feb 2025 18:12:48 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B038082A
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3ce87d31480so9713365ab.2
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034763; x=1739639563; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BvlSbtfLFkbM7ByOi3ybeHkSVhG4Ld41TKFVJ8cKUsA=;
 b=CF87S4bC2sq5WnX678GYaRIKVPjTi5qrsY8Q5j9ttzX19HLzzhYbfRsEXJf/69h0Bf
 XVT06v1rNWU7u09jMH2dx1LWoozyuWmkiZ+ndALvtoZrB1Jw+2dATHKt+M8IetSG2nnc
 LFUneA0c0m6GIWtfk3jW2qITyinYm+GaB3n8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034763; x=1739639563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BvlSbtfLFkbM7ByOi3ybeHkSVhG4Ld41TKFVJ8cKUsA=;
 b=XkoKoBTxIEPhCh9T5nn0EoUBSrjJw/Px4e2hUoP4M2wbUYQiYxm+7tYT2T4zWnuacC
 j56ALlIe0ZJa473O+M0LvuzxeDmOeFWwdYkL4iUnmxccCkQ8PVHmTLSonftZGsqNglrv
 7/gYrLrGbLStP456iGPeDmySVj/CdEfYdL6Rf7Oc/W9WBmeSMc3heEpioAhCJ8Yn7n2c
 rEMSZu74H6He7e+0v9WuwODwyGIBwihb4VBCELPf1DabeJb72Ro2yNQ0BJPZx7hYpBDe
 HZYwotpK1UmS7ptjn2zDZVV9aT+vbT7JsAkPtBzrX+tTeXpT//tXmbP4J6J79h3TDxdj
 Y/jA==
X-Gm-Message-State: AOJu0YwdO1nyXRLsQrqkH6Iy2YXkDs9yCO0mLsFGOkvdVYyx0HWHIUK+
 DDHi2mRyToBeFDKJE04LVP7KJUuG6JLjYtgvGDiC2yZmToXWMdQjmR66I+o3AYddwd87RUBvIXo
 =
X-Gm-Gg: ASbGncvpWqYMPBur/kooZpTTmzLklohTHw/NIt7HEueQLST7vNn4wKlVe26T0e/Ro7o
 zbRQ2x61+nu997vAGSlpFtXIdRIIb5A5kjLZarXKgZ2V4pLE+e2bjRZI6vcNzEnQM11ErSm7TWI
 7EVTV/R1z6gzenoiKV11sG8F/eiVFQCTgeN2MtGNvh1ZhKCeMQfDG5ujICA9CT6L9Lbtx17Kudv
 gy/OolkZ+EY4YGX62z4OE/hQlfEn0GiKP70SNMbxS+9zLgu9R8AuJP+rNTW2ggte6CXTPa6kITR
 xCtftaY4Mv4beH5h5a3Orz5VdlyxN+PhdOeIh1m+VnaXPNBLVv32
X-Google-Smtp-Source: AGHT+IGUjqG6CheEXVzrpEgbRSWPyD7HeGCUdfsoDF1cRCgW/l6m0iEbFKjwQIpcbRIq/TiubZT83A==
X-Received: by 2002:a05:6e02:1fe3:b0:3cf:c7d3:e4b with SMTP id
 e9e14a558f8ab-3d13df17868mr65814505ab.21.1739034763511; 
 Sat, 08 Feb 2025 09:12:43 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 16/29] efi: arm: Avoid enabling caches when running under
 EFI
Date: Sat,  8 Feb 2025 10:11:36 -0700
Message-ID: <20250208171154.1305761-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

The previous bootloader has already set up the cache, so don't try to do
it again.

This fixes a crash in QEMU when booting from EDK2

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/board_r.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index caac092c8e7..c4545e9b483 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -110,8 +110,9 @@ static int initr_reloc(void)
  */
 static int initr_caches(void)
 {
-	/* Enable caches */
-	enable_caches();
+	if (ll_boot_init())
+		enable_caches();
+
 	return 0;
 }
 #endif
-- 
2.43.0

