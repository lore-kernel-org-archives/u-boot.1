Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38993E77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A91189730;
	Wed,  4 Dec 2024 00:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fDXCsdy5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B04089730; Wed,  4 Dec 2024 00:48:04 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48A18967D
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-841a7ae8d8aso239353639f.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269680; x=1733874480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vYAECU28AEurSs1P/vzovd1fibvOs8JYUmQjJ2pZRg=;
 b=fDXCsdy5W+HVOnCuxfTSH7usX/6DKRx5Zaon5kVelEsbM5rcJL1TdN9fg4Sh5hSJwR
 MGikDhXkIIFfzRsirL2QyUJYXseE7N1UWzWMSrE5ft179wU913JFnkmEdb5QWIO3MRfd
 w3wVaEm8bMV94eAzWUl/9nPKLSV4nssU3wB3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269680; x=1733874480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vYAECU28AEurSs1P/vzovd1fibvOs8JYUmQjJ2pZRg=;
 b=rA0jnfarW5lGhFIFuuEsKIGkSV1Ex5Xy0FgPcxdrF/NIIp0CThVz2tH3s2Gs2592yo
 5FN2U4LZKDAT1gZnVMFfH/C7y1IEhXrg+OAkpWX/57M48CNyy3UcBOvPIzK3DihN0bWf
 ZrmiD9kYVCR2lWElKOnhh+79jUjsdKfD7scGBEr5jwOY3M3RDEBpxvc0gKjkDoWqspDc
 vnoL0R9XJrV71zTbvlPFepva3bSevhn7IkBxZnTVg5VBBvcJSZXgVbhExHUAHr4DExOa
 Dx9yb41PHw6xmc9SOORkNRDGgfF7l4akYAwwdPPKH7E7MRy9FCFPdGvxlQJkTDEO49Bq
 Q+2w==
X-Gm-Message-State: AOJu0YzL9zh2G8Q6m44hzCIVMWx/7DzSGwehCWdDwm9qU5gfz9UnwFcy
 q/E5QgmWeKLGgf+NvmfjTl2c12AtbRtde1G0k3wT0taFPf3gEu2pSSXU5IDpHJUpd7npeOMuObY
 =
X-Gm-Gg: ASbGnctnPEVy3Plh7Unvqvymhnl2RkXDQKFpc9sR8oneTXXAz4pvnksUFjnfxR5y1AP
 PaRwxcLvySLNrz4wMVnyHop6TcBBsoJvkWOOKy/8VXAAgu8Nia92t6bFmQ12/zn/aocv1HWqaik
 SrRKyRltMiDocOh2MgQVzW6frZkWcjjgrXFCFzxzE1UW07vqMl/NQEDPkEGDpM2ty01XN3KXR3q
 LUhbcZOd9RqaoBfBFtqo8EJj1lRMSq0QWbqVMVsb66lgxO1+NyHcuZH+LYvS2FVPhtFzZd9+yLo
 vicBa/oh4e4=
X-Google-Smtp-Source: AGHT+IHdmqewrk0VOTnb+A90b9N5yLKDmU9nn3e98tXgR7qmhaBDQWjkRl54H4OVSJ/Sh4jQnlzJ9g==
X-Received: by 2002:a05:6602:6d0e:b0:83a:b188:7a4d with SMTP id
 ca18e2360f4ac-8445b42ff3cmr567457639f.0.1733269680099; 
 Tue, 03 Dec 2024 15:48:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 38/41] pxe: Collect the FDT in the bootflow
Date: Tue,  3 Dec 2024 16:45:56 -0700
Message-Id: <20241203234559.2938192-39-sjg@chromium.org>
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

