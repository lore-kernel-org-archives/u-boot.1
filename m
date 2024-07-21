Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150E6C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C302288387;
	Sun, 21 Jul 2024 12:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MyhocUCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D34887DEA; Sun, 21 Jul 2024 12:10:16 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CDE087E2E
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266eda81c5so27290705e9.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556612; x=1722161412; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMDeghO/Y6K45EmdAp4dwoHR9L9HRTg6eyWhSMrrDKY=;
 b=MyhocUCVBVyhn2hTpaiZxTN3cMLRvotQ6KmC4/+ltdY2XxZL4kZRfMVamnjfI44tDD
 DYtGHWUTua0CghWYsm8uUKhLusjzfrooWj40nZnPoEwZ0apLC+XBPHRTRtmq7kbGHAYY
 QRks/TL77Kdsj5+yrRfVD7sc3wgc5LPXNtmH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556612; x=1722161412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PMDeghO/Y6K45EmdAp4dwoHR9L9HRTg6eyWhSMrrDKY=;
 b=n25x4e1hV0+ZVrTCK0Fyen+fbzU7BrYuNEqFVQyQrmLnUyLrLDbrk8xqrKHCDcHtG6
 FCE4qkeMPviDwtEWV5GMk86z8dHJELHYxP4rbj7XdNi5clLZjhIzjbqxWQnAEvaqiHKC
 LWAID5r8Rp3+YP2gWjbjmcEM/d0hR4T7n++TvF8aGtl9QxylzbIjoLVoZUaqAPk4tzA1
 F882AvpZ1Hm5bcAHNLMVq0M2eRSFRWKcNEAlVuH/D8mgpbWdmmB0JRzMhMaO+n1tfCYY
 Cy9d5tqHdT8FVxGlpZrgGxJHykgS3qEStlRE6HARMzD2FUe7f5kDsmJw+WxagDMWiltS
 oiAQ==
X-Gm-Message-State: AOJu0YyOsX8lOk9fMkHr4xUUKX4vmV4VqToBX0tof0RUlDZZYIZD/ZRO
 931+B/mFlYFiXBYfBvD0/wSn9uVkCovqJ9aPDcns0fVw/ryxKfkFHf0TLiXdYIHZ8SjVmQKDFS0
 =
X-Google-Smtp-Source: AGHT+IFjWMrY7h3N+wEE7ah6xbGGhQHzTAd7gdxLc5gQblPa6DGzhceOJFzTSSiGNOIdjt/XRjfdBg==
X-Received: by 2002:a05:600c:3b26:b0:426:5b44:2be7 with SMTP id
 5b1f17b1804b1-427dc5204bfmr33447605e9.10.1721556612436; 
 Sun, 21 Jul 2024 03:10:12 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:10:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 19/21] sandbox: Add a flag to enable UPL
Date: Sun, 21 Jul 2024 11:09:37 +0100
Message-Id: <20240721100940.3202027-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
References: <20240721100940.3202027-1-sjg@chromium.org>
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

