Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49033C47079
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19DBB87A0A;
	Thu,  4 Jan 2024 16:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ErOZmUeU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 808F7879AB; Thu,  4 Jan 2024 16:12:39 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A40879E4
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7bb0af58134so27970339f.3
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381129; x=1704985929; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjIsIQEuTVNW370g0hsTvPEuHNQ0mYcMS4YRQeDoxMs=;
 b=ErOZmUeUTfhhdfaorD4cfSeqILFOoyXVxKp8Lbo9JZte3N+DTB0SMP7MJ52D4sxAB4
 ZDHgQ3GFBMyuu361bZN32zNAocsn4Opbuu6ttQqn5W5cN1ivWsbrHb4niaf+IOP6EOO5
 KOW82MkwJg+FpdGDqpohA841BCI3hV5bRVxSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381129; x=1704985929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjIsIQEuTVNW370g0hsTvPEuHNQ0mYcMS4YRQeDoxMs=;
 b=rA5U4j146D2sFr9BGq+fdbq7Jq67OQb9d2Kez5hCD9xWC5mxXNvpIROid50YYtmgRy
 3HegalJzY2Q56P8yX00NgQIiiKGRSpIx2QQpNBIPrcp9Buu+mRIjGn+C/3bTXvuiyOQ7
 qYOLVzHlr4rXfV1IqYNLub3P6XOJXalwofiDjxS2d/IGE4JzkmygEz3uEB4WG3/paRDu
 CojmSvVDVsM/Q/4RV4ZkpVm/0d8J4NmoQ6K0Spoa2q9UgOG+gVukY4UWnoKLm7CwNDf4
 js6FXJkzUcX8O4tDJFWDUgkZK7K9AF4RCxqZ3mnx/UnkePXF/7lkhFNTk40kGOU6T0Dw
 AlLQ==
X-Gm-Message-State: AOJu0Ywdi67tF04C4rN+++YQjZX7ElzjTAi3zu7n5YUYC42F1glUakPP
 eggh+0NHXAaNqdVV5+MX6YZT7AZto7CjoRbnTsSHrqt87FFA
X-Google-Smtp-Source: AGHT+IFLUZdPKzM+rP3u3LZS40vEN1A/RBwpPs19cx+5NZPoQ6cs/qomBxxT+j0AIZLu3jzyG02KNw==
X-Received: by 2002:a05:6e02:2163:b0:35f:b0d1:985b with SMTP id
 s3-20020a056e02216300b0035fb0d1985bmr817797ilv.3.1704381129467; 
 Thu, 04 Jan 2024 07:12:09 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cv4-20020a056e023b8400b0035fb79100cesm9260742ilb.59.2024.01.04.07.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:12:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 12/19] x86: coreboot: Enable unit tests
Date: Thu,  4 Jan 2024 08:11:45 -0700
Message-Id: <20240104151152.697855-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151152.697855-1-sjg@chromium.org>
References: <20240104151152.697855-1-sjg@chromium.org>
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

Enable unit tests so we can run command-line tests in coreboot. Enable
console recording, with enough space for the 'cbsysinfo' command. Add
to the pre-relocation malloc() space to make room for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/coreboot_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 7d744e9962a..5433a5ae0c2 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -1,6 +1,7 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1110000
 CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x1000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="coreboot"
@@ -16,6 +17,8 @@ CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
 CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then cls; bootflow boot; fi"
+CONFIG_CONSOLE_RECORD=y
+CONFIG_CONSOLE_RECORD_OUT_SIZE=0x1000
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_LOG=y
@@ -60,3 +63,4 @@ CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
 CONFIG_SMBIOS_PARSER=y
+CONFIG_UNIT_TEST=y
-- 
2.34.1

