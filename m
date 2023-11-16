Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52124C47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D98E874F2;
	Thu, 16 Nov 2023 05:11:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P1l+uZY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D86D8747E; Thu, 16 Nov 2023 05:11:41 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ABF1874A9
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7a6acc8e222so13602839f.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107897; x=1700712697; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WE/98gwI4OaLTOodzrTHSjqOhmfNtsEPAtYO5kXdNfI=;
 b=P1l+uZY3JT6UyIcehPJcbEYm52e8eDP88yR9cAmOwZDK0zh7bMgNuekCiXqEuLtUbw
 pFhpYkRhIx8fAZFZGs1XFJurK/tnpGWD00TasQKOYI0CNMf2KC4Bv9iKAq7PoIIfpW/m
 9t6ITjssEcXbUi0VZyMPE+B6IBVyxn9ttfE3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107897; x=1700712697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WE/98gwI4OaLTOodzrTHSjqOhmfNtsEPAtYO5kXdNfI=;
 b=WPqAN5QlEHHOj6raB7bWgtPoKeZq4nyg4RW03vy125bcyeXHchO7+JRthdTo2AgcfP
 c6rzVrpI/k12Yyo0FA4Ls8fP901I52qb2E7W/NSGWE0bqVn9JlUDEXI9zQp/6rwd21Dc
 JRWyklfFtdHKoGviUEs4IydcyHIMW1YPjX7WyKnSdFi9GGzQ6Gq6evcTydUbyig4cs4M
 5i+tTayjMjX8l+TUJaUKJOUFn2drrEcEusbKASmMUn314hmxXrWoHAwaaxtR9FQoYsmo
 Dnz/5Wjm3xUVN+FBAT7/5Du0PHI/w1Pg8f49Kw50aB604GYsu95AEPB7k8KjmRMSmCCK
 B7jQ==
X-Gm-Message-State: AOJu0YwWjK6RrkVGccQ/Jw43OGEnNki2e0cfUfWubPGyjqyU9CH59Jny
 8Jc5ZWY2cD3XhjY+5Em2IHG2whPl2prrk974L0z2tA==
X-Google-Smtp-Source: AGHT+IHAuIOHB0gWGa8u9QmvJ28oesDm0TSmTY6OGDfZ1nis8iKVGS3jYwJu39K/LPnh+cLz47Kn2Q==
X-Received: by 2002:a05:6e02:1542:b0:35a:b283:d14c with SMTP id
 j2-20020a056e02154200b0035ab283d14cmr16591465ilu.3.1700107897655; 
 Wed, 15 Nov 2023 20:11:37 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 21/32] bootm: Drop #ifdef in bootm_find_images()
Date: Wed, 15 Nov 2023 21:10:21 -0700
Message-ID: <20231116041043.362055-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

(no changes since v1)

 boot/bootm.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index d5893e82d128..d9c62d730f7f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -524,29 +524,29 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
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
2.43.0.rc0.421.g78406f8d94-goog

