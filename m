Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DEAE7E64B
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 16:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AE8686DAF;
	Tue, 26 Sep 2023 18:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="A4vZx8lO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8031986DC1; Tue, 26 Sep 2023 18:36:01 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9591A86D47
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 18:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c02e232c48so156359871fa.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1695746159; x=1696350959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xu43sRj5gHv7C+lZnOG3S0ytA7r5YrXVpIzgWuIXXu4=;
 b=A4vZx8lOMzUp5mFhvU7jMcNCZ1HPGmua5rKLn84HbUNQjoriqlTIVQF0WbzOeI0TUc
 ZfDfE6YgCbHPSOmj6cCbmsn2R+Uj7w49UBIVSeyY4E0OPockjPLSv3elxXET72o6OvCA
 8hdOvEbhvkwN9uyNSuF7RWnPA9nwWMeOgQ19m7nm4hHXqyyFA9vBFvIeaF1dbZ0nMEsr
 MMUlMVo5otUduRfQNMBgGUIQ81AIcYaAxsBDvqv7uCn+XHU3NMt/POddo0O8oRcPGEM8
 2xhDC36H1TlD1zFunpEumrQas35j2FdHc0nCwIoniOv1WhWJ44VxOp2nuwmmzTZs6oxJ
 k0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695746159; x=1696350959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xu43sRj5gHv7C+lZnOG3S0ytA7r5YrXVpIzgWuIXXu4=;
 b=ptelRd+UGgJxsJUWI0ID+RO7ws+1rmZjtr3JeC7sfFx+qToji8MX4a2qtg42WTdNuY
 FX5HMkFoVKr1dGWxDLO/061ZRcNp9VoB3OfiTTZlSCVeX7MQDSHbRebEo/pzjFjkoXFC
 cmijbMpWbsPsJtxRVulpq8fpsUiPAUnlwpWNUKWi/VZ6cLsRGu7mG8UJc1HX/HG6uG+U
 iXqCDb31seKcZgiAc2qQAGqGj1muY4dmrE9/TrYvN9yWVe9/PZIjdE9wKgCe4hRTsuqn
 IR35HuSrqGoNcHhEwdhtzT7np25GYraFc90lXOqOy2u7KmTQHtOtVxPYnGcoFhMetr94
 PLpA==
X-Gm-Message-State: AOJu0Yy/RXdUxpTwe03KmLX5d53w9olWWT8GWsvWXXgq5qg0I6gp/ON4
 vGxZBTzOLWp+JqjquEDongyY1g==
X-Google-Smtp-Source: AGHT+IHqKULhReFt0cmFaE1uRnkUaS083ha697OMNq9C+xUfDKCNZdh2PQFfOPQl8ERt9uZcTpG4+g==
X-Received: by 2002:a2e:3e0e:0:b0:2bc:e46d:f4ca with SMTP id
 l14-20020a2e3e0e000000b002bce46df4camr7971408lja.46.1695746158733; 
 Tue, 26 Sep 2023 09:35:58 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 x18-20020a2e9c92000000b002c12630e4d3sm2698544lji.127.2023.09.26.09.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:35:58 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>, u-boot@lists.denx.de,
 Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v2 1/3] common: add prototype & rename populate_serial_number()
Date: Tue, 26 Sep 2023 18:35:08 +0200
Message-ID: <20230926163510.219804-2-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926163510.219804-1-artur@conclusive.pl>
References: <20230926163510.219804-1-artur@conclusive.pl>
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

Rename populate_serial_number() to a more descriptive
eeprom_read_serial() and provide the missing function prototype.

This is useful for boards that wish to read their serial number from
EEPROM at init.

Signed-off-by: Artur Rojek <artur@conclusive.pl>
---

v2: - rename the function
    - move function documentation from .c file to the prototype location

 cmd/tlv_eeprom.c | 14 +-------------
 include/init.h   | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/cmd/tlv_eeprom.c b/cmd/tlv_eeprom.c
index 79796394c5c8..47c127ca4950 100644
--- a/cmd/tlv_eeprom.c
+++ b/cmd/tlv_eeprom.c
@@ -1088,19 +1088,7 @@ int mac_read_from_eeprom(void)
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
+int eeprom_read_serial(int devnum)
 {
 	char serialstr[257];
 	int eeprom_index;
diff --git a/include/init.h b/include/init.h
index 3bf30476a2e0..f18f3b9961d8 100644
--- a/include/init.h
+++ b/include/init.h
@@ -283,6 +283,20 @@ void board_init_r(struct global_data *id, ulong dest_addr)
 int cpu_init_r(void);
 int last_stage_init(void);
 int mac_read_from_eeprom(void);
+
+/**
+ *  eeprom_read_serial - read the serial number from EEPROM
+ *
+ *  This function reads the serial number from the EEPROM and sets the
+ *  appropriate environment variable.
+ *
+ *  The environment variable is only set if it has not been set
+ *  already.  This ensures that any user-saved variables are never
+ *  overwritten.
+ *
+ *  This function must be called after relocation.
+ */
+int eeprom_read_serial(int devnum);
 int set_cpu_clk_info(void);
 int update_flash_size(int flash_size);
 int arch_early_init_r(void);
-- 
2.42.0

