Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58A3C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 10:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBEE687E36;
	Thu,  8 Feb 2024 11:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lxZXUWKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D3938785E; Thu,  8 Feb 2024 11:50:09 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69C1C86D9E
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 11:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8ED9C40A27
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 10:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707389401;
 bh=yCjGlLpGJWW6X1j33LnbbvVGKUs52mDWcG0NS1S+m2w=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=lxZXUWKH/b8Kr9TaW0R2j+iU9pqdGgYinuUqY+XTw9wVlcaKDcK7UBsvvhxOqgQoP
 DK+C9hBuC61Ff93t1dfJ0TyzCpvEEvvEZZGVYcBNM5EiPTZJE/4kuJG8mB5HavS6Ke
 jLoZgZP6HCHQGtb/uAWlWQLAAuPrx0lmi4eV3QijK7JhmTxyuUJzDmewO3Baer2Cq3
 K5KiXO2eOjSqHXvx1L9qmfL3qmiIgohmamUzx1v7boqBWMoOsNld1k+J6GCVk4RVtC
 cP1nRbRt9q7IQuQfBWsrRGg1cAHnHk/pgl/gAH2Xb7+GS/z6YmZ4R0wBjECccEebGY
 irgho6tYNd+UQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40fb1690f94so3679385e9.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 02:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707389401; x=1707994201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCjGlLpGJWW6X1j33LnbbvVGKUs52mDWcG0NS1S+m2w=;
 b=KcEyeQTuz+GX0gmUc5qQkd54/9oq8NdpSKhgJ+qfDTCJIfnTPBZzMQPOEmbqmxKjHJ
 IpsesmzeBENm5iXawxYbrs/okqh8eAwB9wfK7esAmPDbBXSWPICRBY/RNqJXtkpyZ6xN
 QPyJ0LWSageXuOGAW1dSpp8FcabmeXci7gOPVDXOxmAsTXGYW0Gc+Red1pASTRSKsfQY
 XgHQMfX8wYvoPcR/CDW03IViB+yIDSjDQGg8B11u3tOjylltod9LbVaZfMIX5hpG0Xlk
 xaORpxL0Vvljl86YiYaaxl2Ovrl3eygnjqBfY5UIiLrTkLJ+ksdE1eQ62u/FtkP/QSne
 IQvA==
X-Gm-Message-State: AOJu0YykH/AXurVVjjVzHe4fAdXkjPw8/bzBZqiXZIQfAedcxmfFeC8D
 9NG4ZVOeUaMH2AaAK+h5A4Q51gYeY6pt+gsVryyNWxAPDg5SZSMKRV62QTE+tBtb8V13bPHAPR+
 ULh/jw5lBfa0IFT69IMbxsnY/RHhfjXQSSqVh90EgABqPdSaYEwMoh1szcrYsIfkS513VsVJig7
 M=
X-Received: by 2002:a05:600c:4fd3:b0:40f:d145:63cb with SMTP id
 o19-20020a05600c4fd300b0040fd14563cbmr1698268wmq.9.1707389401084; 
 Thu, 08 Feb 2024 02:50:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsyxGjyAZR/hEh+YDDVh73k79O5orQa3c3XEicZYbuF+Gv5qBDZzwibVDzlP5lXTNQONNbBQ==
X-Received: by 2002:a05:600c:4fd3:b0:40f:d145:63cb with SMTP id
 o19-20020a05600c4fd300b0040fd14563cbmr1698257wmq.9.1707389400833; 
 Thu, 08 Feb 2024 02:50:00 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXccCmfP7Kqdesft02cFD3HiAy0u5bBP4Y09DPJChpM4O1ItMTJM9EDA1m38wyGk7wUlf8sOxybF9XQ4Nz8iby7ld7yqsJ9lQKFDTxmRSLPiNkylKKgcYvWpze6Soa/xs7dih2qOXFb
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 v12-20020a05600c470c00b0040ff7e3170asm1248348wmo.2.2024.02.08.02.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 02:50:00 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] cmd: smbios: type 1 wake-up time, family
Date: Thu,  8 Feb 2024 11:49:51 +0100
Message-ID: <20240208104952.19964-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208104952.19964-1-heinrich.schuchardt@canonical.com>
References: <20240208104952.19964-1-heinrich.schuchardt@canonical.com>
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
 cmd/smbios.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/cmd/smbios.c b/cmd/smbios.c
index 66f6b761378..f79619c1f0b 100644
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

