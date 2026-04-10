Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01C1F44863
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 13:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BB4C84230;
	Fri, 10 Apr 2026 15:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="k6DnpMFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCE578419E; Fri, 10 Apr 2026 15:33:07 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12CA584222
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488c21c636dso12037845e9.2
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775827984; x=1776432784;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BtufZEB5n/cUkjJwG+H52mksqhnEpO9+iUbfse9d39M=;
 b=k6DnpMFn5bGN3QdcoJYL3e/IPto8/fqnP+xZ8qbPu+agGnpy/LXk5zPUtZOve5l/RF
 YdUmPl3WfnQ7wI8vqdW6VYbuIQi49f7EFDVvftTLxxEUVuTBCmoMN4Z6GSRyDfTzKywz
 AY00zT2yTc8cscxy05C8ai94kY7C29aWZkcPaq9OtNmelTDS5DzTig45SjPUwNwR9Wxq
 MEyYHjn7SlPU05YCVneVr3nr3KBeUrUib8GQENRgQUHGURFijSMomn2uOCaZJYocVjRx
 TxiDciUZNRrA5ht0B6J4ZA+tIX2IjK67UpfuXA+zXp/vFHyzkR+fYFXc0cfwq95O0f8o
 qIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775827984; x=1776432784;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BtufZEB5n/cUkjJwG+H52mksqhnEpO9+iUbfse9d39M=;
 b=TFkwhOjyJ/DaliygcZqUffxVzfJLt2Js2fzmPwqKsWHeeDGJpvk/GBFAPujBToALKV
 cOtUuDpg+a/31pikDaRgjdqq9uWgjqM9mf/ZhafDLicC46w0z6jivjUYZYsMMYebCPjO
 YA8pkcKadfQxHSbbsm2vWj6B6DPlpGzC0O1UkPbQos4gL7oWbSNm9ULs3oqrE+y80sac
 QdwD7S9PlFnjwrFgY77XyoIIuKRN9pL2B51zk36xhXvYynN9m+oS9MKUJVDwFmTwOnjF
 4iaXND67VPouRICYdgS9nbeLQNPnGTxrcmCZPeiY3m1qYJ1WeVSIaP3m8dB1IcOmbOcX
 SJ5w==
X-Gm-Message-State: AOJu0YxAvoqaXnM/5d/lv1YM9Oe5kR08a0DnwbcbMId90j6dXK0PkcxV
 OUPDEhAref9/JzMQb2zY52mG8ITW4r3ALcWJy3wYtm3EcaBB7NuiSZBlXe/tKk0vJkk=
X-Gm-Gg: AeBDieuvSJOvGKdltL+0Ci9neYJKEHSYKxS5G/uoqIOOYNJ0XRetQpi4aU2iPF3FTQD
 cvDl8EsqpM/e1TFaqwObPMjbVJu8DZd2hg8DCoV8Ob5xk8ikSlqbJZPoXxz/V3afKeH3Dh1IWu9
 LYrz31t3ihJh4hKt+SoqcXdkZ1lgUbEGLIIbjeCmdWvBfjk0QJIhTSks8zA09p04DTVAVC5VrzV
 ObGGdd1huH+UqrjOdw+DZZ2TCgO3Jxc3sZ5eDotfPQSh6RYQHXAQEDzDX2v3PdwkLHtSPfvttVd
 ozFft/9gcEiuiao4Dsvy5LBS5UBxZcbbVf5N9FRVhkqH/xl3TaiHGmUnMIhCGpYRsbFCERsAgMH
 5j2Uh8+8OyVVlo2oIayvGGmkKyQ6JbDGQhdsINiDNqY9xe4/u9BLjHuPJ1N/exF49pxOYazHDFX
 vdSmrp6jfzbgo35Dbacxc+
X-Received: by 2002:a05:600c:608e:b0:488:a2ac:a336 with SMTP id
 5b1f17b1804b1-488d688d2f0mr41855195e9.19.1775827984442; 
 Fri, 10 Apr 2026 06:33:04 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d67a46bdsm33314295e9.3.2026.04.10.06.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:33:04 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 10 Apr 2026 15:31:51 +0200
Subject: [PATCH v5 11/12] dm: core: Split SIMPLE_PM_BUS into phases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-topic-am33-evm-oftree-v2026-01-v5-11-4b9c7aca0e3e@baylibre.com>
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
In-Reply-To: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931; i=msp@baylibre.com;
 h=from:subject:message-id; bh=lkprq4BFxGGI5bmMMcK7Y37vNbeeoPrG8dPKW/YHhNA=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbv7/9Ua07tDVyX/P0L2rhMcLz116ZumPP3ldfu1nm+
 k7SZ56v1VHKwiDGxSArpsjSmRia9l9+57HkRcs2w8xhZQIZwsDFKQATOdbEyHBqwaWbqzbz/tik
 +tt9E5f/J+l3j3o+dUtMzXZwfP4oqCqc4b+vpZ2e2J3GHZJPt28r82vd9HCT8H+dxORev7Wu2ZF
 VfVwA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Similar to SIMPLE_BUS, create a SPL_SIMPLE_PM_BUS additional to the
SIMPLE_PM_BUS. Most boards will not need SIMPLE_PM_BUS in SPL.

This is currently needed to reduce the SPL size for beagle bone black
with OF_UPSTREAM enabled.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/core/Kconfig  | 8 ++++++++
 drivers/core/Makefile | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index 5419bf65b5d653464f8bf958382ede30954d6402..0471e2977d0a993afcafee11874d43016d6738b4 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -342,6 +342,14 @@ config SIMPLE_PM_BUS
 	  Supports the 'simple-pm-bus' driver, which is used for busses that
 	  have power domains and/or clocks which need to be enabled before use.
 
+config SPL_SIMPLE_PM_BUS
+	bool "Support simple-pm-bus driver in SPL"
+	depends on SPL_DM && SPL_OF_CONTROL && SPL_CLK && SPL_POWER_DOMAIN
+	help
+	  Supports the 'simple-pm-bus' driver, which is used for busses that
+	  have power domains and/or clocks which need to be enabled before use,
+	  in SPL.
+
 config OF_TRANSLATE
 	bool "Translate addresses using fdt_translate_address"
 	depends on DM && OF_CONTROL
diff --git a/drivers/core/Makefile b/drivers/core/Makefile
index a549890c22b997a8c3e7cd6ab08b2ed2ac7994b2..1073c26b2ed0009e15ccca0bac93a64d882f0df9 100644
--- a/drivers/core/Makefile
+++ b/drivers/core/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi.o
 obj-$(CONFIG_$(PHASE_)DEVRES) += devres.o
 obj-$(CONFIG_$(PHASE_)DM_DEVICE_REMOVE)	+= device-remove.o
 obj-$(CONFIG_$(PHASE_)SIMPLE_BUS)	+= simple-bus.o
-obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
+obj-$(CONFIG_$(PHASE_)SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_DM)	+= dump.o
 obj-$(CONFIG_$(PHASE_)REGMAP)	+= regmap.o
 obj-$(CONFIG_$(PHASE_)SYSCON)	+= syscon-uclass.o

-- 
2.53.0

