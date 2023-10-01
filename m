Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8041EE748E9
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 16:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FF70870B6;
	Sun,  1 Oct 2023 18:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z6NHgqva";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48F6285DFA; Sun,  1 Oct 2023 18:14:08 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C4C85DEA
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 18:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=viraniac@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6c64c2c0f97so740674a34.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696176844; x=1696781644; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qKqhK+819jTXwgCpGk8Kno4Z+2i1UHCrJPCLLk2ARU8=;
 b=Z6NHgqvaah3fB09F/TVRlzC7594Z9JAML2ZViPmXO+3Qbm07cVGjh0Ls0dDDp1DMxd
 /679sxQOvdIWIJ+HRJLByzbXPSTHAi/7mTCf82Ec6Vn7o1di0iFFqGNSpkhChu1CMXuL
 xHBAoWuoGIQ368XiOwaZkBNrQ6X2Zt8bgohCEceje6hCLWIx6cPNYP7ObtkqaYxYfPbW
 XkWPTSmrL6Y7RhD6fiZNX7GRQx+Us0Z6Eq0Gcea7mTCYfwyDFIZ4GhpBsEe+KzhE9hCC
 1bVS8ZOJnKUHhAY2c3VOGaPZl41qoZVAWyN7FikDjTBfwBrM9mDa2HfyIo7OtqIgldEm
 zU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696176844; x=1696781644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKqhK+819jTXwgCpGk8Kno4Z+2i1UHCrJPCLLk2ARU8=;
 b=Nk2zdMxFO/uHBHcf/j9tH05110me86uI4v6hcwJ22dyrd6SSoiPbNk7KprGPwRuwab
 b8fc9ueq/pWrHmzFWXUJLuSN6MzPgD32rAUPsFRLgIPepb+51qZb+55W754MX1qa6mHX
 GBINiV4KWb3opxc/hSEN78vhZvvY667UHBWX/B5yvVm2dYOQkKRG35NvE4jV6OLfQMJQ
 7ZR4XNiOcwVLUBawEXeoeiF/nm9DQwgq/QeFlUjFBXF6f94tIGO9NSt7u6sCJfH6bUo7
 xJLmEHV2aE7EpLEFt3h012rp+bVVf6P7UxthZ+7V9Ie3jfMrVWLN/NOCgqdLsfFjlLj4
 BxOg==
X-Gm-Message-State: AOJu0YwQBL3XhyDLn390iiDF7eB3CsTex/2dkXxMgLoCFs/EM9SWKSt6
 pvu44QWQ2TcgFdR+DVuPIOR/QexcIloTJg==
X-Google-Smtp-Source: AGHT+IF3hCVWedY53QyrokIA3jNmhpN/ab+9bhpTygQgf5JmjShwKO0PFFpOKzhlMJ/6G99NOnKXOQ==
X-Received: by 2002:a05:6870:1686:b0:1bf:df47:7b5d with SMTP id
 j6-20020a056870168600b001bfdf477b5dmr11033487oae.24.1696176844476; 
 Sun, 01 Oct 2023 09:14:04 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:1005:b0fb:a4e0:d431:5949:1fcf])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a63af16000000b00583f73b7bcbsm10905058pge.58.2023.10.01.09.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 09:14:03 -0700 (PDT)
From: Gunjan Gupta <viraniac@gmail.com>
To: u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, Ondrej Jirman <megi@xff.cz>,
 Gunjan Gupta <viraniac@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/1] sunxi: dram: Fix incorrect ram size detection for some H6
 boards
Date: Sun,  1 Oct 2023 21:43:32 +0530
Message-ID: <20231001161336.31140-2-viraniac@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231001161336.31140-1-viraniac@gmail.com>
References: <20231001161336.31140-1-viraniac@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Oct 2023 18:17:08 +0200
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

On some H6 boards like Orange Pi 3 LTS, some times U-Boot fails to detect
ram size correctly. Instead of 2GB thats available, it detects 4GB of ram
and then SPL just hangs there making board not to boot further.

On debugging, I found that the rows value were being determined correctly,
but columns were sometimes off by one value. I found that adding some
delay after the mctl_core_init call along with making use of dsb in the
start of the mctl_mem_matches solves the issue.

Signed-off-by: Gunjan Gupta <viraniac@gmail.com>
---

 arch/arm/mach-sunxi/dram_helpers.c   | 1 +
 arch/arm/mach-sunxi/dram_sun50i_h6.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi/dram_helpers.c
index cdf2750f1c..5758c58e07 100644
--- a/arch/arm/mach-sunxi/dram_helpers.c
+++ b/arch/arm/mach-sunxi/dram_helpers.c
@@ -32,6 +32,7 @@ void mctl_await_completion(u32 *reg, u32 mask, u32 val)
 #ifndef CONFIG_MACH_SUNIV
 bool mctl_mem_matches(u32 offset)
 {
+	dsb();
 	/* Try to write different values to RAM at two addresses */
 	writel(0, CFG_SYS_SDRAM_BASE);
 	writel(0xaa55aa55, (ulong)CFG_SYS_SDRAM_BASE + offset);
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
index bff2e42513..a031a845f5 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
@@ -623,6 +623,8 @@ static void mctl_auto_detect_dram_size(struct dram_para *para)
 	para->cols = 11;
 	mctl_core_init(para);
 
+	udelay(50);
+
 	for (para->cols = 8; para->cols < 11; para->cols++) {
 		/* 8 bits per byte and 16/32 bit width */
 		if (mctl_mem_matches(1 << (para->cols + 1 +
-- 
2.42.0

