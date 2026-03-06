Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F09F513ED
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C29C838BB;
	Fri,  6 Mar 2026 03:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kwDmMqza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1138383F75; Fri,  6 Mar 2026 03:37:06 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F19B3836D3
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-899ee87355dso70715096d6.1
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764622; x=1773369422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MD6qqBthLnoeLu2mNA/rGg9pLlumgB9HqToA5L2/vYU=;
 b=kwDmMqzap+EveZipXfHHgH2rvjPMxRpiHScskmq1/uDt5ZwmqayxT3G4NRp54guCZE
 dCFWIIfX52oJnm++6+9tw1MhHW1yPafRBbk1hJL0hPcPn3O2luv8r5L3f55Yj2NPNBQ4
 aLMwd0Xf9Mw+d/F8+mLlsry8wwaNrN9fT38cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764622; x=1773369422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MD6qqBthLnoeLu2mNA/rGg9pLlumgB9HqToA5L2/vYU=;
 b=NJGno2HtcxDcW6dy+EtSTSLs5fhvjRGow7ygj9/Qw/vjQR6vb7tUbN8nwsgyog4208
 UtY3i9ktO+K8TDVplrrgJFYSxOt86es8mkS9HwMc1cu+9eRZyAwV2a76wLOjuRIeFsSv
 r8yn7jATLEAqry4jbk6ihgmMBViNFCF9RUbW4IggrLCvaU2JJaQ/H7jTQwKPtmS9ZF/S
 zlXY6zX1Pi2rds1IW3grMbFtgApnfGj/uk+3Tm5+L73hu60kg+tcltLRWFRqIQP0eZe7
 4FC4pn+68PxhnnrmF12k7HVYUhbDirNLcIzb8LvPRM0WM/2u/HPhrScYm2JLQwkWP4pp
 PDTw==
X-Gm-Message-State: AOJu0YxixKnCl98BaA6si7qcipoXXbSvW79PbiucPKWn/sdtAvpbpQ5w
 WuJMP7vgeM8uGxeuCNEiWCptxtlnVpwQ8JJEThVQawzk+wTCsCdZD7qI1G7uUx1ucP8IoBsH0M8
 WhqU=
X-Gm-Gg: ATEYQzzFXunFwPyv92wjmXDvUCnF/D0KrLfhPk2wEL4pSRgMUzr5w21rRetNX/S45Ft
 NWaO7ML4wP1xMMO6dESW0NQhjSKGou/nF+mPapI7SYt4SVHQV9ZCJ28jYo6aoHjhRTH59zcu/70
 eoT+enclmAZB4S7R7B/0J26GSTjhjE6k6/RzfGVrC7SGZg+1Oqze6E4buuvjZfOTC8myLYmFSc/
 onEvNDvVKXhD036ZqqMssu0gY3tVXIpdVjUiIP6r+qHVZYq/niQ1lthzuPq7NNnsUumNVdrQi0x
 7O+z/58EeLy7VrmXIiNpXZ9/FtIR+dibp7z38BMMV/1aDf1Z2VwBbc/odDyn5SiYu2M7vGdN66P
 Ie8g9VkXnIkJkHRmkvq4/jclRp1M8kDdFv8U4JTTXz2SG+HVxfg2XztcJIe6GaldmK6u2h0VEoW
 Ts3frjW4TMiG0DWJGuPw==
X-Received: by 2002:a05:622a:2:b0:4f1:b93e:8d60 with SMTP id
 d75a77b69052e-508f491c586mr7959891cf.33.1772764622061; 
 Thu, 05 Mar 2026 18:37:02 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 01/17] dm: Move flags_remove() check before child removal
Date: Thu,  5 Mar 2026 19:36:10 -0700
Message-ID: <20260306023638.2678886-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306023638.2678886-1-sjg@chromium.org>
References: <20260306023638.2678886-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Move the flags_remove() call before device_chld_remove() and save the
result in a separate variable. This is just a refactoring with no
behaviour change, preparing for the next commit which needs to know
whether the parent will be removed before deciding how to remove its
children.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

(no changes since v1)

 drivers/core/device-remove.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/core/device-remove.c b/drivers/core/device-remove.c
index 437080ed778..03ef49c4db0 100644
--- a/drivers/core/device-remove.c
+++ b/drivers/core/device-remove.c
@@ -198,7 +198,7 @@ static int flags_remove(uint flags, uint drv_flags)
 int device_remove(struct udevice *dev, uint flags)
 {
 	const struct driver *drv;
-	int ret;
+	int ret, cret;
 
 	if (!dev)
 		return -EINVAL;
@@ -210,6 +210,14 @@ int device_remove(struct udevice *dev, uint flags)
 	if (ret)
 		return ret;
 
+	/*
+	 * Remove the device if called with the "normal" remove flag set,
+	 * or if the remove flag matches any of the drivers remove flags
+	 */
+	drv = dev->driver;
+	assert(drv);
+	cret = flags_remove(flags, drv->flags);
+
 	/*
 	 * If the child returns EKEYREJECTED, continue. It just means that it
 	 * didn't match the flags.
@@ -218,17 +226,10 @@ int device_remove(struct udevice *dev, uint flags)
 	if (ret && ret != -EKEYREJECTED)
 		return ret;
 
-	/*
-	 * Remove the device if called with the "normal" remove flag set,
-	 * or if the remove flag matches any of the drivers remove flags
-	 */
-	drv = dev->driver;
-	assert(drv);
-	ret = flags_remove(flags, drv->flags);
-	if (ret) {
+	if (cret) {
 		log_debug("%s: When removing: flags=%x, drv->flags=%x, err=%d\n",
-			  dev->name, flags, drv->flags, ret);
-		return ret;
+			  dev->name, flags, drv->flags, cret);
+		return cret;
 	}
 
 	ret = uclass_pre_remove_device(dev);
-- 
2.43.0

