Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE20E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D27768036B;
	Thu, 19 Dec 2024 19:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UWO2wEQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98BA7803A9; Thu, 19 Dec 2024 19:29:41 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F666802B4
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a813899384so3642615ab.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632977; x=1735237777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VavxHntR3p2/fvzxP7Xztcud0CIpgaP4QnTEVGJ1nR0=;
 b=UWO2wEQL9Xv8XQ52fMNZCBvJyB8zVPe061n5YMYoolT7OtBlalgLGE+8SqU+yk68lO
 uN8JuVbfTAUArPE91AdbtOO9RmIx0NVqNz7bXzT3p3l/oiwuBuiHSKH73ZBms7DG3rUC
 r0cdKhJ+kczEH0nKYxEEVZuSEORLYFHQFYB34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632977; x=1735237777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VavxHntR3p2/fvzxP7Xztcud0CIpgaP4QnTEVGJ1nR0=;
 b=C8vKmTR6w2Nl2+mIck2u2jyxmEq7tdt3h6iBjk/xx67Y6LWEKdRf45rTfVUkDHt9UE
 fepC0CWQY1XGw4voLsJHvCGLcxwluuCFqqvjFna3cEn2qTMhZeqjeWhBu5Ft1CbctgzB
 frhuhWQRlSfZR1pt5NeagF5GqqujF7WhyCRXAztNXm9Q39OCpW8el4gsYlQZD9eJ0Old
 R3lbJV7t75ME7EYOl5kjfkXfM4IMM86fdVcR8P4NrGJBRxKj/zxOMiPNrAaVq8E1ALuF
 iF3yMQg+WYvOkDvYx2/idAPHrZHdySjE8NFIKU8rb7rw/tI5HzfLN2hZYiHr9tk/lP+t
 UW2Q==
X-Gm-Message-State: AOJu0Yx6cWZmfCB/TrqjX6seRBw1axNin8V32LwqwU2kxmIhIcD4wiJB
 hQ1v1GxYjylZZxjwXiA10ydrUExHLPmajWdtQBWNwV/ATAlMeukSaAnjZe67Ni2ng3KgCsLcvHE
 =
X-Gm-Gg: ASbGncuFDdV0Zk1r8catOFXgb7sqWvUctCXFoPTQBmdSAqWvt661Qf3XyCBXMafMyzH
 1pjRJeh8+Y7c4bidHK9YysGgSn02mEEMTvlI3kdzh06VriMtTfxO3dFVmp+AcHiJb5sl7w/Untz
 6Ch47F02WUUY8ivxqUYmMX3GFGwQQrLdoMbBg8e4Zo9dgGc3/EThW5gkb7wZrwcv4mgsUiB19oi
 L4PH2L6oB7Yzon650CcIjvDdHpsmOeaRWPQVbcG7pEujD34hTULeV8mgc7azChJKfp2UEl7uTgd
 p/20NFmMwsFdAvAZFg==
X-Google-Smtp-Source: AGHT+IHUZbLRFIlYIQfJdyb5oxNzKN16IlE4Y9dCKiREnS2l2N5TeT/N9IEuRzTtJrR0X3nKRNxKgw==
X-Received: by 2002:a05:6e02:3c87:b0:3a7:c5ff:e698 with SMTP id
 e9e14a558f8ab-3c2cc7576dfmr1459115ab.0.1734632976072; 
 Thu, 19 Dec 2024 10:29:36 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 10/19] spl: Allow serial to be disabled in any XPL phase
Date: Thu, 19 Dec 2024 11:28:58 -0700
Message-Id: <20241219182907.2609704-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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

The current check looks only at SPL, but TPL or VPL might have a
different setting. Update the condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 7c57eb8539b..91ee07f7079 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -837,7 +837,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
  */
 void preloader_console_init(void)
 {
-#ifdef CONFIG_SPL_SERIAL
+#if CONFIG_IS_ENABLED(SERIAL)
 	gd->baudrate = CONFIG_BAUDRATE;
 
 	serial_init();		/* serial communications setup */
-- 
2.34.1

