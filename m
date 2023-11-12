Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79CBC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E1C3877F4;
	Sun, 12 Nov 2023 01:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CmvQ0b2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CB3886F42; Sun, 12 Nov 2023 01:10:36 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C38E87017
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-35937f2fadeso13616865ab.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747788; x=1700352588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2/9/4WvxcdMtI0Pi9x/0jfur+U4ZUPdtE0jRv25gS0=;
 b=CmvQ0b2rY3ijjLr1aWxJE2QNNbX+YjyctnAVtdEHQl5Imhrur0X5OZDPVYY1AnzF6j
 aehs9EpikhwOI0Hvga/jiorDtI5lEAvTEMmhdEBBCnkszBkvHw0sk/H9Jm9jiJREMTRx
 I4fBf2d/48zE3I/gXM4ZQFsLcaFJamcoqNTOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747788; x=1700352588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S2/9/4WvxcdMtI0Pi9x/0jfur+U4ZUPdtE0jRv25gS0=;
 b=U5o+a1jYBN3vrnNey+25Vy/uUCcMWfqFBMm6dXcnpG2PbIwxllyUKrtCBRkBoS62Fm
 fqmYnv7LZrMEoIHXBmr85YLxeTeufjaO4EJ3jb1u5ILUZbT35PAj2wkcTyoQDL+7RTZd
 5PCK7OuJH+ry3p0K//ziM0jjqTrOO6uXV/lgWEqscMh/EcSsvKwL7arxD2t7BzOLU0CN
 iO5zan4Zx3lbLdaWPu7Ws2ffOChQbpz4vzWh5N9CBn6wcvyovHKGhaFhd4VokfMlCbJ0
 8ekSVc/ouc8NjB2LBQDSIvG31SRJqaNZ7McU/vk13sl+wrZZ6uOrNtQFqEghJGr9qNnQ
 FZgQ==
X-Gm-Message-State: AOJu0Yx8EeUg1/+Rj0J/fnRHj3u9hKnRlAZJuBb7JeEEhnf8lTA25gkv
 fuQOn8O4/aRuS4QMHzXxnh7KcD/gE3FkklEjJRqsxA==
X-Google-Smtp-Source: AGHT+IF/s+W5IyeJoLOa+5cnQ2e5G3cOY5l17Uc7S9xJcOgDCwLMRWnvv3mRQxnOueRoEj9ICyKE9Q==
X-Received: by 2002:a05:6e02:1a27:b0:359:4a25:fab with SMTP id
 g7-20020a056e021a2700b003594a250fabmr3532786ile.5.1699747787743; 
 Sat, 11 Nov 2023 16:09:47 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 19/29] bootm: Drop #ifdef in bootm_find_images()
Date: Sat, 11 Nov 2023 17:09:04 -0700
Message-ID: <20231112000923.73568-20-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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

The OF_LIBFDT #ifdef makes it harder to use a local variable for that
code block. Convert it to if() instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 5782a1e2a57b..0de49a9d1fa1 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -523,29 +523,29 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 		return 1;
 	}
 
-#if CONFIG_IS_ENABLED(OF_LIBFDT)
-	/* find flattened device tree */
-	ret = boot_get_fdt(flag, argc, argv, IH_ARCH_DEFAULT, &images,
-			   &images.ft_addr, &images.ft_len);
-	if (ret) {
-		puts("Could not find a valid device tree\n");
-		return 1;
-	}
+	if (CONFIG_IS_ENABLED(OF_LIBFDT)) {
+		/* find flattened device tree */
+		ret = boot_get_fdt(flag, argc, argv, IH_ARCH_DEFAULT, &images,
+				   &images.ft_addr, &images.ft_len);
+		if (ret) {
+			puts("Could not find a valid device tree\n");
+			return 1;
+		}
 
-	/* check if FDT overlaps OS image */
-	if (images.ft_addr &&
-	    (((ulong)images.ft_addr >= start &&
-	      (ulong)images.ft_addr < start + size) ||
-	     ((ulong)images.ft_addr + images.ft_len >= start &&
-	      (ulong)images.ft_addr + images.ft_len < start + size))) {
-		printf("ERROR: FDT image overlaps OS image (OS=0x%lx..0x%lx)\n",
-		       start, start + size);
-		return 1;
-	}
+		/* check if FDT overlaps OS image */
+		if (images.ft_addr &&
+		    (((ulong)images.ft_addr >= start &&
+		      (ulong)images.ft_addr < start + size) ||
+		     ((ulong)images.ft_addr + images.ft_len >= start &&
+		      (ulong)images.ft_addr + images.ft_len < start + size))) {
+			printf("ERROR: FDT image overlaps OS image (OS=0x%lx..0x%lx)\n",
+			       start, start + size);
+			return 1;
+		}
 
-	if (IS_ENABLED(CONFIG_CMD_FDT))
-		set_working_fdt_addr(map_to_sysmem(images.ft_addr));
-#endif
+		if (IS_ENABLED(CONFIG_CMD_FDT))
+			set_working_fdt_addr(map_to_sysmem(images.ft_addr));
+	}
 
 #if CONFIG_IS_ENABLED(FIT)
 	if (IS_ENABLED(CONFIG_FPGA)) {
-- 
2.42.0.869.gea05f2083d-goog

