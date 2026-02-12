Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48922EEA84E
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 20:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 231CA83DCA;
	Thu, 12 Feb 2026 21:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="K6JFFWCC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3141883CB5; Thu, 12 Feb 2026 21:45:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B34B83DCA
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 21:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770929134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uzth/JYhZQo4r4//T8emgWZVZm/bXIkkXnaaipOOtQA=;
 b=K6JFFWCCuKeI1ZKoYJUObvYuFU3fFf5MA5CmbK8sWJhpN9YSoNda1XGpaGgAgsBw0bdAjH
 MnCxyKn4ZABnQsOIdMa0q6s6/gnN96vs75++V36hOfoyRStRE8T9+asbRMxveYPdRMyvQs
 1o6W+E+jS3HIy6G8ypSoFXaERQubEQE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-DyRrz8U1Nc2Dhf_C2-u59Q-1; Thu, 12 Feb 2026 15:45:33 -0500
X-MC-Unique: DyRrz8U1Nc2Dhf_C2-u59Q-1
X-Mimecast-MFC-AGG-ID: DyRrz8U1Nc2Dhf_C2-u59Q_1770929132
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836fbfa35cso1540525e9.1
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 12:45:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770929132; x=1771533932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uzth/JYhZQo4r4//T8emgWZVZm/bXIkkXnaaipOOtQA=;
 b=cgBeHneczx+FwIfm03Jo06/xJatukg23+ShOHMzh2/LvMzSQ1oMpQ9enwH1ThJg/xH
 2FztTNsExFJTliM9no2oKUdotF8MRbQzN73VD7/aZT4wGTSXAZjIhB3MTzPbabfdTxl+
 B+uh2qbe9xmpWa4lSzVQUAPwqqNzRAfpeKeA7z48ZbJN/oBKJCs2k5QJfWbMM6ZRRtvl
 2sIraDTmA2s6dNy67qh8HQspWYcnLDUT1/uwGkOKUwPAa7m6uaVMoUiT8/AB+38YlXWK
 ophRGI1c+eJIDtVDWiLVZ/NrOCMnBaxO5W3NBL/0tyiqoMyFx+WrAPgR1yRI0SjvHycH
 A6iQ==
X-Gm-Message-State: AOJu0Yx3jZd3LowLsdIjs3w22rew9I2MKfW9uETZbGjphhXvPP415xL1
 OKn0EUOXxKpEGejTnHi5Lnx6AOlAYjXNQdUn716on/PFBp8FloBE8q2+IwnLmaJhATcWNiCG0MZ
 bk4fFcWVoBUAGyQNkxUVtu5n7K3lleJ5QfzDAyTRBLT/iPtnDTjwHTyqQfQDpkmAHMn32gPH7jX
 Wz7jMMjBrdUEEkcx0nCyOl3n5hbVVoxpmKPrtRzA==
X-Gm-Gg: AZuq6aLWggZDCdxC2AaYYJlCzv3JCZKWEeh+i/o7hZ4xIdVs90toqoqf/b9kIsmXmwk
 RZPFZSOHMb3nvGTWF8uQmNzVbhWbBtW2g1n5b7nlZ5l7zsWoslgmbAmLz0Bb++pf2giKVCUW+jE
 6+c3KKt4mseNjUVfSJj2tj1ZVn7o7tsGe8sL9bP5WhPyPRN7TLjLvvfTwCY8ZMJWZWeP0OX0zYG
 5nIqyd/2X0ECtdfmC73HQ42BeE7xkvyiLyg15/3t/2cyIkYC4wjeeYKaCSzLc+ytAyxgpW7trXx
 Va0O+YRFnMhZem5b8/hVwGMK/48AdIhtb06vUWa0OLJQ1RrDzNlyr5iM6Mm8VzmJlZqjLYPK45E
 9NcemVchEtGiXKLKXgzW7mqUsTGnzqNq8GD6ESrhlJ0l6i68=
X-Received: by 2002:a05:600c:8119:b0:480:4d39:84b3 with SMTP id
 5b1f17b1804b1-48370e175c2mr5638335e9.6.1770929131799; 
 Thu, 12 Feb 2026 12:45:31 -0800 (PST)
X-Received: by 2002:a05:600c:8119:b0:480:4d39:84b3 with SMTP id
 5b1f17b1804b1-48370e175c2mr5638055e9.6.1770929131312; 
 Thu, 12 Feb 2026 12:45:31 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370ac3564sm6753225e9.5.2026.02.12.12.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 12:45:29 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, eballetb@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 7/7] efi_selftest: Enhance MBR test for
 PARTITION_INFO_PROTOCOL
Date: Thu, 12 Feb 2026 21:45:01 +0100
Message-ID: <20260212204511.619392-8-javierm@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212204511.619392-1-javierm@redhat.com>
References: <20260212204511.619392-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yunYq1YIsh16Z4DQJL5hOi7pdkGhTA9a43HFld0F1eg_1770929132
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The EFI_PARTITION_INFO_PROTOCOL test was added before the protocol fully
supported MBR partitions. As a result, it lacked specific checks for the
content of the raw MBR partition record.

Now that MBR support has been implemented, enhance the selftest to provide
coverage for the MBR entries too.

This verifies that the protocol correctly reads and exposes MBR partition
records and prevents this functionality to regress due future changes.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 lib/efi_selftest/efi_selftest_block_device.c | 26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_selftest/efi_selftest_block_device.c
index f145e58a267a..9c4be834eebb 100644
--- a/lib/efi_selftest/efi_selftest_block_device.c
+++ b/lib/efi_selftest/efi_selftest_block_device.c
@@ -19,6 +19,7 @@
 #include "efi_selftest_disk_image.h"
 #include <asm/cache.h>
 #include <part_efi.h>
+#include <part.h>
 
 /* Block size of compressed disk image */
 #define COMPRESSED_DISK_IMAGE_BLOCK_SIZE 8
@@ -319,6 +320,25 @@ static int execute(void)
 	u64 pos;
 	char block_io_aligned[1 << LB_BLOCK_SIZE] __aligned(1 << LB_BLOCK_SIZE);
 
+	/*
+	 * The test disk image is defined in efi_selftest_disk_image.h,
+	 * it contains a single FAT12 partition of 127 sectors size.
+	 */
+	static const dos_partition_t mbr_expected = {
+		.boot_ind = 0x00,
+		.head = 0x00,
+		.sector = 0x02,
+		.cyl = 0x00,
+		.sys_ind = 0x01, /* FAT12 */
+		.end_head = 0x02,
+		.end_sector = 0x02,
+		.end_cyl = 0x00,
+		/* LBA 1 */
+		.start_sect = cpu_to_le32(1),
+		/* Size 127 sectors (0x7f) */
+		.nr_sects = cpu_to_le32(127),
+	};
+
 	/* Connect controller to virtual disk */
 	ret = boottime->connect_controller(disk_handle, NULL, NULL, 1);
 	if (ret != EFI_SUCCESS) {
@@ -405,6 +425,12 @@ static int execute(void)
 		return EFI_ST_FAILURE;
 	}
 
+	/* Compare the obtained MBR with the expected one for the test partition */
+	if (memcmp(&part_info->info.mbr, &mbr_expected, sizeof(mbr_expected))) {
+		efi_st_error("MBR partition record mismatch\n");
+		return EFI_ST_FAILURE;
+	}
+
 	/* Open the simple file system protocol */
 	ret = boottime->open_protocol(handle_partition,
 				      &guid_simple_file_system_protocol,
-- 
2.53.0

