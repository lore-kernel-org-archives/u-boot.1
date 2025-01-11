Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94E8E77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB6B98036B;
	Sat, 11 Jan 2025 01:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iyyYxXq0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 117F480613; Sat, 11 Jan 2025 01:00:50 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9CD8801B0
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-84a012f7232so116050839f.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553645; x=1737158445; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iH3A5NECLEyz9NwDo0koPxKhQ3A3FVMsX+JB5AMpfjA=;
 b=iyyYxXq0/sjUZBULuy9rjXlDjuX+sCRm6v7UXGnbX/hG1nkPTg2V0C3Swjr4Ov40Mx
 Qko6xNebTi5YvZWZBQ+nwvrrWocXOgvgoFCyY6wlfwF5t44KYEdoitNCBRwpul6vBPUm
 EglK4PWrEEUtg9EcL5D6JIGCUI4OnOhmBQH/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553645; x=1737158445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iH3A5NECLEyz9NwDo0koPxKhQ3A3FVMsX+JB5AMpfjA=;
 b=hSAWH65YkSGXUpGzSDGBMuLh2lhEbK2L/dzEbcY/VrezLietHMVWoC0QBGM4W45tgk
 HrNPJWn0GD4BFW4V3hKYdA4wh76cI8kQzElDKuMwea22LlC7YOpYrDW1XfBKyDPCuw+P
 FhCEY5JexrjcIzR3XeSeqgg86oS6ru58ua91nA+o6vz3aH2MDHLOp2dH2mnXzqYMeYMy
 dgEbO4wBf8hHToY8z53hZIFk3530qhHj7O54KQ2T+vvkeJRbSc4o2EJuwANQUCpmk1oA
 UNl6MdR8rWb3wPVQh4xUdKiNWZrxx+sWepPuUwjYEQIO1rGG0PU6cy2CN7l7XTCClUze
 4nhw==
X-Gm-Message-State: AOJu0Yy3fW25zZKmU1lx8B5bnJt4HQkp47BPsUrJdcKh29nWe099ZnLj
 VQ+VLvCTkBBHTca5NLt88Loom4jpTlC1rYzDim7vQBxpwmlgY5UBLd/4KXUZOnAuic+jOJcTadc
 =
X-Gm-Gg: ASbGnctMZBX30CoYL07Cc8SEa6b1UrSbQP7wZeGR365zG1Y9/8NgjO7Tsw1bli1yYJh
 gzUyJDSknY008D2eEn/0hEFhz1a1Pr2uAUPkvm/bmZ75cEWmq2o12j2lH1HPnJg3eX0WLuFKlxF
 KNX49fbUxr8YrFYOdEQIuVXSGsJb4Tp1Yo05/h/PIPOXt/n1M8oYWCl19UuWSzxVIZMC/xwirhq
 hKMkQWnvoSgHXIVTf//xDGd/CvGXfkw5mzqX1Cv0Rql1pCGDBOqgT0YIoFkDWHiyHzQeeAEYzAq
 y5vUCmHkIfhQzn9PVQ==
X-Google-Smtp-Source: AGHT+IEHo123FdTJABTk94WvWogXkya1X3vAtyvZeZPX7nRKOKppi51orogwGcRZTJq/Efzn/jTemw==
X-Received: by 2002:a05:6e02:17c6:b0:3ce:34fb:fdac with SMTP id
 e9e14a558f8ab-3ce47575fa7mr58762055ab.5.1736553645473; 
 Fri, 10 Jan 2025 16:00:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:00:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alex Shumsky <alexthreed@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Dragan Simic <dsimic@manjaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Watt <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 01/30] bloblist: Make BLOBLIST_ALLOC the default
Date: Fri, 10 Jan 2025 17:00:00 -0700
Message-Id: <20250111000029.245022-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

We want to encourage people to use an allocated bloblist since it is
more flexible than a fixed one. Make this the default, being sure not to
change existing users.

The unit tests require BLOBLIST_FIXED so add a dependency in the
Makefile to avoid build errors.

All sandbox builds require BLOBLIST_FIXED so make that the default for
sandbox.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Use 'default' instead of reordering items
- Update the commit message

 common/Kconfig                         | 2 ++
 configs/chromebook_bob_defconfig       | 1 +
 configs/chromebook_coral_defconfig     | 1 +
 configs/chromebook_kevin_defconfig     | 1 +
 configs/chromebook_samus_tpl_defconfig | 1 +
 configs/qemu-x86_64_defconfig          | 1 +
 test/common/Makefile                   | 4 ++++
 7 files changed, 11 insertions(+)

diff --git a/common/Kconfig b/common/Kconfig
index 0e8c44f3f74..7685914fa6f 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1047,6 +1047,8 @@ if BLOBLIST
 
 choice
 	prompt "Bloblist location"
+	default BLOBLIST_FIXED if SANDBOX
+	default BLOBLIST_ALLOC
 	help
 	  Select the location of the bloblist, via various means.
 
diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index decac2e1935..072311465d9 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -36,6 +36,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-bob.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_SPL_MAX_SIZE=0x1e000
diff --git a/configs/chromebook_coral_defconfig b/configs/chromebook_coral_defconfig
index 0fb73049738..b1999b4ef20 100644
--- a/configs/chromebook_coral_defconfig
+++ b/configs/chromebook_coral_defconfig
@@ -44,6 +44,7 @@ CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BLOBLIST=y
 # CONFIG_TPL_BLOBLIST is not set
+CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x30000
 CONFIG_SPL_NO_BSS_LIMIT=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 5bbea6c42a8..13c0998dbab 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -37,6 +37,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-kevin.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_SPL_MAX_SIZE=0x1e000
diff --git a/configs/chromebook_samus_tpl_defconfig b/configs/chromebook_samus_tpl_defconfig
index fc524da5480..42337d7a11e 100644
--- a/configs/chromebook_samus_tpl_defconfig
+++ b/configs/chromebook_samus_tpl_defconfig
@@ -34,6 +34,7 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0xff7c0000
 CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_SPL_NO_BSS_LIMIT=y
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 812b20687e5..f93721fceb8 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -34,6 +34,7 @@ CONFIG_SPL_LOG=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x10000
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
diff --git a/test/common/Makefile b/test/common/Makefile
index 53c4f16164d..95bd00741a3 100644
--- a/test/common/Makefile
+++ b/test/common/Makefile
@@ -1,9 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0+
 obj-y += cmd_ut_common.o
 obj-$(CONFIG_AUTOBOOT) += test_autoboot.o
+
 ifneq ($(CONFIG_$(XPL_)BLOBLIST),)
+ifdef CONFIG_BLOBLIST_FIXED
 obj-$(CONFIG_$(XPL_)CMDLINE) += bloblist.o
 endif
+endif
+
 obj-$(CONFIG_CYCLIC) += cyclic.o
 obj-$(CONFIG_EVENT_DYNAMIC) += event.o
 obj-y += cread.o
-- 
2.34.1

