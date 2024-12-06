Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDE3E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9AE88960A;
	Fri,  6 Dec 2024 03:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lc+ZVQVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2080E89672; Fri,  6 Dec 2024 03:36:56 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E62B8965C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a8034f24a8so12795375ab.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452611; x=1734057411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iE/ALBq6nkn1t/ePNsMu0Kga7vDUwmojevVesuygxq8=;
 b=Lc+ZVQVxwENRVnn0k12UQVqEuXvr+It+p+txTEBRdEbxiMRjCGtzSmviUndH6pnaVi
 AKsvMASR3Q8YL0G03pyvZhlST9H6bciUfLvI9tkESz2iSxcOIu0t6uKJFSPG28ugB8jB
 BPd3GddDDuzP4yh8kr19yxh9xnmk6kxRfxme8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452611; x=1734057411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iE/ALBq6nkn1t/ePNsMu0Kga7vDUwmojevVesuygxq8=;
 b=a1VWN5c9itfQAbFUmSbTpybHVi8MtuoPMdE7x2PFRpzrmhoa4pq8JBb7SLhi8aU0EO
 jCX3Rs9pER6fNN+45kQTceijUqOdbJhZDLmlFYLpe5w4vBleDNuegIA/PMBeIYBPLmOr
 lgkx+8P3GT+iFAuiCr8NT1VpAaetMgD13LsZvVDEZdS3Ejf2GINVbudsCsMP8Lsqogni
 IzMAfGBFlJI9d3SRjYuQDz8bdyV4msluVmK5GU3aDXYx0XO9QFoo8+yhG/xD8fhFZ1Vo
 m2elul8mcbf8W0xSPbA/NGLXfcDdo1QuZC5Iqr7jH8ujnDuykhwup/N6UrOXfVvbQ6gh
 t7tQ==
X-Gm-Message-State: AOJu0YxNSHHW4c1X0sg5ahcz9PCJwiR62BX422+fjOsWHG6yJdSXL7ag
 3mHKUnt7jzIkuo9OF8Cwq9FnuPtIwpTe6HlW8qnvV3uZ+2n6JiLc+jQHetltcJZEUzIf+zju/qE
 =
X-Gm-Gg: ASbGncvpnsTiL9Rg5W1DFlONlBhFYauK0TxQzEZDJZnkOsc37mZrxBu2MvMqYwVaj3N
 YEbAy6rz20YZ7eKeF18m2RaaXVo7yHm8mULLpBbgHCKgqPUigYtVPRSY8SjguxW7F7x7QyLqWkX
 DS97DFM0TtQjJntpapqNFmZRBd60ozZn+QULE/bKgEYCcYGiprlboCaWAWFqKeSoBfX/S+XNeGe
 2R//cUr02JYTZL2/hQqNcZTeeXHxMbvko9BYwmqOhNG0nCa7HQlvE1IYNsuJ3N/YyVriRgwW1Uh
 R9nDO9VB1tA=
X-Google-Smtp-Source: AGHT+IFq38z8i1P9zZGldvCucpc2QWXV24YLt052mF7gLtqnRpzyNti+eEAo8rpbkP7NqV0Dp2cUAw==
X-Received: by 2002:a05:6e02:1389:b0:3a7:87f2:b00e with SMTP id
 e9e14a558f8ab-3a811e28220mr18385085ab.19.1733452611250; 
 Thu, 05 Dec 2024 18:36:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:36:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 07/46] bootstd: Correct display of kernel version
Date: Thu,  5 Dec 2024 19:35:46 -0700
Message-Id: <20241206023626.2456858-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

