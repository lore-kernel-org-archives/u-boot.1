Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EE2CA0FFA
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 17:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C8386583;
	Tue,  5 Sep 2023 19:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aKDnYvU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 964BE86582; Tue,  5 Sep 2023 19:33:28 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A49A4865DA
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 19:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-501bd164fbfso1818252e87.0
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693935204; x=1694540004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iXxUSU0N4LMqy2gaYQ0QzHA99jfZjJIfU5QzoxbQU90=;
 b=aKDnYvU4LPP1L1dQDqY8RtgHpvlgC72GnIChVTxVFAXfuNs0RHeCT3V9o0PbqdZO5h
 POJ1rYY7FYwDPY6+VkIwN3+z51xyIGkaH27FhVLoVeGWHYTJbPFTOEOoOWnrwFapj34Q
 b+lNCvxtFdbFNWqq7TD1Vrb8r8B0/Ue7QODqsPf55SEUj9YuS7vXkiKIPQYoi1APFyrc
 2slx/NfABnn4hH9VHWHpCGc9L47I1MoR2BkgrY+qXzbE92Fsffam/rMb4e4tpze9dNHe
 Zoc5D/TkVhoyp5xm85uj8blniRocf/y/NXf8Yh4kU7aB+6EVR/GlHjBRZ4eh2CK+o1H7
 hLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693935204; x=1694540004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iXxUSU0N4LMqy2gaYQ0QzHA99jfZjJIfU5QzoxbQU90=;
 b=RXho0EesEkgF7B8twbgDl7JhNH2KtICByHq7LQHLRYv2G9yM4rSwmttV7CBcJMzSGn
 b7nq3twE/Ybej4Rp2zEHQ1lNVQa8LpPz76t78pfjg9OhRpWGCmjW0wyc/41qA8/P3sfm
 SP63OxMM8Bm8QiQ+Zrsom+gf325kGMkXfJ9l4UaeHEeNsQHRm0z9fVKObWIh5guqBl42
 u1PbVikyXuG3euHaUACMpBZ19delwgJ2O+AP3GePlfLjH0pEgPoVV3pztg7fUqHt9nYr
 wCfSEexi18pURijJChSDvhLJ4q0xfD3x03mRfPxhNEgLhcKcbRjQ9VkO/lLQ2zKq6+52
 YK8Q==
X-Gm-Message-State: AOJu0YwngYef+VcuKVfEdXHJpKeoJ+/aKwfLSOiZBIJXfwcf2QJqV/LP
 ei+g3uSg9CpS3wkTjhcWfLIG01gByaLgog==
X-Google-Smtp-Source: AGHT+IHG1JqADdmEM4Z+r2wnDEg8Q0hFmuUsA1RhSSoZIpDUepulB/J9Xwj9YSuQ078ivqfctfyY2w==
X-Received: by 2002:ac2:5977:0:b0:500:c709:5845 with SMTP id
 h23-20020ac25977000000b00500c7095845mr388117lfp.4.1693935203398; 
 Tue, 05 Sep 2023 10:33:23 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194]) by smtp.gmail.com with ESMTPSA id
 u7-20020a05651206c700b00501c1794883sm342357lff.251.2023.09.05.10.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 10:33:23 -0700 (PDT)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: u-boot@lists.denx.de
Cc: Maksim Kiselev <bigunclemax@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v1] clk: mux: check value returned from clk_mux_val_to_index()
Date: Tue,  5 Sep 2023 20:33:06 +0300
Message-Id: <20230905173307.3404875-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
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

The clk_mux_val_to_index() may return -EINVAL. In this case
clk_mux_get_parent() will return a wrong parent index and
this will lead to out of bounds error.

E.g. when we register mux clk:
	ret = clk_register(clk, UBOOT_DM_CLK_CCF_MUX, name,
			   parent_names[clk_mux_get_parent(clk)]);

Let's add a check on the return value of clk_mux_val_to_index() and if
it's negative, set parent index to 0.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/clk/clk-mux.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 017f25f7a5..00fe916171 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -88,6 +88,7 @@ unsigned int clk_mux_index_to_val(u32 *table, unsigned int flags, u8 index)
 u8 clk_mux_get_parent(struct clk *clk)
 {
 	struct clk_mux *mux = to_clk_mux(clk);
+	int index;
 	u32 val;
 
 #if IS_ENABLED(CONFIG_SANDBOX_CLK_CCF)
@@ -98,7 +99,13 @@ u8 clk_mux_get_parent(struct clk *clk)
 	val >>= mux->shift;
 	val &= mux->mask;
 
-	return clk_mux_val_to_index(clk, mux->table, mux->flags, val);
+	index = clk_mux_val_to_index(clk, mux->table, mux->flags, val);
+	if (index < 0) {
+		log_err("Could not fetch index\n");
+		index = 0;
+	}
+
+	return index;
 }
 
 static int clk_fetch_parent_index(struct clk *clk,
-- 
2.39.2

