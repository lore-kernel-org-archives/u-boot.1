Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFABDC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 769B388B1D;
	Thu, 15 Aug 2024 22:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="larOoXI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D43388AA9; Thu, 15 Aug 2024 22:24:48 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B003488AD2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-39728bbf949so5115915ab.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753475; x=1724358275; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZPs5LxcNNfqWmMn1am7y0YE8qmewycHIxMGVk0UTcc=;
 b=larOoXI4NOYDgvDDsEwpGPMtRmuI0w6sGvICOVfPatkTnjW2iIxUhsJQTyPqCqdULF
 8UCwUfzngZMzGoikhmTyVQ//TlMKfwF9Fg9rC+UuEcI+jhC7iNK0UIyOWJZzItZwClIo
 AFRfcMUJpclmYMk9GiuhrxnliVeXtmvMox3aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753475; x=1724358275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZPs5LxcNNfqWmMn1am7y0YE8qmewycHIxMGVk0UTcc=;
 b=Xv76uGsmA5dIfgTha8Uai0pHJCDnZ69Ml5R2FZMjFo1+2Dgq0u/3+IKooFMF21iSKT
 k1s8JxKbM/UCkXHAfLR9N2HPGyG6tlRySn5b8EvDWEgVxg2zhISIPDNmsLm9lXbnyE/c
 XHPFmeqKoDMWefFdAkwtKFmdUxLopYvAg+TqBJDtRnuz+fVGQ2GoMnI+049d4+OWeS0j
 VuSGAaTGnLH9ux8A1bb3TkZA95U6xW8wwpFJWO+P7JRTqbP9mTSGUCdowQ1S7qWQMLfr
 Re2KLkOHHZ7jVJsW1nYKapw6ngzKWbDjUgBW8XXmc5WugJXD/OJx0VzogCtCdFzwojDH
 PN9Q==
X-Gm-Message-State: AOJu0Yxul7Gjcr8T2KlpUw4BuDG8pbfBSmksKh+Z7afIU0Dz5yJe8GcD
 84cxnx7DZKCtewRPfmsCV9+Cp06w0htEhOA6I67clvcFZ+USkmJb9o98wOu9/TAF/57bYMR58B0
 41Q==
X-Google-Smtp-Source: AGHT+IGmjZRtHLKmSt90SB2Sm6FNRQ8L9SfZrK6ilzrKOcxvgMW+wf0AXVB/uELHL2plWHRhgHibkw==
X-Received: by 2002:a05:6e02:12c7:b0:398:54dc:1408 with SMTP id
 e9e14a558f8ab-39d26d6ecf5mr15120435ab.23.1723753475226; 
 Thu, 15 Aug 2024 13:24:35 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ead5597sm8144915ab.7.2024.08.15.13.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:24:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 09/14] bootstd: Add debugging for efi bootmeth
Date: Thu, 15 Aug 2024 14:24:19 -0600
Message-Id: <20240815202424.766778-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202424.766778-1-sjg@chromium.org>
References: <20240815202424.766778-1-sjg@chromium.org>
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

Add a little debugging so we can see what is happening.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_efi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 39232eb2e25..99887a89f02 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -163,8 +163,10 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 	int ret, seq;
 
 	/* We require a partition table */
-	if (!bflow->part)
+	if (!bflow->part) {
+		log_debug("no partitions\n");
 		return -ENOENT;
+	}
 
 	strcpy(fname, EFI_DIRNAME);
 	strcat(fname, BOOTEFI_NAME);
@@ -172,8 +174,10 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 	if (bflow->blk)
 		 desc = dev_get_uclass_plat(bflow->blk);
 	ret = bootmeth_try_file(bflow, desc, NULL, fname);
-	if (ret)
+	if (ret) {
+		log_debug("no file\n");
 		return log_msg_ret("try", ret);
+	}
 
 	/* Since we can access the file, let's call it ready */
 	bflow->state = BOOTFLOWST_READY;
@@ -308,6 +312,8 @@ static int distro_efi_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 {
 	int ret;
 
+	log_debug("dev='%s', part=%d\n", bflow->dev->name, bflow->part);
+
 	/*
 	 * bootmeth_efi doesn't allocate any buffer neither for blk nor net device
 	 * set flag to avoid freeing static buffer.
@@ -333,6 +339,7 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
 	ulong kernel, fdt;
 	int ret;
 
+	log_debug("boot\n");
 	kernel = env_get_hex("kernel_addr_r", 0);
 	if (!bootmeth_uses_network(bflow)) {
 		ret = efiload_read_file(bflow, kernel);
-- 
2.34.1

