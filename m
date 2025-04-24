Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DA8C369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3A3B82075;
	Thu, 24 Apr 2025 14:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BDy6+ayA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C18881F4D; Thu, 24 Apr 2025 14:14:02 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86DF7809D4
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E83BA41A26
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 12:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745496825;
 bh=S0QxCT2A1EMBk7nUVHW0lSWKWEmmqpgHlBODInJPrl8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=BDy6+ayAn9fYe0LMY0G9sHOPHNjyR3HN8a+W2mvoVBhPqO21o13kLnWjevN7/Knbr
 mQ2XXTKvw0mE1+OTZH3XPcnnlCgZFLuY7na1hsYCZRGVCLSVpErWicCaBGAEJ1t7dP
 Cz1nY/pPF2jkk5xDsQmz3wTNu2bp3x5+NMGfySJY4kUMibuuyFlTa4rlZgdnNIocCB
 SXoz+IIVdHMgRXEwwTICmXQPV7oZRFXJRsfBm5X+57MtQxPsoeQlautiTtY5ZpCJGZ
 xaOJczD10HI8OggFpjoY1dKs/7Z1nzI0/0hJpdMvEpzBqGmbvJGSOOlIJQ0IMaxQNR
 7/zal6CYvhMiw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39d9243b1c2so312016f8f.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 05:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745496804; x=1746101604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S0QxCT2A1EMBk7nUVHW0lSWKWEmmqpgHlBODInJPrl8=;
 b=rtTNltNQUjYbjURmD7JC6jNf9I3+s0grmNaizG2n6CpuZv8iP+iJBb8bT+k/0B0Cn9
 SIbf3WkR3jNtbvNlXw8bbm4wIuZQEBJnSRvKNjwZGAx93CKeElOW+3GPEDWc07YyNSh4
 2MAcAopGkWgbDsEHcAqRY4Z7bxYDNyasI5ThQ/tbJ2skp9JqwE93bRf+vT1W9xUKAuZD
 6UYe0xzGO11YFXAs7i4JNQDXPodJo+Irs7rpvK6T4lElFph3toPSYjMiE2iXOwwqVoHC
 jWoyi18z9djN48JSexV/zIgouYD3V4SxP19NzElnOkk6+TDt1TtcJpJ0cXgHS79MQ5VA
 DSCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQpME2eleoIDPFkhDDVvz9xfKJPBdI0hci973SH9iB97wf01JprA9q0WLsnB8HcF03G4b9mI0=@lists.denx.de
X-Gm-Message-State: AOJu0YzngwM9PFF1wma1p+vARbz1iiunFJ6pTtewKK6pUu2yFQnidaGv
 pd9amcKT/T6oP6y8dHWPp8i4VM3hhVR1JPmhW7J3bpriGLjvfJMhONUbrwj6lAVsQgPo3lv+z+T
 YQzhwF6ARyCMIb3gRzdz65Xoew1foClf4EsSmQ/HRDItEZKNKkSA9Djpy+1gV1L7Feq8=
X-Gm-Gg: ASbGncvSw76p5TJBOelLoc0eYyCNPJcyvvZIkkLR12M9r/ldzc2s7Tt2Qwe4AOFRn5i
 cr4VWIKYoDjP840MsZmE3e1QnP+WupgQHSs0nldWc15sikn8zWHAuJcyl8sQsINUpsawRSlDhjy
 LCU0H1me8DCVQmINnKWeBNxAvKEiFuLG/pcCJvCm8RjH83EfPdNB0JcORQb8VcPa1WTWVtH6xbq
 iBjKicuETS44Ke1Sza5sB1uPlw4FQNm8BvmeKjcYy0uqJpVKRtnVpMa3v7OBzr52Y7ldDdwVCaE
 wuSKjfy//I21FC0JJgzWDjKf8m4Yje2Ira2KOL+NOj4457bRcDx9z3M16F5qoR8mQHBZRK+3wzw
 q60i8ODGKHK1XlQ==
X-Received: by 2002:a05:6000:184c:b0:39f:b62:8cb2 with SMTP id
 ffacd0b85a97d-3a06cfa3064mr2309414f8f.38.1745496804291; 
 Thu, 24 Apr 2025 05:13:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQpeWA1el5MTPw17/UfBGEHWNvljiKmW3NL7WUELRdayzY3dTH1J1b235zVp39X9RJeOpVCA==
X-Received: by 2002:a05:6000:184c:b0:39f:b62:8cb2 with SMTP id
 ffacd0b85a97d-3a06cfa3064mr2309395f8f.38.1745496803970; 
 Thu, 24 Apr 2025 05:13:23 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d5326e1sm1900906f8f.70.2025.04.24.05.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 05:13:23 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>,
 Sumit Garg <sumit.garg@kernel.org>, H Bell <dmoo_dv@protonmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Matthias Brugger <mbrugger@suse.com>, "E . Shattow" <lucent@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 2/8] riscv: dts: jh7110: add DeepComputing FML13V01
 device-tree
Date: Thu, 24 Apr 2025 14:13:09 +0200
Message-ID: <20250424121315.144549-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
References: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
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

Add the u-boot device-tree include needed to support the
DeepComputing Framework motherboard (FML13V01).

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v4:
	no change
v3:
	no change
v2:
	no change
---
 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
new file mode 100644
index 00000000000..ab882d07f6f
--- /dev/null
+++ b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ */
+
+#include "jh7110-common-u-boot.dtsi"
+#include "starfive-visionfive2-binman.dtsi"
-- 
2.48.1

