Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD87CC87FCB
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 08:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D64683D71;
	Sat,  9 Aug 2025 10:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ydcrwlyz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F56783D7D; Sat,  9 Aug 2025 10:22:04 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9186C83A32
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 10:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E864A3F718
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 08:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1754727719;
 bh=GNxzFhPzaHlEtSWRoN6E/bfLlC4B3BSt9Lr3QZCheZY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Ydcrwlyzpjs0++01C8SIiz9h3rj00RrJLT3WjcxUbuC4dABEYplTZNCTIXR70deA8
 Z+a1yLF3/cth8YwvADYyrd8ua9czgGEXkAzCvN3PYlmfH9AxIEK8R9cBMn6gz+N/9z
 TRKYsPfB7NnJ/+4+65oPWineSQY+KHLHfqaJVrc2BID2Qd6igM0maP/G1T9bdkxzTS
 BTaCYPY+BDMfAJmiHok23S01PRKsIVZWEVTA79sAOK70XAenhahDb4mBkFAjHSDCIl
 ZNKtvKY+3MsYWuagUFrtMIAD16yTLST4NmTejRQRkMHbFAIKoLaEMRlQv+N6b37lrO
 S688g+E/J9y/g==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-458bb0e68c6so15097175e9.1
 for <u-boot@lists.denx.de>; Sat, 09 Aug 2025 01:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754727719; x=1755332519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GNxzFhPzaHlEtSWRoN6E/bfLlC4B3BSt9Lr3QZCheZY=;
 b=g/11QU5eHHEmQQA+iuXQUIKkHniw/8w0XQlG/etCIpHTCHiMdZtn/+UUfH/9Fzdudn
 afoxwQ27bzo3q6c66iobq1tmWs8O/b0Yg2dltS1EyfJ7rdGfyjQLAZnHR1PfBH3Zlo+l
 /pZtpLrualdovyV1BqCNh3KMn3VcSKMwEe6eVpqHhP/Uw7nmrMMt7nyg34ZE4MynexNV
 qvKTQXsXKc1LZ1kjQCkxItCTBlfqH8cUmgAvn2Vaw5aUe84z4gpPlsBrYp8E1/XotWGI
 F101hrSXBlsvcrv/c7S71ZsUOIOX5Ro89R8nujVW3HcMxy+QH37RW9G8a4zQfKWUnhuC
 5nLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBM/slbrskICv6A0RwEtGDWOgiVGCDSAJ0TRPGllHHBCGjZy4vxrFIYUTb8VA6bgkwmcyrP4k=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4Yr/BUfiPBjjGHeXUtdh+Ism6zZXtgvMuVjn9FhHtQpRqRNrE
 cE+DZtKpXCLN3IC9Q7wePr7M5qAxUjS+a+Cpc98YSzwflI+dots4/m66Tfqc3055gdKKyJQlKYQ
 UTn5YeE8LZN/kj4SSCxN/kb+/G5vitqCEBtp24DdpShQCwW9AxMLah6ipQJd+Nbh4dxe+aRfMVS
 sNFg1a5w==
X-Gm-Gg: ASbGnctdB+dxP+12YKiF8rziNxMHk/OmB1WUTUdB4A/Ge6UiWnnh9mN9d1PTJTbZPAS
 gS8cRFyTSr6rGPwYQvGygkGFKvMKyO+2PlsVyFsg16DOQUQWrlomVP8OZNKvgCI25LAkpo3PTlV
 TO2n0WZuJlnBAN7jEzoQs/znQnmcKi5B99dn8kzKJGudXMX9BU0pSUVwjNf1+zO+tVR14J4haFD
 4D/by4DQvzPw9IJEkNZIWMbGucii0BaxdwGZzkAzRPr26BALDVIKxOgTFmOsgXeUpZm3dw8TGrp
 T0f7FcfJhZxzgcaMmw74EyVc07n8ywmDnI/dLYlP7EXDtg/HMVg0aYl+s0TbNoNTvK9UbdeuQG2
 6vMhcsKKhhfheQf8kpjGFpgZ+Ef9c6g==
X-Received: by 2002:a05:600c:5254:b0:450:d3b9:4ba4 with SMTP id
 5b1f17b1804b1-459f4eaa88bmr51629215e9.2.1754727719335; 
 Sat, 09 Aug 2025 01:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsaIREcpalgYfwGCpj04agfvRZSyhV/hZyTR7zDW6quZCn63J5NW6QFtQlnbON+nH0Ie4hkQ==
X-Received: by 2002:a05:600c:5254:b0:450:d3b9:4ba4 with SMTP id
 5b1f17b1804b1-459f4eaa88bmr51628965e9.2.1754727718768; 
 Sat, 09 Aug 2025 01:21:58 -0700 (PDT)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e075047fsm115029655e9.1.2025.08.09.01.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Aug 2025 01:21:58 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: E Shattow <e@freeshell.de>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] starfive: fix return code of `mac write_eeprom`
Date: Sat,  9 Aug 2025 10:21:55 +0200
Message-ID: <20250809082155.6929-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.0
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

When writing the EEPROM fails, the command usage help text is displayed
after the error message. We should only display the error message instead.

If writing the EEPROM fails, return CMD_RET_FAILURE (1) instead of
CMD_RET_USAGE (-1).

Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/starfive/visionfive2/visionfive2-i2c-eeprom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index 010e386e64d..17a44020bcf 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -275,7 +275,7 @@ static int prog_eeprom(unsigned int size)
 
 	if (is_match_magic()) {
 		printf("MAGIC ERROR, Please check the data@%p.\n", pbuf.buf);
-		return -1;
+		return CMD_RET_FAILURE;
 	}
 
 	ret = i2c_get_chip_for_busnum(CONFIG_SYS_EEPROM_BUS_NUM,
@@ -285,7 +285,7 @@ static int prog_eeprom(unsigned int size)
 	if (ret) {
 		printf("Get i2c bus:%d addr:%d fail.\n", CONFIG_SYS_EEPROM_BUS_NUM,
 		       CONFIG_SYS_I2C_EEPROM_ADDR);
-		return ret;
+		return CMD_RET_FAILURE;
 	}
 
 	for (i = 0, p = (u8 *)pbuf.buf; i < size; ) {
@@ -314,11 +314,11 @@ static int prog_eeprom(unsigned int size)
 	if (ret) {
 		has_been_read = -1;
 		printf("Programming failed.\n");
-		return -1;
+		return CMD_RET_FAILURE;
 	}
 
 	printf("Programming passed.\n");
-	return 0;
+	return CMD_RET_SUCCESS;
 }
 
 /**
-- 
2.50.0

