Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B292CC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 07:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54634877CD;
	Wed, 27 Dec 2023 08:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m15BI/sk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE6B87872; Wed, 27 Dec 2023 08:40:50 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7670F877CD
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-336746c7b6dso4519968f8f.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 23:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703662847; x=1704267647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQwHQofarpB7Eqh9D/wuXyXaOOzYC9hIzq+xrFD4nMU=;
 b=m15BI/skjV0SaxypwU0Jk6sB2riCLk2bIBcluZXvEodnLpBpIFr2f7MAI2sqRLx1aO
 aUUb/BPDgelq/AoGEKtjuajWWTDFI2s+jQvKxeNT/VjrdqJMB/pK6oDlAq+sJWO+lIrA
 VR4ijtYpQSTjsufrklFMkD4iVNQEmzzLoJaxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703662847; x=1704267647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQwHQofarpB7Eqh9D/wuXyXaOOzYC9hIzq+xrFD4nMU=;
 b=f/Q7m+FBfJbFeyo6Z2XoTrGQ6Vc47L+ItAbv2yn05A11J1QavOUMrUM7sNTYKoCqAq
 QVNRpoEf2/wG4Lg/5SGU8yg17oE0g/1KmbRv3JGdHQ4yvxUjGHrLdmeJ1+x2jEuOe+aN
 WIe20gwivh6raJhkuRWl09a5L3kIaB/UM05OKaI2qpgCVJxEpLcknBPF2vH2kEqBtoDn
 Ki7Y6cwxF4BoOllhRmsjlltEjufeSyI7wCL9m60phMcFFMkj56sWe09n5kdZttXdAAFG
 kh1Ta6Vx3nFEsqpMj+SLrhxqgT/8wnQnMVv8iHb3BDVOid5MxWkwv64n4Hg3JhFvkrZt
 iv2g==
X-Gm-Message-State: AOJu0YyyuWvJ62S2gw5OSkXX+V4lbNnC4iG2kdkE0yie9axdrrJv7XJP
 kO3jYAThfr1g74QNpUaVNE8dEAKvN8HQX86AJcwin4djbl4A
X-Google-Smtp-Source: AGHT+IGno/sgYvW3bwV+8UGylMxAmOHhSNFF4qKjvAJ/w5rrO9jKdvUf49QaqoQcuKW07hK9N6bMAw==
X-Received: by 2002:a05:600c:4d26:b0:40c:50d5:f7ac with SMTP id
 u38-20020a05600c4d2600b0040c50d5f7acmr4307592wmp.60.1703662846899; 
 Tue, 26 Dec 2023 23:40:46 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 s23-20020adf9797000000b00336813bb588sm14314426wrb.111.2023.12.26.23.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 23:40:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v4 2/7] smbios: Move the rest of the SMBIOS2 code
Date: Wed, 27 Dec 2023 07:40:19 +0000
Message-Id: <20231227074025.2178825-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227074025.2178825-1-sjg@chromium.org>
References: <20231227074025.2178825-1-sjg@chromium.org>
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

