Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214E4CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 14:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D794B86FC5;
	Wed, 18 Oct 2023 16:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="ITb5qS/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A003986F94; Wed, 18 Oct 2023 16:01:41 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC24C86FB7
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 16:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b9d07a8d84so85134581fa.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1697637699; x=1698242499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZywHXq0DKOY4kDhAaecXD0ZweSv5orAU+XUoe/Z7gt8=;
 b=ITb5qS/haaoAH14DxmVGbwSzS+1nojP59uLhUzka2tcwcHaPRwGVyITKphKbHVevIi
 0gs6wai49WZQrODmRgiXToZIj3e61VUHXFoTPbecfi2JPYSclikZPpyKzVnW1oTYnQbZ
 rrWDjQ+rtLR6QrTCA13aunUqEPNoEhXXpF+ujDzWfHSoIhf8r54HXbAoDiI+0Zc97sGj
 ZcLYutBz4z9ytNEnTgjQ0cf2Imqh1zUBhdaaEa2z0gF0wOYOdT3XqoYmwkRtl9RP2e0X
 G8QEF+x7kn/JUO58on8LJXGs3ByaqBOn3W5vI4h/4WcZ+fFfhYH87Aa+E4s1xCE5Q08F
 zg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697637699; x=1698242499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZywHXq0DKOY4kDhAaecXD0ZweSv5orAU+XUoe/Z7gt8=;
 b=KYm3TovFrO53EjpoQb6PzBKqqKqck6UhYd+E1bUGB6bdVNFI8bItlBli33+/LT7e3s
 lurJ8NkCtf4Vvsor6dWOKqrTINmBA7PyKTo7OeRu7SEnAYxv1oSjihVBIMhAfGwqBVge
 u1p+3tAYCSC33nebtD06vTDk7C0wu0yHs2O5C/Lbr1ho53G5acdNGxPf4jTECFF7tSI4
 O6ks65SUeq1+QLKMhTLhI0LKIvtIZqsSLjz6f4rY+JelbZ0sqAGmHIlwRiX02jz5SJyN
 zS3hl7/9btdaEJ5Ta47EbijrCcI+ATrYNMvXxwrzPJxy36XxXUb1icrpCkCXoFVaRjo6
 DnEA==
X-Gm-Message-State: AOJu0Yw7GOxdrb5+9j4iu8RnoWt1IUkuvhyC05aVJ27RVsiOWE3z91Cf
 Q5N3gdbufxFPpq3AOqRgGONgxKfRmqLVdx1h9duTGA==
X-Google-Smtp-Source: AGHT+IE+gODW8d0XcXK9g2AXZAjV2XfKfWTuZKTqqczsBNUUrxbmjNHOnZ/JjKImC0vuDjmbn8IR8Q==
X-Received: by 2002:a2e:95c4:0:b0:2bc:c28c:a2b8 with SMTP id
 y4-20020a2e95c4000000b002bcc28ca2b8mr3847780ljh.27.1697637698829; 
 Wed, 18 Oct 2023 07:01:38 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 f2-20020a05651c03c200b002b9bf5b071bsm718692ljp.20.2023.10.18.07.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 07:01:38 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v5 1/4] common: add prototype & rename populate_serial_number()
Date: Wed, 18 Oct 2023 16:00:56 +0200
Message-ID: <20231018140059.161169-2-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231018140059.161169-1-artur@conclusive.pl>
References: <20231018140059.161169-1-artur@conclusive.pl>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

v5: no change

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

