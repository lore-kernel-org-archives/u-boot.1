Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE2AC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 085B387F4A;
	Mon, 26 Feb 2024 18:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bSlKOo1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4FE87F28; Mon, 26 Feb 2024 18:26:28 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB6C587F25
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40fd72f7125so26935505e9.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968383; x=1709573183; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z0hCDiTNri44tvXyNMJaRxomK4RdMAbxwZTo74BYQs4=;
 b=bSlKOo1psLPZIJpm1JevNhA9qO/DFjSQFkF0BEuM0+tNS6q2/Z+PvfFOPxpR9PG2WS
 CPZm2K0vX+YgINIghVOhYoNjiD42Si1HOEV3NC9mJt4guPXjMdO3nKkWEiYJ4kBDh9nG
 sUWXn4KrDmw24utiUAKnw6nBGpOi+1KTEOvTSsoUiOzhQxlBBSm/2Oa7YXVw28DvO+Bn
 vDlSAjzy7F8jw5SLt6LssGLzEEjD9upiv9SWHqGs38oJ0KUEharGVwjt+Z1s/TkHWzCt
 lC1WQw4PACWjKcpWW4JLhCDhNXdEVGmM+4FnxtyqrlegnO+rfPJYqbVcIi34pIK3om+b
 +8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968383; x=1709573183;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0hCDiTNri44tvXyNMJaRxomK4RdMAbxwZTo74BYQs4=;
 b=SbCvumzcpxTKpy+JSrd+CHR3xY0rKsRT3O+UHKwDCvis2WyxIlSeVi9lRgjwJR/JNH
 glqEnfA8MtEK4Q+y4SFToVVfmWYGz5tMw93NeBstDy/fFNqhTzh/brBOD5on4H2YI+9K
 mRheaXy3OkrvrI+RbUjZoPUbAClFJmXIYNXUPpAbvz3sDCARCwSghhrcScpEvpkP4XDa
 XeyoPctB6h4+yl7Xj4+3AWykAWqmCGHkkpl+SC8OHbO6fePynYd3tIbGA5M6/RvMHBDi
 FmdxyYMy6rA844y8Tkm79WyddLRsQfQWgChgPfeK8PX4a/ckko9HdcI/rIkVImQKJSMh
 02xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXTdLTZFTw4B62gd+ni3/i6o37GV85LHTZxflb24Boz0MrpK0cgpeTvnfpnWTzykVdpyqqZEjDJPajmCKyjCqy5FwX4w==
X-Gm-Message-State: AOJu0YxU/KHJj6Vq3PYi2L3GkYI21Gy2fGKr/4kM1M+ezxvyRWJ4hin2
 s432ScRoUDI3DEgt3faUtekQB04lJAir4N+KjydwSZTRAoYdEBmL1mf0oKxh1po=
X-Google-Smtp-Source: AGHT+IFallmb0vCf1MdH36/KNe/mPV/kS4mBz1CLsX+lnXIgqqtVXnD/YZRxuJjFO7QAfpPikR1pUw==
X-Received: by 2002:a5d:658b:0:b0:33d:2848:79b6 with SMTP id
 q11-20020a5d658b000000b0033d284879b6mr5455248wru.45.1708968383203; 
 Mon, 26 Feb 2024 09:26:23 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:22 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:05 +0000
Subject: [PATCH v5 01/39] arm: init: export prev_bl_fdt_addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-1-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2036;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=rDoYKulwRgfSZJ6WGXOQUTKGJ56bse325sV7t1f3MEU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3esPK14X/jBhcQtqU91hLPaO+0L9zPuj3D9ttRSI
 2vLx8n8HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiIe8YGVZ+uGz39oDrV8WD
 MS5SHw7qlL2TK2FJYvTM+p/HH38x7hojw/wSnYK7uleaznC291pOjdIqV1Ze9fHmu55HD7k3f7+
 xVR8A
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

When booting U-Boot on board with a locked down first-stage bootloader,
we emulate the Linux boot header. By passing the U-Boot FDT through this
first-stage bootloader and retrieving it afterwards we can pre-populate
the memory nodes and other info like the KASLR address.

Add a function to export the FDT addr so that boards can use it over the
built-in FDT.

Don't check is_addr_accessible() here because we might not yet have a
valid mem_map if it's going to be populated from the FDT, let the board
do their own validation instead.

Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/lib/save_prev_bl_data.c |  5 +++++
 include/init.h                   | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/lib/save_prev_bl_data.c b/arch/arm/lib/save_prev_bl_data.c
index f7b23faf0d66..b286bac9bf00 100644
--- a/arch/arm/lib/save_prev_bl_data.c
+++ b/arch/arm/lib/save_prev_bl_data.c
@@ -44,8 +44,13 @@ bool is_addr_accessible(phys_addr_t addr)
 
 	return false;
 }
 
+phys_addr_t get_prev_bl_fdt_addr(void)
+{
+	return reg0;
+}
+
 int save_prev_bl_data(void)
 {
 	struct fdt_header *fdt_blob;
 	int node;
diff --git a/include/init.h b/include/init.h
index 9a1951d10a01..630d86729c4e 100644
--- a/include/init.h
+++ b/include/init.h
@@ -167,8 +167,19 @@ defined(CONFIG_SAVE_PREV_BL_FDT_ADDR)
  *
  * Return: 0 if ok; -ENODATA on error
  */
 int save_prev_bl_data(void);
+
+/**
+ * get_prev_bl_fdt_addr - When u-boot is chainloaded, get the address
+ * of the FDT passed by the previous bootloader.
+ *
+ * Return: the address of the FDT passed by the previous bootloader
+ * or 0 if not found.
+ */
+phys_addr_t get_prev_bl_fdt_addr(void);
+#else
+#define get_prev_bl_fdt_addr() 0LLU
 #endif
 
 /**
  * cpu_secondary_init_r() - CPU-specific secondary initialization

-- 
2.43.1

