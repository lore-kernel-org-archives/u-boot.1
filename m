Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1F6D4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8FEB8961D;
	Tue, 19 Nov 2024 14:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ATVlE//0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BB5E8959C; Tue, 19 Nov 2024 14:20:33 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A54BC89722
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a7546ac6e6so10302955ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022429; x=1732627229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MaKl3Hbdh1LDCGEgLUl6/1nkW4/acQbQjSojXC5Nxi0=;
 b=ATVlE//0EaAc3tht1cECO2sRCY+gFj+uBHIzhRDwZ+iWUYcwTyc6hUBJTMce167+qH
 DI3HKhQ1U9l1Oi79PMPHnpVKNJaTmiUI4fJjhR9gq17FDntEwK79qGl4z96+2E1wPnOh
 dNFzwW9dx6Svex6IA5sOVxCL3xUbx/9CukYJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022429; x=1732627229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MaKl3Hbdh1LDCGEgLUl6/1nkW4/acQbQjSojXC5Nxi0=;
 b=tGjNXMPzxrfELUuix0NEQOvyyvydvBWxbKnq0nQEMHVuMR2wAswnNIpRBkdp3p4F2P
 oFwjr3EPb2KHJbu7SL6XTdKm4+Gq1cfLR97+dfXzABFmkrfwKL4mmNQuuBsxW5x0YVyT
 MBT8DqYB+SOU+bUiB0echPqrEWVxMpduoj45qW3O1Zn2d30Mq/2z5ewbiCg3VvioTFtU
 adDrbn3jkk8+9s3+cqgV8l0oWrFFGyaPVPM2gsP8U7c1pXcW52UfhnC7jHhE9KM87aA/
 XauCJum2WK4DpvSWGOW1xEBohBUiDb7Y0fviS2nZwDmmGA2pvh1iack0bkwVtK1sdMDm
 uGHA==
X-Gm-Message-State: AOJu0YzztQf7j7j6X1JcUqeRW+lF9VuGX/fPSxVL3yeLqcr+GShtNuy9
 EBdwq/PY+jSnU2ti2asIM21UG66OngT6V9iarwhHyoJVBRRJlw+5jHfqiSgTdVrQoOIzMNHpCW8
 =
X-Google-Smtp-Source: AGHT+IGIb/onac4MnqLRrYndW0TN1boiY8p0AfyZUfTd0P17PJjh+1hdgZ5HrtGDSPz1VQ6dR0lY/g==
X-Received: by 2002:a05:6e02:3083:b0:3a7:1f83:8219 with SMTP id
 e9e14a558f8ab-3a748018819mr177055465ab.8.1732022428791; 
 Tue, 19 Nov 2024 05:20:28 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:20:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 36/39] pxe: Collect the FDT in the bootflow
Date: Tue, 19 Nov 2024 06:18:41 -0700
Message-Id: <20241119131844.4078144-37-sjg@chromium.org>
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

Move processing of the FDT so that it happens before booting. Add a test
to check that the FDT is now visible.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/pxe_utils.c     | 22 +++++++++++++---------
 test/boot/bootflow.c |  6 +++++-
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 7106e532e03..ca91bff7e51 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -578,26 +578,23 @@ static int label_process_fdt(struct pxe_context *ctx, struct pxe_label *label,
  * @initrd_filesize: String containing initrd size (only used if
  *	@initrd_addr_str)
  * @initrd_str: initrd string to process (only used if @initrd_addr_str)
+ * @conf_fdt: string containing the FDT address
  * Return: does not return on success, or returns 0 if the boot command
  * returned, or -ve error value on error
  */
 static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 			  char *kernel_addr, char *initrd_addr_str,
-			  char *initrd_filesize, char *initrd_str)
+			  char *initrd_filesize, char *initrd_str,
+			  const char *conf_fdt)
 {
 	struct bootm_info bmi;
 	ulong kernel_addr_r;
+	int ret = 0;
 	void *buf;
-	int ret;
 
 	bootm_init(&bmi);
 
-	bmi.conf_fdt = env_get("fdt_addr_r");
-
-	ret = label_process_fdt(ctx, label, kernel_addr, &bmi.conf_fdt);
-	if (ret)
-		return ret;
-
+	bmi.conf_fdt = conf_fdt;
 	bmi.addr_img = kernel_addr;
 	bootm_x86_set(&bmi, bzimage_addr, hextoul(kernel_addr, NULL));
 
@@ -684,6 +681,8 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	char mac_str[29] = "";
 	char ip_str[68] = "";
 	char *fit_addr = NULL;
+	const char *conf_fdt;
+	int ret;
 
 	label_print(label);
 
@@ -788,11 +787,16 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		printf("append: %s\n", finalbootargs);
 	}
 
+	conf_fdt = env_get("fdt_addr_r");
+	ret = label_process_fdt(ctx, label, kernel_addr, &conf_fdt);
+	if (ret)
+		return ret;
+
 	if (ctx->no_boot)
 		return 0;
 
 	label_run_boot(ctx, label, kernel_addr, initrd_addr_str,
-		       initrd_filesize, initrd_str);
+		       initrd_filesize, initrd_str, conf_fdt);
 	/* ignore the error value since we are going to fail anyway */
 
 cleanup:
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 4671bd7ab1f..cbd65cb3eb5 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1436,7 +1436,7 @@ static int bootflow_scan_extlinux(struct unit_test_state *uts)
 		"ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB",
 		bflow->cmdline);
 
-	ut_asserteq(3, bflow->images.count);
+	ut_asserteq(4, bflow->images.count);
 
 	/* check each image */
 	img = alist_get(&bflow->images, 0, struct bootflow_img);
@@ -1450,6 +1450,10 @@ static int bootflow_scan_extlinux(struct unit_test_state *uts)
 	ut_asserteq(IH_TYPE_RAMDISK, img->type);
 	ut_asserteq(0x2000000, img->addr);	/* ramdisk_addr_r */
 
+	img = alist_get(&bflow->images, 3, struct bootflow_img);
+	ut_asserteq(IH_TYPE_FLATDT, img->type);
+	ut_asserteq(0xc00000, img->addr);	/* fdt_addr_r */
+
 	return 0;
 }
 BOOTSTD_TEST(bootflow_scan_extlinux, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
-- 
2.34.1

