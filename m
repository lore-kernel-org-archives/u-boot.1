Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3007610A1E7E
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E57368407B;
	Thu, 26 Mar 2026 12:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="BJ57FJf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8646383FC6; Thu, 26 Mar 2026 12:29:09 +0100 (CET)
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com
 [IPv6:2607:f8b0:4864:20::122e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F3D183FEC
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-1279eced0b9so1117358c88.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1774524545; x=1775129345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxjXydMpMVcp4C6P7mn+axfur3Ksy8Tu7As7CtekFYk=;
 b=BJ57FJf+idVEG+tfg5PJUUTwk+FabwqGZCVaLVsJ9yeyQFAAKX0NRhe/nVuY6MtIOs
 x+oFKUC4S1iibx3ZttJqRzuB0p4y/pslBrEt1PDthOKkitZQ+ytQHIRg3PJ4HhRsw2rq
 kqf9kgxe2M9QRqlSHsVXD9gWWjLCvIBwsYHwSGVXM8E0LWHv0S7T7EKyvwW07KvBv5qZ
 /TFoI4yYl3h+vQsK7DtEIKnlS4z2Ky300ORI+bx+MxUCarCqftODl5/p+RSudtzUpZUC
 uc/1boZuuVNvwluwM4La8MAfmP97ELjRvAyZwmy3oWWt//7LA1sPDJaqtf0BixOOOtes
 nssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774524545; x=1775129345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MxjXydMpMVcp4C6P7mn+axfur3Ksy8Tu7As7CtekFYk=;
 b=DEsRcHUBMr8NdrrKdjIYYPt6Feu1TdZvemnxBSAdiBiJ1szf1I9FLpaVGqVNdAWs2K
 q+es6ZJP90cvuhJPun4Z5ruD2jbDoRyF8+/rziSHR+IZ8i/i90dut59e3PGWJTOPHgEM
 E9bffGqN0Qvxzn7opZjxntPk8LMVqLDtaHGiCXrQVUYGogi3Ptm9KYw3N1Yf9WGl+z6e
 5g03G02fBxIVVF2HFC1aoFWeTEybIXsF0bAMegtMfrwKP1Z0AcGholN3Jvx7Gzgdb9HI
 PpnmMDijVjkdWMuvntUawm47EhniNbSZApd2N556Odog90JiNkyywcw3Fda0iyUVC5Gl
 3W2w==
X-Gm-Message-State: AOJu0Yw1A5dEu+f7Mvoj0jmTNELq1XVxFrB3gs8z5Zpb32dxW5uJx3ua
 OyQdILCvSY7/BzvVTFus24Lal8SkFCf4XajwwLftTt5n24k/V6lHmd4x6zktAHfczFMjNx5U0dt
 kIWnaXrZCLEcH898Yl9tn/SR3jA0FfeV43Goy5NpvXjKL7BrzqANmX5o3ZpmdfbrKLlyrygVDlP
 2I7ynPLzXhjAl5f/kwIqZbwWmDO16lkXge6szo9T3xfxQ=
X-Gm-Gg: ATEYQzy5AUMH6Q+zq2VRkHS+kO3cUHTekfPI2EHK+y2hMbM8bViunnVHjApe+qvCOvr
 8+vDoYXi1cg82QxOK5LL1Ywax6vUvmtwzI+AhCMDg6RnkHe4wIhrUDRbGlmQ7NASa7eYLbAq2KF
 0IZaczCQJCy2uqtSsuAW8/tw5HO80Zj272OWyv97WYHNrO65baoTqx6o/F/EdxrlR19y+E5PI3p
 yiUthhfK/LSBXDK35pZPvprtSvTRlE4tQag+QC35EK3iWeUP4+PDUZofJASZN4hVFXTMANtJi8r
 rUTkx9jWhkMi0nXUh1pPiiiq4Sjxy32J8r6Ot7XcT4kvbdboigAEZuYpEAUyMknYhfr0TsEOlG/
 QTV+icxI2gMPkbylBvWd6KP/5AuDnbYpBOQHiNHlzmQw6Pawjpknm49NTtwF/VPbY55QIIwdhQa
 jITw0w//T4e+hhDojyMmAlDOWEJdLvL/mHM1tPoT/rMbqSt8ad2gnxuETLaixwsJKiQmgSqnhb4
 mR074TODw7fysUgosazJ9xHAP3Bao+Yzd8YQXMD
X-Received: by 2002:a05:7022:69a:b0:128:cf5c:535a with SMTP id
 a92af1059eb24-12a96e5c913mr3832159c88.11.1774524545227; 
 Thu, 26 Mar 2026 04:29:05 -0700 (PDT)
Received: from fedora (cpe-109-60-83-68.zg3.cable.xnet.hr. [109.60.83.68])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-12aa7624247sm3729221c88.11.2026.03.26.04.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:29:04 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: u-boot@lists.denx.de, trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, gregory.clement@bootlin.com,
 lars.povlsen@microchip.com, horatiu.vultur@microchip.com,
 jerome.forissier@arm.com, marex@denx.de, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 06/14] mmc: atmel-sdhci: include arch specific clk.h only for
 AT91
Date: Thu, 26 Mar 2026 12:26:47 +0100
Message-ID: <20260326112830.313874-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326112830.313874-1-robert.marko@sartura.hr>
References: <20260326112830.313874-1-robert.marko@sartura.hr>
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

Microchip LAN969x will not include any arch specific clk.h, so in order to
support it only include <asm/arch/clk.h> when AT91 is selected.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/mmc/atmel_sdhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/atmel_sdhci.c b/drivers/mmc/atmel_sdhci.c
index f3a030ffde5..2b6d64d1425 100644
--- a/drivers/mmc/atmel_sdhci.c
+++ b/drivers/mmc/atmel_sdhci.c
@@ -8,7 +8,9 @@
 #include <dm.h>
 #include <malloc.h>
 #include <sdhci.h>
+#if IS_ENABLED(CONFIG_ARCH_AT91)
 #include <asm/arch/clk.h>
+#endif
 #include <asm/global_data.h>
 
 #define ATMEL_SDHC_MIN_FREQ	400000
-- 
2.53.0

