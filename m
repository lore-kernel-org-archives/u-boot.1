Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D418C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B43C681EE5;
	Sat, 15 Mar 2025 15:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kIiph51/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE5381EC5; Sat, 15 Mar 2025 15:28:37 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DC5C80756
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso6247245e9.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048914; x=1742653714; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gy4PnU4eNP1M48v0FBfuALibXDChaUG2OjKS5qLKdZU=;
 b=kIiph51/i/wl4D7pzNveCN5B5vBUB4ohNWH02UtN/fJYgdiBOF0jdsQRiFEbWrsbzh
 JDCLY0x1YLVpL8MfCKhzVZ+wimOJLyz8UEswcrANdyGg4zKDLlVuPpLa5ErTJVDziv73
 Q8Bwd0O6tYhns18/um7IbslxjRU1PwVwJf4Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048914; x=1742653714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gy4PnU4eNP1M48v0FBfuALibXDChaUG2OjKS5qLKdZU=;
 b=CXWhK3uaMnV6qJJ+yrT1GsNnzaOZywY1CLTxaE+tkeWydK27PaPT/6MHhOAhcUiCcP
 VGu6NttH/84KoykAvhD+rCNBlTBwWQC5js3awYqMu0E4T6TDK5svBYezc1LLxdQK/lA0
 ImtBkTMCTvzqBzU2t7q35CRZb3iU8zF7wGAudOwsOEthvwy91z5ZOs/QiYdlRmHSdyto
 L4C05LXfqi8KlTp6ueKEuub+kWbAbWvuJEe2KPxHAcz4ZPhLtZpk0UJaKUmor9m9wGtA
 XuGmZ2ifjOiX9PbwHbPosTZSRy7UoD5EdIF1EJe75AJ/UOzJnO9mwBCOlKhzjxbhdxZA
 Z2dw==
X-Gm-Message-State: AOJu0YyhEkD4N8GHY5G4TnWYW6wZ7x9nluhtH0biGi+VPFW42giAmH1k
 OUGyKhSIOrCFCeHT3pXzWntpRPSqeCmX8v22Hx4vceng6k1t+aJpmBCXD2oEAgz8jKp9YiyfIMa
 Pkw==
X-Gm-Gg: ASbGncvA7qDGDzQBC0W8D7bBi0WN/JQQkyZ8Zba652Os82eAO629XhSnKu+DKbNwuAg
 Nba1YhEDQrQ1NSSWxDGRDxHLMd9y0oj9MHn9OcCvMueBp6ivXAIdQPX34NvlZ4slA3DrQAc6Fko
 lYKG3HJedc1U9yGI2TjNjBhxXavzEclXF/vUYZHI6CImIaStwERQSt/VdUV2d3JhJBFt1Hwce9C
 Nxmk65lMdw6RiuRjzHNq6pnh+BO5DOfLXCOp6mhlGDE5b+1HSB8JwCiHLucy7AO/VIDoHg45+IP
 rlXkkDBkJyQbTgeDMF2umrWg3eIyToJr0l5ajhKauA==
X-Google-Smtp-Source: AGHT+IE8iCA2+G0sHs1slxGQoR3Y6nWgjrSelzv7mHbYdDvhQ1++QHr5qMmAwyHnJSNpqL5ouZfnXw==
X-Received: by 2002:a05:600c:a21b:b0:43c:fcbc:968c with SMTP id
 5b1f17b1804b1-43d1ef4b09amr84162175e9.7.1742048913989; 
 Sat, 15 Mar 2025 07:28:33 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 39/46] boot: Handle running out of labels
Date: Sat, 15 Mar 2025 14:25:59 +0000
Message-ID: <20250315142643.2600605-40-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

If only a single label is provided in the list, bootdev_next_label()
does not operate correctly and reads beyond the end of the pointer list.

Fix this by adding a new check. Also add a note to convert this array
to an alist

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to handle running out of labels

 boot/bootdev-uclass.c | 3 +++
 include/bootstd.h     | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 9e4c3db2dc1..3791ebfcb42 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -579,6 +579,9 @@ int bootdev_next_label(struct bootflow_iter *iter, struct udevice **devp,
 	struct udevice *dev;
 
 	log_debug("next\n");
+	if (iter->cur_label >= 0 && !iter->labels[iter->cur_label])
+		return log_msg_ret("fil", -ENODEV);
+
 	for (dev = NULL; !dev && iter->labels[++iter->cur_label];) {
 		const char *label = iter->labels[iter->cur_label];
 		int ret;
diff --git a/include/bootstd.h b/include/bootstd.h
index c39058c0787..ac3c1922fcc 100644
--- a/include/bootstd.h
+++ b/include/bootstd.h
@@ -24,6 +24,9 @@ struct udevice;
  * This is attached to the (only) bootstd device, so there is only one instance
  * of this struct. It provides overall information about bootdevs and bootflows.
  *
+ * TODO(sjg@chromium.org): Convert prefixes, bootdev_order and env_order to use
+ *	alist
+ *
  * @prefixes: NULL-terminated list of prefixes to use for bootflow filenames,
  *	e.g. "/", "/boot/"; NULL if none
  * @bootdev_order: Order to use for bootdevs (or NULL if none), with each item
-- 
2.43.0

