Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DF6E95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 14:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E2DB86B7E;
	Mon,  9 Oct 2023 16:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="dSqe/SrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A3986D9D; Mon,  9 Oct 2023 16:42:12 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1694986C1E
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 16:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50305abe5f0so6112088e87.2
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 07:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1696862529; x=1697467329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d2pRMuliat9q5d7LR7qxA0hQQ3Vjo0is2X20X08B+8A=;
 b=dSqe/SrWhcf/Xsar1koVZApir6l3YKjtBVzZBxAF9/hb12nNjzKk/Oxx2igRekiH2N
 wU1VUDuimeDZ/Bmy2UnOi31FK1bXVlYVBFbOK4S/nv6XfaJQMfLCeu0ftmuvL9Fx8OMF
 a4yYmKn311mGMMroZunyZ2+TaTPeWPnP1CkQRnCQVokP0zfq2lG8Ng0iXWGGW86hEFMG
 Dlg6+og9ZoDovcER0CRXVgi2T4lll41HDPrN/gnc9S5/M6vYB6k3aSUUi0GbOueyrR8W
 OF7wN1b4Ie8oZIaroQKokP1xxC8dl66wB9CAENwLmuylDhkB/KTQqlx3LxQGh1L9Hy3T
 gb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696862529; x=1697467329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d2pRMuliat9q5d7LR7qxA0hQQ3Vjo0is2X20X08B+8A=;
 b=KiK1CJ1oJaQ2vFuTOaSyS/hX58jTiHabpBmYJKcFZuQbx/p3rXg+MhK9pOPx27gM0i
 2NYHOcUtMbtgkfdxrSmfNVc7QIGxCbzGvOWWka4PoGDk7QVr3zYnQAVUD7TFRxYI9BFW
 yKFrICbWF//xADYMjRj5B6leeqf0dZiPWli1KbCgL+LCgL8HEG6DanVqXOI0zayciIy4
 0Rtkyzh+zqlkbN2UZAGuIWrRdCYzq/ZqeqfTWAdCO0RSoLcb5e3e7Z/90Q+CmtnBK9jW
 o6lUv9B1C01q0FxJz+F9TJqcd+U+RL9eXy2avbYj8WuSg6rbw9qoJ0xxE3CbcUvE/8Ap
 z4ig==
X-Gm-Message-State: AOJu0YyLHJ03IG9Add/UqxkwU7DlmcPAZwfQ1tY7sFW2QlNnl1svXINM
 D4oBjdTkL8XHtjhUm4fJRxGVxQ==
X-Google-Smtp-Source: AGHT+IEMJmtvUlLCmSUlQ0eQeWcI0g1KA2iDw3BsXobn1MG0RJuJMKtJ3vQBeXf+5as92L72jXAsfA==
X-Received: by 2002:a05:6512:344d:b0:4ff:a8c6:d1aa with SMTP id
 j13-20020a056512344d00b004ffa8c6d1aamr11788677lfr.48.1696862529113; 
 Mon, 09 Oct 2023 07:42:09 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 f19-20020ac25333000000b005045bb669d7sm1464733lfh.62.2023.10.09.07.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 07:42:08 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Simon Glass <sjg@chromium.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jakub Klama <jakub@conclusive.pl>, Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v4 1/4] common: add prototype & rename populate_serial_number()
Date: Mon,  9 Oct 2023 16:41:48 +0200
Message-ID: <20231009144151.773721-2-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009144151.773721-1-artur@conclusive.pl>
References: <20231009144151.773721-1-artur@conclusive.pl>
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
serial_read_from_eeprom() and provide the missing function prototype.

This is useful for boards that wish to read their serial number from
EEPROM at init.

Signed-off-by: Artur Rojek <artur@conclusive.pl>
---

v4: - revert to the approach found in v2
    - keep the new serial_read_from_eeprom() name

v3: - restore original function name and make it static
    - provide a generic function for reading EEPROM serial number and
      wrap it around the existing tlv logic
    - move the env var check out of populate_serial_number() and into
      the new serial_read_from_eeprom() in order to stay consistent with
      the documentation

v2: - rename the function
    - move function documentation from .c file to the prototype location

 cmd/tlv_eeprom.c | 14 +-------------
 include/init.h   | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/cmd/tlv_eeprom.c b/cmd/tlv_eeprom.c
index 79796394c5c8..57cfd355df1b 100644
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
+int serial_read_from_eeprom(int devnum)
 {
 	char serialstr[257];
 	int eeprom_index;
diff --git a/include/init.h b/include/init.h
index 4e7fe26c2004..d57a24fd00dd 100644
--- a/include/init.h
+++ b/include/init.h
@@ -271,6 +271,20 @@ void board_init_r(struct global_data *id, ulong dest_addr)
 
 int cpu_init_r(void);
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
+int serial_read_from_eeprom(int devnum);
 int set_cpu_clk_info(void);
 int update_flash_size(int flash_size);
 int arch_early_init_r(void);
-- 
2.42.0

