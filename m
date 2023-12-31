Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15174C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C94068788A;
	Sun, 31 Dec 2023 16:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GztbTAmQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D9758785D; Sun, 31 Dec 2023 16:26:18 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC0C38785E
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7bb0af58134so208146639f.3
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 07:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704036370; x=1704641170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7mmEqgZuP8OrVTbhMfrsTBnCy7cFUB4d+YOmNLSr/w=;
 b=GztbTAmQUgEOeILDn+754CUkxKzLqddkOCW+y8gKX9asHbPpfwUGP+2SWLBNrNH01J
 0mx5dxf79ZEwcqOE90WjhiT4bbEZrAsomyRpHUk+RCwfHqMrrxy12XNlGkQULIOs1VWl
 lNEl0rR5Gk/CwF2BTP4MgJOCKUsDuY89peFhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704036370; x=1704641170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P7mmEqgZuP8OrVTbhMfrsTBnCy7cFUB4d+YOmNLSr/w=;
 b=G0N0MZCXDVALDvUiPB16ir6fdEIlcYT8Yiz2bYvxMemglvl9RwKkvlTol2A+V3TlLr
 4Ymw+iOD17+6T1XQaQOmcvvwyhGOOnOoGnXRQO3QG1X7zRlcRGZ8imIQxfc1/uAYlR7W
 x+4Fx+r7icjx4U483uksbaGLfgn514SFWJ8oon9Cj/OC5SNYGSD+3POucfr31XSWKgI3
 GgJoKYC7ZERSIXZpdfJ4S8aknubmMXYsI3gsukiStrpfgmUWiSGkDPkNEq9CxNJDeAau
 VRtAK33VoFz5z4j1qArW9WuA36WqG54etCDKulc1wf0Ng4qUNADZEEwXh4w2BK/TlQ9A
 C/sw==
X-Gm-Message-State: AOJu0YynQ7pKIYyP+gU7L0fllWmDW6Mqk9fLZX14e68bVacwp05DMGoX
 bq8FASfsirNHWJKoUWVFI6K2KfmKxcLg9/7Q3LOOV7n9OtDH
X-Google-Smtp-Source: AGHT+IGhBNB91qVjm9FONi4NDBQKw+Y1S2CIc2cG5YAedGZDuWQEI1Jw7+20UWBIxFwEab56pv1p8Q==
X-Received: by 2002:a6b:7302:0:b0:7ba:9b3b:faf2 with SMTP id
 e2-20020a6b7302000000b007ba9b3bfaf2mr21722805ioh.3.1704036370554; 
 Sun, 31 Dec 2023 07:26:10 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cz9-20020a0566384a0900b0046b482039ecsm5632625jab.55.2023.12.31.07.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 07:26:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v5 01/12] smbios: Refactor 32-bit code into an else statement
Date: Sun, 31 Dec 2023 08:25:44 -0700
Message-Id: <20231231152555.464874-2-sjg@chromium.org>
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

In preparation for adding support for SMBIOS3 move this code into an
else statement. There is no functional change.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 lib/smbios.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index 45480b01af4..b417f8a9057 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -589,14 +589,6 @@ ulong write_smbios_table(ulong addr)
 		len += tmp;
 	}
 
-	memcpy(se->anchor, "_SM_", 4);
-	se->length = sizeof(struct smbios_entry);
-	se->major_ver = SMBIOS_MAJOR_VER;
-	se->minor_ver = SMBIOS_MINOR_VER;
-	se->max_struct_size = max_struct_size;
-	memcpy(se->intermediate_anchor, "_DMI_", 5);
-	se->struct_table_length = len;
-
 	/*
 	 * We must use a pointer here so things work correctly on sandbox. The
 	 * user of this table is not aware of the mapping of addresses to
@@ -612,16 +604,28 @@ ulong write_smbios_table(ulong addr)
 		       (unsigned long long)table_addr);
 		addr = 0;
 		goto out;
+	} else {
+		memcpy(se->anchor, "_SM_", 4);
+		se->length = sizeof(struct smbios_entry);
+		se->major_ver = SMBIOS_MAJOR_VER;
+		se->minor_ver = SMBIOS_MINOR_VER;
+		se->max_struct_size = max_struct_size;
+		memcpy(se->intermediate_anchor, "_DMI_", 5);
+		se->struct_table_length = len;
+
+		se->struct_table_address = table_addr;
+
+		se->struct_count = handle;
+
+		/* calculate checksums */
+		istart = (char *)se + SMBIOS_INTERMEDIATE_OFFSET;
+		isize = sizeof(struct smbios_entry) -
+			SMBIOS_INTERMEDIATE_OFFSET;
+		se->intermediate_checksum = table_compute_checksum(istart,
+								   isize);
+		se->checksum = table_compute_checksum(se,
+					      sizeof(struct smbios_entry));
 	}
-	se->struct_table_address = table_addr;
-
-	se->struct_count = handle;
-
-	/* calculate checksums */
-	istart = (char *)se + SMBIOS_INTERMEDIATE_OFFSET;
-	isize = sizeof(struct smbios_entry) - SMBIOS_INTERMEDIATE_OFFSET;
-	se->intermediate_checksum = table_compute_checksum(istart, isize);
-	se->checksum = table_compute_checksum(se, sizeof(struct smbios_entry));
 out:
 	unmap_sysmem(se);
 
-- 
2.34.1

