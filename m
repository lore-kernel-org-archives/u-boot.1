Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BBBC54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A13C8755E;
	Sat, 18 Nov 2023 22:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RGvmwUKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A305D874A5; Sat, 18 Nov 2023 22:06:43 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6DA3870C3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7a66b5f7ea7so106991839f.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341576; x=1700946376; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ts/Rv8vsm/SVViLuiBjqqHUONkbgC/0iZxKoqgUdwVE=;
 b=RGvmwUKWVMBL6QrKRjeeli6QEmbb59pj5k0OCcgLeKUZVVbols/x4NFW3WEFbEzYrD
 E+Z1jq1vxWApFKn84u1Ct3cRPL+xf+fiY2nMThcOQn+ZC386slyymqR56bXxZwH6AcNl
 OQTJ7s3AMkt+KXnxhdHnk07/bYa/SMV/ZU6F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341576; x=1700946376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ts/Rv8vsm/SVViLuiBjqqHUONkbgC/0iZxKoqgUdwVE=;
 b=MWMJrWpQq2Ja4gHEl3MDsjHHJUbNn9ZIL0LSAvWDbuZjGCODEQyltcpQyCw3zCh8nw
 Ovi/+ma0qgL8OuPy/TnfiwnTlvucStBsu0rmqKuBBzBOjVhOIVmeshQUGl7+OhP6cgWm
 JY9FSfd6U3VW6lwju3Tjjz6LLUF1+1MHAFqsLUwnlp/c8+4BGCUwWr/VfxO2edrW/23n
 WNGxGo7IG1Z7hkWMbX7URDjlzlfZSUFBnhmzAb9t7u4K1YltQY32g1cPjFmy0oSsHnTG
 Nfo9WOVjDbIhnx3e7ivtnBY92YLWxYSHEpWuPv5BFHKjZUAhrW5T2lxhcADiX/Lp2JRf
 Qv+w==
X-Gm-Message-State: AOJu0Yz8dC02/cj07nOUXsVIi0cmvSITLbLa83uz8dBav3/FevuyTPFU
 KmBNKXwfc7lxbZH+2YPYXTI9pRNmK7gbgIftoJ1pHA==
X-Google-Smtp-Source: AGHT+IEGn3mxPBpviO4TVJ/liVqW2VtRZ9ihWgxaC0kimoP22j54qs+bc1pNt/xcorTwNam95hrtcg==
X-Received: by 2002:a05:6602:6423:b0:7a6:83da:6dfa with SMTP id
 gn35-20020a056602642300b007a683da6dfamr4924579iob.0.1700341576457; 
 Sat, 18 Nov 2023 13:06:16 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v3 23/32] bootm: Reduce arguments to boot_get_fpga()
Date: Sat, 18 Nov 2023 14:05:11 -0700
Message-ID: <20231118210547.577026-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

This function only uses two arguments. The 'arch' always has a constant
value, so drop it. This simplifies the function call.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c       | 3 +--
 boot/image-board.c | 5 ++---
 include/image.h    | 9 +++++++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 5dc9cdeb244f..ae3fceb392da 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -555,8 +555,7 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 #if CONFIG_IS_ENABLED(FIT)
 	if (IS_ENABLED(CONFIG_FPGA)) {
 		/* find bitstreams */
-		ret = boot_get_fpga(argc, argv, &images, IH_ARCH_DEFAULT,
-				    NULL, NULL);
+		ret = boot_get_fpga(&images);
 		if (ret) {
 			printf("FPGA image is corrupted or invalid\n");
 			return 1;
diff --git a/boot/image-board.c b/boot/image-board.c
index 60e514fc150e..b926275ec917 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -616,8 +616,7 @@ int boot_get_setup(struct bootm_headers *images, u8 arch,
 	return boot_get_setup_fit(images, arch, setup_start, setup_len);
 }
 
-int boot_get_fpga(int argc, char *const argv[], struct bootm_headers *images,
-		  u8 arch, const ulong *ld_start, ulong * const ld_len)
+int boot_get_fpga(struct bootm_headers *images)
 {
 	ulong tmp_img_addr, img_data, img_len;
 	void *buf;
@@ -659,7 +658,7 @@ int boot_get_fpga(int argc, char *const argv[], struct bootm_headers *images,
 						tmp_img_addr,
 						(const char **)&uname,
 						&images->fit_uname_cfg,
-						arch,
+						IH_ARCH_DEFAULT,
 						IH_TYPE_FPGA,
 						BOOTSTAGE_ID_FPGA_INIT,
 						FIT_LOAD_OPTIONAL_NON_ZERO,
diff --git a/include/image.h b/include/image.h
index 04f35de9d082..63f2bd3b3713 100644
--- a/include/image.h
+++ b/include/image.h
@@ -642,8 +642,13 @@ ulong genimg_get_kernel_addr(char * const img_addr);
 int genimg_get_format(const void *img_addr);
 int genimg_has_config(struct bootm_headers *images);
 
-int boot_get_fpga(int argc, char *const argv[], struct bootm_headers *images,
-		  uint8_t arch, const ulong *ld_start, ulong * const ld_len);
+/**
+ * boot_get_fpga() - Locate the FPGA image
+ *
+ * @images: Information about images being loaded
+ * Return 0 if OK, non-zero on failure
+ */
+int boot_get_fpga(struct bootm_headers *images);
 
 /**
  * boot_get_ramdisk() - Locate the ramdisk
-- 
2.43.0.rc0.421.g78406f8d94-goog

