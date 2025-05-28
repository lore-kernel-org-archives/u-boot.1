Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C6CC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CCB283A22;
	Wed, 28 May 2025 10:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oWxP8AUh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D48FE83A1F; Wed, 28 May 2025 10:26:51 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0654683A26
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d817bc6eb0so22015785ab.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420805; x=1749025605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYcAAYcVH3TI5QjbQGVFeF0odLs4Oh3qP0NeUOiwT4o=;
 b=oWxP8AUhQZyN6DHVP4JBbW5ZlFKLE7hGJGIUbg4Lu2Lplwu5D2PHlK6l2bm/CAbcH0
 R+imXN0UGawezUMU9UaYGzobNUtSakgJcT25KgzrB9u/gzbN5o04ekKwA4lgl1NViKEu
 3GXLatO6fU+gGkuYMUeyJ9DbeKY25duTY1Zqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420805; x=1749025605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYcAAYcVH3TI5QjbQGVFeF0odLs4Oh3qP0NeUOiwT4o=;
 b=ovY5gKz9PXWI0FVeML8VIvQrrhyYEUz2nWQ9e011n0Es5c2s/quaoZ2v2Us8HokxAU
 OMcYBh1XCui6XJ99PedsfKs+BBgHubMNrDrs+ULYWqzX97YMDX+aziEveJ0p1sWpwFsc
 CISSetAxDShkvkxqTT2E4ecctuMgX7eD40mqwzqfLbfXkn6tIqgXWq4FVPtPN4HyHePW
 z1I31zxzunKmkRTzJeZAq9hCas2Del36K1Ay6ssRNOTDHiF8d4WUDx4bIVisROrLk4DD
 0t4iRQ2WydZJH2o5+UbMLcU4ClZGq/Gy7RNqsmsu1SI/HumHLjJ7zyy45iNvYPNT3T+W
 Eilg==
X-Gm-Message-State: AOJu0Yw5Cq5c8YnmzOScmxNxCpQ2X3+2BANdIaz/OuHY71twgPJZAtP3
 TktiU3yfLovYzSWdab7LsaLT+w2I33eA8I9TzCqOLBVrUa9D6N6rm8TGfjg8Ind+46qOB7a1t+c
 nM/ARpXED
X-Gm-Gg: ASbGnctP9iA3DP/jUucIhjwfC6JMX9VnG7ZVbpOWcZA8sQirU3r4eorldvp2ed0eiIM
 B/rViQROIssSGIcc0dujAacv2PjuGl5yVKYaZ9EALUKtW3iKfgErTSNhxxxitkh/FAZzl83hy4p
 gYOUre8GsHtv22TPKP2UaI8l3wdmzX8KnvbPP9gKGiF26sRyNeww+mltYAOqZGNhUOYXCfKIBnx
 OqEcieuSVW5zk9cWCF9AzYoDAMVk8Dfqlqitjnj63oY2f72j4z/2AkJ/r6CB51o6hjxZVg7WWmE
 S8tei4jElWPyvh6nzF/dH5C9zA44b1J93CBjhEk1lJnIKwelTxJj/NHyiAX0ssHo8AyJbiEFO7Z
 bGXtA+hsRPX27Ac+iSpGVois=
X-Google-Smtp-Source: AGHT+IF2H6Bc0h1Ykxa5OKC4D0IxqrZ+pWhlX6n2vWZS2D7XxEaY8mtHTvWpl26dJ5qeMafGdmQPAQ==
X-Received: by 2002:a05:6e02:4505:b0:3dd:792d:ce42 with SMTP id
 e9e14a558f8ab-3dd792dd094mr67490935ab.0.1748420805231; 
 Wed, 28 May 2025 01:26:45 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 27/27] x86: efi: Add various useful options
Date: Wed, 28 May 2025 02:24:53 -0600
Message-ID: <20250528082520.152391-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

Enable logging, TPM and the lsblk and cat commands. These are all useful
for using and debugging the EFI app.

For the 32-bit app, enable CONFIG_BOARD_EARLY_INIT_R so that the EFI
devices are scanned.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/efi-x86_app32_defconfig | 9 +++++++++
 configs/efi-x86_app64_defconfig | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index 2848dac905b..de97cb64ce7 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -17,7 +17,11 @@ CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
 CONFIG_BOOTCOMMAND="bootflow scan -lbp"
 CONFIG_SYS_PBSIZE=532
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_LOG=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_BOARD_EARLY_INIT_R=y
+CONFIG_CMD_LSBLK=y
+CONFIG_CMD_CAT=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
@@ -29,4 +33,9 @@ CONFIG_NO_NET=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 # CONFIG_SCSI is not set
+# CONFIG_TPM_V1 is not set
+CONFIG_TPM2_EFI=y
+CONFIG_CONSOLE_SCROLL_LINES=5
+CONFIG_CMD_DHRYSTONE=y
+CONFIG_TPM=y
 # CONFIG_GZIP is not set
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index f0dac46a552..55daf7bec2a 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -19,8 +19,11 @@ CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
 CONFIG_BOOTCOMMAND="bootflow scan -lbp"
 CONFIG_SYS_PBSIZE=532
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_LOG=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
+CONFIG_CMD_LSBLK=y
+CONFIG_CMD_CAT=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
@@ -32,6 +35,9 @@ CONFIG_NO_NET=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 # CONFIG_SCSI is not set
+# CONFIG_TPM_V1 is not set
+CONFIG_TPM2_EFI=y
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_CMD_DHRYSTONE=y
+CONFIG_TPM=y
 # CONFIG_GZIP is not set
-- 
2.43.0

