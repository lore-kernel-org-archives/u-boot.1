Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15019C83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 14:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60179831C5;
	Mon, 21 Jul 2025 16:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FM2h9Uti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8FB6831D3; Mon, 21 Jul 2025 16:43:39 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68DD1831B5
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 16:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4561a4a8bf2so49041005e9.1
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753109017; x=1753713817; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oP1SkVGGbNDIZbDYhYKk+QkZsiHAeTefZRv+4X/fhhY=;
 b=FM2h9Uti6vQIF2PxEL2n6d7ZZGQSIARfcHPkAvb5C9/dvNK3q35y1tya3TzXDk1SNm
 DHCm19w8WnTkSks5YToo5cBkK0ddoVZL+YR8nTETDDeXLR0Zpf3+24oyB73Ym3P3YCjb
 GjtzuuRNQUtQ//HelRguU6U7EAMsKAW7ouCdnDzPQa6FJ8a6fc8x2wV+V+ecXaF6FVrH
 CmjEWVHMz7t+tTq0i8l9cKwtPeMtQAbTguxqUMx/bDiu9+9/9rFgRRGEQnXH2k4fZC9a
 5GSmyUUjhhMtKn4kqOHemitk36em8B0ldUdKYAYXBCICMf443l98krIoOALo2R1P0iVo
 xKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753109017; x=1753713817;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oP1SkVGGbNDIZbDYhYKk+QkZsiHAeTefZRv+4X/fhhY=;
 b=VxsxYVzBW01fTQevfTLYj2IQIhHVQon5XLu4+RuFyuYJIyhjAYqnh4JxaZlp5cuzE/
 WoTk+owectlec5ZJNtz3pTJfsE1AzINbvbSzGfpVXSe/z1Mhs/JVMnWQ2DGVt0HeDG8x
 dTnSM4SYWAbNaT+eLfWQUPPGBUqMDZjTJpTUwi4GT1hZdth7ki1Z2b9pMnxjex7ZUJaU
 dk2VEEy7jMXnLTS4khr+Kx28Q5ms4n4RwYcKzXPyWTb60GVNVE5iIg3/JgsCisjVY+uR
 vmdJcrGDySLFLwCQNCL61BMa6pHToTYRF+Jd1tZZsM+/sG57YBZ/8Al4+8a8763s6Uih
 awYw==
X-Gm-Message-State: AOJu0Yzdkfp6j0HTaONsMHeWz3GCJpeXP7+imqdSpaq+D+0tdfvXz+UP
 0aVRc2XXAu6F3gfJ18dq1ogMwT8UhGc+OdmtcVoxWi0fVHlVX84rYeCgNcmebBta1TIgcdMXu3d
 IoG1s
X-Gm-Gg: ASbGncvSjsVIjis+Pek49Tpf/m/u0aNa8uzLSF133UJn2Q8bt9NyzGXHlxL4uFe0foM
 1bjmVupz6lTyHSGmpIG2FFfL0B5WFf2ViifQwqQhzmztg+r7yVrfBcjaJhwzHBh3r75PmIW+8it
 ETLBLMe3r6iCsGMs3BUaG47xHvlWA6h3oUNXjMjCWB7jI4pl3tkAEJDLIfnahkOuQEdUxl3sYF1
 UBegKNatzoLRoSB1ubZmfnxwVeDA4u3dUUs0PPOlFrVg0zsJaeJjf4ty4lHpFMyiaiyHzoOh1xF
 cbCldW9KDiKFizy4n1POXoZy6DndUm4vibh6777w7+LQh7TvHxQgENF5ZOMsvuIuOpwx/c7eFzs
 oXie2fK7evsqHX0KWGwxK5A+6RMB/HuT2/Um5AM5yJZ9JxF6dE7M=
X-Google-Smtp-Source: AGHT+IEMzmtTCpwzqVfbcTTl0C3RgywiomEsOzUog5XEZgqW3+HsrzHwZVhBYLpPuUlZEKflAkYhbQ==
X-Received: by 2002:a05:600c:4ed3:b0:456:1a69:94fb with SMTP id
 5b1f17b1804b1-4562e33d914mr194923165e9.13.1753109016589; 
 Mon, 21 Jul 2025 07:43:36 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:eb9:1701:2d55:8dae:7c0e:23c4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e8860cdsm166070455e9.20.2025.07.21.07.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 07:43:36 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 21 Jul 2025 15:43:36 +0100
Subject: [PATCH] cmd: elf: Prevent possible buffer overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-elfboot-v1-1-00b431844e3b@linaro.org>
X-B4-Tracking: v=1; b=H4sIABdSfmgC/x2NwQrCMBAFf6Xs2UAStUV/RXrYxFe7oInsFhFK/
 93U4zADs5JBBUbXbiXFR0xqaRAOHeWZywNO7o0p+nj2QwwOzynVujgPzqG/HOOpH6jViQ0uKZc
 87/2LbYHu4q2Y5Ptf3MZt+wEIToabcgAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In do_bootvx the environment variable 'bootdev' is fetched and copied
into a buffer without confirming that it will not overflow that buffer.
Use strlcpy to ensure that the buffer will not be overflowed.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 cmd/elf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/cmd/elf.c b/cmd/elf.c
index 5e0ee30a7c8..53ec193aaa6 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -21,6 +21,8 @@
 #include <linux/linkage.h>
 #endif
 
+#define BOOTLINE_BUF_LEN 128
+
 /* Interpreter command to boot an arbitrary ELF image from memory */
 int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
@@ -114,7 +116,7 @@ int do_bootvx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	unsigned long bootaddr = 0; /* Address to put the bootline */
 	char *bootline; /* Text of the bootline */
 	char *tmp; /* Temporary char pointer */
-	char build_buf[128]; /* Buffer for building the bootline */
+	char build_buf[BOOTLINE_BUF_LEN]; /* Buffer for building the bootline */
 	int ptr = 0;
 #ifdef CONFIG_X86
 	ulong base;
@@ -226,7 +228,7 @@ int do_bootvx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (!bootline) {
 		tmp = env_get("bootdev");
 		if (tmp) {
-			strcpy(build_buf, tmp);
+			strlcpy(build_buf, tmp, BOOTLINE_BUF_LEN);
 			ptr = strlen(tmp);
 		} else {
 			printf("## VxWorks boot device not specified\n");

---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250721-elfboot-0eac16932467

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

