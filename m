Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84B0CF6D28
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 14:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC27989034;
	Wed,  2 Oct 2024 16:39:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WesUoDMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 805C8890F3; Wed,  2 Oct 2024 16:39:41 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1E7E890CE
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 16:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cd46f3a26so55310675e9.2
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727879978; x=1728484778; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kw110bgQIB++mEZ/IhsEoAMkwIQOj/pRBnQftJzGOqk=;
 b=WesUoDMY3K30sWUQGG+OvFNWSpuKn5mhUvN7h2da81QaA3T2JBgHPF5LhXsLuvRwKR
 ZiEgozRIQk2rWn2Qidkv1eNvced1U86Nt2Jz+jWyKqGIr1ca/9cr8UDqhOmf8Rf+dM51
 WABrDtfg28kaSi6QKRZDZbdYo1jMS+mATQkrcmPPIU4n9pAbMQt2Gi70sJ1qUY4zfZIf
 1JJYM2bf6ybUlUg8Q89tQoJx+m7O0p0W5TR0DTsDQVRodlSq5afvME22GPwO98wlM8at
 YVf17tIe3qRN5SSJfc/IgWDH+4f/AYXGIcZGdoXb8pzEMxtdAtFwfAg1KrtA9r/mvHQj
 8wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727879978; x=1728484778;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kw110bgQIB++mEZ/IhsEoAMkwIQOj/pRBnQftJzGOqk=;
 b=wzjHa3FuwaVzRA7B5AhWwhNa668GtDXBkWKXPxlQls2cFLFHHndYnodtHWnLwdqMy/
 PfhmtRdRqVcQ23994Z4pXeGf0CMaCJZQZKx7INRTgq52FDb7J++MGabXLVqu0Nht7vmL
 iz0KUNquQi8ZMrtOJXvzyrePctpKYtwNNISFb8GujXGBxh2Qf9WJivvss9gk58vyYJO4
 zTH31JqcqSmyQnmMm9IbhCSVBDpnDJKjgt1Si/zslRmVs2oU7trWzIW0lLPxdu0KNKz+
 sVTwLjSgripLjOSlelcDGy8avY8J1CG+uWm78qTITKzfZa3eTczg136zbnTQ/Xz69r1f
 Fjag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAXMNMgRtMowzV6m4rI9I1mTxHLYmuYSZb/1N8+5dZJ4ji2gpDNz+X42LBVG7qwYTMm7toVgc=@lists.denx.de
X-Gm-Message-State: AOJu0YzdE9q0tNit5vcqU/9FSf5OULIlL6h/Mp+ueR7xtv/MwCSmpD3+
 F4Vih4smtxrqNtEzCdVfdjb20s4rVQFNpFlAp9acJQdO3qCypJJFtAdLZMIJelU=
X-Google-Smtp-Source: AGHT+IHaCo7KnIIYzC5zjoVW7e/TAKzY3txwz2SYHgvUr7a08ELVpYIeRoXKMXWvSYonHTk1aF68PQ==
X-Received: by 2002:a05:600c:4454:b0:42f:68e8:d874 with SMTP id
 5b1f17b1804b1-42f778fa3c7mr23965155e9.31.1727879978166; 
 Wed, 02 Oct 2024 07:39:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e65c3sm14056083f8f.60.2024.10.02.07.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 07:39:37 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 02 Oct 2024 16:39:33 +0200
Subject: [PATCH v3 2/3] usb: dwc3: fix dcache flush range calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-2-5398088ef93c@linaro.org>
References: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-0-5398088ef93c@linaro.org>
In-Reply-To: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-0-5398088ef93c@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1510;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=y5L/ah81b52wg2BmUIBDjC9IK51neBebBKPXX2bS1kY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm/VsncgLj8ZE6ED+Md4TtA91Kn2hdkE1XO7lhZWvK
 WjJbWUqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZv1bJwAKCRB33NvayMhJ0XQOD/
 4zFItGtjvmgfMrc4tdNBqGcrgt3ca2zr57HvavxIadd8tHujqtoqxaWHHqCjIO0gvg+9fAC8lDmns2
 6vCEmMsGJlLEtjztYRJGYQvRdcvqetzdwPAUGLdRWvM4TM22+m8DEFdP7fhAHbFVJFufvr+pAFQySc
 2Kky04jHSJry+UhYSyTbQHPUTtXpCW7JGxlk7ScS8w0O5Y0bwRgdjk60eOICT66y3cRoZSoDErfIjb
 yLh3mzOZPYznEEyjfQSeq1Y7dSvedjuatxdXZtTf+LpHp/tBU/XMhtlO2d/fFL8RxDromOF3l25z0a
 5pEQ93lGtnzeNZEpACPJ+W13n+YBlkIB3IljXCldt8+YN78fw1nWo0/lSt6JS+6GnmwsKKJPC1/lmM
 HOyRyVy4yilAf0iwkNEOoV6zwGale+3HXuOmBIJl9Ao++xFx1szK1jWTjoQAhMN5hdndptsG0SlgNU
 dgsDuXYK5UNRQC9G7buIjRRMcDyc/rqfnchmnei3w3R/06TbBYuXUXvTklNlUij+kEuILjv9c/e0VW
 4lZE6c1Zll6TioiQQTBNCwaDTHHFfCQDlMvYkDTO+YFeA4BoauucBJgN1qMpwEI80/wZoPn+J0RE8m
 POM5wPmbnoT3pX4oGklZwqarSJTuI1e0xhnILhc3pzQrFSUrngHtLzdzcKnQ==
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

Remove CACHELINE_SIZE which was the same as DMA_MINALIGN.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/dwc3/io.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 04791d4c9be..a6c2bb0f47d 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -20,7 +20,6 @@
 #include <cpu_func.h>
 #include <asm/io.h>
 
-#define	CACHELINE_SIZE		CONFIG_SYS_CACHELINE_SIZE
 static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 {
 	unsigned long offs = offset - DWC3_GLOBALS_REGS_START;
@@ -50,6 +49,9 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
 
 static inline void dwc3_flush_cache(uintptr_t addr, int length)
 {
-	flush_dcache_range(addr, addr + ROUND(length, CACHELINE_SIZE));
+	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, ARCH_DMA_MINALIGN);
+
+	flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
 }
 #endif /* __DRIVERS_USB_DWC3_IO_H */

-- 
2.34.1

