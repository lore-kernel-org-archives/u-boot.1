Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B590C678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F06286C3E;
	Fri, 18 Aug 2023 02:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S7F0WY+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B032986C03; Fri, 18 Aug 2023 02:27:23 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F5486C01
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34a8bd1a7fbso1423605ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318439; x=1692923239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/XW+6HRwbJQa/jbXIP3F3Dmjrphj9qJlYuLRh+lDN4=;
 b=S7F0WY+wqoJ7eMS026jLvv8nXKCWlGf0mMMZDynduLUtQkwYdWj1QZljYuMDGSPfec
 3TiZSqX1kjuVIwOxxmVFjQmxu4M3uZUlqYBx8dqBkjruMYYYjvsv7x/8+s6sL7hypIYr
 vMdI43d+oGTpP992XbFUqlkGSP2G06W3kOvY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318439; x=1692923239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/XW+6HRwbJQa/jbXIP3F3Dmjrphj9qJlYuLRh+lDN4=;
 b=g4MsIcSTLDZj67haYXwTNaXUn5a3tf3Fcn68TuxF2+RiuXJIeKTma2xEFGQIirhwC9
 kbFmQ9IsoacQslsKgD2f/OtsVxX6dXOBTHGOjiIOK2Ys37umdsF62cYheC27oANQhTX7
 SGHNNoa/wcksGEZoORoMzFDKBTnm1xsWMzaqtsmyU2uHSjlZDWYh70dBnxYrtzA2+WvJ
 poMZbOTYyksYf1EiZVyf55FzC+CKkBi/io6ZwrVaFNQ395d43uYitDB5jxf4VadKjePC
 eZ4bNSzs95bt47vQXIHobnzNjZpJ2HoO4r2R42NGTqlK1qrqDUMe/qZiulzdXtXnkNaz
 fBqA==
X-Gm-Message-State: AOJu0YzHud5zns8eKFN0K+IIMomYr2ZQECDzkj5c6gMpDd0/9Hw8/RnW
 GOQQuELj8ae+OXaRe0NYs7TIAsMw4dWjWoht51k=
X-Google-Smtp-Source: AGHT+IEPxKpoFZQi/BL79PczFV3E64c3tnnn51QBT7hfG1JPGHpBPmoT22PD6seLVpZtEjTCshSBgg==
X-Received: by 2002:a05:6e02:963:b0:34a:c28f:9423 with SMTP id
 q3-20020a056e02096300b0034ac28f9423mr1127916ilt.8.1692318439598; 
 Thu, 17 Aug 2023 17:27:19 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Coreboot ML <coreboot@coreboot.org>
Subject: [PATCH v2 07/20] x86: coreboot: Enable CONFIG_SYS_NS16550_MEM32
Date: Thu, 17 Aug 2023 18:26:46 -0600
Message-ID: <20230818002706.853550-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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

The debug UART on modern machines uses a 32-bit wide transfer. Without
this, setting debug output causes a hang or no output. It is not obvious
(when enabling CONFIG_DEBUG_UART) that this is needed.

Enable 32-bit access to avoid this trap.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/coreboot64_defconfig | 1 +
 configs/coreboot_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index a094a7c24234..29b68d6929c7 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -52,6 +52,7 @@ CONFIG_ATAPI=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 # CONFIG_PCI_PNP is not set
+CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_CONSOLE_SCROLL_LINES=5
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 735cd6eb4c22..2961908f29cd 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -60,6 +60,7 @@ CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_NVME_PCI=y
 # CONFIG_PCI_PNP is not set
+CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_CONSOLE_SCROLL_LINES=5
-- 
2.42.0.rc1.204.g551eb34607-goog

