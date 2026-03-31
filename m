Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A8CFF60D9
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 08:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CD01840BE;
	Tue, 31 Mar 2026 10:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bhKuy+hx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC83F8408D; Tue, 31 Mar 2026 10:01:42 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E5D84099
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 10:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso60502745e9.0
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774944098; x=1775548898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oUxZQYLSGSVNDMCuRR2atuqUV38+bRliJUF+/W8O4A=;
 b=bhKuy+hxaBSTyuqov7bCBVC9r9Oc651d9PafAJXseKrnP7mq6FP5Ey97sK/xa2bCCa
 cIe8G77JHVlkI/hukMKbCEQ1mfKVbA4VAyhM6XC1FlUjl48+GGbXaaVM/a8g5vabSpCi
 RA3dHfVZKcVQEw0zS7ChrAMeWZltZ2u+32lai6ZANx3KNXAtwLlBL+g2XlNJqzIeknWQ
 DJx2d7ogePHXaN7IsxDQSSIL5htsFV7KFMttPSnQbhCV+WvlqvZ9EccbvVCj9CiA9Q7X
 NYLIbilk5w0gMaaeIEQAjW5OxXIesaNBdNhKaLGAYLWk7JDL0V/q0EpNQvmjasm7A4sp
 kxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774944098; x=1775548898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7oUxZQYLSGSVNDMCuRR2atuqUV38+bRliJUF+/W8O4A=;
 b=dbYObwud+Ms2j1mWeR8SABviQKxLz7ePZ6ACgZf2diAvXh7WS3mt67Qr+bmkArtIgM
 fBZmF3La/ee6NTaPVrofNU3pqG/0gyB0C4rezOGQ8vcZOstcHUZnj9PLHVeek2zhAPqs
 LADvgrOV6PmGXexXlVnvKAm2VKVcsGI3GOlFvX5MOZtLUW4sm2QTxLPQYnUuGRALweY6
 J/sG3u0aZNW1hcce2nbKZpHPySCPrANG9Q+y6vXX2Mb3nUGDgE+GEHxps4As4fscHJ+T
 AfHRnAeKXZx1deOLgQyU10JjIE+tEksvhRO/TwJdg4jJ+pwgJQonKOSHgGlQ/zLxgZdc
 2wSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhPl9ACGf0zem8nZPXREBxMZFYh3McEQYgbAukDOFHbulf5wV6bj/QLZvi7tc7n9tXts50Jmo=@lists.denx.de
X-Gm-Message-State: AOJu0YxeBtAFjNjZuCUdleoIaAhH+IKYOR6Muj6RMWjQY09bej3Z/vez
 3P5r+PNdxSDZCeCtP+koB1xK+JSqEAkHqaloHRds8/zGjmWWccGQaLCvLGJHCTPT2DQ=
X-Gm-Gg: ATEYQzz01gWPchZNJf5MQMcTC+mBMcywGqauXgq06QIW1btMekCnf9vqh33RuiWV0Vc
 zMn/S/S8DufrV0HdaHg5nHhnlJctsWs41sbwxSWV5XJ+uceK1F5DNQjazRsjfu0P/blRQUiooEO
 w+3vw0sb0ZzJ5te4PWlBmTstFEueZIVRePrv5Wt8x5oMS0Z553zl1a9ACBsVOHrTeWGoK6DKglK
 59/xqloiwAEHGhOU1WNedyRBK9wqpJ1BU9N1mxQf9CYlnQmI6C5LxEbDaCidyu2iiWo2weARJJy
 nXvjMr3i2VfSw+UrPFvJ4oJxkx450ZBkaRmB1qYEfgwuIuMhgmpmhlV0vNzLhsPy5Sb6fx/igZ/
 T7HuFHhP9xuzTly3G36zNhJgXgWeFz2cldl+FUh8s2IeXZ5JcsbfVFIKG/HrQ65V9yh7S2xyl3+
 IB43V3U2NZ23fU9kScOHBpI9Hcbjghv3QIUSLEjPF7jPwcOaHRomr69QO47QeDAqDJAUWH2jqen
 V0V2g7C8n3OYAH9Ede/iXMUN6YZyI52TH7hXA/+TfcoXypdPaZSTrwgtFF8NzZsAamSmNNUnlrU
 KUnJkBJJvQrx5pjCBoyU3R5ua7ZG1IacwgQ9l8w5DnCKjaG7HVjuYSFpHDDOUTXDlo90gD1ixIq
 EvmseFkw8AoCcmXOOufVoUJRj1q7hjybsJTpwx0/t9mpJHHNV+U8PO3jum1hnP5/8d2lXSeg0aV
 k/6Lkw98LKJ2mjmsl2z9aOYT0yBKi/zLHNhkwmtzCTuNAxaOA+F/0ecqk+U71z
X-Received: by 2002:a05:600c:a408:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-488783820d1mr31232785e9.8.1774944098362; 
 Tue, 31 Mar 2026 01:01:38 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c9250afsm10087065e9.36.2026.03.31.01.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 01:01:37 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: marek.vasut+renesas@mailbox.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH v2 4/4] common: Allow relocations on the top of the last bank
Date: Tue, 31 Mar 2026 11:01:14 +0300
Message-ID: <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
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

Right now we only relocate u-boot to the top of the first
memory bank unless the board specific code overwrites it.
This is problematic when loading big binaries as it
fragments the contiguous memory space for no apparent reason.

It's worth noting that there are cases where we must not relocate
above the 4GiB boundary (64bit hardware with 32bit only capable
DMA). E.g This will break platforms, if the ethernet
controller cannot DMA above 4 GiB, and once U-Boot does
get relocated above 4 GiB, the packet buffer which is built
into the U-Boot binary is also relocated above 4 GiB.

Add a Kconfig option and allow the common code to relocate U-Boot
to the top of the last discovered bank.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Kconfig          |  7 +++++++
 common/board_f.c | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Kconfig b/Kconfig
index ce25ea24a60f..3ebdee1b2794 100644
--- a/Kconfig
+++ b/Kconfig
@@ -474,6 +474,13 @@ config SKIP_RELOCATE
 	  Skips relocation of U-Boot allowing for systems that have extremely
 	  limited RAM to run U-Boot.
 
+config RELOCATE_LAST_BANK
+	bool "Relocate to the topmost memory address"
+	help
+	  When U-Boot relocates, it chooses the end of the first memory bank.
+	  Enable this if you have multiple banks and want U-Boot to relocate
+	  to the topmost memory address
+
 endif # EXPERT
 
 config PHYS_64BIT
diff --git a/common/board_f.c b/common/board_f.c
index df2b0dc899bf..4270f368e653 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -309,6 +309,8 @@ __weak int mach_cpu_init(void)
 /* Get the top of usable RAM */
 __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
+	int ret;
+
 #if defined(CFG_SYS_SDRAM_BASE) && CFG_SYS_SDRAM_BASE > 0
 	/*
 	 * Detect whether we have so much RAM that it goes past the end of our
@@ -321,6 +323,19 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 		 */
 		return 0;
 #endif
+	if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK)) {
+		phys_addr_t old_top = gd->ram_top;
+
+		ret = fdtdec_setup_mem_ram_top();
+		if (ret)
+			debug("failed to relocate to ram top");
+		ret = fdtdec_setup_ram_size();
+		if (ret) {
+			debug("failed to calculate RAM size");
+			gd->ram_top = old_top;
+		}
+	}
+
 	return gd->ram_top;
 }
 
-- 
2.53.0

