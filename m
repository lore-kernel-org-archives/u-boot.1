Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06E3C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA9687B44;
	Thu, 14 Dec 2023 17:52:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZZNHug09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83F0F87B1A; Thu, 14 Dec 2023 17:52:06 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 192EA87822
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35f418f394dso23455435ab.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572720; x=1703177520; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/uX2ryKAEZBjHGs+wGhtzHYEyOmV4i0u0CTu3FfRPJE=;
 b=ZZNHug09ZUcw/9/8qehFSW8xaAQvZUWJmmN4icqfpRJGvDmAf32tgxNfVG2kS9M3+m
 FCxHzyswPcvCMGQffpAGa7bzmtnpbmNhFwo9Jar+awlG1xi7SaclcV7Nv/RVLc4z+5BA
 npvau85MHlST1F1NQqbC3GhIcUoS+C5VCGCag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572720; x=1703177520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/uX2ryKAEZBjHGs+wGhtzHYEyOmV4i0u0CTu3FfRPJE=;
 b=SZoxqRnYhOS4UURlIe/QMBKRsOqB7JJRNnMxKs6RNlW/TC2BjEcR9P+SL5Ci+xCBq7
 OeByspbZpCw3iK4q6H5uMx7oc/Z3GDUW0+1agdMYUY57b4118Eu+MGUAcn0gJ+PIBcGq
 IRPBFTwvWIalrulE+0nrVgjcNDAUUXx7kYwUx+LJ26yXVj6ZT4tOIUyv3r/2mni/omiE
 bV+GpU0RR+PaYx02k5dE6kAGs9qKADUR+QRLofK735lpHnMT2IGZNnAsNumA/YOWLCwp
 81Hmw7mqAbVxI3R1ITpVAZCqtioEf9j/tdCjESQzrFSH9Sri4ybSwjpfPMQzxQ9f/BFx
 mePg==
X-Gm-Message-State: AOJu0YzIB8WxnMD1gv5TXzhWaZyDKXcXbxOx9ddWFOVBLptGPWRSirUp
 FJ0BrDtf6yTD7UoeNd02hzh5WV5liU87kRBjaMr55w==
X-Google-Smtp-Source: AGHT+IHzb/7bmjPNYEYVVxtjXMngl3krPz1PJlxxNS5QKE+nNBlMhhc7Hpg81VfsrMPNt1u1Un4n3Q==
X-Received: by 2002:a92:c565:0:b0:35d:6997:9cb3 with SMTP id
 b5-20020a92c565000000b0035d69979cb3mr13537239ilj.52.1702572720766; 
 Thu, 14 Dec 2023 08:52:00 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:52:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 20/21] stm32: Use bootm_run() and bootz_run()
Date: Thu, 14 Dec 2023 09:50:29 -0700
Message-ID: <20231214165112.2182274-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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

Use the new bootm/z_run() functions to avoid having to create an
argument list for the stm32prog code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .../cmd_stm32prog/cmd_stm32prog.c             | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
index 8670535844d3..3ed393b7199f 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <bootm.h>
 #include <command.h>
 #include <dfu.h>
 #include <image.h>
@@ -125,12 +126,10 @@ static int do_stm32prog(struct cmd_tbl *cmdtp, int flag, int argc,
 		char dtb_addr[20];
 		char initrd_addr[40];
 		char *fdt_arg, *initrd_arg;
-		char *bootm_argv[5] = {
-			"bootm", boot_addr_start,
-		};
 		const void *uimage = (void *)data->uimage;
 		const void *dtb = (void *)data->dtb;
 		const void *initrd = (void *)data->initrd;
+		struct bootm_info bmi;
 
 		fdt_arg = dtb_addr;
 		if (!dtb)
@@ -141,7 +140,7 @@ static int do_stm32prog(struct cmd_tbl *cmdtp, int flag, int argc,
 		snprintf(boot_addr_start, sizeof(boot_addr_start) - 1,
 			 "0x%p", uimage);
 
-		initrd_arg = "-";
+		initrd_arg = NULL;
 		if (initrd) {
 			snprintf(initrd_addr, sizeof(initrd_addr) - 1,
 				 "0x%p:0x%zx", initrd, data->initrd_size);
@@ -149,15 +148,18 @@ static int do_stm32prog(struct cmd_tbl *cmdtp, int flag, int argc,
 		}
 
 		printf("Booting kernel at %s %s %s...\n\n\n", boot_addr_start,
-		       initrd_arg, fdt_arg);
-		bootm_argv[2] = initrd_arg;
-		bootm_argv[3] = fdt_arg;
+		       initrd_arg ?: "-", fdt_arg);
+
+		bootm_init(&bmi);
+		bmi.addr_fit = boot_addr_start;
+		bmi.conf_ramdisk = initrd_arg;
+		bmi.conf_fdt = fdt_arg;
 
 		/* Try bootm for legacy and FIT format image */
 		if (genimg_get_format(uimage) != IMAGE_FORMAT_INVALID)
-			do_bootm(cmdtp, 0, 4, bootm_argv);
+			bootm_run(&bmi);
 		else if (IS_ENABLED(CONFIG_CMD_BOOTZ))
-			do_bootz(cmdtp, 0, 4, bootm_argv);
+			bootz_run(&bmi);
 	}
 	if (data->script)
 		cmd_source_script(data->script, NULL, NULL);
-- 
2.43.0.472.g3155946c3a-goog

