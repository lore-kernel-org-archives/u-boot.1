Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9BACAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 23:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99E2983677;
	Thu, 25 Sep 2025 01:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PiBDw7pz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A876835C9; Thu, 25 Sep 2025 01:31:27 +0200 (CEST)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7579C8362A
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 01:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-904d71faab6so274573241.1
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 16:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758756684; x=1759361484; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YC22lanRl3GQTzHHIg6mfQ+uCSGbvcLQ5JEnLBvDDRU=;
 b=PiBDw7pz9TojLhJdWUPAs8Nihcc/R2NVR0bVYgVhunrm4a9D4hTp3BkEidtlQiI5X3
 s+kDz7KFT3sPAPCU6Pl5ItykDe/n3qS9I1a7+6LwlF+xZ7aLGUYRUo6LY1e8tIWzbF2x
 5xRXsuc5w3/Y00kSphZX7Q3BffgvGrOWjXdiHpqpd4UuDHHgMM9+0O/ALHcBF6+uBcUg
 PAOYnLKIskIDyKYngivE4R66uy76K89uhbGi7Y58TmWK7Foeatu0v5RRBEiqbcD1xGbL
 vexhX7JnLkVFtJF5OVcJimtdfkcT7+lcBQlcqE1ZFjRe31WRL6156NU0hZqxPTZg2cxx
 aXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758756684; x=1759361484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YC22lanRl3GQTzHHIg6mfQ+uCSGbvcLQ5JEnLBvDDRU=;
 b=J4EmwmP7EOl6B475Mz6GIA5Q7dmjuycon7kIQQTy+X2FYRh68Rl+nCFno8Pm0kiQBo
 H7FHd5SGfvjZ6AnJUIZAPht+pJCYibk1Q2QxmtiQRog+4lhe7a/Ws3t4AJqfdFjKjjgZ
 PeXJIW/DWursEluhtNNa2gHux66iPJx3KGsP/eJ+1tfkDv63tNqLRMYhQiFMqA+6TB52
 qpx9PUFUijpesnJdrRhM51kqUf+sK/npZtFcIrXIltxiVa+pu7FNegCUZagTtuwGTqkM
 p3abNe3QU4oZ+cH/sIBPf2lhY9XEx8q7UzrQH5mYWW0/oKacVe6bXmkcnMH0VoQZTkfk
 YXAg==
X-Gm-Message-State: AOJu0YwYlQKNSVL8rnG3b7FqFGbEmzuv7yawDmXf9kODBlt1OwHBTzGZ
 uVEdlMylbOdl3cSeDnF1S0buMnpdKJ8qT9dHEG4uKYs7P0geeY2AgJSfBwb6E0vtD4MOxHwjImQ
 VoRcz
X-Gm-Gg: ASbGncvxCnFo9HVPKu2NHhWUTdS2jASwDDs6Y1a4QDKurggiQCsF67vCqoOcd6wEnLX
 luwtvANrGkRFdzkeg2k0/A4GYjgFTnkidGrlvYL7UTD78oXnvBZKPRI1HqjG++lNKzB85n8An5F
 Gr7ypTmvduI6xryLOm19/LEvbhT4grUjqo7Mo6mzF5bE92Ka5kICwWoeqAy6HIYDO1oJV0EpYfl
 QXNxWODThQpI4/iFzMUqJHfYk5We07uEqwE8y1fUn3CyKPoR4RLbkiy2s55CAH1XObMvuS1kA+r
 fNogpsNe06v22ya0YpRWGYTNLgrgGVBYNq2VJLSQQaPUzmL2JC5Zl+6nu2M/HtEfsY5F2I1R9Zi
 jaSvStbOgaO+xAIT5GD7pxS2UYt/SPXg3SKt/qdsQVKAYgghR
X-Google-Smtp-Source: AGHT+IGPfqIJE2va3ahFUx11dnReClM8LSN74ocZU8iIL3sDlMR8v97ZXqC54fSmqiD4EHDPGaC28Q==
X-Received: by 2002:a05:6122:3bc1:b0:544:6eb7:d7c5 with SMTP id
 71dfb90a1353d-54bea21a491mr749916e0c.6.1758756684041; 
 Wed, 24 Sep 2025 16:31:24 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.192])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-54bede0587asm101577e0c.30.2025.09.24.16.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 16:31:23 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 1/2] part: Export part_driver_lookup_type for external use
Date: Wed, 24 Sep 2025 17:31:19 -0600
Message-ID: <20250924233120.454116-2-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924233120.454116-1-javier.tia@linaro.org>
References: <20250924233120.454116-1-javier.tia@linaro.org>
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

Make part_driver_lookup_type non-static so it can be used outside
part.c. This allows external callers to determine the appropriate
partition driver for a block device, enabling more flexible handling of
partition types.

Add a prototype and kernel-doc comment in part.h to document the
function contract. Provide a stub inline implementation returning NULL
when partition support is disabled, ensuring build consistency across
configurations.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 disk/part.c    |  2 +-
 include/part.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/disk/part.c b/disk/part.c
index 66e2b3a7219..f0c6866e210 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -63,7 +63,7 @@ static struct part_driver *part_driver_get_type(int part_type)
  * @dev_desc: Device descriptor
  * Return: Driver found, or NULL if none
  */
-static struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
+struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
 {
 	struct part_driver *drv =
 		ll_entry_start(struct part_driver, part_driver);
diff --git a/include/part.h b/include/part.h
index b772fb34c8a..52fd3d534e0 100644
--- a/include/part.h
+++ b/include/part.h
@@ -471,6 +471,9 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 #define part_get_info_ptr(x)	x
 #endif
 
+static inline struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
+{ return NULL; }
+
 /**
  * struct part_driver - partition driver
  */
@@ -727,6 +730,24 @@ int part_get_type_by_name(const char *name);
  */
 int part_get_bootable(struct blk_desc *desc);
 
+/**
+ * part_driver_lookup_type() - Look up the partition driver for a blk device
+ *
+ * If @desc->part_type is PART_TYPE_UNKNOWN, this checks each partition driver
+ * against the blk device to see if there is a valid partition table acceptable
+ * to that driver.
+ *
+ * If @desc->part_type is already set, it just returns the driver for that
+ * type, without testing if the driver can find a valid partition on the
+ * descriptor.
+ *
+ * On success it updates @desc->part_type if set to PART_TYPE_UNKNOWN on entry
+ *
+ * @desc: Device descriptor
+ * Return: Driver found, or NULL if none
+ */
+struct part_driver *part_driver_lookup_type(struct blk_desc *desc);
+
 #else
 static inline int part_driver_get_count(void)
 { return 0; }
-- 
2.51.0

