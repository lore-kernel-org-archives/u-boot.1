Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D440C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB39F889B3;
	Fri, 14 Jun 2024 14:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DJ3hVu+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34BC4889B3; Fri, 14 Jun 2024 14:09:58 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B84A68867C
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ebe40673e8so20169191fa.3
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 05:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718366995; x=1718971795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2IbHdPhio2c3ZIp2NyqYCLKFfMQNvG8zl2EuDFuifuY=;
 b=DJ3hVu+WDJb8kMm5EZC7muQAV4oW94TUkDQWx2sNpiO4nQT3W2x/Exh1lQyF6TFtBk
 ZbMC8peb3dMmyK8PhKiagzSoN4Z9CKuTIcJffAPJR3xSoyjSxMRzFKuqDh1HHCrScMcB
 miRNOTTS8oY78B+4sXFU4rA88xl0twleU4HAfGhrLMMLRxf+pYo/yUaWddurh7qTVJIO
 YCOVuwa9v0fhue3Fp/JDpyoGjIm3UyN1OYkBtvLthZDrgpjpZIWTHatX9Gw5z5EZ/Gm8
 v3SptpWHKG1Qnm6NXkxX5pwi0vhnFy0d2TJd5avUL01pY86qikzMN7Ssm/jlPx+tDLWM
 Ucdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718366995; x=1718971795;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2IbHdPhio2c3ZIp2NyqYCLKFfMQNvG8zl2EuDFuifuY=;
 b=miCH6SBdC25LuXuPz+tCUjGIVGlqf1jnPbf85igonO+TAtAkObEltQQUjG6xmvqBYq
 t85qzdmzud/ibT5AqIjgyjkb6ghdoNOdSxhTxlTIqiZnzI0wiTuL5AxfWTBjMDZAyjjt
 NeXVhQPjqJfNVa9STWn5WxbCcBg5pQE7stzoZ1Y1qWRGZTUdsX/hRwPQmUmxGCDeOn8u
 hx4KeOWseYGouU8+sqmi/VzSYtKHX52Y1L+WU0Ws4T9JU333pPNUeL0j67aaC0PN9Yym
 ARpNLiPLmjeGRXRysIEB7s7Mydc/TEXG8XLSkktBZukE7QSKJ5ld4mmGJ68JWNbWO1Z+
 u/jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZC9sSfmoaISIPvFQQtHa227wwK+NCQEP6kt2yA/Suzza+Syx+sjF3y82GGHIWxS8jinZfaK7rTWVoefmouQB++JPiGw==
X-Gm-Message-State: AOJu0YxqJSJZOAzKYsDVKygi/bkhuIXZpG8MpnKnINxXv5T3BHKr8wge
 V3mn2580T/bFNaa5d36FZq92wIWnRzmL/i7n3a4szmPR++AXKp1X5ZydOfwAvKE=
X-Google-Smtp-Source: AGHT+IEJdjjzAHOOzSjzJ3ZnXaVm2GHKhzsjrx6esPM9OgJQNg8FlHe7rzBRUqfyj8fbUdNWj/iq8Q==
X-Received: by 2002:a2e:a17a:0:b0:2ec:16a6:edc3 with SMTP id
 38308e7fff4ca-2ec16a6f04fmr10854641fa.22.1718366994995; 
 Fri, 14 Jun 2024 05:09:54 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f23cdsm4235595f8f.77.2024.06.14.05.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 05:09:54 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH] tpm: measure DTB in PCR1 instead of PCR0
Date: Fri, 14 Jun 2024 15:09:50 +0300
Message-ID: <20240614120951.16158-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The PC client spec [0], doesn't describe measurements for DTBs. It does
describe what do to for ACPI tables though.

There is a description for ACPI in 3.3.4.1 PCR[0] – SRTM, POST BIOS,
and Embedded Drivers and they explicitly mention ACPI in there. There's
no mention of ACPI in 3.3.4.2 PCR[1] – Host Platform Configuration.

However, in Figure 6 --  PCR Mapping of UEFI Components ACPI is shown
in PCR1. The general description also mentions PCR0 is for code and PCR1
is for data such as ACPI and SMBIOS.

So let's switch over the DTB measurements to PCR1 which seems a better
fit.

[0] https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification

Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 boot/bootm.c              | 2 +-
 lib/efi_loader/efi_tcg2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 6fa8edab021e..3de87eb185d7 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -963,7 +963,7 @@ int bootm_measure(struct bootm_headers *images)
 			goto unmap_initrd;

 		if (IS_ENABLED(CONFIG_MEASURE_DEVICETREE)) {
-			ret = tcg2_measure_data(dev, &elog, 0, images->ft_len,
+			ret = tcg2_measure_data(dev, &elog, 1, images->ft_len,
 						(u8 *)images->ft_addr,
 						EV_TABLE_OF_DEVICES,
 						strlen("dts") + 1,
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 51264c1b998c..a8a54c9f131d 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -1328,7 +1328,7 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb)
 	sha256_update(&hash_ctx, (u8 *)dtb + fdt_off_mem_rsvmap(dtb), rsvmap_size);
 	sha256_finish(&hash_ctx, blob->data + blob->blob_description_size);

-	ret = measure_event(dev, 0, EV_POST_CODE, event_size, (u8 *)blob);
+	ret = measure_event(dev, 1, EV_POST_CODE, event_size, (u8 *)blob);

 	free(blob);
 	return ret;
--
2.45.1

