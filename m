Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42498C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 13:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4584288BCB;
	Fri, 19 Jul 2024 15:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EkhyiP/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48B0F88B8D; Fri, 19 Jul 2024 15:57:01 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6584188BC7
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 15:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4279c924ca7so12850715e9.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721397417; x=1722002217; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i+jRIalvS5muc88dIbat7gIg4Q1A2Ra7DzoF/oDb6nU=;
 b=EkhyiP/nMy6dhwlsfiZRmt4d4YhOKpp4gkxVL6HGYY37jdHd71381o5ROy9WR/qYA2
 DwI7K6hIjfPzf3IAXkQonEMXh1PYvwusaruMGdj2UXbnEu760upy8X7DVeHkKehCunBu
 VfRZXSuEH4uDvo2eJkTpYvp7DGHSFuamvvlBcwZWIUKg2697evqcM6680JiwsB1m7QO7
 qXs4xYhdNHA+Z1yxfObIzG7Zoqgy7lpe9azQ9VKvBtxJb6E9pLqscqn7zVFYYlwttTO1
 8PTqIuoua6tbd2I+DZLdxnZrnEID9f1EzmStdUN08USTafz4XoAcykQBVXFcQg8gp609
 MW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721397417; x=1722002217;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+jRIalvS5muc88dIbat7gIg4Q1A2Ra7DzoF/oDb6nU=;
 b=rVaGc8BSJH3VYpqi72TErgFkE9l5Ceez6sLOCd0/WgcdkyLFZqDxnmmTVjoctuIlyK
 63lwp3MyuDKWwh4sN146btUEuxonrI+0KFpOaM9S5N2YhDAwMvmMblBR3W2x7PcEKWrG
 6Q2ZRH/0agGdI8qcSFzAsrOwCbTUvlG5Jkthl005obCOFgZQbNzHVKft7pSWNsmCHcE7
 H097OlhSKMI7ZHFEI6Kitt7xwpjA1GYxr4DXZ/bsZ/y76cJ/i7QLf/s+QFEInHkhWVnD
 6p8tVVqd8x9iDSE3bIR6ODiwl7VwZjhTivMYSVUM5+NX9EojT1O6CpNVo57DLyqr60l/
 Hy1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR4I4xEd5GDwpyeHLnGNcKLl69nodJU0FwjCYsp4xRZjODgkAYxGTfwPRGQ44TX4Iz8pWg4ANIBFItIQBW9VFkc7JplQ==
X-Gm-Message-State: AOJu0Yz7/RwT3XN7Cca6Zl0RtM+JL6QUOH786/XtGg2PnOpC7gH/qTzV
 rN1gVvoHE+vAMBd4OCQ3bXgRQ2BVVgPqb8JXA2ei22zwfUQwwsIa0OoitGn3d50=
X-Google-Smtp-Source: AGHT+IHSMwakYGB9/5KVUlOWqws4/Gff+CEsx+WhJfyFumDdJ8AYGvpHdE0KrIjFPMSOSaQnsC5PPw==
X-Received: by 2002:a5d:4c8e:0:b0:368:31c7:19d3 with SMTP id
 ffacd0b85a97d-36831c72a22mr4681547f8f.9.1721397416289; 
 Fri, 19 Jul 2024 06:56:56 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868bc21sm1694083f8f.39.2024.07.19.06.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 06:56:55 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 19 Jul 2024 15:56:51 +0200
Subject: [PATCH 2/3] usb: dwc3: fix dcache flush range calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-2-58a5f026ea8e@linaro.org>
References: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-0-58a5f026ea8e@linaro.org>
In-Reply-To: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-0-58a5f026ea8e@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=kh4rtOL6KeUvZru5sLtHZtD07pAad6NFUjKXTJm+qDc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmmnClPPG/Fg9c6HqnGAbU3NOHqXuMzkT+XVYeFAfF
 bSfTPJGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZppwpQAKCRB33NvayMhJ0Y3sEA
 CVFcj2sDoJHJIuKiiCDOwm2HfJ/xEIjAqoiZ9UFFgegJjWBWvWHgvkLP2t9hf3oRIMeV9Ifq0CkXyx
 iAsGxXjqjSuyvzKC0s7JORHI11qqWvICHEIfvuqfVnkNsyX8dZZ42VZA/u01sKF1hR+dY9UWQylvgC
 FzyDUI1q7ZtyhL0qVHnRFsjHgS4BPaHsYXoDYku+rrbSEewXB0X/oDlYX5JBDSDwEk2aM/nSOjm8vz
 EgSCREGm/uX3OfdY8MpbqbSFF8rkLAsqsrzGxMVYA1izmevlztjxwbIFjFktyZ6secS+pDAbHKsKvl
 sKiaAJc9EGpowHdfS+YBBxcRpmQ//MoHts5zaxmM+oiJY1ds4s4UpGBQH6YoyfvgPka7H9xOGr0vvt
 n/YPk9jL1KKgcruDyyfshQTylnuDGUXpDYbxui6CQ3sRDedNFWMWir1PMBlWE9712SVc2YWkbQLIE2
 lR56Ivp/A+z+k4Msrypy7ObTaKR4KZ+gMRE8LwNdZbSak8qhxFW8ciKrPwZ+BCz/oGECXpaT7M8zs8
 VntXCS/LfYuWsl9R3wULTraYYcAPjb3eAmulIiju/8l/47y9hy01pPsxBVUktyAhS/cGtLtnoaLKKB
 9zj9MFLlAVLHhgPpTbmJKOWcbORorS1k/4RIMXQsuFCFc2PQJFU/Q9nlcXUQ==
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

The current flush operation will omit doing a flush/invalidate on
the first and last bytes if the base address and size are not aligned
with DMA_MINALIGN.

This causes operation failures Qualcomm platforms.

Take in account the alignment and size of the buffer and also
flush the previous and last cacheline.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/dwc3/io.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 04791d4c9be..1aaf5413c6d 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -50,6 +50,9 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
 
 static inline void dwc3_flush_cache(uintptr_t addr, int length)
 {
-	flush_dcache_range(addr, addr + ROUND(length, CACHELINE_SIZE));
+	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, ARCH_DMA_MINALIGN);
+
+	flush_dcache_range(start_addr, end_addr);
 }
 #endif /* __DRIVERS_USB_DWC3_IO_H */

-- 
2.34.1

