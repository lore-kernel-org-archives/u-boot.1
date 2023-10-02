Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E93E7849A
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 12:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63B0C86DAD;
	Mon,  2 Oct 2023 14:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="aAR7gdsx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BBCB86DFA; Mon,  2 Oct 2023 14:42:59 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D4E180834
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 14:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-503397ee920so24989593e87.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1696250575; x=1696855375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DoxVScwTBE3MIbFUBvAq+1CsqDIxqKVhfF3fB3WFuJc=;
 b=aAR7gdsxe+gZUSVRA5qQAY3GAeNKzA9q5PWSPjpb9JWyxhz7f83Kzm5jXachTi5tXk
 s0TG3Y7WOoKCtmt+NNV6YredO4AHmjfDQcF+J7erxfT0byv+N0mcv6cfUNFDQHHur6co
 xtoTwQ9QCIN+8yhw07YP1//pn5ZlNPuOKM32LX96SIFmCtfA826Ba9ehh2SSw3Richfd
 tApua11e1AthGP6PwXZ1JAkIHP1CGfIhe7FAhQdQfojYdCLlM5Bdv1fz9V5Z1bHk9/2Q
 f2W+iSsv2ZQQpNj56+29j/52VAmXW2dJYCo2nOXk69Fw3TaHbPuAaJ4PwT5Lpqxr3MeN
 IJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696250575; x=1696855375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DoxVScwTBE3MIbFUBvAq+1CsqDIxqKVhfF3fB3WFuJc=;
 b=JN9oQPJT2330VifeE6SPm7D+Wdzuf9RQgZneGUMQpHwgS2QiJKHOkPNgvF1S17wOhl
 jspmk7jh585M5WgVgBF6Rxz9AzkalKfY6aNrKvlqvItK9w7ijDAugDiV+WY87TvwJP22
 5z4A88TUduJgej+FlKhpBGaKTGQwJetLbP06rEXDWMxUMWdoQ/YtqXNcoIFysJ59npIa
 Ct2fpR1/MzKQNMq1wK5usGeOwiSk4P+WCq80Jq8yUVEFkcHPt/KCFHqIZi6jSx3cbda9
 5xJmxcV3FepsrdJHr1ttzS839XYQ9FDUoZbFk32hupF2Z9qFaoUnZFrn+gx7sgSdM1tP
 tnZw==
X-Gm-Message-State: AOJu0YyNYkAsQizsfUmJ5mfHHSgtEit7733Pnxpgl7k+3C0tc02BAN47
 0RpYfz3Qf3jVxlo7rTiVBVwZtmfqKEEfMwfl8qrQzw==
X-Google-Smtp-Source: AGHT+IFsUvza2J6YvVmRetaiOA3OyMQqRDyHOGRU7ZFKYYMpPAu4QTqY4cflDxEoxqy9x4afZVu1OA==
X-Received: by 2002:a05:6512:3ee:b0:502:d5b0:436e with SMTP id
 n14-20020a05651203ee00b00502d5b0436emr7996903lfq.62.1696250575512; 
 Mon, 02 Oct 2023 05:42:55 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 e8-20020ac25468000000b004faa2de9877sm4719316lfn.286.2023.10.02.05.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 05:42:55 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v3 1/4] common: Add generic function for reading serial number
Date: Mon,  2 Oct 2023 14:42:14 +0200
Message-ID: <20231002124217.68220-2-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231002124217.68220-1-artur@conclusive.pl>
References: <20231002124217.68220-1-artur@conclusive.pl>
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

Provide a generic way for boards to read their serial number from EEPROM
at init.

If CONFIG_ID_EEPROM is set, the new serial_read_from_eeprom() function
will now be called during the post-relocation part of the board init.

Provided is the tlv eeprom implementation of the above function, making
use of the existing, yet never utilized, populate_serial_number().
Boards which use custom logic for interaction with their EEPROMs need to
supply their own implementation.

Signed-off-by: Artur Rojek <artur@conclusive.pl>
---

v3: - restore original function name and make it static
    - provide a generic function for reading EEPROM serial number and
      wrap it around the existing tlv logic
    - move the env var check out of populate_serial_number() and into
      the new serial_read_from_eeprom() in order to stay consistent with
      the documentation

v2: - rename the function
    - move function documentation from .c file to the prototype location

 cmd/tlv_eeprom.c | 25 +++++++++----------------
 common/board_r.c |  8 ++++++++
 include/init.h   | 14 ++++++++++++++
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/cmd/tlv_eeprom.c b/cmd/tlv_eeprom.c
index 79796394c5c8..9aa9b070473e 100644
--- a/cmd/tlv_eeprom.c
+++ b/cmd/tlv_eeprom.c
@@ -1088,27 +1088,12 @@ int mac_read_from_eeprom(void)
 	return 0;
 }
 
-/**
- *  populate_serial_number - read the serial number from EEPROM
- *
- *  This function reads the serial number from the EEPROM and sets the
- *  appropriate environment variable.
- *
- *  The environment variable is only set if it has not been set
- *  already.  This ensures that any user-saved variables are never
- *  overwritten.
- *
- *  This function must be called after relocation.
- */
-int populate_serial_number(int devnum)
+static int populate_serial_number(int devnum)
 {
 	char serialstr[257];
 	int eeprom_index;
 	struct tlvinfo_tlv *eeprom_tlv;
 
-	if (env_get("serial#"))
-		return 0;
-
 	if (read_eeprom(devnum, eeprom)) {
 		printf("Read failed.\n");
 		return -1;
@@ -1123,3 +1108,11 @@ int populate_serial_number(int devnum)
 
 	return 0;
 }
+
+int serial_read_from_eeprom(void)
+{
+	if (env_get("serial#"))
+		return 0;
+
+	return populate_serial_number(0);
+}
diff --git a/common/board_r.c b/common/board_r.c
index 4aaa89403117..0f2cbf7bd741 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -121,6 +121,13 @@ __weak int fixup_cpu(void)
 	return 0;
 }
 
+#if defined(CONFIG_ID_EEPROM)
+__weak int serial_read_from_eeprom(void)
+{
+	return 0;
+}
+#endif
+
 static int initr_reloc_global_data(void)
 {
 #ifdef __ARM__
@@ -714,6 +721,7 @@ static init_fnc_t init_sequence_r[] = {
 	cpu_secondary_init_r,
 #if defined(CONFIG_ID_EEPROM)
 	mac_read_from_eeprom,
+	serial_read_from_eeprom,
 #endif
 	INIT_FUNC_WATCHDOG_RESET
 #if defined(CONFIG_PCI_INIT_R) && !defined(CONFIG_SYS_EARLY_PCI_INIT)
diff --git a/include/init.h b/include/init.h
index 3bf30476a2e0..df218c95de42 100644
--- a/include/init.h
+++ b/include/init.h
@@ -283,6 +283,20 @@ void board_init_r(struct global_data *id, ulong dest_addr)
 int cpu_init_r(void);
 int last_stage_init(void);
 int mac_read_from_eeprom(void);
+
+/**
+ *  serial_read_from_eeprom - read the serial number from EEPROM
+ *
+ *  This function reads the serial number from the EEPROM and sets the
+ *  appropriate environment variable.
+ *
+ *  The environment variable is only set if it has not been set
+ *  already. This ensures that any user-saved variables are never
+ *  overwritten.
+ *
+ *  This function must be called after relocation.
+ */
+int serial_read_from_eeprom(void);
 int set_cpu_clk_info(void);
 int update_flash_size(int flash_size);
 int arch_early_init_r(void);
-- 
2.42.0

