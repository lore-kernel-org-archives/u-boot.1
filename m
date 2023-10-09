Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093C0E95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 14:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF66586DC5;
	Mon,  9 Oct 2023 16:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="cSKSOnkg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E78B86DC4; Mon,  9 Oct 2023 16:42:13 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C281486D80
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 16:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2bb9a063f26so57487481fa.2
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 07:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1696862530; x=1697467330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3TDoPTArIlJp2YWU3LoENoz/Ev7J8QkMqEf1OH5GIQ=;
 b=cSKSOnkgfkPOw95s4Y5Uih/0wsfIStaar/ii9hGl5sOdcSRrvwQnVPLUOBpuOQdxPw
 xpMMF1cKQchQgBPaguglb/ziiXGNzojDjM4sNZaHNdvdHWi4qC3HO9zudZ69k5MoFKX5
 VA4Z9gWzjYDbxGoi0ZkBVYUJr9Zd35bXNOSG2ab7Eydy/b78PNUx5HLL8/mwAVyQ54x/
 CsfXU0EZnhKnZa7Sh7hNBZ+wMvP7FUBUIYRymEMTyCDFHORjzH7y68hq/tl5WtoNkpok
 0zBgJbmibPlA5cSCBKokP2uigDUx5fGNy4U1nAup12gLuSwBB5D7Iir3D05Q1nqsmMU5
 BNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696862530; x=1697467330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3TDoPTArIlJp2YWU3LoENoz/Ev7J8QkMqEf1OH5GIQ=;
 b=HsT9Ud7coNDDCN28FO8+untkT04GEdhReCmF2cArMwApD2zdacOIxnmrZ91jvn/5ev
 euI/CT0QR/7beNVdq8OmQAgHCGWGMu01grMbICOs2PrGJMlR8LXPOr86x07xzPji8x3C
 76pvu1oJBUPUnDATAwhVuVzTVdg+u9uPfKFAq4X1B1dn/YGXkH+V/CEgUJ2o2USuu8TB
 8WLSlLzBDRAy6RuWKefnF0dF0xA3duBMauRMoa0Sjv3Zxakb2Fjy3iXFIa47DEbUhvbZ
 yy6AlqkfTPGz60vwj3nsu/S04cwxZ4SmEFDa8jPbJr2M5jD2MYyy7dxdu166I55I1TyE
 8caA==
X-Gm-Message-State: AOJu0YxHwpUPTKB6oHkLvdniHPUo9MoPVmDvaZyMGx5eTXXNXHdKPq7G
 azyZdyQyLS6Nj9ACTIvd7Ec8wQ==
X-Google-Smtp-Source: AGHT+IFkNfywGeP5CTf6/oLVwMsG2v8jk8+LMF/jQmlNh0Pxq2a0dE1G9Nkn9ijiN+RDCVUOjrI+DA==
X-Received: by 2002:ac2:4da7:0:b0:505:7113:1d0f with SMTP id
 h7-20020ac24da7000000b0050571131d0fmr11808638lfe.13.1696862529993; 
 Mon, 09 Oct 2023 07:42:09 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 f19-20020ac25333000000b005045bb669d7sm1464733lfh.62.2023.10.09.07.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 07:42:09 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Simon Glass <sjg@chromium.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jakub Klama <jakub@conclusive.pl>, Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v4 2/4] event: add new EVT_SETTINGS_R event
Date: Mon,  9 Oct 2023 16:41:49 +0200
Message-ID: <20231009144151.773721-3-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009144151.773721-1-artur@conclusive.pl>
References: <20231009144151.773721-1-artur@conclusive.pl>
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
---

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
index be4cefd6ae8a..a60a64718e01 100644
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

