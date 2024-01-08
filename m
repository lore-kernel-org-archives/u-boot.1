Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7449C47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B3D87A21;
	Mon,  8 Jan 2024 01:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BEiTw84X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9638087935; Mon,  8 Jan 2024 01:15:07 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1A1D87A09
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7b7f9fdc14dso63504539f.0
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672900; x=1705277700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSLyrnbMteyrjfnKpkyAey0cMSeQrnVHXu5QKuIBruY=;
 b=BEiTw84XLV+KSYIaMJuUiukvQxZVaiimzKLKIlSKuLjYu/8qhCt9Qx++eoy5xTlbr1
 X308chmi97z+01/Whc/g7lcsK+7i4dRj4I1tqPR9MuHND6fR573c4yw3YlCah0Fqlk0p
 TaxWLKWYH4NuW26uwSZ4CViiXpd+W2XjqSAnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672900; x=1705277700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSLyrnbMteyrjfnKpkyAey0cMSeQrnVHXu5QKuIBruY=;
 b=Pl1+/FPy+lKv8TCUG7QFUtEwZgWGksZq+HuXNR1tOeLJASXge6IZAax4hfU1JlX+s2
 H/v3FP/cE9UBaSkKItqJxejE5FhCNWYGasPJ79hh7JnCVaKaCB62SjB0t0LFvNX9I+pk
 roOu9R33CAs2F5nzOW3SzVET4kywoIYWSk1Ipd+a2Ehq+TpSon9Wgslm1pR4DPv4iaVQ
 wq5AIcJ3bakEGUcEYjJKFtdPjzoo/9/WBb/LWt9lNgga4JyRcnSU8OxWlBaOOYaE3paX
 w0c60Rp1fVtbr/oM+6izF9NVr4z5/dMdvma9lbYUUQzCWCY4kmrdpwcswAmsvKW8Ns3y
 9gYQ==
X-Gm-Message-State: AOJu0YyQ8p9hRTlSpHQB6YvWI8+V5ip/+F/SF+6H5Ii0+MNQCBZOTS/3
 XHDeyZRChn26d/B4icTRypxMjVauW5DzNLLnXIt+kwn+Dg9E
X-Google-Smtp-Source: AGHT+IERg93jrYyDD0eYnMuKSW0aYooi9lBLYcfHrIMCQ5vRUM0uuyipChNhAeSQUk7oAtFBhzr3UQ==
X-Received: by 2002:a6b:6d09:0:b0:7bc:4b86:6f0 with SMTP id
 a9-20020a6b6d09000000b007bc4b8606f0mr384367iod.8.1704672900304; 
 Sun, 07 Jan 2024 16:15:00 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a023407000000b0046dc488fe32sm1873420jae.82.2024.01.07.16.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 16:15:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] coreboot: Switch to a monospaced font
Date: Sun,  7 Jan 2024 17:14:55 -0700
Message-Id: <20240108001455.35638-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108001455.35638-1-sjg@chromium.org>
References: <20240108001455.35638-1-sjg@chromium.org>
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

The default font is proportional, with different character widths.
Select a monospace font for coreboot so that the 'dm tree' output lines
up correctly.

Update the coreboot tests to match.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/coreboot64_defconfig |  3 +++
 configs/coreboot_defconfig   |  3 +++
 test/cmd/font.c              | 12 +++++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 49c982ef756..c4571090859 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -64,6 +64,9 @@ CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_VIDEO_COPY=y
 CONFIG_CONSOLE_TRUETYPE=y
+CONFIG_CONSOLE_TRUETYPE_SIZE=20
+# CONFIG_CONSOLE_TRUETYPE_NIMBUS is not set
+CONFIG_CONSOLE_TRUETYPE_ANKACODER=y
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_ACPI=y
 CONFIG_CMD_DHRYSTONE=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index d4e44e00dca..7aa841bb54b 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -61,6 +61,9 @@ CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_VIDEO_COPY=y
 CONFIG_CONSOLE_TRUETYPE=y
+CONFIG_CONSOLE_TRUETYPE_SIZE=20
+# CONFIG_CONSOLE_TRUETYPE_NIMBUS is not set
+CONFIG_CONSOLE_TRUETYPE_ANKACODER=y
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
diff --git a/test/cmd/font.c b/test/cmd/font.c
index 9c1eebf799e..ee1c610106d 100644
--- a/test/cmd/font.c
+++ b/test/cmd/font.c
@@ -29,14 +29,20 @@ static int font_test_base(struct unit_test_state *uts)
 
 	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_command("font list", 0));
-	ut_assert_nextline("nimbus_sans_l_regular");
+	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_NIMBUS))
+		ut_assert_nextline("nimbus_sans_l_regular");
+	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_ANKACODER))
+		ut_assert_nextline("ankacoder_c75_r");
 	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_CANTORAONE))
 		ut_assert_nextline("cantoraone_regular");
 	ut_assertok(ut_check_console_end(uts));
 
 	ut_assertok(vidconsole_get_font_size(dev, &name, &size));
-	ut_asserteq_str("nimbus_sans_l_regular", name);
-	ut_asserteq(18, size);
+	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_ANKACODER))
+		ut_asserteq_str("ankacoder_c75_r", name);
+	else
+		ut_asserteq_str("nimbus_sans_l_regular", name);
+	ut_asserteq(CONFIG_CONSOLE_TRUETYPE_SIZE, size);
 
 	if (!IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_CANTORAONE))
 		return 0;
-- 
2.34.1

