Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBB9C282EC
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CADF28141D;
	Thu,  6 Mar 2025 15:26:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fBd40cId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98241808A2; Thu,  6 Mar 2025 15:25:59 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A362281253
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39130ee05b0so119069f8f.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 06:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741271156; x=1741875956; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ue63HpIL4s7nmj4eEoqQjm3Hf7Q+UiOFHWN8tEEsJfA=;
 b=fBd40cIdaJig7tlS1gjm2jISJioy7qxjnoyNTu+hyWn1vONYedRnWxrN7xY0wmOf0J
 yrd/dCMY7gdObJtaXGtYijDiGCerUOcriO4+YJteDUU0pSBMyR/zsnxdlVix/W+42Fx4
 kOz1j4D5XodVNMKWKI+umdbvuI0b7h33R0FBTxgB3kfh8oXnPE+wlKvjAfv6iqRhfnck
 kwIz5UsAQqaEOlSPZPx8wZJQ+FL5QCPECLgymInID4z/GjPDlMPJ2Xg4tO6ZleM3FySS
 N89Sw26qcIsS6ofvqDzqj0ux57C0qrw6bFvM3dtsUaYSB/sFmp5kCE/zx9CVWiLrcxan
 jfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741271156; x=1741875956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ue63HpIL4s7nmj4eEoqQjm3Hf7Q+UiOFHWN8tEEsJfA=;
 b=RvJlBT8wFPyuMELKk7ZWXCu8jHCGZ9Qt5zLws6S6kxjzyvFpvpLlCV/V/QrNGS9wOd
 xRGiu3f1/cZm8QKv2DdGtc/nQzEZnmM6MVjLOKscZMqzaSDGlIEY93cT0viE/bNqpAsK
 O90NvRCK+YFFP1/eIDFqur6v3c9dR0g3Kaj7XoEYmrGzVS6n/Ko7xIgQiSdbEKLx6P2/
 uDSNsGVVKqaxm5GCY88jajfMt0IU5YJmjdjcFECErnxNuK+SxiMTo9IUELZJtJLdtapX
 /ESMAwDg/Cih12WWw8dCoJxiUwDd8k95m68L3rvxxBx7hzWp7BLR7+YWAi29SQlZ+BV1
 QjLA==
X-Gm-Message-State: AOJu0YzelaHlqKh3n5cYqqjjpNPPJ6R9tVAb57LnIA3SP5yMvYMzWO3S
 Usg3WO+MdNATZwbCnJmHW/OReV/6GCnnU3mwt8EVH+dv9tIz8yZaPOxgVLCc0JIF2Ydm4lbN7xC
 Y
X-Gm-Gg: ASbGncsrj4ckiRbaIm20AMAWeQacza20zX2J7kejTVYdmR0rWGhBDVleF2M7SFmso7R
 6WEx2trzUmac4HvcijAmdSUN+95Cd7et/6inM44g2QgT28w0rmOisLRjA/sN496tDr6ibRRdLI4
 Clv4xq1Q8jHkz8zWvxxJwP/GQ6WfxxwGuZPnloZCq8Op/DIFMjb8Ywn9+xdwd+YuBeUTaZDGc+b
 VpeT1mCFTTV8sWgZGquRR+ZaR/NNu5vEPM8Lh21bnLdeJ52BezdvRNCun+a80ZkUoHs11UgQjku
 /2EMvVjTOcEEN6bCAlnhcr34KZhVZi1jsXw7oPYZDZAUSVDtFfepRg==
X-Google-Smtp-Source: AGHT+IEyYI5PjbHm4unY7wH2CzapdjT5BCpDuQIVn9EIGgVQP6+tu5aeb2Jq7V2sO2SBBeHT7RHEjw==
X-Received: by 2002:a5d:47ab:0:b0:38f:4fa6:bb24 with SMTP id
 ffacd0b85a97d-3911f7a83cbmr7065025f8f.39.1741271155800; 
 Thu, 06 Mar 2025 06:25:55 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfad7sm2181543f8f.26.2025.03.06.06.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 06:25:55 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] dm: core: add 'netif' field to struct udevice for NET_LWIP
Date: Thu,  6 Mar 2025 15:25:19 +0100
Message-ID: <20250306142525.3079189-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306142525.3079189-1-jerome.forissier@linaro.org>
References: <20250306142525.3079189-1-jerome.forissier@linaro.org>
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

When NET_LWIP is enabled, the network stack operates on 'struct netif'
pointers to represent network interfaces, while U-Boot natively uses
struct udevice. Therefore there should be a 1:1 mapping between a
(network) udevice and a netif. This association is only implemented in
one way by netif::state which is a private opaque pointer that we
use to store the udevice. But the udevice doesn't have any equivalent
to store the netif. In the initial design of the lwIP integration it
was decided to re-create a new netif each time an operation on a
udevice is needed. Retrospectively, it was a bad choice since it
causes needless allocations and makes debugging more difficult since
netif identifiers keep changing: et0, et1, et2, etc.

Therefore, introduce a 'struct netif *' field in struct udevice. A
follow-up patch will use it to look up a netif from a udevice and avoid
unnecessary allocations.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 include/dm/device.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dm/device.h b/include/dm/device.h
index add67f9ec06..230aceb4142 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -20,6 +20,7 @@
 #include <linux/printk.h>
 
 struct driver_info;
+struct netif;
 
 /* Driver is active (probed). Cleared when it is removed */
 #define DM_FLAG_ACTIVATED		(1 << 0)
@@ -166,6 +167,7 @@ enum {
  * @dma_offset: Offset between the physical address space (CPU's) and the
  *		device's bus address space
  * @iommu: IOMMU device associated with this device
+ * @netif: lwIP device associated with this device
  */
 struct udevice {
 	const struct driver *driver;
@@ -198,6 +200,9 @@ struct udevice {
 #if CONFIG_IS_ENABLED(IOMMU)
 	struct udevice *iommu;
 #endif
+#if CONFIG_IS_ENABLED(NET_LWIP)
+	struct netif *netif;
+#endif
 };
 
 static inline int dm_udevice_size(void)
-- 
2.43.0

