Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00791C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:28:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B17C878E8;
	Sun, 31 Dec 2023 16:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mbSmLCV9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85F0687887; Sun, 31 Dec 2023 16:26:23 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB2B18788A
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:26:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7bb0af58134so208151939f.3
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 07:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704036378; x=1704641178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yngB+cgy3jxjYzkffqrDQtaSLub4L+b+ccLCH7nDEg=;
 b=mbSmLCV9S7OL5gV30BnQ8nTuPpV5vlF92PfiGjY1x6EUihL5DYTtgKwaaSIUVwQyC1
 tod0aMjWnQSeq4w465+fAqY7Slk5DJRqWFO9bsNQa4J95Cjom1ls+CAwVcEX6keU18m6
 XAhUCIgbYMp4jO4gj3s4Y2ypOJxt2opsdWP5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704036378; x=1704641178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4yngB+cgy3jxjYzkffqrDQtaSLub4L+b+ccLCH7nDEg=;
 b=xJ09T/9l69arPjymDV2HcjtyzDrTH1zEUn58Mr4AHoviDaC4OlcPwYuZPNJEgF5byp
 /6Z21xoyrd9MSQquin/9jlDWAuWUE5zK0B6EdzBKPqxdspGnAQx191K0RbLpxKQiPcYn
 opgLgyWmCzfmI4sHJSbtMAFxeADpJjOS1zKOPUoF9PhVR1n1u9NDFjyJqyaw/ytxo9KJ
 0wSGRRYCvxKeQOoqanqP5dfDJvScIZ/dMHzMpTlydYpRTEhl+6jwfJeeYDWauPybxXVR
 I57cVTemjCwumwHUgnsX9dzOxI8dlI/c1UMJ/d/f1LR2/Wrxt1ECMI4pBbYhGaBtlu/e
 ik9Q==
X-Gm-Message-State: AOJu0YwU8ICg03ScENGToqn81jScUdGrd2+PstRSabsVX94aUlkTtONc
 jihQyfOSm1be0kHouGwg4YDBN8Qd57PPkz2jbLi/WNkFpEHS
X-Google-Smtp-Source: AGHT+IE7rdLFGxP0ffJvkdXJzHMDzu+S1b8Twi1e1sUAAzjnTqYhfl+6E+uylxhJuK+U+SIAbhIcrw==
X-Received: by 2002:a05:6602:1492:b0:7ba:9707:67ad with SMTP id
 a18-20020a056602149200b007ba970767admr26879600iow.28.1704036378490; 
 Sun, 31 Dec 2023 07:26:18 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cz9-20020a0566384a0900b0046b482039ecsm5632625jab.55.2023.12.31.07.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 07:26:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 12/12] efi: Correct smbios-table installation
Date: Sun, 31 Dec 2023 08:25:55 -0700
Message-Id: <20231231152555.464874-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231231152555.464874-1-sjg@chromium.org>
References: <20231231152555.464874-1-sjg@chromium.org>
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

At present this code allocates memory when writing the tables and
then unnecessarily adds another memory map when installing it.

Adjust the code to allocate the tables using the normal U-Boot
mechanism. This avoids doing an EFI memory allocation early in
U-Boot, which may use memory that would be overwritten by a
'load' command, for example.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
I believe this is the fix we agreed on for after the release, so I am
including it in this series.

Changes in v5:
- Add new patch to correct smbios-table installation

 lib/efi_loader/efi_smbios.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index 5db342ee0d7..eb6d2ba43c9 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -54,27 +54,25 @@ efi_status_t efi_smbios_register(void)
 
 static int install_smbios_table(void)
 {
-	u64 addr;
-	efi_status_t ret;
+	ulong addr;
+	void *buf;
 
 	if (!IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE) || IS_ENABLED(CONFIG_X86))
 		return 0;
 
-	addr = SZ_4G;
-	ret = efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
-				 EFI_RUNTIME_SERVICES_DATA,
-				 efi_size_in_pages(TABLE_SIZE), &addr);
-	if (ret != EFI_SUCCESS)
+	/* Align the table to a 4KB boundary to keep EFI happy */
+	buf = memalign(SZ_4K, TABLE_SIZE);
+	if (!buf)
 		return log_msg_ret("mem", -ENOMEM);
 
-	addr = map_to_sysmem((void *)(uintptr_t)addr);
+	addr = map_to_sysmem(buf);
 	if (!write_smbios_table(addr)) {
 		log_err("Failed to write SMBIOS table\n");
 		return log_msg_ret("smbios", -EINVAL);
 	}
 
 	/* Make a note of where we put it */
-	log_debug("SMBIOS tables written to %llx\n", addr);
+	log_debug("SMBIOS tables written to %lx\n", addr);
 	gd->arch.smbios_start = addr;
 
 	return 0;
-- 
2.34.1

