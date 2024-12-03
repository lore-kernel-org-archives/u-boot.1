Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F048E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B50B896AF;
	Wed,  4 Dec 2024 00:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gNL0r7KR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07B2C89686; Wed,  4 Dec 2024 00:46:51 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFEE8896C3
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:46:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-84435dbda4bso13738839f.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269607; x=1733874407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OEaE1fphclgQDqzpnHdWb6ml0j7J3NisLCZD8sOxWfU=;
 b=gNL0r7KRkuTsrHvIc5kX/oTG1/mpNjU5QnYub2W9IW6sj86i7RMGCCxagT8I2trAF8
 l3FpPlq2KGUn9iacXksnv6nOd6w4MYXUhSff8vu/iLRMjNioozB49a5kpkByKENOuI+9
 oQvhV1qNTRwq6AMz1OeDJB7QbE4E7iJPamm/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269607; x=1733874407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OEaE1fphclgQDqzpnHdWb6ml0j7J3NisLCZD8sOxWfU=;
 b=kyJwYpEZQ8JcaGDVpawKCUEsUegf8+JlNlNAizjutjLuX8Dz824WdQLw+K1DVVVTbz
 3fL78Rlk5fVjoCucBWHhrstl5UckPxXilwHJvYIV00OSRgVs0DoA3zXsneVuBMzkaaaz
 a9HSM0KBgK5eGivnHE760IDVXsTBngjG2IlYasnfty2V9ycubcKCZfxPGPYLCW3/cvy9
 Akzr8gCl0Dx5bMLzyayydvXXTYjvqIEwNXIfbIb2bqKL4cqq1+4bwJHA/Fo+HFixAfTm
 8SpO6kVB1axtKpBU72g2GjhGeBM4aUfOHckTv6bzk6LNaUAR9x9Eo/NWKmbka8p+XD+I
 5Pug==
X-Gm-Message-State: AOJu0Yy4IgQTitgLYaewK+7bGlsVhf0dcyQ1qWiZoyG41oYbgnX7MRkl
 kt4w3gjevqaGXVK8K+KD1O24ERlHN+y4GuTOl+1jrzSQ0GJZiIUWugMAqQRaaF7SUvMYVyyQEbw
 =
X-Gm-Gg: ASbGncsXB/lWXDoX3qNehpKmbaIasLllActMWzfmNFW7JmENqy+tu6lS71HM3pD+IvU
 16H6na2/ILsRyDpPGkIEKRI+Vf4+CeKs7qxkghuLf27yPqJyXjoVFuWX4AN6poIVMMoPgFnDfHO
 nibDYg2eL9XoICQjaTL1rUZVtvzrHnlqCXsmYKVC8AyJiZIo1z+bFFMG28OvIHEVZh4ws6wboEL
 A4szX5x6j7UeE9POCODv9DOdqQOA6VZxRDPP9VTKjgSlSO2Y4a4z9/rFNvQW45l7qQhM/mtgqxh
 93PGeRpWIxw=
X-Google-Smtp-Source: AGHT+IEk/KUzWFsEILCgewP1UOq0w66cPXHJzI+GYt12+7327Cu5foGnAF9G+6L+17PY+PznzgL2mA==
X-Received: by 2002:a05:6602:1690:b0:7f6:8489:2679 with SMTP id
 ca18e2360f4ac-8445c1812aemr394838439f.8.1733269607105; 
 Tue, 03 Dec 2024 15:46:47 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 13/41] bootm: Allow building bootm.c without
 CONFIG_SYS_BOOTM_LEN
Date: Tue,  3 Dec 2024 16:45:31 -0700
Message-Id: <20241203234559.2938192-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

This code cannot be compiled by boards which don't have this option. Add
an accessor in the header file to avoid another #ifdef

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 boot/bootm.c    | 8 ++++----
 include/bootm.h | 8 ++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 16a43d519a8..0a1040ef923 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -633,11 +633,11 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	load_buf = map_sysmem(load, 0);
 	image_buf = map_sysmem(os.image_start, image_len);
 	err = image_decomp(os.comp, load, os.image_start, os.type,
-			   load_buf, image_buf, image_len,
-			   CONFIG_SYS_BOOTM_LEN, &load_end);
+			   load_buf, image_buf, image_len, bootm_len(),
+			   &load_end);
 	if (err) {
-		err = handle_decomp_error(os.comp, load_end - load,
-					  CONFIG_SYS_BOOTM_LEN, err);
+		err = handle_decomp_error(os.comp, load_end - load, bootm_len(),
+					  err);
 		bootstage_error(BOOTSTAGE_ID_DECOMP_IMAGE);
 		return err;
 	}
diff --git a/include/bootm.h b/include/bootm.h
index c471615b08c..d174f18ac18 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -89,6 +89,14 @@ struct bootm_info {
 #define bootm_x86_set(_bmi, _field, _val)
 #endif
 
+static inline ulong bootm_len(void)
+{
+#ifdef CONFIG_SYS_BOOTM_LEN
+	return CONFIG_SYS_BOOTM_LEN;
+#endif
+	return 0;
+}
+
 /**
  * bootm_init() - Set up a bootm_info struct with useful defaults
  *
-- 
2.34.1

