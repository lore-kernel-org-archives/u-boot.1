Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6728F10A1E7D
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E61488406D;
	Thu, 26 Mar 2026 12:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="mXEd/ju9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E74683FEC; Thu, 26 Mar 2026 12:29:13 +0100 (CET)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com
 [IPv6:2607:f8b0:4864:20::1231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4209E81E18
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-1271257ae53so924371c88.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1774524549; x=1775129349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSKyqTAa5HzNTJKB6WTvAuQCQJfT7cpbIMV68L6LuCc=;
 b=mXEd/ju9DW4xytbBoNarqvJt66CWzj2mzqBLXVD0u4OC9gjAsWTp622uAAh8Oq+Y86
 /+z0cjHdwbvLX+RWciWTpEvuLLrdMMWkOA2AETb0D4lGFJUJjN6bah+KYjt+rCfjz2SI
 M2zCHCKIRkcYGMBlnDcdqYEDqDu2xKJTNlyvJUf0yvVKEZLhSrVdmioQiFItT+EaR3HJ
 87JZiW4ni2+yugFB9tEHnNqocgbgcyoDFmu1yrnc0xLcFw4Xqr2QwHhSgIyj4AQL90+y
 mFaDvtoXzzL3MP4+oimIzJNJanf4RHeGCgh8D6rVxVWQ3UTNOb95LAucOE9R5Jw2qKO7
 pAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774524549; x=1775129349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZSKyqTAa5HzNTJKB6WTvAuQCQJfT7cpbIMV68L6LuCc=;
 b=I0cfgxH+rQcJyzg5REyC7Ni3kvX5uNZET6FARugvEgSfzwkJvRqU9eKGwuat6uhos2
 8HdpKEBO1aH65dAbkNHnALOaebIUj+X/uCp7Be43juTQCSpOO0k/TepDZGdWz1HhReSk
 bi/xP7HMPixlZb+MVl1lk6PFRvvOTflzWJN41Edmq+wuiTyUfBDescj0cAFmy6yzV8kd
 aWMrx4KyRJba+2JsY8WV6D/zk/1uysySlQGYctgSRX9s9Nyg/oCUttkkHPVoApgySsa7
 jEBmNf5UxogGoF3WW3VYtzYo6ORlFRgvMsQb/8R9PnL2FiJj4YLzE/Se2vbjqUzrcRO3
 m0hw==
X-Gm-Message-State: AOJu0YxvdQKEC23EUzeIqIr+GCFb8C5+iCZdT36nSHZWxxk+4hMRq2F+
 0m0OHXMW1ygP3DQALWsWiqs7rIE2R26QqTtrGhwzxwkH1KxI0dkdc+GKtCIwCE24CTwxXAoBiIn
 DqQe2uYAiu5QAV4Mop9QnmdpSeEx9dCXvgZ9myGcuObyNGrGJ7yTrL75GYBOR6s7fUlefWCFIMI
 glyN0CmiW5dbfJQ4+MijUYKVn8RyG2hqX+xtYi16lBXYE=
X-Gm-Gg: ATEYQzyVaSo9p/YmmkKaYSPVJp5CP/XIell/aOR5cA5Oao1Kxx49UhrWdLXlyTmqTLw
 ZYajqKT5DbauM2CUJYtZhPGhuSI1Y/w8R7NHbfzfzFAreZM891qtATW4RTCqcbmYKKRgTEdsXRL
 BoGZM5LSTUtwNIBye/3PpJYGpW1/+I+kHYnd7FoPRY9BVxsQa1RoDPvsGFNgBqZv6Wo3xhN6SFa
 ZZNZ8iBLUJhIoeI8vXF3Q8LFSL8+Uf7Vdi/XrB/b9bLJuLMRbJZu2W9maWMF5E2MEVlmJVBived
 dR2Bp+KBN2rostapwUeC70dTA7d2Wte/lDpw+yx5iQQ2WN/QefvBxlnIr5quH+042eZBpBWMegD
 2FdRhzqKo7UMvRtHoEJJJvC+Rhg5pPcYEwIXErblcXhvvY/9ZS41OySoidxUzVe2H/Xyr+uyZJN
 /f7CUG2ttcK3l9PPgLNuMaacfNXaQ4e0XFcWaIBcDRovh1DYynKabrVDDFhylGlXOokgldts8C/
 wtqFi/MVRVDp+skCftufpYp6TMWLj3Y+DejeGxdIRDawhp/w4g=
X-Received: by 2002:a05:7022:6094:b0:128:e693:b63f with SMTP id
 a92af1059eb24-12a96ee700emr3408510c88.30.1774524548971; 
 Thu, 26 Mar 2026 04:29:08 -0700 (PDT)
Received: from fedora (cpe-109-60-83-68.zg3.cable.xnet.hr. [109.60.83.68])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-12aa7624247sm3729221c88.11.2026.03.26.04.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:29:08 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: u-boot@lists.denx.de, trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, gregory.clement@bootlin.com,
 lars.povlsen@microchip.com, horatiu.vultur@microchip.com,
 jerome.forissier@arm.com, marex@denx.de, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 07/14] mmc: atmel-sdhci: add support for LAN969x
Date: Thu, 26 Mar 2026 12:26:48 +0100
Message-ID: <20260326112830.313874-7-robert.marko@sartura.hr>
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

LAN969x is compatible with the existing driver, however it requires the
GCK clock rate to be set to 100000000 Hz instead.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/mmc/Kconfig       | 2 +-
 drivers/mmc/atmel_sdhci.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 9b77b8c619d..b238d5c2894 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -565,7 +565,7 @@ config MMC_SDHCI_ASPEED
 
 config MMC_SDHCI_ATMEL
 	bool "Atmel SDHCI controller support"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || ARCH_MICROCHIPSW
 	depends on MMC_SDHCI
 	help
 	  This enables support for the Atmel SDHCI controller, which supports
diff --git a/drivers/mmc/atmel_sdhci.c b/drivers/mmc/atmel_sdhci.c
index 2b6d64d1425..712405e3262 100644
--- a/drivers/mmc/atmel_sdhci.c
+++ b/drivers/mmc/atmel_sdhci.c
@@ -15,6 +15,7 @@
 
 #define ATMEL_SDHC_MIN_FREQ	400000
 #define ATMEL_SDHC_GCK_RATE	240000000
+#define LAN969X_GCK_RATE	100000000
 
 #define ATMEL_SDHC_MC1R 0x204
 #define ATMEL_SDHC_MC1R_FCD	0x80
@@ -169,6 +170,7 @@ static const struct udevice_id atmel_sdhci_ids[] = {
 	{ .compatible = "atmel,sama5d2-sdhci", .data = ATMEL_SDHC_GCK_RATE },
 	{ .compatible = "microchip,sam9x60-sdhci", .data = ATMEL_SDHC_GCK_RATE },
 	{ .compatible = "microchip,sama7g5-sdhci", .data = ATMEL_SDHC_GCK_RATE },
+	{ .compatible = "microchip,lan9691-sdhci", .data = LAN969X_GCK_RATE },
 	{ }
 };
 
-- 
2.53.0

