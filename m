Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332CBC0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1415807D7;
	Sun,  9 Feb 2025 22:15:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HzcZ8J9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5A2A80A2A; Sun,  9 Feb 2025 22:15:45 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B6F8809D4
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3ce915a8a25so13250015ab.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135740; x=1739740540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDZYbCANs+oDTwPhSeiewF+MloaTA7lZ++Gou2LVcMs=;
 b=HzcZ8J9tCi9klR6xOvqCnCj/xAGYdcLztN3cHYTmxRKMElZEt3SzcxDuuMANKmbAq3
 hHn5EXStBO2jPq+LTM7F7pFdc3ojW+ZsDOjsAhqEKMQ0shXtoNtYWJ6HS5eYC2Ldw679
 1RqH3reyzLJ321/uT0jevatnhHGtdmHmhsrBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135740; x=1739740540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDZYbCANs+oDTwPhSeiewF+MloaTA7lZ++Gou2LVcMs=;
 b=mGB8OD2ouI5yXuqjhI1kuw75s/XR3LIygfpTv16dgWK+i2zV2un2IsHOGolxZwGReP
 QzCDVR8jtYkiwVUtHUNF+/o6fPwFwAf1tgSeqWTT9lhS7g5CwByuGvnpVqGJj2UB9EYO
 +BLVrdvPysB7N4LRsN5yUjAV4MJTDsnRj36k1nPCtTC+xjbJXoEh97obP0g4GSLwmQiI
 SbcD6yljI3O1zi6SWWksbqbmk/Gi7aZOuMKJ7m8dLj4sDxzERpLvJJJG2R9gAfyiESZl
 7fawoVVnD41vjtYFO98JiOmQeoJ8N8ydB2mrbC9Sih58oDw+HmBMN/92/h7CBLQ7mI7y
 4R/A==
X-Gm-Message-State: AOJu0YxtvctWwrzQjTLxaNWKW5CACKa8fsaBBbVI6q2sJGuLfGOQjtr4
 imuEiZxU4Qb9/18sCi0bzOr/zM8cykCnrJIsrJk8KyMC5VRhjZMoyCZCf7t+ajGCfK5JKF4Y120
 =
X-Gm-Gg: ASbGncuVrufAM+ZqVImzDi8+NJBTrcpYNPcrqoCrOipdd8Lg1xcjkmZA09UB1TaeEQo
 V3FkB5MDD2eZzcMLW0CElf7U32mou2DSgdqJubInbEwRm/DNcJbCk4ZrglUkmLp0ASUHxlUr43s
 4Rg1dS+qqK/Q8qr5exPbLeiB5yItc8vjuQU5PKNjQgT5P0Y3GED3FFjhX55qxIMAIQqqOAU7Jg+
 ouY97rl6FOLH5GBNrf2NkJaHqSopDdmQla9VbXPP+mq3aZaA98mxEY+D8r+fs3so8Hit7AZzlSF
 XJVbSUPbk2ZVsjK6etXzJFfo4p+1eythWcP+H1k10dXLUoP8sZCI
X-Google-Smtp-Source: AGHT+IFcUm+YWwDjUZxkss6aAaeFCnT/yZ4Fhe3p1BGjExgEZmn39sWbVtk5t3cP/7XYQwzH/wROjw==
X-Received: by 2002:a05:6e02:180d:b0:3cf:bb11:a3a7 with SMTP id
 e9e14a558f8ab-3d13df248abmr81858185ab.17.1739135739756; 
 Sun, 09 Feb 2025 13:15:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:15:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 08/35] rockchip: Allow RAM init to happen in SPL on rk3399
Date: Sun,  9 Feb 2025 14:14:29 -0700
Message-ID: <20250209211502.2299245-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

