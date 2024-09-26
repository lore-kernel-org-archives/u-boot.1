Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01012CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EE1588E36;
	Thu, 26 Sep 2024 22:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nBcvbGAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B61188DFD; Thu, 26 Sep 2024 22:51:59 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D27388E4F
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4581ec0e00eso9004301cf.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383916; x=1727988716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6z1TcdJHXKl/7rLTDoHi8mLi/2sRzhvfFzvXErgRNSw=;
 b=nBcvbGAcWKqC/49QccTfGyPNrj5DKirP//4k+2n8fxvNtpH7GxkO4KoznG4IxZZYEU
 sk/o2ehK3WaiRgm11BUAjpGJHrteH6KrVDjK0EEQQvFgGQbM/tp4K6ESQsuZgVN1USxj
 Xd4QMnPD8x6oPg3GVf/bEaLRyzqxlDDF5ihrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383916; x=1727988716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6z1TcdJHXKl/7rLTDoHi8mLi/2sRzhvfFzvXErgRNSw=;
 b=vw2fEpQhgKTyAaz4uHFA1Vm5gxOjMSTGB2kWFTW4eSoMWVzRxb/Wo90sHXQs82TsAF
 ONT/qkeHI0Y14+CquxM43ikT2ldKZR3VmDFvJxAW6g/SZWmccai7mxwl79bJ/FjE06Ax
 /NfDG9kywsfwXsH4U+bHhRABXP3hu5eQaWiV2PW2fDBfo1MyhOzNhXDqC3qjUHrVvOqI
 wgmMRjm59akC4XP0kbmpgZfV/as8X+ECAyaqgZBgSTx6PfMp+78sE2kfEhJizrlprurK
 US/dyX1fzohJmE971Dbu2TtKJZMfFNFwpydva47AfIhDQv7BSZ4ypMv1Yt4eBsb/XLbs
 Jz/w==
X-Gm-Message-State: AOJu0YxXd3b8cnpyYdZMBKqbGEwtiqp5Bb4kPpIoXOZGlf/W2IbyLfpX
 rqRRnYP4D5Fxi1qfllayCDHV5iCi7kcv6vmYGqlto2VaT2mMgjZ+ugrBCvR5s/JrLwPbIxhP5nh
 nFWcbSow=
X-Google-Smtp-Source: AGHT+IHXWSwDM3oBnh9buLuHDddHIl7hJmBMWvaTk0CcIv8XMg1ZUyFGwQzsYRDVghBnlpgP8xqLBQ==
X-Received: by 2002:a05:6214:4801:b0:6cb:2e1b:f5ff with SMTP id
 6a1803df08f44-6cb3b5cd3b3mr16640046d6.21.1727383916449; 
 Thu, 26 Sep 2024 13:51:56 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:51:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH 19/27] mx23_olinuxino: Drop status-LED code
Date: Thu, 26 Sep 2024 22:44:39 +0200
Message-ID: <20240926204455.963584-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926204455.963584-1-sjg@chromium.org>
References: <20240926204455.963584-1-sjg@chromium.org>
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/olimex/mx23_olinuxino/mx23_olinuxino.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/board/olimex/mx23_olinuxino/mx23_olinuxino.c b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
index b2bb6678c23..78136c1620a 100644
--- a/board/olimex/mx23_olinuxino/mx23_olinuxino.c
+++ b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
@@ -13,9 +13,6 @@
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
-#ifdef CONFIG_LED_STATUS
-#include <status_led.h>
-#endif
 #include <linux/delay.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -61,9 +58,5 @@ int board_init(void)
 	/* Adress of boot parameters */
 	gd->bd->bi_boot_params = PHYS_SDRAM_1 + 0x100;
 
-#if defined(CONFIG_LED_STATUS) && defined(CONFIG_LED_STATUS_BOOT_ENABLE)
-	status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_STATE);
-#endif
-
 	return 0;
 }
-- 
2.43.0

