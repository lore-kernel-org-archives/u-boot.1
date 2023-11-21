Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C090FC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA00787627;
	Tue, 21 Nov 2023 18:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HvhZSmzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2F338761D; Tue, 21 Nov 2023 18:09:34 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48F23875C7
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-407da05f05aso24092505e9.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586570; x=1701191370; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RjqWjGwm0pe7NXs5upe08tBe8v++ugqXzOHduAzt1+4=;
 b=HvhZSmzd7AjYZtdumM9yaDp0K/cHBXB14GXoWmI8vXpLP4bpztQBPX96tM5naQC9p9
 WWe8vip6CygZ3FaCP56WGFIbGh4S2hxNZu8Qo61aZIrB8om8PRkYo/IXxn5hRzSpDMJh
 IWsaDgFawZ91fvqrfR30vZa2f8WK2fXa0KsRsjut9tzVffjewmA+2AIOXHlbt/1o0EhO
 SDqsAM5XjJ2oD+XNoA1k147AUaMPgGioileuuf9oG7vsJGQinexuAt9v/8OWZIPlx0T6
 D3qJiwStosH2qD17zYMrqj4NJFpOsblsN3zlbzsHp8GDxOkRng9QqInQSP86V7PaxX/p
 eh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586570; x=1701191370;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjqWjGwm0pe7NXs5upe08tBe8v++ugqXzOHduAzt1+4=;
 b=WjTsX0Kn0k4R6O7uWJj01BOyYnrEm+wkcClPn8rrSjLW0rJliHtjaMbNIMAGyM7ozU
 YQDhE8FihvrfeZZxgw182QDUQ0uAd9d07OLdmSAvi+xYtPWsvGYC59ZYl83QvBprW0kj
 VucE3A5+cMAzdxNYEx7JaQbnCYfXrvQlNUJ6BpjQy+4a8M1SvMd3ZTyzes0z5qh3FY75
 n+ua8IvPRdfDE77SDPgvwW9ZHFzR8ivIGdWXf2+dxDWR63gq6TjQSmrqPemcJSjuZ+Br
 7A6I1UOG1iIPqNCXQ6WQlvqavKbzrd1rhGiJH5C4T3nhPhzgGCoIBc9IsXbY7nCZUHfU
 UBKA==
X-Gm-Message-State: AOJu0Yy1GN4PZHIy6vwodlOB2kscaPkiTwHxosb5WQ1bOBT0tJJgycXL
 iKR2OgE2/0DN6+6UBXCLBsGnKg==
X-Google-Smtp-Source: AGHT+IHimnqir+n70vPFmji5HSh19NUrbRptOCyCVwiQjSyO8enkdNQxVR1erMlLrKgtg+LUh9JIxA==
X-Received: by 2002:a05:600c:2246:b0:408:3975:e225 with SMTP id
 a6-20020a05600c224600b004083975e225mr9010746wmm.40.1700586569734; 
 Tue, 21 Nov 2023 09:09:29 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:29 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:24 +0000
Subject: [PATCH 01/21] arm: init: export prev_bl_fdt_addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-1-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
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
 Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=02W1reWasTWVELXqu9mEJ1f8u1Mk5o8it70zinvlRPs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ66nHrzsD8nqU4+bnm90yvdTTu2y1N0PG1emfLpW8
 na2IEdoRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIugMM//O90o+lXr5lGpoS
 2Lf0XFzybpbTbwJV3kxSPlkzY5Hp/esMv9n4PR0ZU4sWvPq0PUshoU4kxmACw7wFqVq3VB8+2Ou
 y7SIA
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
This patch has no dependencies

Cc: Simon Glass <sjg@chromium.org>
---
 arch/arm/lib/save_prev_bl_data.c |  5 +++++
 include/init.h                   | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/lib/save_prev_bl_data.c b/arch/arm/lib/save_prev_bl_data.c
index f7b23faf0d66..b286bac9bf00 100644
--- a/arch/arm/lib/save_prev_bl_data.c
+++ b/arch/arm/lib/save_prev_bl_data.c
@@ -45,6 +45,11 @@ bool is_addr_accessible(phys_addr_t addr)
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
diff --git a/include/init.h b/include/init.h
index d57a24fd00dd..7a3ab152b65f 100644
--- a/include/init.h
+++ b/include/init.h
@@ -168,6 +168,17 @@ defined(CONFIG_SAVE_PREV_BL_FDT_ADDR)
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

-- 
2.42.1

