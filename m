Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08581E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9A9E80628;
	Wed,  1 Jan 2025 23:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mewy+HDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C64480654; Wed,  1 Jan 2025 23:13:14 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B8F80317
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21670dce0a7so60370405ad.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769590; x=1736374390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0C9NMVPmKG4EU/QVCAe+yjgAZ4Q/cxxaNDrT9ByQdKw=;
 b=Mewy+HDk5Vl/C4GR9dySMBobDd0IW/BW5OrKrNho6Y1dWj2g9WXdKlY48efONUlNPF
 /gUnpsGhGgAkJ18Bm/uhYhIKp5VmIszoSTYZPl+T7o9/8eQkq/wM566cynKaG+snvjSG
 QUKPnwFjvXxm53ico9EsY233jGFuHOZj9pcuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769590; x=1736374390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0C9NMVPmKG4EU/QVCAe+yjgAZ4Q/cxxaNDrT9ByQdKw=;
 b=pWa1bJSC8SUoeHbwG79HaDm6xFfga7DC1plvpIjY1waN3JVKibh9OQa7le4ZPQVfcG
 UPMlJiqyt7yq50CtLvQYAypHy8gOWVmx3lrwrTdtmIjxPvfyLEFk1RB1a6onJRMxzovQ
 CU/x8e75j+0tn+ti9LmFeqWOpU61nUP5kqriq0eMA2yMyU68rXzJdgVuy5BE4ZAg+LPJ
 jhuD1OS/zoxEi1HdbjnM2TpP5XpO94bulEt0V5Gwl+WIEmztlRkFh1FueSiAfy3kCx4u
 E6n3GIFzhm5D6ymlZoQPAF3Tig5tMn4nbowQlnOGUoLB7cEthOV7oWsJnCL4yMt+z1W6
 Z2IA==
X-Gm-Message-State: AOJu0YwEU6hfskwnXLo1tIFZSKtj2MRHVRxw1vI6G5JPqu+mgFzvW1zd
 5A7wnzZj7yXUuTePd1VN9lK/yF4s8J91kzUYeDs+rxXIGADvJZSlBQn2UCmuXB/BomIRrTgu4OU
 =
X-Gm-Gg: ASbGncvj8+QNxfTFCTt8CxinMkqiepftpt3Z9nOPcG1sOfHgyiGDEKYm4kyFtTEAnt5
 oPi4zWK3PTgqojx++S6fA2Df1ubrRo5niuNepQgOGc0tSaGScVOamDDfKPJluyVsldbxVa1SwRW
 MznSU1np2xksf3U1rgfWKqIGx3eBtXmUJ7+168I57oDnB5o9zWKGzRoe601NEkK+vTUPFMqEkmZ
 UhcJvJlTYxXT7k4zNRWRf9RALPpyJNZmXwAF75lgviUU6J8/a/z9FE=
X-Google-Smtp-Source: AGHT+IHS7Mj2UhhwU91Ute2U5C+Td5PIJ7qXxrR2wPWWAcymfUtU7VNv6G0xViTuPG5XKFagpz/x3w==
X-Received: by 2002:a05:6a20:6f06:b0:1e1:9ba5:80d8 with SMTP id
 adf61e73a8af0-1e5e080df22mr60621258637.33.1735769590008; 
 Wed, 01 Jan 2025 14:13:10 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:13:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 26/67] upl: Drop enum upl_serial_access_type
Date: Thu,  2 Jan 2025 11:09:12 +1300
Message-ID: <20250101221003.1944600-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

We already have enum upl_access_type which is good enough, so drop the
serial-specific enum.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/upl.h   | 7 +------
 test/boot/upl.c | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/upl.h b/include/upl.h
index 4d0eca88047..9f2a6e7842d 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -169,11 +169,6 @@ struct upl_memres {
 	bool no_map;
 };
 
-enum upl_serial_access_type {
-	UPLSAT_MMIO,
-	UPLSAT_IO,
-};
-
 /* serial defaults */
 enum {
 	UPLD_REG_IO_SHIFT	= 0,
@@ -214,7 +209,7 @@ struct upl_serial {
 	uint reg_offset;
 	uint reg_io_width;
 	ulong virtual_reg;
-	enum upl_serial_access_type access_type;
+	enum upl_access_type access_type;
 };
 
 /**
diff --git a/test/boot/upl.c b/test/boot/upl.c
index 99f02b7951b..c2b571e06c4 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -142,7 +142,7 @@ int upl_get_test_data(struct unit_test_state *uts, struct upl *upl)
 	upl->serial.reg_offset = 0x40;
 	upl->serial.reg_io_width = 1;
 	upl->serial.virtual_reg = 0x20000000;
-	upl->serial.access_type = UPLSAT_MMIO;
+	upl->serial.access_type = UPLAT_MMIO;
 
 	alist_init_struct(&upl->graphics.reg, struct memregion);
 	ut_assertok(add_region(uts, &upl->graphics.reg, 0xd0000000, 0x10000000));
-- 
2.43.0

