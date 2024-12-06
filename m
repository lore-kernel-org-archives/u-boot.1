Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8C7E7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38E7B89753;
	Fri,  6 Dec 2024 03:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jxN7l45y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD2628979B; Fri,  6 Dec 2024 03:38:28 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C4889761
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:38:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a79911ac70so6210315ab.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452704; x=1734057504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vYAECU28AEurSs1P/vzovd1fibvOs8JYUmQjJ2pZRg=;
 b=jxN7l45yEqjm4UX8XjX6BlZfXp8c0+IKytlZ3cFNhAkzXtbVHalEJmuFIvZsMRt2ev
 wZCY++NVG8XVqXdasaoNdLfuuN/WPSSibuRVohOGuHGXyP2uANUiAHkhnKdRxjSQ/+tD
 MwqN4+dT/qdSiKQz7R5EvMQ4uRItr4OC+LwIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452704; x=1734057504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vYAECU28AEurSs1P/vzovd1fibvOs8JYUmQjJ2pZRg=;
 b=qrbAqoHJO3IxP9atLbSa9lAKlybwXuU1+oS1U5SD4m39MamoyTIKpU41CfvgKcgLTn
 epKOcMsR1mVeitmFwSBEtlaVixBvM8aCf892VqIrsCWF16v8jHbVywO1yvFbMv/0ToGe
 JKEI4pDP5CBKXtevklxsIoXKG5T8LW2EyoTZ1cqPzBUX+4JAnj3kiqm5PLAb9fxppbnd
 GH4kRCtW90sUxrgGvtpXzLOsC8eQIdt/H+uqfUF9CUC2jtJUEz6DBY/oTyQB+h4M0hRJ
 4cfs1xubAaaoS1Otts9bQ+n6HGQZAVuWXPLMv8Mf36jx4ZauBUgXACqgFilg6xrtouiU
 pCZg==
X-Gm-Message-State: AOJu0YzjU32OjjVg9Ctvy/v3WjYuDrJFqECZHC5neBWDD84ao2orXPhJ
 AHM9jmiMbRH5YAOwNrM/MoNXwFisQ1uiTNGZRmBu++wjqCLfii9wvddXOkYeXCCEAw1OywYQxDg
 =
X-Gm-Gg: ASbGnctAWGDnEwqE41tJ53j4Bf+3d1O431ZcVlmI3eBWgUJicfE8u5lI3uQChoCDum1
 ytA4ckw9CvhQ9wovW7I99TzwDijr2Jd1qBOa44C6BxghtmTrgar6A3nailPUO4UQpXFxxA6PePi
 slieSufeNT18pJYpr8eJryMMv7KH5Dp/UXJ4ecfcvVydQBGht7T3ouwsOduvCdirHJmG+WokYeP
 8N6WdxMLudY4Qh6x/2Sk4cgnNdWqk0hkMVDdppJsiZjIVgd2d+7TFjI1EDvPL2h3AmiWSMrk5vU
 yTNjVYdm+IM=
X-Google-Smtp-Source: AGHT+IGgiqcb02kXy/IMs7o+M3s2AlumGvfvGAno2UTmB2yzEhH5crgL8/tqTFETSUJlSzy+sx+a8Q==
X-Received: by 2002:a05:6e02:1ca7:b0:3a7:6e34:9219 with SMTP id
 e9e14a558f8ab-3a811db26admr20042975ab.14.1733452704342; 
 Thu, 05 Dec 2024 18:38:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:38:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 42/46] pxe: Collect the FDT in the bootflow
Date: Thu,  5 Dec 2024 19:36:21 -0700
Message-Id: <20241206023626.2456858-43-sjg@chromium.org>
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

Move processing of the FDT so that it happens before booting. Add a test
to check that the FDT is now visible.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/pxe_utils.c     | 22 +++++++++++++---------
 test/boot/bootflow.c |  6 +++++-
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 3531ab1c71a..053fdcbb6e7 100644
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
 
@@ -678,6 +675,8 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	char mac_str[29] = "";
 	char ip_str[68] = "";
 	char *fit_addr = NULL;
+	const char *conf_fdt;
+	int ret;
 
 	label_print(label);
 
@@ -782,11 +781,16 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
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
index ef8c0c1bbaa..640a7cdb7c9 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1459,7 +1459,7 @@ static int bootflow_scan_extlinux(struct unit_test_state *uts)
 		"ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB",
 		bflow->cmdline);
 
-	ut_asserteq(3, bflow->images.count);
+	ut_asserteq(4, bflow->images.count);
 
 	/* check each image */
 	img = alist_get(&bflow->images, 0, struct bootflow_img);
@@ -1473,6 +1473,10 @@ static int bootflow_scan_extlinux(struct unit_test_state *uts)
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

