Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D358CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 14:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E2C86FB7;
	Wed, 18 Oct 2023 16:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="OeaszQ1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6210186FCD; Wed, 18 Oct 2023 16:01:43 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D306986FB9
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 16:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c50fbc218bso66489991fa.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 07:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1697637700; x=1698242500; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e41jXYZ3aJBqR5kgmS3hwSDM9OaudguJizWu7EecAr4=;
 b=OeaszQ1yZwz+fwqYa2AMbMsvXA4pxe5lAK+WyInprqsbqkl7LcWdt2YkAApsmf1LZM
 Z2pgtRiZfhRBqegpCyQHKJOjIOWJ3v6A24SW2Ch+Z5kdoMicYvTAdJOHO2tQZN3XPC38
 PBpjC4lSIKVZdj1RM8Xek5hfU8oZhU4EQOVXIW4aZVQHKlZyLx6zMLHg8s/2w8+5kV6J
 m4ln2ypT1YMic/qLd9+/Ic8VG4rB77uFVfSuhjuJ78SHoDPfXitOKX9T+NXDcKYsFg1L
 ObwvWhNy18N/fGyeWjCgkKjUAKXg6FYMPpbGSpVvyJ30F977BNiVCneEU8A8UCdKsNpT
 1gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697637700; x=1698242500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e41jXYZ3aJBqR5kgmS3hwSDM9OaudguJizWu7EecAr4=;
 b=xJmgFwXiYsZ6jYE1GvKQqaX0lA2Et51SLlIey8Pl9I/fLj0bOJqrhI4Ndf6qMcmT1g
 mzqMh94Xb7PoOVJ0d1Yjlp07Y5pbiNnQqUM0dGRQAWFzgzXoDYkZlB65ksEK6CI70WPq
 wa/ZPxLPEI9TKOQaLBpxgIoOTEf3BM3qn1M+lw0SlHWu9yzw6OqtSgzpEqn973ZF2cyK
 IOF5mOkVlPeSTWqDwVWfRiF2xJgVdHIzxLsqqDuCIC2f+569A3TQFGQe2uOmlrdL2zWS
 8xuoqZ8AtjO9oG2rzlwwPkCevJgXDT+5np/vJi+RD+k7eKe2LsOo3APs2rLuTzfEo7Uv
 OYEQ==
X-Gm-Message-State: AOJu0YzGtobUbxVcKaW6uHV2ocbwxIP7mYzZJwXZMAbYa8zGBlmFuBHc
 ndMLgPigznDC/HhPPFPLWQh5xA==
X-Google-Smtp-Source: AGHT+IGMI7OOp/KuRyLobAUT7oYVEyMjy/LYkIEKPTJDUWMoa7BWZIdLqvNwjKwm37J4SEL2vJEa1w==
X-Received: by 2002:a05:651c:83:b0:2c5:623:aa01 with SMTP id
 3-20020a05651c008300b002c50623aa01mr3753186ljq.49.1697637699709; 
 Wed, 18 Oct 2023 07:01:39 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 f2-20020a05651c03c200b002b9bf5b071bsm718692ljp.20.2023.10.18.07.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 07:01:39 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v5 2/4] event: add new EVT_SETTINGS_R event
Date: Wed, 18 Oct 2023 16:00:57 +0200
Message-ID: <20231018140059.161169-3-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231018140059.161169-1-artur@conclusive.pl>
References: <20231018140059.161169-1-artur@conclusive.pl>
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

Introduce EVT_SETTINGS_R, triggered post-relocation and before console
init.

This event gives an option to perform any platform-dependent setup,
which needs to take place before show_board_info(). Usage examples
include readout of EEPROM stored settings.

Signed-off-by: Artur Rojek <artur@conclusive.pl>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

v5: no change

v4: new patch

 common/board_r.c | 1 +
 common/event.c   | 1 +
 include/event.h  | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/common/board_r.c b/common/board_r.c
index 52786901be55..a7967849dc0c 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -693,6 +693,7 @@ static init_fnc_t init_sequence_r[] = {
 #if defined(CONFIG_ID_EEPROM)
 	mac_read_from_eeprom,
 #endif
+	INITCALL_EVENT(EVT_SETTINGS_R),
 	INIT_FUNC_WATCHDOG_RESET
 #if defined(CONFIG_PCI_INIT_R) && !defined(CONFIG_SYS_EARLY_PCI_INIT)
 	/*
diff --git a/common/event.c b/common/event.c
index 3080d9ed754d..dc61b9672f32 100644
--- a/common/event.c
+++ b/common/event.c
@@ -37,6 +37,7 @@ const char *const type_name[] = {
 	/* init hooks */
 	"misc_init_f",
 	"fsp_init_r",
+	"settings_r",
 	"last_stage_init",
 
 	/* Fpga load hook */
diff --git a/include/event.h b/include/event.h
index c5646b713ad8..a8f046da3c32 100644
--- a/include/event.h
+++ b/include/event.h
@@ -104,6 +104,15 @@ enum event_t {
 	 */
 	EVT_FSP_INIT_F,
 
+	/**
+	 * @EVT_SETTINGS_R:
+	 * This event is triggered post-relocation and before console init.
+	 * This gives an option to perform any platform-dependent setup, which
+	 * needs to take place before show_board_info() (e.g. readout of EEPROM
+	 * stored settings).
+	 */
+	EVT_SETTINGS_R,
+
 	/**
 	 * @EVT_LAST_STAGE_INIT:
 	 * This event is triggered just before jumping to the main loop.
-- 
2.42.0

