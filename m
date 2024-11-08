Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D38D5C0C2
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDEFE891DB;
	Fri,  8 Nov 2024 14:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QbyQb6iT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 560D088B8F; Fri,  8 Nov 2024 04:45:26 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A58188B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7e9e38dd5f1so1380791a12.0
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 19:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731037523; x=1731642323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vcll6O17sa9AneFFHqS5EXLYPgcs38J6JPJAC9JsSB8=;
 b=QbyQb6iTIb3sY0XV4YjbMdbJqw16KLIme0kPRhvtVNjR0+0I6suBbtEzUniu4/r7Y/
 EAzPahJy1FUktJ7/hYVKXPoD103WaJDQmiqBljPaDYZ7K7gHvLAF1rm3AdXtpZhTaZwr
 kwKOz4crSJ39SCpUwXYM4vglRNL7S7EB3CXp9drX9a06gW9IdeKcrBh1ec2I2HaPSi0O
 0DNIAiRYmS1jDwC/spPVx5H/QXWtL9aD6TE1muunqsLFJiQ9yGkH9DxWBKpeZncONLHE
 Ep7GAR3NJD/LA6GwKz8u/gETY/EZQLdnwv+9ldiveajo9Q51d3R8RUtqn/9F223mCEkV
 UwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731037523; x=1731642323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vcll6O17sa9AneFFHqS5EXLYPgcs38J6JPJAC9JsSB8=;
 b=fuHr++bWitooVmIIJIfAUmRMkT9KjDQByBeAYmoX3C4xTw+6dQIz1ZN08cApSlSLsX
 9sHLsV6Vid9CDX6xU1jDafWALZjO0PfmZILDLQCnIiiOC83stDb2VU3ZgqcwDsW60uOP
 oc2+VlLM6fQxH1ikJlwHcsHJZoqfF2+FLyOOI92lij1c71Vt488gArXqRiuAe5WNoz/P
 G0EhAZ9+TmOHt/n2zp5+5Pa05mWllyh+zgSJXTTQ5wTE+1LbIxrq3kmTaOOPzZnxkupq
 LjtMZbHVt9lTmevHgnVmkdH1C7pKhyiKFbgILMlJVsPZa1QCBYvukPd1yDGZ2+s7YJbS
 3EEQ==
X-Gm-Message-State: AOJu0YwrXqzDQcPpUD2wTe6OjUJxzncaXRwiIs9Kos2PF3FN1Yj4gcbt
 PM/A8IDqvXztZkbSPBGx89saZmnMYCXDwuVvFHdUZpz17YM1YJOi05anhY3hYq4=
X-Google-Smtp-Source: AGHT+IFVNZZTDNbw7ekcDUau6/USgJ4SK2alvkELuaLOYTxD6WIwamxcGAxAkTWLgiz3OPrRt/zcOQ==
X-Received: by 2002:a05:6a20:9c91:b0:1db:f53d:f0c2 with SMTP id
 adf61e73a8af0-1dc22b92d7fmr2183069637.43.1731037522593; 
 Thu, 07 Nov 2024 19:45:22 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72407a571eesm2520802b3a.178.2024.11.07.19.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:45:22 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 03/15] efi_loader: device_path: add definition of
 DEVICE_PATH_SUB_TYPE_MSG_IPV4
Date: Fri,  8 Nov 2024 00:45:17 -0300
Message-ID: <20241108034517.346233-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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

Add definition for DEVICE_PATH_SUB_TYPE_MSG_IPV4 device path
subtype.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 include/efi_api.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/efi_api.h b/include/efi_api.h
index f07d074f93..c76519a20a 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -616,6 +616,7 @@ struct efi_device_path_acpi_path {
 #  define DEVICE_PATH_SUB_TYPE_MSG_SCSI		0x02
 #  define DEVICE_PATH_SUB_TYPE_MSG_USB		0x05
 #  define DEVICE_PATH_SUB_TYPE_MSG_MAC_ADDR	0x0b
+#  define DEVICE_PATH_SUB_TYPE_MSG_IPV4		0x0c
 #  define DEVICE_PATH_SUB_TYPE_MSG_UART		0x0e
 #  define DEVICE_PATH_SUB_TYPE_MSG_USB_CLASS	0x0f
 #  define DEVICE_PATH_SUB_TYPE_MSG_USB_WWI	0x10
@@ -691,6 +692,22 @@ struct efi_device_path_uri {
 	u8 uri[];
 } __packed;
 
+struct efi_ipv4_address {
+	u8 ip_addr[4];
+} __attribute__((aligned(4)));
+
+struct efi_device_path_ipv4 {
+	struct efi_device_path dp;
+	struct efi_ipv4_address local_ip_address;
+	struct efi_ipv4_address remote_ip_address;
+	u16 local_port;
+	u16 remote_port;
+	u16 protocol;
+	u8 static_ip_address;
+	struct efi_ipv4_address gateway_ip_address;
+	struct efi_ipv4_address subnet_mask;
+} __packed;
+
 #define DEVICE_PATH_TYPE_MEDIA_DEVICE		0x04
 #  define DEVICE_PATH_SUB_TYPE_HARD_DRIVE_PATH	0x01
 #  define DEVICE_PATH_SUB_TYPE_CDROM_PATH	0x02
-- 
2.43.0

