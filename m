Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F205C0219B
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 17:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C7DA80836;
	Fri,  7 Feb 2025 18:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="i2cqF7vY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B36807F1; Fri,  7 Feb 2025 18:23:53 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB57800B3
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 18:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4F1883F682
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 17:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738949015;
 bh=Tqtj5XdOWikb8Tu2Zz8Ppx51UJ1YAodgxmoxTYUsJ9s=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=i2cqF7vYbSi4Yvy3OrkKmN2+uNl4bFLZF6MgL98T8D1uV5uu+3r/P20eh74BsjwTN
 ijjM3No7DEhaw1ng3FF5NSs1ubDSfh36OydAMOi3aRGE8k4VP4tMBFfTl4Xupim0Nu
 qLCK9D4fT+POwA0fHrGaW9PSLeaQgzQXOkkmCzdoEX79BY6lu3EDjwm8El0X3ZTWfl
 noSFDXSNIbLuEePQU3zaYdFWEqfrppOoldOeeuEMY2CYHg9kMhJ9OrAtKAATSOj+Bn
 BlVStoHNYI2F9lbFq5WijsXSQGTnM5c3gC9pnZ4HDfGAIQGyhBHgj9n9NrbAggvIWU
 zYSDxXNJPrkjg==
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5dc5369fad7so2811539a12.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 09:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738948924; x=1739553724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tqtj5XdOWikb8Tu2Zz8Ppx51UJ1YAodgxmoxTYUsJ9s=;
 b=Gwz/sKtF/fwa8TYNd+UM64c2ektlSqgZvFaZtNHH7fwzRgtujtCrjDZgHgxsdxM1Be
 euqWOMDRTyz40XoIphAijXwHKI+PJLfV/DScX/2pMPVu/JmKbTPDc+/81SzuS2O0CD3n
 LBp0xiDxSIUAWJP2ztYgBkifPA/UihmYNk+1n0Nay+/4p1/S5J/e18vUFUne6MjuYdZr
 vxLDQbtLTcio1CAfYWRcUkZE/sEXV6i3gQgiW0jiMZTdLJ1f+L61tAU5bmeC+mjkBt9v
 lSH7hrnzmcns/0KrbdspNGlNzckB3rMn9ijudp1ZzcDq22op41AEKuRdfTnpvKMJnsY3
 Ting==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfceyM62geI95jF8E7AKlIvtBpeyJyow02B8t5Fw3Nz0RiBuMeEOxMsSSist9yXbwHQaBblh8=@lists.denx.de
X-Gm-Message-State: AOJu0YyljWiiwgIXVxuc5rAvjednZsRUgWCG7Sj8P+KLZRePfufvCPNX
 VHvZlQTN1aPCBwCoGhPPnJK4zRQHFRNIw8csMm0iyvuKqIaetPeQbGoWalvBZebpPlhj2a8a9jj
 N/oRmNDkqTxtEy94IabdBDk59USZ4+kuKCOaIERbZC2tl4Pl5rBs6pHsgS1ZN7BBS+VI=
X-Gm-Gg: ASbGncsGEqHiJuLxaIJyjgnQ8gx/a0z8SXe3NkW/9/uF4Nyk/ii9uN+V/guAAwswOmu
 SAkX7dRZhiOiuwUBGP4hRpSV9q2NwCYifFsxjy5qZFeXVOUNF0EcYshceWttVr+/GBq15l4iDam
 vMMwyYcwPE05nS8P07hOPY81KH4bUFGooWfJLi1V6Q8VtcOQ1VLzCIWW/HkFPVRx3y1Y3pyfoPC
 GmlA4FB8WLKTpUYDCD3opUkOARKOXy0aEqc1fKkYlfOjB7CD1AaRhsrObVHe+d3u4O45pVKxsUQ
 T2337qMrTBUQhJgRJSbugzrO6kY1oP7+fAGEob7vTMYmL8Kb+SW3uHRC3exosUIRaHYWZCd7IjS
 /sIo4YAM=
X-Received: by 2002:a05:6402:3907:b0:5db:f5e9:6745 with SMTP id
 4fb4d7f45d1cf-5de44e5e000mr5027718a12.0.1738948924406; 
 Fri, 07 Feb 2025 09:22:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGB2pvsFNtU1TjhEa/+bwT+9OABSpIv7Q+nMXHRU7qOq06DcYw11pj7HqJK5wIz+zd5FHcy6A==
X-Received: by 2002:a05:6402:3907:b0:5db:f5e9:6745 with SMTP id
 4fb4d7f45d1cf-5de44e5e000mr5027676a12.0.1738948924056; 
 Fri, 07 Feb 2025 09:22:04 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf6c9f8besm2866914a12.52.2025.02.07.09.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 09:22:03 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>,
 "E . Shattow" <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/6] riscv: dts: jh7110: add DeepComputing FML13V01 device-tree
Date: Fri,  7 Feb 2025 18:21:13 +0100
Message-ID: <20250207172116.117749-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
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

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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
2.47.1

