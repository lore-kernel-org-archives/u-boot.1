Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5678FC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D56E0887E3;
	Sat, 13 Jul 2024 09:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UyQ+hhOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B764088789; Sat, 13 Jul 2024 09:04:01 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D171F88850
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52ea0f18500so2733902e87.3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854238; x=1721459038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMDeghO/Y6K45EmdAp4dwoHR9L9HRTg6eyWhSMrrDKY=;
 b=UyQ+hhOUYdxOvrFZVr8z2MfE92RewF/wsnfEQ5CBHOjd48hrOZ9MEwfRWd7bolnS5w
 C6FVU4Nki7ad22RlAfwZxcEQyCOYNynCikfxjWL5qaIQSn99SGZrS8LXELrG1vTCFsA+
 svvB3WZL5BT9WL5h+rpOGVGBki6I2uY5s7JMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854238; x=1721459038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PMDeghO/Y6K45EmdAp4dwoHR9L9HRTg6eyWhSMrrDKY=;
 b=E7OT+ZVzgO1xkXapbVyxVaUBOUn0c80ASIPmjj+nTt75CHjjeRE+OQh0NUwCzz6/ds
 AezRVl8K3Pd8Y0yhBFn5eShX3bHmQ3RiUN25ORBwYJImdE/zGS4W34hY/fARfa/FHs9g
 c7kYd1nvVh7olzt7DOKTJadDNCMItiOPLKbi8CovQffyRpHFRqyh9TgyJdpeszwb4ZtQ
 PoIvjfm/E7nqmfzmLtwPmWr5GAIIyOqnngnqzwrifmq6EL9WjaQy7VLNjCRQVS6iX8O5
 8x0ZX4+Z1YHku9bNjcGMup14zdT4nI4pfafLOARHwzALPHeag15VSCxP6ERGjhSSYkSZ
 9cJA==
X-Gm-Message-State: AOJu0YwQSpVUeNL/rdYU0xXEKsUWUGE/lLyaBd3mvqeLo5EpNhLLfMc7
 vB0UIZ5Pr6P9zsn+Fx76+ZCRoeyryAbOV8ze/O8pIg3Fj7bczLYhHTd23MJNR6qBGziRdpQuBWM
 =
X-Google-Smtp-Source: AGHT+IFgFUgEz0A7u+UgC4lv2Vun4w31mWqFKSe+94ZaWXEJhvZS4n8xn6zFQA/7fww1dCWUz+az2A==
X-Received: by 2002:a05:6512:688:b0:52c:df51:20bc with SMTP id
 2adb3069b0e04-52eb99942b2mr9242669e87.16.1720854237971; 
 Sat, 13 Jul 2024 00:03:57 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 19/21] sandbox: Add a flag to enable UPL
Date: Sat, 13 Jul 2024 08:00:53 +0100
Message-Id: <20240713070055.2172883-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

