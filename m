Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07622E77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E07A806E8;
	Sat, 11 Jan 2025 01:01:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LEmPYX5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A4B801B0; Sat, 11 Jan 2025 01:01:06 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEC58806DB
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3ce34c6872aso16506715ab.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553663; x=1737158463; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgXckmYNYTYGPVlF1UwxJ7wb9qss6MH8fA3zviaz6Fk=;
 b=LEmPYX5Hlb4cLEqKmbzgb9ugkr6+6UQOUFgkfl5DV2ZhgrbCM4HuL7X7LV9PqM/M+B
 e2FPePmrLBSfSuvHq0eFAhRB3yqwZYkqco3WvtFPU8mU+lZsPKbt52lCwRmzWBt5+MBt
 8rNr6IA0aSBCnfzXqcoV/pBE3gHM+VlePA2KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553663; x=1737158463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgXckmYNYTYGPVlF1UwxJ7wb9qss6MH8fA3zviaz6Fk=;
 b=trFNZ4WtcR06flBd82EMJA1jIXBWkg8OmjraXtyRIbcGp+fls1nNm4hOn6YKZ1OjT9
 LOppGREsENt07igZRE4KuMESx8EMTOOBUCzKIKL+zvWi1qhZsV5K19vKfDNWtnv7IL4l
 H3BLY5VyxMjBkKTx7zlb3ig+Q67spRBhr69wexx+0XpUDz71glo9yX8ka312dyNlh3Ci
 kXEFyGhwdG4HiANb50sLOn34+3s9Ms4fatbnFCHOxujccgRSfvwGE6MH/un4nTgI2yJJ
 A//G1x+zNmS0jxrlaajQ5iPMI/Ia/ZhMavTj809KJ2Z/7O4L9IGwQjl7Cr4MkuRiZj6g
 g/SQ==
X-Gm-Message-State: AOJu0Yyeo5wDEAkS92TYTISF8vSAYB3gKtRpMhtt7E7xBwORDjiXG9UU
 VHAtX0x+kKarp5WWYgVGvDxllWPC5pHVCGUymZp8vHb0jJXAX4nrKOUKv2C4XQVtNEQz1LbamIE
 =
X-Gm-Gg: ASbGncuOOdNo9C0H2rIH6+UN4hslvwf23ZC0dtiryNIRLcYjy3En9ysKWd4kiUQacPN
 EXcVDWOkQ6DJXw2LPl2ARQfg6wiDSmTREQrReCwRDXPR6Ag7xVt5a4toL6YBlPM/CpI4o05lqo4
 uWDr6pFzNBuyBeAuhMY8D1H2Q9l7NCsMVLmVmvbWDKEib3JLG+CnaAoShTSJIPNgrNBH97+LNfA
 sZi0skk0yctA7yyKior77U+eQADhPywEV4RkDemvEOUmks4APMA0XWzVS4MrMPWC55ITpvIJjOQ
 ZlUSoDHfxemWYWvG4g==
X-Google-Smtp-Source: AGHT+IEaNQR5AQ6g86nF13pSEy+nfnBJARdKe84br4kQxSueH6gfLeRp2ZKgVL3AN599pZ4tEouQSg==
X-Received: by 2002:a05:6e02:1d14:b0:3a7:d792:d6c4 with SMTP id
 e9e14a558f8ab-3ce3a8df63cmr106936145ab.21.1736553663065; 
 Fri, 10 Jan 2025 16:01:03 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 08/30] x86: Enable meminfo command
Date: Fri, 10 Jan 2025 17:00:07 -0700
Message-Id: <20250111000029.245022-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

Enable this command for x86 boards as it is quite useful for seeing
where memory is.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Fix 'Emable' typo
- Enable the command in cmd/Kconfig instead

 cmd/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8fc76778d87..64c6e980a09 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -905,14 +905,14 @@ config MD5SUM_VERIFY
 
 config CMD_MEMINFO
 	bool "meminfo"
-	default y if SANDBOX
+	default y if SANDBOX || X86
 	help
 	  Display memory information.
 
 config CMD_MEMINFO_MAP
 	bool "- with memory map"
 	depends on CMD_MEMINFO
-	default y if SANDBOX
+	default y if SANDBOX || X86
 	help
 	  Shows a memory map, in addition to just the DRAM size. This allows
 	  seeing where U-Boot's memory area is, at the top of DRAM, as well as
-- 
2.34.1

