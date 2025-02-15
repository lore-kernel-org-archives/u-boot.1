Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC5AC02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1474480FA6;
	Sat, 15 Feb 2025 04:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fs8Ul02z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53C5380F60; Sat, 15 Feb 2025 04:24:17 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B6580FD0
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3d2223fe5a4so1927685ab.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589852; x=1740194652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXP+rIvekQBhoekDBVPE6symLx1klcQ/wpK4/YJdjW4=;
 b=fs8Ul02zTDmlWh/RtWB0fIsTh1B+SRcHReMRDhjHBNCe3APBCj5Fxvpo4BtpaMxeEq
 uEgKP+PGPsZVHeBEPcYq5qzJbiKXYtcPlJ9NyyRklOqDPxBlVWp0vCnTWSnNlcplvtYe
 j3Eu/MTn8GURw+Ds2ZlmPEfRyf+fNPCtUzsP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589852; x=1740194652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AXP+rIvekQBhoekDBVPE6symLx1klcQ/wpK4/YJdjW4=;
 b=kzfj66wHEJadbz7ry9PRpslqQY3P4tTD9y2zI4E4uFA0K4YTX1Ssmy0BIEp+bgJ3pH
 6LfbopnRGYTbnHPcfsJFbQDg62MuiAyz5+5a16TsRw5YXo86tA+ny4nOVYQ3irSuBUvP
 ADYvJ8ha3FXhxVv7IhY2Wtc+9Bi/EzBQdk+BYfkSbPL/3yVqx0bEHO4mTYVHHbtiTgPg
 UeC2cqAitzdQzg5GBvvUI1uH2YAgI7+kbJ4vDrjcak53HXY8OE738EKP0sa4UX4/D04o
 o862Z4YP2HlUm3tl51yqr+FOvX/mJh2fJ6A/dnoPTF0rcspKUa+HpwaXo6SEX98hJoGy
 GoYA==
X-Gm-Message-State: AOJu0YxpCeNR1QIig1WR8TNxKXIrk04V1RtPi9F4HbMo8QrQxy5wlYwI
 Jw10O/ip6z6cDI/VatwfRF3ec04y1PZKBSk41P4LpaS3gkzP+cmHkzxx1hg5EsBlFvhUsxWeKDU
 =
X-Gm-Gg: ASbGncv0yOE5bABhbqGVakEj6PlTxMWSkRoq08CsnaKzSg3EXZjT+i/1n+7ggK55TBK
 mN8TNB/eIlmw/6EOnifSelSBXjf+eB+B0z1XpB/wv/y06mo9PpK9AxEdLiqc3vpKaPnoc3ozV15
 KVWCng832+iEBva0Ipf9n1CmwPB9vWKnh/zu8kmczxBJHnf5/hnVmVNMyBSRLUs8ojiSXuNInIC
 YZW6H49funlq72rbwdNA3r8l+v5lBWaZq67wBTOaz3CFeeitRkqPnVe/vRzL7UU5ZIlfuD+sGID
 UZVNrYOA2LGew3Xf0SUXQFhVa6X95tZPRTeDwUfSmzBzNvNo6HTz
X-Google-Smtp-Source: AGHT+IFp8y7MBmuWOWMrZpUcsXXKwCTTWolE57Ld+bKa8yw8SzW5KSbSWm8LgpM+d4aza/WBDjyCaQ==
X-Received: by 2002:a05:6e02:470e:b0:3d1:5f26:121 with SMTP id
 e9e14a558f8ab-3d18cd1682amr70270705ab.9.1739589852112; 
 Fri, 14 Feb 2025 19:24:12 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:24:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Michal Simek <michal.simek@amd.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v4 23/29] efi: arm: Adjust how the monitor length is calculated
Date: Fri, 14 Feb 2025 20:22:44 -0700
Message-ID: <20250215032254.4121030-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

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
index e7d9a3b312d..41c0ba22c88 100644
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

