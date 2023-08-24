Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CD4C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1446986A01;
	Thu, 24 Aug 2023 21:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JWUKKWMU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24319869C2; Thu, 24 Aug 2023 21:56:14 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 470DE86940
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7927952ca67so6241539f.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906968; x=1693511768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RMRMil6Lw0IPrc/fRwGDQB4zswzxxce2IHmZNmBw29s=;
 b=JWUKKWMUD1ds2Us73IRZV0JX1kXfePOj6I7paMQCNDaRXoDfOpBy1xpotXMJPkHGmN
 sPVX2Yguittw+fms3QtOekTgtEl8r3zaDW1FJs/7aEjeFAlIxucmdHm+xSooNN3UQy6a
 bHvmDzlIaiOnW35iXs80CNvNFuMb7BEbnkyyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906968; x=1693511768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RMRMil6Lw0IPrc/fRwGDQB4zswzxxce2IHmZNmBw29s=;
 b=GE8G/yoXpRgDZDlmceiS62TPYlXW+uDGZe6vMGx4DqZw3WlaIeiBIjEsoEH0dk/gnx
 IbrLW5D+A5k6dbK4NVFvbsi++N3riq84WB2RViebjUqXjapLE16FWDmb6Kc3D2zWZL25
 FqC7IYvnzczTWIsgtBceScLmKF98WDGZ2Olw/yPmZYfahDhIuxZrWJuDm6sqg+ffkDQ4
 YcAE8klibxlv+gLzrEmjhBUmBChtD9QL5PEEFRV5/hOYWA9vbTDeDCHPEvibXW2Ww+ZH
 2pxSg1AkdieIeWF2R7pjUPbB/JB1uOVTTBUX6lQjtJU5keBMZO1xBl2u9N3jCnu2N9U9
 cHDQ==
X-Gm-Message-State: AOJu0YwDlKg2DqM1549DmUcsZRAhIJFYNAvVxSMgxq10w2vgMnOdKQ4A
 5nOP8m9xveySis2eggmAxue15pTp0GGi6y8s3RU=
X-Google-Smtp-Source: AGHT+IHE92B53XgXcpzJ+RJ5Nn9uixcP36AukKLYv6dsEV5HGv3kd25yGhrm00DLTZVnTzTek9zGjg==
X-Received: by 2002:a5e:8811:0:b0:790:adce:d553 with SMTP id
 l17-20020a5e8811000000b00790adced553mr7077183ioj.21.1692906967942; 
 Thu, 24 Aug 2023 12:56:07 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 10/23] part: Add an accessor for struct disk_partition
 sys_ind
Date: Thu, 24 Aug 2023 13:55:33 -0600
Message-ID: <20230824195553.1685996-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
References: <20230824195553.1685996-1-sjg@chromium.org>
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

This field is only present when a CONFIG is set. To avoid annoying #ifdefs
in the source code, add an accessor. Update the only usage.

Note that the accessor is optional. It can be omitted if it is known that
the option is enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootdev-uclass.c |  7 +++----
 include/part.h        | 12 ++++++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index fa52bc3a9c4e..c4044d87dc3e 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -184,12 +184,11 @@ int bootdev_find_in_blk(struct udevice *dev, struct udevice *blk,
 		if (ret)
 			return log_msg_ret("fs", ret);
 
-		/* Use an #ifdef due to info.sys_ind */
-#ifdef CONFIG_DOS_PARTITION
 		log_debug("%s: Found partition %x type %x fstype %d\n",
-			  blk->name, bflow->part, info.sys_ind,
+			  blk->name, bflow->part,
+			  IS_ENABLED(CONFIG_DOS_PARTITION) ?
+			  disk_partition_sys_ind(&info) : 0,
 			  ret ? -1 : fs_get_type());
-#endif
 		bflow->blk = blk;
 		bflow->state = BOOTFLOWST_FS;
 	}
diff --git a/include/part.h b/include/part.h
index 5cf1c5ec96f0..16ba8c102535 100644
--- a/include/part.h
+++ b/include/part.h
@@ -135,6 +135,18 @@ static inline void disk_partition_clr_type_guid(struct disk_partition *info)
 #endif
 }
 
+/* Accessors for struct disk_partition field ->sys_ind */
+extern int __invalid_use_of_disk_partition_sys_ind;
+
+static inline uint disk_partition_sys_ind(const struct disk_partition *info)
+{
+#ifdef CONFIG_DOS_PARTITION
+	return info->sys_ind;
+#else
+	return __invalid_use_of_disk_partition_sys_ind;
+#endif
+}
+
 struct disk_part {
 	int partnum;
 	struct disk_partition gpt_part_info;
-- 
2.42.0.rc1.204.g551eb34607-goog

