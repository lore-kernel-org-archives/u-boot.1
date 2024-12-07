Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D620BE7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DCA8894C0;
	Sat,  7 Dec 2024 18:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PKYWiY5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D86188DC6; Sat,  7 Dec 2024 18:26:38 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DA5F894A7
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-84197c469cfso95437239f.3
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592394; x=1734197194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmYNmrbAeYv0Sh1EWrfaiKx/UwCgZHMfqJoAMoZFvRQ=;
 b=PKYWiY5mi0Lt7/HHVBZjQyX12Uwe6eQjCZm2dsAXKU//F/SRdov0OiUYYOUfx5jyUH
 bFNsy3R4aEe9zA/ViGPvuFBDOpz/R5y7pgrjH3GzJUskfKu8D2bGvaM1qbxtP0WaVRZ4
 RZ8MYax8DyKUM9/czsF81UQ5g+cwAADZjg6LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592394; x=1734197194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fmYNmrbAeYv0Sh1EWrfaiKx/UwCgZHMfqJoAMoZFvRQ=;
 b=HAaJOjlT6XYsbXJmb1uAIIqnzbFTD4nVKh34S7otD2ZqIJ0yWxC2KnFat5h4V0StEA
 08OHHaENkmIoTVzP9Ru1Y4R4WCqeSSCrZsA67fsdyPn87D6eU5IXPAw0XB6XA1tsV8Iv
 DiRxYcNkMO+IOzZiE9hT3k0fmDM2aMqw2UgvP7Jn6HJJ12XtUrt1XiSzYdex6T/Q7+tp
 CaOfZ32uCQHBk/Qh4e8lej/0LxPUhPh38b3YuIEnlWLRCrnPOOIsqXFyxuVpqrJDy3Ar
 yzmFGXiWM3g/VU2WW7jk+u9tDwvhoChpm0dZ3jHWym5Wua89jNt2kC6bZArufywCPPOh
 S1QA==
X-Gm-Message-State: AOJu0YzIGsTn3IX3EwG+a93ll5kZtlezS360tZWdiiKzX+TDAL7EJvX5
 PLvZSndwvqkXxlkel75LW2enMgXo5ekhZB/OIaRndjhynDQIED+0R9PTZgr2mHi7O8dwHESibNw
 =
X-Gm-Gg: ASbGnctQGC/2ROt9dpu0R+dFU6/qtY0Ta9R7Gadsm12JlDtTdtikPFW2FIR8ADXgAak
 ggytL9f7dydsXrOuCImhhuRsoJDpD58aD5CkylvXYC7pBETA4r6LW7wtoo4u62NZPUzqQj7KEz6
 YHs5k4IXZTdEtpFNYBn+41sZOmcMKNX/PrJs1A5iyQiOJOOQfQosb9KZinlXIrUq0qLuEBR3XuD
 DVSaDdY7/IeldYVsXb1hMYWKM2SUQKE0qkm/GLqHCyMDEktWrEVuAPrRP2oiIRQxoCri40OUKYN
 tQq0K0tLCcA=
X-Google-Smtp-Source: AGHT+IE5b3+k2ncmhuweWYO2cFhgkbMuDz5fgcjAeDChl+AvoxSw6zj0zmqWuWqyu25P1yJwOqzMRA==
X-Received: by 2002:a05:6602:148b:b0:83a:b901:3150 with SMTP id
 ca18e2360f4ac-8447e241784mr776081239f.8.1733592394335; 
 Sat, 07 Dec 2024 09:26:34 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 13/19] spl: Drop a duplicate variable in boot_from_devices()
Date: Sat,  7 Dec 2024 10:24:06 -0700
Message-Id: <20241207172412.1124558-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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

The variable 'ret' is defined twice, which is not intended. This may
have been a local merge error.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 2eefeb6d893 ("spl: Report a loader failure")
---

(no changes since v1)

 common/spl/spl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 702920bd2f7..ad31a2f8b6c 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -612,7 +612,6 @@ static int boot_from_devices(struct spl_image_info *spl_image,
 	for (i = 0; i < count && spl_boot_list[i] != BOOT_DEVICE_NONE; i++) {
 		struct spl_image_loader *loader;
 		int bootdev = spl_boot_list[i];
-		int ret;
 
 		if (CONFIG_IS_ENABLED(SHOW_ERRORS))
 			ret = -ENXIO;
-- 
2.34.1

