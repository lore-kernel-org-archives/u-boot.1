Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C505CAC5B5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 22:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC72C830CA;
	Fri, 26 Sep 2025 00:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v3fsh4rC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0BB480107; Fri, 26 Sep 2025 00:48:44 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83A308206E
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 00:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-89018ea5625so676710241.0
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758840521; x=1759445321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MmdIA4A17BYaroEr1VJPGkqOn6AJlCkwLBXWBEGI3+E=;
 b=v3fsh4rCe4/QXx/KiJ5NWhhA9etmFoyp1kSfsUqmN8pKogcmbhTc0qz1er7/l+/SFR
 DALRb2Swz881F+dRcu5gJF9QfkN1UDej7ftEykJejAie/Y1YNTLb+5ABR2cq243Ue+Bw
 uAh5P1n25Veto9Zcz4ycyUUoqB6G8yEQwg9t0whAbRMa3cw6URkZipBsKaVwj+Uh8oxZ
 2kH0qqK9Vk2cnmajNG55Ccx2VZKm85d1yGeC2lPY5wUKNibtMJSXx15Ppuqik51rUREb
 GzdtaLqJROWSgDPMsF4MaifdN8lb3QHEP9B+zdBMoYOvnPlF/hbQyBrZQ2KWM69lr3kN
 HcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758840521; x=1759445321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmdIA4A17BYaroEr1VJPGkqOn6AJlCkwLBXWBEGI3+E=;
 b=LzdR8yFB+u0kUiY4OwHYwLELLOaTsDQGyoMUGojeZNGD6k1AHeVwnKwDIrRflcMzZh
 cZpOFiAOf45VeiqnLuhGiK+tEDXWiwDpQhhWSUfRB+ZZoVF5muZuVaqYsbxvf1qBP4XD
 T5OZixxHxshExEBkJGAvDHqwmS2RIaM726F5bnSXhGItGvtyvqpcbHF5EAt9EGQuufHh
 gVaPW38+WDd67uEvh5D2uXGelDA7k2Rh8uI9XeLdw2b0uK6Vynez7eGFZentVucR3QRL
 +gUwjBoRQVxmtFzzg8AOuJE8+vi97QPIZO1/mD3mx8DCBdgoQSlaLKlaE+SU14ckhdfw
 +mWA==
X-Gm-Message-State: AOJu0YzR9JnkTZwlnJEiuhIz0a5wjQGFmNaFDzfXEGZ+2biJHIBvgq5y
 Zg9W+Lk5VcGXEEqcWt4wIyZdooMW0sYbCVWMdK29OhagzsE5h8DPM4dUIr9Obt+gFnbiRPcTBi2
 KlbpM
X-Gm-Gg: ASbGncv9dSBXuGPKxgTxFV5RprWsRTa9zI/N9TQAnfcs5wPO2CEeGdKHUyQqmBcb3Rf
 8fbngSxVvFwCAE0XsLGyWITcUQOJaH5ujHh1DW6T512ybogh7rY/WQFRnrwWsMU5wmZpdrE3tS6
 gA442PbvPuIgvssYoqo3YatoO8ax3FNdc3sHXEdJXD0uFfSRw+g5fVEwnWmL9dZnSKlPxgKWjx8
 yFF/WqcIB4m+eapSiz2+6BjPI93VVWOhN6PXvYMCb8HbmokbUJaRgrUEqdbydQgjlB3R0WFJypl
 mDfhLsmfJzpILVwf/xteY4eQoaA46OuNmDrdMfgOokasayf7DR1wX8cJ7OBbJAAXQ4RTWoAPEtd
 TIjNvIj8hwijDSUiHlHlrUVKd57Y6jM2ytkmngJdH5Y4vtvzp
X-Google-Smtp-Source: AGHT+IHlIP00eRmOZN+yO8G0KGEfskp7SaaPrKlR2nDt1PG/NiCaZkfYeaXdHYui63jUDhFlDrC1VA==
X-Received: by 2002:a05:6122:46a1:b0:549:f04a:6ea8 with SMTP id
 71dfb90a1353d-54bea2c71a1mr2293492e0c.9.1758840521027; 
 Thu, 25 Sep 2025 15:48:41 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.192])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-54beddf9c76sm673866e0c.28.2025.09.25.15.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 15:48:40 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 1/2] part: Export part_driver_lookup_type for external use
Date: Thu, 25 Sep 2025 16:48:36 -0600
Message-ID: <20250925224838.567562-2-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925224838.567562-1-javier.tia@linaro.org>
References: <20250925224838.567562-1-javier.tia@linaro.org>
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
 disk/part.c    | 18 +-----------------
 include/part.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/disk/part.c b/disk/part.c
index 66e2b3a7219..be2b45d5a29 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -47,23 +47,7 @@ static struct part_driver *part_driver_get_type(int part_type)
 	return NULL;
 }
 
-/**
- * part_driver_lookup_type() - Look up the partition driver for a blk device
- *
- * If @desc->part_type is PART_TYPE_UNKNOWN, this checks each parition driver
- * against the blk device to see if there is a valid partition table acceptable
- * to that driver.
- *
- * If @desc->part_type is already set, it just returns the driver for that
- * type, without testing if the driver can find a valid partition on the
- * descriptor.
- *
- * On success it updates @desc->part_type if set to PART_TYPE_UNKNOWN on entry
- *
- * @dev_desc: Device descriptor
- * Return: Driver found, or NULL if none
- */
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

