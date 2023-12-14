Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DB2C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FDFC87B37;
	Thu, 14 Dec 2023 17:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T5vyP6wi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2B0C87B0E; Thu, 14 Dec 2023 17:52:02 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6D9287AFE
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:52:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7b6fe5d67d4so312429439f.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572719; x=1703177519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xM637a7/+74UxIJkS29Afb2Qul2T5Es438+DTSq1oH4=;
 b=T5vyP6wizG4zPT/jm07FvpnYChAOQRFu9WeVSc1r080hrqgSxhG6bFo2oEC0HNCPtH
 pZx337MIhDGXEpEBhB9iIOpZNvPMrT2jA5gxHqvZqy8Vz5rXexPZMLCW4Zazn5UqB2hF
 fiuVFgriplJFX/29GPqgaMHQw92+8trsItBEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572719; x=1703177519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xM637a7/+74UxIJkS29Afb2Qul2T5Es438+DTSq1oH4=;
 b=lKSmkRa0bQk2rJNcoiDj5PA+DJ63XPawFK+txrvi5OTMs/ugk2OtXWa/fRCx8I6Cp0
 KnETtqV5UYGNxkRO0tqVLK+REz5hpo4uYSAA/AZH+lxmD/9rDv9z4zIIKwBNfpwKozLY
 WpAHCqxxDRKaYhrQUjiN782Z0c2UJR5mgU8Iq4UpVu+zxME8IDHknh4p3fxoUqVig0SK
 5+5fAG+rlWhIg6KBsICsPJ5djSC06Zy7P8t3Vubuwq4JXrZdCS92+hBvO8jl4vFCboyZ
 iHsENMgg1uIPhH2l1pxh3feLxsJq63JJnJ0FVw69z62miDAsnTqzT0EFUGKuwFcOjYR0
 kwxA==
X-Gm-Message-State: AOJu0YyjrfrDEgb6f1aHRIF1Lp6/41/AUDLkc/q44//Q1yqe34yMFOZ2
 HBnuOw/u2UnVMlQFqEIidb/hHRG4ikCzdbF1TNJFwA==
X-Google-Smtp-Source: AGHT+IFzNmHrq+4O6kqvxUp9Ec1fPtvE0fquphffCtdNDGWIeFR1D4jiAz1o6jRu8Hi3zqaghnBpXg==
X-Received: by 2002:a92:ca89:0:b0:35f:772b:b89d with SMTP id
 t9-20020a92ca89000000b0035f772bb89dmr2448179ilo.62.1702572719268; 
 Thu, 14 Dec 2023 08:51:59 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 18/21] stm32: Use local vars in stm32prog for initrd and fdt
Date: Thu, 14 Dec 2023 09:50:27 -0700
Message-ID: <20231214165112.2182274-14-sjg@chromium.org>
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

Rather than assigning to the bootm_argv[] array multiple times, use
local variables for the two things that can change and assign them at
the end.

This makes it easier to drop the array eventually.

Tidu up an overly short line while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .../cmd_stm32prog/cmd_stm32prog.c             | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
index 2411bcf06d8f..8670535844d3 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
@@ -124,30 +124,35 @@ static int do_stm32prog(struct cmd_tbl *cmdtp, int flag, int argc,
 		char boot_addr_start[20];
 		char dtb_addr[20];
 		char initrd_addr[40];
+		char *fdt_arg, *initrd_arg;
 		char *bootm_argv[5] = {
-			"bootm", boot_addr_start, "-", dtb_addr, NULL
+			"bootm", boot_addr_start,
 		};
 		const void *uimage = (void *)data->uimage;
 		const void *dtb = (void *)data->dtb;
 		const void *initrd = (void *)data->initrd;
 
+		fdt_arg = dtb_addr;
 		if (!dtb)
-			bootm_argv[3] = env_get("fdtcontroladdr");
+			fdt_arg = env_get("fdtcontroladdr");
 		else
-			snprintf(dtb_addr, sizeof(dtb_addr) - 1,
-				 "0x%p", dtb);
+			snprintf(dtb_addr, sizeof(dtb_addr) - 1, "0x%p", dtb);
 
 		snprintf(boot_addr_start, sizeof(boot_addr_start) - 1,
 			 "0x%p", uimage);
 
+		initrd_arg = "-";
 		if (initrd) {
-			snprintf(initrd_addr, sizeof(initrd_addr) - 1, "0x%p:0x%zx",
-				 initrd, data->initrd_size);
-			bootm_argv[2] = initrd_addr;
+			snprintf(initrd_addr, sizeof(initrd_addr) - 1,
+				 "0x%p:0x%zx", initrd, data->initrd_size);
+			initrd_arg = initrd_addr;
 		}
 
-		printf("Booting kernel at %s %s %s...\n\n\n",
-		       boot_addr_start, bootm_argv[2], bootm_argv[3]);
+		printf("Booting kernel at %s %s %s...\n\n\n", boot_addr_start,
+		       initrd_arg, fdt_arg);
+		bootm_argv[2] = initrd_arg;
+		bootm_argv[3] = fdt_arg;
+
 		/* Try bootm for legacy and FIT format image */
 		if (genimg_get_format(uimage) != IMAGE_FORMAT_INVALID)
 			do_bootm(cmdtp, 0, 4, bootm_argv);
-- 
2.43.0.472.g3155946c3a-goog

