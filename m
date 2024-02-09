Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7687C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 15:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59A7D87E83;
	Fri,  9 Feb 2024 16:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bhVb/D3x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E1487E70; Fri,  9 Feb 2024 16:51:39 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F5387E74
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 16:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B70AF40A2B
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 15:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707493893;
 bh=GznVGRl3+h4pqZJpRoPqckiO3GDXVwB88+1KfwtC0sg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=bhVb/D3xl7vmcQassqDbu/Gn6UmEp6SdidhoSENzD0AFehKz/iivz+VpEmS46YGWn
 tpsQUq3t+MFURn+YI0WkFGUQVKOPUIb1I/AO42DnXyE6UBRQT8WeLSwih25I1ZjldL
 MoDc0k6CAJyrTJJgTnJEzST+5XuGYpBt1i8xd+fmCrqVMEcvUuekfy3xSbquKsuf8R
 ukuOMNLZR9ctw2KsrrnD0rBSgOBPkOQlpMIXa3De1z/rCMqfDOwLTzjrc9merYdWEK
 tg62WiyFB8V1aaByjphhRINk3fp8jF89gfH8Lv73jntoCscjC1H3cT16B95jk4phQ2
 R5dR42Xe3zBPA==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a2c4e9cb449so74388066b.1
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 07:51:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707493891; x=1708098691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GznVGRl3+h4pqZJpRoPqckiO3GDXVwB88+1KfwtC0sg=;
 b=wGZKJqlNFSr5wEyHLfDpmMkNlFiJFJPITQhiuBbLhwaMbf54FEeLq3m0AOH+mZ9/iO
 I3efBVanVY9tjryWSi58ehf+LWyCbzlRb3fTGQtvIs6ZnQWVARdXKAtYdemLzFX6PI/d
 THfKQpGdAobXUCB2GunEt8H4ha0RCA1Ai75pMNRxyQvhDQyEVo445MFnZfJaaC8XbwAv
 pG0XmgfoeAP6QPu5M1HhYuTDdt/NqwvAsTIUziv27j4X7FrrZKe+eEbt25uCX/xDFvLi
 2AxYYL9PP4w9AnocIutXj8vvc30o5si0DpWRCXSStohS6iaC8A2wq+hxzw5qUXG3Pez8
 pI8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAxPw/GmUYf4jxKt4e5ktNUNuhSLSHZpg6/P6N6qyzQ7D9kzAD9le0H42WwNi1Ls5uXRQIHX1JbYoguv3wcz4ZugEAjw==
X-Gm-Message-State: AOJu0Yyogovm8rqtbpLGRDiWGJgBqx3BkR+4GTbU8AxlA8IsNiF6E5Wv
 v6vcxRGo+U5zPWwRRnV/vJqeWKSVUHHEkJ/S5+IWe8JnW1U+xJ9oQ2d5GLnInoPgDZj/gip9cDS
 KVikyRz9och6E66zBjrHmTYgMYLVI0xFNWIuxat4H7M+A2frEOeBzgVNvf2YiwhvfLtY=
X-Received: by 2002:a17:907:111a:b0:a38:4842:56da with SMTP id
 qu26-20020a170907111a00b00a38484256damr1685780ejb.61.1707493891560; 
 Fri, 09 Feb 2024 07:51:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuEkjn2676a4LNrNrIRIO0SXd571YENhxTg9qjiNbid41LodW1Y5nPd2Uo9JRFhYINMGptgA==
X-Received: by 2002:a17:907:111a:b0:a38:4842:56da with SMTP id
 qu26-20020a170907111a00b00a38484256damr1685763ejb.61.1707493891204; 
 Fri, 09 Feb 2024 07:51:31 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUjFrK6DOrPUvHqDVqrHMvLyWQmTSJSGXMob1hk5BgUTl3bvZphOMBxJdf7dBNDOL2zsQgbXl5WhhoRkjNnhT6HfYnAl5mdOQ8FwhA8XSAEpndL34eoSjbI2WxbvuezLQh3X/1lk47KMydOCEDHbJz9kzUiyyRolk3Y53AUlPFmyTQL5zxL1mERghc3pnmkZHyn6pOYiyqhP8mMCKGW
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a17090655ca00b00a38620c3b3dsm866944ejp.198.2024.02.09.07.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 07:51:30 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/2] cmd: smbios: type 1 wake-up time, family
Date: Fri,  9 Feb 2024 16:51:14 +0100
Message-ID: <20240209155115.102957-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209155115.102957-1-heinrich.schuchardt@canonical.com>
References: <20240209155115.102957-1-heinrich.schuchardt@canonical.com>
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

Correct type 1 output

* render wake up time as string
* print family string
* remove duplicate serial number output

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 cmd/smbios.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/cmd/smbios.c b/cmd/smbios.c
index 66f6b761378..d3bd8b12a67 100644
--- a/cmd/smbios.c
+++ b/cmd/smbios.c
@@ -14,6 +14,18 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+static const char * const wakeup_type_strings[] = {
+	"Reserved",		/* 0x00 */
+	"Other",		/* 0x01 */
+	"Unknown",		/* 0x02 */
+	"APM Timer",		/* 0x03 */
+	"Modem Ring",		/* 0x04 */
+	"Lan Remote",		/* 0x05 */
+	"Power Switch",		/* 0x06 */
+	"PCI PME#",		/* 0x07 */
+	"AC Power Restored",	/* 0x08 */
+};
+
 /**
  * smbios_get_string() - get SMBIOS string from table
  *
@@ -72,6 +84,14 @@ void smbios_print_str(const char *label, void *table, u8 index)
 	printf("\t%s: %s\n", label, smbios_get_string(table, index));
 }
 
+const char *smbios_wakeup_type_str(u8 wakeup_type)
+{
+	if (wakeup_type >= ARRAY_SIZE(wakeup_type_strings))
+		/* Values over 0x08 are reserved. */
+		wakeup_type = 0;
+	return wakeup_type_strings[wakeup_type];
+}
+
 static void smbios_print_type1(struct smbios_type1 *table)
 {
 	printf("System Information\n");
@@ -81,11 +101,12 @@ static void smbios_print_type1(struct smbios_type1 *table)
 	smbios_print_str("Serial Number", table, table->serial_number);
 	if (table->length >= 0x19) {
 		printf("\tUUID: %pUl\n", table->uuid);
-		smbios_print_str("Wake Up Type", table, table->serial_number);
+		printf("\tWake-up Type: %s\n",
+		       smbios_wakeup_type_str(table->wakeup_type));
 	}
 	if (table->length >= 0x1b) {
-		smbios_print_str("Serial Number", table, table->serial_number);
 		smbios_print_str("SKU Number", table, table->sku_number);
+		smbios_print_str("Family", table, table->family);
 	}
 }
 
-- 
2.43.0

