Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24933C19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D9E4812D9;
	Thu,  6 Mar 2025 01:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oMD4H4TB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F6B38141D; Thu,  6 Mar 2025 01:26:48 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 368AB81253
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-85b0180631fso3447639f.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220802; x=1741825602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2dPYjJ6QVbmboFenCL5sEPEiJUJ0lVwRBbY3v33Ozg=;
 b=oMD4H4TBObP5jgRUuK6OtcT5YQ/qPty3BkFpvs8+oOcS7Okx9E1/zzoZ7m4WuVuiNt
 /uyrlz9DkxERyqU8VVr0itijNMlU9ETZU3iiC1ZXi3skPNLgQeRnT+kUf66ezPQwsf6s
 iMnmGC5sQtv8SNbvKqBoaC2prEpyPoU/JgQ2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220802; x=1741825602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2dPYjJ6QVbmboFenCL5sEPEiJUJ0lVwRBbY3v33Ozg=;
 b=NcfOFtOnNTYK1U70JtziJ8Ftzzyq1K9waZKpQAh7H8ZR4rPSS4t0PrF06uU7sBjLwQ
 gSTdEesmWBTOUTLZ62Q5MAcq6AcmBgV05DHNajh6NGP4zfHe+PwxiqrbqL5qvlzuFF9w
 FcBWpnVln38sCamz1TyMWuWaaZmx+HADb/bTyD1fZ9Y+tJuD8BqpRqUBjhpOonNiNb47
 +IO3jqCQE63H0XeKzN8pJIeizN/ccVpPjLUL4T0zleKhpF5aeHitpV1NmQeKQUQFqpOe
 So4xMWZ9l8H1DGXK/gwrQLWamAu/hJCt30eAKKCELEJ43Nocaz+gZDHoRsVHaihhMnbl
 XVOQ==
X-Gm-Message-State: AOJu0YzpRxSoEFWCIM51wC/cMoz3xMv5rSyHYg0lcpoeowhRW5HZlZzB
 Q+IGfV5AJRAs3rRmCMznjehoTyuyJ+u6edKGWYU6JexBATc7skh/HjJ1Irf+WWd8qZbgM8xbRB4
 =
X-Gm-Gg: ASbGncs0P4vjrvNUUz9iO48Bp0EEdQfXwSB8F75ArFJksROfl4Ax4Qv+SpiQEaaGHmp
 WSR07MeqklqiPLQ6fU1nwoMmHuxFP7M/hTRqmtKEUwaj3Y73T4XD+w6JG1xJG584VDIWiBu2B9G
 ZlfmCEc3nwsCiGFSn6WJg29BUntio0D4xnix3OOUDWELJlPMfB8N6P3U1XHofWxGAVkCgQTlpMx
 uWJcos+RVD+d+e/h78bT6i/m1btYDCDUEt8OQFv40wf1JVHPvPw62o0zG9litxA2kMg5wKjFc7L
 Yl0h9OYgqzLh8P71zrK6xjWOuKra29H3EPINOzCADa2pue2YShxSrfdVbHjLBBn5ndkibUzgGtc
 bOS6f7g==
X-Google-Smtp-Source: AGHT+IF0BhqBYpByQiEkg5yEgH3FLKxCmTH8wBa3hm9K5tZXsFcHuK1zRoTIfw1rXy5VDuHCuOcmVg==
X-Received: by 2002:a05:6602:2769:b0:855:5e3a:e56b with SMTP id
 ca18e2360f4ac-85affba0bacmr584356539f.12.1741220801898; 
 Wed, 05 Mar 2025 16:26:41 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:26:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v5 07/29] bootstd: Correct display of kernel version
Date: Wed,  5 Mar 2025 17:25:01 -0700
Message-ID: <20250306002533.2380866-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

The address of the bzImage is not recorded in the bootflow, so we cannot
actually locate the version at present. Handle this case, to avoid
showing invalid data.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/zimage.c | 13 ++++++++-----
 cmd/bootflow.c        |  2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 7f4b117b403..d71285e71d9 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -558,7 +558,6 @@ void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
 		 bool show_cmdline)
 {
 	struct setup_header *hdr;
-	const char *version;
 	int i;
 
 	printf("Setup located at %p:\n\n", base_ptr);
@@ -595,10 +594,14 @@ void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
 	print_num("Real mode switch", hdr->realmode_swtch);
 	print_num("Start sys seg", hdr->start_sys_seg);
 	print_num("Kernel version", hdr->kernel_version);
-	version = zimage_get_kernel_version(base_ptr,
-					    (void *)bmi->bzimage_addr);
-	if (version)
-		printf("   @%p: %s\n", version, version);
+	if (bmi->bzimage_addr) {
+		const char *version;
+
+		version = zimage_get_kernel_version(base_ptr,
+						    (void *)bmi->bzimage_addr);
+		if (version)
+			printf("   @%p: %s\n", version, version);
+	}
 	print_num("Type of loader", hdr->type_of_loader);
 	show_loader(hdr);
 	print_num("Load flags", hdr->loadflags);
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 72b06a42e4d..da17fd93b8b 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -383,6 +383,8 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		struct bootm_info bmi;
 
 		bootm_init(&bmi);
+		/* we don't know this at present */
+		bootm_x86_set(&bmi, bzimage_addr, 0);
 		zimage_dump(&bmi, bflow->x86_setup, false);
 
 		return 0;
-- 
2.43.0

