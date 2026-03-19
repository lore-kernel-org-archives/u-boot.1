Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9AF1091926
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C5D8840E0;
	Thu, 19 Mar 2026 22:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jx2K6oWR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD8783FD9; Thu, 19 Mar 2026 22:36:47 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 097D48407E
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d7e5e8c907so514924a34.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956199; x=1774560999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Wl4KFjvewINj3YRORuYiKvjkyzO9CwGZadGBYZLYzk=;
 b=jx2K6oWRH4cL9v9blDR3iytfsF/bqXM5kwRivU+fT6GY+3YV8WbA2+rEDjQYZpSFNY
 IDHCpaLi9H1aZ61apX4KentuDFteYnSiey/q+USeU2hVfM5NtdDx8htWTXdy3KUmFjNd
 CCJOP67EaYq3gMqolHtKR9/wYeY/BxvXYjrmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956199; x=1774560999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Wl4KFjvewINj3YRORuYiKvjkyzO9CwGZadGBYZLYzk=;
 b=UaqXcg8VP2tBmogFCmQOHS8y0hWGUvwO/9miHumDUjrvKSQoNg9h1H7DWutDM+jPyE
 S8etnd5Xso5oJZZNCKCX4IXurGEarm0fxm+Q/gRjEAC/hTHmNhFnVUkNVnfb3nkXt1g1
 3tD0ghOMJdawQDEBHcjSnp8J2AdvrkeTcJMBT+W8CtCQDA2Vn0PpSyKn4ZmVHpqE/bux
 e8ki5hzZ3WOT9oe3MWVABH6GFUdy8Ue522dLcHdXBbEEpv1w6mkan8gQfYUIefY8Nv1v
 s3BxMuYWNP6/Z9vsXZvPs50qAd4506OYyQjEz6eGYZJumhGFaUM4wLE6rqGQWTYc3R8Z
 hvEw==
X-Gm-Message-State: AOJu0YwBFiopGbQaoohHKN/so9O57ln0otqqE2fyEhqmONeaH4KMvlSV
 jAjU1pRTNG34aeSo9q2mw3kkVhAC4+l+sDguq8sfMHQTbSARyXBnr8X5Z8vabTADiVYWv0D6t8v
 2K2i05Q==
X-Gm-Gg: ATEYQzz5xNuwq+ryuA8NTOs9sdU6Q8MvoUnpq03Ytrrtm5VLOhxmQLmywwN9rrVKNrW
 icbNZeHcGtHQM00tLl+s1atSWd0VJFK7JYEs/oqMcxRoaQwAIczFOknoV08fAyjgMTVA08W6X2z
 U63lz0EyiivgMO2Um+Uz6dTjuLT00MUrN29wu83/vWyH3QlVyzrZd+zA2PfO2SMbMrD3wL9sFdI
 9f3tRlK1voXv27NBBYBl+9xa8Qe8IZWeVZ59tFt2TnTLqZ5R5jZKszvFZ9AlIn7sgPgsEJN1gbu
 DOMIZzPQ3HVyKHW9ZR9Ya6DvzU5xPqR1sFfjF9MXkz1osn8LZdbPpThiXXrxZS69RZ++4oh8qwf
 hz3YGaB0YGEDB7WeZy7NL8VGQ1ahi8Niumcdmg8vNg1TtzkNL/hAd9b1Ltz1laHR3+n0wm1/2Wl
 4EVYgeIFhQYbHE/gA7ng==
X-Received: by 2002:a05:6830:441f:b0:7d7:ea9f:c104 with SMTP id
 46e09a7af769-7d7eac46a3bmr600850a34.0.1773956199606; 
 Thu, 19 Mar 2026 14:36:39 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 05/15] dm: Add struct uclass_member for uclass membership
Date: Thu, 19 Mar 2026 15:35:35 -0600
Message-ID: <20260319213551.267031-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319213551.267031-1-sjg@chromium.org>
References: <20260319213551.267031-1-sjg@chromium.org>
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

We want to support linking a device into a secondary uclass. Add a new
struct hold the require information.

For now this struct is not actually used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/dm/device.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/dm/device.h b/include/dm/device.h
index 5302cb1f7f0..6d9528807cc 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -115,6 +115,40 @@ enum {
 	DM_REMOVE_NO_PD		= 1 << 1,
 };
 
+/**
+ * struct uclass_member - a device's membership in a uclass
+ *
+ * This holds the information needed to link a device into a uclass. Every
+ * device has one of these embedded in struct udevice for its primary uclass.
+ * When DM_UC_ADJUNCT is enabled, additional instances can be allocated to
+ * register a device in further uclasses (adjuncts).
+ *
+ * This struct should not be used outside core driver-model code and tests.
+ * Use accessor functions instead.
+ *
+ * @uc: Pointer to the uclass
+ * @uc_node: Node in the uclass's device list
+ * @uc_priv: Per-device private data owned by the uclass
+ * @uc_plat: Per-device platform data owned by the uclass
+ * @seq: Sequence number within this uclass (-1 = none)
+ * @ops: Ops provided by this device for the uclass
+ * @dev: Owning device (adjuncts only; for the primary uclass use
+ *	container_of)
+ * @adj_node: Node in the device's list of adjuncts
+ */
+struct uclass_member {
+	struct uclass *uc;
+	struct list_head uc_node;
+	void *uc_priv;
+	void *uc_plat;
+	int seq;
+	const void *ops;
+#if CONFIG_IS_ENABLED(DM_UC_ADJUNCT)
+	struct udevice *dev;
+	struct list_head adj_node;
+#endif
+};
+
 /**
  * struct udevice - An instance of a driver
  *
-- 
2.43.0

