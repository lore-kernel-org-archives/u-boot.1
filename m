Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5CDFEE4F7
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2EE583F20;
	Sat, 28 Feb 2026 21:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GmURdSY2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6687683F14; Sat, 28 Feb 2026 21:20:29 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34B9583EC6
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d19bfe1190so2748727a34.1
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310025; x=1772914825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMecNIGwwIFkrvghiGTISWnaq3Ku25+rXm7IRA18quM=;
 b=GmURdSY2jqWeIKU/nLY/SJIGsh62rpM1Xztr90f8LCbpkunkFo65oRwPTNjxOb+NpS
 d0EHM+BpH+W5vtmdCLXAvJNTPJcVxqSOXLjUJVW5ZeUG0ie+MQhcfR47k8O5nVybRNAs
 9PcnjtlzH56XMRXfXvUydbWg7OKUWMGHUJSHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310025; x=1772914825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mMecNIGwwIFkrvghiGTISWnaq3Ku25+rXm7IRA18quM=;
 b=Yft0GvAeBJ3AMW4lUkXJFb+HBPVq/m9HNCcfwSK5S8C+SIhdtk0hBaPIMOdde9fNeY
 HBm1i2xt1gOvNJPUJCEuMU8a+Qmy7jTxdVJpNR0OkHUAaGJcAqZV7PLjWZxnUDHmZbxE
 2dOLiqkrMDsq5e6zymjprtlhL5ou8IOrilfVlBPHNu1Pw95/p3UQYVIc+Vw3WGydO/6t
 3LYtWgpwrXYE4JjeC9VFwZoh2c5MP2cU5FxBAEwHfqFHjb0zVH2j9P/J/DEg+az+rymE
 VEdZ9IwPtDB5mpq3tZgjBUgZGQMb6rFJMnmYhD25Klx2N9nvf864Ukq9m1UgWKmfGJ04
 nV4A==
X-Gm-Message-State: AOJu0Yyy0HyBhna5guYyP5vJX/GmZIDDlPOHFQtY/CN0uKoHus7/n9ej
 D8b5cjuBKusjRbBOdwUsO3swT/qRNHPMnfeI8aWSbWnmi8YGDxAkcD9uJpGMd7vCO0uAzZYXGKA
 9nD0=
X-Gm-Gg: ATEYQzzQXj9Yj2lNsnye4mv3g0uMUmsSM7ZtcWSxjGS+VlZ2wrJ0nLOeUyJOESuK7j9
 3w6KYG52L3itetQKf1+Ab/65nHTTifNw6SttmMonuvy5fCLld5O1yBoH6VrcrW6hOrQQfF4dACj
 bDJ5tYXbmP0KRNs1yblj21WqgxWswoPffvLAKsXOA6LVU4ackm0yVe2Er4JlaVJbwOFojTR/XbQ
 K9/PQ8GgEilzlWVtBkAcOl3Kcsu0kEmGrhxRcHAAgEW+DLDS7qli0CU9RNwgw8eSOZGiKler8Qv
 GxmQUG+5OsvDQBpmPzq1kIrV08QYLTcdEbFqly65SORtiT3QUmMatIiiXqeTHtHh+CAzcJjrlwL
 zO8gqNjfr3K5d444f5oKlTmCVpNVEyIRlmGNFAppbpKHr1TPRHikLWQUF8DuBX8z47/9ovwm10e
 KNt8ULdcn9Lo8gwFjyghG2YsMI1aDu
X-Received: by 2002:a05:6830:82a5:b0:7d1:9e9a:a55e with SMTP id
 46e09a7af769-7d591b23adamr6924038a34.11.1772310025195; 
 Sat, 28 Feb 2026 12:20:25 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 02/17] dm: Remove children when parent is removed by flags
Date: Sat, 28 Feb 2026 13:19:50 -0700
Message-ID: <20260228202011.1834493-3-sjg@chromium.org>
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

When dm_remove_devices_active() removes devices using specialised flags
like DM_REMOVE_ACTIVE_ALL, a parent device may match (e.g. MMC has
DM_FLAG_OS_PREPARE) while its children do not. This deactivates the
parent but leaves children activated, an inconsistent state.

Later, when uclass_destroy() calls device_remove() with DM_REMOVE_NORMAL
on the already-deactivated parent, it returns early without touching the
children. The subsequent device_unbind() then fails because the children
are still activated.

Fix this by dropping only the DM_REMOVE_ACTIVE_ALL requirement for child
removal when the parent is being removed. This ensures children are
removed along with their parent, while still preserving other flags like
DM_REMOVE_NON_VITAL so that vital devices remain protected.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

(no changes since v1)

 drivers/core/device-remove.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/core/device-remove.c b/drivers/core/device-remove.c
index 03ef49c4db0..557afb8d817 100644
--- a/drivers/core/device-remove.c
+++ b/drivers/core/device-remove.c
@@ -219,10 +219,19 @@ int device_remove(struct udevice *dev, uint flags)
 	cret = flags_remove(flags, drv->flags);
 
 	/*
+	 * Remove all children. If this device is being removed due to
+	 * active-DMA or OS-prepare flags, drop the active-flag requirement
+	 * for children so they are removed even without matching active
+	 * flags, since a deactivated device must not have activated
+	 * children. Preserve other flags (e.g. DM_REMOVE_NON_VITAL) so
+	 * that vital children are still protected.
+	 *
 	 * If the child returns EKEYREJECTED, continue. It just means that it
 	 * didn't match the flags.
 	 */
-	ret = device_chld_remove(dev, NULL, flags);
+	ret = device_chld_remove(dev, NULL,
+				 cret ? flags :
+				 (flags & ~DM_REMOVE_ACTIVE_ALL));
 	if (ret && ret != -EKEYREJECTED)
 		return ret;
 
-- 
2.43.0

