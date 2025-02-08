Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5163CC02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5158B80C83;
	Sat,  8 Feb 2025 18:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QdcOONyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05BBE80C8F; Sat,  8 Feb 2025 18:13:04 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEF5380EB5
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-855190e244bso7684539f.2
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034780; x=1739639580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0wg+67MpC4JoDXqSSmR9/zrHo41rNyUe24PF3Kxpf0=;
 b=QdcOONytwumw/kROexRiqgk91CI6wbue2sA8v9+W3+KY585sTSZu9umOMEQq5Ri+Iv
 Gjg385DC7s2wU+uR6arMyfGgqM333Mp6VpvBU2EDtf3AKkCWzI78t5PDgc5pyTydOEOx
 k4lnbXddI5AAsjg88UozSfVjxhuxe9SgugOTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034780; x=1739639580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q0wg+67MpC4JoDXqSSmR9/zrHo41rNyUe24PF3Kxpf0=;
 b=b+6ttF17bZPMVy5q5ydYlK6PU1bplW6x5c2jwi/GccmRIraZHgd/izP0LNERqLUR1q
 1J2rQwRQsbgzsUA5JSm4BrQa0o60pLvbO5QHAJbRVRLdo1s1LSgMWPx4DijQKWcZ/Ork
 zTqUmFXN7F6iTAt4SmkKt9C5Tx1fGgqgawB/AK9SKeS+QZtvCJuxx8o4JWLFzCrIg4PV
 ZvBN9GOGQzxXNPALvuCUveJanFspLAzSod3N4I67Nwfjmnzcm9wqWE1DERdYyhJ2Z3Os
 IW977UoKmCSQ5rPlJoH0sIdhUUwvzhIn0UBPBCjLKgtw2sUBpzBLeUVxUeMjLSk3lGzJ
 II2Q==
X-Gm-Message-State: AOJu0YyJZI6tCHhyD6ZNEvXkLmnLA+mr7eMbD6CW3FO+D42ook4jtsIX
 du7vLluqa3KFhHnmWDX4Je/eYyiKZ7ShHWDW7ZQtPZ0G7uYkbL4JtITR9+35WqbrFhRN5au/uyQ
 =
X-Gm-Gg: ASbGncu1du2a+s8BVIOlyIpUB2VjNsJ5Xhh2fAU5GkjLRtBmId/a8gbvZggKYuWwfXn
 H6t4nwOq1T2F7gOg1ccKwEx+kWdpnFDP/wh0KHV0k/wfq2AZkTkJjCJ6E7FphTkXZP1JIIAe+a+
 xQ8HprONI/2ygmSLynRSVP6xpubMR636gdvGVOj1SIeJxExSVrx3zK93nT1KgnDCjgp8WbmXp/r
 Bu9NDuj5tx8vWbN4+Y/K0s69Ub3oB0tvrv1vnyvQoS/1d1rIRpJKAeVwz2TQIjkV6yBaKA7xiOv
 OYGCgQn9WrcY1UCH1eJ/UOzoPKxu4nZpLsPMwmWzi4PH1gXYgTB7
X-Google-Smtp-Source: AGHT+IGAVC08fbJY88/TjACHdLMr+GKNc0xPmgyiPc3MRVvyPhB51CY6ESzcyOxkVyoovVvqoZDVzA==
X-Received: by 2002:a05:6602:4887:b0:847:51e2:eb0 with SMTP id
 ca18e2360f4ac-854fd90c631mr744001739f.12.1739034779979; 
 Sat, 08 Feb 2025 09:12:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 23/29] efi: arm: Adjust how the monitor length is calculated
Date: Sat,  8 Feb 2025 10:11:43 -0700
Message-ID: <20250208171154.1305761-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

Adjust the conditions to support the EFI app when running on ARM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Put the EFI-app case first in setup_mon_len(), for clarity

 common/board_f.c | 6 +++---
 common/board_r.c | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 8baaa2341a3..5b9203fec18 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -261,7 +261,9 @@ static int init_func_i2c(void)
 
 static int setup_mon_len(void)
 {
-#if defined(CONFIG_ARCH_NEXELL)
+#if defined(CONFIG_EFI_APP)
+	gd->mon_len = (ulong)_end - (ulong)image_base;
+#elif defined(CONFIG_ARCH_NEXELL)
 	gd->mon_len = (ulong)__bss_end - (ulong)__image_copy_start;
 #elif defined(__ARM__) || defined(__MICROBLAZE__)
 	gd->mon_len = (ulong)__bss_end - (ulong)_start;
@@ -270,8 +272,6 @@ static int setup_mon_len(void)
 #elif defined(CONFIG_SANDBOX)
 	/* gcc does not provide _init in crti.o on RISC-V */
 	gd->mon_len = 0;
-#elif defined(CONFIG_EFI_APP)
-	gd->mon_len = (ulong)_end - (ulong)_init;
 #elif defined(CONFIG_NIOS2) || defined(CONFIG_XTENSA)
 	gd->mon_len = CONFIG_SYS_MONITOR_LEN;
 #elif defined(CONFIG_SH) || defined(CONFIG_RISCV)
diff --git a/common/board_r.c b/common/board_r.c
index c4545e9b483..3fa2d44402e 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -124,7 +124,9 @@ __weak int fixup_cpu(void)
 
 static int initr_reloc_global_data(void)
 {
-#ifdef __ARM__
+#if defined(CONFIG_EFI_APP)
+	monitor_flash_len = (ulong)_end - (ulong)image_base;
+#elif defined __ARM__
 	monitor_flash_len = _end - __image_copy_start;
 #elif defined(CONFIG_RISCV)
 	monitor_flash_len = (ulong)_end - (ulong)_start;
-- 
2.43.0

