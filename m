Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5BBC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1A9A86A44;
	Thu, 24 Aug 2023 21:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YIk5wUD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 824E58683C; Thu, 24 Aug 2023 21:56:20 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F07986A12
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7926755c052so6665039f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906975; x=1693511775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIcsopYxpjrsNYoBSXByekSWxiDJtKrJwLaIjXhsxTc=;
 b=YIk5wUD1VSOR+ljBTvtUe6BS8nHWRfZZxG5yjkUw3cW54i+SXvsBv8hkjV6BFAohTb
 L1kpzLv6ksIwFfRFNQZroelaLV//9aR2Jvi4VHBEyjrtCS+OBwyI3m7wXHwm5S8A+LYa
 nTwBVgJHqGlyCOyX718kye/hvsbV0M60ZNfes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906975; x=1693511775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIcsopYxpjrsNYoBSXByekSWxiDJtKrJwLaIjXhsxTc=;
 b=HNZ97r0dTGDuB53QNLnGe3vUOKPlYEfmAgmrHmmDaJPlF4wDZmftXWixbWLuLpgHXk
 +y8wiEYcEPFuw45pI2gMw0a4sZrOm5cR+nzByjrRCoBJVXXhkNzBROxXE3ZFdC8j3Nec
 ULQ2CBRlmIXKKg2RlLO4cTQ3ywqc+tocS3LU7+zbYpORP0f7s0m1Pll7d5Ec/yyZHpat
 NiAmaYeukIqKKQVLborwYIkayAk2O1Xl2qMYFAC02pmPmArznoCAcWpeamEdO2YVn93p
 ACnqaI+WM43y+v4bfJJebhAD7LtY8SitTy91H9Wr0eoy0WjFzrKS53hrW3QsAIq285y4
 p9cQ==
X-Gm-Message-State: AOJu0YzI3+27WhqiIIlHtxLzL82IAL2SIsIERUPByfIIkHfA8gSrPF8M
 jDoBy3LWADNzWk6FUSBYM6ufPnN1EWssrPtv3Bw=
X-Google-Smtp-Source: AGHT+IHSxxoo+90o+FRGYPtiPTt0RU3u0ulmutpAVdbaVVMqIPa7i+2MEI9bnNi0IR72uT9wrPouog==
X-Received: by 2002:a5e:c102:0:b0:788:2eaf:46ce with SMTP id
 v2-20020a5ec102000000b007882eaf46cemr7624470iol.9.1692906975023; 
 Thu, 24 Aug 2023 12:56:15 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 19/23] part: Add a fallback for part_get_bootable()
Date: Thu, 24 Aug 2023 13:55:42 -0600
Message-ID: <20230824195553.1685996-20-sjg@chromium.org>
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

This function can be called when partition support is disabled. Add a
static inline to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/part.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/part.h b/include/part.h
index 16ba8c102535..f321479a5e91 100644
--- a/include/part.h
+++ b/include/part.h
@@ -372,14 +372,6 @@ part_get_info_by_dev_and_name_or_num(const char *dev_iface,
 }
 #endif
 
-/**
- * part_get_bootable() - Find the first bootable partition
- *
- * @desc: Block-device descriptor
- * @return first bootable partition, or 0 if there is none
- */
-int part_get_bootable(struct blk_desc *desc);
-
 struct udevice;
 /**
  * disk_blk_read() - read blocks from a disk partition
@@ -670,12 +662,24 @@ static inline struct part_driver *part_driver_get_first(void)
  */
 int part_get_type_by_name(const char *name);
 
+/**
+ * part_get_bootable() - Find the first bootable partition
+ *
+ * @desc: Block-device descriptor
+ * @return first bootable partition, or 0 if there is none
+ */
+int part_get_bootable(struct blk_desc *desc);
+
 #else
 static inline int part_driver_get_count(void)
 { return 0; }
 
 static inline struct part_driver *part_driver_get_first(void)
 { return NULL; }
+
+static inline bool part_get_bootable(struct blk_desc *desc)
+{ return false; }
+
 #endif /* CONFIG_PARTITIONS */
 
 #endif /* _PART_H */
-- 
2.42.0.rc1.204.g551eb34607-goog

