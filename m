Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E30C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:16:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79AF882DE7;
	Mon, 26 May 2025 12:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CkuaYQpB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63892836AB; Mon, 26 May 2025 12:16:13 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4711882B19
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d817bc6eb0so11358805ab.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254569; x=1748859369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDZYbCANs+oDTwPhSeiewF+MloaTA7lZ++Gou2LVcMs=;
 b=CkuaYQpBrR+4gUzIL7KLiZWJzrxJu6HLLsnk+ME5v/32Y4Uj3W8/xLa2rwV3uMy0JH
 C7xWvjrsWu96Sfc1/NvG7UrbPy217j6n2pzgs/yB0rrpeu52DTgiqt4JF+YWF/d79eKi
 8TRk0DeojA62GN/P1ofdbpvbJSxYyeMK+nT08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254569; x=1748859369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDZYbCANs+oDTwPhSeiewF+MloaTA7lZ++Gou2LVcMs=;
 b=Sp6b0di2ep2M4zGlx0+7jKVtgGatA6KMMOvTffk+oU3d9GiQqpg3HORScEckHd7R69
 cE8dD/LCG1Ud3VZLJnAzhqylQhK04/7LouWQ2F5Wqkxube7mqi9kg8BoLmeot4z85dMq
 DfGefshqsczUnEtUw8d53LR0zo4I8lSouKOhdlnbi377nFUb+msviw/F4930uCWfi/xk
 8zRxJa1y0xp0q6I2HLCTJ5BWuFopilqtgy3gELEeJufVtwmolzZoSC+PfkqogTC15dK1
 tFWN0qNTSPrRVwZiOCD5mwUcZqJ3Dx4/GB3pwRtRybpdjHjyGoJxdI62wM8sKj3QlAz7
 Iq8g==
X-Gm-Message-State: AOJu0YynTmi3CFooTmwsuHtf0X+eDhEUIEqNNFfQHHID3eOfGxy0fp1T
 2CjLbTSJ8ofHacInVZzPMHyu9+yK6cUBO0FERvrpIYS2sJgA3/pFfJAovaOMOJE0sHzbNLFOrxE
 bpniDNHi0
X-Gm-Gg: ASbGncsJgtY4cKSu3xSmscgHf1HLMjblQE6SeO/7pk4kT5ay0HuFJuYw3QhEjLkYiQJ
 Mk2YxEPtILr2YSDikSNIcQYuEFFIg/3thlZl2XAqcz9QsY9rUSTai6C4cLYhGPndYvKrJpFE8wW
 XtHXEyi3IRza97OmKooihIrFKZge85tP0BKKnAd6eL2KBPUEteNWJ0JE6jlM+qF65CmqhedtiFQ
 ibyTvtpb66K14pfssQj8QLo1apgbxIaZTUJBdGMx6XXpvnxua+bV6HBBYEJvC8WkH5ukls4wyGW
 GxNWARlsUsxBWcS84htx2KxeWxEEpF/BcVlwm7boCKZhkNZVn+Qz6xZLZ0q72lSsgicnvEzsCTI
 GylK+M7asRTWh
X-Google-Smtp-Source: AGHT+IGPfNlHk6v7ZH1PP36VDjM2a+DdBNKslum/NX2kUrP/H4lZP9GHhheez1u92/jhdHz4ElZqhw==
X-Received: by 2002:a05:6e02:19c8:b0:3dc:7fa4:834 with SMTP id
 e9e14a558f8ab-3dc9b75b679mr73698375ab.15.1748254568768; 
 Mon, 26 May 2025 03:16:08 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 04/25] rockchip: Allow RAM init to happen in SPL on rk3399
Date: Mon, 26 May 2025 04:14:50 -0600
Message-ID: <20250526101541.3254628-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

TPL runs before VPL. The earliest updatable phase with VBE is SPL. We
want to be able to update the RAM-init code in the field.

So when VPL is being used, init the RAM later, in SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/ram/rockchip/sdram_rk3399.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 6fa8f268770..9ac16dfdc71 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -194,6 +194,7 @@ struct io_setting {
 static bool phase_sdram_init(void)
 {
 	return xpl_phase() == PHASE_TPL ||
+		(IS_ENABLED(CONFIG_VPL) && xpl_phase() == PHASE_SPL) ||
 		(!IS_ENABLED(CONFIG_TPL) &&
 		 !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) &&
 		 !not_xpl());
@@ -3195,8 +3196,9 @@ U_BOOT_DRIVER(dmc_rk3399) = {
 	.of_to_plat = rk3399_dmc_of_to_plat,
 	.probe = rk3399_dmc_probe,
 	.priv_auto	= sizeof(struct dram_info),
-#if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
+#if defined(CONFIG_VPL) && defined(CONFIG_SPL_BUILD) || \
+	!defined(CONFIG_VPL) && defined(CONFIG_TPL_BUILD) || \
+	!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD)
 	.plat_auto	= sizeof(struct rockchip_dmc_plat),
 #endif
 };
-- 
2.43.0

