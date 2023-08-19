Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F2BEE49A6
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51CFF86EE9;
	Sat, 19 Aug 2023 23:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="faeancy3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B800B8700A; Sat, 19 Aug 2023 23:23:27 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0600386C1C
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-790c6d966e0so77184639f.0
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480203; x=1693085003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/XW+6HRwbJQa/jbXIP3F3Dmjrphj9qJlYuLRh+lDN4=;
 b=faeancy3VgJ0U0nlde/7VnGdaAVG0AzFTO/x/01eoihx2aoure9CuSocyI+SafK/Ag
 FYgcJvSy6fjhF9wRQ0eOPFUC9Bu5tNl4LSZKyBfs+UMkBXM3VFkapqf1FaYrxwgSK1IP
 FWBasodgcRC3SBj7QhOOuxD4T5pqysD14ELv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480203; x=1693085003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/XW+6HRwbJQa/jbXIP3F3Dmjrphj9qJlYuLRh+lDN4=;
 b=V7gcgWCx01Hm2RQ2mkicUtRizMvgCOwCZwtqO4g3R/C22jr84yIofT8DPh62creTvP
 vuudzNklR5T+Y5+u22gKUGqbWFkERuSvz/uIpm7rRaRSXOTCd9OfB9itgFCWzedgaDpR
 fUqmrv7ZjtTQDTxEQzEL+HP7MLaNnwIha0eV2/OhWMVD7fhLxpnV5EjeYDx0xdk8b7aS
 f5n+FBP5fr8RbsFeMe0kV83OUKrXJcQodwo0VmlmL6tcFG8VW75JbIG0vZlP4YzpUULA
 ZNKAOxs8HJrkqDNVkiZdoVgIAriOxwIJQJf0o0B0K5f6fihQQw9vicumKick4RIdXFW9
 9Tfw==
X-Gm-Message-State: AOJu0YwV/VrKC1vHRAfN4Lg3w8Y0bWxv3CJM+oRliLjDVjHxZDMXiI9s
 N8ufZBuvvCMsYI29ULYDyshHICcajlg7yE+9t0U=
X-Google-Smtp-Source: AGHT+IFcRKMcdyaBAMTUprjDXb6vKqPzw1aXyyUTtuhYszf/7KEkP960tlgxnPxIxaAjTAaXwyEGkQ==
X-Received: by 2002:a5d:8415:0:b0:785:cb8d:f1c5 with SMTP id
 i21-20020a5d8415000000b00785cb8df1c5mr4010508ion.12.1692480203605; 
 Sat, 19 Aug 2023 14:23:23 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 07/19] x86: coreboot: Enable CONFIG_SYS_NS16550_MEM32
Date: Sat, 19 Aug 2023 15:22:45 -0600
Message-ID: <20230819212309.1094440-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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

