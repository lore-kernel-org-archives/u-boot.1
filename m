Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356AAC2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:09:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 768EE885CF;
	Fri, 21 Jun 2024 01:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="naj0CcHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEDAD88569; Fri, 21 Jun 2024 01:06:52 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DBD887B77
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7f38f5584ebso21979139f.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924809; x=1719529609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QVjgvZkf9bVBvoxHsy/rlFaH05Vnyr++Ji4XD4ula4=;
 b=naj0CcHu52yNN6FYgCi0snzMRzKVmK9/zbTmKRNi73ZeFJdRPSNTOQexgc71A8r8EF
 7NJZjSf0NEgiHLPK2E2FVDArCsq3tNpicPLjLRPlD+x4QUAJ3LRbit8FQ3UhgTVW8dvC
 ma31lkulN+zd3U6Lm8vekpZAZMaBU6SIv6jrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924809; x=1719529609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3QVjgvZkf9bVBvoxHsy/rlFaH05Vnyr++Ji4XD4ula4=;
 b=b4mMXasckUp7TGTMToouFHuYESnmGi5bOLfMPjcDRxQxsPyzUYAKaYE2eL6Lx7X5EA
 HQMM6hlpAkJPbkMdY6B+g1FeJjQpqk36niAhczIYOSqI68zevMVt/U8Uh67R4nbFZe/B
 TaioWmweMYoUPtn94W1mS3Ib91X1kBuq6wduld0J3MqmDhdsKCoygMEMenAaazvamC3J
 GOZWWFVBjPiHWs7gBVlByT1vxwYYzQkK2V2HI9ru3eY5YIbZgXfLkMBqamPwzuAI8ilB
 hfsGEI/f0DF7eWfjyxmsefiYB4htNtkwWnmqFYAACW7zXq3f2g6N+e/tJWQ+JDD5+p7b
 GbWg==
X-Gm-Message-State: AOJu0Ywqgfp/6k7QJG2J/MdGi6j6fu1rwF9oTfVqxuMwVwx2KaSr69/D
 /mYm0XjQ7mtzGO1CZgrMXgAK78FjzDaUIQkt1O4Kn72CtUgkQDnWhoCkFRIIi9bWLEVFh4fTwtq
 j4w==
X-Google-Smtp-Source: AGHT+IHkL5oh2n8QWFqmUJweYkgfb1/CWLfNe8h7dm5tUbVkIrS0fTl6hq7uMeVknaWJTQsZJX/6Hw==
X-Received: by 2002:a05:6602:2cd2:b0:7eb:8afa:ecf8 with SMTP id
 ca18e2360f4ac-7f13ee0eb39mr786962339f.11.1718924809314; 
 Thu, 20 Jun 2024 16:06:49 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH v3 15/18] rockchip: Ensure memory size is available in RK3399
 SPL
Date: Thu, 20 Jun 2024 17:06:22 -0600
Message-Id: <20240620230625.1797397-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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

At present gd->ram_size is 0 in SPL, meaning that it is not possible to
enable the cache. Correct this by always populating the RAM size
correctly.

This increases code size by about 500 bytes in SPL, since it must call
the rather large rockchip_sdram_size() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Cut the patch down to bare bones

Changes in v2:
- Add new patch to correct memory size in SPL

 drivers/ram/rockchip/sdram_rk3399.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 02cc4a38cf0..3c4e20f4e80 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -3142,19 +3142,19 @@ static int rk3399_dmc_init(struct udevice *dev)
 
 static int rk3399_dmc_probe(struct udevice *dev)
 {
+	struct dram_info *priv = dev_get_priv(dev);
+
 #if defined(CONFIG_TPL_BUILD) || \
 	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
 	if (rk3399_dmc_init(dev))
 		return 0;
-#else
-	struct dram_info *priv = dev_get_priv(dev);
-
+#endif
 	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
 	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
 	priv->info.base = CFG_SYS_SDRAM_BASE;
 	priv->info.size =
 		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
-#endif
+
 	return 0;
 }
 
-- 
2.34.1

