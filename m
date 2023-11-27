Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEC1C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B3908772E;
	Mon, 27 Nov 2023 14:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mlN8USNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C74C88772E; Mon, 27 Nov 2023 14:01:05 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 385B08772C
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50aaaf6e58fso6350834e87.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090062; x=1701694862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UeW1odG9hZuINbqUD6xKHKoC4MNjK1YXfaNFNoaxSpw=;
 b=mlN8USNKSdapJQD9LgxHLOYJH0PL2kxmUETqagM4ONEc9rcBoBBeKq9fTtijURbUK3
 pJFxi+5cpRwweR611EpdqqSjAIZpW/xIOQpwwVY8EsozygU+e3yVePKhVYgqS8VLXiis
 mZ1lNyuAYxdT/f4xoiwoquBLxjjqIc2LjGW5lrZ1U6O1YaIk0v0tdm3ILnPVuuJvua/z
 qd1enOZw2GVwjfdv1qmC766LvFMWVD3PnY2XheMPxAD3enYprExKLV3zgSYZa8DqLqaU
 5PDUho3gtDtVhpbA3Y+R8XxVQD/OSREgzqghUJppm/XdRviafO3Pc0ZNbo46b/1hh8aQ
 ncng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090062; x=1701694862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UeW1odG9hZuINbqUD6xKHKoC4MNjK1YXfaNFNoaxSpw=;
 b=OvULDCc+Rab1xwKynjy8HTQc/clHSkb1Ml+j5JnOJvdm/1iAzDBqSRAdS7rQNw5gUA
 Ryei8DDrfR9kPFjD7j3wpkM2fPJ42N8YdndbSae8gEINwD0EPlHUUeZuIaVQECmvyneM
 JZqkasJ5Hk0E73MNlEqVX4RW3EwzdcYKYq9TDDvgRo9O8VUYp6OWyfXbU5rYi7Z3wULn
 bFIzQdrbUs/AGntJ1uZeICWqRceKUCHUpIPV4fi0ngtdoyfDgBV8bazDGo3a82YKlOLg
 2H/9hNpYJchd7oaFW00HVZ6y/hr73CAw3j2gfukSVqkSsZ4kbPP0O4DcvTBvWB3cTuPJ
 D8Ig==
X-Gm-Message-State: AOJu0YwVerTUWC2tQGC771QqaCnIKl0cFneSdf0mQQRXFwMPW42hvHg4
 WXgTZM52CJc2CTxrpmjkeFgS0tjywcX4eZtPoQIy6A==
X-Google-Smtp-Source: AGHT+IG/DY0aUDSEoysLMtJ6WiqhLVBpdqwyaT8FfKG5G5k+KwQgccEObtiSv7LprG7je8U5nT0QHQ==
X-Received: by 2002:a05:6512:32a7:b0:507:a5e2:7c57 with SMTP id
 q7-20020a05651232a700b00507a5e27c57mr7363582lfe.18.1701090062376; 
 Mon, 27 Nov 2023 05:01:02 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:02 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 23/43] rcar3_salvator-x_defconfig: increase binary size limit
Date: Mon, 27 Nov 2023 18:57:06 +0600
Message-Id: <20231127125726.3735-24-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

   aarch64:  +   rcar3_salvator-x
u-boot.img exceeds file size limit:
  limit:  0x100000 bytes
  actual: 0x106d6c bytes
  excess: 0x6d6c bytes

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/rcar3_salvator-x_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index e045cf27d3..238d0b3940 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -10,12 +10,13 @@ CONFIG_DEFAULT_DEVICE_TREE="r8a77950-salvator-x-u-boot"
 CONFIG_SPL_TEXT_BASE=0xe6338000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_SALVATOR_X=y
-CONFIG_SYS_MONITOR_LEN=1048576
+CONFIG_SYS_MONITOR_LEN=1085440
 CONFIG_SPL_STACK=0xe6304000
 CONFIG_SYS_LOAD_ADDR=0x58000000
 CONFIG_PCI=y
 CONFIG_LTO=y
 CONFIG_REMAKE_ELF=y
+CONFIG_BOARD_SIZE_LIMIT=1085440
 CONFIG_SYS_MONITOR_BASE=0x00000000
 CONFIG_FIT=y
 # CONFIG_BOOTSTD is not set
-- 
2.30.2

