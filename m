Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72364FEE4F7
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7B7283E76;
	Sat, 28 Feb 2026 21:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LbbLQXqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD7783EEF; Sat, 28 Feb 2026 21:20:27 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E82083CDF
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d4cb7e10efso3764170a34.0
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310023; x=1772914823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MD6qqBthLnoeLu2mNA/rGg9pLlumgB9HqToA5L2/vYU=;
 b=LbbLQXqZgqaexTo4IftjMaCleH1kdDGOTMz3dwCPaV10yXBk11tTY98Dj69GyuMk5Q
 ZL+P3Fz+pElbizyLF73DFgm60Ntd7gF30+RZ8MXw+BAD88XLnT3Arw/xvTXVuJy5KXnE
 G7nUwSmZlEyjHyMML7NlhBimNhQypQJujL06E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310023; x=1772914823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MD6qqBthLnoeLu2mNA/rGg9pLlumgB9HqToA5L2/vYU=;
 b=sRcCY1/txmctU3aJqcL37xTrvheWPysf3QPwjvbi64+CHNdDyxlFrBp+OgNXKzmQFN
 Nsd6Lir/2fTqU8XZITlTuMF8lJWqo1DlEsPY7s0cnbNj6EPSUI86bRTUImGCstpKTPcZ
 kNsnoCDIR64UnTwUkK3OazapDkaCFl3Kc5xWSTEXmdQnEBWyDhWxqpnqV0KVnqwUYeha
 PLYguE4i68rUFtxdTxtjdBqGW4KVFJ/Yyikx595kf/vxJ4eLPwNriHlNC3gujlYWDSAR
 ywupvdhcoE2aijMv3A7O5oCxjn/PBZ7rIzur3li4zBwqT8tpj0uzku+CYxwKfJ7YH1LW
 PlRQ==
X-Gm-Message-State: AOJu0Ywaye5T8XWLKrTRXPVOF2xobiLBcxwMFUNaEZrnDJPFjUPO0Z5a
 3Jic1qtY3QHdFFJXdiBLrQJ0rEVS2JnzAdC3zHGgycot7739bWp6Yw43R0CrApyb9hG1gCWOMnq
 WZ00=
X-Gm-Gg: ATEYQzz987Nm/0t7SjesoWusbHUcEHeONvzEWHSZ+pcuRQKnJan1d+a0NyZbkO1ilGP
 Tqv/hQmlM5AMKANRrVdlLUESGJ9CvzDb3eddHqrn641PBmF/s3I44YuiSPpAFBh7yasRb5K9sGl
 zwspVy6GMgc4NEWUnFI/csIVCC1IP/V7A2PcQmqqvQv4EnbpCpOsqTCM5gJEMjX/HuI2vXj0Fcx
 +DxVthkWzK/Wp25MJyLPCiGZdKuCcWRR1rKgjIQo1BQSC9nMFbk1g8XQlvpuWSSm1jmoswXZ24L
 sF3qREK6QbkTe0thEMBI6iNBPa27dWJ0U31Rkrm4bDDVksvYNWtNX02QYB4SCnpUvN46T3sXEGw
 NA5Wio4L2kcfolFWIDqdY34tNuBe62MN7DOtxIVEaO1dxrtUYepINJy6JtV9unJoGtN47AIEl0G
 CfGVNk/Te69QahpWIJMg==
X-Received: by 2002:a05:6830:620d:b0:7d1:8ced:55f5 with SMTP id
 46e09a7af769-7d591c1ef6fmr5038733a34.34.1772310023557; 
 Sat, 28 Feb 2026 12:20:23 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 01/17] dm: Move flags_remove() check before child removal
Date: Sat, 28 Feb 2026 13:19:49 -0700
Message-ID: <20260228202011.1834493-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228202011.1834493-1-sjg@chromium.org>
References: <20260228202011.1834493-1-sjg@chromium.org>
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

