Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD603C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 129ED87897;
	Sun, 31 Dec 2023 16:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QjZGy6IK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60FF587886; Sun, 31 Dec 2023 16:26:17 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D3F87886
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7ba834684abso420253739f.2
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 07:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704036371; x=1704641171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8BNTG7muoWuaXnE+ORQo5Vv/TAOybzTE4xIJuy6YW0=;
 b=QjZGy6IKr2KDWhVD05ucGsBTEZ4E2OAVw0yT0+chcI+vp5IevlSSL/5z8YXlIGmT10
 D0p4oyIzJselGEQXhRui7THv6OwuyROhWFq+3jrjpbq0hD1AwPfIgQI/ubxamNoVBw3X
 XoZr6+DNeOM2UuC6er+UsJUVQGeEKpng1nIdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704036371; x=1704641171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i8BNTG7muoWuaXnE+ORQo5Vv/TAOybzTE4xIJuy6YW0=;
 b=iYtG+u8TX1OAwdx67FJGYGCxdX9JNCh2W53+imrp7AwHFnGGls0YRjVfHde/bN+wWN
 XsJyD0ECq/QAyuXaF+ho4UI11mLFWDFb1cyhhpr/6uQs0VPPD7mZqYvRRJGuseyMEiR/
 PdJVgkRrgbkMpA2qc7ET+hp+Hun31OVMMvj66r87hMJAWdUCHI9tolsPJY1jh4OtBNv9
 nHIP4EWiSnGPx/OmfvbeS6LF5cKb9rApwwXzHQT9fVs5GncFY1C6QaoZoWa6qF6RQtIB
 R8aF4QWtZX57eiPBUXOe2XMvWS7k9B3WA39hbxCsfesKB71nJ8nnm4KFSsvuutTnu+RK
 UVFA==
X-Gm-Message-State: AOJu0YzlzC3x+kt5ITUePJV9WaMLUJ1BWRv5xbF08iXQGV7OiogrRVD8
 PXVg3Dc7WRpowgbfi/tAgYqZEZ7wHqvE2dMvazzlfbl/Fdqv
X-Google-Smtp-Source: AGHT+IG0NAQdahGJi3mdlpex2zPuPdd/agdBPpF3ztBuvg7h/xZa5GAbcsaGvCyA4vbDceFrfNqEjg==
X-Received: by 2002:a6b:f10d:0:b0:7b7:f403:c068 with SMTP id
 e13-20020a6bf10d000000b007b7f403c068mr23071172iog.30.1704036371224; 
 Sun, 31 Dec 2023 07:26:11 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cz9-20020a0566384a0900b0046b482039ecsm5632625jab.55.2023.12.31.07.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 07:26:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v5 02/12] smbios: Move the rest of the SMBIOS2 code
Date: Sun, 31 Dec 2023 08:25:45 -0700
Message-Id: <20231231152555.464874-3-sjg@chromium.org>
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

Move all of this logic into the else clause, since it will not be used
for SMBIOS3

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 lib/smbios.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index b417f8a9057..eea72670bd9 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -544,9 +544,8 @@ static struct smbios_write_method smbios_write_funcs[] = {
 ulong write_smbios_table(ulong addr)
 {
 	ofnode parent_node = ofnode_null();
-	struct smbios_entry *se;
+	ulong table_addr, start_addr;
 	struct smbios_ctx ctx;
-	ulong table_addr;
 	ulong tables;
 	int len = 0;
 	int max_struct_size = 0;
@@ -566,9 +565,7 @@ ulong write_smbios_table(ulong addr)
 
 	/* 16 byte align the table address */
 	addr = ALIGN(addr, 16);
-
-	se = map_sysmem(addr, sizeof(struct smbios_entry));
-	memset(se, 0, sizeof(struct smbios_entry));
+	start_addr = addr;
 
 	addr += sizeof(struct smbios_entry);
 	addr = ALIGN(addr, 16);
@@ -603,8 +600,11 @@ ulong write_smbios_table(ulong addr)
 		printf("WARNING: SMBIOS table_address overflow %llx\n",
 		       (unsigned long long)table_addr);
 		addr = 0;
-		goto out;
 	} else {
+		struct smbios_entry *se;
+
+		se = map_sysmem(start_addr, sizeof(struct smbios_entry));
+		memset(se, '\0', sizeof(struct smbios_entry));
 		memcpy(se->anchor, "_SM_", 4);
 		se->length = sizeof(struct smbios_entry);
 		se->major_ver = SMBIOS_MAJOR_VER;
@@ -625,9 +625,8 @@ ulong write_smbios_table(ulong addr)
 								   isize);
 		se->checksum = table_compute_checksum(se,
 					      sizeof(struct smbios_entry));
+		unmap_sysmem(se);
 	}
-out:
-	unmap_sysmem(se);
 
 	return addr;
 }
-- 
2.34.1

