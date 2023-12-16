Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA135C4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ADEC87CB0;
	Sat, 16 Dec 2023 04:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oSRU6Dq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A07187C88; Sat, 16 Dec 2023 04:15:27 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2450787C36
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-35f71436397so8300635ab.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696523; x=1703301323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJVWtRT9ZrlY1O4g/GbYbgPQ6m5bJcTqEgw567On5rM=;
 b=oSRU6Dq6G552yLw/W1UTBvm8uFJg0QcovjNTq2R0/zfq/eCl4l3ipyu4qwM2kwUP+e
 jHew1+qYFkvxvfXRxjBY1h8cPBvijxiMw/G1QuoNDuxeyYFUsuCOyFQkHYRYJxd/21NG
 l6/HT2tGcPWpOqtjSQd3DlfkXGoyS0Tognshc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696523; x=1703301323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJVWtRT9ZrlY1O4g/GbYbgPQ6m5bJcTqEgw567On5rM=;
 b=YfMv9Ve2G/6bdm3ayo9fpMmymLaqwrWjM/Q+FzSfM12TUiDupecxUEIvLwVlyr2hD/
 B9iq6Z4V28yX/0ChKU4rA3s6ry4rsg00u7e2TFvJsTbwPdgt/cXpQd0z0RdOq6geHjzd
 dR4SfU6c++8/rnguc44bMJqS2wqi/MXsD0HnB2TGQbuoT0PD+6s/Qf/FGUCwGfEO9Ucy
 l9eYow9mej4vvjgcT5TdkFXGAbMx1B76WBnI/Qec1Gdq4aUBE61y1NGIOrmr17986W7p
 TRZVPrx+v0QBPS+Xl/KBR/5TMDFcCsBzqHACUe4tkH1mwiN+j6tCfqfouvMSkKAxwod+
 Opgw==
X-Gm-Message-State: AOJu0YxjvE3vpV3Q/tI9aDrLLY5DZnmg3dyiychUXYhDhKMSVuAzvYF6
 4rQBFGfazk1/1aFPy6IhEprebWv9lo/7cdWLNA3ZxA==
X-Google-Smtp-Source: AGHT+IFIJ0c5Y6e8rbvzxM618i+7s/BaEpZSPZWXdtLf9KebSi4BqUrgy5BzzIwrRHQNNfvj0erTIg==
X-Received: by 2002:a05:6e02:339a:b0:35f:7f58:4f3b with SMTP id
 bn26-20020a056e02339a00b0035f7f584f3bmr5868297ilb.131.1702696523699; 
 Fri, 15 Dec 2023 19:15:23 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 18/22] stm32: Use local vars in stm32prog for initrd and fdt
Date: Fri, 15 Dec 2023 20:14:22 -0700
Message-ID: <20231216031446.2222362-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231216031446.2222362-1-sjg@chromium.org>
References: <20231216031446.2222362-1-sjg@chromium.org>
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
Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
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

