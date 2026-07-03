Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5BAC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 12:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EFBB849F6;
	Fri,  3 Jul 2026 14:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jGxZ55e2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B66E84A30; Fri,  3 Jul 2026 14:40:50 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22ED6849F3
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 14:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493be1b9564so3719675e9.2
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 05:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783082447; x=1783687247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zZvNUQTLpfVg+ZFbKrMHHc/gMWBQ/P4+M5+CBBccPEI=;
 b=jGxZ55e2BhFzTNZ4bL8mw+azBBky7fJyixHHTZuep6Qgkuh3pQ5Vyb52MDBUTCW5z5
 XrwjdE0Ip4s60A6iirZD0wtXIvWNBnlyXE20Axmj46u/I1wr2lFV5TEOXYVzAA9BOtSU
 M96Wlp6ZZutrMu4kVAs+vgMWbKyHBKotTJOI4yNw8M8z7Q3OYruLRExvucWH2c1WcKoN
 /iukpGoNd/4hAfkkQ0BAK6b9Cbm62cSjvBMNfZF+IEgzsZ0AfpbUH9ej5z3znT6Fvy52
 WRUnqKynvzdcjnzw3BtIrO098eWk02Gtyr84epjVSlAPZKEYXP3fTnmads9vHh438+C7
 igNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783082447; x=1783687247;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zZvNUQTLpfVg+ZFbKrMHHc/gMWBQ/P4+M5+CBBccPEI=;
 b=FimLtDwl7mNtzDKQHdTsqEHOY6MpgKeoAiYHgBoVf+5tad1ti9oyDVfG9CfAB08X2e
 8gkRb6z1c+r6G2hllDzmoYXSaVG0XogcN+35+o/D46zTsmZKMg1FJS02Ys7qxqeZZiiw
 BGfToyfLkXcn6pwrWnDJlM7OEZR6SeYmGL9TQZqA76jdXluqUXunDH5fBndU8mbK5XuA
 N7VcZWnoEWmJ6ta0I+EYA//O22xRpPAKjR065AWE0eKH0Z4IWHhtvYlFw07cFC19r1d0
 a05bBLfsPX6Qfcm3lPv2ygcTygHhByKN3yFMaraWuJJbG/4uJU1IyV/56ISyyuQ7GH2U
 VPaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8x70LzRunRWl2SPGYD4eACoHLKHIEX/8wl5j+2zh3wSs8Cc3zjvSkvTnfCBzSLprWSnF8C7pg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyh8g7hJ7u8kUb8YuojZvpHDmEZ+H2VqJMJE4Z8la8wcJauKukI
 puZrw2b6UB1wVYnR4LqY5mJEGg5TQskMtfU/VABOBrtjcmrJDsULHX3c8Be2rh1Vwtk=
X-Gm-Gg: AfdE7cnoNa2+bo8cZvtIssKZaay4McVABmFONRpdiO2mUKQR6Urjd4Ye19hfBYRRUkR
 SkVSWBig4LmsTaUS16sIOyGuExA9CZDlkQIPw9BUzRIUOnFQylDj/vd4RSho0mS4zrGdm0Jq3e+
 BZDzzIJ323vIkRqOkSfWBg+9HwF7iTgzbDinH4rTHr4VC6Gk5hY8w1w4ImKEVwuC3K7nNdpMqFy
 D8aHLSWa2EhUSOIkZ0cQIVfmx1oeLeaoVIPruGD6i0vLnxXBUshFsQFd0ocSYpBILFDspu6nyv6
 b7/1yN/zB4eBvO7m8Yl547XJAInLTP+f+naWoOiFsTv28LrQ/jp+eOG7a0EsffFy3ODvacwGCqT
 gPF2iCzUH0dRytx17Nz3bh3Bhgg5dzG879JkZn2ANEZaLIdPsAjrf7wxbWDCaOwWN5abPmfp67r
 47CGPvpSLauEzPF0OdB/DjLDUVLArAPGb9090Y0xgXur9eK+zo81bFE6u7Be4RbP8aDLjpvqxpt
 2bOPfzak8yLkGQGOkdNj6wpPCisJni1QOLySXllbzMvEe8ra8gmX1unbVMsXi6Y1+Ev4h5NIt84
 IRg3fDrmH/h4sd/qnC+M/He/CvVqoqd0HwWepw/geiuaOX/Lgl0ou3ThQuhipuxHNR/Dw1HRTC5
 FIdJpTMa5cy7IPYN9VRpmrcbklbwp3vPJucM/a7JglmpFfpHRXQ1OXQcKxnVG5G+U0579GrpX4t
 VxQ22wA3bvFzZjVCtWpwut+M4tp5rD0kEty4UYeD8+kR7H3Hrq8Op9GH9LlE+SMruy1TpylaJrd
 tGCT2r4GBU2meg=
X-Received: by 2002:a05:600c:5292:b0:492:3754:15f2 with SMTP id
 5b1f17b1804b1-493c3cfbc7amr138145005e9.32.1783082447546; 
 Fri, 03 Jul 2026 05:40:47 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bfe616f5sm131612525e9.1.2026.07.03.05.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 05:40:47 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Correctly count the size on DTB measurements
Date: Fri,  3 Jul 2026 15:40:28 +0300
Message-ID: <20260703124029.91624-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
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

When doing a sha256_update() for the measured DT, the size arguments for
fdt_size_dt_struct() and fdt_size_dt_strings() are inversed.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_tcg2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 1860dc502387..1d52a04ca48f 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -1343,8 +1343,8 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb)
 	header = dtb;
 	sha256_starts(&hash_ctx);
 	sha256_update(&hash_ctx, (u8 *)header, sizeof(struct fdt_header));
-	sha256_update(&hash_ctx, (u8 *)dtb + fdt_off_dt_struct(dtb), fdt_size_dt_strings(dtb));
-	sha256_update(&hash_ctx, (u8 *)dtb + fdt_off_dt_strings(dtb), fdt_size_dt_struct(dtb));
+	sha256_update(&hash_ctx, (u8 *)dtb + fdt_off_dt_struct(dtb), fdt_size_dt_struct(dtb));
+	sha256_update(&hash_ctx, (u8 *)dtb + fdt_off_dt_strings(dtb), fdt_size_dt_strings(dtb));
 	sha256_update(&hash_ctx, (u8 *)dtb + fdt_off_mem_rsvmap(dtb), rsvmap_size);
 	sha256_finish(&hash_ctx, blob->data + blob->blob_description_size);
 
-- 
2.53.0

