Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA893C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE9F88BC1;
	Thu,  8 Aug 2024 00:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hfQKZ3Iv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84EEB88B57; Thu,  8 Aug 2024 00:48:23 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65EE0888CF
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-81f861f369aso49202639f.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070900; x=1723675700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMDeghO/Y6K45EmdAp4dwoHR9L9HRTg6eyWhSMrrDKY=;
 b=hfQKZ3Iv0AmaDBiI7HUpi0bUJZ1G6uYoOV+NyCX9tj+kvUH8o1pC7L1Oj/Jdzr+uLc
 77qVFbqeoNs78c5k7A6sb65fLU2uGufs14veStSyRcp9k7vp5Y7YU1n8QB0G9sOAnqey
 qd8PpoFTq/xM3UFhErLPl2kzqPG5pP8AjiFmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070900; x=1723675700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PMDeghO/Y6K45EmdAp4dwoHR9L9HRTg6eyWhSMrrDKY=;
 b=LraEbzsP7kvjyNAdyJctGbnEhMdsUl5uY5mEMmrhjSkUSVWwhtRqBfwJcqIMKLJx9/
 lJmVmonRYbvsgVTXtiXkbKbRV/6f/Vg6G+lPhAz3dsTGTcJ8a5MsuiSwQsehyTxXAgnI
 YEIpcU3v72pPvZ7/rF9gLu0xFyVcM7/DwM+Hi459lvnG8DNhJM+sbrA/tuFNNyKUD/F+
 d4fpND7q2b1hCkNGepREnJfvtKa8TIyev1ce5xGTmdFX63Ix5sNvrAsSpIio5ZCNgOro
 dMFTNddRIMd9Ga8do2tX/zBzLgDKrCW+q2MYGSaAF37WoR+RvGVKFXi60BLS8CiNUfqK
 AAAw==
X-Gm-Message-State: AOJu0Yzk5j9nqhdZJbQinLU/tTvxJ8UeV1mwkHylpKL58rHQ5AO/8JTv
 zKHy2J9uH+iwuBGZ7ogugx7CgqnHV4GNf78JPxFjH3b9E6bWwBSrqalM55SKKQ5iE/0KaHB7+7U
 =
X-Google-Smtp-Source: AGHT+IGdwh/AgYw2ZLxLa0Air4hgusYMgdUcFQojywjtbVSLzUldZh6vDcE3OwMyr9W4pRsydN/zDw==
X-Received: by 2002:a05:6e02:1d81:b0:376:1fe3:f6f0 with SMTP id
 e9e14a558f8ab-39b544bfcc5mr31620815ab.1.1723070900084; 
 Wed, 07 Aug 2024 15:48:20 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 19/21] sandbox: Add a flag to enable UPL
Date: Wed,  7 Aug 2024 16:47:37 -0600
Message-Id: <20240807224739.3858517-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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

UPL significantly alters the boot flow for sandbox. Add a flag to enable
this so that it can be enabled only on tests which need it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/start.c         | 13 ++++++++++++-
 arch/sandbox/include/asm/state.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index 0920ed55965..9ad5d46271a 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -431,6 +431,14 @@ static int sandbox_cmdline_cb_autoboot_keyed(struct sandbox_state *state,
 }
 SANDBOX_CMDLINE_OPT(autoboot_keyed, 0, "Allow keyed autoboot");
 
+static int sandbox_cmdline_cb_upl(struct sandbox_state *state, const char *arg)
+{
+	state->upl = true;
+
+	return 0;
+}
+SANDBOX_CMDLINE_OPT(upl, 0, "Enable Universal Payload (UPL)");
+
 static void setup_ram_buf(struct sandbox_state *state)
 {
 	/* Zero the RAM buffer if we didn't read it, to keep valgrind happy */
@@ -540,6 +548,9 @@ int sandbox_main(int argc, char *argv[])
 			goto err;
 	}
 
+	if (state->upl)
+		gd->flags |= GD_FLG_UPL;
+
 #if CONFIG_IS_ENABLED(SYS_MALLOC_F)
 	gd->malloc_base = CFG_MALLOC_F_ADDR;
 #endif
@@ -558,7 +569,7 @@ int sandbox_main(int argc, char *argv[])
 	log_debug("debug: %s\n", __func__);
 
 	/* Do pre- and post-relocation init */
-	board_init_f(0);
+	board_init_f(gd->flags);
 
 	board_init_r(gd->new_gd, 0);
 
diff --git a/arch/sandbox/include/asm/state.h b/arch/sandbox/include/asm/state.h
index c84a1f7060f..6b50473ed41 100644
--- a/arch/sandbox/include/asm/state.h
+++ b/arch/sandbox/include/asm/state.h
@@ -97,6 +97,7 @@ struct sandbox_state {
 	bool autoboot_keyed;		/* Use keyed-autoboot feature */
 	bool disable_eth;		/* Disable Ethernet devices */
 	bool disable_sf_bootdevs;	/* Don't bind SPI flash bootdevs */
+	bool upl;			/* Enable Universal Payload (UPL) */
 
 	/* Pointer to information for each SPI bus/cs */
 	struct sandbox_spi_info spi[CONFIG_SANDBOX_SPI_MAX_BUS]
-- 
2.34.1

