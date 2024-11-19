Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50614D44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C51E895B2;
	Tue, 19 Nov 2024 14:19:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k/HAs/YD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F15A5895B9; Tue, 19 Nov 2024 14:19:12 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D26698954F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a76fd74099so3571795ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022349; x=1732627149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OML9mEXlmYbhRnP65fbzkGP6FaWXSltKrWJx6vH5IyE=;
 b=k/HAs/YDcZcIgNYfLrNYDgi7nDT6xhguTVb5lJGPZEiXykIkC/PIpKOQWE5o8MQ6bC
 6qzoywgzBgaW6kVY4106NHEXPOco0CQYLkopg2Ig0sEdoZaKC+2EOLg764fxRB0YJ+xU
 TKUSo2CX4ZAMGKlhS6RofYURIgQ/miAYPlfVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022349; x=1732627149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OML9mEXlmYbhRnP65fbzkGP6FaWXSltKrWJx6vH5IyE=;
 b=PZa0+lBR8F0ZbNDzU8r2Mw9ECtVmgiaF0YH3BJZDP01QuoQmk0KIpWOY027JqGvM/+
 zMVpTEhzIV5TU7KElfhUieGiWftPVE0p5ljIGjaQ1/lH7nFsLnq70vOOL7d6VpvNVtKO
 leEsddfiwiMDd3wJmF51qoiU3BRncvdq9EFkZNKXL2Dh2yv0jyXgk+eCtZBZOo4zJaDX
 jBpRTUvEpNlqrU7HDmWuyOakFB8IVt+5GOBbqXN0aP2fvk8hI712OlasiHBpCeNEjGDk
 ZAQ1l/p3uorxc59Q1h8xHqffHEyqmS4aHAZc5oP/rYaY/j1hkCmM4c4SeQXpMAuDHKGm
 yijQ==
X-Gm-Message-State: AOJu0YyohBV6/at9RY0cCYz4cGo7lcEMl2/L7W90x56cO2PFh5EhV+M8
 HWx5V0UfKPksONOhdwMaoiAWKLJ1tX1CRWEdLQzjmbLaCyZKR6W0d/Yk/Z/65KzMbCL5uRPN8Q4
 =
X-Google-Smtp-Source: AGHT+IHAtcFCwmwg16/bhngSC05/haz6hQQTrhZMVNFUb2mG6QbiybFfx54VwTuKluvF/bmCQ+Zkfw==
X-Received: by 2002:a05:6e02:18cc:b0:3a7:15aa:4169 with SMTP id
 e9e14a558f8ab-3a74808eae6mr198653555ab.23.1732022349089; 
 Tue, 19 Nov 2024 05:19:09 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 07/39] bootstd: Correct display of kernel version
Date: Tue, 19 Nov 2024 06:18:12 -0700
Message-Id: <20241119131844.4078144-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

