Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9282C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD9E7888C8;
	Mon,  2 Sep 2024 00:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P/oTRTEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13591889FC; Mon,  2 Sep 2024 00:26:49 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F9E8690D
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-82a3022be9eso85087739f.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229605; x=1725834405; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fn6taKCgx/ZA4Wh9YCprniYz6cyu/bRt9qJKUSb8eus=;
 b=P/oTRTEtlzYg2CTIhRzbI2ztJVWt7VqNcJeIXYMGnVvqT5vuv1bOx1MeL5Ch7s2/Gz
 MGf15RCOFBkYFJfip9Ihd94JsnWqPW4K7ofWD5qUvX0UfQqmIICcnvxYKu/9elXgXsd/
 3P9jySESKWai4JGh0JYljXLNXXe0dBx1i7pJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229605; x=1725834405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fn6taKCgx/ZA4Wh9YCprniYz6cyu/bRt9qJKUSb8eus=;
 b=ludqzaKpCqF4wRAyu+f+I/FBS6vqxY2hJ82PyUfYvsLGr+6o2OKxCnNyu76TyZWJ4r
 0qni2uzg9cIP9iljRiPi3CbLD0E/KZAXOdqoZUQmXw+gXyiCErZOcNiWmzC2KA+d7Af1
 4daGMytKkfltBoaMJFwdcjqYyWgSY1WVyPw1NtjPA0bxpE698LBr60G4kvxAk68hgtGQ
 YyaomOHu41ju9gBbERIK8J3p0WMtcbtUYVen0pixo4ZCbiw5kBWZtYxHWfs3D8+0M9gd
 ZJKzy0jfi5bfvweiAAI28IPiHQ0JbYop79u5/KyX3FJxJbmHdmdXiIjvrz/zvKlnB2gI
 fHiQ==
X-Gm-Message-State: AOJu0YwPJ0v0V4i0Oye4D2EAimf0dX+jvlWCVXV2Qyfnpi0YqpEoBX7q
 GSmvgHhtP9ST5Yh2qEmlRF8rvo3kFTWINmM97l3FOjsIHvPYrFcD94nJ2Z6fVAMbAO7xYBRTswg
 =
X-Google-Smtp-Source: AGHT+IFHNKpBo24HR/6uwRAYlodf9pT9FwCiHpuMg31R42K59ycxNxS+N0JiwVb8gjLeZXe2k/OOgQ==
X-Received: by 2002:a05:6602:14cb:b0:82a:268d:8333 with SMTP id
 ca18e2360f4ac-82a3429743dmr755512339f.10.1725229605395; 
 Sun, 01 Sep 2024 15:26:45 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:26:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 01/23] nvmxip: Drop the message on probe
Date: Sun,  1 Sep 2024 16:26:12 -0600
Message-Id: <20240901222634.460873-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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

We should not need to announce this device. Drop the message.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/mtd/nvmxip/nvmxip-uclass.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmxip-uclass.c
index 254f04e0b99..58e8c3fb74b 100644
--- a/drivers/mtd/nvmxip/nvmxip-uclass.c
+++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
@@ -47,7 +47,8 @@ int nvmxip_probe(struct udevice *udev)
 		return ret;
 	}
 
-	log_info("[%s]: the block device %s ready for use\n", udev->name, bdev_name);
+	log_debug("[%s]: the block device %s ready for use\n", udev->name,
+		  bdev_name);
 
 	return 0;
 }
-- 
2.34.1

