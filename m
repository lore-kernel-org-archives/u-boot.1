Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CEBC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80BEE87F8C;
	Wed, 20 Mar 2024 13:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="go8xCgRo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC24C87F8C; Wed, 20 Mar 2024 13:16:56 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EF686FCE
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-29bfc3ca816so5831430a91.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710937011; x=1711541811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGqlhAwXlNAbyn9wEG7QpeBZH4E/n9ApsSiGwFf52dI=;
 b=go8xCgRoVpF5c5vfjEryKXTYuk0GZMzuhL4Kv12Qt/Hwo3AJ7sr6Un7dwXhYsEdYl7
 JszictDrjgLnvoMYIFObFllrH+9ewwTC2pP3NJBIOygE+VPufNG5dXR4ByXNgknds/ps
 j6ZZ05rxZYgM5IlPME9yZGK8IoU8jXkkRCZum6LSPMVGiFyayafe11CJnSWqKRF3qXyK
 7ubwundzDJRRDlGCS5keafV/IDrAJlcn0APHfeNtb1iauhzrM/x8gSwXGEt1kCgUgucm
 2Mnwj0HbcCEDOw1CwG+Fs67J/dgNjZTEZNIQBpJ2aui+GcRmpnFvA9aryHNh3+kN9aDK
 6asA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710937011; x=1711541811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HGqlhAwXlNAbyn9wEG7QpeBZH4E/n9ApsSiGwFf52dI=;
 b=Z4Ag0sg24OTa22TYZN7U+g1AmK3mBoK3sOVqwA/Lu0pfHrnLoBQkzi2iAyK2KxxYkj
 iqZmr4yIsxGKazDH8CCbDloUwzKXAzLGiwnKjdjJmG4QWh8wIioIqbr6xRxpNah7tnSQ
 NNMTx3i1LVx6Mwicw+1NDjHar18QbRDkw3mf4iuP853sG+IAmjdP55+6+Cmc5tyi5wom
 Aul0+6lWiCd1t1rqLmAGM0k4ZTk5X3MmwHkQ1u7gKl8+9WQ8XDlb2WvU1ndlW52vASGA
 aqb1LEUfBwxuoKj703I8P5XthMf7Suz2EpEtgvPnxZKeGm41doYaIOWHwuWXkwxOxO1f
 u6Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNjmizty4V1fdXl8Z5QiNcraviLyUmGLMgKMZT1fe4Hd+uV8YM+PhrKgm3PtVq8ao4d3lwYfyLkirFLkOvKB3tldmTJw==
X-Gm-Message-State: AOJu0YzPkUaQdHm4m78Hg14pj8exY03+58FoxYHtbfwdOjcPRK7C6xIy
 wS1VniknEFPs5nLseb84qDFElmJGrNaEthmwJAObO7PrRljTslP6
X-Google-Smtp-Source: AGHT+IE1jn5s0lzHOrdSszKwwavcpMAWfLK0lsMlooY12OvWNaxEeqZhC4BSBg7ly0IYwpIABjObZg==
X-Received: by 2002:a17:90a:5283:b0:29b:68c:1779 with SMTP id
 w3-20020a17090a528300b0029b068c1779mr1692455pjh.40.1710937010956; 
 Wed, 20 Mar 2024 05:16:50 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([201.82.41.210])
 by smtp.gmail.com with ESMTPSA id
 sj10-20020a17090b2d8a00b0029af5587889sm1447870pjb.12.2024.03.20.05.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 05:16:50 -0700 (PDT)
From: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 1/2] arm: mach-k3: am62: Get a53 max cpu frequency by speed
 grade
Date: Wed, 20 Mar 2024 09:16:31 -0300
Message-Id: <20240320121632.105730-2-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320121632.105730-1-jpaulo.silvagoncalves@gmail.com>
References: <20240320121632.105730-1-jpaulo.silvagoncalves@gmail.com>
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

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

AM62 SoC has multiple speed grades. Add function to return max A53 CPU
frequency based on grade. Fastest grade's max frequency also depends on
PMIC voltage, to simplify implementation use the smaller value.

Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
---
 arch/arm/mach-k3/include/mach/am62_hardware.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
index 264f8a488b4..90682d8ee31 100644
--- a/arch/arm/mach-k3/include/mach/am62_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
@@ -122,6 +122,21 @@ static inline int k3_get_max_temp(void)
 	}
 }
 
+static inline int k3_get_a53_max_frequency(void)
+{
+	switch (k3_get_speed_grade()) {
+	case 'K':
+		return 800000000;
+	case 'S':
+		return 1000000000;
+	case 'T':
+		return 1250000000;
+	case 'G':
+	default:
+		return 300000000;
+	}
+}
+
 static inline int k3_has_pru(void)
 {
 	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
-- 
2.34.1

