Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E70C4829A
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 11:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9098287EA2;
	Sat, 10 Feb 2024 12:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OlmUYjkg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C4FE87E96; Sat, 10 Feb 2024 12:06:56 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88EA287E94
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 12:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9D8A840594
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 11:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707563213;
 bh=hAtM20NoYhjPxG3CO2SRjWjLWEu76GzHAjC/LSH9y48=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=OlmUYjkgCPX3NdSOyZuqO+UvAj6p8mF9s07EhG3Vr4Be82U5NiH9TVCQ6eEqhiEDX
 2Whi65OHzEyEayjpcz7UUjkSoLyY3Milb430QFjD+fMm6itbC/9sAvR0gWZcCo0bN7
 4UJ4YuF2OD5Sx/gSnuMmnvGI7hEoevkcRrvpinC8+3gHeyarW+nwWrO0S29vxIldyS
 AaAPDGLoDk0jYW51Jy4tR9deuee17J7BoEPbMV26M+vBPkPow6t5iUz1sEkAjkQJxh
 Q0Ug4RfXGkWqctAspFxOmWV5/XR2g8mDXM/HX9ilaYmkxxuSJDA7l6/NSuCeAb5POS
 0OUpHG0vZdarA==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41082621642so4418995e9.1
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 03:06:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707563213; x=1708168013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hAtM20NoYhjPxG3CO2SRjWjLWEu76GzHAjC/LSH9y48=;
 b=Y3gWJjoqdGc8DS6gZWrLCLAnhF25WfQi/DR5UBhLCy/FZ1lBp8QViRZ4kTfFHuEns9
 7eOpBZSCqeiNJiRP12GRGDeudPckt4/0MazxZcC51alneXSLYsPK7Ceb+rwvfUcJ4kan
 FbkoP/YXCV9FTfA2hXTAkl2NbszxGOWXn1PwhrLFGq1pbMDtmKcEiQFxjMvx4ArvMhoC
 cMG5kUqvln6F0ooHnmcPOGtred3/WL+qpk/7PEANynEhhT7w0OSb7N0UqPVh0stzadU1
 xF5gqXMTvKTQKB5NTGZXQcsXiUxZeddtzehtpQFextWpKNE4Sp17nsqQXAUF0QC2HHvi
 afew==
X-Gm-Message-State: AOJu0YwGSFJfYyumi+tHeDnVvOQrbwUC6GTFE4PtLACaJprG/9DbMvls
 Yw443SdLKSKWKKZHznJh0e3+SBdeOWEI12OmPgBIjZtCIKh9pqhcglwi05cD9ia7V1oFes6YQrv
 9F0erGFh/JSqNxOrI/vDqX71rmCg7Z2ZZDHKk2uAe9PApMRVuDXS3ruiDcZTgEm62Xe8=
X-Received: by 2002:a05:600c:19d3:b0:410:2b93:4908 with SMTP id
 u19-20020a05600c19d300b004102b934908mr1461567wmq.4.1707563213161; 
 Sat, 10 Feb 2024 03:06:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoorzWtNMi81MOH7B7Y+uYcR7/XpTzRspW9bLViiuIyn/yry3ceT1z2i6cGctgTKPsGV2zMA==
X-Received: by 2002:a05:600c:19d3:b0:410:2b93:4908 with SMTP id
 u19-20020a05600c19d300b004102b934908mr1461549wmq.4.1707563212707; 
 Sat, 10 Feb 2024 03:06:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXlzALZye6H+aX9Tq39vuiU58fTyGpk0aa3WmX0+5hPp6uxBvqXl2sSwdh/ieBkOtc+i/C6V2nuQUm4Llfir4FpeuqecVDt3uo83tuQ+zYYgNbZdAjAihy3fFU6Ds+KeMJWjqrDdouRKogl3p1/szxOGtpEmnRfKNRu
Received: from x13s.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 i5-20020a05600c290500b0040ef95e1c78sm3069231wmd.3.2024.02.10.03.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Feb 2024 03:06:52 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/2] cmd: smbios: type 1 wake-up time, family
Date: Sat, 10 Feb 2024 12:06:47 +0100
Message-ID: <20240210110648.21977-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210110648.21977-1-heinrich.schuchardt@canonical.com>
References: <20240210110648.21977-1-heinrich.schuchardt@canonical.com>
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
v3:
	no change
v2:
	no change
---
 cmd/smbios.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/cmd/smbios.c b/cmd/smbios.c
index 66f6b76137..d3bd8b12a6 100644
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

