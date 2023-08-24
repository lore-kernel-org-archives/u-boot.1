Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0E6C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A90B86A11;
	Thu, 24 Aug 2023 21:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="db6Xqy1A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF9B86940; Thu, 24 Aug 2023 21:56:14 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03440868D0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7926b7f8636so7758739f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906968; x=1693511768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzrZadK5ex5Vo397SmAi24MaUsB88Q555oYC2iPbkVw=;
 b=db6Xqy1A0rr22U/0HbbQAebbWb60HUsi8Uf5tDCDP8XYq7sRQLjB1TOytvyIGf9Lcf
 FRqZvRRqpRRRbhjsBUk+Ub7TWWf7Q4RdX3NV/y8npa1vKoE49/Z3oM9kXyf959sb6nOp
 a6/04JDJb2KPPBc+RXAQXlIY13wxl03p/gNrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906968; x=1693511768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jzrZadK5ex5Vo397SmAi24MaUsB88Q555oYC2iPbkVw=;
 b=MURa3XmrpAaH3GepMfMXzDzOiGVqntCe+fZ6/H9wk/q5aJiMQjsFDDYAgmfjiXBgxj
 SWRvjjqr9fDHy5/2OT8BeFgFz9oLdV+k7zXyu2yA8pvKfWar8GVlyJ2hLbulNLp3/Yyh
 Uz4tKdjiNo4gdhej+AGIlzNJHWoq6KvX9VVT6+NfjANpD21hIMKAK3n9rxBVHNvIAUv1
 cZIzT3iJXqfeC+jJRXu0z1pTZ9a6eDZpqwuXuS0J3NrZAuFl3VLtoVaI9NGy2Yn1k1V6
 y5gKqR7i5LIl9nCXD2pKU/k9GL5dwv9c8z7GJVsqzf7nCcJYSVNIPb8pdilrbzA0nBcn
 UDpw==
X-Gm-Message-State: AOJu0YzdJWAEGbNkI0l+6FpClk4gTEPDL0vT7Ytp43iTrXNjHo3Lxz+Y
 0tCyFqt3Z2VpWzjlCbRalXlnmH4FUtTvp0Mz92g=
X-Google-Smtp-Source: AGHT+IEYn3F1miS9TvCniRTs6oVXQUkZ7jtXgr0aFb9NFlfy7gycPcWFlMsMiStD2Xv8g/gj+CHfig==
X-Received: by 2002:a6b:6d05:0:b0:790:b44f:b9ee with SMTP id
 a5-20020a6b6d05000000b00790b44fb9eemr5348378iod.10.1692906968668; 
 Thu, 24 Aug 2023 12:56:08 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 11/23] part: efi: Add debugging for the signature check
Date: Thu, 24 Aug 2023 13:55:34 -0600
Message-ID: <20230824195553.1685996-12-sjg@chromium.org>
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

Add a little more debugging for the initial signature check. Drop the
pointless check for NULL. Also set a log category while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 disk/part_efi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 208675213822..39382c5faee0 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -9,6 +9,9 @@
  *   when CONFIG_SYS_64BIT_LBA is not defined, lbaint_t is 32 bits; this
  *   limits the maximum size of addressable storage to < 2 tebibytes
  */
+
+#define LOG_CATEGORY LOGC_FS
+
 #include <common.h>
 #include <blk.h>
 #include <log.h>
@@ -976,17 +979,23 @@ static int pmbr_part_valid(struct partition *part)
 /*
  * is_pmbr_valid(): test Protective MBR for validity
  *
+ * @mbr: Pointer to Master Boot-Record data
+ *
  * Returns: 1 if PMBR is valid, 0 otherwise.
  * Validity depends on two things:
  *  1) MSDOS signature is in the last two bytes of the MBR
  *  2) One partition of type 0xEE is found, checked by pmbr_part_valid()
  */
-static int is_pmbr_valid(legacy_mbr * mbr)
+static int is_pmbr_valid(legacy_mbr *mbr)
 {
+	uint sig = le16_to_cpu(mbr->signature);
 	int i = 0;
 
-	if (!mbr || le16_to_cpu(mbr->signature) != MSDOS_MBR_SIGNATURE)
+	if (sig != MSDOS_MBR_SIGNATURE) {
+		log_debug("Invalid signature %x\n", sig);
 		return 0;
+	}
+	log_debug("Signature %x valid\n", sig);
 
 	for (i = 0; i < 4; i++) {
 		if (pmbr_part_valid(&mbr->partition_record[i])) {
-- 
2.42.0.rc1.204.g551eb34607-goog

