Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5BFC6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 18:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFB888120;
	Thu, 21 Mar 2024 19:12:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NoBFJmbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E867B86564; Thu, 21 Mar 2024 19:12:28 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28DB48812C
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 19:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9960A3FE20
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711044737;
 bh=bbEdPyuwUvM05oPXYqaOqFDe/ckF9rhtiyT9BUpBEc8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=NoBFJmbSqtPUfxen/0LMAECVrMTZAsadK4qvXKYplwsir+lMG8n2jnLKZIm4SKuxu
 5ErlycmqwhDFb3NgmQjKV/DnQNC6Gvasg0xbGAYPjqk0oZyCfp7ogFe49HPTZPFhaw
 Fu9LUCf4h4dpCV7kzpN6EMnhNoZjUxTRYeWsIcEJsVnWGwzWePxHKMIA43RGAI+s9a
 aPqMuJe2v+Jg91p9kFAUKSzE+uaSXdnkxyZBzoXR9ViLgiHdfqKE1sTkTgUllZ1MNv
 IMRBWuDBK7aA34E7vMqL0Ix0yso57cpb0BR+R0TN+R5uLYFfeGQV53At9PVDk6Iq7j
 TFFIYw4C5e9dg==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-41463be093aso6274975e9.3
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 11:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711044734; x=1711649534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bbEdPyuwUvM05oPXYqaOqFDe/ckF9rhtiyT9BUpBEc8=;
 b=KXqWyHYavdLGgWERfbtV0ItksSNgLw6eHVcbWrTLA89iXOT+SjNvC07beZjZdGuQ7n
 9qcAOdJ5XntS2pbf8mMSrmHpW6Nsa8lJ0UrB+hqQ2qdhs5373WqsKn6brfNm68+qAqWf
 vw4bbdGjyoztzzDnddqClGk/2fdHcI0/2wVMFtevr7oPR0V+i+9bQqkKvZfI+U+3TBAp
 LC0kUePTPIcGz3fEXbw96nuLu7Jh9rjrCTUiBFblKeSniwfdxth/AU7QXpoi8nxZ66Se
 MNVakjgnKhfvESlfynLUN4TdOsq1vGkpe6urvA8QKEKvl0CI5/1Ny9dTtykieUGgR/UL
 Ipfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLeIgDMrShFDG1foD0tS+pW7PDA1sAPqVNXf+Pycks0xDHIlqhgEEzw+eyxGiOTZwxMv0aPFTP6/2mEyZDDvYsYd/G2Q==
X-Gm-Message-State: AOJu0YxA/u8DT50vJ7KBBaI1LhNZIdsHF3x9U4D53lkKA4bcMPB/OH1L
 dkXyTETIblrWPXfj4eIG8E2jAnCj3VXmAVzaHq9d0neWyxkLyq4F4d24A89iB8KfqKnEtx12/7E
 +A+3UeUKEkCYW84W8UlDj5UznHOc4Y2owEMvpZYtHkXCKqo+ymwlzpuPx3beWMuJ/fqY=
X-Received: by 2002:a05:600c:3645:b0:414:7227:2d61 with SMTP id
 y5-20020a05600c364500b0041472272d61mr1956209wmq.1.1711044734258; 
 Thu, 21 Mar 2024 11:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrmaaQJzQZ6hGbTae6pXIB8pjG+TmTsIX2YaydAgGaOAGFszN7/RBMXZA/0Z07ETdtjebZSw==
X-Received: by 2002:a05:600c:3645:b0:414:7227:2d61 with SMTP id
 y5-20020a05600c364500b0041472272d61mr1956188wmq.1.1711044733913; 
 Thu, 21 Mar 2024 11:12:13 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 hg10-20020a05600c538a00b004147743bd0dsm1469420wmb.38.2024.03.21.11.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 11:12:13 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/6] eeprom: starfive: function get_product_id_from_eeprom()
Date: Thu, 21 Mar 2024 19:11:45 +0100
Message-ID: <20240321181149.177356-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
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

Export a function get_product_id_from_eeprom() to read the product ID.
This value can be used for fixing up the device-tree on JH7110 based
products.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 arch/riscv/include/asm/arch-jh7110/eeprom.h         | 9 +++++++++
 board/starfive/visionfive2/visionfive2-i2c-eeprom.c | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/include/asm/arch-jh7110/eeprom.h
index d2776d5b6cb..62d184aeb57 100644
--- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
+++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
@@ -12,4 +12,13 @@
 u8 get_pcb_revision_from_eeprom(void);
 u32 get_ddr_size_from_eeprom(void);
 
+/**
+ * get_product_id_from_eeprom - get product ID string
+ *
+ * A string like "VF7110A1-2228-D008E000-00000001" is returned.
+ *
+ * Return:	product ID string
+ */
+const char *get_product_id_from_eeprom(void);
+
 #endif /* _ASM_RISCV_EEPROM_H */
diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index c36de1a5125..a9f4376c8e1 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -405,6 +405,14 @@ static void set_product_id(char *string)
 	update_crc();
 }
 
+const char *get_product_id_from_eeprom(void)
+{
+	if (read_eeprom())
+		return NULL;
+
+	return pbuf.eeprom.atom1.data.pstr;
+}
+
 int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	char *cmd;
-- 
2.43.0

