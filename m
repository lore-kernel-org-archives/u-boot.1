Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5FFC28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 14:02:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F57780FDA;
	Wed,  2 Apr 2025 16:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xtDBkl/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D5FF81703; Wed,  2 Apr 2025 16:02:24 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 090C780584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 16:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so5094461f8f.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743602541; x=1744207341; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C2EjKF2FSfjqM7rTlder4uNpxU0vv4gA7MKpUhxpTVE=;
 b=xtDBkl/W3BvGCEwJ+8dnGXXllc2aV8auCPTJphD9aQX9V4ArVxggs+9l5xE36HDxiP
 pQmnRrYMB4Pxo/EGndsv1WlkIq6htrJyVkzD9LsRQoB7aZIzG8Efburdc8RdlVZYPq9X
 5NEvN3FpVyP3K8J1ISXaUKQCSNQfjDcx5ntPGwKyfJTe3i0TB2imli0w+HG3PLoDiAIy
 fqJteT25r1XUvNMO4pVpnFTFd9HC4gpOhiaJhKP2Zo+S4+ZCc9OZ9qL/LDI46RDoidTH
 DGsvxvjhmLbvRr8N74zq4HufkoWjLFDN/NbfaAuq+o0gdGVjcql0wde48Tl+g7upnhOL
 TkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743602541; x=1744207341;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C2EjKF2FSfjqM7rTlder4uNpxU0vv4gA7MKpUhxpTVE=;
 b=jDGZY91w7kwjMVoXfWljxa4VuBDJZ5DOsDlolJWdgFf1zYT4xRJk1nMHsVfwLymeNv
 oTlF4QAh4G3p1v3sDHOmmR/Ur6y1XD+f1lQXgyIBber0IaUdgePhssS5KzLs/0aunwGr
 WY4vrzmsnkqqpeorY8Cfr2mJvpZmMo+T4oQ/TL/3PRFHXWJxRSA4BJzomzAHl51n8O3h
 SnuIKlA5Mkp9Vecd01RzHi6YMMSbnNDAvWIjghAW9xmKBrFBES9CIkXK8JTPCkcH402a
 p5QP+rkwQAsMTYCXS00lEA0vfe8WcPvQ3rOwV7sV0VjXd2xJ7vruhczciBur8OUamFYl
 0kfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6Up4pD/Hb/p/RUW0kb37GmpjW2URLNKZrMPFjascZJrKZPyR2WN/PzR38sJb97j+nXY6C/ug=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7+zsPPI8+yxb/MkWGErcg1PNOUAfn8mhby9CzAx0ewUQUaiSV
 t6LoVyu2YHnXtuZs73YgERBIUuhr3ZbKN3cF485s6hFM7g7yKr6ojB5D3nqJmCNpKwiuk3sGeJ3
 j
X-Gm-Gg: ASbGncvgSRdOezJhRCWuMHya+xG14xi/HzAoEQxHqpewaraI8v9yMyAZ9ek7K9L+Lbv
 13MgRcLlF38Zk8LJF8Oef8bOXPebhsgn13eK/6kDryPZsLmLwE0HHJFD9GCmoc+ap3jcLtVHG8B
 I6pONSYWjg+Ljg6JuNg358RAE+odp92EcW5Rwe7HFCtob/HA7zFzZSQMf3KYEDslAie/zdwxAhv
 1jp6WlLjCfWgcoUV6mbYuaBd0c5y/GphCu4y/v8+Pv9anrd7EBkCxRhGK686lwzA/JM8U0j5Ko3
 sNdpbyAGGRQw/ystTRu1KB6DRpzZ4GHwgwQCm2UShcyZvKIGQNImN/kYuufDa2tq3w==
X-Google-Smtp-Source: AGHT+IGRXNX6Za2BH6BWwg3DvdIGeQMcaxGt9AwZc/PfTjwQxtC+HqPIcr1JvtECJbY7Z/xPiRFtcw==
X-Received: by 2002:a5d:5983:0:b0:390:ebae:6c18 with SMTP id
 ffacd0b85a97d-39c120db794mr13270429f8f.12.1743602539985; 
 Wed, 02 Apr 2025 07:02:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a433bsm17283130f8f.97.2025.04.02.07.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 07:02:19 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 02 Apr 2025 16:02:17 +0200
Subject: [PATCH] configs: meson64: move DFU step at the end to give the
 board a chance to boot something on storage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-u-boot-meson64-move-dfu-end-v1-1-68399499ee29@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGhD7WcC/x3MQQqDMBAF0KvIrB1Ig5G2VxEX2vzYWZgpiQZBv
 HuDy7d5J2UkQaZ3c1JCkSwaKx5tQ5/vFBew+GqyxjrTGcs7z6obr8ga+45XLWAfdkb0jPkVXIB
 zvXlSHX4JQY57H8br+gOqRAzvbQAAAA==
X-Change-ID: 20250402-u-boot-meson64-move-dfu-end-eb9f5fe55608
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Tzbr/3SfSeAjPtjhGcXeNaM7p5oxwBH000vypFtPQSg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn7UNrlWXYnX4O0ePETy71q2VHSlGRs9xyCTY8dOBf
 PrxU+TaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+1DawAKCRB33NvayMhJ0eaqD/
 9ZA41PwRMKJj0xMNcZtF7NonClsSc+Efp8TiWioyWeXAooIdNkXIObvHPsa3YyBjsPNuBXtT7z3eqQ
 7h4HDks3Eb5psbnTKqwUg0gWxcHfrSuk3brknmEQ182Qq9iN59txG5yXmtu1fB6G2xXLvm6TQI//Hm
 k8Wm8je3qVfL50pYe3kRG6xfYXA189xeIiLx27PIEID7KvLc3qi+rzPQh9mGjMxQLF6A9HfTququ6F
 LWxGiUud6zudVkKgADHnvbbpWb2QuLbqMsYQkS160Kb20qcr4Bda19DVbMX5d9nnl8qQheSA2y6REs
 I0j4BiNBNvOPnHmdILb94eeMb12h0hGbF4iVQ/LIvUrbyjJtcNnTzIEdfcgxYJ+V00Rt7SpqDikUAV
 GBMTWz+pw+xnPDe8AKnHfukRGnkOubCz6qgDM2mhb5CMRh4thCuuYIP0JNJqUoWoU01LueuvA98/sK
 L++P5UuBj90ShUOZvY7zKYekRLjjVD06tAdxI7aVSSd/KxvqJFL7s7AxrT8PXnvxQZTGcgrEXA/uAF
 jgFIqy5ckPzuuixnqkaRgfE++gABHCuGOyZMFs96/1sMKw0IFsrpZbhrmMpFzdL0wbqxj9tRJE3/N9
 tKBQ2SBKPDGyHTirdQzBtW0zhT19y+A+QpnCG4cJhFqchiO5lAjn60UOXKJA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The DFU was set to run at the beginning, but we may want to
boot something over USB, MMC or Ethernet even if booted over
USB, so move the DFU as the final fallback.

This keeps the current Amlogic U-Boot CI working and makes
the default config more generic.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/configs/meson64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index f3275b37a516da6befd41324ddb2a3fe1f36fc83..675df623311f361f3a55971c3894ffbe1d07fee6 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -118,13 +118,13 @@
 #ifndef BOOT_TARGET_DEVICES
 #define BOOT_TARGET_DEVICES(func) \
 	func(ROMUSB, romusb, na)  \
-	func(USB_DFU, usbdfu, na)  \
 	BOOT_TARGET_MMC(func) \
 	BOOT_TARGET_DEVICES_USB(func) \
 	BOOT_TARGET_NVME(func) \
 	BOOT_TARGET_SCSI(func) \
 	BOOT_TARGET_PXE(func) \
-	BOOT_TARGET_DHCP(func)
+	BOOT_TARGET_DHCP(func) \
+	func(USB_DFU, usbdfu, na)
 #endif
 
 #define BOOTM_SIZE		__stringify(0x1700000)

---
base-commit: c17f03a7e93dfbbe5d32f5738274187065d9493f
change-id: 20250402-u-boot-meson64-move-dfu-end-eb9f5fe55608

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

