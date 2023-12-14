Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1D3C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D98A87AE5;
	Thu, 14 Dec 2023 17:51:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j1tRgmpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9D8F87ACC; Thu, 14 Dec 2023 17:51:49 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D250287AC5
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-35d82fb7e86so25047085ab.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572706; x=1703177506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y23neOU4idWVpv+eW8UmVRXPVHbMLB+fUVdIT01bSAI=;
 b=j1tRgmpmwnpp7evI9Q/JkZGGmKT0T4vqZUWh113BMu29a0HzUZ+5AXd40qvcOrX2jX
 CFWQpblGj7GVEQG/FNxqxkhgLqImSMwxzb7t68oHKIITpuKsn48B5J/WiVgerC9ObMqR
 ze2ikLGWDfsWd/1TFuni+pQwzm4xHKtuAlzDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572706; x=1703177506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y23neOU4idWVpv+eW8UmVRXPVHbMLB+fUVdIT01bSAI=;
 b=Dfzur2Ilh9wH83U8I80Ag5+rrDEkJknX+RSTj9mHwilg598AZ5hhjX9eGJiLkmxawp
 ui3bJcZgBid2pJZWaKP8NU0slNqS66/NafHcEC96sGPXxHsMU0vuS4cqHojaiukkF6Wk
 dLNE+NycNqqz5hMR8NFPaAWkJmqKVECpEUNrN6qCf8ItGtBjvzq7hb2G6eB9uLMgBu7u
 oWHHWnFop+tRimkNQ6guMpFVuhFxQKQXeIlY3X7trcEuP7lcxg3UGe9DHuUNKn2vHK33
 6Ym4JeYsIC8b8kmO4gsD0pMLpAQpKc+DyqGBXJSok/gUbLCXCsBFqE95HWWrWbPhz5PS
 KPdA==
X-Gm-Message-State: AOJu0YzEKshPn7lCtXrQ1kCcT0Ym94q2LsViyWZKV1655PoMcyO/R29k
 k8R1X/oPpz63R40Sn+L5u+Pojzx/DkP8SZckKl1IMQ==
X-Google-Smtp-Source: AGHT+IF70Yc9RsBbHOfLBS4IdtiSqkyZh3B6mjKsuFW1My/WTpe7gjRvT6nmpFZo3qFTB9E/gd8nOw==
X-Received: by 2002:a05:6e02:178a:b0:35d:658d:40f2 with SMTP id
 y10-20020a056e02178a00b0035d658d40f2mr12064820ilu.47.1702572706424; 
 Thu, 14 Dec 2023 08:51:46 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Scott McNutt <smcnutt@psyent.com>,
 Thomas Chou <thomas@wytron.com.tw>
Subject: [PATCH v2 04/21] nios2: Add a reset_cpu() function
Date: Thu, 14 Dec 2023 09:50:13 -0700
Message-ID: <20231214094939.v2.4.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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

The current do_reset() is called from a command context. Add a function
which can be used from anywhere, as is done on ARM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/nios2/cpu/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/nios2/cpu/cpu.c b/arch/nios2/cpu/cpu.c
index 79a54d1bc259..de7bfa947f11 100644
--- a/arch/nios2/cpu/cpu.c
+++ b/arch/nios2/cpu/cpu.c
@@ -35,11 +35,17 @@ int checkboard(void)
 }
 #endif
 
-int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+void reset_cpu(void)
 {
 	disable_interrupts();
 	/* indirect call to go beyond 256MB limitation of toolchain */
 	nios2_callr(gd->arch.reset_addr);
+}
+
+int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	reset_cpu();
+
 	return 0;
 }
 
-- 
2.43.0.472.g3155946c3a-goog

