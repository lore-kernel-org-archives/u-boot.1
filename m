Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2917FE77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C726589696;
	Wed,  4 Dec 2024 00:46:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DZOlAWgT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A93896B9; Wed,  4 Dec 2024 00:46:33 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE92588F55
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-84194e90c0fso390009539f.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269590; x=1733874390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iE/ALBq6nkn1t/ePNsMu0Kga7vDUwmojevVesuygxq8=;
 b=DZOlAWgT3PoPL1WXY66Rzdsb1ZcFLgy4/+XbSGiFfGL7Cz+xxsXbN7OTetsVHiMfOY
 7FJU1Bjamhlgs/aejCtyrT4rlvW2lcWuOXrm9aBlnFJr1n21AyqeDV6SzUWTJWOyGJT6
 lxhK1+JaHH/ikzqJ3Yit9eWPvCVL9J/H3WMEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269590; x=1733874390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iE/ALBq6nkn1t/ePNsMu0Kga7vDUwmojevVesuygxq8=;
 b=wC2iCLFcW9/ZLe2/xsShUaCihMe4/Sevw8KfIu1q2wak/uLJ8LRbNIIwuTm3tRaO6B
 dv0Xc9UFR2HLohSMLGCmZOEOiJVljJA5KZDBDRuPDWQ5I8dTvHIak/ngiza/UAGP4nIN
 jtQsM/lFRwn+XX+uOyNAl1agihIL9iYSlMev7wORs87RM4A1N/FA0F/VQ3uSXD9la74C
 1o/6eAu0KV5/WVEvQCBpENkZLXichYE8jx1kCrNeythg39UD3yeoBrGFKj/8Tv2HLsMd
 i4rN9hMhuv84gW01ux5k4CDJrW60odFP/AojJykPxHtastNlKzFLWZUk0OaE7W9jQUfm
 gBBA==
X-Gm-Message-State: AOJu0YyvHudaFsoZ7ysGJJtPXRl1vQIP4QAb2qx/IzhrriMT5f3Qf+8l
 LVjaYPWPXPwtL3v0bDmMZvE1a4/72eM/n5XyA3XVEhY64CI5PwCzNFOcWIfqA/Np2SDYIKZW4ys
 =
X-Gm-Gg: ASbGncsQ7wdis6G3vYSZMS+dBhjUpf8Qsanjt44ovcJW78OPVO8/w4Uy1AZLf88jVHx
 oDHvOXs23Vy8TfeahlI/FVi4h0sSWJ7M8A9sfyn/bX67nBjF18oonokOkopiUTn/BQyJhCzf7OM
 gwnYFpCcgOqCgh2POpHJi8njHMv4qiZiUaS6+BbaQCnRJ5nTkh1cjAtOl62OoboraFGftwGMRhb
 UCVZ+d8Na+4usQuJjaZ/sDGRpfuSlJs2XVeKg7R/k00OfvS2yhIAn6sRVKGKG6b9JVtaUEBa+dA
 jpsuddUBzfk=
X-Google-Smtp-Source: AGHT+IHk6mwVxYX8OXXcPVGr1bT/zdhQdPHY71CobEqQMAvZT51t/PLvQxLQnuuLXwb46WiHuQohyQ==
X-Received: by 2002:a05:6602:2dcf:b0:83a:b7a2:74e6 with SMTP id
 ca18e2360f4ac-84462819605mr297989139f.0.1733269589929; 
 Tue, 03 Dec 2024 15:46:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 07/41] bootstd: Correct display of kernel version
Date: Tue,  3 Dec 2024 16:45:25 -0700
Message-Id: <20241203234559.2938192-8-sjg@chromium.org>
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
index fb69d0ef561..d74c404464c 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -559,7 +559,6 @@ void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
 		 bool show_cmdline)
 {
 	struct setup_header *hdr;
-	const char *version;
 	int i;
 
 	printf("Setup located at %p:\n\n", base_ptr);
@@ -596,10 +595,14 @@ void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
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
index 5ab322ef00d..b3b78bebaed 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -384,6 +384,8 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		struct bootm_info bmi;
 
 		bootm_init(&bmi);
+		/* we don't know this at present */
+		bootm_x86_set(&bmi, bzimage_addr, 0);
 		zimage_dump(&bmi, bflow->x86_setup, false);
 
 		return 0;
-- 
2.34.1

