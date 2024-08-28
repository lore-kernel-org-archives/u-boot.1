Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30338C7112E
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 20:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7813A885A0;
	Wed, 28 Aug 2024 22:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nOMpD7Dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B4C5888A3; Wed, 28 Aug 2024 22:14:04 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44AB58862E
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 22:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-39f37387c21so2071375ab.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 13:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724876041; x=1725480841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Qsmyn6ODRsP1NSGK8axVeSZthqXw0UPVmGqTFS0g30=;
 b=nOMpD7DgLwmFUOJa6ueBZu6DTsjAETH5vwB3J1cwU46zteS0cGuma9yqEJJbM2DffZ
 Wo++zTAPFxFd54SrTPd54GzRMTVHwPht3OAhZ+u806ONbSPFVnu+aI6sYz85ws/Yx8/U
 PE1qkVN3jz7tLzcVoknsbxeQiHtNj1JKfM//o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724876041; x=1725480841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Qsmyn6ODRsP1NSGK8axVeSZthqXw0UPVmGqTFS0g30=;
 b=QSdamoTd6rMhV1ijb51xxFXSKZwIhlVDlQcDClkjRPZDmdvICAlZxDppP5X5snWTDB
 RyNULOyTZlDz4pIGpSa3VF9iV08nriAWRMTzOqmOHXMeamqljeU+7OVOjZs0xktbRusq
 5wgtx3383a3GSHgvT2/X6A1+mzM8glRS2vFnuEzR8Gok/AawUYqcZ5jYl+OCnLt4tBoO
 RZOWrcITd98DnUxyjdp0XwHEcI8z3iDFXQPO5Dvol0Yl6GqPJe2dpPA3r4SSNA6fK9u8
 V/fHWVEbGFTETeNrUjPR5EZ/PgXYwHvopcLnfYzennPpneu95NCNH9yw+jDp84dz4Nbl
 Fhgg==
X-Gm-Message-State: AOJu0YymaZv7b6tx2rvrdZrpkp2w4xZj9RWhfDoMgbh9X2+4Dow+RgbR
 IwkKx7B2RuACtRtASyuZgUJv4uZ8xWO+hci8IBBp6gPTHK9NiBe7NId7nppeYWQBnnYy0nIYiyY
 =
X-Google-Smtp-Source: AGHT+IHEOc0XK6G9578ExNm+CtHf/Z0zC9/0O7E0JY4BGwwXqszZbOZkQZK0DWbXgA9QkU+US9mSQw==
X-Received: by 2002:a05:6e02:188e:b0:399:4535:b66e with SMTP id
 e9e14a558f8ab-39f377e08bdmr9925755ab.9.1724876040898; 
 Wed, 28 Aug 2024 13:14:00 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e91f88sm348785ab.44.2024.08.28.13.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 13:14:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] x86: coreboot: Update the timestamp code to use sysinfo
Date: Wed, 28 Aug 2024 14:13:53 -0600
Message-Id: <20240828201355.1111764-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

Rather than using a special variable, get the timestamp info from the
coreboot sysinfo struct. Return a proper error as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/coreboot/timestamp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/cpu/coreboot/timestamp.c b/arch/x86/cpu/coreboot/timestamp.c
index ec4003c4e77..681191d85bb 100644
--- a/arch/x86/cpu/coreboot/timestamp.c
+++ b/arch/x86/cpu/coreboot/timestamp.c
@@ -6,13 +6,12 @@
  */
 
 #include <bootstage.h>
+#include <errno.h>
 #include <asm/arch/timestamp.h>
 #include <asm/cb_sysinfo.h>
 #include <asm/u-boot-x86.h>
 #include <linux/compiler.h>
 
-static struct timestamp_table *ts_table  __section(".data");
-
 void timestamp_init(void)
 {
 	timestamp_add_now(TS_U_BOOT_INITTED);
@@ -20,6 +19,8 @@ void timestamp_init(void)
 
 void timestamp_add(enum timestamp_id id, uint64_t ts_time)
 {
+	const struct sysinfo_t *info = cb_get_sysinfo();
+	struct timestamp_table *ts_table = info->tstamp_table;
 	struct timestamp_entry *tse;
 
 	if (!ts_table || (ts_table->num_entries == ts_table->max_entries))
@@ -37,13 +38,15 @@ void timestamp_add_now(enum timestamp_id id)
 
 int timestamp_add_to_bootstage(void)
 {
+	const struct sysinfo_t *info = cb_get_sysinfo();
+	const struct timestamp_table *ts_table = info->tstamp_table;
 	uint i;
 
 	if (!ts_table)
-		return -1;
+		return -ENOENT;
 
 	for (i = 0; i < ts_table->num_entries; i++) {
-		struct timestamp_entry *tse = &ts_table->entries[i];
+		const struct timestamp_entry *tse = &ts_table->entries[i];
 		const char *name = NULL;
 
 		switch (tse->entry_id) {
-- 
2.34.1

